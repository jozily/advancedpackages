-- SPDX-License-Identifier: GPL-3.0-or-later
--[[
  血战3v3 附加规则（全部集中在本文件）

  纯新增补丁文件，不修改 bloodybattle 内任何原有 lua/qml。
  规则逻辑全部在本文件；双将牌的界面是另一个新增文件
  qml/hx__3v3_PairPanel.qml，备选池展示与弃置弹窗共用它，
  靠 prop.dialog 区分（false 铺满宿主，true 自带外框）。原有文件一行未动。
  init.lua 第 5 行 loadSkillSkelsByPath 会自动扫描 rule_skills 目录并 require
  本文件，因此无需改动 init.lua 即可生效。

  所有功能挂在同一个总开关下：「特色双将模式」。
  总开关关闭时，本文件的全部附加规则不生效，原版行为与其他设置不受影响。
  总开关本身要求先开启房间设置里的「Enable deputy general（副将机制）」，
  否则在设置页常驻灰化；总开关以下的子项同样只在总开关开启时可点。

  一、奇数体力值补偿
      双将体力上限与当前体力统一取两将体力合计的向下取整值，
      修掉「三血配四血」时体力牌多出的空格，以及换将后 hp 与 maxHp 不一致。
      合计为奇数（舍去半点体力）时按设置补偿：护甲一枚或
      阴阳鱼一枚（出牌阶段弃一枚摸一张；弃牌阶段开始弃一枚，本回合手牌上限 +2）。

  二、双将固定组合
      选将时记下每名玩家自己排定的主副将组合（第 1、2 张为第一组，
      第 3、4 张为第二组，依此类推）。阵亡换将时，把该玩家自己尚未登场的
      下一组提到本方备选池最前，由原换将流程照常取用。

  三、换将时清理旧将残留状态（子开关，默认开）
      换将复用同一个玩家对象，旧将本回合攒下的技能使用次数、临时标记、
      回合末回调（如穿屋的技能加回）会残留到新将身上，造成胆守计数偏大、
      新将回合末又拿回旧技能等问题。开启后，换将完成即只清理该玩家自己的
      这些残留状态，不动给其他角色挂的效果；关掉则走官方流程。

  四、自己的回合内阵亡则跳过本回合（子开关，默认关）
      换将完成后结束当前阶段与当前回合。实现方式是在阶段、回合事件的数据上
      打「到此为止」标记，不调用 breakTurn，因此正在结算的伤害事件（包括
      铁索连环的后续传导）仍会完整走完，新将也不会补触发当前阶段技能。

  五、乐不思蜀：数量与改版效果
      1) 牌堆中乐不思蜀保留 3 / 2 / 1 / 0 张（默认 3 张）；
         多出来的不进入本局牌堆，改为花色点数相同的【兵粮寸断】。
      2) 改版效果三选一，顶替原「判定不为红桃则跳过出牌阶段」：
         上限+2 / 英姿 / 自守。与本包「应用村规卡牌」互斥，村规优先。

  六、特色双将模式
      每名玩家依次选三组武将（共六张），第一组登场，其余两组进入备选池；
      选将结束时由主帅从备选池统一弃置两组（四张）。

  七、血战比赛规则（子开关，默认关）
      关：击杀对方三组备选、留一组即胜（六分口径）；
      开：必须击杀对方全部备选才胜（全歼口径）。

  八、双禁将方案（子开关，默认关）
      除禁将页面当前选中的那套方案之外，再把指定的第二套方案的禁将并进本房间。
      方案只存在房主本机，所以房主进房时由客户端把它送到服务器，
      服务端收下后写进 room.disabled_generals / disabled_packs，
      官方过滤环节自动生效，连远程服务器建房也能用，且不改动任何原有文件。

  八之一、选将分两个候选池（双禁将的子开关，默认关）
      开启后第二套方案不再并进房间，而是在选将时单独成一个候选池：
      候选区左半来自方案 A（当前方案），右半来自方案 B（第二套方案），
      两池上方各标方案名。玩家仍在两池合起来的候选里选定张数。

  注意：本文件的 require 返回值必须是「技能骨架」或 false。
  loadSkillSkelsByPath 会把返回值当技能骨架登记，返回 true/nil 都会让它
  把布尔值当骨架用而报错，所以末尾写成 return 骨架 or false。
]]

local MODE_NAME = "hx__3v3_mode"

-- 设置键
-- 总开关：特色双将模式。关掉它，本文件所有附加功能一律不生效
local SETTING_MASTER = "3v3signatureDeputy"
-- 子项：奇数体力值补偿（护甲 / 阴阳鱼）
local SETTING_ODD = "hx3v3oddComp"
local SETTING_ENDTURN = "hx3v3endTurnOnDeath"
-- 子项：换将时清理旧将残留状态（技能使用次数、临时标记、回合末回调），默认开
local SETTING_SWAPFIX = "hx3v3swapSkillFix"
-- 子项：一次性选完三组（只弹一次框，一次选六张，结果区直接分三组）
local SETTING_ONESHOT = "hx3v3oneShotGroups"
local SETTING_FULLWIN = "hx3v3competitionFullWin"
local SETTING_DOUBLEBAN = "hx3v3doubleBan"
-- 子项：双禁将时要并进来的第二套方案（1 起算，对应禁将页面的第 N 套）
local SETTING_BANSCHEME = "hx3v3doubleBanScheme"
-- 子项：两个候选池（选将时把两套方案的可用将分成两池，各标方案名）
local SETTING_DUALPOOL = "hx3v3dualPool"
-- 子项：本局全体禁将（独立开关，放在总控之前，单双将都生效）
-- 开启后所有人选将前先从候选里禁 1-4 名（双将按「组」禁），汇总为全局禁用
local SETTING_GLOBALBAN = "hx3v3globalBan"
-- 子项：本局每人禁将数量（ComboRow，值 1-4；双将下表示禁几组）
local SETTING_GLOBALBANCOUNT = "hx3v3globalBanCount"
-- 子项：双将禁配（放在总控之后）。房主用禁配方案把武将两两配对标号，
-- 同号两将不得组成一组双将；双候选池下 A/B 各出一将组成一组。
local SETTING_NOPAIR = "hx3v3noPair"
-- 子项：禁配方案选择（1 起算，对应禁配方案列表第 N 套）
local SETTING_PAIRSCHEME = "hx3v3pairScheme"
local SETTING_COUNT = "hxIndulgenceCount"
local SETTING_EFFECT = "hxIndulgenceEffect"
-- 借刀杀人牌名字数：默认 4 字（不和谐），开启后 2 字（OL 和谐口径）。
-- 与双将无关、全模式通用，放在总开关之上，不设 enabled 门槛。
local SETTING_JIEDAO = "hxJiedaoNameLen"
-- 旧键：仅用于读回老存档，统一折算到 SETTING_ODD
local SETTING_ARMOR_OLD = "3v3deputyExtraArmor"

-- 每名玩家自己的主副将组合表，键为玩家 id，值为 { {主将, 副将}, ... }
-- 只用服务端读取，不必下发客户端：带 @ 前缀的 banner 会被客户端 qml_mark
-- 当作私人标记渲染，而本表没有 players 字段，会在 qml_mark.lua:75 报错
local PAIR_BANNER = "hx__3v3_own_pairs"

-- 换将水位线：换将时记下当时的事件 id，getEventsOfScope 用它排除换将前
-- 「以该玩家为目标」的旧事件，让胆守这类按本回合目标次数计数的技能重新累计
local SWAP_WATERMARK = "__hx_swap_watermark"

-- 改版乐不思蜀
local SKILL_NAME = "hx__3v3_indulgence_skill"
local MARK_MAXHP = "__hx_indulgence_maxhp-turn"
local MARK_SELF = "__hx_indulgence_self-turn"

-- 数量选项：值 - 要减去（移除）的张数。不同牌堆乐不思蜀总数不一样
-- （比赛牌堆 2 张、混装牌堆 5 张），按「减几张」配置；减的数量超过牌堆
-- 存量时按存量全减。
local COUNT_KEYS = {
  hx_indulgence_count_3 = 3,
  hx_indulgence_count_2 = 2,
  hx_indulgence_count_1 = 1,
  hx_indulgence_count_0 = 0,
}

-- 效果选项：值 - 命中后生效的规则
local EFFECT_KEYS = {
  hx_indulgence_effect_maxcards2 = "maxcards2",
  hx_indulgence_effect_maxhp = "maxhp",
  hx_indulgence_effect_self = "self",
}

-- 补偿方式选项：W.ComboRow 存的是翻译键本身（TranslatedComboRow 里
-- value = model[currentIndex]），不是 off/armor/yinyang 这种短名，
-- 所以取值时先折一次，否则永远判定成 off
local ODD_COMP_KEYS = {
  hx_odd_comp_off = "off",
  hx_odd_comp_armor = "armor",
  hx_odd_comp_yinyang = "yinyang",
}

local function normCompKind(v)
  if type(v) ~= "string" then return nil end
  local kind = ODD_COMP_KEYS[v]
  if kind then return kind end
  if v == "off" or v == "armor" or v == "yinyang" then return v end
  return nil
end

-- 双禁将的「第二套」直接用房主自己的禁将方案：选项就是他的方案列表，
-- 文字就是方案自己起的名字（没起名的显示「方案 N」）。
-- 方案名只有客户端知道（客户端全局 Config.disableSchemes）。
-- model/value 在客户端 Lua VM 求值，渲染期读全局 Config 拿真实方案。
-- 不再硬编码「第 1 套…第 8 套」8 个空占位：下拉只列房主真实存在的方案。
local BAN_SCHEME_MAX = 30 -- 防止畸形配置刷爆下拉，正常按实际方案数
local BAN_SCHEME_KEYS = {}
for i = 1, BAN_SCHEME_MAX do
  BAN_SCHEME_KEYS["hx_ban_scheme_" .. i] = i
end
-- 没选过时按第 2 套算：第 1 套通常正是当前方案
local DEFAULT_BAN_SCHEME_KEY = "hx_ban_scheme_2"

-- 初始为空，渲染期由 refreshBanSchemeModel 填入真实方案；
-- 读不到配置时保持空，绝不退回 8 个占位（用户明确要求删掉它们）。
local BAN_SCHEME_MODEL = {}
local BAN_SCHEME_LABELS = {}

-- 房主本机禁将方案的中转槽：大厅 LobbyTask 收到后按玩家 id 存这里，
-- 房间内的 applyDoubleBan / 双候选池按房主 id 读。
-- asio 是单进程单 VM，模块级 table 跨大厅与房间线程共享，按 id 隔离不串数据。
-- 这是替代被禁用的 hx_ban_scheme 命令（该命令会踢线）的传输方式。
local HX_PLAYER_BAN_SCHEMES = {}
-- 大厅 TaskPlayer.id 与房间内 serverPlayer.id 不是同一个域，按 id 存/读会对不上
-- （日志里 push pid=4 成功，applyDoubleBan 按 owner.id 读却落空）。
-- 因此额外按昵称索引，并留一份「最近推送槽」兜底：房间里通常只有房主一人
-- 推方案，取最近那份最稳。三者都存，读取端依次回退。
local HX_PLAYER_BAN_BY_NAME = {}
local HX_LAST_PUSHED_SCHEMES = nil

-- 双将禁配：房主本机禁配方案的中转槽，机制同禁将方案（LobbyTask 推送，
-- 按玩家 id / 昵称 / 最近推送三路索引）。每套方案形如：
--   { name = "方案名", pairs = { { "将A", "将B" }, ... } }
-- 每一对就是一个标号（pairs 下标 1 起：第一对=1号，第二对=2号…），
-- 同对两将不得组成一组双将。
local HX_PLAYER_PAIR_SCHEMES = {}
local HX_PLAYER_PAIR_BY_NAME = {}
local HX_LAST_PUSHED_PAIRS = nil
-- 禁配方案云端存档 key（与禁将方案分开，互不干扰）
local PAIR_SYNC_SAVE_KEY = "hx_pair_schemes_v1_20261120"

-- 本局全体禁将：全局禁用表记在房间 banner 上，选将过滤钩子从这里读。
-- 值形如 { [玩家id] = { 将名/组... } }，最终并成 room.disabled_generals。
local GLOBAL_BAN_BANNER = "hx__3v3_global_ban"

-- 本局禁配：当前生效禁配方案的 pairs 广播到房间 banner，客户端备选面板
-- 据此显示「本局已禁配」。值形如 { pairs = {{g1,g2},...}, dual = bool }。
local GLOBAL_PAIR_BANNER = "hx__3v3_global_pair"

-- 读取本机禁将方案。
-- 关键：model/value 函数在【客户端】Lua VM 求值（GetUIDataOfSettings →
-- W.toQmlData 的 v(settings)）。客户端进程在 freekill.lua 启动时就把配置文件的
-- 全文解进全局 Config（含 disableSchemes），这是最可靠的数据源。
-- 之前用 io.open 相对路径读文件，受沙箱（assert(not f:startsWith(".."))）和
-- 渲染期 CWD 影响，常读不到 → 下拉退回硬编码的 8 项占位，方案名全丢。
local function readBanConfSchemes()
  local conf = rawget(_G, "Config")
  if type(conf) == "table" and type(conf.disableSchemes) == "table" then
    return conf.disableSchemes
  end
  -- 服务端求值侧（或全局 Config 未就绪）才退回读文件
  local okOpen, f = pcall(io.open, "freekill.client.config.json", "r")
  if okOpen and f then
    local okRead, text = pcall(f.read, f, "a")
    f:close()
    if okRead and type(text) == "string" then
      local okDecode, d = pcall(json.decode, text)
      if okDecode and type(d) == "table" and type(d.disableSchemes) == "table" then
        return d.disableSchemes
      end
    end
  end
  return nil
end

-- 列出房主真实存在的方案，并按方案名改写 hx_ban_scheme_N 的翻译；
-- ComboBox 的显示文本就是 Lua.tr(键)，所以把真实名字注入翻译表即可。
local function refreshBanSchemeModel()
  local schemes = readBanConfSchemes()
  if type(schemes) ~= "table" then return false end
  local n = #schemes
  if n <= 0 then return false end
  if n > BAN_SCHEME_MAX then n = BAN_SCHEME_MAX end

  local model, labels = {}, {}
  for i = 1, n do
    local key = "hx_ban_scheme_" .. i
    model[i] = key
    local name = type(schemes[i]) == "table" and schemes[i].name or ""
    if type(name) ~= "string" then name = "" end
    name = name:gsub("^%s+", ""):gsub("%s+$", "")
    labels[key] = (name ~= "") and name or ("方案 " .. i)
  end
  BAN_SCHEME_MODEL = model
  BAN_SCHEME_LABELS = labels
  -- 客户端渲染期把真实名字注入翻译表，Lua.tr(key) 就能显示方案名
  if type(Fk) == "table" and type(Fk.loadTranslationTable) == "function" and next(labels) then
    pcall(Fk.loadTranslationTable, Fk, labels)
  end
  return true
end
pcall(refreshBanSchemeModel)

-- 禁配方案：读取本机 Config.pairSchemes（与禁将方案 disableSchemes 平行），
-- 用同一套「渲染期读全局 Config」的办法拿真实方案名填入下拉。
local PAIR_SCHEME_MAX = 30
local PAIR_SCHEME_MODEL = {}
local PAIR_SCHEME_LABELS = {}
local DEFAULT_PAIR_SCHEME_KEY = "hx_pair_scheme_1"

local function readPairConfSchemes()
  local conf = rawget(_G, "Config")
  if type(conf) == "table" then
    if type(conf.pairSchemes) == "table" then return conf.pairSchemes end
    -- QML 侧把禁配方案存在 Config.conf.pairSchemes 里（saveConf 会整体写盘）
    if type(conf.conf) == "table" and type(conf.conf.pairSchemes) == "table" then
      return conf.conf.pairSchemes
    end
  end
  local okOpen, f = pcall(io.open, "freekill.client.config.json", "r")
  if okOpen and f then
    local okRead, text = pcall(f.read, f, "a")
    f:close()
    if okRead and type(text) == "string" then
      local okDecode, d = pcall(json.decode, text)
      if okDecode and type(d) == "table" and type(d.pairSchemes) == "table" then
        return d.pairSchemes
      end
    end
  end
  return nil
end

