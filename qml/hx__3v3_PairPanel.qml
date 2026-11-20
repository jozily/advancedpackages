// SPDX-License-Identifier: GPL-3.0-or-later
// 血战特色双将：双将牌面板（备选池展示 + 成组弃置，同一份牌面）
//   dialog = false：铺满宿主，用于备选武将展示（单方用 cardNames，比赛规则用 value）
//   dialog = true ：自带外框与按钮的弹窗，用于成组弃置备选武将
pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import Fk
import Fk.Components.Common
import LunarLtk
import LunarLtk.Components
import LunarLtk.Pages.Popups

Item {
  id: root

  // 用法开关：true 为弃置弹窗，false 为备选池展示
  property bool dialog: false

  // 展示用法（dialog = false）
  property string name
  property var cardNames: []
  property var value            // { 冷方池, 暖方池 } 时为双方栏

  // 弃置用法（dialog = true）
  property var generals: []     // 待弃置武将，同组的两张相邻
  // 纯字符串通道：服务端用 | 把 generals 拼成一串再发。深层 Lua table
  // 经 CustomDialog prop 的 CBOR 桥接后可能退化成空表，导致牌面全空；
  // 标量字符串最可靠，QML 侧优先切它，generals(table) 只作兜底。
  property string generalsFlat: ""
  property int num: 4           // 需要弃置的张数
  property string prompt: ""

  property bool armorOn: false  // 补偿方式是否为护甲（兼容旧字段）
  property string comp: "off"   // 奇数体力值补偿：off / armor / yinyang
  property var fallback: []     // 取消时交回的结果；空则沿用「交空数组」的老行为

  property var selected: []     // 已选武将名（弃置用法）

  signal finished()
  signal finish()               // 兼容 PopupItem 的 finish 回调

  readonly property real cardScale: 1.5
  readonly property real cardW: 93 * cardScale
  readonly property real cardH: 130 * cardScale
  readonly property real gap: 18
  readonly property bool feasible: selected.length === num

  //--------------------------------------------------------------------
  // 列表归一
  //
  // lua 的表传到 qml 是 QVariantList：能当下标数组用，但 Array.isArray
  // 对它返回 false（freekill-core/Fk/Base/Config.qml:100 有同样的注释）。
  // 直接写 Array.isArray 判数组会让 generals / value 全被当成空表，
  // 弃置弹窗只剩外框和按钮、备选池一片空白。这里统一先做一次归一。
  //--------------------------------------------------------------------
  function seq(v) {
    if (v === undefined || v === null) return [];
    // 有的桥接把 Lua 表序列化成 JSON 字符串传过来，先试解析，
    // 否则弃置弹窗的 generals 会被当成空、只剩进度条和按钮。
    if (typeof v === "string") {
      if (v === "") return [];
      try {
        const j = JSON.parse(v);
        if (Array.isArray(j)) return j;
      } catch (e) {}
      return [];
    }
    const ret = [];
    if (Array.isArray(v)) {
      for (let i = 0; i < v.length; ++i) ret.push(v[i]);
      return ret;
    }
    if (typeof v !== "object") return ret;
    // 有的桥接形态给的是 count/get 访问器而不是下标
    if (typeof v.count === "number" && typeof v.get === "function") {
      for (let i = 0; i < v.count; ++i) ret.push(v.get(i));
      return ret;
    }
    const n = (typeof v.length === "number") ? v.length : 0;
    for (let i = 0; i < n; ++i) ret.push(v[i]);
    if (ret.length > 0) return ret;
    // 没有 length 的稀疏对象：按数字键顺序取
    const keys = Object.keys(v).filter(k => /^\d+$/.test(k)).sort((a, b) => Number(a) - Number(b));
    for (const k of keys) ret.push(v[k]);
    return ret;
  }

  // 相邻两张一组
  function pairsOf(v) {
    const arr = seq(v);
    const ret = [];
    for (let i = 0; i < arr.length; i += 2) ret.push(arr.slice(i, i + 2));
    return ret;
  }

  // 待弃置的原始名单：优先用字符串通道，table 只作兜底。
  // 两条都取后比长度，谁长用谁，避免某一路只到一半。
  readonly property var rawGenerals: {
    const fromFlat = (root.generalsFlat && root.generalsFlat !== "")
      ? root.generalsFlat.split("|").filter(function(x) { return x !== ""; })
      : [];
    const fromTable = root.seq(generals);
    return fromFlat.length >= fromTable.length ? fromFlat : fromTable;
  }

  readonly property var dialogPairs: root.pairsOf(root.rawGenerals)

  // 从武将数组里挑出名单标记（HXBAN:/HXPAIR:），其余原样交给牌面。
  // 这是与武将显示同源的通道：武将能显示，名单标记就一定能到。
  function cleanPool(arr) {
    const out = [];
    const a = root.seq(arr);
    for (let i = 0; i < a.length; ++i) {
      const x = a[i];
      if (typeof x === "string" && (x.indexOf("HXBAN:") === 0 || x.indexOf("HXPAIR:") === 0)) continue;
      out.push(x);
    }
    return out;
  }
  readonly property var displayCardNames: root.cleanPool(root.cardNames)

  // 把数组里的标记解析回 banInfo / pairInfo（pollBanners 调用）
  function harvestFromPool() {
    // 非比赛：标记随 cardNames 下发；比赛：标记在 value 的冷/暖池里，
    // 此时 cardNames 为空。两条通道都扫，谁带标记就用谁。
    let a = root.seq(root.cardNames);
    const v = root.seq(root.value);
    if (v.length === 2) {
      a = a.concat(root.seq(v[0]), root.seq(v[1]));
    }
    for (let i = 0; i < a.length; ++i) {
      const x = a[i];
      if (typeof x !== "string") continue;
      if (!root.banInfo && x.indexOf("HXBAN:") === 0) {
        const body = x.slice(6);
        const names = [];
        const segs = body.split(",");
        let grouped = false;
        for (let k = 0; k < segs.length; ++k) {
          if (segs[k].indexOf(" x ") >= 0) {
            grouped = true;
            const two = segs[k].split(" x ");
            for (let m = 0; m < two.length; ++m) if (two[m]) names.push(two[m]);
          } else if (segs[k]) {
            names.push(segs[k]);
          }
        }
        if (names.length > 0) root.banInfo = { names: names, grouped: grouped };
      }
      if (!root.pairInfo && x.indexOf("HXPAIR:") === 0) {
        const body = x.slice(7);
        const pairs = [];
        const segs = body.split(",");
        for (let k = 0; k < segs.length; ++k) {
          const one = segs[k].replace(/^\d+hao /, "");
          const two = one.split(" x ");
          if (two.length >= 2) pairs.push([two[0], two[1]]);
        }
        if (pairs.length > 0) root.pairInfo = { pairs: pairs, dual: false };
      }
    }
  }

  // 双方栏：value 为 { 冷方池, 暖方池 }，内外两层都是 QVariantList
  readonly property var duelPools: {
    const v = root.seq(value);
    if (v.length !== 2) return [];
    const cool = root.cleanPool(root.seq(v[0]));
    const warm = root.cleanPool(root.seq(v[1]));
    if (cool.length === 0 && warm.length === 0) return [];
    return [cool, warm];
  }
  readonly property bool duel: root.duelPools.length === 2

  // 服务端在渲染备选池时通过 prop 注入的禁用名单 { names, grouped }
  // 必须用属性声明接住：pragma ComponentBehavior: Bound 下，未声明的注入属性取不到。
  // 同时用 Lua.client.getBanner 主动读兜底（官方 RoomModel.qml:148 就这么用），
  // 因为 prop 注入那一刻 banner 可能还没同步到客户端。两路谁先读到用谁。
  property var banInfo: null

  // 服务端注入的本局禁配信息 { pairs = {{g1,g2},...}, dual }
  property var pairInfo: null

  // 与 banInfo/pairInfo 同批注入的纯字符串通道。
  // 嵌套 table 经 CBOR 桥接到 QML 会丢字段，但字符串稳定；
  // 备选池 cardNames 就是字符串/数组通道，显示一直正常。
  property string banFlat: ""
  property string pairFlat: ""

  // ---- 主动读 banner 兜底 ----
  // 名单是 Lua 表经桥接来的 QVariantList，必须统一走 seq() 归一，
  // 绝不能用 Array.isArray（对 QVariantList 返回 false）。
  function pollBanners() {
    root.harvestFromPool();
    if (!root.banInfo) {
      // 最高优先：prop 注入的纯字符串（与 cardNames 同一条已证明可靠的通道）
      if (typeof banFlat === "string" && banFlat.length > 2) {
        var pf = banFlat.split("|");
        var pGrouped = pf[0] === "1";
        var pNames = pf.slice(1).filter(function(x) { return x !== ""; });
        if (pNames.length > 0) root.banInfo = { names: pNames, grouped: pGrouped };
      }
      // 其后：getBanner 字符串通道
      if (!root.banInfo) {
        var flat = null;
        try { flat = Lua.client.getBanner("hx__3v3_global_ban_flat"); } catch (e) {}
        if (typeof flat === "string" && flat.length > 2) {
          var parts = flat.split("|");
          var grouped = parts[0] === "1";
          var names = parts.slice(1).filter(function(x) { return x !== ""; });
          if (names.length > 0) root.banInfo = { names: names, grouped: grouped };
        }
      }
      if (!root.banInfo) {
        var bi = null;
        try { bi = Lua.client.getBanner("hx__3v3_global_ban_info"); } catch (e) {}
        if (bi && typeof bi === "object" && root.seq(bi.names).length > 0) {
          root.banInfo = { names: bi.names, grouped: bi.grouped === true };
        }
      }
    }
    if (!root.pairInfo) {
      // 最高优先：prop 注入的纯字符串
      if (typeof pairFlat === "string" && pairFlat.length > 2) {
        var ppf = pairFlat.split("|");
        var pDual = ppf[0] === "1";
        var pPairs = [];
        var pGroups = (ppf[1] || "").split(";");
        for (var pi2 = 0; pi2 < pGroups.length; ++pi2) {
          var pTwo = pGroups[pi2].split(",");
          if (pTwo.length >= 2) pPairs.push([pTwo[0], pTwo[1]]);
        }
        if (pPairs.length > 0) root.pairInfo = { pairs: pPairs, dual: pDual };
      }
      if (!root.pairInfo) {
        var pflat = null;
        try { pflat = Lua.client.getBanner("hx__3v3_global_pair_flat"); } catch (e) {}
        if (typeof pflat === "string" && pflat.length > 2) {
          var pp = pflat.split("|");
          var dual = pp[0] === "1";
          var pairs = [];
          var groups = (pp[1] || "").split(";");
          for (var i = 0; i < groups.length; ++i) {
            var two = groups[i].split(",");
            if (two.length >= 2) pairs.push([two[0], two[1]]);
          }
          if (pairs.length > 0) root.pairInfo = { pairs: pairs, dual: dual };
        }
      }
      if (!root.pairInfo) {
        var pi = null;
        try { pi = Lua.client.getBanner("hx__3v3_global_pair_info"); } catch (e) {}
        if (pi && typeof pi === "object" && root.seq(pi.pairs).length > 0) {
          root.pairInfo = { pairs: pi.pairs, dual: pi.dual === true };
        }
      }
    }
  }

  // 面板创建后头几秒每 400ms 读一次（备选池 mark 往往早于 banner 到达）；
  // 读到名单即停，读不到最多轮询 20 次（8 秒）。
  Timer {
    id: bannerPoller
    interval: 400
    repeat: true
    running: !root.dialog
    property int ticks: 0
    onTriggered: {
      root.pollBanners();
      ticks++;
      if (ticks >= 20 || (root.banNames.length > 0 && root.pairRows.length > 0)) stop();
    }
  }
  // ---- 本局已禁用：入口 + 展开面板 ----
  property bool banOpen: false

  readonly property var banNames: root.seq(root.banInfo && root.banInfo.names)
  readonly property bool banGrouped: !!(root.banInfo && root.banInfo.grouped)
  // 双将按组：相邻两张一组；单将：逐个。结果是一维的「显示行」
  readonly property var banRows: {
    const n = root.banNames;
    const rows = [];
    if (root.banGrouped) {
      for (let i = 0; i < n.length; i += 2) {
        rows.push(n.slice(i, i + 2).join(" × "));
      }
    } else {
      for (let i = 0; i < n.length; ++i) rows.push(n[i]);
    }
    return rows;
  }

  // ---- 本局已禁配：入口 + 展开面板 ----
  property bool pairOpen: false
  // pairs 是二维 QVariantList，两层都要归一
  readonly property var pairRows: {
    const raw = root.pairInfo && root.pairInfo.pairs;
    let ps = root.seq(raw);
    // 嵌套 2 维表经桥接可能整块变成一个 JSON 字符串，先尝试拆开
    if (ps.length === 1 && typeof ps[0] === "string") {
      try {
        const parsed = JSON.parse(ps[0]);
        if (Array.isArray(parsed)) ps = parsed;
      } catch (e) {}
    }
    const rows = [];
    for (let i = 0; i < ps.length; ++i) {
      let g = root.seq(ps[i]);
      // 每一项也可能被压成 "A,B" 或 "A x B"
      if (g.length < 2 && typeof ps[i] === "string") {
        g = ps[i].split(" x ");
        if (g.length < 2) g = ps[i].split(",");
      }
      if (g.length >= 2) rows.push((i + 1) + "号  " + g[0] + " × " + g[1]);
      else rows.push((i + 1) + "号  " + String(ps[i]));
    }
    // 极端桥接:整块 pairs 退化成一个字符串也至少出一行
    if (rows.length === 0 && typeof raw === "string" && raw.length > 0) {
      rows.push("1号  " + raw);
    }
    return rows;
  }
  readonly property bool pairDual: !!(root.pairInfo && root.pairInfo.dual)

  //--------------------------------------------------------------------
  // 弃置弹窗的尺寸全部按显式数字算。
  // 宿主 createObject 后按 root 自身的宽高居中，而宽高若挂在
  // dialogCol.implicitWidth 上，一旦某一层的位置摆放出错就会退化成
  // 0 宽 0 高；这里改成 列数 × 牌面尺寸 的定值算式，不再往下依赖。
  //--------------------------------------------------------------------
  readonly property int dlgCount: root.dialogPairs.length
  // 4 组以内排一行，再多就两行均分，行数不会超过 4
  readonly property int dlgCols: root.dlgCount <= 4
    ? Math.max(1, root.dlgCount)
    : Math.max(2, Math.min(4, Math.ceil(root.dlgCount / 2)))
  readonly property int dlgRows: Math.max(1, Math.ceil(root.dlgCount / Math.max(1, root.dlgCols)))
  readonly property real dlgGridW: root.dlgCols * root.cardW + (root.dlgCols - 1) * root.gap
  readonly property real dlgGridH: root.dlgRows * root.cardH + (root.dlgRows - 1) * root.gap
  readonly property real dlgViewH: Math.min(root.dlgGridH, 430)

  readonly property real dlgPadTop: 36
  readonly property real dlgPadSide: 40
  readonly property real dlgPadBottom: 20
  readonly property real dlgCountH: 22
  readonly property real dlgBtnH: 36
  readonly property real dlgSpacing: 12

  width: dialog
    ? Math.max(root.dlgGridW + root.dlgPadSide * 2, 460)
    : (parent ? parent.width : 0)
  height: dialog
    ? (root.dlgPadTop + root.dlgViewH + root.dlgSpacing + root.dlgCountH
       + root.dlgSpacing + root.dlgBtnH + root.dlgPadBottom)
    : (parent ? parent.height : 0)

  function kingdomOf(g) {
    if (!g) return "";
    try {
      return Ltk.getGeneralData(g).kingdom ?? "";
    } catch (e) {
      return "";
    }
  }

  function gDataOf(g) {
    if (!g) return null;
    try {
      return Ltk.getGeneralData(g);
    } catch (e) {
      return null;
    }
  }

  function hpOf(g) {
    const d = gDataOf(g);
    // 双将牌顶合算的是「登场体力上限」，必须读 maxHp。
    // 像神孙策这类 hp=1/maxHp=6 的武将，旧代码读 hp 会把上限当成 1，
    // 组双将后黑条只剩一个勾玉。maxHp 与服务端 adjustDeputyHp 的口径一致。
    return d ? (d.maxHp ?? d.hp ?? 0) : 0;
  }

  function shieldOf(g) {
    const d = gDataOf(g);
    return d ? (d.shield ?? 0) : 0;
  }

  function magatamaOf(g) {
    const k = kingdomOf(g);
    return k === "" ? "" : (SkinBank.getGeneralCardDir(k) + k + "-magatama");
  }

  function isPairSelected(pair) {
    return !!pair && pair.length > 0 && selected.indexOf(pair[0]) >= 0;
  }

  function togglePair(pair) {
    if (!pair || pair.length < 2) return;   // 落单的牌不参与成组弃置
    if (isPairSelected(pair)) {
      selected = selected.filter(n => pair.indexOf(n) < 0);
    } else {
      if (selected.length + pair.length > num) return;
      const next = selected.slice();
      for (const g of pair) next.push(g);
      selected = next;
    }
  }

  function confirm() {
    if (!feasible) return;
    const picked = selected.slice();
    root.finished();
    Ltk.roomModel.deActivate();
    ClientInstance.replyToServer("", picked);
  }

  function cancel() {
    root.finished();
    Ltk.roomModel.deActivate();
    // 弃置是允许不弃的，回空数组即可；换将必须有人登场，
    // 这时 lua 会塞一份兜底结果，取消等价于取默认那一组
    const fb = root.seq(root.fallback);
    ClientInstance.replyToServer("", fb.length === root.num ? fb : []);
  }

  // 宿主 showPopup 会调用这两个（原 GraphicsBox 也有）
  function shown() {}
  function close() { root.finished() }

  // 唯一的 onCompleted：读 banner 兜底 + 弃置弹窗自检。
  // 今早曾因新增第二个 Component.onCompleted 造成重复声明，这里合并回一个。
  Component.onCompleted: {
    Qt.callLater(function() { root.pollBanners(); });
    if (!root.dialog) return;
    console.log("[hx3v3] pair panel: pairs=" + root.dialogPairs.length
      + " flat=" + (root.generalsFlat || "").split("|").length
      + " table=" + root.seq(generals).length
      + " raw=" + root.rawGenerals.length + " num=" + root.num
      + " cols=" + root.dlgCols + " size=" + root.width + "x" + root.height);
  }

  // 一组主副将合成一张牌：左右各半张立绘，中间一道金线，顶部黑条是合算后的体力
  component PairCard: Item {
    id: cardRoot
    required property var pair
    property bool selectable: false
    property bool selected: false
    signal toggled()

    width: 93 * root.cardScale
    height: 130 * root.cardScale

    readonly property string mainName: (pair && pair.length > 0) ? pair[0] : ""
    readonly property string deputyName: (pair && pair.length > 1) ? pair[1] : ""

    readonly property int mainHp: root.hpOf(mainName)
    readonly property int deputyHp: root.hpOf(deputyName)
    // 双将同体力：两将合计取半，这一份就是登场后的体力
    readonly property int mergedHp: deputyName === ""
      ? mainHp : Math.floor((mainHp + deputyHp) / 2)
    // 合计为奇数时舍去半点体力，补偿方式选阴阳鱼就给一枚
    readonly property int yinyangNum: (root.comp === "yinyang" && deputyName !== ""
        && (mainHp + deputyHp) % 2 === 1) ? 1 : 0
    // 护甲：两将自带护甲相加，补偿方式选护甲时再补一枚
    readonly property int armorNum: {
      if (deputyName === "") return root.shieldOf(mainName);
      let n = root.shieldOf(mainName) + root.shieldOf(deputyName);
      if (root.comp === "armor" && (mainHp + deputyHp) % 2 === 1) n += 1;
      return n;
    }

    function showDetail() {
      if (mainName === "") return;
      Ltk.roomScene.showInfoPopup(
        Qt.createComponent("LunarLtk.Pages.InfoPopups", "GeneralDetail"),
        { generals: deputyName === "" ? [mainName] : [mainName, deputyName] });
    }

    Rectangle {
      id: artMask
      anchors.fill: parent
      radius: 4 * root.cardScale
      visible: false
    }

    Item {
      id: artLayer
      anchors.fill: parent
      visible: false   // 只作为 OpacityMask 的素材，按 photobase 的写法隐藏

      Image {
        width: cardRoot.deputyName !== "" ? parent.width / 2 : parent.width
        height: parent.height
        smooth: true
        fillMode: Image.PreserveAspectCrop
        source: cardRoot.mainName === "" ? ""
          : (SkinBank.getGeneralExtraPic(cardRoot.mainName, "dual/")
            ?? SkinBank.getGeneralPicture(cardRoot.mainName))
      }

      Image {
        x: parent.width / 2
        width: parent.width / 2
        height: parent.height
        smooth: true
        visible: cardRoot.deputyName !== ""
        fillMode: Image.PreserveAspectCrop
        source: cardRoot.deputyName === "" ? ""
          : (SkinBank.getGeneralExtraPic(cardRoot.deputyName, "dual/")
            ?? SkinBank.getGeneralPicture(cardRoot.deputyName))
      }
    }

    OpacityMask {
      anchors.fill: artMask
      source: artLayer
      maskSource: artMask
    }

    // 中间的分割线，和牌桌上的双将头像一致
    Image {
      anchors.fill: parent
      visible: cardRoot.deputyName !== ""
      fillMode: Image.PreserveAspectCrop
      smooth: true
      source: SkinBank.photoDir + "deputy-split"
    }

    // 卡框压在立绘上面
    Image {
      anchors.fill: parent
      anchors.margins: -1 * root.cardScale
      fillMode: Image.PreserveAspectFit
      source: SkinBank.generalCardDir + "border"
    }

    // 势力的标记，左上角
    Image {
      x: -1 * root.cardScale; y: -1 * root.cardScale
      width: 22 * root.cardScale
      fillMode: Image.PreserveAspectFit
      source: {
        const k = root.kingdomOf(cardRoot.mainName);
        return k === "" ? "" : (SkinBank.getGeneralCardDir(k) + k);
      }
    }

    // 牌顶的黑条：双将合起来算的体力，旁边一枚护甲或阴阳鱼
    Rectangle {
      id: hpBar
      x: 22 * root.cardScale
      y: 2 * root.cardScale
      width: cardRoot.width - 24 * root.cardScale
      height: 13 * root.cardScale
      radius: 3 * root.cardScale
      color: "#B3000000"
      visible: cardRoot.mainName !== ""
        && (cardRoot.mergedHp > 0 || cardRoot.armorNum > 0 || cardRoot.yinyangNum > 0)

      Row {
        x: 2 * root.cardScale
        anchors.verticalCenter: parent.verticalCenter
        spacing: 0
        Repeater {
          model: Math.max(0, Math.min(5, cardRoot.mergedHp))
          Image {
            width: 9 * root.cardScale
            height: 9 * root.cardScale
            source: root.magatamaOf(cardRoot.mainName)
          }
        }
      }

      // 右边两枚标记并排：阴阳鱼在左、护甲在右。
      // 原来两个都 anchors.right，奇数补偿为阴阳鱼时会被护盾压住，
      // 看起来就像「选了阴阳鱼还是护甲」。
      Row {
        anchors.right: parent.right
        anchors.rightMargin: 1 * root.cardScale
        anchors.verticalCenter: parent.verticalCenter
        spacing: 2 * root.cardScale

        // 阴阳鱼：补偿方式为阴阳鱼、且两将体力合计为奇数时给一枚
        Image {
          visible: cardRoot.yinyangNum > 0
          width: 14 * root.cardScale
          height: 14 * root.cardScale
          fillMode: Image.PreserveAspectFit
          source: {
            // 与头像旁那个标记图标用同一张图；那张图属于 UI 包本身，不依赖国战包
            return Cpp.path + "/packages/lunarltk-qsgs-ui/image/selfArea/hegIcon/yinyangfish.png";
          }

          // 图片缺失时退回一个「☯」，牌面不会只剩一块空白
          Text {
            visible: parent.status !== Image.Ready
            anchors.centerIn: parent
            text: "☯"
            color: "white"
            font.pixelSize: 13 * root.cardScale
            font.bold: true
            style: Text.Outline
          }
        }

        // 护甲：两将自带的护甲相加（补偿方式为护甲时再加一枚）
        Image {
          visible: cardRoot.armorNum > 0
          width: 13 * root.cardScale
          height: 14 * root.cardScale
          source: SkinBank.magatamaDir + "shield"

          Text {
            anchors.horizontalCenter: parent.horizontalCenter
            y: -2 * root.cardScale
            text: cardRoot.armorNum
            color: "white"
            font.family: Config.libianName
            font.pixelSize: 13 * root.cardScale
            font.bold: true
            style: Text.Outline
          }
        }
      }
    }

    // 姓名竖排，主将在左半边、副将在右半边
    Text {
      x: 2 * root.cardScale; y: 26 * root.cardScale
      width: 17 * root.cardScale
      height: 86 * root.cardScale
      text: cardRoot.mainName === "" ? "" : Lua.tr(cardRoot.mainName)
      visible: cardRoot.mainName !== ""
      color: "white"
      font.family: "LiSu"
      font.pixelSize: 13 * root.cardScale
      lineHeight: 1.05
      style: Text.Outline
      wrapMode: Text.WrapAnywhere
    }

    Text {
      x: cardRoot.width / 2 + 2 * root.cardScale; y: 26 * root.cardScale
      width: 17 * root.cardScale
      height: 86 * root.cardScale
      text: cardRoot.deputyName === "" ? "" : Lua.tr(cardRoot.deputyName)
      visible: cardRoot.deputyName !== ""
      color: "white"
      font.family: "LiSu"
      font.pixelSize: 13 * root.cardScale
      lineHeight: 1.05
      style: Text.Outline
      wrapMode: Text.WrapAnywhere
    }

    // 选中/悬停的描边。原先用负的 anchors.margins 往外扩 3px，
    // 而池子和弃置列表都套在 clip: true 的 Flickable 里，
    // 边上一圈的描边会被裁掉，看起来像「只包了一半」。改画在牌内。
    Rectangle {
      anchors.fill: parent
      anchors.margins: 1
      radius: 5
      color: "transparent"
      border.width: 3
      border.color: cardRoot.selectable && cardRoot.selected ? "#4CAF50"
        : (hoverArea.containsMouse ? "#C8A96E" : "transparent")
    }

    Rectangle {
      anchors.fill: parent
      radius: 4
      color: cardRoot.selectable && cardRoot.selected ? "#4C4CAF50" : "transparent"
    }

    MouseArea {
      id: hoverArea
      anchors.fill: parent
      hoverEnabled: true
      cursorShape: Qt.PointingHandCursor
      // 长按看技能，松手时不要再把整组选中状态翻一次
      property bool held: false
      onPressed: held = false
      onPressAndHold: {
        held = true;
        cardRoot.showDetail();
      }
      onClicked: {
        if (held) return;
        if (cardRoot.selectable) cardRoot.toggled();
        else cardRoot.showDetail();
      }
    }
  }

  // 一栏备选：每张牌是一组主副将（仅展示用法）
  component Pile: Flickable {
    id: flick
    property var list: []
    property var pairs: root.pairsOf(list)

    contentWidth: width
    contentHeight: pairGrid.height
    clip: true

    Grid {
      id: pairGrid
      x: Math.max(0, (flick.width - pairGrid.width) / 2)
      columns: Math.max(1, Math.min(4, flick.pairs.length))
      spacing: root.gap

      Repeater {
        model: flick.pairs.length

        delegate: PairCard {
          required property int index
          pair: flick.pairs[index]
        }
      }
    }
  }

  // ---------------- 展示用法：铺满宿主 ----------------
  ColumnLayout {
    visible: !root.dialog
    anchors.fill: parent
    spacing: 4

    // ---- 本局已禁用入口：浮层固定在底部，不被备选池 fillHeight 挤出 ----
    Item {
      visible: !root.dialog && root.banNames.length > 0
      Layout.fillWidth: true
      Layout.preferredHeight: visible ? 28 : 0
      Layout.maximumHeight: 28
      Layout.minimumHeight: visible ? 28 : 0
      z: 20

      Rectangle {
        id: banBtn
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 220
        height: 26
        radius: 6
        color: root.banOpen ? "#8E2438" : "#2A1A20"
        border.color: "#C06070"
        border.width: 1
        Text {
          anchors.centerIn: parent
          text: "本局已禁用 (" + root.banNames.length + ")  " + (root.banOpen ? "收起" : "展开")
          color: "#FFE0E6"
          font.pixelSize: 13
        }
        MouseArea {
          anchors.fill: parent
          onClicked: root.banOpen = !root.banOpen
        }
      }

      Rectangle {
        visible: root.banOpen
        anchors.top: banBtn.bottom
        anchors.topMargin: 4
        anchors.horizontalCenter: banBtn.horizontalCenter
        width: Math.max(240, banBtn.width)
        height: Math.min(360, 28 + root.banRows.length * 24)
        radius: 6
        color: "#1E1418"
        border.color: "#8E2438"
        border.width: 1
        clip: true
        Flickable {
          anchors.fill: parent
          anchors.margins: 8
          contentHeight: banCol.implicitHeight
          clip: true
          Column {
            id: banCol
            width: parent.width
            spacing: 2
            Text {
              text: root.banGrouped ? "本局禁用（双将按组）" : "本局禁用武将"
              color: "#C06070"
              font.pixelSize: 12
              font.bold: true
            }
            Repeater {
              model: root.banRows
              delegate: Text {
                required property string modelData
                required property int index
                width: banCol.width
                text: (index + 1) + "号  " + Lua.tr(modelData)
                color: "#E8D8A0"
                font.pixelSize: 13
                elide: Text.ElideRight
              }
            }
          }
        }
      }
    }

    // ---- 本局已禁配入口：紧接在「本局已禁用」下方 ----
    Item {
      visible: !root.dialog && root.pairRows.length > 0
      Layout.fillWidth: true
      Layout.preferredHeight: visible ? 28 : 0
      Layout.maximumHeight: 28
      Layout.minimumHeight: visible ? 28 : 0
      z: 21

      Rectangle {
        id: pairBtn
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 220
        height: 26
        radius: 6
        color: root.pairOpen ? "#2E5E8E" : "#1A2430"
        border.color: "#5E90C0"
        border.width: 1
        Text {
          anchors.centerIn: parent
          text: "本局已禁配 (" + root.pairRows.length + ")  "
                + (root.pairOpen ? "收起" : "展开")
          color: "#D6E8FF"
          font.pixelSize: 13
        }
        MouseArea {
          anchors.fill: parent
          onClicked: {
            root.pairOpen = !root.pairOpen;
            if (root.pairOpen) root.banOpen = false;
          }
        }
      }

      Rectangle {
        visible: root.pairOpen
        anchors.top: pairBtn.bottom
        anchors.topMargin: 4
        anchors.horizontalCenter: pairBtn.horizontalCenter
        width: Math.max(260, pairBtn.width)
        height: Math.min(360, 28 + root.pairRows.length * 24)
        radius: 6
        color: "#141A22"
        border.color: "#2E5E8E"
        border.width: 1
        clip: true
        Flickable {
          anchors.fill: parent
          anchors.margins: 8
          contentHeight: pairCol.implicitHeight
          clip: true
          Column {
            id: pairCol
            width: parent.width
            spacing: 2
            Text {
              text: "本局禁配组合" + (root.pairDual ? "（双池各一将）" : "")
              color: "#7FB0E0"
              font.pixelSize: 12
              font.bold: true
            }
            Repeater {
              model: root.pairRows
              delegate: Text {
                required property string modelData
                width: pairCol.width
                text: "· " + modelData
                color: "#CFE0F5"
                font.pixelSize: 12
                elide: Text.ElideRight
              }
            }
          }
        }
      }
    }

    // 单方备选（未开比赛规则）
    ColumnLayout {
      visible: !root.duel
      Layout.fillWidth: true
      Layout.fillHeight: true
      Layout.minimumHeight: 0
      spacing: 4

      BigGlowText {
        Layout.fillWidth: true
        Layout.preferredHeight: childrenRect.height + 4
        text: Lua.tr(root.name)
      }

      Pile {
        list: root.displayCardNames
        Layout.fillWidth: true
        Layout.fillHeight: true
      }
    }

    // 双方备选（比赛规则）
    ColumnLayout {
      visible: root.duel
      Layout.fillWidth: true
      Layout.fillHeight: true
      Layout.minimumHeight: 0
      spacing: 4

      BigGlowText {
        Layout.fillWidth: true
        Layout.preferredHeight: childrenRect.height + 4
        text: Lua.tr("hx__cool_generals")
      }

      Pile {
        list: root.duelPools.length === 2 ? root.duelPools[0] : []
        Layout.fillWidth: true
        Layout.fillHeight: true
      }

      BigGlowText {
        Layout.fillWidth: true
        Layout.preferredHeight: childrenRect.height + 4
        text: Lua.tr("hx__warm_generals")
      }

      Pile {
        list: root.duelPools.length === 2 ? root.duelPools[1] : []
        Layout.fillWidth: true
        Layout.fillHeight: true
      }
    }

  }

  // ---------------- 弃置用法：自带外框的弹窗 ----------------
  Rectangle {
    visible: root.dialog
    anchors.fill: parent
    color: "#020302"
    opacity: 0.8
    radius: 5
    border.color: "#A6967A"
    border.width: 1
  }

  Text {
    visible: root.dialog
    anchors.top: parent.top
    anchors.topMargin: 5
    anchors.horizontalCenter: parent.horizontalCenter
    text: root.prompt !== "" ? root.prompt : Lua.tr("HX3v3_AskForThrowGeneral")
    color: "#E4D5A0"
    font.pixelSize: 18
  }

  Column {
    id: dialogCol
    visible: root.dialog
    anchors.fill: parent
    anchors.topMargin: root.dlgPadTop
    anchors.bottomMargin: root.dlgPadBottom
    anchors.leftMargin: root.dlgPadSide
    anchors.rightMargin: root.dlgPadSide
    spacing: root.dlgSpacing

    // 组数多时这一层滚动，弹窗高度不再跟着牌数线性长高
    Flickable {
      id: dialogFlick
      width: dialogCol.width
      height: root.dlgViewH
      contentWidth: width
      contentHeight: dialogGrid.height
      clip: true
      boundsBehavior: Flickable.StopAtBounds

      Grid {
        id: dialogGrid
        x: Math.max(0, (dialogFlick.width - dialogGrid.width) / 2)
        columns: root.dlgCols
        spacing: root.gap

        Repeater {
          model: root.dialogPairs.length

          delegate: PairCard {
            required property int index
            pair: root.dialogPairs[index]
            selectable: true
            selected: root.isPairSelected(root.dialogPairs[index])
            onToggled: root.togglePair(root.dialogPairs[index])
          }
        }
      }
    }

    Text {
      width: dialogCol.width
      height: root.dlgCountH
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
      text: Lua.tr("HX3v3_PairThrow_count") + " " + root.selected.length + " / " + root.num
        + (root.dialogPairs.length === 0 ? "（未收到武将数据）" : "")
      font.family: Config.li2Name
      font.pixelSize: 15
      color: root.feasible ? "#8BC34A" : "#BBBBBB"
    }

    Item {
      width: dialogCol.width
      height: root.dlgBtnH

      Row {
        anchors.centerIn: parent
        spacing: 20

        Rectangle {
          width: 120
          height: root.dlgBtnH
          radius: 6
          border.width: 2
          enabled: root.feasible
          border.color: enabled ? (okArea.containsMouse ? "#4CAF50" : "#45a049") : "#555555"
          color: enabled ? (okArea.containsMouse ? "#4CAF50" : "#45a049") : "#2D2D2D"

          Text {
            anchors.centerIn: parent
            text: Lua.tr("OK")
            font.family: Config.li2Name
            font.pixelSize: 16
            font.bold: true
            color: parent.enabled ? "#FFFFFF" : "#888888"
          }

          MouseArea {
            id: okArea
            anchors.fill: parent
            enabled: parent.enabled
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: parent.enabled
            onClicked: root.confirm()
          }
        }

        Rectangle {
          width: 120
          height: root.dlgBtnH
          radius: 6
          border.width: 2
          border.color: cancelArea.containsMouse ? "#E57373" : "#C62828"
          color: cancelArea.containsMouse ? "#E57373" : "#C62828"

          Text {
            anchors.centerIn: parent
            text: Lua.tr("Cancel")
            font.family: Config.li2Name
            font.pixelSize: 16
            font.bold: true
            color: "#FFFFFF"
          }

          MouseArea {
            id: cancelArea
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: root.cancel()
          }
        }
      }
    }
  }
}
