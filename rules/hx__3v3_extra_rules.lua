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

  七、比赛规则·击穿全部备选才获胜（子开关，默认关）
      比赛规则下必须击杀对方全部备选武将（四组）才判负，
      每击穿一组记一分，全部击穿记五分。

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
local SETTING_COUNT = "hxIndulgenceCount"
local SETTING_EFFECT = "hxIndulgenceEffect"
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

-- 数量选项：值 - 要保留的张数
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
-- 方案名只有客户端知道（freekill.client.config.json 的 disableSchemes），
-- 服务端进程读不到就保持旧的「第 N 套」占位，不影响取值（值仍然是 hx_ban_scheme_N）。
local BAN_SCHEME_KEYS = {}
for i = 1, 8 do
  BAN_SCHEME_KEYS["hx_ban_scheme_" .. i] = i
end
-- 没选过时按第 2 套算：第 1 套通常正是当前方案
local DEFAULT_BAN_SCHEME_KEY = "hx_ban_scheme_2"

local BAN_SCHEME_MODEL = {
  "hx_ban_scheme_1", "hx_ban_scheme_2", "hx_ban_scheme_3", "hx_ban_scheme_4",
  "hx_ban_scheme_5", "hx_ban_scheme_6", "hx_ban_scheme_7", "hx_ban_scheme_8",
}
local BAN_SCHEME_LABELS = {}

-- 只列出房主真实存在的方案，并按方案名改写 hx_ban_scheme_N 的翻译；
-- ComboBox 的显示文本就是 Lua.tr(键)，所以改名即可，不必动取值逻辑。
local function refreshBanSchemeModel()
  local conf = rawget(_G, "Config")
  local schemes = (type(conf) == "table") and conf.disableSchemes or nil
  if type(schemes) ~= "table" then return false end
  local n = #schemes
  if n <= 0 then return false end
  if n > 8 then n = 8 end

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
  return true
end
pcall(refreshBanSchemeModel)

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
  ["#HX3v3_AskForThrowGeneral_tips"] = "请主帅弃置 %arg 张备选武将（每组两张）",
  ["HX3v3_AskForThrowGeneral"] = "弃置备选武将",
  ["hx__3v3_swap_prompt"] = "请为阵亡角色选择一组武将",
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
if okW and type(W) == "table" and type(W.PreferenceGroup) == "function"
    and type(W.SwitchRow) == "function" and type(W.ComboRow) == "function" and Fk then
  local origAddGameMode = Fk.addGameMode
  if type(origAddGameMode) == "function" then
    Fk.addGameMode = function(self, mode)
      origAddGameMode(self, mode)
      if type(mode) ~= "table" or mode.name ~= MODE_NAME then return end

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
          W.SwitchRow {
            _settingsKey = SETTING_MASTER,
            title = "hx_settings_signature_deputy_title",
            enabled = masterEnabled,
          },
          W.SwitchRow {
            _settingsKey = SETTING_ONESHOT,
            title = "hx_settings_one_shot_groups_title",
            enabled = subEnabled,
          },
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
            _settingsKey = SETTING_ENDTURN,
            title = "hx_settings_end_turn_on_death_title",
            enabled = subEnabled,
          },
          W.SwitchRow {
            _settingsKey = SETTING_SWAPFIX,
            title = "hx_settings_swap_skill_fix_title",
            -- 换将状态隔离的子项，没存过值时就当开着
            value = function(settings)
              local v = settingsFlag(settings, SETTING_SWAPFIX)
              if v == nil then return true end
              return v == true
            end,
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
            model = BAN_SCHEME_MODEL,
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
        })
      end)
    end
  end
end

