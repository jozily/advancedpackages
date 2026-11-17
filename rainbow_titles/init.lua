-- 自用称号包。开启客户端本地称号模式：
-- 服务端 asio 0.1.17 不提供 PlayerTitles 特性，官方也无更高版本，
-- 因此改用 TitleBank 的本地测试模式，称号的拥有/装备全部从本包样式表读取，
-- 无需服务端支持，也不改任何 core 文件。
local extension = Package:new("rainbow_titles", Package.SkinPack)
extension.extensionName = "rainbow_titles"

Fk.title_styles = Fk.title_styles or {}
for id, style in pairs(require "packages.advancedpackages.rainbow_titles.styles") do
  Fk.title_styles[id] = style
end

-- 打开本地称号模式（TitleBank.refresh() 读取该全局）
Fk.title_test_enabled = true

return extension
