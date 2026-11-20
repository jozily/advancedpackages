// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Fk
import LunarLtk

// 禁配方案管理入口（血战附加规则设置项）。
// 由 advancedpackages/rules/hx__3v3_extra_rules.lua 注入。
//
// 方案存 Config.conf.pairSchemes：
//   { name, dual:bool, banA:int(禁将方案序号,1起), banB:int, pairs:[[g1,g2],...] }
// single: dual=false，两名将都来自 banA 将池；
// dual  : dual=true，pairs 每项 [A池将, B池将]，两池各选一名。
// 禁配筛选仅限所选禁将方案的将池（banPkg/normalPkg/banCardPkg 折算）。
Item {
  id: root

  property string title: ""
  property string subTitle: ""
  property var schemes: []
  property int curIdx: 0
  property bool busy: false

  // 将池不能做成声明式绑定：combo 改的是普通 JS 对象字段 s.banA/s.banB，
  // QML 绑定系统追踪不到对象内部字段变化，会一直显示第一次算出的池。
  // 改成普通属性，在每次切换方案/禁将方案/双方案后显式重算。
  property var poolA: []
  property var poolB: []
  property bool syncingBan: false

  readonly property var badgeColors: [
    "#E81A62", "#3D7EFF", "#20A162", "#F5A623", "#8E44AD", "#00A6A6"
  ]

  implicitHeight: Math.max(60, titleCol.implicitHeight + 16)

  // Lua 表桥接来的 QVariantList：Array.isArray 对它返回 false，统一归一。
  function seq(v) {
    if (v === undefined || v === null || typeof v === "string") return [];
    if (Array.isArray(v)) return v.slice();
    if (typeof v !== "object") return [];
    if (typeof v.count === "number" && typeof v.get === "function") {
      var a = []; for (var i = 0; i < v.count; ++i) a.push(v.get(i)); return a;
    }
    var n = (typeof v.length === "number") ? v.length : 0, b = [];
    for (var j = 0; j < n; ++j) b.push(v[j]);
    if (b.length > 0) return b;
    var keys = Object.keys(v).filter(function(k) { return /^\d+$/.test(k); })
                 .sort(function(x, y) { return Number(x) - Number(y); });
    for (var m = 0; m < keys.length; ++m) b.push(v[keys[m]]);
    return b;
  }

  // ---------------- 持久化：Config.conf.pairSchemes ----------------
  function loadSchemes() {
    var c = Config.conf || {};
    var s = root.seq(c.pairSchemes);
    if (s.length === 0) {
      s = [{ name: "禁配方案 1", dual: false, banA: 1, banB: 2, pairs: [] }];
    }
    for (var i = 0; i < s.length; ++i) {
      if (typeof s[i].dual !== "boolean") s[i].dual = false;
      if (!s[i].banA) s[i].banA = 1;
      if (!s[i].banB) s[i].banB = 2;
      s[i].pairs = root.normPairs(s[i].pairs);
    }
    root.schemes = s;
    root.curIdx = Math.min(Math.max(0, c.pairIdx || 0), s.length - 1);
    syncBanCombos();
  }

  function normPairs(p) {
    var arr = root.seq(p), out = [];
    for (var i = 0; i < arr.length; ++i) {
      var pair = root.seq(arr[i]);
      if (pair.length >= 2) out.push([pair[0], pair[1]]);
    }
    return out;
  }

  function saveSchemes() {
    var c = Config.conf || {};
    c.pairSchemes = root.schemes;
    c.pairIdx = root.curIdx;
    Config.conf = c;
    Config.saveConf();
    pushToServer();
  }

  function cur() { return root.schemes[root.curIdx]; }

  function rebuildCombo() {
    if (!pairCombo) return;
    pairCombo.model = root.schemes.map(function(s, i) {
      return (s.name && s.name !== "") ? s.name : ("禁配方案 " + (i + 1));
    });
    pairCombo.currentIndex = root.curIdx;
  }

  function refreshPairs() {
    if (!pairModel) return;
    var s = cur();
    pairModel.clear();
    if (!s) return;
    var pairs = root.normPairs(s.pairs);
    for (var i = 0; i < pairs.length; i++)
      pairModel.append({ label: i + 1, g1: pairs[i][0], g2: pairs[i][1] });
  }

  // ---------------- 禁将方案将池 ----------------
  readonly property var banSchemes: root.seq(Config.disableSchemes)

  function banSchemeName(idx) {
    var s = root.banSchemes[idx - 1];
    return (s && s.name && s.name !== "") ? s.name : ("禁将方案 " + idx);
  }

  // 按禁将方案折算可用武将池（与官方 filterAllGenerals / 服务端 banSetsOf 一致）。
  function poolOfScheme(idx) {
    var s = root.banSchemes[idx - 1];
    var out = [];
    if (!s) return out;
    var packs = root.seq(Ltk.getAllGeneralPack());
    if (packs.length === 0) return out;
    var disGens = root.seq(Lua.client.disabled_generals);
    var disPacks = root.seq(Lua.client.disabled_packs);
    var banPkg = (s.banPkg && typeof s.banPkg === "object") ? s.banPkg : {};
    var normalPkg = (s.normalPkg && typeof s.normalPkg === "object") ? s.normalPkg : {};
    var banCardPkg = root.seq(s.banCardPkg);
    var seen = {}, hiddenCache = {};
    function isHidden(g) {
      if (hiddenCache[g] !== undefined) return hiddenCache[g];
      var h = false;
      try { h = !!Lua.ev("Fk.generals['" + g + "'].hidden"); } catch (e) {}
      hiddenCache[g] = h; return h;
    }
    function add(g) {
      if (!g || seen[g] || isHidden(g)) return;
      seen[g] = true; out.push(g);
    }
    for (var pi = 0; pi < packs.length; ++pi) {
      var pack = packs[pi];
      if (disPacks.indexOf(pack) >= 0 || banCardPkg.indexOf(pack) >= 0) continue;
      var gs = root.seq(Ltk.getGenerals(pack));
      if (Object.prototype.hasOwnProperty.call(banPkg, pack)) {
        var white = root.seq(banPkg[pack]);
        for (var w = 0; w < white.length; ++w)
          if (disGens.indexOf(white[w]) < 0) add(white[w]);
      } else if (Object.prototype.hasOwnProperty.call(normalPkg, pack)) {
        var black = root.seq(normalPkg[pack]);
        for (var b = 0; b < gs.length; ++b)
          if (black.indexOf(gs[b]) < 0 && disGens.indexOf(gs[b]) < 0) add(gs[b]);
      } else {
        for (var k = 0; k < gs.length; ++k)
          if (disGens.indexOf(gs[k]) < 0) add(gs[k]);
      }
    }
    return out;
  }

  // 显式重算将池，并同步下方禁将方案下拉框。
  function recomputePools() {
    var s = cur();
    root.poolA = s ? root.poolOfScheme(s.banA || 1) : [];
    root.poolB = (s && s.dual) ? root.poolOfScheme(s.banB || 2) : [];
  }

  function syncBanCombos() {
    if (!comboA || !comboB) return;
    var s = cur();
    root.syncingBan = true;
    var na = comboA.model ? comboA.model.length : 0;
    var nb = comboB.model ? comboB.model.length : 0;
    comboA.currentIndex = s ? Math.min(Math.max(0, (s.banA || 1) - 1), Math.max(0, na - 1)) : 0;
    comboB.currentIndex = s ? Math.min(Math.max(0, (s.banB || 2) - 1), Math.max(0, nb - 1)) : 0;
    root.syncingBan = false;
    root.recomputePools();
  }

  function labelOf(g) {
    var s = cur();
    if (!s) return 0;
    var pairs = root.normPairs(s.pairs);
    for (var i = 0; i < pairs.length; i++)
      if (pairs[i][0] === g || pairs[i][1] === g) return i + 1;
    return 0;
  }

  // ---------------- LobbyTask ----------------
  function pushToServer() {
    var payload = JSON.stringify({ op: "push_pairs", schemes: root.schemes, cur: root.curIdx + 1 });
    Cpp.notifyServer("LobbyTask", ["hx_pair_sync", payload]);
  }
  function doSync(upload) {
    if (root.busy) return;
    root.busy = true;
    var payload = JSON.stringify({ op: "sync", schemes: upload ? root.schemes : [] });
    Cpp.notifyServer("LobbyTask", ["hx_pair_sync", payload]);
    syncTimer.start();
  }
  Component.onCompleted: {
    Qt.callLater(function() {
      loadSchemes();
      // 服务端重启会清空内存槽；组件每次加载必须主动把房主禁配方案
      // 重推一次，否则开局 readPairSchemes 读不到，禁配限制与 @& 横幅全失效。
      // 与禁将按钮 UpdateSchemesButton.pushAllSchemes 同一机制。
      pushToServer();
    });
  }
  Timer {
    id: syncTimer; interval: 8000; repeat: false
    onTriggered: { if (root.busy) { root.busy = false; App.showToast("同步超时，请重试"); } }
  }
  Connections {
    target: Mediator
    function onCommandGot(sender, command, data) {
      if (command !== "hx_pair_sync_result") return;
      syncTimer.stop(); root.busy = false;
      var p = data;
      if (typeof p === "string") { try { p = JSON.parse(p); } catch (e) { p = null; } }
      if (!p || p.ok !== true) { App.showToast("同步失败，请确认已连接服务器"); return; }
      var incoming = root.seq(p.schemes);
      if (incoming.length === 0) {
        App.showToast("云端暂无禁配方案，可先点「上传」保存一套");
        return;
      }
      var have = {};
      for (var i = 0; i < root.schemes.length; i++)
        if (root.schemes[i].name) have[root.schemes[i].name] = true;
      var added = 0;
      for (var j = 0; j < incoming.length; ++j) {
        var s = incoming[j];
        if (!s || !s.name || have[s.name]) continue;
        root.schemes.push({ name: s.name, dual: s.dual === true,
          banA: s.banA || 1, banB: s.banB || 2, pairs: root.normPairs(s.pairs) });
        have[s.name] = true; added++;
      }
      rebuildCombo();
      saveSchemes();
      var msg = (p.admin && p.pushed) ? ("已上传云端，共 " + root.schemes.length + " 套")
              : (added > 0 ? ("已拉取云端方案，新增 " + added + " 套") : "云端方案均已在本地");
      App.showToast(msg);
    }
  }

  // ---------------- 入口行 ----------------
  RowLayout {
    anchors.fill: parent
    anchors.leftMargin: 16; anchors.rightMargin: 16; spacing: 12
    ColumnLayout {
      id: titleCol; Layout.fillWidth: true; Layout.alignment: Qt.AlignVCenter; spacing: 2
      Text { text: root.title; font.pixelSize: 17; font.bold: true; elide: Text.ElideRight
             Layout.fillWidth: true; color: "#333333" }
      Text { text: root.subTitle; visible: root.subTitle !== ""; font.pixelSize: 13
             font.bold: false; wrapMode: Text.WordWrap; Layout.fillWidth: true; color: "#888888" }
    }
    Button {
      Layout.alignment: Qt.AlignVCenter; Layout.preferredHeight: 32
      text: root.busy ? "处理中" : "管理"; enabled: !root.busy
      contentItem: Text { text: parent.text; color: "#333"; font.pixelSize: 13
        horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
      onClicked: Qt.callLater(function() {
        try { loadSchemes(); mgr.open(); }
        catch (err) { App.showToast("打开禁配管理失败：" + err); }
      })
    }
  }

  // ---------------- 小头像 ----------------
  component SmallAvatar : Item {
    id: av; property string name: ""; width: 48; height: 48
    Image {
      property bool useSmall: !!SkinBank.getGeneralExtraPic(av.name, "avatar/")
      anchors.fill: parent
      source: SkinBank.getGeneralExtraPic(av.name, "avatar/") ?? SkinBank.getGeneralPicture(av.name)
      sourceClipRect: useSmall ? undefined : Qt.rect(61, 20, 128, 128)
      fillMode: Image.PreserveAspectCrop; asynchronous: true
    }
    Rectangle { anchors.fill: parent; color: "transparent"; border.width: 1; border.color: "#C9C9CF"; radius: 4 }
  }

  // 可复用的武将头像格（带序号徽章）
  component GeneralCell : Item {
    id: cell
    property string gname: ""
    property int side: 0
    width: 60; height: 66
    SmallAvatar { name: cell.gname; anchors.horizontalCenter: parent.horizontalCenter; y: 1; width: 46; height: 46 }
    Text {
      anchors.top: parent.top; anchors.topMargin: 49; anchors.horizontalCenter: parent.horizontalCenter
      text: Lua.tr(cell.gname); font.pixelSize: 10; color: "#444"; width: 58
      elide: Text.ElideRight; horizontalAlignment: Text.AlignHCenter
    }
    Rectangle {
      visible: root.labelOf(cell.gname) > 0
      anchors.top: parent.top; anchors.left: parent.left; width: 17; height: 17; radius: 9
      color: root.badgeColors[(root.labelOf(cell.gname) - 1) % root.badgeColors.length]
      Text { anchors.centerIn: parent; text: root.labelOf(cell.gname); color: "white"; font.pixelSize: 10; font.bold: true }
    }
    MouseArea { anchors.fill: parent; onClicked: addGeneral(cell.gname, cell.side) }
  }

  // ---------------- 管理窗口 ----------------
  Popup {
    id: mgr
    width: Math.min((Overlay.overlay ? Overlay.overlay.width : 960) - 24, 1120)
    height: Math.min((Overlay.overlay ? Overlay.overlay.height : 540) - 24, 800)
    anchors.centerIn: Overlay.overlay
    modal: true; closePolicy: Popup.CloseOnEscape; padding: 0
    background: Rectangle { radius: 10; color: "#FAFAFB"; border.color: "#E3E3E6"; border.width: 1 }
    onOpened: { loadSchemes(); rebuildCombo(); refreshPairs(); syncBanCombos(); }

    ColumnLayout {
      anchors.fill: parent; anchors.margins: 10; spacing: 6

      // 标题栏
      Rectangle {
        Layout.fillWidth: true; Layout.preferredHeight: 38; radius: 8; color: "#D8145A"
        RowLayout {
          anchors.fill: parent; anchors.leftMargin: 12; anchors.rightMargin: 6
          Text { text: "禁配方案管理"; color: "white"; font.pixelSize: 16; font.bold: true; Layout.fillWidth: true }
          Button { text: "关闭"; flat: true; onClicked: mgr.close()
            contentItem: Text { text: parent.text; color: "white"; font.pixelSize: 12
              horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
            background: Rectangle { color: "transparent" } }
        }
      }

      // 方案工具行
      Rectangle {
        Layout.fillWidth: true; Layout.preferredHeight: 42; radius: 8; color: "#FFF"; border.color: "#EBEBEE"
        RowLayout {
          anchors.fill: parent; anchors.leftMargin: 8; anchors.rightMargin: 8; spacing: 5
          Text { text: "方案"; font.pixelSize: 12; color: "#555"
            Layout.alignment: Qt.AlignVCenter }
          ComboBox {
            id: pairCombo; Layout.minimumWidth: 100; Layout.fillWidth: true
            Layout.preferredHeight: 28; Layout.alignment: Qt.AlignVCenter; font.pixelSize: 11
            delegate: ItemDelegate {
              width: pairCombo.width; height: 26
              contentItem: Text { text: modelData; font.pixelSize: 11; color: "#333"; verticalAlignment: Text.AlignVCenter }
              highlighted: pairCombo.highlightedIndex === index
            }
            onCurrentIndexChanged: {
              if (root.syncingBan) return;
              if (currentIndex < 0 || currentIndex === root.curIdx) return;
              root.curIdx = currentIndex; root.pendingA = ""; root.pendingB = "";
              refreshPairs(); syncBanCombos();
            }
          }
          Button { text: "新建"; padding: 0; Layout.preferredHeight: 28; Layout.preferredWidth: 46; Layout.alignment: Qt.AlignVCenter
            contentItem: Text { anchors.fill: parent; text: "新建"; color: "#333"; font.pixelSize: 11
              horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
            onClicked: {
              root.schemes.push({ name: "禁配方案 " + (root.schemes.length + 1), dual: false, banA: 1, banB: 2, pairs: [] });
              root.curIdx = root.schemes.length - 1; rebuildCombo(); refreshPairs(); syncBanCombos(); } }
          Button { text: "重命名"; padding: 0; Layout.preferredHeight: 28; Layout.preferredWidth: 58; Layout.alignment: Qt.AlignVCenter
            contentItem: Text { anchors.fill: parent; text: "重命名"; color: "#333"; font.pixelSize: 11
              horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
            onClicked: renamePopup.open() }
          Button { text: "删除"; padding: 0; Layout.preferredHeight: 28; Layout.preferredWidth: 46; Layout.alignment: Qt.AlignVCenter
            contentItem: Text { anchors.fill: parent; text: "删除"; color: "#C62828"; font.pixelSize: 11
              horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
            onClicked: { if (root.schemes.length <= 1) { App.showToast("至少保留一套方案"); return; }
              root.schemes.splice(root.curIdx, 1); root.curIdx = Math.max(0, root.curIdx - 1);
              rebuildCombo(); refreshPairs(); syncBanCombos(); } }
          Button { text: root.busy ? "稍候" : "上传"; padding: 0; Layout.preferredHeight: 28; Layout.preferredWidth: 46
            Layout.alignment: Qt.AlignVCenter; enabled: !root.busy
            contentItem: Text { anchors.fill: parent; text: parent.text; color: "#333"; font.pixelSize: 11
              horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
            onClicked: doSync(true) }
          Button { text: root.busy ? "稍候" : "拉取"; padding: 0; Layout.preferredHeight: 28; Layout.preferredWidth: 46
            Layout.alignment: Qt.AlignVCenter; enabled: !root.busy
            contentItem: Text { anchors.fill: parent; text: parent.text; color: "#333"; font.pixelSize: 11
              horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
            onClicked: doSync(false) }
          Button { text: "保存"; padding: 0; Layout.preferredHeight: 28; Layout.preferredWidth: 46; Layout.alignment: Qt.AlignVCenter
            contentItem: Text { anchors.fill: parent; text: "保存"; color: "#333"; font.pixelSize: 11
              horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
            onClicked: saveSchemes() }
        }
      }

      // 禁将方案配置行
      Rectangle {
        Layout.fillWidth: true; Layout.preferredHeight: 42; radius: 8; color: "#F3F6FA"; border.color: "#DDE5EE"
        RowLayout {
          anchors.fill: parent; anchors.leftMargin: 8; anchors.rightMargin: 8; spacing: 5
          Text { text: "双方案"; font.pixelSize: 12; color: "#333"
            Layout.alignment: Qt.AlignVCenter }
          Switch {
            id: dualSwitch; checked: cur() ? cur().dual === true : false
            Layout.alignment: Qt.AlignVCenter; Layout.preferredHeight: 28
            onToggled: { var s = cur(); if (s) { s.dual = checked; root.pendingA = ""; root.pendingB = ""; root.recomputePools(); } }
          }
          Text { text: "A池"; font.pixelSize: 11; color: "#555"
            Layout.alignment: Qt.AlignVCenter }
          ComboBox {
            id: comboA; Layout.minimumWidth: 120; Layout.preferredHeight: 28
            Layout.alignment: Qt.AlignVCenter; font.pixelSize: 11
            model: root.banSchemes.map(function(s, i) {
              return (s && s.name && s.name !== "") ? s.name : ("禁将方案 " + (i + 1)); })
            delegate: ItemDelegate {
              width: comboA.width; height: 26
              contentItem: Text { text: modelData; font.pixelSize: 11; color: "#333"; verticalAlignment: Text.AlignVCenter }
              highlighted: comboA.highlightedIndex === index
            }
            onCurrentIndexChanged: {
              if (root.syncingBan) return;
              var s = cur(); if (s && root.banSchemes.length > 0) {
                s.banA = currentIndex + 1; root.pendingA = ""; root.pendingB = ""; root.recomputePools();
              }
            }
          }
          Text { text: "B池"; font.pixelSize: 11; color: "#555"; visible: dualSwitch.checked
            Layout.alignment: Qt.AlignVCenter }
          ComboBox {
            id: comboB; visible: dualSwitch.checked; Layout.minimumWidth: 120; Layout.preferredHeight: 28
            Layout.alignment: Qt.AlignVCenter; font.pixelSize: 11
            model: root.banSchemes.map(function(s, i) {
              return (s && s.name && s.name !== "") ? s.name : ("禁将方案 " + (i + 1)); })
            delegate: ItemDelegate {
              width: comboB.width; height: 26
              contentItem: Text { text: modelData; font.pixelSize: 11; color: "#333"; verticalAlignment: Text.AlignVCenter }
              highlighted: comboB.highlightedIndex === index
            }
            onCurrentIndexChanged: {
              if (root.syncingBan) return;
              var s = cur(); if (s && root.banSchemes.length > 0) {
                s.banB = currentIndex + 1; root.pendingB = ""; root.recomputePools();
              }
            }
          }
          Button { text: "保存"; padding: 0; Layout.preferredHeight: 28; Layout.preferredWidth: 46; Layout.alignment: Qt.AlignVCenter
            contentItem: Text { anchors.fill: parent; text: "保存"; color: "#333"; font.pixelSize: 11
              horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
            onClicked: saveSchemes() }
        }
      }

      // 主体：单方案＝选将区 + 标号表；双方案＝A池选将 + B池预览 + 标号表
      RowLayout {
        Layout.fillWidth: true; Layout.fillHeight: true; spacing: 8

        // A 池选将区
        Rectangle {
          Layout.preferredWidth: dualSwitch.checked ? Math.round(mgr.width * 0.36) : Math.round(mgr.width * 0.55)
          Layout.fillHeight: true
          radius: 8; color: "#FFF"; border.color: "#EBEBEE"
          ColumnLayout {
            anchors.fill: parent; anchors.margins: 6; spacing: 5
            RowLayout {
              Layout.fillWidth: true; Layout.preferredHeight: 30; spacing: 4
              Text { text: "选将池：" + root.banSchemeName(cur() ? cur().banA : 1)
                font.pixelSize: 11; color: "#666"; Layout.fillWidth: true; elide: Text.ElideRight }
              Button {
                id: tabSearch; text: "搜索"; checkable: true; checked: true
                Layout.preferredWidth: 50; Layout.preferredHeight: 26; Layout.alignment: Qt.AlignVCenter
                contentItem: Text { text: "搜索"; color: tabSearch.checked ? "white" : "#555"; font.pixelSize: 11
                  horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                background: Rectangle { radius: 4; color: tabSearch.checked ? "#D8145A" : "#EDEDF0"
                  border.color: tabSearch.checked ? "#D8145A" : "#D5D5DA" }
                onClicked: { checked = true; tabAll.checked = false; }
              }
              Button {
                id: tabAll; text: "全部"; checkable: true
                Layout.preferredWidth: 50; Layout.preferredHeight: 26; Layout.alignment: Qt.AlignVCenter
                contentItem: Text { text: "全部"; color: tabAll.checked ? "white" : "#555"; font.pixelSize: 11
                  horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                background: Rectangle { radius: 4; color: tabAll.checked ? "#D8145A" : "#EDEDF0"
                  border.color: tabAll.checked ? "#D8145A" : "#D5D5DA" }
                onClicked: { checked = true; tabSearch.checked = false; }
              }
            }
            TextField {
              id: searchField; Layout.fillWidth: true; Layout.preferredHeight: 32; visible: tabSearch.checked
              placeholderText: "在将池内搜索武将名"
              onTextChanged: doSearch()
            }
            GridView {
              id: searchGrid; visible: tabSearch.checked
              Layout.fillWidth: true; Layout.fillHeight: true; clip: true
              cellWidth: 60; cellHeight: 66
              model: ListModel { id: searchModel }
              delegate: GeneralCell { gname: model.name; side: 0 }
            }
            GridView {
              id: gridAll; visible: tabAll.checked
              Layout.fillWidth: true; Layout.fillHeight: true; clip: true
              cellWidth: 60; cellHeight: 66
              model: root.poolA
              delegate: GeneralCell { gname: modelData; side: 0 }
            }
          }
        }

        // B 池预览（仅双方案）
        Rectangle {
          visible: dualSwitch.checked
          Layout.preferredWidth: Math.round(mgr.width * 0.32); Layout.fillHeight: true
          radius: 8; color: "#F7FBFF"; border.color: "#D6E4F2"
          ColumnLayout {
            anchors.fill: parent; anchors.margins: 6; spacing: 5
            Text { text: "B池：" + root.banSchemeName(cur() ? cur().banB : 2)
              + "（点一名与A池成组）"; font.pixelSize: 11; font.bold: true; color: "#2E5E8E"
              Layout.fillWidth: true; elide: Text.ElideRight }
            GridView {
              id: gridB; Layout.fillWidth: true; Layout.fillHeight: true; clip: true
              cellWidth: 60; cellHeight: 66; model: root.poolB
              delegate: GeneralCell { gname: modelData; side: 1 }
            }
          }
        }

        // 标号表（始终占满剩余高度，不再留空白）
        Rectangle {
          Layout.fillWidth: true; Layout.fillHeight: true
          radius: 8; color: "#FFF"; border.color: "#EBEBEE"
          ColumnLayout {
            anchors.fill: parent; anchors.margins: 6; spacing: 5
            RowLayout {
              Layout.fillWidth: true; Layout.preferredHeight: 28
              Text { text: "禁配标号"; font.pixelSize: 12; font.bold: true; color: "#D8145A"; Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter; verticalAlignment: Text.AlignVCenter }
              Text { text: "共 " + pairModel.count + " 组"; color: "#909098"; font.pixelSize: 11
                Layout.alignment: Qt.AlignVCenter; verticalAlignment: Text.AlignVCenter }
              Button { text: "预览"; padding: 0; Layout.preferredHeight: 26; Layout.preferredWidth: 46; Layout.alignment: Qt.AlignVCenter
                contentItem: Text { anchors.fill: parent; text: "预览"; color: "#333"; font.pixelSize: 11
                  horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                onClicked: showPreview() }
            }
            Rectangle {
              Layout.fillWidth: true; Layout.preferredHeight: 26
              visible: (dualSwitch.checked ? root.pendingA !== "" || root.pendingB !== "" : root.pendingA !== "")
              radius: 5; color: "#FFF4E5"; border.color: "#F5C97B"
              Text { anchors.centerIn: parent; font.pixelSize: 11; color: "#9A6B00";
                text: dualSwitch.checked
                  ? ("A:" + Lua.tr(root.pendingA) + " / B:" + Lua.tr(root.pendingB))
                  : ("已选 " + Lua.tr(root.pendingA) + "，再点一名") }
            }
            ListView {
              id: pairList; Layout.fillWidth: true; Layout.fillHeight: true; clip: true
              model: ListModel { id: pairModel }
              delegate: Rectangle {
                width: pairList.width - 4; height: 42; radius: 6; color: "#FBFAFC"; border.color: "#EFEFF2"
                RowLayout {
                  anchors.fill: parent; anchors.leftMargin: 6; anchors.rightMargin: 4; spacing: 4
                  Rectangle { Layout.preferredWidth: 20; Layout.preferredHeight: 20; radius: 10
                    color: root.badgeColors[(model.label - 1) % root.badgeColors.length]
                    Text { anchors.centerIn: parent; text: model.label; color: "white"; font.pixelSize: 10; font.bold: true } }
                  SmallAvatar { name: model.g1; width: 30; height: 30 }
                  Text { text: Lua.tr(model.g1); font.pixelSize: 10; color: "#333"; elide: Text.ElideRight }
                  Text { text: "配"; font.pixelSize: 10; color: "#B0B0B6" }
                  SmallAvatar { name: model.g2; width: 30; height: 30 }
                  Text { text: Lua.tr(model.g2); font.pixelSize: 10; color: "#333"; Layout.fillWidth: true; elide: Text.ElideRight }
                  Button { text: "移除"; Layout.preferredWidth: 48; Layout.preferredHeight: 24
                    contentItem: Text { text: parent.text; color: "#C62828"; font.pixelSize: 10
                      horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                    onClicked: { var s = cur(); s.pairs = root.normPairs(s.pairs);
                      s.pairs.splice(model.label - 1, 1); refreshPairs(); } }
                }
              }
            }
          }
        }
      }
    }
  }

  function doSearch() {
    searchModel.clear();
    var word = searchField.text.trim();
    if (word === "") return;
    var pool = root.poolA;
    for (var i = 0; i < pool.length; ++i) {
      var g = pool[i];
      if (g.indexOf(word) >= 0 || Lua.tr(g).indexOf(word) >= 0)
        searchModel.append({ name: g });
    }
  }

  property string pendingA: ""
  property string pendingB: ""

  function addGeneral(g, side) {
    var s = cur();
    if (!s) return;
    s.pairs = root.normPairs(s.pairs);
    if (!s.dual) {
      if (root.pendingA === "") {
        root.pendingA = g; App.showToast("已选 " + Lua.tr(g) + "，再点一名配成同标号");
      } else if (root.pendingA === g) {
        App.showToast("不能与自身配对");
      } else {
        s.pairs.push([root.pendingA, g]); root.pendingA = ""; refreshPairs();
      }
    } else {
      if (side === 0) {
        if (root.pendingB !== "") { s.pairs.push([g, root.pendingB]); root.pendingB = ""; refreshPairs(); }
        else { root.pendingA = g; App.showToast("已选 A 池 " + Lua.tr(g) + "，再到 B 池选一名"); }
      } else {
        if (root.pendingA !== "") { s.pairs.push([root.pendingA, g]); root.pendingA = ""; refreshPairs(); }
        else { root.pendingB = g; App.showToast("已选 B 池 " + Lua.tr(g) + "，再到 A 池选一名"); }
      }
    }
  }

  function showPreview() {
    var s = cur(), lines = [];
    if (s) {
      var pairs = root.normPairs(s.pairs);
      for (var i = 0; i < pairs.length; i++)
        lines.push((i + 1) + "号：" + Lua.tr(pairs[i][0]) + " 配 " + Lua.tr(pairs[i][1]));
    }
    previewText.text = lines.length ? lines.join("\n") : "（空方案）";
    previewPopup.open();
  }

  Popup {
    id: renamePopup; anchors.centerIn: Overlay.overlay; width: 340; height: 150
    modal: true; closePolicy: Popup.CloseOnEscape; padding: 12
    background: Rectangle { radius: 10; color: "#FFF"; border.color: "#E3E3E6" }
    ColumnLayout {
      anchors.fill: parent; spacing: 8
      Text { text: "重命名方案"; font.pixelSize: 16; font.bold: true; color: "#333" }
      TextField { id: rnField; Layout.fillWidth: true; placeholderText: "方案名" }
      RowLayout { Layout.fillWidth: true; Item { Layout.fillWidth: true }
        Button { text: "取消"; Layout.preferredHeight: 30
          contentItem: Text { text: parent.text; color: "#333"; font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
          onClicked: renamePopup.close() }
        Button { text: "确定"; Layout.preferredHeight: 30
          contentItem: Text { text: parent.text; color: "#D8145A"; font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
          onClicked: { var s = cur();
            if (s && rnField.text.trim() !== "") { s.name = rnField.text.trim(); rebuildCombo(); saveSchemes(); }
            renamePopup.close(); } }
      }
    }
    onOpened: { rnField.text = (cur() && cur().name) || ""; }
  }

  Popup {
    id: previewPopup; anchors.centerIn: Overlay.overlay; width: 400; height: 300
    modal: true; closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside; padding: 12
    background: Rectangle { radius: 10; color: "#FFF"; border.color: "#E3E3E6" }
    ColumnLayout {
      anchors.fill: parent; spacing: 8
      Text { text: "禁配方案预览"; font.pixelSize: 16; font.bold: true; color: "#333" }
      Rectangle { Layout.fillWidth: true; Layout.fillHeight: true; radius: 6; color: "#FBFAFC"; border.color: "#EFEFF2"
        Text { id: previewText; anchors.fill: parent; anchors.margins: 8; wrapMode: Text.WordWrap
          font.pixelSize: 12; color: "#333"; verticalAlignment: Text.AlignTop; lineHeight: 1.4 } }
      Button { Layout.alignment: Qt.AlignRight; text: "关闭"; Layout.preferredHeight: 30
        contentItem: Text { text: parent.text; color: "#333"; font.pixelSize: 12
          horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
        onClicked: previewPopup.close() }
    }
  }
}