if type(Fk.loadTranslationTable) == "function" then
  pcall(Fk.loadTranslationTable, Fk, {
    ["hx_settings_extra_rules_group_title"] = "血战附加规则",

    ["hx_settings_signature_deputy_title"] = "模式总开关",
    ["help: hx_settings_signature_deputy_title"] =
      "本组设置的总开关，必须先开启房间设置中的「启用副将」才能开启。"
      .. "\n开启后每名玩家依次选择三组武将（共六张）：第一组登场，其余两组进入备选池，"
      .. "选将结束时由主帅从备选池统一弃置两组；阵亡换将按本人选定的组合依次上场。",

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
      "仅比赛规则生效。开启后必须击杀对方全部备选武将才算获胜，"
      .. "每击穿一组记一分，全部击穿记五分胜利。",

    ["hx_settings_double_ban_title"] = "双禁将方案",
    ["help: hx_settings_double_ban_title"] =
      "开启后，在禁将页面当前选中的方案之外，自选第二套禁将方案，两者取并集。"
      .. "\n若同时开启下面的「选将分两个候选池」，两套禁将方案各自成一个候选池。",

    ["hx_settings_double_ban_scheme_title"] = "第二套方案",
    ["help: hx_settings_double_ban_scheme_title"] =
      "下拉里列出房主自己保存的禁将方案，"
      .. "顺序与禁将页面一致，改名或添加新方案后需重进服务器才能生效。"
      .. "\n选中的那一套会与禁将页面当前方案取并集，与当前方案是同一套时不会重复生效。"
      .. "\n下面是方案名读取不到时的兜底写法：",
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

    ["hx_settings_indulgence_count_title"] = "牌堆中乐不思蜀数量",
    ["help: hx_settings_indulgence_count_title"] =
      "本局牌堆保留的【乐不思蜀】张数，默认三张，若小于三张则补为花色点数相同的【兵粮寸断】。"
      .. "此项与双将无关，单将模式同样生效。",
    ["hx_indulgence_count_3"] = "3张",
    ["hx_indulgence_count_2"] = "2张",
    ["hx_indulgence_count_1"] = "1张",
    ["hx_indulgence_count_0"] = "0张",

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
    if key == "3v3thegeneralsNum" and masterOn(self) then
      -- 选将结束时主帅统一弃置两组（四张）；关掉总开关即恢复原设置
      return 4
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

local function fullWinOn(room)
  return masterOn(room) and rawSetting(room, "3v3competition") == true
      and rawSetting(room, SETTING_FULLWIN) == true
end

applyFullWin = function(mode)
  if type(mode) ~= "table" or type(mode.winner_getter) ~= "function" then return false end
  if mode.__hx_fullwin_patched then return true end
  mode.__hx_fullwin_patched = true
  local orig = mode.winner_getter
  mode.winner_getter = function(self, victim)
    local room = Fk:currentRoom()
    if not (room and victim and fullWinOn(room)) then
      return orig(self, victim)
    end
    -- 原逻辑在这里先 table.remove 掉一张，等于「剩一名备选即判负」；
    -- 全歼口径下不预扣，备选清零才判负
    local cool = room:getBanner("@&hx__cool_generals") or {}
    local warm = room:getBanner("@&hx__warm_generals") or {}
    local winner = ""
    if victim.role:startsWith("warm") then
      if #warm == 0 then winner = victim:getEnemies(true) end
    elseif victim.role:startsWith("cool") then
      if #cool == 0 then winner = victim:getEnemies(true) end
    end
    if #cool > 0 and #warm > 0 then winner = "" end
    if victim.surrendered and (victim.role == "cool_marshal" or victim.role == "warm_marshal") then
      winner = victim:getEnemies(true)
    end
    if not winner then winner = "" end
    return winner
  end
  hxlog("fullwin getter installed")
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
local YINYANG_SKILL = "hx__3v3_yinyang_skill"
local YINYANG_MARK = "@!!yinyangfish"

-- 技能骨架在包加载期创建；fk 的子项不一定就绪，统一 pcall 兜住。
-- 骨架必须由本文件 return 出去交给 loadSkillSkelsByPath 登记：只有登记过的技能
-- 才会进 Fk.skills，而 room:handleAddLoseSkills → Player:addSkill 第一步就是
-- getActualSkill(name) → Fk.skills[name] → assert(isInstanceOf(Skill))。
-- 之前本文件 return false，技能从没进表，加技能时断言失败被 pcall 吞掉，
-- 于是标记（图标）在、技能不在，主动与弃牌阶段都用不了。
local yinyangSkel
local function buildYinyangSkill()
  local yinyangSkill = fk.CreateSkill { name = YINYANG_SKILL }

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
    end,
  })

  return yinyangSkill
end
yinyangSkel = select(2, pcall(buildYinyangSkill))
if type(yinyangSkel) ~= "table" then yinyangSkel = nil end

-- 补偿方式：新键优先；老存档里的布尔开关折算成「护甲」
local function oddCompKind(room)
  local kind = normCompKind(rawSetting(room, SETTING_ODD))
  if kind then return kind end
  if rawSetting(room, SETTING_ARMOR_OLD) == true then return "armor" end
  return "off"
end

