// SPDX-License-Identifier: GPL-3.0-or-later
pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Fk
import Fk.Components.Common
import Fk.Components.GameCommon as Game
import LunarLtk
import LunarLtk.Components
import LunarLtk.Pages.Popups

import "models"

GraphicsBox {
  id: root

  property ChooseGeneralWithCanChangeModel dataModel: chooseGeneralModel

  property alias generalCardList: generalCardList
  property var draggingCard: null
  property bool justClicked: false

  property var generals: dataModel.generals
  property var change: dataModel.change
  property var skills: dataModel.skills
  property int choiceNum: dataModel.choiceNum
  property bool convertDisabled: dataModel.convertDisabled
  property bool cancelable: dataModel.cancelable
  property string skillName: dataModel.skillName
  property string prompt: dataModel.prompt
  property bool detailed: dataModel.detailed
  property string ruleType: dataModel.ruleType
  property var extraData: dataModel.extraData
  property bool hegemony: dataModel.hegemony
  readonly property bool manyChoice: (choiceNum > 4 && generals.length > 8) || generals.length > 12

  // 从8张以上武将牌选4个以上，改为用小头像
  readonly property int cardWidth: manyChoice ? 64 : 93
  readonly property int cardHeight: manyChoice ? 64 : 130
  readonly property int cardGapX: manyChoice ? 12 : 10
  readonly property int cardGapY: manyChoice ? 24 : 30
  readonly property int cardStepX: cardWidth + cardGapX
  readonly property int cardStepY: cardHeight + cardGapY

  // 双禁将·双候选池：前 poolSplit 张来自方案 A，其余来自方案 B。
  // 8 张以内左右并排；超过 8 张（12 人的开局）改成上下两块，每块各自带标题。
  property int poolSplit: dataModel.poolSplit
  property var poolNames: dataModel.poolNames
  readonly property bool hasPools: poolSplit > 0 && poolSplit < generals.length
      && dataModel.poolNameList.length >= 2 && choiceNum >= 2
  readonly property bool multiPoolRows: hasPools && generals.length > 8
  // 每行放几张：沿用旧的多行分栏（ceil(count/2)），12 张即 6 列两行
  readonly property int poolCols: generals.length > 8
      ? Math.ceil(generals.length / 2) : generals.length
  readonly property int poolRowsA: multiPoolRows ? Math.ceil(poolSplit / poolCols) : 1
  readonly property int poolRowsB: multiPoolRows
      ? Math.ceil((generals.length - poolSplit) / poolCols) : 1
  // A 块占的高度（最后一行只算牌高）
  readonly property int poolBlockH: multiPoolRows
      ? (poolRowsA - 1) * cardStepY + cardHeight : 0
  readonly property int poolHeaderH: hasPools ? 24 : 0
  readonly property int poolGap: (hasPools && !multiPoolRows) ? 22 : 0
  // 上下分块时 B 块标题的起始 y。换将按钮挂在牌下方，需要多留一点空隙
  readonly property int poolBlockBY: poolHeaderH + poolBlockH
      + (dataModel.canChangeGeneral ? 28 : 10)

  // 一次选完三组：结果框按「每组 groupSize 张」排开，组间留空并标组名
  property int groupSize: dataModel.groupSize
  readonly property bool groupedResult: groupSize >= 2 && choiceNum > groupSize
  readonly property int groupCount: groupedResult ? Math.ceil(choiceNum / groupSize) : 1
  readonly property int slotGap: manyChoice ? 10 : 20
  readonly property int groupGap: groupedResult ? 28 : 0
  readonly property int resultAreaWidth: {
    if (!groupedResult)
      return choiceNum * cardWidth + Math.max(0, choiceNum - 1) * slotGap;
    return groupCount * (groupSize * cardWidth + (groupSize - 1) * slotGap)
         + (groupCount - 1) * groupGap;
  }

  function groupX(g) {
    return g * (groupSize * cardWidth + (groupSize - 1) * slotGap + groupGap);
  }

  function slotX(i) {
    if (!groupedResult) return i * (cardWidth + slotGap);
    return groupX(Math.floor(i / groupSize)) + (i % groupSize) * (cardWidth + slotGap);
  }

  function groupLabel(g) {
    if (g === 0) return "首发";
    const names = ["一", "二", "三", "四"];
    return "备选" + (names[g - 1] ?? (g + 1));
  }

  // 候选区某一格的坐标。占位方块与卡片都从这里取，避免两处公式各算一套而错位。
  function magnetPos(index) {
    const count = root.dataModel.generals.length;
    if (count <= 0) return { x: 0, y: root.poolHeaderH };

    if (root.multiPoolRows) {
      // 上下分块：每池各自从第一列开始，块内按行铺
      const inA = index < root.poolSplit;
      const local = inA ? index : index - root.poolSplit;
      const row = Math.floor(local / root.poolCols);
      const col = local % root.poolCols;
      return {
        x: col * root.cardStepX,
        y: (inA ? root.poolHeaderH : root.poolBlockBY + root.poolHeaderH)
            + row * root.cardStepY
      };
    }

    let columns = count;
    if (columns > 8) columns = Math.ceil(columns / 2);

    let x = (index % columns) * root.cardStepX;
    if (count > 8 && index > count / 2 && count % 2 === 1)
      x += Math.round(root.cardStepX / 2);
    if (root.hasPools && index >= root.poolSplit)
      x += root.poolGap;
    const y = count <= 8 ? root.poolHeaderH
                         : (index < count / 2 ? 0 : root.cardStepY);
    return { x: x, y: y };
  }

  // 布局是 Column 排的，首次 arrangeCards 可能早于排版完成（读到的 resultArea.y 还是旧值），
  // 卡片就会压在一起。这里在尺寸落定后再排一次。
  Timer {
    id: arrangeTimer
    interval: 0
    repeat: false
    onTriggered: {
      root.arrangeCards();
      if (!root.loggedLayout) {
        root.loggedLayout = true;
        console.log("[hx3v3] choose layout n=" + root.dataModel.generals.length
          + " split=" + root.dataModel.poolSplit
          + " cols=" + root.poolCols
          + " multi=" + root.multiPoolRows
          + " choice=" + root.dataModel.choiceNum
          + " group=" + root.dataModel.groupSize
          + " sel=" + (root.dataModel.result ? root.dataModel.result.length : 0)
          + " slots=" + resultList.count
          + " slotx=" + root.slotX(0) + "," + root.slotX(1)
          + " area=" + Math.round(generalArea.width) + "x" + Math.round(generalArea.height)
          + " res=" + Math.round(resultArea.x) + "," + Math.round(resultArea.y)
          + " popup=" + Math.round(root.width) + "x" + Math.round(root.height));
      }
    }
  }

  property bool loggedLayout: false

  function scheduleArrange() {
    arrangeTimer.restart();
  }

  ChooseGeneralWithCanChangeModel {
    id: chooseGeneralModel
  }

  function loadData(data) {
    root.dataModel.generals = data.generals ?? [];
    root.dataModel.change = data.change ?? [];
    root.dataModel.skills = data.skills ?? [];
    root.dataModel.choiceNum = data.choiceNum ?? 1;
    root.dataModel.convertDisabled = data.convertDisabled ?? false;
    root.dataModel.cancelable = data.cancelable ?? false;
    root.dataModel.skillName = data.skillName ?? "";
    root.dataModel.prompt = data.prompt ?? "";
    root.dataModel.detailed = data.detailed ?? false;
    root.dataModel.ruleType = data.ruleType ?? "";
    root.dataModel.extraData = data.extraData ?? { n: data.choiceNum };
    root.dataModel.hegemony = data.hegemony ?? false;
    root.dataModel.poolSplit = data.poolSplit ?? 0;
    root.dataModel.poolNames = data.poolNames ?? [];
    root.dataModel.groupSize = data.groupSize ?? 0;
    root.dataModel.initGeneralModels();
    root.dataModel.refreshPoolUsed();
    root.loggedLayout = false;
    arrangeCards();
    scheduleArrange();
  }

  function updateData(data) {
    let [type, value] = data;
    value = value ?? "";
    if (type == "select") {
    }
  }

  // 弹窗尺寸/排版变化后再排一次，避免卡片停在按旧尺寸算出的位置上
  onShown: scheduleArrange()
  onWidthChanged: scheduleArrange()
  onHeightChanged: scheduleArrange()
  Component.onCompleted: scheduleArrange()

  Connections {
    target: root.dataModel
    function onGeneralChanged(oldName, newName) {
      for (let i = 0; i < generalCardList.count; i++) {
        const item = generalCardList.itemAt(i);
        if (item.modelData === oldName) {
          item.modelData = newName;
        }
      }
      arrangeCards();
    }
  }

  title.text: dataModel.promptText
      + (hasPools ? ("（两侧各选" + dataModel.poolQuota[0] + "张）") : "")
  width: Math.max(generalArea.width, resultAreaWidth)
         + body.anchors.leftMargin + body.anchors.rightMargin
  height: body.implicitHeight + body.anchors.topMargin + body.anchors.bottomMargin

  Column {
    id: body
    anchors.fill: parent
    anchors.margins: 40
    anchors.bottomMargin: 20

    Item {
      id: generalArea
      // 尺寸直接由各格坐标反推，和卡片/占位块用同一套公式，不会出现算小了压到结果区
      width: {
        const count = root.dataModel.generals.length;
        if (count <= 0) return root.cardWidth;
        let right = 0;
        for (let i = 0; i < count; i++) {
          const mp = root.magnetPos(i);
          right = Math.max(right, mp.x + root.cardWidth);
        }
        return right;
      }
      height: {
        const count = root.dataModel.generals.length;
        if (count <= 0) return root.cardHeight;
        let bottom = root.cardHeight;
        for (let i = 0; i < count; i++) {
          const mp = root.magnetPos(i);
          bottom = Math.max(bottom, mp.y + root.cardHeight);
        }
        // 末尾留出换将按钮与呼吸空间
        return bottom + (root.dataModel.canChangeGeneral ? 28 : 14);
      }
      onWidthChanged: root.scheduleArrange()
      onHeightChanged: root.scheduleArrange()
      z: 1

      // 两池上方各标方案名：单行时左 A 右 B；上下分块时各在自己那块上方。
      // 右侧跟一个「已选/名额」计数
      Text {
        id: poolNameA
        visible: root.hasPools
        x: 2
        y: 0
        width: Math.max(0, (root.multiPoolRows ? root.poolCols : root.poolSplit)
                           * root.cardStepX - 10 - 34)
        height: root.poolHeaderH
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        text: root.hasPools ? ("◆ " + (root.dataModel.poolNameList[0] ?? "")) : ""
        font.family: Config.li2Name
        font.pixelSize: 13
        font.bold: true
        color: "#E8C86A"
      }
      Text {
        visible: root.hasPools
        x: poolNameA.x + poolNameA.width
        y: 0
        width: 34
        height: root.poolHeaderH
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        text: root.dataModel.poolUsedA + "/" + root.dataModel.poolQuota[0]
        font.family: Config.li2Name
        font.pixelSize: 12
        color: root.dataModel.poolUsedA >= root.dataModel.poolQuota[0]
               ? "#79D279" : "#9A9A9A"
      }
      Text {
        id: poolNameB
        visible: root.hasPools
        x: root.multiPoolRows ? 2 : (root.poolSplit * root.cardStepX + root.poolGap + 2)
        y: root.multiPoolRows ? root.poolBlockBY : 0
        width: Math.max(0,
          (root.multiPoolRows ? root.poolCols
                              : (root.dataModel.generals.length - root.poolSplit))
            * root.cardStepX - 10 - 34)
        height: root.poolHeaderH
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        text: root.hasPools ? ("◆ " + (root.dataModel.poolNameList[1] ?? "")) : ""
        font.family: Config.li2Name
        font.pixelSize: 13
        font.bold: true
        color: "#7FC7E8"
      }
      Text {
        visible: root.hasPools
        x: poolNameB.x + poolNameB.width
        y: poolNameB.y
        width: 34
        height: root.poolHeaderH
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        text: root.dataModel.poolUsedB + "/" + root.dataModel.poolQuota[1]
        font.family: Config.li2Name
        font.pixelSize: 12
        color: root.dataModel.poolUsedB >= root.dataModel.poolQuota[1]
               ? "#79D279" : "#9A9A9A"
      }
      // 单行并排时两池之间的竖分隔线；上下分块时靠标题分行，不需要
      Rectangle {
        visible: root.hasPools && !root.multiPoolRows
        x: root.poolSplit * root.cardStepX + root.poolGap / 2 - 1
        y: root.poolHeaderH
        width: 2
        height: root.cardHeight
        radius: 1
        color: "#3A3A3A"
      }

      Repeater {
        id: generalMagnetList
        model: root.dataModel.generals.length

        Item {
          required property int index
          width: root.cardWidth
          height: root.cardHeight
          x: root.magnetPos(index).x
          y: root.magnetPos(index).y
        }
      }
    }

    Item {
      id: splitLine
      width: parent.width - 80
      height: 16
      anchors.horizontalCenter: parent.horizontalCenter
      clip: true

      // 候选区与已选区之间拉一条分隔线，避免选中牌看起来像混在候选里
      Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        height: 1
        color: "#31342B"
      }
    }

    Item {
      width: parent.width
      height: Math.max(root.cardHeight + (root.groupedResult ? 26 : 20),
                       root.manyChoice ? 0 : 165)
      
      // 按钮容器 - 靠近左侧边界
      Item {
        id: buttonContainer
        width: 50
        height: resultArea.height
        anchors.left: parent.left
        anchors.verticalCenter: resultArea.verticalCenter
        anchors.leftMargin: 10
        
        // 隐藏换将按钮
        Rectangle {
          id: hideChangeBtn
          width: 100
          height: 50
          visible: root.dataModel.change && root.dataModel.change.length > 0 && root.dataModel.changeGeneralBtnVisible
          enabled: root.dataModel.change && root.dataModel.change.length > 0 && root.dataModel.changeGeneralBtnVisible
          anchors.centerIn: parent
          radius: 4
          border.width: 1
          border.color: enabled ? (hideChangeBtnMouseArea.containsMouse ? "#ff4444" : "#cc3333") : "#555555"
          color: enabled ? (hideChangeBtnMouseArea.containsMouse ? "#cc3333" : "#aa2222") : "#2D2D2D"
          Text {
            anchors.centerIn: parent
            text: "隐藏换将"
            font.family: Config.li2Name
            font.pixelSize: 14
            font.bold: true
            color: enabled ? "#FFFFFF" : "#888888"
          }
          MouseArea {
            id: hideChangeBtnMouseArea
            anchors.fill: parent
            enabled: hideChangeBtn.enabled
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: hideChangeBtn.enabled
            onClicked: {
              root.dataModel.changeGeneralBtnVisible = false;
            }
          }
        }
        // 显示换将按钮
        Rectangle {
          id: showChangeBtn
          width: 100
          height: 50
          visible: root.dataModel.change && root.dataModel.change.length > 0 && !root.dataModel.changeGeneralBtnVisible
          enabled: root.dataModel.change && root.dataModel.change.length > 0 && !root.dataModel.changeGeneralBtnVisible
          anchors.centerIn: parent
          radius: 4
          border.width: 1
          border.color: enabled ? (showChangeBtnMouseArea.containsMouse ? "#44ff44" : "#33cc33") : "#555555"
          color: enabled ? (showChangeBtnMouseArea.containsMouse ? "#33cc33" : "#22aa22") : "#2D2D2D"
          Text {
            anchors.centerIn: parent
            text: "显示换将"
            font.family: Config.li2Name
            font.pixelSize: 14
            font.bold: true
            color: enabled ? "#FFFFFF" : "#888888"
          }
          MouseArea {
            id: showChangeBtnMouseArea
            anchors.fill: parent
            enabled: showChangeBtn.enabled
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: showChangeBtn.enabled
            onClicked: {
              root.dataModel.changeGeneralBtnVisible = true;
            }
          }
        }
      }

      // 结果框区域：普通情况一排铺开；一次选完三组时按组排开，每组两张并标组名
      Item {
        id: resultArea
        anchors.centerIn: parent
        width: root.resultAreaWidth
        height: root.cardHeight + (root.groupedResult ? 18 : 0)

        Repeater {
          id: resultList
          model: root.dataModel.choiceNum

          Rectangle {
            // Bound 模式下必须显式声明 index，否则 slotX(index) 拿到的是
            // 外层作用域的 index，两个槽位会算到同一坐标叠成一个框。
            required property int index
            color: "#1D1E19"
            radius: 3
            border.width: 1
            border.color: "#3C3F35"
            width: root.cardWidth
            height: root.cardHeight
            x: root.slotX(index)
          }
        }

        Repeater {
          model: root.groupedResult ? root.groupCount : 0

          Text {
            required property int index
            text: root.groupLabel(index)
            x: root.groupX(index)
            y: root.cardHeight + 2
            width: root.groupSize * root.cardWidth + (root.groupSize - 1) * root.slotGap
            horizontalAlignment: Text.AlignHCenter
            font.family: Config.li2Name
            font.pixelSize: 12
            color: index === 0 ? "#E8C86A" : "#9A9A9A"
          }
        }
      }
    }

    Item {
      id: buttonArea
      width: parent.width
      height: 55
      Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        spacing: 10

        Rectangle {
          id: convertBtn
          visible: Lua.client.getSettings("disableSameConvert") ? false : (Lua.client.getSettings("NoSameGeneral") ? false : !root.dataModel.convertDisabled)
          width: 120
          height: 35
          // enabled: root.dataModel.canConvert FIXME: 严肃修复不能点击替换武将的bug

          radius: 6
          border.width: 2
          border.color: enabled ? (convertBtnMouseArea.containsMouse ? "#FF9800" : "#E68900") : "#555555"
          color: enabled ? (convertBtnMouseArea.containsMouse ? "#FF9800" : "#E68900") : "#2D2D2D"

          Text {
            anchors.centerIn: parent
            text: Lua.tr("Same General Convert")
            font.family: Config.li2Name
            font.pixelSize: 15
            font.bold: true
            color: "#FFFFFF"
          }

          MouseArea {
            id: convertBtnMouseArea
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: {
              Ltk.roomScene.showInfoPopup(Qt.createComponent("SameConvert.qml"), { dataModel: root.dataModel });
            }
          }
        }

        Rectangle {
          id: fightButton
          width: 120
          height: 35
          enabled: root.dataModel.feasible
          
          radius: 6
          border.width: 2
          border.color: enabled ? (fightButtonMouseArea.containsMouse ? "#4CAF50" : "#45a049") : "#555555"
          color: enabled ? (fightButtonMouseArea.containsMouse ? "#4CAF50" : "#45a049") : "#2D2D2D"

          Text {
            anchors.centerIn: parent
            text: Lua.tr("OK")
            font.family: Config.li2Name
            font.pixelSize: 16
            font.bold: true
            color: enabled ? "#FFFFFF" : "#888888"
          }

          MouseArea {
            id: fightButtonMouseArea
            anchors.fill: parent
            enabled: fightButton.enabled
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: fightButton.enabled
            onClicked: {
              root.dataModel.accepted();
              close();
              Ltk.roomModel.deActivate();
              ClientInstance.replyToServer("", root.dataModel.result);
            }
          }
        }

        Rectangle {
          id: detailBtn
          width: 120
          height: 35
          enabled: root.dataModel.result.length > 0

          radius: 6
          border.width: 2
          border.color: root.dataModel.result.length > 0 ? (detailBtnMouseArea.containsMouse ? "#2196F3" : "#1976D2") : "#555555"
          color: root.dataModel.result.length > 0 ? (detailBtnMouseArea.containsMouse ? "#2196F3" : "#1976D2") : "#2D2D2D"

          Text {
            anchors.centerIn: parent
            text: Lua.tr("Show General Detail")
            font.family: Config.li2Name
            font.pixelSize: 15
            font.bold: true
            color: root.dataModel.result.length > 0 ? "#FFFFFF" : "#888888"
          }

          MouseArea {
            id: detailBtnMouseArea
            anchors.fill: parent
            enabled: detailBtn.enabled
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: detailBtn.enabled
            onClicked: {
              Ltk.roomScene.showInfoPopup(
                Qt.createComponent("LunarLtk.Pages.InfoPopups", "GeneralDetail"),
                { generals: root.dataModel.result }
              );
            }
          }
        }

        MetroButton {
          id: skdetailBtn
          width: 80
          height: 40
          text: Lua.tr("@hx__1v2_skill")
          visible: Lua.client.getSettings("LuandouMode") ? Lua.client.getSettings("LuandouMode") >= 3 : false
          onClicked: {
            let _skills = [];
            if (root.dataModel.skills.length > 0) {
              _skills = root.dataModel.skills;
            }
            Ltk.roomScene.showInfoPopup(Qt.createComponent("../../utility/qml/SkillDetail.qml"), { skills: _skills });
          }
        }
      }
    }
  }

  // 武将牌
  Component {
    id: generalCardDelegate

    GeneralCardItem {
      required property string modelData
      required property int index
      dataModel: root.dataModel.generalDict[modelData] ?? Ltk.createGeneralCardModel(modelData)

      selectable: {
        // 读一下两池计数：选满一侧后要立即重算可否选（list 本身不带变更通知）
        const _tick = root.dataModel.poolUsedA + root.dataModel.poolUsedB;
        const result = root.dataModel.result;
        if (result) {
          return result.includes(modelData) || root.dataModel.generalFilter(modelData) || false;
        }
        return false;
      }

      draggable: !root.draggingCard || root.draggingCard === this

      onClicked: {
        if (!selectable) return;
        root.justClicked = true;
        root.dataModel.selectGeneralCard(modelData);
        root.arrangeCards();
      }

      onRightClicked: {
        if (root.dataModel.freeAssign) {
          Ltk.roomScene.showInfoPopup(Qt.createComponent("FreeAssign.qml"),
            { dataModel: root.dataModel, oldName: dataModel.name });
        } else {
          Ltk.roomScene.showInfoPopup(
            Qt.createComponent("LunarLtk.Pages.InfoPopups", "GeneralDetail"),
            { generals: [modelData] }
          );
        }
      }

      opacity: dragging ? 0.5 : 1
      onDraggingChanged: {
        if (dragging) root.draggingCard = this;
      }
      onXChanged: {
        if (!dragging) return;
        root.arrangeCards();
      }
      onYChanged: {
        if (!dragging) return;
        root.arrangeCards();
      }
      onReleased: {
        if (!root.justClicked) {
          root.updateCardDragging(this);
        }
        root.justClicked = false;
        root.draggingCard = null;
        root.arrangeCards();
      }

      // 换将按钮
      Rectangle {
        id: changeGeneralBtn
        anchors.top: parent.bottom
        anchors.horizontalCenter: parent.center
        width: 93
        height: 24
        visible: root.dataModel.changeGeneralBtnVisible && root.dataModel.canChangeGeneral && !root.dataModel.result.includes(modelData)
        enabled: root.dataModel.canChangeGeneral

        radius: 4
        border.width: 1
        border.color: enabled ? (changeGeneralBtnMouseArea.containsMouse ? "#ffd700" : "#fff28e") : "#d84e4e"
        color: enabled ? (changeGeneralBtnMouseArea.containsMouse ? "#3D3D3D" : "#2D2D2D") : "#1A1A1A"

        Text {
          anchors.centerIn: parent
          text: Lua.tr("Change General").arg(root.dataModel.change.length)
          font.family: Config.li2Name
          font.pixelSize: 15
          font.bold: true
          color: enabled ? (changeGeneralBtnMouseArea.containsMouse ? "#FFFFFF" : "#F5E6D3") : "#666666"
        }

        MouseArea {
          id: changeGeneralBtnMouseArea
          anchors.fill: parent
          enabled: changeGeneralBtn.enabled
          cursorShape: Qt.PointingHandCursor
          hoverEnabled: changeGeneralBtn.enabled
          onClicked: {
            if (root.dataModel.change && root.dataModel.change.length > 0) {
              const newGeneral = root.dataModel.change[0];
              root.dataModel.changeGeneralCard(modelData, newGeneral);
            }
          }
        }
      }
    }
  }

  // 头像
  Component {
    id: avatarCardDelegate

    CompactGeneralCardItem {
      id: avatarCard
      width: root.cardWidth
      height: root.cardHeight
      clip: false

      required property string modelData
      required property int index
      dataModel: root.dataModel.generalDict[modelData] ?? Ltk.createGeneralCardModel(modelData)

      selectable: {
        // 读一下两池计数：选满一侧后要立即重算可否选（list 本身不带变更通知）
        const _tick = root.dataModel.poolUsedA + root.dataModel.poolUsedB;
        const result = root.dataModel.result;
        if (result) {
          return result.includes(modelData) || root.dataModel.generalFilter(modelData) || false;
        }
        return false;
      }

      draggable: !root.draggingCard || root.draggingCard === this

      // 不可选时压暗
      Rectangle {
        visible: !avatarCard.selectable
        anchors.fill: parent
        color: Qt.rgba(0, 0, 0, 0.5)
      }

      onClicked: {
        if (!selectable) return;
        root.justClicked = true;
        root.dataModel.selectGeneralCard(modelData);
        root.arrangeCards();
      }

      onRightClicked: {
        if (root.dataModel.freeAssign) {
          Ltk.roomScene.showInfoPopup(Qt.createComponent("FreeAssign.qml"),
            { dataModel: root.dataModel, oldName: dataModel.name });
        } else {
          Ltk.roomScene.showInfoPopup(
            Qt.createComponent("LunarLtk.Pages.InfoPopups", "GeneralDetail"),
            { generals: [modelData] }
          );
        }
      }

      opacity: dragging ? 0.5 : 1
      onDraggingChanged: {
        if (dragging) root.draggingCard = this;
      }
      onXChanged: {
        if (!dragging) return;
        root.arrangeCards();
      }
      onYChanged: {
        if (!dragging) return;
        root.arrangeCards();
      }
      onReleased: {
        if (!root.justClicked) {
          root.updateCardDragging(this);
        }
        root.justClicked = false;
        root.draggingCard = null;
        root.arrangeCards();
      }

      // 换将按钮
      Rectangle {
        id: changeGeneralBtn
        anchors.top: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: root.cardWidth
        height: 20
        visible: root.dataModel.changeGeneralBtnVisible && root.dataModel.canChangeGeneral && !root.dataModel.result.includes(modelData)
        enabled: root.dataModel.canChangeGeneral

        radius: 4
        border.width: 1
        border.color: enabled ? (changeGeneralBtnMouseArea.containsMouse ? "#ffd700" : "#fff28e") : "#d84e4e"
        color: enabled ? (changeGeneralBtnMouseArea.containsMouse ? "#3D3D3D" : "#2D2D2D") : "#1A1A1A"

        Text {
          anchors.centerIn: parent
          text: Lua.tr("Change General").arg(root.dataModel.change.length)
          font.family: Config.li2Name
          font.pixelSize: 11
          font.bold: true
          color: enabled ? (changeGeneralBtnMouseArea.containsMouse ? "#FFFFFF" : "#F5E6D3") : "#666666"
        }

        MouseArea {
          id: changeGeneralBtnMouseArea
          anchors.fill: parent
          enabled: changeGeneralBtn.enabled
          cursorShape: Qt.PointingHandCursor
          hoverEnabled: changeGeneralBtn.enabled
          onClicked: {
            if (root.dataModel.change && root.dataModel.change.length > 0) {
              const newGeneral = root.dataModel.change[0];
              root.dataModel.changeGeneralCard(modelData, newGeneral);
            }
          }
        }
      }
    }
  }

  Repeater {
    id: generalCardList
    model: root.dataModel.generals
    delegate: root.manyChoice ? avatarCardDelegate : generalCardDelegate
  }

  function updateCardDragging(item) {
    const name = item.dataModel.name;
    if (!item.selectable) {
      root.dataModel.moveGeneral(name, false);
      return;
    }

    let i, pos, itemdiff;
    let diff = 17308, idx = -1;
    for (i = 0; i < root.dataModel.choiceNum; i++) {
      pos = root.mapFromItem(resultArea, root.slotX(i), 0);
      itemdiff = Math.max(Math.abs(pos.x - item.x), Math.abs(pos.y - item.y));
      if (itemdiff < diff) {
        diff = itemdiff;
        idx = i;
      }
    }
    if (idx !== -1 && diff < (root.manyChoice ? 30 : 50)) {
      root.dataModel.moveGeneral(name, true, idx);
    } else {
      root.dataModel.moveGeneral(name, false);
    }
  }

  function arrangeCards() {
    if (!root.dataModel) return;
    let item, pos, i;
    const list = root.dataModel.result ?? [];

    for (i = 0; i < generalCardList.count; i++) {
      item = generalCardList.itemAt(i);
      if (!item) break;
      if (item.dragging) {
        item.z = 999;
        continue;
      }

      const resultIdx = list.findIndex(e => e === item.dataModel.name);
      if (resultIdx !== -1 && root.dataModel.choiceNum > 0) {
        // 已选中的武将：直接按结果格的坐标算，不再去读格子 item
        // （格子可能还没排版完成，读到的 y 是旧值，卡片就会压到候选区上）
        const slot = Math.min(resultIdx, root.dataModel.choiceNum - 1);
        pos = root.mapFromItem(resultArea, root.slotX(slot), 0);
      } else {
        // 未选中的武将，移动到候选区的第 i 格
        const mp = root.magnetPos(i);
        pos = root.mapFromItem(generalArea, mp.x, mp.y);
      }
      item.origX = pos.x;
      item.origY = pos.y;
      item.goBack(true);
    }

    setHegemonyData();
  }

  function updateCompanion(gcard1, gcard2, overwrite) {
    if (Ltk.isCompanionWith(gcard1.modelData, gcard2.modelData)) {
      gcard1.dataModel.hasCompanion = true;
    } else if (overwrite) {
      gcard1.dataModel.hasCompanion = false;
    }
  }

  function setHegemonyData() {
    if (!root.dataModel || !root.dataModel.hegemony) return;

    let item, i;

    const result = root.dataModel.result ?? [];
    const selectedItems = result.slice(0, 2).map(name => {
      for (let j = 0; j < generalCardList.count; j++) {
        const card = generalCardList.itemAt(j);
        if (card.modelData === name) return card;
      }
      return null;
    });

    // 主副将认定
    for (i = 0; i < generalCardList.count; i++) {
      item = generalCardList.itemAt(i);
      item.dataModel.inPosition = 0;
    }
    if (selectedItems[0]) {
      if (selectedItems[0].dataModel.mainMaxHp !== 0) {
        selectedItems[0].dataModel.inPosition = 1;
      } else if (selectedItems[0].dataModel.deputyMaxHp !== 0) {
        selectedItems[0].dataModel.inPosition = -1;
      }
      if (selectedItems[1]) {
        if (selectedItems[1].dataModel.mainMaxHp !== 0) {
          selectedItems[1].dataModel.inPosition = -1;
        } else if (selectedItems[1].dataModel.deputyMaxHp !== 0) {
          selectedItems[1].dataModel.inPosition = 1;
        }
      }
    }

    // 珠联璧合
    for (i = 0; i < generalCardList.count; i++) {
      item = generalCardList.itemAt(i);

      if (selectedItems[0]) {
        if (selectedItems[1]) {
          if (selectedItems[0] === item) {
            updateCompanion(item, selectedItems[1], true);
          } else if (selectedItems[1] === item) {
            updateCompanion(item, selectedItems[0], true);
          } else {
            item.dataModel.hasCompanion = false;
          }
        } else {
          if (selectedItems[0] !== item) {
            updateCompanion(item, selectedItems[0], true);
          } else {
            for (let j = 0; j < generalCardList.count; j++) {
              updateCompanion(item, generalCardList.itemAt(j), false);
            }
          }
        }
      } else {
        for (let j = 0; j < generalCardList.count; j++) {
          updateCompanion(item, generalCardList.itemAt(j), false);
        }
      }
    }
  }

}