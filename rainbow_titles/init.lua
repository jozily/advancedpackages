-- 自用称号包。拥有、装备与权限由服务端 asio 管理，本包只提供定义与外观。
local extension = Package:new("rainbow_titles", Package.SkinPack)
extension.extensionName = "rainbow_titles"

Fk.title_styles = Fk.title_styles or {}
for id, style in pairs(require "packages.advancedpackages.rainbow_titles.styles") do
  Fk.title_styles[id] = style
end

return extension
