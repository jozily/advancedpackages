-- SPDX-License-Identifier: GPL-3.0-or-later
--[[
  血战3v3 阴阳鱼技能骨架。

  单独成文件是为了走官方的 loadSkillSkelsByPath → Package:install 正规登记：
  这样客户端进程和服务端进程都会在包加载期把 "yinyangfish_skill&" 注册进
  Fk.skills，并自动补上正确的 package.extensionName。

  角色下方那枚可点击的小鱼图标（SpecialMarkSkillArea.qml）只认
  origName === "yinyangfish_skill&" 的 SkillModel；该 SkillModel 由客户端
  Ltk.getSkillData 读【客户端本机】Fk.skills 生成。之前技能只在规则文件顶层
  手动 createSkill + addSkill，依赖 fk 子项就绪的时机，客户端常常注册失败，
  于是服务端能加技能、技能栏有图标，角色下方却画不出鱼图标。改走正规骨架后
  两端一致。

  技能效果与国战 yinyangfish_skill& 完全一致：
    出牌阶段弃一枚「阴阳鱼」摸一张；弃牌阶段开始弃一枚，本回合手牌上限 +2。
]]
local YINYANG_SKILL = "yinyangfish_skill&"
local YINYANG_MARK = "@!!yinyangfish"

local yinyangSkill = fk.CreateSkill { name = YINYANG_SKILL }

-- 与国战 HegUtil.removeHegMark 一致：用掉最后一枚 mark 时把隐藏技能一起摘掉。
local function removeYinyangIfEmpty(room, player)
  if player:getMark(YINYANG_MARK) <= 0 and type(room.handleAddLoseSkills) == "function" then
    pcall(room.handleAddLoseSkills, room, player, "-" .. YINYANG_SKILL, nil, false)
  end
end

yinyangSkill:addEffect("active", {
  prompt = "#hx__3v3_yinyang_skill",
  anim_type = "drawcard",
  can_use = function(self, player)
    return player:getMark(YINYANG_MARK) > 0
  end,
  card_filter = Util.FalseFunc,
  target_num = 0,
  on_use = function(self, room, effect)
    local player = effect.from
    room:removePlayerMark(player, YINYANG_MARK, 1)
    player:drawCards(1, YINYANG_SKILL)
    removeYinyangIfEmpty(room, player)
  end,
})

yinyangSkill:addEffect(fk.EventPhaseStart, {
  priority = 0.1,
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player.phase == Player.Discard
      and player:getMark(YINYANG_MARK) > 0
      and player:getHandcardNum() > player:getMaxCards()
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = YINYANG_SKILL,
      prompt = "#hx__3v3_yinyang_max",
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:removePlayerMark(player, YINYANG_MARK, 1)
    room:addPlayerMark(target, MarkEnum.AddMaxCardsInTurn, 2)
    room:broadcastProperty(player, "MaxCards")
    removeYinyangIfEmpty(room, player)
  end,
})

Fk:loadTranslationTable{
  ["yinyangfish_skill&"] = "阴阳鱼",
  ["#hx__3v3_yinyang_skill"] = "你可弃一枚「阴阳鱼」，摸一张牌",
  ["#hx__3v3_yinyang_max"] = "你可弃一枚「阴阳鱼」，此回合手牌上限 +2",
  [":yinyangfish_skill&"] = "出牌阶段，你可弃一枚「阴阳鱼」，摸一张牌；弃牌阶段开始时，你可弃一枚「阴阳鱼」，此回合手牌上限 +2。",
  ["@!!yinyangfish"] = "阴阳鱼",
  [":@!!yinyangfish"] = "出牌阶段，你可弃一枚「阴阳鱼」，摸一张牌；弃牌阶段开始时，你可弃一枚「阴阳鱼」，此回合手牌上限 +2。",
}

return yinyangSkill
