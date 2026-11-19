-- advancedpackages 顶层增强包入口（可整体删除）。
-- 删除本目录后：血战恢复原版行为，称号与精选原画一并消失，血战本体零改动。

local packs = {}

-- 1) 称号外观包（返回 Package，交给 ModManager install）
--    包名为 rainbow_titles，避免与 fengsui 自带的 fengsui_titles 冲突
local ok_titles, titles = pcall(require, "packages.advancedpackages.rainbow_titles.init")
if ok_titles and titles then
  -- 大厅独立称号窗口：customPages 是官方扩展注册大厅按钮的接口（见
  -- freekill-core/standard/init.lua、delight）。popup=true 时按钮点击会把
  -- 下面的 QML 塞进大厅抽屉打开，不必再钻进血战房间设置。
  titles.customPages = {
    {
      name = "我的称号",
      iconUrl = "packages/advancedpackages/rainbow_titles/images/rainbow_banner.png",
      popup = true,
      qml = {
        url = "packages/advancedpackages/qml/hx__3v3_TitleWindow.qml",
      },
    },
  }
  packs[#packs + 1] = titles
end

-- 2) 精选原画皮肤已拆分为独立包 rainbow_skins，本包不再注册皮肤。

-- 3) 阴阳鱼技能包：走官方 loadSkillSkelsByPath → Package:install 正规登记，
--    让客户端与服务端的 Fk.skills 都稳定有 "yinyangfish_skill&"（含正确的
--    package.extensionName）。角色下方那枚可点击小鱼图标只认这个名字，
--    且由客户端本机 Fk.skills 生成 SkillModel，必须在客户端也注册成功。
local ok_yy, yyPack = pcall(function()
  local extension = Package:new("hx_yinyang", Package.SpecialPack)
  extension:loadSkillSkelsByPath("./packages/advancedpackages/rules/skills")
  return extension
end)
if ok_yy and yyPack then packs[#packs + 1] = yyPack end

-- 4) 血战附加规则：纯自包含补丁，require 即自执行 hook
--    （自带 hxfs hook、QML 重定向、设置项开关，均走 latePatches 延迟到运行期）
pcall(require, "packages.advancedpackages.rules.hx__3v3_extra_rules")

return packs
