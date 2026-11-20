// SPDX-License-Identifier: GPL-3.0-or-later
// 本局已禁配：把每对禁配武将画成一张双将牌（左主将、右副将）。
// 由 @[hxpair]& 自定义 mark 的 spec.qml 加载，prop.pairs = [[A,B], ...]
pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import Fk
import Fk.Components.Common
import LunarLtk
import LunarLtk.Components

Item {
  id: root
  anchors.fill: parent   // 必须铺满 PopupItem 的 container，否则根节点 0x0 → 内容全空白

  property var pairs: []
  property string pairsFlat: ""   // "A,B;C,D"：每对逗号、对间分号，最可靠的字符串通道
  property string name: ""

  readonly property real cardScale: 1.5
  readonly property real cardW: 93 * cardScale
  readonly property real cardH: 130 * cardScale
  readonly property real gap: 16

  // Lua table 桥接成 QVariantList：Array.isArray 不可靠，先归一
  function seq(v) {
    if (v === undefined || v === null) return [];
    if (typeof v === "string") return v === "" ? [] : [v];
    const out = [];
    try {
      for (let i = 0; i < v.length; ++i) out.push(v[i]);
    } catch (e) { return []; }
    return out;
  }

  // 每对可能是数组 [A,B]，也可能被桥接成 "A,B" 字符串，统一拆两份
  function pairOf(x) {
    if (typeof x === "string") {
      const p = x.split(",").map(function(s){ return s.trim(); }).filter(function(s){ return s !== ""; });
      return [p[0] || "", p[1] || ""];
    }
    const a = root.seq(x);
    return [a[0] || "", a[1] || ""];
  }

  readonly property var rows: {
    const out = [];
    if (root.pairsFlat && root.pairsFlat !== "") {
      const pairs = root.pairsFlat.split(";").filter(function(x){ return x !== ""; });
      for (let i = 0; i < pairs.length; ++i) {
        const g = pairs[i].split(",").map(function(x){ return x.trim(); });
        if ((g[0] && g[0] !== "") || (g[1] && g[1] !== "")) out.push([g[0] || "", g[1] || ""]);
      }
      return out;
    }
    const raw = root.seq(root.pairs);
    for (let i = 0; i < raw.length; ++i) {
      const pr = root.pairOf(raw[i]);
      if (pr[0] !== "" || pr[1] !== "") out.push(pr);
    }
    return out;
  }

  component PairCard: Item {
    id: cardRoot
    required property var pair
    readonly property string mainName: pair[0] || ""
    readonly property string deputyName: pair[1] || ""

    width: root.cardW
    height: root.cardH

    function showDetail() {
      if (mainName === "") return;
      Ltk.roomScene.showInfoPopup(
        Qt.createComponent("LunarLtk.Pages.InfoPopups", "GeneralDetail"),
        { generals: deputyName === "" ? [mainName] : [mainName, deputyName] });
    }

    Rectangle { id: artMask; anchors.fill: parent; radius: 4 * root.cardScale; visible: false }

    Item {
      id: artLayer
      anchors.fill: parent
      visible: false
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

    OpacityMask { anchors.fill: artMask; source: artLayer; maskSource: artMask }

    Image {
      anchors.fill: parent
      visible: cardRoot.deputyName !== ""
      fillMode: Image.PreserveAspectCrop
      smooth: true
      source: SkinBank.photoDir + "deputy-split"
    }

    Image {
      anchors.fill: parent
      anchors.margins: -1 * root.cardScale
      fillMode: Image.PreserveAspectFit
      source: SkinBank.generalCardDir + "border"
    }

    Image {
      x: -1 * root.cardScale; y: -1 * root.cardScale
      width: 22 * root.cardScale
      fillMode: Image.PreserveAspectFit
      source: {
        let k = "";
        try { k = Ltk.getGeneralData(cardRoot.mainName).kingdom ?? ""; } catch (e) {}
        return k === "" ? "" : (SkinBank.getGeneralCardDir(k) + k);
      }
    }

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

    MouseArea {
      anchors.fill: parent
      hoverEnabled: true
      cursorShape: Qt.PointingHandCursor
      onClicked: cardRoot.showDetail()
    }
  }

  // 顶部大字标题：浮层实现，绝不改动 Flickable 的 anchors.fill
  Text {
    z: 2
    anchors.top: parent.top
    anchors.topMargin: 6
    anchors.horizontalCenter: parent.horizontalCenter
    text: "本局已禁配"
    color: "#ffe08a"
    font.pixelSize: 26
    font.bold: true
  }

  Flickable {
    anchors.fill: parent
    contentWidth: grid.width
    contentHeight: grid.y + grid.height + 8
    clip: true
    Grid {
      id: grid
      x: Math.max(0, (parent.width - grid.width) / 2)
      y: 40
      columns: Math.max(1, Math.min(5, root.rows.length))
      spacing: root.gap
      Repeater {
        model: root.rows.length
        PairCard { required property int index; pair: root.rows[index] }
      }
    }
  }
}
