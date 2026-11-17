// advancedpackages 提供的 Avatar.qml 克隆（分支自 freekill-core）。
// 目标：头像优先取当前选中皮肤的图，跟随“开启皮肤替换原画”功能。
// 官方 core 的 Avatar.qml 零改动；本文件由 addQmlImportPath 注册后生效。
import QtQuick

import Fk
import LunarLtk

Image {
  id: root

  width: 64
  height: 64

  // 当前武将选中的皮肤名（Config.enabledSkins: 武将id -> 皮肤名）
  property string skinName: (typeof Config !== "undefined" && Config.enabledSkins
                             && Config.enabledSkins[general])
                            ? Config.enabledSkins[general] : ""
  // 皮肤的完整图片路径；普通图片皮肤有值，骨骼皮肤/未选皮肤返回空串
  property string skinPath: skinName ? Ltk.getFullSkinPath(general, skinName) : ""

  // 取图顺序：皮肤图 -> 专门的头像小图 -> 武将主图
  source: (skinPath !== "" ? skinPath
                           : SkinBank.getGeneralExtraPic(general, "avatar/"))
          ?? SkinBank.getGeneralPicture(general)

  // 只有走主图兜底时才按标准立绘裁头部；皮肤图与 avatar 小图已是头像比例
  sourceClipRect: (!skinPath && !useSmallPic) ? Qt.rect(61, 20, 128, 128) : undefined
  clip: true

  property string general
  property string pkgName: {
    const splited = general.split('__')[0];
    if (splited == general) return "";
    return splited;
  }
  property bool useSmallPic: !!SkinBank.getGeneralExtraPic(general, "avatar/")
  property bool detailed: false

  Rectangle {
    visible: root.detailed && root.pkgName !== ""
    anchors.top: parent.top
    anchors.left: parent.left
    height: 16
    width: childrenRect.width + 4
    color: "#3C3229"
    opacity: 0.8

    Text {
      text: Lua.tr(root.pkgName)
      x: 2; y: 1
      font.family: Config.libianName
      font.pixelSize: 14
      color: "white"
      style: Text.Outline
      textFormat: Text.RichText
    }
  }

  Rectangle {
    visible: root.detailed
    anchors.bottom: parent.bottom
    anchors.right: parent.right
    height: 16
    width: childrenRect.width + 4
    color: "snow"
    opacity: 0.8

    Text {
      text: Lua.tr(root.general)
      x: 2; y: 1
      font.family: Config.libianName
      font.pixelSize: 14
      color: "black"
      style: Text.Outline
      textFormat: Text.RichText
    }
  }

  Rectangle {
    anchors.fill: parent
    color: "transparent"
    border.width: 1
  }
}
