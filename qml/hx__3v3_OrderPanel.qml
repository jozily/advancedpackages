// 血战「主帅排将」出场顺序排序弹窗——双将牌展示样式版。
// 替换 bloodybattle/qml/3v3Box.qml（由 extra_rules 包装 Request.setData 换地址）：
// 相邻两张将（主＋副）合成一张双将牌，左右各半张立绘、中间金线、顶部黑条体力，
// 与选将/弃将界面的 hx__3v3_PairPanel 同一套牌面。点两张牌交换的是「整组」
// （组内主副顺序不变），符合双将成组出场的实际语义。
// 回传契约与原版一致：确认回传排序后的扁平将名数组，取消回传空串。
pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import Fk
import Fk.Components.Common
import LunarLtk
import LunarLtk.Components
import LunarLtk.Pages.Popups

GraphicsBox {
    id: root

    property var generals: []
    property int selectedPair: -1   // 当前选中的组序号（每张双将牌 = 一组）

    // QVariantList 归一：桥接形态可能是 count/get 访问器而非下标数组
    function seq(v) {
        if (v === undefined || v === null || typeof v === "string") return [];
        const ret = [];
        if (Array.isArray(v)) {
            for (let i = 0; i < v.length; ++i) ret.push(v[i]);
            return ret;
        }
        if (typeof v !== "object") return ret;
        if (typeof v.count === "number" && typeof v.get === "function") {
            for (let i = 0; i < v.count; ++i) ret.push(v.get(i));
            return ret;
        }
        const n = (typeof v.length === "number") ? v.length : 0;
        for (let i = 0; i < n; ++i) ret.push(v[i]);
        if (ret.length > 0) return ret;
        const keys = Object.keys(v).filter(k => /^\d+$/.test(k)).sort((a, b) => Number(a) - Number(b));
        for (const k of keys) ret.push(v[k]);
        return ret;
    }

    // 相邻两张一组（双将选将时主副相邻）；落单的一张自成一组的半张牌
    function pairsOf(v) {
        const arr = seq(v);
        const ret = [];
        for (let i = 0; i < arr.length; i += 2) ret.push(arr.slice(i, i + 2));
        return ret;
    }

    Component.onCompleted: {
        root.generals = root.seq(generals).slice();
    }

    readonly property var pairs: root.pairsOf(root.generals)
    readonly property bool dualMode: root.pairs.length > 0
      && root.pairs.every(p => p.length === 2)

    readonly property real cardScale: 1.5
    readonly property real cardW: 93 * cardScale
    readonly property real cardH: 130 * cardScale
    readonly property real gap: 18

    readonly property int count: root.pairs.length
    readonly property int cols: count <= 4 ? Math.max(1, count) : 4
    readonly property int rows: Math.max(1, Math.ceil(count / Math.max(1, cols)))

    title.text: Lua.tr("#hx__3v3_choose_generals")
    width: cols * cardW + (cols - 1) * gap + 100
    height: rows * cardH + (rows - 1) * gap + 150

    function kingdomOf(g) {
        if (!g) return "";
        try { return Ltk.getGeneralData(g).kingdom ?? ""; }
        catch (e) { return ""; }
    }

    function gDataOf(g) {
        if (!g) return null;
        try { return Ltk.getGeneralData(g); }
        catch (e) { return null; }
    }

    function hpOf(g) {
        const d = gDataOf(g);
        return d ? (d.maxHp ?? d.hp ?? 0) : 0;
    }

    function magatamaOf(g) {
        const k = kingdomOf(g);
        return k === "" ? "" : (SkinBank.getGeneralCardDir(k) + k + "-magatama");
    }

    // 点击一张牌：第一次选中，第二次连同整组换位，再点同一张取消
    function pickPair(idx) {
        if (root.selectedPair === -1) {
            root.selectedPair = idx;
        } else if (root.selectedPair === idx) {
            root.selectedPair = -1;
        } else {
            const a = root.selectedPair, b = idx;
            const pa = root.pairs[a], pb = root.pairs[b];
            if (pa && pa.length === 2 && pb && pb.length === 2) {
                const arr = root.seq(root.generals).slice();
                const ia = a * 2, ib = b * 2;
                const tmp = [arr[ia], arr[ia + 1]];
                arr[ia] = arr[ib];
                arr[ia + 1] = arr[ib + 1];
                arr[ib] = tmp[0];
                arr[ib + 1] = tmp[1];
                root.generals = arr;
            }
            root.selectedPair = -1;
        }
    }

    // 一组主副将合成一张牌（与 PairPanel 的 PairCard 同款牌面）
    component PairCard: Item {
        id: cardRoot
        required property var pair
        property bool selected: false   // 由 delegate 从外部传入，组件内不碰 index
        signal toggled()

        width: 93 * root.cardScale
        height: 130 * root.cardScale

        readonly property string mainName: (pair && pair.length > 0) ? pair[0] : ""
        readonly property string deputyName: (pair && pair.length > 1) ? pair[1] : ""
        readonly property int mainHp: root.hpOf(mainName)
        readonly property int deputyHp: root.hpOf(deputyName)
        readonly property int mergedHp: deputyName === ""
          ? mainHp : Math.floor((mainHp + deputyHp) / 2)

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

        OpacityMask {
            anchors.fill: artMask
            source: artLayer
            maskSource: artMask
        }

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
                const k = root.kingdomOf(cardRoot.mainName);
                return k === "" ? "" : (SkinBank.getGeneralCardDir(k) + k);
            }
        }

        Rectangle {
            id: hpBar
            x: 22 * root.cardScale
            y: 2 * root.cardScale
            width: cardRoot.width - 24 * root.cardScale
            height: 13 * root.cardScale
            radius: 3 * root.cardScale
            color: "#B3000000"
            visible: cardRoot.mainName !== "" && cardRoot.mergedHp > 0

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

        Rectangle {
            anchors.fill: parent
            anchors.margins: 1
            radius: 5
            color: "transparent"
            border.width: 3
            border.color: cardRoot.selected ? "#4CAF50"
              : (hoverArea.containsMouse ? "#C8A96E" : "transparent")
        }

        Rectangle {
            anchors.fill: parent
            radius: 4
            color: cardRoot.selected ? "#4C4CAF50" : "transparent"
        }

        MouseArea {
            id: hoverArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            property bool held: false
            onPressed: held = false
            onPressAndHold: {
                held = true;
                cardRoot.showDetail();
            }
            onClicked: {
                if (held) return;
                cardRoot.toggled();
            }
        }
    }

    Item {
        id: cardArea
        x: (root.width - (root.cols * root.cardW + (root.cols - 1) * root.gap)) / 2
        y: 40
        width: root.cols * root.cardW + (root.cols - 1) * root.gap
        height: root.rows * root.cardH + (root.rows - 1) * root.gap

        Grid {
            anchors.fill: parent
            columns: root.cols
            spacing: root.gap

            Repeater {
                model: root.pairs.length

                PairCard {
                    required property int index
                    pair: root.pairs[index]
                    selected: root.selectedPair === index
                    onToggled: root.pickPair(index)
                }
            }
        }
    }

    Item {
        id: buttonArea
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12
        width: 320
        height: 40

        Row {
            anchors.fill: parent
            spacing: 8

            MetroButton {
                width: 150
                height: 40
                text: Lua.tr("OK")
                onClicked: {
                    close();
                    Ltk.roomModel.deActivate();
                    ClientInstance.replyToServer("", root.generals);
                }
            }

            MetroButton {
                width: 150
                height: 40
                text: Lua.tr("Cancel")
                onClicked: {
                    root.close();
                    Ltk.roomModel.deActivate();
                    ClientInstance.replyToServer("", "");
                }
            }
        }
    }
}