local function refreshPairSchemeModel()
  local schemes = readPairConfSchemes()
  if type(schemes) ~= "table" then return false end
  local n = math.min(#schemes, PAIR_SCHEME_MAX)
  if n <= 0 then
    -- 保底留一项：ComboBox 的 model 为空会进入 currentIndex=-1 的异常态，
    -- 展开后关不掉、点不到，还会把紧邻的「奇数体力值补偿」行挤到重叠。
    PAIR_SCHEME_MODEL = { "hx_pair_scheme_1" }
    PAIR_SCHEME_LABELS = { ["hx_pair_scheme_1"] = "禁配方案 1" }
    return false
  end
  local model, labels = {}, {}
  for i = 1, n do
    local key = "hx_pair_scheme_" .. i
    model[i] = key
    local s = schemes[i]
    local name = type(s) == "table" and s.name or ""
    if type(name) ~= "string" then name = "" end
    name = name:gsub("^%s+", ""):gsub("%s+$", "")
    labels[key] = (name ~= "") and name or ("禁配方案 " .. i)
  end
  PAIR_SCHEME_MODEL = model
  PAIR_SCHEME_LABELS = labels
  if type(Fk) == "table" and type(Fk.loadTranslationTable) == "function" and next(labels) then
    pcall(Fk.loadTranslationTable, Fk, labels)
  end
  return true
end
pcall(refreshPairSchemeModel)

local function isModeRoom(room)
  if not room or type(room.getSettings) ~= "function" then return false end
  return room:getSettings("gameMode") == MODE_NAME
end

local function isDeputyRoom(room)
  if not isModeRoom(room) then return false end
  if room:getSettings(SETTING_MASTER) ~= true then return false end
  return room:getSettings("enableDeputy") and not room:getSettings("3v3anjiang")
end

local function getEffectKind(room)
  return EFFECT_KEYS[room:getSettings(SETTING_EFFECT)]
end

-- 本文件在包加载阶段执行，比 lua/server/scheduler.lua 早，
-- 那时 Request、qml_mark 都还没就绪，包装不能当场做完。
-- 这里登记若干「等运行期再补」的包装，房间第一次读设置时逐个尝试。
local latePatches = {}
local latePatchDone = false

-- 日志：服务端走 fk.qInfo，客户端没有它，同时打一份 print，
-- 这样两端都能在日志里留痕，方便确认补丁到底装到了哪个进程
local function hxlog(msg)
  local line = "[hx3v3] " .. tostring(msg)
  pcall(function() fk.qInfo(line) end)
  pcall(print, line)
end

-- 兼容修复：个别入口会在房间 settings 初始化之前读 getSettings，
-- 官方 core 的实现直接对 nil 索引，报 roombase.lua:87
-- "attempt to index a nil value (local 't')"。这里包一层守卫：
-- settings 还不是 table 时返回 nil，不改官方文件本身。
local function patchGetSettingsGuard()
  -- RoomBase 的类名是 "Base.RoomBase"，不会挂到 _G.RoomBase 上；
  -- 它登记在 Fk.Base.RoomBase（ModManager:initialize 里 require 的表）。
  -- 依次尝试注册表、require、全局，三处都拿不到才返回 false 等下一轮重试。
  local RB
  if type(Fk) == "table" and type(Fk.Base) == "table" then
    RB = Fk.Base.RoomBase
  end
  if type(RB) ~= "table" then
    local ok, m = pcall(require, "core.roombase")
    if ok and type(m) == "table" then RB = m end
  end
  if type(RB) ~= "table" then RB = rawget(_G, "RoomBase") end
  if type(RB) ~= "table" or type(RB.getSettings) ~= "function" then
    return false
  end
  if RB.__hx_getsettings_guard then return true end
  local origGet = RB.getSettings
  RB.getSettings = function(self, key)
    if type(rawget(self, "settings")) ~= "table" then return nil end
    return origGet(self, key)
  end
  RB.__hx_getsettings_guard = true
  hxlog("getSettings nil-guard installed")
  return true
end
patchGetSettingsGuard()
latePatches[#latePatches + 1] = patchGetSettingsGuard

----------------------------------------------------------------------
-- 借刀杀人牌名字数：默认 4 字（不和谐），开启后 2 字（OL 和谐口径）。
-- 全模式通用，不依赖 isModeRoom，与双将无关。
----------------------------------------------------------------------
-- getNameLength 是 Card 的全局方法、调用时没有 room 参数，统一从当前房间
-- 读设置；服务端判定技能时必定有 currentRoom，读不到时按默认 4 字处理。
local function jiedaoTwoChars()
  -- 服务端：技能判定场景必有 currentRoom
  local ok, room = pcall(function() return Fk:currentRoom() end)
  if ok and room and type(room.getSettings) == "function" then
    local ok2, v = pcall(room.getSettings, room, SETTING_JIEDAO)
    if ok2 then return v == true end
  end
  -- 客户端：本机读同一房间的设置，保证 UI 预览与服务端判定一致
  local ok3, v = pcall(function()
    if type(ClientInstance) == "table" and type(ClientInstance.getSettings) == "function" then
      return ClientInstance:getSettings(SETTING_JIEDAO)
    end
  end)
  if ok3 then return v == true end
  return false
end

-- 官方无参调用本来就是 4 字；天宗包几十个技能用 getNameLength(true) 传 true，
-- 这里把 true 解释成「按本局开关取字数」：开关开 → 2，关 → 4。
-- 这样默认与官方一致，开启后天宗技能与 ol 包技能口径统一。
local function patchJiedaoNameLen()
  local CardCls = rawget(_G, "Card")
  if type(CardCls) ~= "table" or type(CardCls.getNameLength) ~= "function" then
    return false
  end
  if CardCls.__hx_jiedao_namelen_patched then return true end
  local orig = CardCls.getNameLength
  CardCls.__hx_jiedao_namelen_patched = true
  CardCls.getNameLength = function(self, ol_rule)
    if self and self.trueName == "collateral" then
      return jiedaoTwoChars() and 2 or 4
    end
    return orig(self, ol_rule)
  end
  return true
end
latePatches[#latePatches + 1] = patchJiedaoNameLen
pcall(patchJiedaoNameLen)

-- 每个补丁在「已装好」或「本次装上」时返回真，未就绪返回假；
-- 全部就绪后不再重复尝试，getSettings 上只剩一次布尔判断的开销
local function tryLatePatches()
  if latePatchDone then return end
  local allOk = true
  for _, fn in ipairs(latePatches) do
    local ok, ret = pcall(fn)
    if not ok or not ret then allOk = false end
  end
  latePatchDone = allOk
end

----------------------------------------------------------------------
-- 一、房间设置项：借模式注册的时机把设置追加进 ui_settings
----------------------------------------------------------------------
-- 血战包原先把主帅称作「队长」，且弃置备选武将的文案与成组界面不符。
-- 模式文件在本文件之后加载，翻译需要在其后覆盖一次，故留出独立入口。
local LATE_TRANSLATION = {
  -- 文案保持中性：关掉双将后官方单将流程也用这句，不能再写「每组两张」。
  -- 双将成组界面自己按 num 显示「已选 N / num」，不依赖这里的括注。
  ["#HX3v3_AskForThrowGeneral_tips"] = "请主帅弃置 %arg 张备选武将",
  ["HX3v3_AskForThrowGeneral"] = "弃置备选武将",
  ["hx__3v3_swap_prompt"] = "请为阵亡角色选择一组武将",
  -- 成组选择界面走 CustomDialog 命令，烧条默认显示命令名；这里给出可读标题
  ["hx__3v3_swap_title"] = "换将",
  ["HX3v3_PairThrow_count"] = "已选",
}

local function applyLateTranslation()
  if type(Fk) ~= "table" or type(Fk.loadTranslationTable) ~= "function" then return end
  pcall(Fk.loadTranslationTable, Fk, LATE_TRANSLATION)
  -- 方案名跟着一起补，避免模式文件的翻译表把它盖回「第 N 套」
  if next(BAN_SCHEME_LABELS) ~= nil then
    pcall(Fk.loadTranslationTable, Fk, BAN_SCHEME_LABELS)
  end
end

applyLateTranslation()

-- 模式文件在本文件之后才 require，其翻译会盖掉上面这份，注册时再补一次
if Fk and type(Fk.addGameMode) == "function"
    and not Fk.__hx_late_trans_patched then
  Fk.__hx_late_trans_patched = true
  local origAddModeTrans = Fk.addGameMode
  Fk.addGameMode = function(self, mode)
    origAddModeTrans(self, mode)
    if type(mode) == "table" and mode.name == MODE_NAME then
      pcall(applyLateTranslation)
    end
  end
end

local okW, W = pcall(require, "ui_emu.preferences")
-- 比赛规则的胜利判定在模式表上，等它注册时再包一层；函数体在后面补
local applyFullWin = nil
-- ui_emu.preferences 的可用性受装载顺序影响：个别顺序下装载期 require 会
-- 失败，而血战包注册模式同样发生在装载期，钩子装晚了模式就已注册完，
-- 设置组就永远挂不上去（2026-11-17 恢复官方 core 后出现过）。
-- 因此把安装包成函数：装载期试一次，latePatches 里再补一次；
-- 模式若已注册，直接在 Fk.game_modes 里找到并补跑注册逻辑。
local onHxModeRegistered
local onAnyModeRegistered

-- 「通用设置」组：借刀字数开关。所有游戏模式都要显示，
-- 与血战双将无关。借刀字数全模式生效。
-- 放到每个模式 ui_settings 的最前面（table.insert 第 1 位）。
onAnyModeRegistered = function(mode)
  if type(mode) ~= "table" then return end
  if type(mode.ui_settings) ~= "table" then
    -- 少数模式没有自己的设置页，建一个空表让它也能显示通用项
    mode.ui_settings = {}
  end
  if mode.__hx_common_group_patched then return end
  mode.__hx_common_group_patched = true
  pcall(function()
    table.insert(mode.ui_settings, 1, W.PreferenceGroup {
      title = "hx_settings_common_group_title",
      -- 借刀杀人牌名字数：默认 4 字，开 → 2 字，全模式生效
      W.SwitchRow {
        _settingsKey = SETTING_JIEDAO,
        title = "hx_settings_jiedao_title",
      },
    })
  end)
end

local function installSettingsHook()
  local function wReady()
    return okW and type(W) == "table" and type(W.PreferenceGroup) == "function"
        and type(W.SwitchRow) == "function" and type(W.ComboRow) == "function"
  end
  if not wReady() then
    local okRetry, W2 = pcall(require, "ui_emu.preferences")
    if okRetry and type(W2) == "table" then okW, W = true, W2 end
  end
  if not (wReady() and Fk) then
    hxlog("hx3v3 settings: ui_emu.preferences unavailable, 设置组未安装")
    return false
  end
  if not Fk.__hx_settings_hook_installed then
    Fk.__hx_settings_hook_installed = true
    local origAddGameMode = Fk.addGameMode
    if type(origAddGameMode) == "function" then
      Fk.addGameMode = function(self, mode)
        origAddGameMode(self, mode)
        if type(mode) ~= "table" then return end
        -- 所有模式：通用组（借刀字数）
        pcall(onAnyModeRegistered, mode)
        -- 仅血战模式：双将专属组（乐不思蜀、换将清理等）
        if mode.name == MODE_NAME then
          pcall(onHxModeRegistered, mode)
        end
      end
    end
  end
  -- 钩子装好前就已注册的模式，这里直接补。game_modes 是「模式名→模式」字典，
  -- 必须用 pairs（ipairs 遍历字典无效）。
  if type(Fk.game_modes) == "table" then
    for _, m in pairs(Fk.game_modes) do
      if type(m) == "table" then
        pcall(onAnyModeRegistered, m)
        if m.name == MODE_NAME then
          pcall(onHxModeRegistered, m)
        end
      end
    end
  end
  return true
end

onHxModeRegistered = function(mode)

      -- 每次建房都会调用 mode.logic 得到一个新建的 logic 子类。
      -- 包加载期全局 Request 还不存在，只能等运行期补装；
      -- 这里在选将入口前再补一次，保证弃将请求发出时拦截已经就位。
      if type(mode.logic) == "function" and not mode.__hx_logic_patched then
        mode.__hx_logic_patched = true
        local origLogic = mode.logic
        mode.logic = function(...)
          local cls = origLogic(...)
          if type(cls) == "table" and type(cls.chooseGenerals) == "function" then
            local origChoose = cls.chooseGenerals
            cls.chooseGenerals = function(logicSelf, ...)
              pcall(tryLatePatches)
              return origChoose(logicSelf, ...)
            end
          end
          return cls
        end
      end

      -- 胜利判定不依赖设置页，先装，避免 ui_settings 缺失时漏装
      if applyFullWin then pcall(applyFullWin, mode) end

      if type(mode.ui_settings) ~= "table" or mode.__hx_extra_rules_patched then return end
      mode.__hx_extra_rules_patched = true

      -- 通用开关可能在「游戏设置」（_game）也可能在「模式设置」（_mode），两处都认
      local function settingsFlag(settings, key)
        if type(settings) ~= "table" then return nil end
        local game = settings._game or {}
        if game[key] ~= nil then return game[key] end
        local modeCfg = settings._mode or {}
        return modeCfg[key]
      end
      -- 总开关能否点：必须先开房间设置里的「启用副将」，否则常驻灰化
      -- 两处都读不到时不灰化（真点了也不会生效，服务端 masterOn 还会再挡一次），
      -- 避免设置面板换了字段名就把开关彻底锁死
      local function masterEnabled(settings)
        local v = settingsFlag(settings, "enableDeputy")
        if v == nil then return true end
        return v == true
      end
      -- 子项能否点：总开关开着才可点
      local function subEnabled(settings)
        if not masterEnabled(settings) then return false end
        return settingsFlag(settings, SETTING_MASTER) == true
      end

      pcall(function()
        table.insert(mode.ui_settings, W.PreferenceGroup {
          title = "hx_settings_extra_rules_group_title",
          -- 乐不思蜀两项与双将无关，放在总开关之上：单将模式也能用，
          -- 因此不设 enabled 门槛（血战模式内恒可点，服务端也只认 isModeRoom）
          W.ComboRow {
            _settingsKey = SETTING_COUNT,
            title = "hx_settings_indulgence_count_title",
            model = {
              "hx_indulgence_count_3",
              "hx_indulgence_count_2",
              "hx_indulgence_count_1",
              "hx_indulgence_count_0",
            },
          },
          W.ComboRow {
            _settingsKey = SETTING_EFFECT,
            title = "hx_settings_indulgence_effect_title",
            model = {
              "hx_indulgence_effect_off",
              "hx_indulgence_effect_maxcards2",
              "hx_indulgence_effect_maxhp",
              "hx_indulgence_effect_self",
            },
          },
          -- 换将时清理旧将状态：独立开关，放在模式总开关之前
          --（11-17 应用户要求上移，单独可点，不受总开关灰化控制）
          W.SwitchRow {
            _settingsKey = SETTING_SWAPFIX,
            title = "hx_settings_swap_skill_fix_title",
            -- 换将状态隔离的子项，没存过值时就当开着
            value = function(settings)
              local v = settingsFlag(settings, SETTING_SWAPFIX)
              if v == nil then return true end
              return v == true
            end,
          },
          -- 一次选完三组 / 回合内阵亡：移到总开关之前，单独可点，
          -- 不受总开关灰化控制（11-17 应用户要求上移，与"换将清理"同列）
          W.SwitchRow {
            _settingsKey = SETTING_ONESHOT,
            title = "hx_settings_one_shot_groups_title",
          },
          W.SwitchRow {
            _settingsKey = SETTING_ENDTURN,
            title = "hx_settings_end_turn_on_death_title",
          },
          -- 本局全体禁将 + 禁将数量：放在总控之前，独立可点，单双将都生效
          --（应用户要求放在总控前面；与"换将清理""一次选完"同列）
          W.SwitchRow {
            _settingsKey = SETTING_GLOBALBAN,
            title = "hx_settings_global_ban_title",
          },
          W.ComboRow {
            _settingsKey = SETTING_GLOBALBANCOUNT,
            title = "hx_settings_global_ban_count_title",
            model = {
              "hx_global_ban_count_1",
              "hx_global_ban_count_2",
              "hx_global_ban_count_3",
              "hx_global_ban_count_4",
            },
            -- 没存过时按 1 名/组
            value = function(settings)
              local v = settingsFlag(settings, SETTING_GLOBALBANCOUNT)
              for _, key in ipairs({
                "hx_global_ban_count_1", "hx_global_ban_count_2",
                "hx_global_ban_count_3", "hx_global_ban_count_4",
              }) do
                if v == key then return v end
              end
              return "hx_global_ban_count_1"
            end,
            enabled = function(settings)
              return settingsFlag(settings, SETTING_GLOBALBAN) == true
            end,
          },
          W.SwitchRow {
            _settingsKey = SETTING_MASTER,
            title = "hx_settings_signature_deputy_title",
            enabled = masterEnabled,
          },
          -- 双将禁配：放在总控之后，受总控灰化控制（双将才有"配对"概念）
          W.SwitchRow {
            _settingsKey = SETTING_NOPAIR,
            title = "hx_settings_no_pair_title",
            enabled = subEnabled,
          },
          -- 「禁配方案」下拉框已移除：用哪套方案改为在下方「禁配方案管理」
          -- 窗口里直接选择，选中即生效；SETTING_PAIRSCHEME 保留仅为兼容旧存档。
          W.ComboRow {
            _settingsKey = SETTING_ODD,
            title = "hx_settings_odd_comp_title",
            model = {
              "hx_odd_comp_off",
              "hx_odd_comp_armor",
              "hx_odd_comp_yinyang",
            },
            enabled = subEnabled,
          },
          W.SwitchRow {
            _settingsKey = SETTING_FULLWIN,
            title = "hx_settings_full_win_title",
            enabled = subEnabled,
          },
          W.SwitchRow {
            _settingsKey = SETTING_DOUBLEBAN,
            title = "hx_settings_double_ban_title",
            enabled = subEnabled,
          },
          W.ComboRow {
            _settingsKey = SETTING_BANSCHEME,
            title = "hx_settings_double_ban_scheme_title",
            -- 函数形式：在客户端渲染设置页时求值，那时再读本机配置，
            -- 方案数量与名字都是最新的（含更新按钮刚拉下来的 6 套默认方案）。
            model = function()
              pcall(refreshBanSchemeModel)
              return BAN_SCHEME_MODEL
            end,
            -- 没存过时默认第 2 套（只剩一套时就是那一套），
            -- 存过的方案被删掉也要退回到列表里还有的项，否则下拉框会显示空
            value = function(settings)
              local chosen = settingsFlag(settings, SETTING_BANSCHEME)
              for _, key in ipairs(BAN_SCHEME_MODEL) do
                if key == chosen then return chosen end
              end
              return BAN_SCHEME_MODEL[2] or BAN_SCHEME_MODEL[1]
                  or DEFAULT_BAN_SCHEME_KEY
            end,
            -- 总开关、特色双将、双禁将三者都开着才有意义，否则灰化
            enabled = function(settings)
              return subEnabled(settings)
                  and settingsFlag(settings, SETTING_DOUBLEBAN) == true
            end,
          },
          W.SwitchRow {
            _settingsKey = SETTING_DUALPOOL,
            title = "hx_settings_dual_pool_title",
            -- 双禁将开着才有意义
            enabled = function(settings)
              return subEnabled(settings)
                  and settingsFlag(settings, SETTING_DOUBLEBAN) == true
            end,
          },
          -- 云端默认禁将方案【更新】按钮，所有人可用。
          -- 组件本体在 advancedpackages/qml/ 下：点击发 LobbyTask 拉取云端
          -- 6 套默认方案；管理员点击时组件会顺带上送本地方案，由服务端判定后覆盖。
          {
            _qml = {
              url = "packages/advancedpackages/qml/hx__3v3_UpdateSchemesButton.qml",
            },
            _settingsKey = "hxBanUpdateSchemesBtn",
            _children = {},
            title = "hx_settings_update_schemes_title",
          },
          -- 一键删除本地禁将方案：只清本客户端方案，不碰云端全服存档。
          -- 放在「更新默认禁将方案」下面，二者配合：删光本地后可点上面重新拉取 6 套默认。
          {
            _qml = {
              url = "packages/advancedpackages/qml/hx__3v3_DeleteSchemesButton.qml",
            },
            _settingsKey = "hxBanDeleteSchemesBtn",
            _children = {},
            title = "hx_settings_delete_schemes_title",
          },
          -- 禁配方案管理窗口入口：编辑成对武将/标号、命名、保存，
          -- 管理员还可上传/拉取云端禁配方案（与禁将方案云备份分开）。
          -- 放在组最末尾，避免裸 QML 组件影响上面「奇数体力值补偿」行的布局。
          {
            _qml = {
              url = "packages/advancedpackages/qml/hx__3v3_PairSchemesButton.qml",
            },
            _settingsKey = "hxPairSchemesBtn",
            _children = {},
            title = "hx_settings_pair_manage_title",
          },
        })
      end)
end

pcall(installSettingsHook)

if type(Fk.loadTranslationTable) == "function" then
  pcall(Fk.loadTranslationTable, Fk, {
    -- 通用设置组：所有游戏模式可见
    ["hx_settings_common_group_title"] = "通用设置",
    ["hx_settings_jiedao_title"] = "借刀杀人算2字",
    ["help: hx_settings_jiedao_title"] =
      "开启后，本局所有按「牌名字数」判定的技能都将【借刀杀人】算作 2 字（OL 和谐口径）；"
      .. "默认关闭时算 4 字。对所有游戏模式生效。",

    ["hx_settings_extra_rules_group_title"] = "血战附加规则",

    ["hx_settings_signature_deputy_title"] = "双将模式规则",
    ["help: hx_settings_signature_deputy_title"] =
      "双将模式规则的总开关，必须先开启房间设置中的「启用副将」才能开启。"
      .. "\n开启后每名玩家依次选择三组武将（共六张）：第一组登场，其余两组进入备选池，"
      .. "选将结束时由主帅从备选池统一弃置两组；阵亡换将按本人选定的组合依次上场。",

    -- 本局全体禁将（总控之前）
    ["hx_settings_global_ban_title"] = "本局全体禁将",
    ["help: hx_settings_global_ban_title"] =
      "开启后，所有人在正式选将前先从自己的候选里禁若干名武将，"
      .. "汇总后本局对所有人都不再可选。单将按名禁；双将按「组」禁（一组两张）。"
      .. "每人可禁的数量由下面的「本局禁将数量」决定（1-4）。",
    ["hx_settings_global_ban_count_title"] = "本局禁将数量",
    ["help: hx_settings_global_ban_count_title"] =
      "每名玩家在禁将阶段可禁的数量：单将模式为 1-4 名武将，双将模式为 1-4 组（每组两张）。",
    ["hx_global_ban_count_1"] = "1 名/组",
    ["hx_global_ban_count_2"] = "2 名/组",
    ["hx_global_ban_count_3"] = "3 名/组",
    ["hx_global_ban_count_4"] = "4 名/组",
    ["#hx__3v3_global_ban_prompt"] = "本局禁将：请从候选中禁用 %arg 名/组（禁用后本局所有人都不能选）",
    ["hx__3v3_global_ban_toast"] = "本局禁将已汇总",
    -- 照 fengsui 的 @& banner 方案：官方 LtkLuaUtil 会把 @& 开头的 banner
    -- 渲染成 Room 场景常驻的 ViewGeneralPile 标签，点开可见名单，
    -- 不依赖备选池 PairPanel（那套自定义 QML 反复不显示，弃用）。
    ["@&hx__3v3_ban_list"] = "本局已禁用",
    ["@&hx__3v3_pair_list"] = "本局已禁配",
    ["@[hxpair]&hx__3v3_pair_list"] = "本局已禁配",

    -- 双将禁配（总控之后）
    ["hx_settings_no_pair_title"] = "双将禁配",
    ["help: hx_settings_no_pair_title"] =
      "开启后，用「禁配方案」把武将两两配成标号（第一对为 1 号，第二对为 2 号，依此类推），"
      .. "同一标号的两名武将不得组成一组双将。"
      .. "\n开启「选将分两个候选池」时改为 A 池出一将、B 池出一将组成一组，"
      .. "同样禁止同标号跨池配对。禁配方案在下方「禁配方案管理」里编辑。",
    ["hx_settings_pair_scheme_title"] = "禁配方案",
    ["help: hx_settings_pair_scheme_title"] =
      "下拉里列出房主自己保存的禁配方案，顺序与禁配方案管理窗口一致。",
    ["hx_pair_scheme_1"] = "禁配方案 1",
    ["hx_pair_scheme_2"] = "禁配方案 2",
    ["hx_pair_scheme_3"] = "禁配方案 3",
    ["hx_pair_scheme_4"] = "禁配方案 4",
    ["hx_pair_scheme_5"] = "禁配方案 5",
    ["hx_pair_scheme_6"] = "禁配方案 6",
    ["hx_settings_pair_manage_title"] = "禁配方案管理",
    ["help: hx_settings_pair_manage_title"] =
      "打开禁配方案管理窗口：新增/重命名方案，搜索并添加武将两两成标号，"
      .. "可预览、保存。管理员还能上传本机方案到云端供其他人拉取。",
    ["hx_pair_ban_conflict"] = "禁配冲突：同标号武将不能组成一组，请重新选择",

    ["hx_settings_odd_comp_title"] = "奇数体力值补偿",
    ["help: hx_settings_odd_comp_title"] =
      "双将体力按两将体力之和向下取整，若合计为奇数，"
      .. "按此处选择补偿：\n护甲：获得一枚护甲。"
      .. "\n阴阳鱼：获得一枚「阴阳鱼」，出牌阶段可弃一枚摸一张牌，弃牌阶段开始时可弃一枚令本回合手牌上限 +2。"
      .. "\n不补偿：只修正体力。",
    ["hx_odd_comp_off"] = "不补偿",
    ["hx_odd_comp_armor"] = "护甲",
    ["hx_odd_comp_yinyang"] = "阴阳鱼",

    ["hx_settings_end_turn_on_death_title"] = "回合内阵亡直接结束本回合",
    ["help: hx_settings_end_turn_on_death_title"] =
      "在自己回合内阵亡并换将后，直接结束当前回合。"
      .. "不影响结算中的伤害（比如铁索连环传导）。",

    ["hx_settings_swap_skill_fix_title"] = "换将时清理旧将残留状态",
    ["help: hx_settings_swap_skill_fix_title"] =
      "换将复用同一个玩家，旧将本回合的技能使用次数、临时标记、回合末回调"
      .. "会残留到新将身上：例如胆守把旧将当目标的次数算进新将（该摸 1 却摸 3），"
      .. "或旧将穿屋在回合末把已失去的旧技能加回新将。"
      .. "\n开启后，换将完成即只清理该玩家自己的这些残留状态，"
      .. "新将本回合技能照常可用，也不会动旧将给其他角色挂的效果。默认开启。",

    ["hx_settings_full_win_title"] = "血战比赛规则",
    ["help: hx_settings_full_win_title"] =
      "开启后必须击杀对方全部备选武将才算获胜（全歼口径）；"
      .. "关闭时击杀三组、留一组备选即胜（六分口径）。",

    ["hx_settings_double_ban_title"] = "双禁将方案",
    ["help: hx_settings_double_ban_title"] =
      "开启后，在禁将页面当前选中的方案之外，自选第二套禁将方案，两者取并集。"
      .. "\n若同时开启下面的「选将分两个候选池」，两套禁将方案各自成一个候选池。",

    ["hx_settings_double_ban_scheme_title"] = "第二套方案",
    ["help: hx_settings_double_ban_scheme_title"] =
      "下拉里列出房主自己保存的禁将方案，"
      .. "顺序与禁将页面一致，改名或添加新方案后需重进服务器才能生效。"
      .. "\n选中的那一套会与禁将页面当前方案取并集，与当前方案是同一套时不会重复生效。",
    ["hx_ban_scheme_1"] = "第 1 套",
    ["hx_ban_scheme_2"] = "第 2 套",
    ["hx_ban_scheme_3"] = "第 3 套",
    ["hx_ban_scheme_4"] = "第 4 套",
    ["hx_ban_scheme_5"] = "第 5 套",
    ["hx_ban_scheme_6"] = "第 6 套",
    ["hx_ban_scheme_7"] = "第 7 套",
    ["hx_ban_scheme_8"] = "第 8 套",

    ["hx_settings_dual_pool_title"] = "选将分两个候选池",
    ["help: hx_settings_dual_pool_title"] =
      "开启后，第二套方案的禁将不再并进房间，而是单独组成一个候选池，选区一分为二，玩家只能从两个备选池各选一个作为主副将。"
      .. "\n注意：两池各自独立，所以可能出现「方案 A 禁掉、方案 B 没禁」的武将，"
      .. "它只会出现在右池，选中后照常登场。",

    ["hx_settings_update_schemes_title"] = "更新默认禁将方案",
    ["help: hx_settings_update_schemes_title"] =
      "点击后从服务器拉取最新的 6 套默认禁将方案，追加到你本机的禁将方案列表末尾（已有同名方案不会重复）。"
      .. "\n管理员点击时，还会把你本机前 6 套方案上传，更新服务器上的默认方案供其他人拉取。",
    ["hx_ban_sync_ok"] = "已更新 %1 套默认方案",
    ["hx_ban_sync_admin"] = "已上传并更新服务器默认方案（%1 套）",
    ["hx_ban_sync_latest"] = "已是最新，本地已有全部 6 套默认方案",
    ["hx_ban_sync_fail"] = "更新失败，请确认已连接服务器后重试",

    ["hx_settings_delete_schemes_title"] = "删除本地禁将方案",
    ["help: hx_settings_delete_schemes_title"] =
      "点击后清空你本机保存的全部禁将方案（不影响服务器云端方案）。"
      .. "\n删光后可再点上面的「更新默认禁将方案」重新拉取 6 套默认方案。",

    -- 技能名用国战原名 "yinyangfish_skill&"：末尾 & 让它成为隐藏技能，不进技能栏；
    -- 客户端 SpecialMarkSkillArea 只认这个名字，才会在角色下方画可点击的阴阳鱼图标。
    ["yinyangfish_skill&"] = "阴阳鱼",
    ["hx__3v3_yinyang_skill"] = "阴阳鱼",
    ["#hx__3v3_yinyang_skill"] = "你可弃一枚「阴阳鱼」，摸一张牌",
    ["#hx__3v3_yinyang_max"] = "你可弃一枚「阴阳鱼」，此回合手牌上限 +2",
    [":hx__3v3_yinyang_skill"] =
      "出牌阶段，你可弃一枚「阴阳鱼」，摸一张牌；弃牌阶段开始时，你可弃一枚「阴阳鱼」，此回合手牌上限 +2。",
    -- 阴阳鱼用国战原名 "@!!yinyangfish"：客户端把 "@!" 开头的标记归进 picMarks，
    -- 画在头像旁那个 20×20 的图标位上。图源是 SkinBank.getMarkPic(原名)，
    -- 它只在【本机】packages/*/image/mark/ 下找同名 png，与服务器装了什么包无关；
    -- 玩家的安装目录里只要有国战包（hegemony）的这张图，图标就正常显示。
    ["@!!yinyangfish"] = "阴阳鱼",
    [":@!!yinyangfish"] =
      "出牌阶段弃一枚可摸一张牌；弃牌阶段开始时弃一枚，本回合手牌上限 +2。",

    ["#hx__3v3_choose_group_first"] =
      "座次 %arg，请选择第 %arg2 组武将（%arg3 名），首发登场%arg4",
    ["#hx__3v3_choose_group"] =
      "座次 %arg，请选择第 %arg2 组武将（%arg3 名）%arg4",
    ["hx__3v3_group_toast"] = "特色双将：依次选三组武将",
    ["#hx__3v3_choose_all_groups"] =
      "座次 %arg，一次选完三组武将（共 %arg2 名）：前一组首发，后两组备选%arg3",

    ["hx_settings_one_shot_groups_title"] = "一次选完三组",
    ["help: hx_settings_one_shot_groups_title"] =
      "开启后不再分三次弹选将框，改为一次性选满三组。"
      .. "\n前两张为首发组，后四张按顺序依次是备选第一组、第二组。",

    ["hx_settings_indulgence_count_title"] = "牌堆减去乐不思蜀",
    ["help: hx_settings_indulgence_count_title"] =
      "从本局牌堆里减去的【乐不思蜀】张数，默认减三张。"
      .. "不同牌堆存量不同（比赛牌堆 2 张、混装牌堆 5 张），减的数量超过存量时按存量全减；"
      .. "被减的换成花色点数相同的【兵粮寸断】，减剩时优先保留黑桃、红桃。"
      .. "此项与双将无关，单将模式同样生效。",
    ["hx_indulgence_count_3"] = "减三张",
    ["hx_indulgence_count_2"] = "减两张",
    ["hx_indulgence_count_1"] = "减一张",
    ["hx_indulgence_count_0"] = "不减",

    ["hx_settings_indulgence_effect_title"] = "乐不思蜀调整",
    ["help: hx_settings_indulgence_effect_title"] =
      "选择一项后，本局所有【乐不思蜀】生效后改为以下效果。单将模式同样生效。"
      .. "\n上限+2：跳过出牌阶段，且本回合手牌上限 +2。"
      .. "\n英姿：跳过出牌阶段，且本回合手牌上限等于体力上限。"
      .. "\n自守：改为只能对自己使用牌，不跳过出牌阶段。",
    ["hx_indulgence_effect_off"] = "不启用",
    ["hx_indulgence_effect_maxcards2"] = "上限+2",
    ["hx_indulgence_effect_maxhp"] = "英姿",
    ["hx_indulgence_effect_self"] = "自守",

    ["hx__3v3_indulgence_skill"] = "乐不思蜀",
    ["#hx__3v3_indulgence_skill"] =
      "选择一名其他角色，将此牌置入其判定区：其判定阶段进行判定，若结果不为红桃，则按本局「乐不思蜀改版」结算。",
  })
end

----------------------------------------------------------------------
-- 二、特色双将模式（与通用「副将机制」互斥）
----------------------------------------------------------------------
-- 直接读 settings 表，避免包装 getSettings 之后自我递归
local function rawSetting(room, key)
  local t = type(room) == "table" and room.settings or nil
  if type(t) ~= "table" then return nil end
  if type(t._mode) == "table" and t._mode[key] ~= nil then return t._mode[key] end
  if type(t._game) == "table" and t._game[key] ~= nil then return t._game[key] end
  return t[key]
end

-- 总开关：本模式、通用「副将机制」已开、本模式总开关也开。
-- 三个条件缺一，本文件所有附加规则一律不生效
local function masterOn(room)
  if rawSetting(room, "gameMode") ~= MODE_NAME then return false end
  if rawSetting(room, "enableDeputy") ~= true then return false end
  return rawSetting(room, SETTING_MASTER) == true
end

-- 旧名保留，内部各处沿用
local signatureDeputyOn = masterOn

-- 换将时清理旧将残留状态：单独的子开关，没存过值时按开启处理；
-- 关掉就等于回到官方换将流程，不做任何清理
local function swapSkillFixOn(room)
  local v = rawSetting(room, SETTING_SWAPFIX)
  if v == nil then return true end
  return v == true
end

local okRB, RoomBase = pcall(require, "core.roombase")
if okRB and type(RoomBase) == "table" and type(RoomBase.getSettings) == "function"
    and not rawget(RoomBase, "__hx_signature_deputy_patched") then
  rawset(RoomBase, "__hx_signature_deputy_patched", true)
  local origGetSettings = RoomBase.getSettings
  RoomBase.getSettings = function(self, key)
    -- 运行期补装：Request / qml_mark 在包加载时还不存在
    pcall(tryLatePatches)
    if key == "3v3thegeneralsNum" then
      -- 3v3thegeneralsNum 只有血战模式会读，无需再比 gameMode 字符串
      -- （origGetSettings 取 gameMode 时会走 _mode/_game 分层，曾读不到而漏判）。
      -- 双将模式（总开关开）：每方 12 张备选，统一弃两组（四张）
      if masterOn(self) then
        hxlog("thegeneralsNum: deputy on -> 4")
        return 4
      end
      -- 单将模式（关掉双将 / enableDeputy=false）：每方本就只有 6 张备选，
      -- 血战公式 12 - 6*1 = 6 会把 6 张全弃光，导致无将可用。返回 0 让官方
      -- `if thegeneralsNum > 0` 不成立，直接跳过弃置，6 张备选全部保留。
      -- 一律用 rawSetting（与 masterOn 同源），避免包装层读不到导致漏判。
      local rawDep = rawSetting(self, "enableDeputy")
      hxlog("thegeneralsNum: masterOff enableDeputy=" .. tostring(rawDep) .. " -> 0")
      return 0
    end
    return origGetSettings(self, key)
  end
end

----------------------------------------------------------------------
-- 二·五、比赛规则：击穿全部备选才获胜
----------------------------------------------------------------------
-- 一组 = 一对主副将（两张）。全部击穿记五分，中间每击穿一组记一分
local function poolScore(pool)
  if type(pool) ~= "table" then return 0 end
  local left = math.floor(#pool / 2)
  if left <= 0 then return 5 end
  return math.max(0, 4 - left)
end

-- 备选池取数：比赛规则用公开池，其余用 private 池
local function poolLists(room)
  if room:getSettings("3v3competition") then
    return room:getBanner("@&hx__cool_generals") or {}, room:getBanner("@&hx__warm_generals") or {}
  end
  local cb = room:getBanner("@[private]&hx__cool_generals")
  local wb = room:getBanner("@[private]&hx__warm_generals")
  return (type(cb) == "table" and cb.value) or {}, (type(wb) == "table" and wb.value) or {}
end

-- 引擎实际调用的是 mode.getWinner（CreateGameMode 只把 spec.winner_getter
-- 赋给 getWinner，不会动态回读 winner_getter 字段）。以前包 winner_getter
-- 等于没装，必须包 getWinner 才生效。
applyFullWin = function(mode)
  if type(mode) ~= "table" or type(mode.getWinner) ~= "function" then return false end
  if mode.__hx_fullwin_patched then return true end
  mode.__hx_fullwin_patched = true
  local orig = mode.getWinner
  mode.getWinner = function(self, victim)
    local room = Fk:currentRoom()
    if not (room and victim and masterOn(room)) then
      return orig(self, victim)
    end
    local cool, warm = poolLists(room)
    -- getWinner 在阵亡换将之前调用，判负发生在本轮取将之前。
    -- 关全歼：池剩一组（2张）即判负；开全歼：池空（0张）才判负。
    -- 少算一组修正 2026-11-20：旧值 4/2 实际留了 2 组/1 组，多留一组。
    local limit = rawSetting(room, SETTING_FULLWIN) == true and 0 or 2
    local winner = ""
    if victim.role:startsWith("warm") then
      if #warm <= limit then winner = victim:getEnemies(true) end
    elseif victim.role:startsWith("cool") then
      if #cool <= limit then winner = victim:getEnemies(true) end
    end
    if #cool > limit and #warm > limit then winner = "" end
    if victim.surrendered and (victim.role == "cool_marshal" or victim.role == "warm_marshal") then
      winner = victim:getEnemies(true)
    end
    if not winner then winner = "" end
    return winner
  end
  hxlog("fullwin getter installed on getWinner")
  return true
end

----------------------------------------------------------------------
-- 三、双将体力与「奇数体力值补偿」
----------------------------------------------------------------------
-- 阴阳鱼：国战同款。出牌阶段弃一枚摸一张；弃牌阶段开始弃一枚，本回合手牌上限 +2
-- 玩家身上那枚标记用国战原名 "@!!yinyangfish"，效果就是头像旁那枚小鱼图标。
-- 那个 20×20 的图标位在客户端里是写死的 Image，图源由 SkinBank.getMarkPic 解析：
-- 它遍历【本机】packages/<包>/image/mark/<标记名>.png，跳过已禁用的包。
-- 也就是说这是纯客户端资源查找，服务器上有没有国战包不影响；本机有 hegemony 的
-- @!!yinyangfish.png 就有图标。标记值即数量，1 不显示数字（与国战一致）。
-- 技能名用国战原名（末尾 & = 隐藏技能）：客户端 SpecialMarkSkillArea.qml 只认
-- "yinyangfish_skill&"，才会在角色下方画那枚可点击的阴阳鱼图标，且技能不进技能栏。
-- 11-17 曾误改成 hx__3v3_yinyang_skill，导致技能变常驻、图标区认不出。
local YINYANG_SKILL = "yinyangfish_skill&"
local YINYANG_MARK = "@!!yinyangfish"

-- 和国战 HegUtil.removeHegMark 一致：用掉最后一枚 mark 时把隐藏技能一起摘掉，
-- 技能与 mark 严格挂钩，mark 没了技能栏下方那枚图标也随之消失。
local function removeYinyangIfEmpty(room, player)
  if player:getMark(YINYANG_MARK) <= 0 and type(room.handleAddLoseSkills) == "function" then
    pcall(room.handleAddLoseSkills, room, player, "-" .. YINYANG_SKILL, nil, false)
  end
end

-- 阴阳鱼技能骨架在 rules/skills/yinyangfish.lua。
-- 11-17 20:00 实测发现：只在 init.lua 里走 Package:loadSkillSkelsByPath，
-- 客户端进程并未稳定把 "yinyangfish_skill&" 注册进 Fk.skills，角色下方小鱼
-- 图标（只认本机 Fk.skills 里这个技能名）就画不出来。这里在本文件顶层再显式
-- createSkill + Fk:addSkill 兜底一次：和 init.lua 的骨架加载是同一个 skel，
-- Fk:addSkill 对同名技能是覆盖式写入（不会报错），缺哪条路都能补上。
-- 关键：角色下方图标由客户端 Ltk.createSkillModel → getSkillData 遍历玩家技能
-- 生成，而玩家技能是服务端 addYinyang 加的，两端都必须认得这个名字。
local function ensureYinyangSkillRegistered()
  if type(Fk) ~= "table" or type(Fk.addSkill) ~= "function"
      or type(Fk.skills) ~= "table" then
    return false
  end
  if Fk.skills[YINYANG_SKILL] then return true end
  if type(fk) ~= "table" or type(fk.CreateSkill) ~= "function" then return false end

  -- 优先复用 init.lua 已加载进 Fk.skill_skels 的骨架；没有就现场 require 一份。
  local skel = type(Fk.skill_skels) == "table" and Fk.skill_skels[YINYANG_SKILL] or nil
  if not skel then
    local okReq, mod = pcall(require, "packages.advancedpackages.rules.skills.yinyangfish")
    if okReq and type(mod) == "table" then skel = mod end
  end
  if type(skel) ~= "table" or type(skel.createSkill) ~= "function" then return false end

  local okCreate, realSkill = pcall(function() return skel:createSkill() end)
  if not okCreate or not realSkill then
    hxlog("yinyang createSkill FAILED: " .. tostring(realSkill))
    return false
  end
  if type(Fk.skill_skels) == "table" then
    pcall(function() Fk.skill_skels[YINYANG_SKILL] = skel end)
  end
  local okAdd, errAdd = pcall(Fk.addSkill, Fk, realSkill)
  if okAdd then
    hxlog("yinyang skill registered into Fk.skills (explicit fallback)")
  else
    hxlog("yinyang addSkill FAILED: " .. tostring(errAdd))
  end
  return okAdd
end
pcall(ensureYinyangSkillRegistered)

-- 补偿方式：新键优先；老存档里的布尔开关折算成「护甲」
local function oddCompKind(room)
  local raw = rawSetting(room, SETTING_ODD)
  local kind = normCompKind(raw)
  if kind then
    hxlog(("odd comp: raw=%s kind=%s"):format(tostring(raw), kind))
    return kind
  end
  local old = rawSetting(room, SETTING_ARMOR_OLD)
  hxlog(("odd comp: raw=%s oldarmor=%s -> fallback off")
    :format(tostring(raw), tostring(old)))
  if old == true then return "armor" end
  return "off"
end

-- scene: "start" 开局公布武将 / "swap" 阵亡换将
-- 护甲与体力同口径：主副将初始护甲合计后除二向下取整，再叠加奇数体力补偿的一枚
local function adjustDeputyHp(player, scene)
  local room = player and player.room
  if not isDeputyRoom(room) then return end
  local main = Fk.generals[player.general]
  local deputy = Fk.generals[player.deputyGeneral]
  if not main or not deputy then return end

  -- 上限一律按 maxHp 字段合算。个别将的 maxHp 字段若缺失，退回 hp 时也必须取
  -- 两者较大值：1/6 那类将 maxHp=6、hp=1，若错用 hp 参与合算，双将上限会塌成 1。
  local mainCap = math.max(main.maxHp or 0, main.hp or 0)
  local depCap = math.max(deputy.maxHp or 0, deputy.hp or 0)
  local sum = mainCap + (main.mainMaxHpAdjustedValue or 0)
            + depCap + (deputy.deputyMaxHpAdjustedValue or 0)
  local floorHp = sum // 2
  local fix = main.fixMaxHp
  local dfix = deputy.fixMaxHp
  if dfix then
    fix = fix and math.min(fix, dfix) or dfix
  end

  -- 上限按 maxHp 字段相加除以二；当前体力另按 hp 字段相加除以二（官方
  -- gamelogic.lua:156 口径：math.floor((deputy.hp + general.hp)/2)），再夹到上限内。
  -- 11-17 曾把 hp 直接设成 maxHp，导致选阴阳鱼后一律满血；1/6 将那种 hp≠maxHp
  -- 的武将尤其明显。fixMaxHp 只压上限，不把体力抬满。
  local maxHp = fix or floorHp
  local hpFromGenerals = (main.hp or mainCap) + (deputy.hp or depCap)
  player.maxHp = maxHp
  player.hp = math.min(maxHp, hpFromGenerals // 2)
  room:broadcastProperty(player, "maxHp")
  room:broadcastProperty(player, "hp")
  hxlog(("adjust hp scene=%s main=%s(hp%s/max%s adj%s fix%s) dep=%s(hp%s/max%s adj%s fix%s)"
    .. " sum=%s floor=%s -> maxHp=%s hpSum=%s cur=%s shield=%s+%s->%s")
    :format(tostring(scene), tostring(main.name), tostring(main.hp), tostring(main.maxHp),
      tostring(main.mainMaxHpAdjustedValue), tostring(main.fixMaxHp),
      tostring(deputy.name), tostring(deputy.hp), tostring(deputy.maxHp),
      tostring(deputy.deputyMaxHpAdjustedValue), tostring(deputy.fixMaxHp),
      tostring(sum), tostring(floorHp), tostring(maxHp), tostring(hpFromGenerals), tostring(player.hp),
      tostring(main.shield or 0), tostring(deputy.shield or 0), tostring(player.shield)))

  -- 补偿：合计为奇数说明舍去了半点体力，按设置给一枚护甲或一枚阴阳鱼
  local kind = oddCompKind(room)
  local odd = (sum % 2 == 1)
  local comp = (odd and kind == "armor") and 1 or 0
  -- 护甲与体力同口径：主副将初始护甲合计后除二向下取整，仍按官方上限 5 封顶。
  -- （11-17 之前换将场景只算主将，界沮授 m_ex__jvshou 护甲3 在副将位会被抹掉，
  --   现与主将一并纳入合计再折半。）
  local base = math.min(((main.shield or 0) + (deputy.shield or 0)) // 2, 5)
  player.shield = math.max(0, base + comp)
  room:broadcastProperty(player, "shield")

  -- 阴阳鱼：换将时按新组合重算，旧的先收回，避免越攒越多。
  -- 标记只管图标与剩余次数，能不能「用」取决于技能在不在身上，两者必须一起增删。
  local wantYinyang = odd and kind == "yinyang"
  pcall(room.removePlayerMark, room, player, YINYANG_MARK)
  if type(room.handleAddLoseSkills) == "function" then
    pcall(room.handleAddLoseSkills, room, player, "-" .. YINYANG_SKILL, nil, false)
    if wantYinyang then
      pcall(room.handleAddLoseSkills, room, player, YINYANG_SKILL, nil, false)
    end
  end
  if wantYinyang then
    room:addPlayerMark(player, YINYANG_MARK, 1)
  end
end

local function patchBroadcastHp()
  local okGL, GL = pcall(require, "ltk.server.gamelogic")
  if not okGL or type(GL) ~= "table"
      or type(GL.broadcastGeneralForPlayer) ~= "function"
      or GL.__hx_extra_rules_hp_patched then return true end
  GL.__hx_extra_rules_hp_patched = true
  local origBroadcast = GL.broadcastGeneralForPlayer
  GL.broadcastGeneralForPlayer = function(self, p)
    origBroadcast(self, p)
    pcall(adjustDeputyHp, p, "start")
  end
  return true
end
pcall(patchBroadcastHp)
latePatches[#latePatches + 1] = patchBroadcastHp

-- 出场顺序排序弹窗：血战原版给主帅发的是 bloodybattle/qml/3v3Box.qml（小卡）。
-- 11-17 换成双将牌展示样式：包装 Request.setData，仅当组件 url 指向 3v3Box
-- 时替换为本包 hx__3v3_OrderPanel.qml；交互与回传契约不变（确认回传排序后
-- 的武将名数组，取消回传空串），不碰血战官方包一个字节。
local function patchLordPowerDialog()
  if type(Request) ~= "table" or type(Request.setData) ~= "function" then return false end
  if rawget(Request, "__hx_order_patched") then return true end
  rawset(Request, "__hx_order_patched", true)
  local origSetData = Request.setData
  Request.setData = function(self, player, data)
    if type(data) == "table" and type(data.component) == "table"
        and type(data.component.url) == "string"
        and data.component.url:find("3v3Box", 1, true) then
      -- 仅在双将模式（总开关开 + 启用副将）换成双将牌面板；
      -- 关掉双将后单将模式保留官方 3v3Box 单卡，出场顺序也不受影响。
      local room = player and player.room
      local ok, deputy = pcall(function() return room and isDeputyRoom(room) end)
      if not ok or deputy then
        data.component.url = "packages/advancedpackages/qml/hx__3v3_OrderPanel.qml"
      end
    end
    return origSetData(self, player, data)
  end
  hxlog("lord power dialog: Request.setData patched (3v3Box -> OrderPanel)")
  return true
end
latePatches[#latePatches + 1] = patchLordPowerDialog
pcall(patchLordPowerDialog)

----------------------------------------------------------------------
-- 四、选将后记录每名玩家自己的主副将组合
----------------------------------------------------------------------
local function recordPairs(players, result)
  if type(players) ~= "table" or type(result) ~= "table" then return end
  local first = players[1]
  if not first or not first.room then return end
  local room = first.room
  if not isDeputyRoom(room) then return end

  local data = room:getBanner(PAIR_BANNER)
  if type(data) ~= "table" then data = {} end
  for _, p in ipairs(players) do
    local list = result[p]
    if type(list) == "table" and #list > 2 then
      local queue = {}
      local i = 3
      while i <= #list do
        table.insert(queue, { list[i], list[i + 1] })
        i = i + 2
      end
      data[p.id] = queue
    end
  end
  room:setBanner(PAIR_BANNER, data)
end

-- 特色双将：把「一次选六张」改成国战式「主将＋副将成组、连选三组」
local SIGNATURE_ROUNDS = 3
local SIGNATURE_SIZE = 2

-- 原流程按玩家 id 传参；只有一名玩家时也可能直接传这一份数据
local function paramOf(params, p, total)
  if type(params) ~= "table" then return nil end
  if total == 1 then return params[p.id] or params end
  return params[p.id]
end

-- 每轮给每名玩家的选将参数：池子里剩下的、只选两张、国战 UI（主副将标记）
local function buildRoundParams(players, params, pools, round)
  local out = {}
  for _, p in ipairs(players) do
    local base = paramOf(params, p, #players)
    if type(base) ~= "table" then return nil end
    local data
    if type(table.simpleClone) == "function" then
      data = table.simpleClone(base)
    else
      data = {}
      for k, v in pairs(base) do data[k] = v end
    end
    data.generals = pools[p] or base.generals
    data.choiceNum = SIGNATURE_SIZE
    -- 双禁将分池：这一轮剩下的候选里还有几张是池 A 的，
    -- 序号只减不变（取走的只是从池里删掉，不打乱顺序），所以数一遍即可
    if type(base.poolNames) == "table" then
      data.poolNames = base.poolNames
      local aSet = {}
      for _, g in ipairs((p.room and p.room.__hx_dual_pool_a and p.room.__hx_dual_pool_a[p.id]) or {}) do
        aSet[g] = true
      end
      local split = 0
      for _, g in ipairs(data.generals or {}) do
        if aSet[g] then split = split + 1 end
      end
      data.poolSplit = split
    end
    local extra = data.extraData
    if type(extra) ~= "table" then extra = {} end
    if type(table.simpleClone) == "function" then extra = table.simpleClone(extra) end
    extra.n = SIGNATURE_SIZE
    extra.choiceNum = SIGNATURE_SIZE
    -- 本局已禁用名单从 room banner 回读，确保每轮选将框左上角都能显示
    local room = p.room
    if room and room:getBanner(GLOBAL_BAN_BANNER .. "_done") == true then
      extra.showBanList = true
      local gb = room:getBanner(GLOBAL_BAN_BANNER)
      extra.globalBanned = (type(gb) == "table") and table.simpleClone(gb) or {}
    end
    data.extraData = extra
    -- 选牌本身不限势力，沿用血战原来的无限制选将规则。
    -- 不启用国战（hegemony）分支：hxfs.lua:411-422 的默认回复配对循环在
    -- 最后一个元素上会取到 nil 而崩，且血战将池不保证同势力成对。
    data.hegemony = false
    data.ruleType = "askForGeneralsChosen"
    -- 换将只对首组开放，后两本就是备选，不必再换
    data.change = round == 1 and (base.change or {}) or {}
    local free = (p.room and p.room:getSettings("enableFreeAssign")) and "(自由选将)" or ""
    if round == 1 then
      data.prompt = "#hx__3v3_choose_group_first:::seat#" .. p.seat .. ":" .. round .. ":" .. SIGNATURE_SIZE .. ":" .. free
    else
      data.prompt = "#hx__3v3_choose_group:::seat#" .. p.seat .. ":" .. round .. ":" .. SIGNATURE_SIZE .. ":" .. free
    end
    out[p.id] = data
  end
  return out
end

-- 一次选完三组（子开关）：只弹一次框，一次选满六张，结果区直接按三组排开。
-- 结果顺序即组序：1-2 首发，3-4 备选一，5-6 备选二，与分三轮选完全等价。
local function oneShotGroupsOn(room)
  if not masterOn(room) then return false end
  return rawSetting(room, SETTING_ONESHOT) == true
end

-- 官方自由选将：客户端右键候选卡弹 FreeAssign，从全将池把这张换成任意将。
-- 换回来的将可能不在发牌小池里，服务端按 Fk:canUseGeneral 校验后照样收下，
-- 不能再用 table.contains(pool, g) 把它过滤掉（否则等于禁用了自由选将）。
local function freePickAllowed(room, name)
  if not (room and room:getSettings("enableFreeAssign")) then return false end
  if type(name) ~= "string" then return false end
  local g = Fk.generals[name]
  if not g then return false end
  if g.hidden or g.total_hidden then return false end
  -- 不在这里查 Fk:canUseGeneral（房间 disabled_generals / disabled_packs）：
  -- 客户端 FreeAssign.qml 按 OnlyEnableGeneral 决定要不要查禁用表，关掉该开关
  -- 就允许选任何将；服务端若无条件按房间禁用表复核，就会把玩家自由选来的将
  -- 判为非法丢弃、再用池首旧将回填——表现为「选完又复原成被替换的将」。
  -- 自由选将本就允许突破候选池，客户端那道过滤已足够，服务端只验将真实存在。
  return true
end

local function askAllGroups(players, params, origAskToGeneral)
  local per = SIGNATURE_SIZE * SIGNATURE_ROUNDS
  local once = {}
  for _, p in ipairs(players) do
    local base = paramOf(params, p, #players)
    if type(base) ~= "table" then return nil end
    local list = base.generals
    if type(list) ~= "table" or #list < per then return nil end
    local data = table.simpleClone(base)
    data.choiceNum = per
    data.groupSize = SIGNATURE_SIZE
    local extra = type(data.extraData) == "table"
        and table.simpleClone(data.extraData) or {}
    extra.n = per
    extra.choiceNum = per
    local room = p.room
    if room and room:getBanner(GLOBAL_BAN_BANNER .. "_done") == true then
      extra.showBanList = true
      local gb = room:getBanner(GLOBAL_BAN_BANNER)
      extra.globalBanned = (type(gb) == "table") and table.simpleClone(gb) or {}
    end
    data.extraData = extra
    data.hegemony = false
    data.ruleType = "askForGeneralsChosen"
    local free = (p.room and p.room:getSettings("enableFreeAssign"))
        and "(自由选将)" or ""
    data.prompt = "#hx__3v3_choose_all_groups:::seat#" .. tostring(p.seat)
        .. ":" .. per .. ":" .. free
    once[p.id] = data
  end

  local ret = origAskToGeneral(players, once)
  if type(ret) ~= "table" then return nil end

  local out = {}
  for _, p in ipairs(players) do
    local base = paramOf(params, p, #players)
    local pool = {}
    for i, g in ipairs(base.generals) do pool[i] = g end
    local list = {}
    local got = ret[p]
    if type(got) == "table" then
      for _, g in ipairs(got) do
        if #list >= per then break end
        if (table.contains(pool, g) or freePickAllowed(p.room, g))
            and not table.contains(list, g) then
          list[#list + 1] = g
        end
      end
    end
    -- 取消 / 超时 / 返回不足时按池首依次补齐，保证三组都成型
    while #list < per and #pool > 0 do
      local g = table.remove(pool, 1)
      if not table.contains(list, g) then list[#list + 1] = g end
    end
    if #list < per then return nil end
    out[p] = list
  end
  return out
end

local function askInGroups(players, params, origAskToGeneral)
  local pools = {}
  for _, p in ipairs(players) do
    local base = paramOf(params, p, #players)
    local list = type(base) == "table" and base.generals or nil
    if type(list) ~= "table" then return nil end
    local copy = {}
    for i, g in ipairs(list) do copy[i] = g end
    pools[p] = copy
  end

  local total = {}
  for _, p in ipairs(players) do total[p] = {} end

  pcall(function()
    local room = players[1] and players[1].room
    if room and type(room.doBroadcastNotify) == "function" then
      room:doBroadcastNotify("ShowToast", Fk:translate("hx__3v3_group_toast"))
    end
  end)

  for round = 1, SIGNATURE_ROUNDS do
    local roundParams = buildRoundParams(players, params, pools, round)
    if not roundParams then return nil end
    local ret = origAskToGeneral(players, roundParams)
    if type(ret) ~= "table" then ret = {} end
    for _, p in ipairs(players) do
      local got = ret[p]
      local pool = pools[p]
      if type(got) == "table" and #got > 0 then
        local n = 0
        for _, g in ipairs(got) do
          if n >= SIGNATURE_SIZE then break end
          if (table.contains(pool, g) or freePickAllowed(p.room, g))
              and not table.contains(total[p], g) then
            table.insert(total[p], g)
            table.removeOne(pool, g)
            n = n + 1
          end
        end
      end
      -- 超时、取消或返回非法武将时，用池首补足，避免后面取不到主副将
      while #total[p] < round * SIGNATURE_SIZE and #pool > 0 do
        local g = table.remove(pool, 1)
        table.insert(total[p], g)
      end
    end
  end
  return total
end

local okHX, HX = pcall(require, "packages.bloodybattle.hxfs")
if okHX and type(HX) == "table" and type(HX.askToGeneral) == "function"
    and not HX.__hx_extra_rules_pair_patched then
  HX.__hx_extra_rules_pair_patched = true
  local origAskToGeneral = HX.askToGeneral
  HX.askToGeneral = function(players, params)
    local single = nil
    if (not players[1]) and players.class then
      single = players
      players = { players }
    end
    local first = players[1]
    local room = first and first.room
    local function clip(ret)
      -- 原版超时兜底给的是 choiceNum+1 张（多留一张换将牌），
      -- 多出来的那张会跟着进备选池，导致一方池子平白多一张、得分变负
      if type(ret) ~= "table" then return ret end
      for _, p in ipairs(players) do
        local base = paramOf(params, p, #players)
        local n = type(base) == "table" and base.choiceNum or nil
        if type(ret[p]) == "table" and type(n) == "number" and #ret[p] > n then
          ret[p] = table.slice(ret[p], 1, n)
        end
      end
      return ret
    end
    if not (room and signatureDeputyOn(room)) then
      local ret = clip(origAskToGeneral(single or players, params))
      pcall(recordPairs, players, ret)
      return ret
    end
    if oneShotGroupsOn(room) then
      local all = askAllGroups(players, params, origAskToGeneral)
      if all then
        pcall(recordPairs, players, all)
        return all
      end
      hxlog("one shot: fallback to per-round (pool too small?)")
    end
    local grouped = askInGroups(players, params, origAskToGeneral)
    if not grouped then
      local ret = clip(origAskToGeneral(single or players, params))
      pcall(recordPairs, players, ret)
      return ret
    end
    pcall(recordPairs, players, grouped)
    return grouped
  end
end

----------------------------------------------------------------------
-- 五、换将：先把本人下一组提到池首，换完再补体力、补技能与结束回合
-- 补技能受子开关 SETTING_SWAPFIX 控制（默认开），关掉即完全走官方流程
----------------------------------------------------------------------
local function getPool(room, player)
  local judge = room:getSettings("3v3roletoaaa") and player.role:startsWith("re")
      or player.role:startsWith("cool")
  if room:getSettings("3v3competition") then
    local name = judge and "@&hx__cool_generals" or "@&hx__warm_generals"
    return room:getBanner(name), name, nil
  end
  local name = judge and "@[private]&hx__cool_generals" or "@[private]&hx__warm_generals"
  local banner = room:getBanner(name)
  if type(banner) ~= "table" then return nil, name, nil end
  return banner.value, name, banner
end

local function hoistOwnPair(room, player)
  if not isDeputyRoom(room) then return end
  local data = room:getBanner(PAIR_BANNER)
  local queue = type(data) == "table" and data[player.id] or nil
  if type(queue) ~= "table" then return end

  local list, name, banner = getPool(room, player)
  if type(list) ~= "table" or #list == 0 then return end

  for _, pair in ipairs(queue) do
    local first, second = pair[1], pair[2]
    if first and table.contains(list, first)
        and (second == nil or table.contains(list, second)) then
      table.removeOne(list, first)
      table.insert(list, 1, first)
      if second then
        table.removeOne(list, second)
        table.insert(list, 2, second)
      end
      if banner then
        banner.value = list
        room:setBanner(name, banner)
      else
        room:setBanner(name, list)
      end
      return
    end
  end
end

-- 自己的回合内阵亡：只结束阶段与回合，不 shutdown 事件树，
-- 保证铁索连环的传导伤害继续结算，新将也不补触发当前阶段技能
local function endTurnAfterSwap(player)
  local room = player and player.room
  if not isModeRoom(room) then return end
  -- 总开关 + 子开关双保险：任一关闭都保持原行为
  if not masterOn(room) then return end
  if rawSetting(room, SETTING_ENDTURN) ~= true then return end
  if room.current ~= player then return end

  local GE = rawget(_G, "GameEvent")
  local logic = room.logic
  if type(GE) ~= "table" or not logic then return end

  local cur = logic:getCurrentEvent()
  if not cur or type(cur.findParent) ~= "function" then return end

  local phase = cur:findParent(GE.Phase)
  if phase and type(phase.data) == "table" then
    phase.data.phase_end = true
  end
  local turn = cur:findParent(GE.Turn)
  if turn and type(turn.data) == "table" then
    turn.data.turn_end = true
  end
end

-- 换将时清理旧将残留状态：换将复用同一个玩家对象，旧将本回合的技能使用次数、
-- 临时标记、回合末回调会残留到新将身上。这里只清「换将这个玩家自己」的残留，
-- 不碰它给其他角色挂的任何效果。
local function cleanupAfterSwap(player)
  local room = player and player.room
  local logic = room and room.logic or nil
  if not isModeRoom(room) then return end
  if not masterOn(room) then return end
  if not swapSkillFixOn(room) then
    hxlog("swap cleanup: disabled by setting")
    return
  end

  -- (0) 事件水位线：记下换将发生时的事件 id。之后 getEventsOfScope 会据此
  -- 排除换将前「以本玩家为目标」的 UseCard 事件，让胆守的 X 从换将后重新累计。
  if logic then
    pcall(room.setPlayerMark, room, player, SWAP_WATERMARK, logic.current_event_id or 0)
  end

  -- (1) 技能使用次数：只清本玩家 skillUsedHistory 里的「本回合 / 本阶段」计数，
  -- 让新将的胆守 usedSkillTimes==0 判定从零开始。不动其他玩家。
  local cleared = 0
  if type(player.skillUsedHistory) == "table" then
    for _, hist in pairs(player.skillUsedHistory) do
      if type(hist) == "table" then
        hist[Player.HistoryTurn] = 0
        hist[Player.HistoryPhase] = 0
        cleared = cleared + 1
      end
    end
  end

  -- (2) 临时标记：只清本玩家身上带 -turn / -phase 后缀的标记（胆守计数、穿屋标记等）。
  -- -round 不动（那是跨回合的），也绝不动其他角色的 mark。
  local marks = 0
  local toClear = {}
  for name, _ in pairs(player.mark or {}) do
    if type(name) == "string" and (name:find("-turn", 1, true) or name:find("-phase", 1, true)) then
      table.insert(toClear, name)
    end
  end
  for _, name in ipairs(toClear) do
    pcall(room.setPlayerMark, room, player, name, 0)
    marks = marks + 1
  end

  -- (3) 回合末回调（如穿屋把旧技能加回）：遍历当前 Turn 事件的 extra_clear，
  -- 用 debug.getupvalue 找回捕获了「本玩家」且捕获了「旧将技能名表」的 cleaner，
  -- 精确移除；捕获别的玩家、或不带技能表的回调一律保留。
  local cleaners = 0
  local okDbg, dbg = pcall(require, "debug")
  if not okDbg then dbg = debug end
  local GE = rawget(_G, "GameEvent")
  if type(dbg) == "table" and type(dbg.getupvalue) == "function"
      and type(GE) == "table" and GE.Turn and logic and type(logic.getCurrentEvent) == "function" then
    local cur = logic:getCurrentEvent()
    local turnEv = cur and type(cur.findParent) == "function" and cur:findParent(GE.Turn) or nil
    if turnEv and type(turnEv.extra_clear) == "table" then
      -- 换将后的当前技能名集合：cleaner 捕获的技能若有不在此集合里的，即旧将残留
      local curSkills = {}
      for _, n in ipairs(player:getSkillNameList()) do curSkills[n] = true end
      local kept = {}
      for _, fn in ipairs(turnEv.extra_clear) do
        local capturesPlayer, oldSkillList = false, nil
        if type(fn) == "function" then
          local i = 1
          while true do
            local _, v = dbg.getupvalue(fn, i)
            if v == nil and dbg.getupvalue(fn, i) == nil then break end
            if v == player then capturesPlayer = true end
            if type(v) == "table" then
              -- 找内容是技能名的字符串数组
              local allStr, hasOld, cnt = true, false, 0
              for k, s in pairs(v) do
                if type(k) == "number" and type(s) == "string" then
                  cnt = cnt + 1
                  if not curSkills[s] then hasOld = true end
                else
                  allStr = false
                end
              end
              if cnt > 0 and allStr and hasOld then oldSkillList = v end
            end
            i = i + 1
            if i > 32 then break end
          end
        end
        if capturesPlayer and oldSkillList then
          cleaners = cleaners + 1  -- 丢弃这个 cleaner
        else
          table.insert(kept, fn)
        end
      end
      turnEv.extra_clear = kept
    end
  end

  hxlog(("swap cleanup: id=%s hist=%d marks=%d cleaners=%d general=%s deputy=%s")
    :format(tostring(player.id), cleared, marks, cleaners,
      tostring(player.general), tostring(player.deputyGeneral)))
end

-- 驻颜快照保护：血战换将时官方会用新将的 fk.GameStart 触发驻颜的无条件
-- refresh（zhuyan.lua 的 can_refresh=Util.TrueFunc），把 mark "zhuyan" 覆盖成
-- 「刚换将那一刻」的体力/手牌。用户要的是保留「上一个武将上个结束阶段」的
-- 快照。这里在换将事件 main 执行前存下旧快照、执行后写回；没有该 mark 的
-- 角色一律不动，对无驻颜的对局零影响。
local function saveZhuyanBeforeSwap(who)
  if not who or type(who.getMark) ~= "function" then return end
  local m = who:getMark("zhuyan")
  if type(m) == "table" and m[1] ~= nil and m[2] ~= nil then
    rawset(who, "__hx_zhuyan_snapshot", { m[1], m[2] })
  else
    rawset(who, "__hx_zhuyan_snapshot", nil)
  end
end

local function restoreZhuyanAfterSwap(who)
  if not who then return end
  local m = rawget(who, "__hx_zhuyan_snapshot")
  rawset(who, "__hx_zhuyan_snapshot", nil)
  if not m then return end
  local room = who.room
  if not room or type(room.setPlayerMark) ~= "function" then return end
  pcall(room.setPlayerMark, room, who, "zhuyan", { m[1], m[2] })
  hxlog(("zhuyan restored: id=%s hp=%s hand=%s")
    :format(tostring(who.id), tostring(m[1]), tostring(m[2])))
end

local function afterSwap(who, ev)
  -- 常规路径和运行期兜底可能把事件包两层，用事件实例去重，纠正只做一次
  if ev and ev.__hx_after_swap_done then return end
  if ev then ev.__hx_after_swap_done = true end
  -- hxfs.lua 在换将事件里把当前体力写成 Fk.generals[g].hp（1/6 将就是 1），
  -- 且它跑在本文件纠正之前。这里必须无条件把上限和当前体力重算回 maxHp 口径，
  -- 否则头像体力牌会显示成 1。adjustDeputyHp 本身做了 maxHp 防御与广播。
  pcall(adjustDeputyHp, who, "swap")
  pcall(cleanupAfterSwap, who)
  pcall(endTurnAfterSwap, who)
  if who then
    hxlog(("afterSwap: id=%s general=%s deputy=%s hp=%s/%s")
      :format(tostring(who.id), tostring(who.general), tostring(who.deputyGeneral),
        tostring(who.hp), tostring(who.maxHp)))
  end
end

-- 主动 require 一次，保证无论目录扫描顺序如何，事件都已注册
pcall(require, "packages.bloodybattle.hxfs")

-- 常规路径：包加载早于 scheduler，改 _custom_events 里的 main 即可
for _, ev in ipairs(Fk._custom_events or {}) do
  if ev.name == "BloodyBattleSwap" and type(ev.m) == "function"
      and not ev.__hx_extra_rules_wrapped then
    ev.__hx_extra_rules_wrapped = true
    local orig = ev.m
    ev.m = function(self)
      local who = self and self.data and self.data.who
      if who then pcall(hoistOwnPair, who.room, who) end
      if who then pcall(saveZhuyanBeforeSwap, who) end
      local ret = orig(self)
      if who then pcall(restoreZhuyanAfterSwap, who) end
      if who then afterSwap(who, self) end
      return ret
    end
  end
end

-- 兜底：scheduler 把自定义事件构建成 GameEvent 子类发生在包加载之后，
-- 所以这条要放进运行期补装（房间第一次读设置时执行），加载当时装不上是正常的。
local function patchSwapEventClass()
  local GE = rawget(_G, "GameEvent")
  if type(GE) ~= "table" or type(GE.BloodyBattleSwap) ~= "table" then return false end
  local cls = GE.BloodyBattleSwap
  if cls.__hx_extra_rules_wrapped or type(cls.main) ~= "function" then return true end
  cls.__hx_extra_rules_wrapped = true
  local origMain = cls.main
  cls.main = function(self)
    local who = self and self.data and self.data.who
    if who then pcall(hoistOwnPair, who.room, who) end
    if who then pcall(saveZhuyanBeforeSwap, who) end
    local ret = origMain(self)
    if who then pcall(restoreZhuyanAfterSwap, who) end
    if who then afterSwap(who, self) end
    return ret
  end
  hxlog("swap event: GameEvent class patched at runtime")
  return true
end
latePatches[#latePatches + 1] = patchSwapEventClass
pcall(patchSwapEventClass)

----------------------------------------------------------------------
-- 六、牌堆：按设置替换多出来的乐不思蜀
----------------------------------------------------------------------
local function applyIndulgenceCount(room)
  if not isModeRoom(room) then return false end
  -- 乐不思蜀与双将无关，单将模式（不开副将 / 总开关关）同样生效。
  -- 口径为「减去 N 张」：不同牌堆存量不同（比赛牌堆 2、混装牌堆 5），
  -- 减的数量超过存量时按存量全减。移除顺序 方块>梅花>红桃>黑桃，
  -- 尽量把黑桃、红桃留在牌堆里（对齐「默认留一黑一红」的预期）。
  local removeN = COUNT_KEYS[room:getSettings(SETTING_COUNT)]
  if removeN == nil then removeN = 3 end
  local draw = room.draw_pile
  if type(draw) ~= "table" or type(room.printCard) ~= "function" then return false end

  local indexes = {}
  for i, id in ipairs(draw) do
    local card = Fk:getCardById(id)
    if card and card.trueName == "indulgence" then
      table.insert(indexes, i)
    end
  end
  if #indexes == 0 or removeN <= 0 then return false end
  if removeN > #indexes then removeN = #indexes end

  -- 按移除优先级排序，取前 removeN 张替换成兵粮寸断
  local removeRank = {
    [Card.Diamond] = 1,
    [Card.Club] = 2,
    [Card.Heart] = 3,
    [Card.Spade] = 4,
  }
  table.sort(indexes, function(a, b)
    local ca = Fk:getCardById(draw[a])
    local cb = Fk:getCardById(draw[b])
    local ra = removeRank[ca and ca.suit] or 9
    local rb = removeRank[cb and cb.suit] or 9
    if ra ~= rb then return ra < rb end
    return a < b
  end)

  local changed = false
  for k = removeN, 1, -1 do
    local i = indexes[k]
    local old = Fk:getCardById(draw[i])
    if old then
      local ok, new = pcall(room.printCard, room, "supply_shortage", old.suit, old.number)
      if ok and new then
        -- 被替换下来的乐不思蜀移出牌堆
        room:setCardArea(draw[i], Card.Void, nil)
        table.insert(room.void, draw[i])
        -- 新印的兵粮寸断从 Void 区挪进牌堆，占原位置
        table.removeOne(room.void, new.id)
        room:setCardArea(new.id, Card.DrawPile, nil)
        draw[i] = new.id
        changed = true
      end
    end
  end
  return changed
end

if okGL and type(GameLogic) == "table"
    and type(GameLogic.prepareDrawPile) == "function"
    and not GameLogic.__hx_extra_rules_pile_patched then
  GameLogic.__hx_extra_rules_pile_patched = true
  local origPrepare = GameLogic.prepareDrawPile
  GameLogic.prepareDrawPile = function(self)
    origPrepare(self)
    local room = self.room
    if not room then return end
    local changed = false
    pcall(function() changed = applyIndulgenceCount(room) end)
    if changed then
      room:doBroadcastNotify("PrepareDrawPile", room.draw_pile)
    end
    -- 开局广播全房称号快照：core 的 Mediator 收到 PlayerTitlesSnapshot 后逐个
    -- applyPlayerTitle 填进 Config.playerTitles，头像旁的 TitleItem 自动显示他人称号。
    pcall(function()
      if type(HX_BroadcastRoomTitles) == "function" then
        HX_BroadcastRoomTitles(room)
      end
    end)
  end
end

----------------------------------------------------------------------
-- 七、乐不思蜀改版：命中后的三种效果与牌张技能替换
----------------------------------------------------------------------
-- 本回合手牌上限等于体力上限
if type(Player) == "table" and type(Player.getMaxCards) == "function"
    and not Player.__hx_extra_rules_maxcards_wrapped then
  Player.__hx_extra_rules_maxcards_wrapped = true
  local origGetMaxCards = Player.getMaxCards
  Player.getMaxCards = function(self)
    local m = self.getMark and self:getMark(MARK_MAXHP) or 0
    if type(m) == "number" and m > 0 then
      return math.max(self.maxHp or 0, 0)
    end
    return origGetMaxCards(self)
  end
end

-- 本回合只能对自己使用牌
if type(Player) == "table" and type(Player.isProhibited) == "function"
    and not Player.__hx_extra_rules_prohibit_wrapped then
  Player.__hx_extra_rules_prohibit_wrapped = true
  local origIsProhibited = Player.isProhibited
  Player.isProhibited = function(self, to, card)
    local m = self.getMark and self:getMark(MARK_SELF) or 0
    if type(m) == "number" and m > 0 and to and to ~= self then
      return true
    end
    return origIsProhibited(self, to, card)
  end
end

local function buildIndulgenceSkill()
  if type(Fk.skills) ~= "table" or Fk.skills[SKILL_NAME] then return end
  if type(fk.CreateSkill) ~= "function" then return end

  local skel = fk.CreateSkill { name = SKILL_NAME }
  skel:addEffect("cardskill", {
    prompt = "#hx__3v3_indulgence_skill",
    mod_target_filter = function(self, player, to_select, selected, card, distance_limited)
      return to_select ~= player
    end,
    target_filter = Util.CardTargetFilter,
    target_num = 1,
    on_effect = function(self, room, effect)
      local to = effect.to
      local judge = {
        who = to,
        reason = "indulgence",
        pattern = ".|.|^heart",
      }
      room:judge(judge)
      if judge:matchPattern() then
        local kind = getEffectKind(room)
        -- 上限+2 / 英姿 只是判定失败后的补偿，跳过出牌阶段这一条仍然保留；
        -- 只有「自守」是真正的替代方案，不跳阶段。
        if kind == "maxcards2" then
          to:skip(Player.Play)
          room:addPlayerMark(to, MarkEnum.AddMaxCardsInTurn, 2)
        elseif kind == "maxhp" then
          to:skip(Player.Play)
          room:setPlayerMark(to, MARK_MAXHP, 1)
        elseif kind == "self" then
          room:setPlayerMark(to, MARK_SELF, 1)
        end
      end
      self:onNullified(room, effect)
    end,
    on_nullified = function(self, room, effect)
      room:moveCards {
        ids = room:getSubcardsByRule(effect.card, { Card.Processing }),
        toArea = Card.DiscardPile,
        moveReason = fk.ReasonUse,
      }
    end,
  })
  Fk:addSkill(skel:createSkill())
end

local function buildIndulgenceRuleSkill()
  local ruleName = "hx__3v3_indulgence_rule"
  if type(Fk.skills) ~= "table" or Fk.skills[ruleName] then return end
  if type(fk.CreateSkill) ~= "function" then return end

  local skel = fk.CreateSkill { name = ruleName }
  skel:addEffect(fk.PreCardEffect, {
    global = true,
    can_refresh = function(self, event, target, player, data)
      local room = player.room
      if not isModeRoom(room) then return false end
      if not getEffectKind(room) then return false end
      -- 与本包村规卡牌的乐不思蜀互斥，村规优先
      if room:getSettings("3v3NewCards") then return false end
      if player.seat ~= 1 then return false end
      local card = data.card
      if not card or card.trueName ~= "indulgence" then return false end
      return card.skill ~= nil and card.skill.name ~= SKILL_NAME
    end,
    on_refresh = function(self, event, target, player, data)
      data:changeCardSkill(SKILL_NAME)
    end,
  })
  Fk:addSkill(skel:createSkill())
end

pcall(buildIndulgenceSkill)
pcall(buildIndulgenceRuleSkill)

----------------------------------------------------------------------
-- 八、弃置备选武将：按组合成组弃置
----------------------------------------------------------------------
-- 原流程用 AskForGeneral 弹窗，一堆备选牌逐张点选，可以把一组双将拆开。
-- 这里把该请求换成自带的成组界面：点一张即整组选中，弃置不会拆散组合。
local THROW_FOCUS = "HX3v3_AskForThrowGeneral"
-- 展示与弃置共用一份 qml，靠 dialog 开关区分：
-- false 铺满宿主做备选池展示，true 自带外框和按钮做弃置弹窗。
local PANEL_QML = "packages/advancedpackages/qml/hx__3v3_PairPanel.qml"
local THROW_QML = PANEL_QML

local function buildThrowData(player, data)
  local room = player and player.room
  if not room then hxlog("throw skip: no room") return nil end
  if not isModeRoom(room) then hxlog("throw skip: not 3v3 mode") return nil end
  if not isDeputyRoom(room) then
    hxlog("throw skip: not deputy room, enableDeputy=" .. tostring(room:getSettings("enableDeputy"))
      .. " anjiang=" .. tostring(room:getSettings("3v3anjiang")))
    return nil
  end
  -- 比赛规则下同样按对弃置：6 人局 num=4、8 人局 num=8，池子也都是成对的
  local list, num = data[1], data[2]
  if type(list) ~= "table" or type(num) ~= "number" or num <= 0 or #list <= 0 then
    hxlog("throw skip: bad data, list=" .. type(list) .. " num=" .. tostring(num))
    return nil
  end
  -- 弃置张数必须是偶数（按组弃置）；池子允许奇数，最后一组单张也能选
  if num % 2 ~= 0 or #list < num then
    hxlog("throw skip: odd/short, num=" .. num .. " list=" .. #list)
    return nil
  end
  hxlog("throw list=" .. #list .. " num=" .. num)

  local prompt = "请弃置 " .. num .. " 张备选武将"
  pcall(function()
    local text = Fk:translate("#HX3v3_AskForThrowGeneral_tips")
    if type(text) == "string" and text ~= "" and text ~= "#HX3v3_AskForThrowGeneral_tips" then
      prompt = (text:gsub("%%arg", tostring(num)))
    end
  end)

  return {
    component = {
      url = THROW_QML,
      prop = {
        dialog = true,
        generals = list,
        -- 深层嵌套的 Lua table 经 CustomDialog prop 桥接到 QML 后可能退化成
        -- 空表，弃置弹窗的牌就全没了。这里同时给一条纯字符串通道：武将名
        -- 不含 |，用 | 拼接；QML 侧 seq() 优先切开它，table 只作兜底。
        generalsFlat = table.concat(list, "|"),
        num = num,
        prompt = prompt,
        -- 奇数体力值补偿的方式，界面据此在双将牌上画护盾或阴阳鱼
        armorOn = oddCompKind(room) == "armor",
        comp = oddCompKind(room),
      },
    },
  }
end

-- 阵亡换将：主帅要给刚阵亡的座位挑一组新的主将、副将（hxfs.lua 里发的是
-- command=AskForGeneral、data 只有 {可选武将, 选几名} 的请求）。
-- 官方那一步是 ChooseGeneralBox 逐张点选，一对主副将会被拆成两张单牌；
-- 而备选池自始至终按组排下来（弃置也是整组弃），所以这里同样换成成组界面：
-- 点中一张牌就等于定下这一组，确定后交出两人。
local SWAP_PROMPT_KEY = "hx__3v3_swap_prompt"

local function swapPrompt()
  local fallback = "请为阵亡角色选择一组武将"
  pcall(function()
    local text = Fk:translate(SWAP_PROMPT_KEY)
    if type(text) == "string" and text ~= "" and text ~= SWAP_PROMPT_KEY then
      fallback = text
    end
  end)
  return fallback
end

-- 认人：只有「阵亡换将」这一种请求的数据长这样，别把通用 askToChooseGeneral 卷进来
local function matchSwapAsk(req)
  if req.command ~= "AskForGeneral" then return nil end
  if req.focus_text and req.focus_text ~= "" then return nil end
  local room
  for _, p in ipairs(req.players or {}) do room = room or p.room end
  if not room or not masterOn(room) then return nil end
  if not rawSetting(room, "3v3competition") then return nil end
  local okd, deputy = pcall(isDeputyRoom, room)
  if not okd or not deputy then return nil end

  local pid, data
  for id, d in pairs(req.data or {}) do
    if pid then return nil end          -- 一次只处理一位主帅
    pid, data = id, d
  end
  if not pid or type(data) ~= "table" or #data ~= 2 then return nil end
  local list, num = data[1], data[2]
  if type(list) ~= "table" or type(num) ~= "number" then return nil end
  if num < 2 or num % 2 ~= 0 or #list < num then return nil end
  return pid, list, num, room
end

-- 结果是否恰好是池子里相邻的一组（换将只认这种结果）
local function isContiguousPick(list, ret, num)
  if type(ret) ~= "table" or #ret ~= num then return false end
  for start = 1, #list - num + 1 do
    local same = true
    for k = 1, num do
      if list[start + k - 1] ~= ret[k] then same = false break end
    end
    if same then return true end
  end
  return false
end

-- 拦截点放在 ask 上而不是 setData 上：
-- 1) 包加载时 Request 还没由 scheduler 注入全局，当场包装必然落空；
-- 2) ask 是所有请求的统一出口，此时 data 已由 setData 填好，一次改完两名主帅。
-- 注意：同一 Request 可能被 getResult 触发，用 done 标记避免重复处理。
local function patchThrowRequest()
  if type(Request) ~= "table" or type(Request.ask) ~= "function" then return false end
  if rawget(Request, "__hx_pair_throw_patched") then return true end
  rawset(Request, "__hx_pair_throw_patched", true)
  hxlog("Request.ask patched, command field=" .. tostring(Request.command))

  local origAsk = Request.ask
  Request.ask = function(self, ...)
    if self.command == "AskForGeneral" then
      hxlog("ask focus=" .. tostring(self.focus_text) .. " players=" .. #(self.players or {}))
    end
    -- 单将弃置兜底：血战公式写死 12=6*2，关副将后 thegeneralsNum 只按 1 倍算，
    -- 会算出「弃 6 张」把单将每方 6 张备选全弃光，随后死亡换将因池空直接判死。
    -- getSettings hook 可能没生效，这里在请求层再拦一道：单将模式把弃置数强制归零，
    -- 保留全部备选，保证阵亡后总有将可续。双将/比赛规则一律不碰。
    if self.focus_text == THROW_FOCUS and not rawget(self, "__hx_single_throw_skip") then
      local room = self.players and self.players[1] and self.players[1].room
      if room and isModeRoom(room) and rawSetting(room, "enableDeputy") ~= true
          and not room:getSettings("3v3competition") then
        rawset(self, "__hx_single_throw_skip", true)
        hxlog("throw single-general: force num=0 to keep all spares")
        for pid, d in pairs(self.data or {}) do
          if type(d) == "table" and type(d[2]) == "number" then d[2] = 0 end
        end
        if type(self.default_reply) == "table" then
          for pid in pairs(self.default_reply) do self.default_reply[pid] = {} end
        end
      end
    end
    -- 阵亡换将：换成成组界面，点一组就是一组主副将
    if self.command == "AskForGeneral" and not rawget(self, "__hx_pair_swap_done") then
      rawset(self, "__hx_pair_swap_done", true)
      local pid, list, num, room = matchSwapAsk(self)
      if pid then
        local kind = oddCompKind(room)
        local fb = table.slice(list, 1, num)
        self.data[pid] = {
          component = {
            url = THROW_QML,
            prop = {
              dialog = true,
              generals = table.simpleClone(list),
              -- 同弃置弹窗：给一条纯字符串通道兜住深层 table 桥接退化的情况
              generalsFlat = table.concat(list, "|"),
              num = num,
              prompt = swapPrompt(),
              fallback = fb,
              armorOn = kind == "armor",
              comp = kind,
            },
          },
        }
        if type(self.default_reply) == "table" then
          self.default_reply[pid] = fb
        end
        -- 复用弃置的结果兜底：少选补齐；换将这边的取消/超时也按整组算
        rawset(self, "__hx_pair_throw_meta", { [pid] = {
          list = table.simpleClone(list), num = num, force = true,
        } })
        self.command = "CustomDialog"
        -- 烧条标题：CustomDialog 命令默认显示命令名，这里改成可读的「换将」
        self.focus_text = "hx__3v3_swap_title"
        hxlog("swap replaced: pairs=" .. math.floor(#list / 2) .. " num=" .. num)
      end
    end
    if self.focus_text == THROW_FOCUS and not rawget(self, "__hx_pair_throw_done") then
      rawset(self, "__hx_pair_throw_done", true)
      local byId = {}
      for _, p in ipairs(self.players or {}) do byId[p.id] = p end

      -- 两人的备选数量相同，必须全部能换成成组界面才动手，
      -- 否则会出现一边新界面、一边旧界面的错配
      local replaced, total = {}, 0
      for pid, data in pairs(self.data or {}) do
        total = total + 1
        local rep = buildThrowData(byId[pid], data)
        if not rep then replaced = nil break end
        replaced[pid] = { rep = rep, list = data[1], num = data[2] }
      end
      if replaced and total > 0 then
        local meta = {}
        for pid, item in pairs(replaced) do
          self.data[pid] = item.rep
          -- 原流程的默认回复是 num+1 张（奇数），超时会弃掉半组；
          -- 成组界面按 num 张兜底，保证超时后备选仍是整组
          self.default_reply[pid] = table.slice(item.list, 1, item.num)
          meta[pid] = item
        end
        rawset(self, "__hx_pair_throw_meta", meta)
        self.command = "CustomDialog"
        -- 烧条标题：同上，改成可读的「弃置备选武将」
        self.focus_text = "HX3v3_AskForThrowGeneral"
        hxlog("throw replaced, players=" .. total)
      else
        hxlog("throw not replaced, data entries=" .. total)
      end
    end
    return origAsk(self, ...)
  end

  -- 结果兜底：不管玩家是超时、取消还是没选满，一律凑够 num 张。
  -- 少弃一张会让这一方池子比对方大，弃置后的分数就会算成负数。
  if type(Request.getResult) == "function" and not rawget(Request, "__hx_pair_throw_result") then
    rawset(Request, "__hx_pair_throw_result", true)
    local origGetResult = Request.getResult
    Request.getResult = function(self, player)
      local ret = origGetResult(self, player)
      local meta = rawget(self, "__hx_pair_throw_meta")
      local item = meta and player and meta[player.id]
      if not item then return ret end
      -- 换将必须有人上场，且必须是池子里相邻的一组：
      -- 取消（回空串空表）、少选、被拆开，一律退回默认那一组，
      -- 否则 hxfs 那边取 result[1]、result[2] 会拿到 nil 或半组
      if item.force then
        if isContiguousPick(item.list, ret, item.num) then return ret end
        local fixed = table.slice(item.list, 1, item.num)
        hxlog("swap result default: " .. item.num)
        if type(self.result) == "table" then self.result[player.id] = fixed end
        return fixed
      end
      if type(ret) ~= "table" or #ret == item.num then return ret end

      hxlog("throw result fix: " .. #ret .. " -> " .. item.num)
      local fixed
      if #ret > item.num then
        fixed = table.slice(ret, 1, item.num)
      else
        local picked = {}
        for _, g in ipairs(ret) do picked[g] = true end
        fixed = table.simpleClone(ret)
        for _, g in ipairs(item.list) do
          if #fixed >= item.num then break end
          if not picked[g] then
            fixed[#fixed + 1] = g
            picked[g] = true
          end
        end
      end
      if type(self.result) == "table" then self.result[player.id] = fixed end
      return fixed
    end
  end

  return true
end

latePatches[#latePatches + 1] = patchThrowRequest
pcall(patchThrowRequest)

----------------------------------------------------------------------
-- 九、备选武将展示：按「主将＋副将」成对排列
----------------------------------------------------------------------
-- 备选池在客户端有三种挂法：
--   非比赛规则      "@[private]&hx__cool_generals"   值 { value, players }
--   比赛规则        "@&hx__cool_generals"            值 数组
--   比赛规则计分牌  "@[hx__3v3_score]"               值 { 冷方池, 暖方池 }
-- 客户端对 "@&" 是 LtkLuaUtil.qml 里写死的 ViewGeneralPile，lua 改不到；
-- "@[private]&" 则一定经过客户端 lua 的 private 标记。所以比赛规则的池子在
-- 服务端广播之前就改挂成 private 形态，界面才会落到达成对组件上。
local COOL_GEN_BANNER = "@[private]&hx__cool_generals"
local WARM_GEN_BANNER = "@[private]&hx__warm_generals"
local COMP_COOL = "@&hx__cool_generals"
local COMP_WARM = "@&hx__warm_generals"
local SCORE_MARK = "hx__3v3_score"
local PILE_QML = PANEL_QML
local PAIR_LIST_QML = "packages/advancedpackages/qml/hx__3v3_PairList.qml"

-- mark 的 qml 函数在客户端执行，客户端读不到服务端包装后的设置，
-- 统一走 ClientInstance。读不到时按「已开启」处理：宁可多框一层，也不要退回散牌
local function clientSetting(key)
  local ok, ret = pcall(function() return ClientInstance:getSettings(key) end)
  if ok then return ret end
  return nil
end

local function signatureOnClient()
  local ret = clientSetting(SETTING_MASTER)
  if ret == nil then return true end
  return ret ~= false
end

local function selfId()
  local ok, id = pcall(function() return Self.id end)
  if ok then return id end
  return nil
end

-- 补偿方式：客户端只用来决定牌上画护盾还是阴阳鱼
local function compOnClient()
  local kind = normCompKind(clientSetting(SETTING_ODD))
  if kind then return kind end
  if clientSetting(SETTING_ARMOR_OLD) == true then return "armor" end
  return "off"
end

-- 池子的值是 { value, players } 形态时取出武将名数组
local function poolListOf(name, value)
  if type(name) ~= "string" or type(value) ~= "table" then return nil end
  if type(value.value) ~= "table" then return nil end
  if not (name:find("hx__cool_generals", 1, true) or name:find("hx__warm_generals", 1, true)) then
    return nil
  end
  return value.value
end

-- 客户端读「本局已禁用」展示信息（带是否双将标志）。读不到就交回 nil，
-- 面板据此决定显示与否；全程 pcall 防止客户端 banner API 差异抛错。
local function clientBanInfo()
  local ok, v = pcall(function()
    if type(ClientInstance) ~= "table" then return nil end
    if type(ClientInstance.getBanner) ~= "function" then return nil end
    return ClientInstance:getBanner(GLOBAL_BAN_BANNER .. "_info")
  end)
  if ok and type(v) == "table" and type(v.names) == "table" and #v.names > 0 then
    return { names = v.names, grouped = v.grouped == true }
  end
  return nil
end

-- 客户端读「本局已禁配」展示信息：{ pairs = {{g1,g2},...}, dual }。
-- 与 clientBanInfo 同机制，读不到交回 nil 让面板不显示。
local function clientPairInfo()
  local ok, v = pcall(function()
    if type(ClientInstance) ~= "table" then return nil end
    if type(ClientInstance.getBanner) ~= "function" then return nil end
    return ClientInstance:getBanner(GLOBAL_PAIR_BANNER .. "_info")
  end)
  if ok and type(v) == "table" and type(v.pairs) == "table" and #v.pairs > 0 then
    return { pairs = v.pairs, dual = v.dual == true }
  end
  return nil
end

-- 把客户端读到的禁用/禁配名单转成纯字符串，随 prop 注入 PILE_QML。
-- 关键：嵌套 table {names=...,grouped=...} 经 CBOR 桥接到 QML 会丢字段，
-- 备选池武将用的 cardNames 是字符串/数组通道所以显示正常；名单也走纯字符串
-- 这条已证明可靠的通道，QML 侧解析即可。
local function banInfoToFlat(bi)
  if type(bi) ~= "table" or type(bi.names) ~= "table" or #bi.names == 0 then return nil end
  return ((bi.grouped == true) and "1|" or "0|") .. table.concat(bi.names, "|")
end
local function pairInfoToFlat(pi)
  if type(pi) ~= "table" or type(pi.pairs) ~= "table" or #pi.pairs == 0 then return nil end
  local ps = {}
  for _, pr in ipairs(pi.pairs) do
    if type(pr) == "table" and #pr >= 2 then
      ps[#ps + 1] = tostring(pr[1]) .. "," .. tostring(pr[2])
    end
  end
  if #ps == 0 then return nil end
  return ((pi.dual == true) and "1|" or "0|") .. table.concat(ps, ";")
end

-- 能不能看这个池子：value.players 里没有自己就交回原组件（它会返回 nil）
-- 判定不能用 type(Self) 判表：客户端里的 Self 不是 table。
-- 取不到「谁在看」时不额外过滤，交给官方那层挡，避免因为拿不到 Self 就退回散牌
local function canSeePool(value, player)
  local pid = selfId()
  if pid == nil and type(player) == "table" then pid = player.id end
  if pid == nil then return true end
  local vis = value.players
  if type(vis) == "table" then return table.contains(vis, pid) end
  return type(player) == "table" and player.id == pid
end

-- 非比赛规则的池子走 private 标记，包装它的 qml：本方可见时换成成对组件，
-- 其余情况（卡牌堆、说明文字、别人的池子）原样交回
local function patchMarks()
  if not Fk or type(Fk.qml_marks) ~= "table" then return false end

  local spec = Fk.qml_marks["private"]
  if type(spec) ~= "table" then
    -- 标记表在包加载后一段时间才由 qml_mark.lua 填好，这里只是等它；
    -- 每次取标记都会走到这里，日志只留第一条，免得刷满整个日志文件
    if not rawget(Fk, "__hx_private_wait_logged") then
      rawset(Fk, "__hx_private_wait_logged", true)
      hxlog("private mark not ready yet, will retry")
    end
    return false
  end
  if type(spec) == "table" and type(spec.qml) == "function"
      and not rawget(spec, "__hx_pair_pile_patched") then
    rawset(spec, "__hx_pair_pile_patched", true)
    local origQml = spec.qml
    spec.qml = function(name, value, player)
      local list = poolListOf(name, value)
      if list and clientSetting(SETTING_MASTER) ~= false and canSeePool(value, player) then
        local comp = compOnClient()
        local bi = clientBanInfo()
        local pi = clientPairInfo()
        -- 若搭车广播带了名单，优先用它（与备选池同一条 CBOR 通道，最可靠）
        if type(value) == "table" and type(value.banInfo) == "table" and not bi then
          bi = value.banInfo
        end
        if type(value) == "table" and type(value.pairInfo) == "table" and not pi then
          pi = value.pairInfo
        end
        -- 纯字符串兜底：服务端搭车时已算好塞进 value，直接透传；
        -- 若没有再用本地 table 转一次。字符串不会被 CBOR 桥接丢字段。
        local bFlat = (type(value) == "table" and type(value.banFlat) == "string")
          and value.banFlat or banInfoToFlat(bi)
        local pFlat = (type(value) == "table" and type(value.pairFlat) == "string")
          and value.pairFlat or pairInfoToFlat(pi)
        hxlog(("mark hit private %s n=%d banInfo=%s pairInfo=%s bFlat=%s pFlat=%s")
          :format(tostring(name), #list, tostring(bi ~= nil), tostring(pi ~= nil),
            tostring(bFlat ~= nil), tostring(pFlat ~= nil)))
          return {
            url = PILE_QML,
            prop = { dialog = false, name = name, cardNames = list,
              armorOn = comp == "armor", comp = comp,
              banInfo = bi, pairInfo = pi,
              banFlat = bFlat, pairFlat = pFlat },
          }
      end
      if poolListOf(name, value) then
        hxlog("pool mark not shown: master=" .. tostring(clientSetting(SETTING_MASTER))
          .. " self=" .. tostring(selfId()))
      end
      return origQml(name, value, player)
    end
    hxlog("patched mark private")
  end

  -- 本局已禁配：自定义 mark，直接复用现成的双将配对视觉。
  -- value 是 info.pairs（每对 {A,B}），交给专用 QML 画成双将牌。
  if type(Fk.qml_marks["hxpair"]) ~= "table" then
    Fk.qml_marks["hxpair"] = {
      how_to_show = function(_, value)
        if type(value) ~= "table" then return " " end
        return tostring(#value)
      end,
      qml = function(name, value, player)
        local pairs = (type(value) == "table") and value or {}
        -- 纯字符串兜底：嵌套 table 经 CBOR 桥接常被拆坏，字符串最可靠
        local parts = {}
        for _, pr in ipairs(pairs) do
          if type(pr) == "table" and (#pr >= 2) then
            parts[#parts + 1] = tostring(pr[1]) .. "," .. tostring(pr[2])
          end
        end
        local flat = table.concat(parts, ";")
        return {
          url = PAIR_LIST_QML,
          prop = { name = name, pairs = pairs, pairsFlat = flat },
        }
      end,
    }
    hxlog("registered mark hxpair")
  end

  -- 比赛规则的计分牌同时是双方备选池的入口，值是 { 冷方池, 暖方池 }
  local score = Fk.qml_marks[SCORE_MARK]
  if type(score) == "table" and type(score.qml) == "function"
      and not rawget(score, "__hx_pair_pile_patched") then
    rawset(score, "__hx_pair_pile_patched", true)
    local origScore = score.qml
    score.qml = function(name, value, player)
      if type(value) == "table" and type(value[1]) == "table" and type(value[2]) == "table"
          and signatureOnClient() then
        local comp = compOnClient()
        local bi = clientBanInfo()
        local pi = clientPairInfo()
        if type(value.banInfo) == "table" and not bi then bi = value.banInfo end
        if type(value.pairInfo) == "table" and not pi then pi = value.pairInfo end
        local bFlat = (type(value.banFlat) == "string") and value.banFlat or banInfoToFlat(bi)
        local pFlat = (type(value.pairFlat) == "string") and value.pairFlat or pairInfoToFlat(pi)
        hxlog(("mark hit score banInfo=%s pairInfo=%s bFlat=%s pFlat=%s")
          :format(tostring(bi ~= nil), tostring(pi ~= nil),
            tostring(bFlat ~= nil), tostring(pFlat ~= nil)))
        return {
          url = PILE_QML,
          prop = { dialog = false, name = name, value = value,
            armorOn = comp == "armor", comp = comp,
            banInfo = bi, pairInfo = pi,
            banFlat = bFlat, pairFlat = pFlat },
        }
      end
      return origScore(name, value, player)
    end
    hxlog("patched mark score")
  end

  -- 计分文字：全歼口径下一组一分，全部击穿五分
  if type(score) == "table" and type(score.how_to_show) == "function"
      and not rawget(score, "__hx_score_patched") then
    rawset(score, "__hx_score_patched", true)
    local origShow = score.how_to_show
    score.how_to_show = function(name, value)
      if type(value) == "table" and type(value[1]) == "table" and type(value[2]) == "table"
          and clientSetting(SETTING_FULLWIN) == true then
        return ("冷方得分: %d  暖方得分: %d"):format(poolScore(value[2]), poolScore(value[1]))
      end
      return origShow(name, value)
    end
  end
  return true
end

-- qml_mark 有可能晚于本文件注册，注册时补一次
if Fk and type(Fk.addQmlMark) == "function"
    and not Fk.__hx_qmlmark_patched then
  Fk.__hx_qmlmark_patched = true
  local origAddQmlMark = Fk.addQmlMark
  Fk.addQmlMark = function(self, spec)
    local ret = origAddQmlMark(self, spec)
    pcall(patchMarks)
    return ret
  end
end

-- 客户端查询标记时兜底补一次包装。本文件的加载顺序不保证在 qml_mark 注册之后
local function hookGetQmlMark()
  if type(GetQmlMark) ~= "function" then return false end
  if rawget(_G, "__hx_qmlmark_hooked") then return true end
  rawset(_G, "__hx_qmlmark_hooked", true)
  local origGetQmlMark = GetQmlMark
  hxlog("GetQmlMark hooked")
  GetQmlMark = function(mtype, name, p)
    pcall(patchMarks)
    return origGetQmlMark(mtype, name, p)
  end
  return true
end

local function poolViewerIds(room)
  local ids = {}
  for _, p in ipairs(room.players or {}) do
    if p.id then ids[#ids + 1] = p.id end
  end
  return ids
end

-- 比赛规则的池子挂在 "@&" 上，客户端写死渲染，lua 改不到。
-- 服务端存的时候仍用原名（模式内部要读），广播给客户端的换成 private 形态。
--
-- 注意：Room 类是用 `Room:include(Fk.Base.ServerRoomBase)` 拼出来的，include
-- 是**逐个复制**方法（middleclass.lua:109），所以改 server.roombase 那张表、
-- 甚至改 Fk.Base.ServerRoomBase 都影响不到已经建好的 Room 类，
-- 必须包在 Room 这张类表上（require "ltk.server.room" 就是它）。
local function patchServerBanner()
  local okReq, RoomClass = pcall(require, "ltk.server.room")
  if not okReq or type(RoomClass) ~= "table" or type(RoomClass.setBanner) ~= "function" then
    return false
  end
  if rawget(RoomClass, "__hx_pair_pile_banner") then return true end
  rawset(RoomClass, "__hx_pair_pile_banner", true)
  local origSet = RoomClass.setBanner
  RoomClass.setBanner = function(self, name, value)
    if not masterOn(self) then return origSet(self, name, value) end
    local target
    if name == COMP_COOL then
      target = COOL_GEN_BANNER
    elseif name == COMP_WARM then
      target = WARM_GEN_BANNER
    end
    if not target then return origSet(self, name, value) end

    local list = type(value) == "table" and value or {}
    if #list % 2 == 1 then
      hxlog("pool odd, trim: " .. #list .. " -> " .. (#list - 1))
      list = table.slice(list, 1, #list - 1)
    end
    -- 原名存一份，模式后面的 getBanner("@&...") 照旧能读到
    Fk.Base.RoomBase.setBanner(self, name, list)
    hxlog("pool broadcast " .. target .. " " .. #list)
    -- 把「本局已禁用/已禁配」名单直接搭这段广播的 value 一起送出去：
    -- 备选池名单这条 CBOR 通道已被证明能到达 PairPanel，搭车最可靠，
    -- 不再依赖单独的 _info banner（那条反复读不到）。
    local broadcastValue = { value = list, players = poolViewerIds(self) }
    local okInfo, info = pcall(function() return self:getBanner(GLOBAL_BAN_BANNER .. "_info") end)
    if okInfo and type(info) == "table" then
      if type(info.names) == "table" and #info.names > 0 then
        broadcastValue.banInfo = { names = info.names, grouped = info.grouped == true }
      end
    end
    local okPair, pinfo = pcall(function() return self:getBanner(GLOBAL_PAIR_BANNER .. "_info") end)
    if okPair and type(pinfo) == "table" and type(pinfo.pairs) == "table" and #pinfo.pairs > 0 then
      broadcastValue.pairInfo = { pairs = pinfo.pairs, dual = pinfo.dual == true }
    end
    self:doBroadcastNotify("SetBanner", { target, broadcastValue })
  end
  hxlog("pool banner hooked on Room.setBanner")
  return true
end

-- 备选池每方必是偶数（每人 4 张或 2 张）。出现奇数只可能是有人超时
-- 拿到了 choiceNum+1 张，多出的那排在末尾，丢尾即可；不修的话这一方
-- 会比另一方多一张，弃置后得分算成负数。
local function patchBanners()
  if type(RoomBase) ~= "table" or type(RoomBase.setBanner) ~= "function" then return false end
  if rawget(RoomBase, "__hx_pair_pile_trim") then return true end
  rawset(RoomBase, "__hx_pair_pile_trim", true)
  local origSet = RoomBase.setBanner
  RoomBase.setBanner = function(self, name, value)
    local function trimOdd(list)
      if type(list) ~= "table" or #list % 2 == 0 then return list end
      hxlog("pool odd, trim: " .. #list .. " -> " .. (#list - 1))
      return table.slice(list, 1, #list - 1)
    end

    -- 比赛模式(3v3competition)备选池走 @&hx__cool_generals / @&hx__warm_generals
    -- 纯数组通道，且每次登场后由 hxfs.lua 重新 setBanner。这条原先没裁，
    -- 导致对面偶尔看到 5 张（末张落单）。这里与 private/score 保持同一口径。
    if name == "@&hx__cool_generals" or name == "@&hx__warm_generals" then
      if type(value) == "table" then
        local t = trimOdd(value)
        if t ~= value then value = t end
      end
    end

    if name == COOL_GEN_BANNER or name == WARM_GEN_BANNER then
      if type(value) == "table" and type(value.value) == "table" then
        local t = trimOdd(value.value)
        if t ~= value.value then
          local copy = table.simpleClone(value)
          copy.value = t
          value = copy
        else
          -- 必走 clone：下面要往 broadcastValue 塞 banInfo/pairInfo，
          -- 不能污染模式自己持有的那张 value 表
          local copy = table.simpleClone(value)
          value = copy
        end
        hxlog((name == COOL_GEN_BANNER and "cool pool=" or "warm pool=") .. #t)
        -- 本局已禁用 / 本局已禁配：搭备选池广播这条已证明可靠的通道送给面板。
        -- 关键教训：不要挂在 require("ltk.server.room").setBanner 上——include 是
        -- 逐方法复制，room 实例实际走的是 RoomBase.setBanner（就是这里），
        -- 挂在那张类表上的 hook 从不命中，名单永远发不出去。
        local okB, binfo = pcall(function() return self:getBanner(GLOBAL_BAN_BANNER .. "_info") end)
        if okB and type(binfo) == "table" and type(binfo.names) == "table" and #binfo.names > 0 then
          value.banInfo = { names = binfo.names, grouped = binfo.grouped == true }
          -- 纯字符串兜底：嵌套 table 桥接会丢字段，字符串不会（与 cardNames 同通道）
          value.banFlat = ((binfo.grouped == true) and "1|" or "0|") .. table.concat(binfo.names, "|")
          -- 名单只走 banFlat 字符串 prop（不塞进武将数组，避免污染牌面配对）
        end
        local okP, pinfo = pcall(function() return self:getBanner(GLOBAL_PAIR_BANNER .. "_info") end)
        if okP and type(pinfo) == "table" and type(pinfo.pairs) == "table" and #pinfo.pairs > 0 then
          value.pairInfo = { pairs = pinfo.pairs, dual = pinfo.dual == true }
          local parts = {}
          for _, pr in ipairs(pinfo.pairs) do
            if type(pr) == "table" and #pr >= 2 then
              parts[#parts + 1] = tostring(pr[1]) .. "," .. tostring(pr[2])
            end
          end
          value.pairFlat = ((pinfo.dual == true) and "1|" or "0|") .. table.concat(parts, ";")
        end
        if value.banInfo or value.pairInfo then
          hxlog(("pool carry: ban=%s pair=%s"):format(
            tostring(value.banInfo ~= nil), tostring(value.pairInfo ~= nil)))
        end
      end
    end
    -- 名单同时在独立的 _flat 字符串通道再广播一次：即便备选池 value 的
    -- 嵌套 table 经桥接丢字段，QML 的 pollBanners 也能从 getBanner 读到。
    do
      local okB, binfo = pcall(function() return self:getBanner(GLOBAL_BAN_BANNER .. "_info") end)
      if okB and type(binfo) == "table" and type(binfo.names) == "table" and #binfo.names > 0 then
        local flat = ((binfo.grouped == true) and "1|" or "0|") .. table.concat(binfo.names, "|")
        pcall(function() self:doBroadcastNotify("SetBanner", { GLOBAL_BAN_BANNER .. "_flat", flat }) end)
      end
      local okP, pinfo = pcall(function() return self:getBanner(GLOBAL_PAIR_BANNER .. "_info") end)
      if okP and type(pinfo) == "table" and type(pinfo.pairs) == "table" and #pinfo.pairs > 0 then
        local parts = {}
        for _, pr in ipairs(pinfo.pairs) do
          if type(pr) == "table" and #pr >= 2 then
            parts[#parts + 1] = tostring(pr[1]) .. "," .. tostring(pr[2])
          end
        end
        local pflat = ((pinfo.dual == true) and "1|" or "0|") .. table.concat(parts, ";")
        pcall(function() self:doBroadcastNotify("SetBanner", { GLOBAL_PAIR_BANNER .. "_flat", pflat }) end)
      end
    end
    -- 比赛规则：客户端备选池走计分牌 @[hx__3v3_score] 的 { 冷方池, 暖方池 }。
    -- 这条路径原先没做奇偶裁剪，托管/超时兜底给 num+1 张时会漏出奇数池，
    -- 双将下就表现为某一方备选武将变成 5 张（成组弃置会出现落单牌）。
    -- 这里对两方各自裁成偶数，和上面 private/@& 池保持同一口径。
    if name == "@[hx__3v3_score]" or name == SCORE_MARK then
      if type(value) == "table" and type(value[1]) == "table"
          and type(value[2]) == "table" then
        local a, b = trimOdd(value[1]), trimOdd(value[2])
        if a ~= value[1] or b ~= value[2] then
          local copy = table.simpleClone(value)
          copy[1], copy[2] = a, b
          value = copy
          hxlog(("score pool trim: cool=%d warm=%d"):format(#a, #b))
        end
      end
    end
    return origSet(self, name, value)
  end
  return true
end

hookGetQmlMark()
latePatches[#latePatches + 1] = hookGetQmlMark
latePatches[#latePatches + 1] = patchMarks
latePatches[#latePatches + 1] = patchServerBanner
latePatches[#latePatches + 1] = patchBanners
pcall(patchMarks)
pcall(patchServerBanner)
pcall(patchBanners)

----------------------------------------------------------------------
-- 十、双禁将方案：把第二套方案的禁将并进本房间
----------------------------------------------------------------------
-- 禁将方案存在客户端配置的 disableSchemes 里，每套含 banPkg（包内白名单）、
-- normalPkg（单将黑名单）、banCardPkg（禁包）。方案只存在房主本机，
-- 连别人的服务器建房时那台机器上没有这份文件，所以由客户端进房时
-- 通过 notifyServer 把方案送到服务端，服务端存进房间备用；
-- 读不到网络数据时才退回读本机文件（自己建房的情况）。
-- 禁用名单本身挂在 room.disabled_generals / disabled_packs 上，
-- Fk:canUseGeneral 与 Room:makeGeneralPile 都照着它过滤，属于官方已有机制。
local CONF_FILE = "freekill.client.config.json"
local BAN_CMD = "hx_ban_scheme"

local function readClientConf()
  local okOpen, f = pcall(io.open, CONF_FILE, "r")
  if okOpen and f then
    local okRead, text = pcall(f.read, f, "a")
    f:close()
    if okRead and type(text) == "string" then
      local okDecode, conf = pcall(json.decode, text)
      if okDecode and type(conf) == "table" then return conf end
    end
  end
  -- 端口版/打包版里 CWD 可能不在根目录，退回启动时读进全局的那份
  if type(Config) == "table" then return Config end
  return nil
end

local function generalsOfPackage(pkg)
  local ret = {}
  for name, general in pairs(Fk.generals or {}) do
    local pack = type(general) == "table" and general.package or nil
    if type(pack) == "table" and pack.name == pkg then ret[#ret + 1] = name end
  end
  return ret
end

-- 一套方案折算成「禁用武将」「禁用包」两张表，算法与建房时的客户端一致：
-- banPkg 里名单为空表示整包禁掉，非空则包内未列出的将都被禁。
local function banSetsOf(scheme)
  local gens, packs = {}, {}
  if type(scheme) ~= "table" then return gens, packs end

  for pkg, allowed in pairs(type(scheme.banPkg) == "table" and scheme.banPkg or {}) do
    local list = type(allowed) == "table" and allowed or {}
    if #list == 0 then
      packs[pkg] = true
    else
      local keep = {}
      for _, g in ipairs(list) do keep[g] = true end
      for _, g in ipairs(generalsOfPackage(pkg)) do
        if not keep[g] then gens[g] = true end
      end
    end
  end

  for _, list in pairs(type(scheme.normalPkg) == "table" and scheme.normalPkg or {}) do
    for _, g in ipairs(type(list) == "table" and list or {}) do
      if type(g) == "string" then gens[g] = true end
    end
  end

  for _, pkg in ipairs(type(scheme.banCardPkg) == "table" and scheme.banCardPkg or {}) do
    if type(pkg) == "string" then packs[pkg] = true end
  end

  return gens, packs
end

-- 方案名：方案自己起的名字优先，没起名就按序号兜底
local function schemeNameOf(schemes, idx)
  local s = type(schemes) == "table" and idx and schemes[idx] or nil
  local name = type(s) == "table" and s.name or nil
  if type(name) == "string" and name ~= "" then return name end
  return "方案 " .. tostring(idx or "?")
end

-- 方案要在客户端与服务端之间传，走的是 notifyServer 那条请求通道：
-- 服务端会把整条请求按逗号切开，所以载荷里不能出现逗号。
-- 这里改用 ; 分段、| 分包、+ 分将、= 连接包名与白名单；
-- 将名与包名都是标识符，不含这几个符号，可以安全往返。
local function splitPlain(s, sep)
  local out = {}
  if type(s) ~= "string" or s == "" then return out end
  local start = 1
  while true do
    local i = s:find(sep, start, true)
    if not i then
      out[#out + 1] = s:sub(start)
      break
    end
    out[#out + 1] = s:sub(start, i - 1)
    start = i + #sep
  end
  return out
end

local function encodeScheme(scheme)
  local wp = {}
  for pkg, allowed in pairs(type(scheme.banPkg) == "table" and scheme.banPkg or {}) do
    local list = {}
    for _, g in ipairs(type(allowed) == "table" and allowed or {}) do
      if type(g) == "string" then list[#list + 1] = g end
    end
    wp[#wp + 1] = pkg .. "=" .. table.concat(list, "+")
  end
  local np = {}
  for _, list in pairs(type(scheme.normalPkg) == "table" and scheme.normalPkg or {}) do
    for _, g in ipairs(type(list) == "table" and list or {}) do
      if type(g) == "string" then np[#np + 1] = g end
    end
  end
  local cp = {}
  for _, pkg in ipairs(type(scheme.banCardPkg) == "table" and scheme.banCardPkg or {}) do
    if type(pkg) == "string" then cp[#cp + 1] = pkg end
  end
  return table.concat(wp, "|") .. ";" .. table.concat(np, "+") .. ";" .. table.concat(cp, "+")
end

local function decodeScheme(wp, np, cp)
  local scheme = { banPkg = {}, normalPkg = {}, banCardPkg = {} }
  for _, item in ipairs(splitPlain(wp, "|")) do
    local eq = item:find("=", 1, true)
    if eq then
      local list = {}
      for _, g in ipairs(splitPlain(item:sub(eq + 1), "+")) do
        if g ~= "" then list[#list + 1] = g end
      end
      scheme.banPkg[item:sub(1, eq - 1)] = list
    end
  end
  local ng = {}
  for _, g in ipairs(splitPlain(np, "+")) do
    if g ~= "" then ng[#ng + 1] = g end
  end
  if #ng > 0 then scheme.normalPkg.merged = ng end
  for _, pkg in ipairs(splitPlain(cp, "+")) do
    if pkg ~= "" then scheme.banCardPkg[#scheme.banCardPkg + 1] = pkg end
  end
  return scheme
end

-- 客户端：进房后把本机的方案表整份送到服务端。方案随时可能改动，
-- 所以每次进房都现读一遍 Config，而不是在启动时缓存。
local function hxSendBanSchemes()
  -- 2026-11-17：0.1.17 服务端的 C++ 房间命令是白名单制，hx_ban_scheme 不在
  -- 名单里，方案传不上去；且该包经此客户端发出后服务端 CBOR 解码失败
  -- （Malformed data），直接把玩家踢下线。故停用网络发送，方案改由服务端
  -- 读取同目录 freekill.client.config.json 获得，功能不受影响。
  do return false end
  if type(Config) ~= "table" then return false end
  local schemes = Config.disableSchemes
  if type(schemes) ~= "table" then return false end
  local me = rawget(_G, "Self")
  if type(me) ~= "table" then return false end
  local ci = rawget(_G, "ClientInstance")
  if type(ci) ~= "table" or not ci.client then return false end

  -- 只发房主的：别人发的会把房主的方案盖掉。
  -- 进房那一刻房主身份可能还没下发，此时房间里只有自己一个人，
  -- 这种情况同样是房主，照发；等身份通知到了还会再发一次。
  if me.owner ~= true then
    local players = ci.players
    if type(players) ~= "table" or #players > 1 then return false end
  end

  local cur = (tonumber(Config.currentDisableIdx) or 0) + 1
  local sent = 0
  for i, scheme in ipairs(schemes) do
    if type(scheme) == "table" then
      local payload = i .. ";" .. cur .. ";" .. encodeScheme(scheme)
      -- 同一份数据按两种写法各发一次：一种是命令名加参数分开给，
      -- 一种是像官方 qml 那样拼成一整条命令串。C++ 那边怎么拼请求
      -- 这里看不到，两条都发，服务端收到哪条都能解析，同序号后到覆盖先到。
      if pcall(ci.client.notifyServer, ci.client, BAN_CMD, payload) then
        sent = sent + 1
      end
      pcall(ci.client.notifyServer, ci.client, BAN_CMD .. "," .. payload, "")
    end
  end
  hxlog(("double ban: sent %d scheme(s) to server"):format(sent))
  return sent > 0
end

-- 服务端：收下房主送来的方案，存在房间上等开局取用。
-- data 是切好的请求列表：1 号位发送者 id，2 号位命令名，之后是参数。
-- 头部几个位置随手写死过一版，这里按下标往后找带 ; 的那段，不赌位置。
local function hxReceiveBanSchemes(room, sender, data)
  if type(room) ~= "table" or type(data) ~= "table" then return end
  local payload
  for i = 3, #data do
    local v = data[i]
    if type(v) == "string" and v:find(";", 1, true) then payload = v; break end
  end
  if not payload then return end
  payload = payload:gsub('^"+', ""):gsub('"+$', "")
  local parts = splitPlain(payload, ";")
  local idx = tonumber(parts[1])
  if not idx or idx < 1 then return end
  room.__hx_ban_schemes = room.__hx_ban_schemes or {}
  room.__hx_ban_schemes[idx] = decodeScheme(parts[3], parts[4], parts[5])
  room.__hx_ban_cur = tonumber(parts[2]) or 0
  hxlog(("double ban: server got scheme %d from %s"):format(idx, tostring(sender)))
end

-- 客户端钩子：只让房主发，别人发的会跟房主的方案打架。
-- 包在 Client 类上而不是回调表上，因为回调在 initialize 里就绑定了旧引用；
-- 本文件在大厅阶段加载，早于第一次进房，改类方法才能被 bind 进去。
-- 进房、换房、房主身份通知三处都挂，任一处先到就把方案发出去。
local function patchClientSender()
  local Client = rawget(_G, "Client")
  if type(Client) ~= "table" or type(Client.enterRoom) ~= "function" then return false end
  if rawget(Client, "__hx_ban_sender") then return true end
  rawset(Client, "__hx_ban_sender", true)

  local function wrap(name)
    local orig = Client[name]
    if type(orig) ~= "function" then return end
    Client[name] = function(self, ...)
      local ret = orig(self, ...)
      pcall(hxSendBanSchemes)
      return ret
    end
  end

  wrap("enterRoom")
  wrap("changeRoom")
  wrap("changeRoomOwner")
  hxlog("double ban: client sender hooked")
  return true
end

local function applyDoubleBan(room)
  if type(room) ~= "table" then return false end
  if not masterOn(room) then return false end
  if rawSetting(room, SETTING_DOUBLEBAN) ~= true then return false end
  -- 并进去的名单本来就会去重，重复调用不会重复生效，
  -- 所以这里不设一次性标记：这一局没拿到方案，下一局还有机会。
  local numB = BAN_SCHEME_KEYS[rawSetting(room, SETTING_BANSCHEME) or DEFAULT_BAN_SCHEME_KEY]
  if not numB then
    hxlog("double ban: second scheme not chosen")
    return false
  end

  -- 方案来源优先级：
  --   1) 房主通过 LobbyTask 推到服务端的玩家专属槽（新通道，跨机可用）；
  --   2) 旧 hx_ban_scheme 命令存下的 room.__hx_ban_schemes（已停用，留兼容）；
  --   3) 服务端本机配置文件（仅单机/服务端就是房主时才对得上）。
  -- 之前只走 3)，服务端读的是它自己机器上的 2 套旧方案，房主客户端却已有
  -- 8 套+，选第 17/19 套时 scheme missing，双禁将/双池整体失效。
  local schemes, numA = nil, nil
  local ownerId, ownerName = nil, nil
  if type(room.getOwner) == "function" then
    local okO, owner = pcall(room.getOwner, room)
    if okO and type(owner) == "table" then
      ownerId = owner.id
      -- serverPlayer 提供 getScreenName（asio 版与 TaskPlayer 同名方法）
      if type(owner.getScreenName) == "function" then
        local okN, n = pcall(owner.getScreenName, owner)
        if okN and n then ownerName = tostring(n) end
      end
    end
  end
  -- 依次回退：owner.id → 房主昵称 → 最近一次推送槽。
  -- 大厅 tp.id 与房间 owner.id 不同域，单靠 id 命中不了，故必须留后两条。
  local slot = nil
  if ownerId then slot = HX_PLAYER_BAN_SCHEMES[ownerId] end
  if not slot and ownerName then slot = HX_PLAYER_BAN_BY_NAME[ownerName] end
  if not slot then slot = HX_LAST_PUSHED_SCHEMES end
  if type(slot) == "table" and type(slot.schemes) == "table" and #slot.schemes > 0 then
    schemes = slot.schemes
    numA = tonumber(slot.cur) or 1
    hxlog(("double ban: use pushed schemes owner=%s name=%s (%d)")
      :format(tostring(ownerId), tostring(ownerName), #schemes))
  end
  if not schemes and type(room.__hx_ban_schemes) == "table"
      and next(room.__hx_ban_schemes) ~= nil then
    schemes = room.__hx_ban_schemes
    numA = tonumber(room.__hx_ban_cur) or 0
  end
  if not schemes then
    local conf = readClientConf()
    schemes = conf and conf.disableSchemes
    -- 配置里的 currentDisableIdx 是 0 起算，界面上说的是第 N 套
    numA = (tonumber(conf and conf.currentDisableIdx) or 0) + 1
  end
  if type(schemes) ~= "table" then
    hxlog("double ban: no scheme data (client sent none, config unreadable)")
    return false
  end
  if numA == numB then
    hxlog("double ban: same scheme " .. numB .. ", skipped")
    return false
  end
  local schemeB = schemes[numB]
  if type(schemeB) ~= "table" then
    hxlog(("double ban: scheme %d missing (have %d)")
      :format(numB, #schemes))
    return false
  end

  local gens, packs = banSetsOf(schemeB)

  -- 记下两套方案：A 是房间此刻的禁将（双禁将还没并进来），B 是第二套。
  -- A 只记第一次：makeGeneralPile 可能被调用多次，第二次时房间里可能
  -- 已经并进了 B，再记就把两套混成一套了。
  if type(room.__hx_banA) ~= "table" then
    local ag, ap = {}, {}
    for _, g in ipairs(room.disabled_generals or {}) do ag[g] = true end
    for _, pkg in ipairs(room.disabled_packs or {}) do ap[pkg] = true end
    room.__hx_banA = { gens = ag, packs = ap }
  end
  room.__hx_banB = { gens = gens, packs = packs }
  -- 两池显示名固定为「将池A / 将池B」，不再跟方案自己的 name 走。
  -- 方案名常因改配置、服务端快照不一致而对不上，固定名直观且永不错位。
  -- 设置下拉里仍保留各方案自己的名字（refreshBanSchemeModel），供选择区分。
  room.__hx_ban_names = {
    a = "将池A",
    b = "将池B",
  }

  -- 双候选池：B 不并进房间，选将时单独成池（见 applyDualPools）
  if rawSetting(room, SETTING_DUALPOOL) == true then
    hxlog(("dual pool: A=%s B=%s kept separate")
      :format(room.__hx_ban_names.a, room.__hx_ban_names.b))
    return true
  end

  local roomGens, roomPacks = room.disabled_generals, room.disabled_packs
  local addedGen, addedPack = 0, 0

  if type(roomGens) == "table" then
    for g in pairs(gens) do
      if not table.contains(roomGens, g) then
        roomGens[#roomGens + 1] = g
        addedGen = addedGen + 1
      end
    end
  end
  if type(roomPacks) == "table" then
    for pkg in pairs(packs) do
      if not table.contains(roomPacks, pkg) then
        roomPacks[#roomPacks + 1] = pkg
        addedPack = addedPack + 1
      end
    end
  end

  hxlog(("double ban: cur=%d second=%d +%d gens +%d packs"):format(
    numA, numB, addedGen, addedPack))
  return true
end

----------------------------------------------------------------------
-- 十·五、双禁将的子功能：选将时两个候选池
----------------------------------------------------------------------
-- 池 A 用房间原本的禁将（当前方案）过滤，池 B 只按第二套方案过滤。
-- 两池各取一半候选合成一份候选表交给叫将流程，切分点与两个方案名
-- 一并下发给选将界面（poolSplit / poolNames），由界面分组并标名。
local function dualPoolOn(room)
  if not masterOn(room) then return false end
  if rawSetting(room, SETTING_DOUBLEBAN) ~= true then return false end
  if rawSetting(room, SETTING_DUALPOOL) ~= true then return false end
  return type(room.__hx_banB) == "table" and type(room.__hx_ban_names) == "table"
end

-- 按一张禁将表列出可用武将，隐藏将照 Fk:canUseGeneral 的做法排除
local function generalsAllowedBy(banGens, banPacks)
  local list = {}
  for name, general in pairs(Fk.generals or {}) do
    local pack = type(general) == "table" and general.package or nil
    local pkgName = type(pack) == "table" and pack.name or nil
    if type(general) == "table" and not general.hidden and not general.total_hidden
        and not (pkgName and banPacks[pkgName]) and not banGens[name] then
      list[#list + 1] = name
    end
  end
  return list
end

-- 从池里随机取 n 张：同 trueName 只留一张，已用过的跳过
local function takeFromPool(pool, n, used, out)
  if type(pool) ~= "table" or n <= 0 then return 0 end
  local copy = table.simpleClone(pool)
  table.shuffle(copy)
  local taken = 0
  for _, name in ipairs(copy) do
    if taken >= n then break end
    local general = Fk.generals[name]
    local trueName = general and general.trueName or name
    if not used[trueName] then
      used[trueName] = true
      out[#out + 1] = name
      taken = taken + 1
    end
  end
  return taken
end

-- 把每名玩家的候选表换掉：前半取自池 A，后半取自池 B。
-- 玩家仍在这两池合起来的候选里挑够张数，界面只负责分组与标名。
local function applyDualPools(players, params)
  if type(players) ~= "table" or type(params) ~= "table" or not players[1] then
    return false
  end
  local room = players[1].room
  if not dualPoolOn(room) then return false end
  -- 队友通框选将走的是另一套界面（hx__3v3_sel），候选表结构也不同，暂不拆池
  if room:getSettings("2v2GeneralChoose") then
    hxlog("dual pool: skipped, 2v2 general choose uses another ui")
    return false
  end

  local banA = type(room.__hx_banA) == "table" and room.__hx_banA or {}
  local poolA = generalsAllowedBy(banA.gens or {}, banA.packs or {})
  local poolB = generalsAllowedBy(room.__hx_banB.gens or {}, room.__hx_banB.packs or {})
  if #poolA == 0 or #poolB == 0 then
    hxlog(("dual pool: empty pool A=%d B=%d"):format(#poolA, #poolB))
    return false
  end

  -- 池 B 先挑「A 禁、B 不禁」的将：这一批才是两套方案的差别所在，
  -- 摆出来才看得出第二个池不是第一个池的翻版；不够再用两套都允许的补。
  local inA = {}
  for _, name in ipairs(poolA) do inA[name] = true end
  local poolBOnly, poolBRest = {}, {}
  for _, name in ipairs(poolB) do
    if inA[name] then
      poolBRest[#poolBRest + 1] = name
    else
      poolBOnly[#poolBOnly + 1] = name
    end
  end

  local used, touched = {}, 0
  local totals = { a = 0, b = 0 }
  for _, player in ipairs(players) do
    local data = (#players == 1) and (params[player.id] or params) or params[player.id]
    local list = type(data) == "table" and data.generals or nil
    if type(list) == "table" and #list >= 2 then
      local total = #list
      local picked = {}
      local gotA = takeFromPool(poolA, math.ceil(total / 2), used, picked)
      local gotB = takeFromPool(poolBOnly, total - gotA, used, picked)
      if gotA + gotB < total then
        gotB = gotB + takeFromPool(poolBRest, total - gotA - gotB, used, picked)
      end
      -- 池子不够时用原候选补齐，避免有人的候选变少
      if #picked < total then
        for _, name in ipairs(list) do
          if #picked >= total then break end
          if not table.contains(picked, name) then table.insert(picked, name) end
        end
      end
      data.generals = picked
      data.poolSplit = math.min(gotA, #picked)
      data.poolNames = { room.__hx_ban_names.a, room.__hx_ban_names.b }
      -- 池 A 的具体名单记在房间上：特色双将要一轮一轮地选，
      -- 每一轮的剩余候选都要重新算一次 A 池还剩几张（见 buildRoundParams）
      local aNames = {}
      for i = 1, data.poolSplit do aNames[i] = picked[i] end
      local maps = room.__hx_dual_pool_a or {}
      maps[player.id] = aNames
      room.__hx_dual_pool_a = maps

      -- 换进来的武将不在 chooseGenerals 记的名单里，补上队伍与归属；
      -- 被换掉的旧候选要一并删掉，否则统计里会多出几个「未选取」。
      local gdata = room:getBanner("hx_bloodybattle_generalsData") or {}
      for _, name in ipairs(list) do
        if not table.contains(picked, name) then
          local old = gdata[name]
          if type(old) == "table" and old.pid == player.id and not old.ontype then
            gdata[name] = nil
          end
        end
      end
      for _, name in ipairs(picked) do
        if type(gdata[name]) ~= "table" then
          gdata[name] = {
            team = player.role:startsWith("cool") and "cool" or "warm",
            pid = player.id,
          }
        end
      end
      room:setBanner("hx_bloodybattle_generalsData", gdata)

      touched = touched + 1
      totals.a = totals.a + gotA
      totals.b = totals.b + gotB
    end
  end

  if touched == 0 then return false end
  hxlog(("dual pool: A=%s(%d) B=%s(%d/%d exclusive) players=%d picked=%d/%d")
    :format(room.__hx_ban_names.a, #poolA, room.__hx_ban_names.b, #poolB,
      #poolBOnly, touched, totals.a, totals.b))
  return true
end

-- HX.askToGeneral 是所有常规选将（含 3v3 首发三组）的唯一入口，
-- 在它把候选表交给界面之前替换掉即可，不必改模式文件里的取将逻辑。
local function patchDualPools()
  local ok, HXFS = pcall(require, "packages.bloodybattle.hxfs")
  if not ok or type(HXFS) ~= "table" or type(HXFS.askToGeneral) ~= "function" then
    return false
  end
  if rawget(HXFS, "__hx_dual_pool") then return true end
  rawset(HXFS, "__hx_dual_pool", true)
  local orig = HXFS.askToGeneral
  HXFS.askToGeneral = function(players, params)
    pcall(applyDualPools, players, params)
    return orig(players, params)
  end
  hxlog("dual pool: askToGeneral hooked")
  return true
end

----------------------------------------------------------------------
-- 九·五、本局全体禁将 + 双将禁配
----------------------------------------------------------------------
-- 两个功能都包在 askToGeneral 最外层：禁将先剔除候选（内层双池/分组才用到
-- 干净候选），禁配在最终结果上校验同组同标号。二者各自独立开关、互不依赖。

-- 禁将数量选项（ComboRow 存的是翻译键本身）
local GLOBAL_BAN_COUNT_KEYS = {
  hx_global_ban_count_1 = 1,
  hx_global_ban_count_2 = 2,
  hx_global_ban_count_3 = 3,
  hx_global_ban_count_4 = 4,
}
local function globalBanCount(room)
  local v = rawSetting(room, SETTING_GLOBALBANCOUNT)
  local n = GLOBAL_BAN_COUNT_KEYS[v] or GLOBAL_BAN_COUNT_KEYS[v]
  if type(n) == "number" then return n end
  -- 兼容直接存数字的情况
  n = tonumber(v)
  if n and n >= 1 and n <= 4 then return math.floor(n) end
  return 1
end

local function globalBanOn(room)
  if not isModeRoom(room) then return false end
  return rawSetting(room, SETTING_GLOBALBAN) == true
end

local function noPairOn(room)
  if not masterOn(room) then return false end
  return rawSetting(room, SETTING_NOPAIR) == true
end

-- 读房主禁配方案列表：优先 LobbyTask 推送槽（跨机可用），再回退本机配置。
local function readPairSchemes(room)
  local schemes, numA = nil, 1
  local ownerId, ownerName = nil, nil
  if type(room.getOwner) == "function" then
    local ok, owner = pcall(room.getOwner, room)
    if ok and owner then
      ownerId = owner.id
      if type(owner.getScreenName) == "function" then
        local okN, nm = pcall(owner.getScreenName, owner)
        if okN then ownerName = tostring(nm) end
      end
    end
  end
  local slot = ownerId and HX_PLAYER_PAIR_SCHEMES[ownerId] or nil
  if not slot and ownerName then slot = HX_PLAYER_PAIR_BY_NAME[ownerName] end
  if not slot then slot = HX_LAST_PUSHED_PAIRS end
  if type(slot) == "table" and type(slot.schemes) == "table" and #slot.schemes > 0 then
    schemes = slot.schemes
    numA = tonumber(slot.cur) or 1
  end
  if not schemes then
    schemes = readPairConfSchemes()
    local conf = readClientConf()
    numA = (tonumber(conf and conf.currentPairIdx) or 0) + 1
  end
  return schemes, numA
end

-- 取当前生效的禁配方案，折成「将名 -> 标号」映射。
-- pairs 下标即标号：pairs[1] 两将标号 1，pairs[2] 标号 2 ...
local function pairLabelMapOf(room)
  local map = {}
  -- 用管理窗口里当前选中的方案（房主 push_pairs 推的 cur），
  -- 不再依赖已删除的「禁配方案」下拉框 SETTING_PAIRSCHEME。
  local schemes, idx = readPairSchemes(room)
  if type(schemes) ~= "table" then return map end
  idx = tonumber(idx) or 1
  local s = schemes[idx] or schemes[1]
  if type(s) ~= "table" or type(s.pairs) ~= "table" then return map end
  for label, pair in ipairs(s.pairs) do
    if type(pair) == "table" then
      for _, g in ipairs(pair) do
        if type(g) == "string" then map[g] = label end
      end
    end
  end
  return map
end

-- 把当前生效的禁配方案发布到房间 banner，客户端备选面板据此显示
-- 「本局已禁配」。禁配开关关闭时发布空表，清掉上一局残留。
-- dual=true 表示这套方案是「双禁将方案」模式（每组一将来自 A 池、一将来自 B 池）。
local function publishPairInfo(room)
  if type(room) ~= "table" or type(room.setBanner) ~= "function" then return end
  local info = { pairs = {}, dual = false }
  hxlog(("pair publish: master=%s noPair=%s"):format(
    tostring(masterOn(room)), tostring(noPairOn(room))))
  if noPairOn(room) then
    local schemes, idx = readPairSchemes(room)
    local s = type(schemes) == "table" and (schemes[idx] or schemes[1]) or nil
    if type(s) == "table" then
      if type(s.pairs) == "table" then info.pairs = s.pairs end
      info.dual = s.dual == true
      hxlog(("pair publish: scheme found pairs=%d dual=%s"):format(
        #info.pairs, tostring(info.dual)))
    else
      hxlog("pair publish: no scheme (s is nil/not table)")
    end
  end
  hxlog(("pair publish: final pairs=%d -> @& banner"):format(#info.pairs))
  -- 官方 @& banner：Room 场景常驻显示「本局已禁配 (N)」，点开看名单
  local pairView = {}
  local pairSeen = {}
  for _, pair in ipairs(info.pairs) do
    if type(pair) == "table" then
      for _, g in ipairs(pair) do
        -- 官方 @& banner 走 ViewGeneralPile，每个元素必须是合法武将名；
        -- 若把两个将名拼成 "A x B"，createGeneralCardModel 会当成不存在的
        -- 武将，渲染成两个代号叠加的乱码。故逐将拆成独立元素并去重。
        if type(g) == "string" and g ~= "" and not pairSeen[g] then
          pairSeen[g] = true
          pairView[#pairView + 1] = g
        end
      end
    end
  end
  -- 现成双将配对 UI：用 @[hxpair]& 自定义 mark，把每对原样传成 {A,B} 数组，
  -- 交给 hx__3v3_PairList.qml 画成一张双将牌（左主将右副将），
  -- 不再把 "A x B" 拼成单个假武将名（那会被官方 ViewGeneralPile 渲染成乱码）。
  if #info.pairs > 0 then
    pcall(room.setBanner, room, "@[hxpair]&hx__3v3_pair_list", info.pairs)
    pcall(room.setBanner, room, "@&hx__3v3_pair_list", nil)
  else
    pcall(room.setBanner, room, "@[hxpair]&hx__3v3_pair_list", nil)
    pcall(room.setBanner, room, "@&hx__3v3_pair_list", nil)
  end
  pcall(room.setBanner, room, GLOBAL_PAIR_BANNER .. "_info", info)
  -- 纯字符串通道，避开嵌套 table 桥接：每组用逗号连两个将名，组间用分号，
  -- 首字符 1=双方案/0=单方案。例："1|a,b;c,d"
  local parts = {}
  for _, pair in ipairs(info.pairs) do
    if type(pair) == "table" and #pair >= 2 then
      parts[#parts + 1] = tostring(pair[1]) .. "," .. tostring(pair[2])
    end
  end
  local pairFlat = ((info.dual == true) and "1|" or "0|") .. table.concat(parts, ";")
  pcall(room.setBanner, room, GLOBAL_PAIR_BANNER .. "_flat", pairFlat)
  pcall(function()
    if type(room.doBroadcastNotify) == "function" then
      room:doBroadcastNotify("SetBanner", { GLOBAL_PAIR_BANNER .. "_info", info })
      room:doBroadcastNotify("SetBanner", { GLOBAL_PAIR_BANNER .. "_flat", pairFlat })
    end
  end)
end

-- 本局禁将：每个玩家分到一份独立的随机候选池（张数 = 选将数 generalNum，
-- 各人内容不同），从中禁 n 名（双将按组，n 组 = 2n 张）。禁掉的将并入房间
-- 禁用表（本局在禁将方案之外又禁一遍），与正式选将的候选池分开。
-- 候选来源是当前禁将方案过滤后的全将池，不是正式选将分到的那几张。
-- 只做一次（room 标记），换将/后续批次不再触发。
local function runGlobalBanPhase(room, players, params)
  if room:getBanner(GLOBAL_BAN_BANNER .. "_done") == true then return false end
  local okReq, Req = pcall(require, "server.request")
  if not okReq or type(Req) ~= "table" or type(Req.new) ~= "function" then
    hxlog("global ban: Request unavailable, skipped")
    return false
  end
  local n = globalBanCount(room)
  local groups = signatureDeputyOn(room)
  -- 双将按「组」禁：一组两张，故每人禁 n 组 = 2n 张；单将禁 n 张
  local pickNum = groups and (n * 2) or n

  -- 独立禁将池：把房间当前禁用方案折算成集合，再列出可用全将
  local banGens, banPacks = {}, {}
  for _, g in ipairs(room.disabled_generals or {}) do banGens[g] = true end
  for _, pkg in ipairs(room.disabled_packs or {}) do banPacks[pkg] = true end
  local fullPool = generalsAllowedBy(banGens, banPacks)
  -- 每人一份独立随机候选：张数 = 选将数 generalNum（至少 6），各人洗牌后
  -- 各取 X 张并按 trueName 去重，保证每人看到的候选池不一样。
  local X = room:getSettings("generalNum") or 6
  X = math.max(tonumber(X) or 6, 6)
  if X < pickNum then X = pickNum end

  local req = Req:new(players, "CustomDialog")
  req.focus_text = "AskForGeneral"
  local timeout = room:getSettings("generalTimeout")
  req.timeout = (type(timeout) == "number" and timeout > 0) and timeout or 30
  local UI = "packages/advancedpackages/qml/ChooseGeneralWithCanChange.qml"
  local MODEL = "packages/advancedpackages/qml/models/ChooseGeneralWithCanChangeModel.qml"
  for _, p in ipairs(players) do
    -- 每人独立洗牌，取 X 张互不重名的武将作本轮禁将候选
    local mine, usedTrue = {}, {}
    local copy = table.simpleClone(fullPool)
    table.shuffle(copy)
    for _, g in ipairs(copy) do
      if #mine >= X then break end
      local gen = Fk.generals[g]
      local tn = gen and gen.trueName or g
      if not usedTrue[tn] then
        usedTrue[tn] = true
        mine[#mine + 1] = g
      end
    end
    local data = {
      generals = mine,
      choiceNum = pickNum,
      change = {},
      skills = {},
      convertDisabled = false,
      hegemony = false,
      ruleType = "askForGeneralsChosen",
      groupSize = groups and 2 or 0,
      -- 禁将框左上角也显示「本局已禁用」（进房禁将方案已禁掉的将）；
      -- hideGroupLabel 让禁将框不显示双将的「首发/备选一」组标签。
      extraData = {
        n = pickNum, choiceNum = pickNum,
        globalBanned = table.simpleClone(room.disabled_generals or {}),
        hideGroupLabel = true,
        showBanList = true,
      },
      prompt = "#hx__3v3_global_ban_prompt:::seat#" .. tostring(p.seat) .. ":" .. n,
      cancelable = false,
    }
    req:setData(p, {
      component = { url = UI, model = { url = MODEL, prop = data } },
    })
    req:setDefaultReply(p, table.slice(mine, 1, pickNum))
  end
  local banned = {}
  for _, p in ipairs(players) do
    local got = req:getResult(p)
    if type(got) == "table" then
      for _, g in ipairs(got) do
        if type(g) == "string" then banned[g] = true end
      end
    end
  end

  -- 本局又禁一遍：并入房间禁用表，后续取将（含备选池轮次）都自然过滤
  local allBanned = {}
  for g in pairs(banned) do
    allBanned[#allBanned + 1] = g
    if not table.contains(room.disabled_generals, g) then
      room.disabled_generals[#room.disabled_generals + 1] = g
    end
  end

  -- 选将候选：剔除被禁的，再从独立全将池补足到原张数（选将数量不变）
  for _, p in ipairs(players) do
    local base = paramOf(params, p, #players)
    if type(base) == "table" and type(base.generals) == "table" then
      local want = #base.generals
      local kept, usedTrue = {}, {}
      for _, g in ipairs(base.generals) do
        if not banned[g] then
          local gen = Fk.generals[g]
          local tn = gen and gen.trueName or g
          if not usedTrue[tn] then
            usedTrue[tn] = true
            kept[#kept + 1] = g
          end
        end
      end
      if #kept < want then
        local copy = table.simpleClone(fullPool)
        table.shuffle(copy)
        for _, g in ipairs(copy) do
          if #kept >= want then break end
          if not banned[g] then
            local gen = Fk.generals[g]
            local tn = gen and gen.trueName or g
            if not usedTrue[tn] then
              usedTrue[tn] = true
              kept[#kept + 1] = g
            end
          end
        end
      end
      base.generals = kept
      -- 把本局禁用名单随选将数据下发，供选将界面左上角「本局已禁用」入口展示
      base.extraData = base.extraData or {}
      base.extraData.showBanList = true
      base.extraData.globalBanned = allBanned
    end
  end

  room:setBanner(GLOBAL_BAN_BANNER, allBanned)
  room:setBanner(GLOBAL_BAN_BANNER .. "_done", true)
  -- 官方 @& banner：Room 场景常驻显示「本局已禁用 (N)」，点开看名单
  if #allBanned > 0 then
    pcall(room.setBanner, room, "@&hx__3v3_ban_list", allBanned)
  else
    pcall(room.setBanner, room, "@&hx__3v3_ban_list", nil)
  end
  -- 展示用：带「是否双将」标志，供备选面板「本局已禁用」入口决定单将逐个/双将按组显示
  local banInfoValue = { names = allBanned, grouped = (groups == true) }
  room:setBanner(GLOBAL_BAN_BANNER .. "_info", banInfoValue)
  -- 纯字符串通道：嵌套 table 经 CBOR/Lua proxy 桥接到 QML 时字段可能丢失，
  -- 而官方 getBanner("RoundCount") 那种标量值一直可靠。这里把名单编码成
  -- 单个字符串（首字符 1=双将按组/0=单将，其后用竖线分隔将名），
  -- PairPanel.qml 用 split 解析，彻底绕开嵌套 table 的桥接不确定性。
  local banFlat = ((groups == true) and "1|" or "0|") .. table.concat(allBanned, "|")
  room:setBanner(GLOBAL_BAN_BANNER .. "_flat", banFlat)
  -- 再显式广播一次：确保客户端 ClientInstance.banners 一定有这份数据，
  -- 备选面板的 QML 轮询 Lua.client.getBanner 才能读到。
  pcall(function()
    if type(room.doBroadcastNotify) == "function" then
      room:doBroadcastNotify("SetBanner", { GLOBAL_BAN_BANNER .. "_info", banInfoValue })
      room:doBroadcastNotify("SetBanner", { GLOBAL_BAN_BANNER .. "_flat", banFlat })
      room:doBroadcastNotify("ShowToast", Fk:translate("hx__3v3_global_ban_toast"))
    end
  end)
  hxlog(("global ban: done, %d generals banned this game, info broadcast"):format(#allBanned))
  return true
end

-- 禁配校验：结果里每两名一组（双将）或按候选 A/B 组，同标号则把后者换成
-- 池中一个不同标号的候选；替换不了就退到池首，避免卡住流程。
local function enforceNoPair(room, players, params, ret, groupSize)
  local map = pairLabelMapOf(room)
  local mapN = 0
  for _ in pairs(map) do mapN = mapN + 1 end
  local size = groupSize or (signatureDeputyOn(room) and 2 or 0)
  hxlog(("no-pair: check map=%d size=%d ret=%s players=%d")
    :format(mapN, size, type(ret), type(players) == "table" and #players or -1))
  if mapN == 0 then
    hxlog("no-pair: map empty -> skip")
    return ret
  end
  if size < 2 or type(ret) ~= "table" then return ret end
  for _, p in ipairs(players) do
    local list = ret[p]
    -- 兼容以 id 为键的返回结果
    if type(list) ~= "table" and type(p) == "table" then list = ret[p.id] end
    if type(list) == "table" and #list >= 2 then
      local base = paramOf(params, p, #players)
      local pool = type(base) == "table" and base.generals or {}
      hxlog(("no-pair: pid=%s list=%s pool=%d")
        :format(tostring(type(p) == "table" and p.id or p), #list, #pool))
      local start = 1
      while start + 1 <= #list do
        local a, b = list[start], list[start + 1]
        hxlog(("no-pair: pair %d/%d a=%s(%s) b=%s(%s)")
          :format(start, #list, tostring(a), tostring(map[a]),
            tostring(b), tostring(map[b])))
        if map[a] and map[b] and map[a] == map[b] then
          -- 三级兜底：①不同标号且不在结果里 ②不同标号 ③池里任意非 a 的将
          local repl = nil
          for _, g in ipairs(pool) do
            if g ~= a and not table.contains(list, g)
                and not (map[g] and map[a] and map[g] == map[a]) then
              repl = g; break
            end
          end
          if not repl then
            for _, g in ipairs(pool) do
              if g ~= a and not (map[g] and map[a] and map[g] == map[a]) then
                repl = g; break
              end
            end
          end
          if not repl then
            for _, g in ipairs(pool) do
              if g ~= a then repl = g; break end
            end
          end
          if repl then
            list[start + 1] = repl
            hxlog(("no-pair: replaced %s with %s (label %s)")
              :format(b, repl, tostring(map[a])))
          else
            hxlog("no-pair: NO REPL found -> pair left unchanged")
          end
        end
        start = start + (size > 0 and size or 2)
      end
    else
      hxlog(("no-pair: list not usable (%s, len=%s)")
        :format(type(list), type(list) == "table" and #list or -1))
    end
  end
  return ret
end

-- 最外层包装：禁将 → 内层选将 → 禁配校验。
local function patchGlobalBanNoPair()
  local ok, HXFS = pcall(require, "packages.bloodybattle.hxfs")
  if not ok or type(HXFS) ~= "table" or type(HXFS.askToGeneral) ~= "function" then
    return false
  end
  if rawget(HXFS, "__hx_global_ban_nopair") then return true end
  rawset(HXFS, "__hx_global_ban_nopair", true)
  local orig = HXFS.askToGeneral
  HXFS.askToGeneral = function(players, params)
    local first = players[1]
    local room = first and first.room
    if room then
      pcall(publishPairInfo, room)
      if globalBanOn(room) then
        pcall(runGlobalBanPhase, room, players, params)
      end
    end
    local ret = orig(players, params)
    if room and noPairOn(room) then
      local okE, errE = pcall(enforceNoPair, room, players, params, ret)
      if not okE then hxlog("no-pair: ERROR " .. tostring(errE)) end
    end
    return ret
  end
  hxlog("global ban / no pair: askToGeneral hooked")
  return true
end

-- 服务端的两处补丁：建房时登记收方案的入口，开局建牌堆前把方案并进去。
-- 牌堆构造时逐个走 Fk:canUseGeneral，并入之后所有取将（含备选池的四组轮次）
-- 自然都过滤掉了。
local function patchServerRoom()
  local okRoom, Room = pcall(require, "ltk.server.room")
  if not okRoom or type(Room) ~= "table" then return false end
  if type(Room.initialize) ~= "function" or type(Room.makeGeneralPile) ~= "function" then
    return false
  end
  if rawget(Room, "__hx_double_ban_patched") then return true end
  rawset(Room, "__hx_double_ban_patched", true)

  local origInit = Room.initialize
  Room.initialize = function(self, ...)
    origInit(self, ...)
    if type(self.addCallback) == "function" then
      self:addCallback(BAN_CMD, hxReceiveBanSchemes)
    end
    return
  end

  local origMakePile = Room.makeGeneralPile
  Room.makeGeneralPile = function(self, ...)
    pcall(applyDoubleBan, self)
    return origMakePile(self, ...)
  end
  hxlog("double ban: server hooks installed")
  return true
end

-- 包加载时 room 类可能还没 require 到，交给运行期补装兜底
latePatches[#latePatches + 1] = patchServerRoom
pcall(patchServerRoom)
-- 禁将/禁配必须在双池之前包：禁将先剔除候选，双池再基于干净候选分池。
-- latePatches 按注册顺序执行，先包的是内层，故禁将/禁配先注册。
latePatches[#latePatches + 1] = patchGlobalBanNoPair
pcall(patchGlobalBanNoPair)
latePatches[#latePatches + 1] = patchDualPools
pcall(patchDualPools)
latePatches[#latePatches + 1] = patchClientSender
pcall(patchClientSender)
latePatches[#latePatches + 1] = installSettingsHook
pcall(installSettingsHook)

-- 换将水位线：包装 GameLogic.getEventsOfScope。血战房间里，玩家换将时会记下
-- SWAP_WATERMARK（当时的事件 id）。这里对「本回合的事件」做一次后处理：
-- 若事件与该玩家相关、且发生在换将之前，就剔除掉，让该玩家的计数从换将后
-- 重新累计。覆盖两类技能：
--   UseCard   —— 胆守（十周年 ty_ex__danshou 等）：按本回合被指定为目标次数计数；
--   MoveCards —— 先谋（十周年 tymou__guojia）：按本回合失去的牌数计数。
-- 其他房间/玩家没有水位线标记，或事件类型不在上述两类，走原样返回，零影响。
local function patchEventScopeWatermark()
  local ok, GL = pcall(require, "ltk.server.gamelogic")
  if not ok or type(GL) ~= "table" or type(GL.getEventsOfScope) ~= "function" then return false end
  if GL.__hx_watermark_patched then return true end
  GL.__hx_watermark_patched = true
  local orig = GL.getEventsOfScope
  -- 判断事件 data 是否与玩家相关；不同事件类型字段不同
  local function eventTouchesPlayer(eventType, data, p)
    if eventType == GameEvent.UseCard then
      return type(data.tos) == "table" and table.contains(data.tos, p)
    elseif eventType == GameEvent.MoveCards then
      -- 先谋统计的是「失去的牌」，moves 里 from == p 才算；拿到牌不算失去
      if type(data.moves) == "table" then
        for _, mv in ipairs(data.moves) do
          if type(mv) == "table" and mv.from == p then return true end
        end
      end
      return false
    end
    return false
  end
  GL.getEventsOfScope = function(self, eventType, n, func, scope)
    local res = orig(self, eventType, n, func, scope)
    if type(res) ~= "table" or #res == 0 then return res end
    if eventType ~= GameEvent.UseCard and eventType ~= GameEvent.MoveCards then return res end
    if scope ~= nil and scope ~= Player.HistoryTurn then return res end
    local room = self.room
    if not room or type(room.players) ~= "table" then return res end
    -- 收集本房间带水位线的玩家 -> 水位线 id
    local marks = {}
    for _, p in ipairs(room.players) do
      local wm = p:getMark(SWAP_WATERMARK)
      if type(wm) == "number" and wm > 0 then marks[p] = wm end
    end
    if not next(marks) then return res end
    local kept = {}
    for _, ev in ipairs(res) do
      local drop = false
      local data = ev.data
      if ev.id and data then
        for p, wm in pairs(marks) do
          if eventTouchesPlayer(eventType, data, p) and ev.id <= wm then
            drop = true break
          end
        end
      end
      if not drop then table.insert(kept, ev) end
    end
    return kept
  end
  return true
end
latePatches[#latePatches + 1] = patchEventScopeWatermark
pcall(patchEventScopeWatermark)

----------------------------------------------------------------------
-- advancedpackages：选将 QML 重定向
-- 血战原版的 hxfs.askToGeneral 把 component.url 写死指向
-- packages/bloodybattle/qml/ChooseGeneralWithCanChange.qml（原版界面）。
-- 增强版 QML 已迁到 advancedpackages，这里包装 Request:setData，
-- 发出请求前把这两个 url 改指到增强版，让双候选池/一次选三组界面生效。
----------------------------------------------------------------------
local function patchAdvancedQmlRedirect()
  local ok, Req = pcall(require, "server.request")
  if not ok or type(Req) ~= "table" or type(Req.setData) ~= "function" then return false end
  if Req.__adv_qml_redirect then return true end
  Req.__adv_qml_redirect = true
  local orig = Req.setData
  local OLD_UI = "packages/bloodybattle/qml/ChooseGeneralWithCanChange.qml"
  local NEW_UI = "packages/advancedpackages/qml/ChooseGeneralWithCanChange.qml"
  local OLD_MODEL = "packages/bloodybattle/qml/models/ChooseGeneralWithCanChangeModel.qml"
  local NEW_MODEL = "packages/advancedpackages/qml/models/ChooseGeneralWithCanChangeModel.qml"
  Req.setData = function(self, player, data)
    if type(data) == "table" and type(data.component) == "table" then
      local c = data.component
      if c.url == OLD_UI then c.url = NEW_UI end
      if type(c.model) == "table" and c.model.url == OLD_MODEL then
        c.model.url = NEW_MODEL
      end
    end
    return orig(self, player, data)
  end
  hxlog("advancedpackages: QML redirect installed")
  return true
end
latePatches[#latePatches + 1] = patchAdvancedQmlRedirect
pcall(patchAdvancedQmlRedirect)

----------------------------------------------------------------------
-- 十二、仁彀（rengou）自发动修复
-- 官方 attached_skill 机制：持有主技 rengou 的角色（威刘备）获得该技时，
-- 引擎把附赠技 rengou& 发给场上其他蜀势力角色；主技持有者自己本不应持有
-- rengou&，故按设计不能自己发动仁彀。
-- 但"令其获得技能"类效果（如管宁遁世）可把主技 rengou 授予旁人：若此人
-- 先前已因别的持有者在场而拿到 rengou&，便会同时握有主技与附赠技，于是
-- 在自己回合既能发动仁彀、又能把自己选为目标，弃自己的牌、令自己回血、
-- 再让自己发动烈骧，自导自演。
-- 这里在 advancedpackages 就地加固，不改 tenyear/delight 任何官方文件：
--   ①获得主技时清掉自身的 rengou&；
--   ②附赠技 canUse 排除主技持有者本人；
--   ③附赠技 targetFilter 禁止选自己为目标。
-- 三处均幂等、pcall 保护，tenyear 与 delight 两版一起修；只影响仁彀，
-- 不碰任何其他技能。
----------------------------------------------------------------------
local function patchRengouSelfUse()
  if type(Fk) ~= "table" then return false end
  local cfgList = {
    { main = "rengou",     attach = "rengou&" },
    { main = "dl__rengou", attach = "dl__rengou&" },
  }
  local any = false

  for _, cfg in ipairs(cfgList) do
    -- ① 获得主技时清除自身附赠技（引擎 onAcquire 先给他人发 attach，再调本回调）
    pcall(function()
      local skel = type(Fk.skill_skels) == "table" and Fk.skill_skels[cfg.main]
      if skel and type(skel.on_acquire) == "function" and not skel.__adv_rengou_fix then
        local origAcq = skel.on_acquire
        skel.on_acquire = function(player, is_start, src)
          local ret = origAcq(player, is_start, src)
          pcall(function()
            if player and player.room then
              player.room:handleAddLoseSkills(player, "-" .. cfg.attach, nil, false, true)
            end
          end)
          return ret
        end
        skel.__adv_rengou_fix = true
        any = true
      end
    end)

    local atk = type(Fk.skills) == "table" and Fk.skills[cfg.attach]
    if type(atk) == "table" then
      -- ② canUse：主技持有者本人不得发动附赠技
      pcall(function()
        if type(atk.canUse) == "function" and not atk.__adv_rengou_canuse_fix then
          local origCan = atk.canUse
          atk.canUse = function(self, player, ...)
            if player and type(player.hasSkill) == "function" and player:hasSkill(cfg.main) then
              return false
            end
            return origCan(self, player, ...)
          end
          atk.__adv_rengou_canuse_fix = true
          any = true
        end
      end)
      -- ③ targetFilter：不得选自己为目标
      pcall(function()
        if type(atk.targetFilter) == "function" and not atk.__adv_rengou_tf_fix then
          local origTf = atk.targetFilter
          atk.targetFilter = function(self, player, to_select, ...)
            if to_select == player then return false end
            return origTf(self, player, to_select, ...)
          end
          atk.__adv_rengou_tf_fix = true
          any = true
        end
      end)
    end
  end

  if any then hxlog("rengou self-use fix installed") end
  return any
end
latePatches[#latePatches + 1] = patchRengouSelfUse
pcall(patchRengouSelfUse)

----------------------------------------------------------------------
-- 十一、云端默认禁将方案同步
----------------------------------------------------------------------
-- 所有人点【更新】：从服务端全服存档拉取 6 套默认方案，追加进自己本地的
-- 禁将方案（Config.disableSchemes）并存盘；白名单管理员点同一个按钮时，
-- 额外把本地前 6 套方案上传覆盖全服存档，实现「远端更新」。
-- 走官方 LobbyTask 通道（lobby.cpp 白名单内），载荷是 JSON 字符串，
-- 服务端用 Fk:addTaskDef 注册 handler，回传用 task.player:doNotify。
-- 全服存档 key 带版本号，确保本次内置的带前缀方案首次生效，不受旧存档干扰。
local BAN_SYNC_TASK = "hx_ban_sync"
local BAN_SYNC_RESULT = "hx_ban_sync_result"
-- v3：v2 里是旧名字（小弟彩虹…）；改名后换 key，让内置 6 套带新名字的方案
-- （小弟界将池…26王战池）首次生效，不受旧存档干扰。
local BAN_SYNC_SAVE_KEY = "hx_ban_schemes_v3_20261117"
-- 白名单管理员（按游戏内昵称 getScreenName 判定）
local BAN_ADMINS = {
  ["彩虹小弟"] = true,
  ["周宣"] = true,
}

local function loadBuiltinBanSchemes()
  local ok, defs = pcall(require, "packages.advancedpackages.rules.hx_ban_defaults")
  if ok and type(defs) == "table" and #defs > 0 then return defs end
  return {}
end

-- 服务端：注册 LobbyTask 处理器。客户端也会执行本文件，但没有 addTaskDef
-- 或没有 task 系统时，pcall 兜住即可，不会报错。
if type(Fk) == "table" and type(Fk.addTaskDef) == "function" then
  local okDef, errDef = pcall(function()
    Fk:addTaskDef {
      type = BAN_SYNC_TASK,
      handler = function(task)
        local tp = task.player
        if not tp then return end

        -- task.data 是 LobbyTask 第二个载荷，这里约定为 JSON 字符串
        local payload = {}
        local d = task.data
        if type(d) == "string" then
          local ok, decoded = pcall(json.decode, d)
          if ok and type(decoded) == "table" then payload = decoded end
        elseif type(d) == "table" then
          payload = d
        end

        -- 判定管理员：asio 版 TaskPlayer 的 _splayer 提供 getScreenName
        local isAdmin = false
        local nm = ""
        local sp = tp._splayer
        if sp and type(sp.getScreenName) == "function" then
          local ok, name = pcall(sp.getScreenName, sp)
          if ok then nm = tostring(name) end
          if ok and BAN_ADMINS[nm] then isAdmin = true end
        end
        hxlog(("ban sync enter name=%s admin=%s dataLen=%s")
          :format(nm, tostring(isAdmin), tostring(type(d) == "string" and #d or 0)))

        -- 房主建房/进房时推送本机全部禁将方案：存进玩家专属槽，供房间内
        -- applyDoubleBan / 双候选池读取。按玩家 id 隔离，不写全服存档，
        -- 所以不会多人串数据，也和云端默认方案（管理员上传那套）互不干扰。
        if payload.op == "push_schemes" and type(payload.schemes) == "table"
            and #payload.schemes > 0 then
          local pid = tp.id
          local slot = {
            schemes = payload.schemes,
            cur = tonumber(payload.cur) or 1,
            name = nm,
          }
          HX_PLAYER_BAN_SCHEMES[pid] = slot
          HX_LAST_PUSHED_SCHEMES = slot
          if nm ~= "" then HX_PLAYER_BAN_BY_NAME[nm] = slot end
          hxlog(("ban sync push pid=%s name=%s n=%s cur=%s")
            :format(tostring(pid), nm, #payload.schemes, tostring(payload.cur)))
          return -- 这类后台推送不需要回传，避免刷新按钮状态
        end

        -- 读全服存档（Task:getGlobalSaveState 走 uid=0，跨玩家共享）
        local saved = nil
        local okR, ret = pcall(function() return task:getGlobalSaveState(BAN_SYNC_SAVE_KEY) end)
        if okR and type(ret) == "table" and type(ret.schemes) == "table" and #ret.schemes > 0 then
          saved = ret
        end

        -- 管理员上传：只接受「有效方案」（名字非空且含禁将表），
        -- 避免把客户端尚未写盘的空名/临时方案覆盖到云端（v1 就是这么被污染的）。
        local pushed = false
        if isAdmin and type(payload.schemes) == "table" then
          local valid = {}
          for _, s in ipairs(payload.schemes) do
            if type(s) == "table" and type(s.name) == "string" and s.name ~= ""
                and (type(s.banPkg) == "table" or type(s.normalPkg) == "table"
                     or type(s.banCardPkg) == "table") then
              table.insert(valid, s)
            end
          end
          if #valid > 0 then
            -- 11-17 改为按名称合并：与云端（或内置默认）同名的方案原位替换，
            -- 云端没有的新名字追加到末尾。客户端不再固定传本地前六套，
            -- 管理员本地怎么排序、怎么增删都不影响对号入座。
            local defs = (type(saved) == "table" and type(saved.schemes) == "table"
              and #saved.schemes > 0) and saved.schemes or loadBuiltinBanSchemes()
            local byName, out = {}, {}
            for _, s in ipairs(defs) do
              if type(s) == "table" and type(s.name) == "string" and s.name ~= "" then
                byName[s.name] = s
                table.insert(out, s)
              end
            end
            local replaced, appended = 0, 0
            for _, s in ipairs(valid) do
              if byName[s.name] then
                for k, old in ipairs(out) do
                  if old.name == s.name then
                    out[k] = s
                    replaced = replaced + 1
                    break
                  end
                end
              else
                byName[s.name] = s
                table.insert(out, s)
                appended = appended + 1
              end
            end
            saved = { schemes = out }
            local okW = pcall(function() task:saveGlobalState(BAN_SYNC_SAVE_KEY, saved) end)
            pushed = okW
            hxlog(("ban sync admin upload valid=%s replaced=%s appended=%s ok=%s")
              :format(#valid, replaced, appended, tostring(okW)))
          else
            hxlog("ban sync admin upload SKIPPED: no valid scheme in payload")
          end
        end

        -- 存档为空用内置 6 套初始化并写入
        if not saved then
          saved = { schemes = loadBuiltinBanSchemes() }
          pcall(function() task:saveGlobalState(BAN_SYNC_SAVE_KEY, saved) end)
          hxlog(("ban sync init builtin count=%s"):format(#saved.schemes))
        end

        -- 回传的一定是「有效方案」：把存档里空名/残缺的项过滤掉，
        -- 这样普通玩家点更新后本地能看到完整的默认方案，而不是一堆空名项。
        local out = {}
        for _, s in ipairs(saved.schemes or {}) do
          if type(s) == "table" and type(s.name) == "string" and s.name ~= "" then
            table.insert(out, s)
          end
        end
        -- 若云端有效项不足 6 套，用内置补齐（按名字去重）
        if #out < 6 then
          local have = {}
          for _, s in ipairs(out) do have[s.name] = true end
          for _, s in ipairs(loadBuiltinBanSchemes()) do
            if type(s) == "table" and s.name and s.name ~= "" and not have[s.name] then
              table.insert(out, s)
              have[s.name] = true
            end
            if #out >= 6 then break end
          end
        end

        -- 用 JSON 字符串回传，不用 Lua table：table 经 CBOR 编码后嵌套的
        -- scheme.name/banPkg 在 QML 侧解出来形态不稳，方案名会丢成「第 N 套」。
        -- JSON 字符串到 QML 就是纯字符串，客户端 JSON.parse 后结构完整。
        local reply = {
          ok = true,
          admin = isAdmin,
          pushed = pushed,
          schemes = out,
        }
        local okEnc, replyJson = pcall(json.encode, reply)
        local okN = false
        if okEnc then
          okN = pcall(tp.doNotify, tp, BAN_SYNC_RESULT, replyJson)
        end
        hxlog(("ban sync reply schemes=%s json=%s ok=%s len=%s")
          :format(#out, tostring(okEnc), tostring(okN),
            tostring(okEnc and #replyJson or 0)))
        if not okN then
          pcall(fk.qWarning, "[hx_ban_sync] doNotify failed")
        end
      end, -- handler function end
    }
    end) -- pcall(function() Fk:addTaskDef{...})
  hxlog("ban sync taskdef register=" .. tostring(okDef) .. " err=" .. tostring(errDef))
else
  hxlog("ban sync taskdef SKIPPED: addTaskDef unavailable")
end

----------------------------------------------------------------------
-- 十一·五、禁配方案云端同步（结构与禁将云备份平行，存档独立）
----------------------------------------------------------------------
-- op=push_pairs：房主把本机禁配方案推到玩家专属槽，供 pairLabelMapOf 读取。
-- op=sync：管理员把本机方案按名称合并上传覆盖全服存档；所有人拉取云端方案。
local PAIR_SYNC_TASK = "hx_pair_sync"
local PAIR_SYNC_RESULT = "hx_pair_sync_result"

local function validPairScheme(s)
  if type(s) ~= "table" or type(s.name) ~= "string" or s.name == "" then
    return false
  end
  if type(s.pairs) ~= "table" or #s.pairs == 0 then return false end
  for _, pair in ipairs(s.pairs) do
    if type(pair) == "table" and #pair == 2
        and type(pair[1]) == "string" and type(pair[2]) == "string" then
      return true
    end
  end
  return false
end

if type(Fk) == "table" and type(Fk.addTaskDef) == "function" then
  local okDef2, errDef2 = pcall(function()
    Fk:addTaskDef {
      type = PAIR_SYNC_TASK,
      handler = function(task)
        local tp = task.player
        if not tp then return end
        local payload = {}
        local d = task.data
        if type(d) == "string" then
          local ok, dec = pcall(json.decode, d)
          if ok and type(dec) == "table" then payload = dec end
        elseif type(d) == "table" then payload = d end

        local isAdmin, nm = false, ""
        local sp = tp._splayer
        if sp and type(sp.getScreenName) == "function" then
          local ok, name = pcall(sp.getScreenName, sp)
          if ok then nm = tostring(name) end
          if ok and BAN_ADMINS[nm] then isAdmin = true end
        end

        -- 房主推送本机方案到玩家专属槽
        if payload.op == "push_pairs" and type(payload.schemes) == "table"
            and #payload.schemes > 0 then
          local pid = tp.id
          local slot = {
            schemes = payload.schemes,
            cur = tonumber(payload.cur) or 1,
            name = nm,
          }
          HX_PLAYER_PAIR_SCHEMES[pid] = slot
          HX_LAST_PUSHED_PAIRS = slot
          if nm ~= "" then HX_PLAYER_PAIR_BY_NAME[nm] = slot end
          hxlog(("pair sync push pid=%s name=%s n=%s")
            :format(tostring(pid), nm, #payload.schemes))
          return
        end

        -- 读全服存档
        local saved = nil
        local okR, ret = pcall(function() return task:getGlobalSaveState(PAIR_SYNC_SAVE_KEY) end)
        if okR and type(ret) == "table" and type(ret.schemes) == "table"
            and #ret.schemes > 0 then saved = ret end

        local pushed = false
        if isAdmin and type(payload.schemes) == "table" then
          local valid = {}
          for _, s in ipairs(payload.schemes) do
            if validPairScheme(s) then valid[#valid + 1] = s end
          end
          if #valid > 0 then
            local byName, out = {}, {}
            for _, s in ipairs((type(saved) == "table" and type(saved.schemes) == "table")
                and saved.schemes or {}) do
              if type(s) == "table" and type(s.name) == "string" and s.name ~= "" then
                byName[s.name] = true
                out[#out + 1] = s
              end
            end
            for _, s in ipairs(valid) do
              if byName[s.name] then
                for k, old in ipairs(out) do
                  if old.name == s.name then out[k] = s break end
                end
              else
                byName[s.name] = true
                out[#out + 1] = s
              end
            end
            saved = { schemes = out }
            local okW = pcall(function() task:saveGlobalState(PAIR_SYNC_SAVE_KEY, saved) end)
            pushed = okW
            hxlog(("pair sync admin upload valid=%d ok=%s"):format(#valid, tostring(okW)))
          end
        end

        if not saved then
          saved = { schemes = {} }
          pcall(function() task:saveGlobalState(PAIR_SYNC_SAVE_KEY, saved) end)
        end
        local out = {}
        for _, s in ipairs(saved.schemes or {}) do
          if validPairScheme(s) then out[#out + 1] = s end
        end
        local reply = { ok = true, admin = isAdmin, pushed = pushed, schemes = out }
        local okEnc, replyJson = pcall(json.encode, reply)
        if okEnc then pcall(tp.doNotify, tp, PAIR_SYNC_RESULT, replyJson) end
      end,
    }
  end)
  hxlog("pair sync taskdef register=" .. tostring(okDef2) .. " err=" .. tostring(errDef2))
end

----------------------------------------------------------------------
-- 十二、官方 player titles（不升级 asio、不改 core）
----------------------------------------------------------------------
-- asio 0.1.17 的 supportedFeatures 编译期写死只有 AddRobot/ChangeRoom，
-- 客户端 Config.titleServerSupported 因此恒为 false，"更换称号"按钮灰着，
-- 原生 GetTitleProfile/UpdateTitle 命令服务端也不认。
--
-- 绕过办法：全程借用 asio 0.1.17 白名单内的 LobbyTask 通道，以及 core 自带
-- 的称号命令 handler（Mediator.qml 对 TitleProfile/PlayerTitle/
-- PlayerTitlesSnapshot 都有处理，联机时同样在跑）：
--   客户端发 LobbyTask("hx_title", {op=...}) →
--   服务端 Fk:addTaskDef 的 handler 读/写玩家存档 →
--   task.player:doNotify("TitleProfile", 载荷) 回传。
-- 关键点：applyTitleProfile() 里有一句 titleServerSupported = data.supported
-- === true，所以回传里带上 supported=true 就把那道硬门槛打开了——提示消失、
-- 称号列表出现、原生按钮解灰，全部由 core 自己的逻辑完成，core 一行未动。
--
-- 存档用 TaskPlayer:getGlobalSaveState/saveGlobalState（服务端原生、按账号隔离），
-- 换设备/重连都保留。可选称号表来自 rainbow_titles/styles.lua 注册到
-- Fk.title_styles 的样式，与客户端 TitleBank 渲染的是同一份。
local TITLE_TASK = "hx_title"
local TITLE_SAVE_KEY = "hx_title_equipped_v1"

-- 进程内快照：账号 id -> {playerId,id,title,style}，供房间开局广播他人称号。
-- 大厅 task 与房间 room 在同一 Lua 进程，全局表可共享。
HX_TITLE_EQUIPPED = HX_TITLE_EQUIPPED or {}

-- 称号权威列表写死在服务端，id 与 rainbow_titles/styles.lua 的 key 一一对应，
-- 不依赖服务端进程是否加载了 rainbow_titles 包（它的 init 只在客户端渲染样式
-- 时真正需要）。渲染组件路径仍由客户端 TitleBank 按 style=id 查 Fk.title_styles。
local HX_TITLE_DEFS = {
  { "rainbow_titles.rainbowfamily",         "彩虹家族" },
  { "rainbow_titles.dreamingsaint",         "大梦仙尊" },
  { "rainbow_titles.bigdreamingsaint",      "极大梦仙尊" },
  { "rainbow_titles.shiningrainbowfamily",  "闪光彩虹家族" },
  { "rainbow_titles.dynsatenruiko",         "动·佐天泪子" },
  { "rainbow_titles.dynmisakamikoto",       "动·御坂美琴" },
  { "rainbow_titles.dyndreamingsaint",      "动·大梦仙尊" },
  { "rainbow_titles.dynrainbowfamily",      "动·彩虹家族" },
}

-- 专属称号：仅周宣(id=1)可佩戴；其他账号看得见（快照广播全量），但候选列表
-- 里不出现、也无法装备，存档中若残留（旧数据）读取时自动清除。
local HX_TITLE_OWNER_PID = 1
local HX_TITLE_EXCLUSIVE = {
  ["rainbow_titles.dreamingsaint"]    = true, -- 大梦仙尊
  ["rainbow_titles.bigdreamingsaint"] = true, -- 极大梦仙尊
  ["rainbow_titles.dyndreamingsaint"] = true, -- 动·大梦仙尊
}

local function hxTitleAllowed(pid, id)
  if HX_TITLE_EXCLUSIVE[id] then
    return tonumber(pid) == HX_TITLE_OWNER_PID
  end
  return true
end

-- pid 为 nil 时返回全量（快照/广播取名用）；传具体账号则过滤掉他无权佩戴的专属。
local function hxTitleList(pid)
  local out = {}
  local owner = (pid == nil) or (tonumber(pid) == HX_TITLE_OWNER_PID)
  for _, def in ipairs(HX_TITLE_DEFS) do
    if owner or not HX_TITLE_EXCLUSIVE[def[1]] then
      table.insert(out, { id = def[1], title = def[2], style = def[1] })
    end
  end
  return out
end

local function hxFindTitle(list, id)
  for _, t in ipairs(list) do
    if t.id == id then return t end
  end
  return nil
end

-- 进程内已知的所有称号快照（数组形态，直接交给 PlayerTitlesSnapshot）。
-- 玩家通过 hx_title 换过称号后都会写进 HX_TITLE_EQUIPPED，所以这张表就是
-- "本服已装备称号的玩家"全集，回传给任一玩家即可让其看到其他人。
function HX_TitleSnapshotArray()
  local out = {}
  for pid, entry in pairs(HX_TITLE_EQUIPPED) do
    if type(entry) == "table" and type(entry.id) == "string" and entry.id ~= "" then
      table.insert(out, {
        playerId = tonumber(pid) or tonumber(entry.playerId) or 0,
        id = entry.id,
        title = entry.title or "",
        style = entry.style or entry.id,
      })
    end
  end
  return out
end

-- 房间开局/进房时，把房间内每人的称号汇总后广播给所有人。
-- 先取进程内快照（本次会话换过称号的）；缺失的再从账号存档补读，
-- 这样服务重启后没打开过设置页的玩家，称号依然能被读到。
-- 定义为全局函数，文件前部的开局 hook 在运行时调用（那时已加载完）。
function HX_BroadcastRoomTitles(room)
  if not room or type(room.doBroadcastNotify) ~= "function" then return end
  local defs = hxTitleList()
  local list = {}
  for _, p in ipairs(room.players or {}) do
    local pid = p.id
    if pid then
      local entry = HX_TITLE_EQUIPPED[pid]
      local sid = entry and entry.id or ""
      if (not sid or sid == "") and type(p.getGlobalSaveState) == "function" then
        pcall(function()
          local s = p:getGlobalSaveState(TITLE_SAVE_KEY)
          if type(s) == "table" and type(s.id) == "string" then sid = s.id end
        end)
      end
      if sid and sid ~= "" and hxTitleAllowed(pid, sid) then
        local t = hxFindTitle(defs, sid)
        if t then
          table.insert(list, { playerId = pid, id = t.id, title = t.title, style = t.style })
          -- 回填进程内表，后续 profile 请求也能直接带上
          HX_TITLE_EQUIPPED[pid] = { playerId = pid, id = t.id, title = t.title, style = t.style }
        end
      end
    end
  end
  if #list > 0 then
    local ok = pcall(room.doBroadcastNotify, room, "PlayerTitlesSnapshot", list)
    hxlog("title snapshot broadcast n=" .. #list .. " ok=" .. tostring(ok))
  end
end

if type(Fk) == "table" and type(Fk.addTaskDef) == "function" then
  local okTitle, errTitle = pcall(function()
    Fk:addTaskDef {
      type = TITLE_TASK,
      handler = function(task)
        local tp = task.player
        if not tp then return end
        local pid = tp.id

        local payload = {}
        local d = task.data
        if type(d) == "string" then
          local ok, dec = pcall(json.decode, d)
          if ok and type(dec) == "table" then payload = dec end
        elseif type(d) == "table" then
          payload = d
        end
        local op = payload.op or "profile"
        -- 候选列表按账号过滤：非周宣看不到也不选不了专属称号
        local list = hxTitleList(pid)

        -- 读存档：getGlobalSaveState 已经是解码后的 table（见 taskplayer.lua）
        local savedId = ""
        pcall(function()
          local s = tp:getGlobalSaveState(TITLE_SAVE_KEY)
          if type(s) == "table" then
            savedId = s.id or ""
          elseif type(s) == "string" then
            local ok, dec = pcall(json.decode, s)
            if ok and type(dec) == "table" then savedId = dec.id or "" end
          end
        end)
        -- 存档残留（旧数据/他人冒领的专属）：无权限则清掉，本人不显示也戴不了
        if savedId ~= "" and not hxTitleAllowed(pid, savedId) then
          hxlog(("title task clear unauthorized pid=%s id=%s")
            :format(tostring(pid), tostring(savedId)))
          savedId = ""
          pcall(function() tp:saveGlobalState(TITLE_SAVE_KEY, { id = "" }) end)
        end
        local equipped = hxFindTitle(list, savedId) or {}

        -- 装备：校验 id 在本人可用列表里（专属仅周宣可写），写入账号存档
        if op == "equip" then
          local want = payload.id or ""
          if want == "" then
            equipped = {}
            pcall(function() tp:saveGlobalState(TITLE_SAVE_KEY, { id = "" }) end)
          elseif hxTitleAllowed(pid, want) then
            local t = hxFindTitle(list, want)
            if t then
              equipped = t
              pcall(function() tp:saveGlobalState(TITLE_SAVE_KEY, { id = want }) end)
            end
          else
            hxlog(("title task equip denied pid=%s id=%s")
              :format(tostring(pid), tostring(want)))
          end
          savedId = equipped.id or ""
        end

        -- 更新进程内快照
        HX_TITLE_EQUIPPED[pid] = {
          playerId = pid,
          id = equipped.id or "", title = equipped.title or "", style = equipped.style or "",
        }

        -- 回传 TitleProfile：传 table（不传 JSON 字符串）——core 的
        -- applyTitleProfile 要求 data.titles 是真数组，JSON 字符串会解不出来。
        local profile = {
          playerId = pid,
          supported = true,
          titles = list,
          equipped = equipped,
          ok = true,
          error = "",
        }
        local okN = pcall(tp.doNotify, tp, "TitleProfile", profile)
        -- 同时回传全服称号快照：core 的 Mediator 收到 PlayerTitlesSnapshot 后
        -- 会逐个 applyPlayerTitle 填进 Config.playerTitles，等待室卡片按 playerId
        -- 自动显示他人称号。玩家自己这条由上面的 TitleProfile.equipped 也覆盖。
        local snap = HX_TitleSnapshotArray()
        local okS = pcall(tp.doNotify, tp, "PlayerTitlesSnapshot", snap)
        hxlog(("title task pid=%s op=%s equipped=%s n=%s notify=%s snap=%s/%s")
          :format(tostring(pid), tostring(op), tostring(savedId), #list,
            tostring(okN), tostring(okS), #snap))
        if not okN then pcall(fk.qWarning, "[hx_title] doNotify TitleProfile failed") end
        if not okS then pcall(fk.qWarning, "[hx_title] doNotify snapshot failed") end
      end,
    }
  end)
  hxlog("title taskdef register=" .. tostring(okTitle) .. " err=" .. tostring(errTitle))
else
  hxlog("title taskdef SKIPPED: addTaskDef unavailable")
end

-- 加载自检：日志里能确认本文件在哪个进程跑到、标记表当时有没有就绪
hxlog("extra rules loaded, marks=" .. tostring(Fk and type(Fk.qml_marks) == "table")
  .. " private=" .. tostring(Fk and type(Fk.qml_marks) == "table"
    and Fk.qml_marks["private"] ~= nil)
  .. " getqmlmark=" .. tostring(type(GetQmlMark) == "function"))

-- 本文件主体是补丁，技能骨架（阴阳鱼）已移到 rules/skills/yinyangfish.lua，
-- 由 init.lua 的 Package:loadSkillSkelsByPath 正规登记。这里只返回 false，
-- 避免被误当成技能骨架（init.lua 用 pcall(require) 加载本文件，不看返回值）。
return false
