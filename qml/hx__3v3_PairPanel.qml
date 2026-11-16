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
    if (v === undefined || v === null || typeof v === "string") return [];
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

  readonly property var dialogPairs: root.pairsOf(generals)

  // 双方栏：value 为 { 冷方池, 暖方池 }，内外两层都是 QVariantList
  readonly property var duelPools: {
    const v = root.seq(value);
    if (v.length !== 2) return [];
    const cool = root.seq(v[0]);
    const warm = root.seq(v[1]);
    if (cool.length === 0 && warm.length === 0) return [];
    return [cool, warm];
  }
  readonly property bool duel: root.duelPools.length === 2

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

  // 只在弃置弹窗里留一条自检：牌数为 0 时能直接从日志看出是哪一层空了
  Component.onCompleted: {
    if (!root.dialog) return;
    console.log("[hx3v3] pair panel: pairs=" + root.dialogPairs.length
      + " raw=" + root.seq(generals).length + " num=" + root.num
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

    // 单方备选（未开比赛规则）
    ColumnLayout {
      visible: !root.duel
      Layout.fillWidth: true
      Layout.fillHeight: true
      spacing: 4

      BigGlowText {
        Layout.fillWidth: true
        Layout.preferredHeight: childrenRect.height + 4
        text: Lua.tr(root.name)
      }

      Pile {
        list: root.cardNames
        Layout.fillWidth: true
        Layout.fillHeight: true
      }
    }

    // 双方备选（比赛规则）
    ColumnLayout {
      visible: root.duel
      Layout.fillWidth: true
      Layout.fillHeight: true
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
