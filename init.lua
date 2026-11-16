-- advancedpackages 顶层增强包入口（可整体删除）。
-- 删除本目录后：血战恢复原版行为，称号与精选原画一并消失，血战本体零改动。

local packs = {}

-- 1) 称号外观包（返回 Package，交给 ModManager install）
local ok_titles, titles = pcall(require, "packages.advancedpackages.fengsui_titles.init")
if ok_titles and titles then packs[#packs + 1] = titles end

-- 2) 精选原画皮肤包（SkinPack，与 lunarltk_skins 同机制）
--    图片仍在原资源目录，本包只按武将注册皮肤。
local ok_skins, skins = pcall(require, "packages.advancedpackages.skins")
if ok_skins and skins then packs[#packs + 1] = skins end

-- 3) 血战附加规则：纯自包含补丁，require 即自执行 hook
--    （自带 hxfs hook、QML 重定向、设置项开关，均走 latePatches 延迟到运行期）
--    它返回的技能骨架不交给 install，避免被误当 Package。
pcall(require, "packages.advancedpackages.rules.hx__3v3_extra_rules")

return packs
