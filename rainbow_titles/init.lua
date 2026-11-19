-- 自用称号包。开启客户端本地称号模式：
-- 服务端 asio 0.1.17 不提供 PlayerTitles 特性，官方 Release 到顶。
-- 称号的拥有/装备全部从本包样式表读取，联机也走本地档案，不依赖服务端协议。
local extension = Package:new("rainbow_titles", Package.SkinPack)
extension.extensionName = "rainbow_titles"

Fk.title_styles = Fk.title_styles or {}
for id, style in pairs(require "packages.advancedpackages.rainbow_titles.styles") do
  Fk.title_styles[id] = style
end

-- 联机称号走本地档案；关闭 test_console 分支以免加载缺失的 TitlePreview.qml。
Fk.title_test_enabled = false
Fk.title_local_enabled = true

return extension