-- scene: "start" 开局公布武将 / "swap" 阵亡换将
-- 两种场合原有的基础护甲口径不同，这里各自沿用原口径，只叠加补偿的那一枚
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

  -- 体力上限与当前体力一致，体力牌不再出现空格
  local maxHp = fix or floorHp
  player.maxHp = maxHp
  player.hp = maxHp
  room:broadcastProperty(player, "maxHp")
  room:broadcastProperty(player, "hp")
  hxlog(("adjust hp scene=%s main=%s(hp%s/max%s adj%s fix%s) dep=%s(hp%s/max%s adj%s fix%s)"
    .. " sum=%s floor=%s -> maxHp=%s cur=%s")
    :format(tostring(scene), tostring(main.name), tostring(main.hp), tostring(main.maxHp),
      tostring(main.mainMaxHpAdjustedValue), tostring(main.fixMaxHp),
      tostring(deputy.name), tostring(deputy.hp), tostring(deputy.maxHp),
      tostring(deputy.deputyMaxHpAdjustedValue), tostring(deputy.fixMaxHp),
      tostring(sum), tostring(floorHp), tostring(maxHp), tostring(player.hp)))

  -- 补偿：合计为奇数说明舍去了半点体力，按设置给一枚护甲或一枚阴阳鱼
  local kind = oddCompKind(room)
  local odd = (sum % 2 == 1)
  local comp = (odd and kind == "armor") and 1 or 0
  local base = (scene == "swap")
      and (main.shield or 0)
      or math.min((main.shield or 0) + (deputy.shield or 0), 5)
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
        if table.contains(pool, g) and not table.contains(list, g) then
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
          if table.contains(pool, g) and not table.contains(total[p], g) then
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
      local ret = orig(self)
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
    local ret = origMain(self)
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
  -- 乐不思蜀与双将无关，单将模式（不开副将 / 总开关关）同样生效
  local keep = COUNT_KEYS[room:getSettings(SETTING_COUNT)] or 3
  local draw = room.draw_pile
  if type(draw) ~= "table" or type(room.printCard) ~= "function" then return false end

  local indexes = {}
  for i, id in ipairs(draw) do
    local card = Fk:getCardById(id)
    if card and card.trueName == "indulgence" then
      table.insert(indexes, i)
    end
  end
  if #indexes <= keep then return false end

  local changed = false
  for k = #indexes, keep + 1, -1 do
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
        hxlog("mark hit private " .. tostring(name) .. " n=" .. #list)
        return {
          url = PILE_QML,
          prop = { dialog = false, name = name, cardNames = list,
            armorOn = comp == "armor", comp = comp },
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
        hxlog("mark hit score")
        return {
          url = PILE_QML,
          prop = { dialog = false, name = name, value = value,
            armorOn = comp == "armor", comp = comp },
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
    self:doBroadcastNotify("SetBanner", {
      target, { value = list, players = poolViewerIds(self) },
    })
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

    if name == COOL_GEN_BANNER or name == WARM_GEN_BANNER then
      if type(value) == "table" and type(value.value) == "table" then
        local t = trimOdd(value.value)
        if t ~= value.value then
          local copy = table.simpleClone(value)
          copy.value = t
          value = copy
        end
        hxlog((name == COOL_GEN_BANNER and "cool pool=" or "warm pool=") .. #t)
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

  -- 优先用房主进房时送来的那份；没有网络数据（自己建房时也可能还没到）
  -- 才退回去读本机文件。
  local schemes, numA = room.__hx_ban_schemes, nil
  if type(schemes) == "table" and next(schemes) ~= nil then
    numA = tonumber(room.__hx_ban_cur) or 0
  else
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
  room.__hx_ban_names = {
    a = schemeNameOf(schemes, numA),
    b = schemeNameOf(schemes, numB),
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
latePatches[#latePatches + 1] = patchDualPools
pcall(patchDualPools)
latePatches[#latePatches + 1] = patchClientSender
pcall(patchClientSender)

-- 换将水位线：包装 GameLogic.getEventsOfScope。血战房间里，玩家换将时会记下
-- SWAP_WATERMARK（当时的事件 id）。这里对「本回合 UseCard 事件」做一次后处理：
-- 若事件目标里含有带水位线的玩家、且事件发生在该玩家换将之前，就剔除掉。
-- 这样胆守这类「按本回合被指定次数计数」的技能会从换将后重新累计。
-- 其他房间/玩家没有水位线标记，走原样返回，零影响。
local function patchEventScopeWatermark()
  local ok, GL = pcall(require, "ltk.server.gamelogic")
  if not ok or type(GL) ~= "table" or type(GL.getEventsOfScope) ~= "function" then return false end
  if GL.__hx_watermark_patched then return true end
  GL.__hx_watermark_patched = true
  local orig = GL.getEventsOfScope
  GL.getEventsOfScope = function(self, eventType, n, func, scope)
    local res = orig(self, eventType, n, func, scope)
    if eventType ~= GameEvent.UseCard or type(res) ~= "table" or #res == 0 then return res end
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
      if ev.id and data and type(data.tos) == "table" then
        for _, to in ipairs(data.tos) do
          local wm = marks[to]
          if wm and ev.id <= wm then drop = true break end
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

-- 加载自检：日志里能确认本文件在哪个进程跑到、标记表当时有没有就绪
hxlog("extra rules loaded, marks=" .. tostring(Fk and type(Fk.qml_marks) == "table")
  .. " private=" .. tostring(Fk and type(Fk.qml_marks) == "table"
    and Fk.qml_marks["private"] ~= nil)
  .. " getqmlmark=" .. tostring(type(GetQmlMark) == "function"))

-- 本文件主体是补丁，只顺带造一个技能骨架（阴阳鱼）。loadSkillSkelsByPath 会拿
-- require 的返回值当技能骨架（先写 skel.file_path，再 createSkill 并登记进 Fk.skills），
-- 所以这里要返回骨架本身；骨架没建成才返回 false。返回 true 会在 skel.file_path 那步崩。
return yinyangSkel or false
