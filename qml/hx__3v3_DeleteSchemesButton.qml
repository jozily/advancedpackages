import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import Fk
import Fk.Widgets as W

// 一键删除本地禁将方案按钮。
// 由 advancedpackages/rules/hx__3v3_extra_rules.lua 注入到血战附加规则设置组，
// 紧挨在「更新默认禁将方案」下面。只删【玩家自己客户端】的方案，
// 不动服务端全服云端存档；范围以用户确认为准。
// 左侧说明文字 + 右侧独立按钮，只有点按钮本身才触发，避免整行误触。
Item {
  id: root

  property string title: ""
  property string subTitle: ""

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
        font {
          family: root.font.family
          pixelSize: 17
          bold: true
        }
        elide: Text.ElideRight
        Layout.fillWidth: true
      }
      Text {
        text: root.subTitle
        visible: root.subTitle !== ""
        font {
          family: root.font.family
          pixelSize: 13
        }
        color: "grey"
        wrapMode: Text.WordWrap
        lineHeight: 0.95
        Layout.fillWidth: true
      }
    }

    Button {
      Layout.alignment: Qt.AlignVCenter
      text: "删除全部"
      onClicked: confirmDialog.open()
    }
  }

  MessageDialog {
    id: confirmDialog
    title: "删除本地禁将方案"
    informativeText: "确定删除本机全部禁将方案吗？此操作只影响本客户端，不会删除云端方案。"
    buttons: MessageDialog.Ok | MessageDialog.Cancel
    onButtonClicked: function (button) {
      if (button === MessageDialog.Ok) {
        root.doDelete();
      }
      confirmDialog.close();
    }
  }

  // 清空本地方案：保留一个空方案占位，避免禁将下拉/双禁将读到零长度列表出错。
  // currentDisableIdx 与 curScheme 一并复位，再写盘。
  function doDelete() {
    var blank = { name: "", banPkg: [], normalPkg: [], banCardPkg: [] };
    Config.disableSchemes = [blank];
    Config.currentDisableIdx = 0;
    Config.curScheme = blank;
    Config.saveConf();
    App.showToast("本地禁将方案已删除");
  }
}
