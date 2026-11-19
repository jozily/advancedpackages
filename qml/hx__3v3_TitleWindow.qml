import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Fk

// 大厅独立称号窗口。由 advancedpackages/init.lua 的 extension.customPages
// 注册到大厅按钮，popup=true 时本组件被塞进大厅抽屉打开（占 80% 宽）。
//
// 协议与 hx__3v3_TitleButton.qml 完全一致，走 LobbyTask("hx_title", ...)：
//   打开 → profile → 服务端回 TitleProfile（core 自带 handler 接住并
//   applyTitleProfile，把 titleServerSupported 置 true）→ 本窗口同时监听
//   commandGot 拿到列表填网格；点选 → equip → 服务端写账号存档再回传刷新。
//
// 专属称号（大梦仙尊/极大梦仙尊/动·大梦仙尊）只对周宣(id=1)下发，
// 其他账号服务端就不发这几项，窗口自然看不到也选不了；但别人仍能在
// 等待室头像看到周宣佩戴的专属（快照全量广播）。
Item {
  id: root
  anchors.fill: parent

  property var titleList: []
  property string currentId: ""
  property string currentTitle: ""
  property bool busy: false
  property int selfId: (typeof Cpp !== "undefined" && Cpp.self) ? Cpp.self.id : -1

  // 与 core applyTitleProfile 一致：CBOR 解出的 titles 可能是 QVariantList，
  // Array.isArray 为 false，做一次 JSON 往返转成真数组。
  function normalizeProfile(data) {
    var p = data;
    if (typeof p === "string") {
      try { p = JSON.parse(p); } catch (e) { return null; }
    }
    if (!p) return null;
    if (p.titles && !Array.isArray(p.titles)) {
      try { p = JSON.parse(JSON.stringify(p)); } catch (e) { return null; }
    }
    if (p.supported !== true || !Array.isArray(p.titles)) return null;
    return p;
  }

  function requestProfile() {
    Cpp.notifyServer("LobbyTask", ["hx_title", JSON.stringify({ op: "profile" })]);
  }

  function equip(id) {
    root.busy = true;
    Cpp.notifyServer("LobbyTask", ["hx_title", JSON.stringify({ op: "equip", id: id })]);
    retryTimer.start();
  }

  Component.onCompleted: Qt.callLater(requestProfile)

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
      var p = root.normalizeProfile(data);
      if (!p) return;
      root.titleList = p.titles;
      var eq = p.equipped || {};
      root.currentId = eq.id || "";
      root.currentTitle = eq.title || "";
    }
  }

  // 居中卡片
  Rectangle {
    anchors.centerIn: parent
    width: Math.min(760, parent.width - 40)
    height: Math.min(560, parent.height - 40)
    radius: 12
    color: "#f7f5fb"
    border { width: 1; color: "#d8d2e6" }

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 24
      spacing: 14

      // 标题 + 关闭
      RowLayout {
        Layout.fillWidth: true
        spacing: 12
        ColumnLayout {
          Layout.fillWidth: true
          spacing: 2
          Text {
            text: "我的称号"
            font { family: root.font.family; pixelSize: 24; bold: true }
            color: "#2b2340"
          }
          Text {
            text: "选择称号后，头像与游戏内会立即显示；他人也能看到。"
            font { family: root.font.family; pixelSize: 13 }
            color: "#7a7390"
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
          }
        }
        Button {
          text: "关闭"
          onClicked: root.finish && root.finish()
        }
      }

      // 当前称号
      Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 56
        radius: 8
        color: "#ece7f7"
        border { width: 1; color: "#cdc2e8" }
        RowLayout {
          anchors.fill: parent
          anchors.margins: 12
          spacing: 10
          Text {
            text: "当前佩戴"
            font { family: root.font.family; pixelSize: 14 }
            color: "#6a6280"
          }
          Text {
            Layout.fillWidth: true
            text: root.currentTitle !== "" ? ("【" + root.currentTitle + "】") : "无（未佩戴）"
            font { family: root.font.family; pixelSize: 17; bold: true }
            color: "#3a2f5c"
            elide: Text.ElideRight
          }
          BusyIndicator {
            visible: root.busy
            running: root.busy
            Layout.preferredWidth: 24
            Layout.preferredHeight: 24
          }
        }
      }

      // 称号网格
      Text {
        text: "可选用称号（点击直接佩戴）"
        font { family: root.font.family; pixelSize: 14; bold: true }
        color: "#4a4260"
      }

      GridView {
        id: grid
        Layout.fillWidth: true
        Layout.fillHeight: true
        cellWidth: 240
        cellHeight: 84
        clip: true
        model: root.titleList

        delegate: Item {
          width: grid.cellWidth - 12
          height: grid.cellHeight - 10

          Rectangle {
            anchors.fill: parent
            radius: 8
            color: modelData.id === root.currentId ? "#d9e9f7" : "#ffffff"
            border {
              width: modelData.id === root.currentId ? 2 : 1
              color: modelData.id === root.currentId ? "#3a86c8" : "#ddd8e8"
            }
            RowLayout {
              anchors.fill: parent
              anchors.margins: 8
              spacing: 10

              Rectangle {
                Layout.preferredWidth: 96
                Layout.preferredHeight: 30
                radius: 4
                color: "#241a42"
                border { width: 1; color: "#b892f0" }
                Text {
                  anchors.centerIn: parent
                  text: modelData.title
                  color: "#ffe9fb"
                  font { family: root.font.family; pixelSize: 12; bold: true }
                  elide: Text.ElideRight
                }
              }

              ColumnLayout {
                Layout.fillWidth: true
                spacing: 3
                Text {
                  text: modelData.title
                  font { family: root.font.family; pixelSize: 13; bold: true }
                  color: "#2b2340"
                  elide: Text.ElideRight
                  Layout.fillWidth: true
                }
                Text {
                  text: modelData.id === root.currentId ? "佩戴中" : "点击佩戴"
                  font { family: root.font.family; pixelSize: 11 }
                  color: modelData.id === root.currentId ? "#3a86c8" : "#8a839c"
                }
              }
            }
            MouseArea {
              anchors.fill: parent
              enabled: !root.busy
              cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
              onClicked: {
                if (modelData.id !== root.currentId) root.equip(modelData.id);
              }
            }
          }
        }
      }

      // 底栏：卸下 + 刷新
      RowLayout {
        Layout.fillWidth: true
        spacing: 12
        Text {
          text: root.titleList.length === 0 && !root.busy
                ? "未读取到称号列表，请确认已连接服务器后点刷新。"
                : ("共 " + root.titleList.length + " 个可用称号")
          font { family: root.font.family; pixelSize: 12 }
          color: "#7a7390"
          Layout.fillWidth: true
          wrapMode: Text.WordWrap
        }
        Button {
          text: "卸下称号"
          enabled: !root.busy && root.currentId !== ""
          onClicked: root.equip("")
        }
        Button {
          text: "刷新"
          enabled: !root.busy
          onClicked: root.requestProfile()
        }
      }
    }
  }
}
