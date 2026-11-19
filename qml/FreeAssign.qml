// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Fk
import LunarLtk
import LunarLtk.Components
import LunarLtk.Pages.Popups

import "models"

Item {
  id: root
  anchors.fill: parent
  property var generalModel

  required property ChooseGeneralWithCanChangeModel dataModel
  property string oldName

  signal finish()

  ToolBar {
    id: bar
    width: parent.width
    RowLayout {
      anchors.fill: parent
      ToolButton {
        opacity: stack.depth > 1 ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 100 } }
        text: Lua.tr("Back")
        onClicked: stack.pop()
      }

      Label {
        text: Lua.tr("Enable free assign")
        elide: Label.ElideRight
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
        Layout.fillWidth: true
      }

      TextField {
        id: word
        placeholderText: "Search..."
        clip: true
        verticalAlignment: Qt.AlignVCenter
        background: Rectangle {
          implicitHeight: 16
          implicitWidth: 120
          color: "transparent"
        }
        focus: true
        onEditingFinished: {
          if (text !== "") {
            if (stack.depth > 1) stack.pop();
            generalModel = Ltk.searchAllGenerals(word.text);
            const onlyEnable = Lua.client.getSettings('OnlyEnableGeneral');
            if (onlyEnable) {
              const disabledGenerals = Lua.client.disabled_generals;
              const disabledPack = Lua.client.disabled_packs;
              generalModel = generalModel.filter(general => {
                const generalExists = Ltk.getGeneral(general);
                if (!generalExists) return false;
                
                const packageName = Ltk.getGeneral(general).package.name;
                const isPackDisabled = disabledPack && disabledPack.includes ? disabledPack.includes(packageName) : false;
                const isHidden = Ltk.getGeneral(general).hidden;
                const isDisabled = disabledGenerals && disabledGenerals.includes ? disabledGenerals.includes(general) : false;
                return !isPackDisabled && !isHidden && !isDisabled;
              });
            }
            stack.push(generalList);
            word.text = "";
          }
        }
      }

      ToolButton {
        text: Lua.tr("Search")
        enabled: word.text !== ""
        onClicked: {
          if (stack.depth > 1) stack.pop();
          generalModel = Ltk.searchAllGenerals(word.text);
          const onlyEnable = Lua.client.getSettings('OnlyEnableGeneral');
          if (onlyEnable) {
            const disabledGenerals = Lua.client.disabled_generals;
            const disabledPack = Lua.client.disabled_packs;
            generalModel = generalModel.filter(general => {
              const generalExists = Ltk.getGeneral(general);
              if (!generalExists) return false;

              const packageName = Ltk.getGeneral(general).package.name;
              const isPackDisabled = disabledPack && disabledPack.includes ? disabledPack.includes(packageName) : false;
              const isHidden = Ltk.getGeneral(general).hidden;
              const isDisabled = disabledGenerals && disabledGenerals.includes ? disabledGenerals.includes(general) : false;
              return !isPackDisabled && !isHidden && !isDisabled;
            });
          }
          stack.push(generalList);
          word.text = "";
        }
      }
    }
  }

  StackView {
    id: stack
    width: parent.width
    height: parent.height - bar.height
    anchors.top: bar.bottom
    initialItem: pkgList
  }

  ListModel {
    id: packages
  }

  Component {
    id: pkgList
    GridView {
      id: listView
      width: parent.width
      height: stack.height
      ScrollBar.vertical: ScrollBar {}
      model: packages
      clip: true
      cellWidth: width / 5
      cellHeight: 40

      delegate: ItemDelegate {
        width: listView.width / 5
        height: 40

        Text {
          text: Lua.tr(name)
          color: "#E4D5A0"
          anchors.centerIn: parent
        }

        onClicked: {
          const packName = packages.get(index).name;
          generalModel = Ltk.getGenerals(packName);
          const onlyEnable = Lua.client.getSettings('OnlyEnableGeneral');

          if (onlyEnable) {
            const disabledGenerals = Lua.client.disabled_generals;
            generalModel = generalModel.filter(general => {
              const isHidden = Ltk.getGeneral(general).hidden;
              const isDisabled = disabledGenerals && disabledGenerals.includes ? disabledGenerals.includes(general) : false;
              return !isHidden && !isDisabled;
            });
          }
          stack.push(generalList);
        }
      }
    }
  }

  Component {
    id: generalList
    ColumnLayout {
      clip: true
      width: stack.width
      height: stack.height
      Item { height: 6 }
      GridView {
        clip: true
        Layout.preferredWidth: stack.width - stack.width % 100 + 10
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignHCenter
        model: generalModel
        ScrollBar.vertical: ScrollBar {}

        cellHeight: 140
        cellWidth: 100

        delegate: GeneralCardItem {
          required property string modelData
          autoBack: false
          dataModel: Ltk.createGeneralCardModel(modelData)
          onClicked: {
            stack.pop();
            root.dataModel.changeGeneral(root.oldName, dataModel);
            root.finish();
          }
        }
      }
    }
  }

  function load() {
    packages.clear();

    const packs = Ltk.getAllGeneralPack();
    const onlyEnable = Lua.client.getSettings('OnlyEnableGeneral');

    const disabledGenerals = Lua.client.disabled_generals;
    const disabledPack = Lua.client.disabled_packs;

    packs.forEach((name) => {
      if (onlyEnable && disabledPack && disabledPack.includes && disabledPack.includes(name)) {
        return;
      }

      const gens = Ltk.getGenerals(name);
      if (gens && gens.length > 0) {
        if (!onlyEnable) {
          packages.append({ name: name });
        } else {
          const availableGenerals = gens.filter(general => {
            const isHidden = Ltk.getGeneral(general).hidden;
            const isDisabled = disabledGenerals && disabledGenerals.includes ? disabledGenerals.includes(general) : false;
            return !isHidden && !isDisabled;
          });

          if (availableGenerals.length > 0) {
            packages.append({ name: name });
          }
        }
      }
    });
  }

  Component.onCompleted: {
    load();
  }
}