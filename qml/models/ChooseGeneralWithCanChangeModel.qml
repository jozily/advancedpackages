import QtQuick
import Fk
import LunarLtk

QtObject {
  id: root

  property var generals: [] // string[]
  property var change: [] // 可换将的武将列表
  property var skills: [] // 技能列表
  property int choiceNum: 1
  property bool convertDisabled: false
  property bool cancelable: false
  property string skillName
  property string prompt: ""
  property bool detailed
  property string ruleType: ""
  property var extraData: ({ n: choiceNum })
  property bool hegemony: false
  property bool freeAssign: Lua.client.getSettings("enableFreeAssign")
  property bool changeGeneralBtnVisible: true // 换将按钮可见性

  // 双禁将·双候选池：generals 的前 poolSplit 张来自方案 A，其余来自方案 B，
  // poolNames 是两套方案的名字（[A, B]）。都为 0/空时按原样单池显示。
  property int poolSplit: 0
  property var poolNames: []

  // 一次选完三组时每组几张（0 表示不分组的普通选将）
  property int groupSize: 0

  // 从 lua 传来的数组有三种形态（真数组 / 带 length 的类数组 / 数字键表），
  // Array.isArray 对后两者恒假，这里统一折成真数组。
  readonly property var poolNameList: {
    const n = poolNames;
    const ret = [];
    if (!n) return ret;
    if (Array.isArray(n) || n.length !== undefined) {
      for (let i = 0; i < n.length; i++) ret.push(n[i]);
      return ret;
    }
    if (typeof n.count === "number" && typeof n.get === "function") {
      for (let i = 0; i < n.count; i++) ret.push(n.get(i));
      return ret;
    }
    for (let i = 1; n[i] !== undefined; i++) ret.push(n[i]);
    if (ret.length === 0) {
      for (let i = 0; n[i] !== undefined; i++) ret.push(n[i]);
    }
    return ret;
  }

  // 双池时两侧各选各的：一张都不能从同一侧取两张。
  readonly property bool pooledChoice: choiceNum >= 2
      && poolSplit > 0 && poolSplit < generals.length
      && poolNameList.length >= 2

  // 两池各自的取牌上限：默认对半，某池候选不够时把差额让给另一池。
  readonly property var poolQuota: {
    if (!pooledChoice) return [choiceNum, 0];
    const nA = poolSplit;
    const nB = Math.max(0, generals.length - poolSplit);
    let qa = Math.min(Math.ceil(choiceNum / 2), nA);
    let qb = Math.min(Math.floor(choiceNum / 2), nB);
    let rest = choiceNum - qa - qb;
    if (rest > 0) {
      const addA = Math.min(rest, nA - qa);
      qa += addA;
      rest -= addA;
      const addB = Math.min(rest, nB - qb);
      qb += addB;
    }
    return [qa, qb];
  }

  function poolIndexOf(name) {
    const i = generals.indexOf(name);
    if (i < 0) return -1;
    return i < poolSplit ? 0 : 1;
  }

  // 该武将所属那一侧还有没有名额；-1（不在候选表里）不限制。
  // 这里直接数 result，不读界面计数，避免刷新时机不一致导致漏拦。
  function poolAllows(choice) {
    if (!pooledChoice) return true;
    const part = poolIndexOf(choice);
    if (part < 0) return true;

    // 一次选完三组：每组都要一张 A、一张 B（groupSize=2 时即一 A 一 B）。
    // result 按点选顺序填入，槽位 idx 属于第 floor(idx/groupSize) 组。
    // 检查「当前正在填的这一组」里本池已放几张，达到组内配额就拦下，
    // 逼玩家去另一池选；这样三组自然地每组一 A 一 B，总数也就是 3+3。
    if (groupSize >= 2 && choiceNum > groupSize) {
      const g = Math.floor(result.length / groupSize);
      const start = g * groupSize;
      let usedInGroup = 0;
      for (let i = start; i < result.length; i++) {
        if (poolIndexOf(result[i]) === part) usedInGroup += 1;
      }
      const quotaInGroup = part === 0
          ? Math.ceil(groupSize / 2) : Math.floor(groupSize / 2);
      if (usedInGroup >= quotaInGroup) return false;
    }

    let used = 0;
    for (let i = 0; i < result.length; i++) {
      if (poolIndexOf(result[i]) === part) used += 1;
    }
    return used < poolQuota[part];
  }

  // 已选择的武将
  property list<string> result: [] // string[]

  // 两池各自已选几张。list 的变化不会通知绑定，所以由下面的改动点主动刷新。
  property int poolUsedA: 0
  property int poolUsedB: 0

  function refreshPoolUsed() {
    let a = 0, b = 0;
    for (let i = 0; i < result.length; i++) {
      const part = poolIndexOf(result[i]);
      if (part === 0) a += 1;
      else if (part === 1) b += 1;
    }
    poolUsedA = a;
    poolUsedB = b;
  }

  property var generalDict: ({}) // 武将名到GeneralModel的映射

  signal generalChanged(string oldname, string newname)
  signal changeListUpdated() // 换将列表更新信号

  signal accepted()
  signal rejected()

  readonly property string promptText: {
    if (prompt !== "") return Ltk.processPrompt(prompt);
    const pre_prompt = Ltk.processPrompt(Ltk.chooseGeneralPrompt(ruleType, generals, extraData));
    const suffix = freeAssign ? `(${Lua.tr("Enable free assign")})` : "";
    // var myPhoto = Ltk.roomScene.getPhoto(Self.id);
    // const selfseat = myPhoto && myPhoto.seatNumber ?  ("你的座次是 %1 ，").arg(Lua.tr("seat#" + myPhoto.seatNumber)) : "";
    // const ret = selfseat + Lua.tr("$ChooseGeneral").arg(choiceNum) + suffix;
    // if (pre_prompt !== "" && suffix === "" && selfseat === "") return pre_prompt;
    const ret = Lua.tr("$ChooseGeneral").arg(choiceNum) + suffix;
    if (pre_prompt !== "" && suffix === "") return pre_prompt;
    return ret;
  }

  readonly property bool feasible: {
    return choiceNum === result.length;
  }

  readonly property bool canConvert: {
    for (const name of generals) {
      if (Ltk.getSameGenerals(name).length > 0) return true;
    }
    return false;
  }

  readonly property bool canChangeGeneral: {
    return change && change.length > 0;
  }

  function generalFilter(choice) {
    const len = result.length;
    // 因为list<string>作为ListModel传不到lua只好复制
    const luaResult = result.map(e => e);
    // 双池时先看本侧名额，再走官方过滤；已在结果里的牌只调整顺序，不再占名额
    if (!result.includes(choice) && !poolAllows(choice)) return false;
    return choiceNum > len && Ltk.chooseGeneralFilter(ruleType, choice, luaResult,
        generals, extraData);
  }

  function selectGeneralCard(choice) {
    if (result.includes(choice)) {
      moveGeneral(choice, false);
    } else if (generalFilter(choice)) {
      result.push(choice);
    }
    refreshPoolUsed();
  }

  function moveGeneral(general, toSelect, toIndex) {
    const idx = result.findIndex(e => e === general);
    if (!toSelect) {
      if (idx !== -1) result.splice(idx, 1);
      refreshPoolUsed();
      return;
    }

    if (!generalFilter(general)) return;

    toIndex = Math.min(result.length, toIndex);

    if (idx !== toIndex) {
      const to_pos = toIndex ?? (result.length - 1)
      result[to_pos] = general;
      refreshPoolUsed();
    }
  }

  // 武将牌变更（自选或者同名替换）
  function changeGeneral(oldName, newModel) {
    const newName = newModel.name;
    for (let i = 0; i < generals.length; i++) {
      if (generals[i] === oldName) {
        generals[i] = newName;
      }
    }
    for (let i = 0; i < result.length; i++) {
      if (result[i] === oldName) {
        result[i] = newName;
      }
    }
    generalDict[newModel.name] = newModel;
    refreshPoolUsed();
    generalChanged(oldName, newName);
  }

  function initGeneralModels() {
    generalDict = {};

    for (const name of generals) {
      const model = Ltk.createGeneralCardModel(name)
      generalDict[name] = model;
    }
  }

  // 换将功能
  function changeGeneralCard(oldName, newName) {
    // 查找被换武将在 generals 中的索引
    let index = generals.findIndex(card => card === oldName);
    if (index !== -1) {
      // 替换对应武将
      generals[index] = newName;
      
      // 如果被换武将在结果中，也更新结果
      result = result.map(e => e === oldName ? newName : e);
      
      // 从change列表中移除已使用的武将
      change = change.filter(card => card !== newName);
      
      // 更新generalDict
      const model = Ltk.createGeneralCardModel(newName);
      generalDict = Object.assign({}, generalDict, { [newName]: model });

      refreshPoolUsed();

      // 发出变更信号
      generalChanged(oldName, newName);
      changeListUpdated();
    }
  }
}