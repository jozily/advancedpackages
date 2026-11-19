import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Fk

// 官方 player titles 的客户端入口（不依赖 asio 的 PlayerTitles 特性）。
// 由 advancedpackages/rules/hx__3v3_extra_rules.lua 注入到血战附加规则设置组。
//
// 原理：asio 0.1.17 不认 GetTitleProfile/UpdateTitle，也不下发 PlayerTitles
// 特性，所以 core 的原生"更换称号"按钮是灰的。这里改走白名单内的 LobbyTask：
//   进入组件 → 发 LobbyTask("hx_title", {op:"profile"}) →
//   服务端回传 TitleProfile（core 的 Mediator 自带 handler 会接住并执行
//   applyTitleProfile，其中把 titleServerSupported 置为 true，提示消失、
//   称号列表就绪）→ 本组件同时监听 commandGot 拿到同一份数据填下拉。
//   玩家选称号 → 发 LobbyTask("hx_title", {op:"equip", id:...}) →
//   服务端写账号存档后再回传 TitleProfile 刷新。
Item {
  id: root

  // 这两个属性由 LuaSettingsPage.buildComponent 作为初始属性传入（title 已翻译）。
  // 必须显式声明，否则 createObject 赋值时找不到属性，整项可能显示异常。
  property string title: "我的称号"
  property string subTitle: ""
  property var titleList: []
  property string currentId: ""
  property string currentTitle: ""
  property bool busy: false

  implicitHeight: Math.max(60, titleCol.implicitHeight + 16)

  RowLayout {
    anchors.fill: parent
    anchors.leftMargin: 16
    anchors.rightMargin: 16
    spacing: 12

    ColumnLayout {
      id: titleCol
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignVCenter
      spacing: 2

      Text {
        text: root.title
        font { family: root.font.family; pixelSize: 17; bold: true }
        opacity: enabled ? 1.0 : 0.3
        elide: Text.ElideRight
        Layout.fillWidth: true
      }
      Text {
        text: "当前：" + (root.currentTitle !== "" ? ("【" + root.currentTitle + "】") : "无")
        color: "grey"
        font { family: root.font.family; pixelSize: 13 }
        wrapMode: Text.WordWrap
        lineHeight: 0.95
        Layout.fillWidth: true
      }
      Text {
        text: root.subTitle
        color: "grey"
        font { family: root.font.family; pixelSize: 11 }
        wrapMode: Text.WordWrap
        lineHeight: 0.95
        visible: root.subTitle !== ""
        Layout.fillWidth: true
      }
    }

    Button {
      id: pickBtn
      Layout.alignment: Qt.AlignVCenter
      text: root.busy ? "读取中…" : "更换称号"
      enabled: !root.busy
      onClicked: titleMenu.open()

      Menu {
        id: titleMenu
        y: pickBtn.height
        MenuItem { text: "（不佩戴称号）"; onTriggered: root.equip("") }
        Repeater {
          model: root.titleList
          MenuItem {
            text: "【" + modelData.title + "】"
            onTriggered: root.equip(modelData.id)
          }
        }
      }
    }
  }

  function requestProfile() {
    var payload = JSON.stringify({ op: "profile" });
    Cpp.notifyServer("LobbyTask", ["hx_title", payload]);
  }

  function equip(id) {
    root.busy = true;
    var payload = JSON.stringify({ op: "equip", id: id });
    Cpp.notifyServer("LobbyTask", ["hx_title", payload]);
    retryTimer.start();
  }

  Component.onCompleted: {
    Qt.callLater(requestProfile);
  }

  Timer {
    id: retryTimer
    interval: 8000
    repeat: false
    onTriggered: {
      if (root.busy) {
        root.busy = false;
        App.showToast("称号更新超时，请重试");
      }
    }
  }

  Connections {
    target: Mediator
    function onCommandGot(sender, command, data) {
      if (command !== "TitleProfile") return;
      retryTimer.stop();
      root.busy = false;
      var p = data;
      if (typeof p === "string") {
        try { p = JSON.parse(p); } catch (e) { p = null; }
      }
      if (!p) return;
      // CBOR 解出的 titles 可能是 QVariantList（Array.isArray 为 false），
      // 与 core 的 applyTitleProfile 同样做一次 JSON 往返转成真数组。
      if (p.titles && !Array.isArray(p.titles)) {
        try { p = JSON.parse(JSON.stringify(p)); } catch (e) { return; }
      }
      if (p.supported !== true || !Array.isArray(p.titles)) return;

      root.titleList = p.titles;
      var eq = p.equipped || {};
      root.currentId = eq.id || "";
      root.currentTitle = eq.title || "";
      console.log("[hxTitle] profile titles=", p.titles.length, "equipped=", root.currentTitle);
    }
  }
}
