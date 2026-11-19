import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Fk
import Fk.Widgets as W

// 云端默认禁将方案【更新】按钮。
// 由 advancedpackages/rules/hx__3v3_extra_rules.lua 注入到血战附加规则设置组。
// 左侧是说明文字，右侧是独立按钮——只有点按钮本身才会触发，避免整行误触。
  // 点击：发 LobbyTask 给服务端，载荷是 JSON 字符串（本机全部方案）。
  // 服务端判定身份：管理员顺带按名称合并上传方案（与云端同名的原位替换、
  // 新名字追加），所有人都会收到云端最新 6 套。
  // 收到回传：把方案追加进 Config.disableSchemes（同名不重复）并写盘。
Item {
  id: root

  property string title: ""
  property string subTitle: ""
  property bool busy: false

  implicitHeight: Math.max(60, titleCol.implicitHeight + 16)

  RowLayout {
    anchors.fill: parent
    anchors.leftMargin: 16
    anchors.rightMargin: 16
    spacing: 12

    ColumnLayout {
      id: titleCol
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignVCenter
      spacing: 2

      Text {
        text: root.title
        font {
          family: root.font.family
          pixelSize: 17
          bold: true
        }
        opacity: enabled ? 1.0 : 0.3
        elide: Text.ElideRight
        Layout.fillWidth: true
      }

      Text {
        text: root.subTitle
        visible: root.subTitle !== ""
        font {
          family: root.font.family
          pixelSize: 13
        }
        color: "grey"
        wrapMode: Text.WordWrap
        lineHeight: 0.95
        Layout.fillWidth: true
      }
    }

    Button {
      id: updateBtn
      Layout.alignment: Qt.AlignVCenter
      text: root.busy ? "更新中…" : "更新"
      enabled: !root.busy
      onClicked: root.doUpdate()
    }
  }

  // 有效方案 = 有非空名字、且带三段禁将表之一。
  // 历史遗留的空名方案（新建未命名就存下的）会在禁将方案下拉里显示成
  // 「空展位」，推给服务端还会把 scheme 序号顶偏。统一过滤掉。
  function isValidScheme(s) {
    return s && typeof s === "object" && typeof s.name === "string"
      && s.name.replace(/^\s+|\s+$/g, "") !== ""
      && (s.banPkg || s.normalPkg || s.banCardPkg);
  }

  // 洗掉内存里的空名方案并落盘，保证下拉不再出现空展位；
  // 返回清洗后的列表，currentDisableIdx 同步夹到有效范围内。
  function cleanLocalSchemes() {
    var src = Config.disableSchemes || [];
    var cleaned = src.filter(isValidScheme);
    var changed = cleaned.length !== src.length;
    if (cleaned.length === 0) return src.slice();
    var cur = Config.currentDisableIdx || 0;
    if (cur < 0 || cur >= cleaned.length) {
      cur = 0;
      changed = true;
    }
    if (changed) {
      Config.disableSchemes = cleaned;
      Config.currentDisableIdx = cur;
      Config.curScheme = cleaned[cur];
      Config.saveConf();
    }
    return cleaned;
  }

  // 把房主本机【全部】禁将方案推到服务端玩家专属槽，供双禁将/双候选池读取。
  // 服务端与客户端是两台机器，服务端读不到客户端配置；旧的 hx_ban_scheme
  // 命令会踢线，故改走白名单内的 LobbyTask。按玩家 id 隔离，不串数据。
  function pushAllSchemes() {
    var all = cleanLocalSchemes();
    var payload = JSON.stringify({
      op: "push_schemes",
      schemes: all,
      cur: (Config.currentDisableIdx || 0) + 1
    });
    Cpp.notifyServer("LobbyTask", ["hx_ban_sync", payload]);
  }

  function doUpdate() {
    if (root.busy) return;
    root.busy = true;
    // 上传本机全部清洗后的方案；服务端对管理员按名称合并，
    // 对普通玩家只回传云端默认方案，本地多出自建方案不受影响。
    var payload = JSON.stringify({ op: "sync", schemes: cleanLocalSchemes() });
    Cpp.notifyServer("LobbyTask", ["hx_ban_sync", payload]);
    // 兜底：8 秒没收到回传就解锁，避免卡死
    retryTimer.start();
  }

  // 建房打开设置页、组件创建时自动推一次房主方案：
  // 这样开局 makeGeneralPile 时服务端已有方案，双禁将/双池生效。
  Component.onCompleted: {
    Qt.callLater(pushAllSchemes);
  }

  Timer {
    id: retryTimer
    interval: 8000
    repeat: false
    onTriggered: {
      if (root.busy) {
        root.busy = false;
        App.showToast(Lua.tr("hx_ban_sync_fail"));
      }
    }
  }

  Connections {
    target: Mediator
    function onCommandGot(sender, command, data) {
      if (command !== "hx_ban_sync_result") return;
      retryTimer.stop();
      root.busy = false;
      // 服务端回传的是 JSON 字符串（CBOR 直传 table 会让嵌套方案名丢失），
      // 也兼容旧版/意外的对象形态。
      var payload = data;
      if (typeof payload === "string") {
        try {
          payload = JSON.parse(payload);
        } catch (e) {
          payload = null;
        }
      }
      console.log("[hxBanSync] got", typeof data, payload && payload.ok,
        payload && payload.schemes && payload.schemes.length);
      if (!payload || payload.ok !== true || !payload.schemes) {
        App.showToast(Lua.tr("hx_ban_sync_fail"));
        return;
      }
      // 云端方案追加到本地方案末尾，按名字去重。
      // 先把历史空名方案洗掉，避免下拉继续出现空展位、scheme 序号被顶偏。
      var list = (Config.disableSchemes || []).filter(isValidScheme);
      var have = {};
      for (var i = 0; i < list.length; i++) {
        var n = list[i] && list[i].name;
        if (n) have[n] = true;
      }
      var added = 0;
      for (var j = 0; j < payload.schemes.length; j++) {
        var s = payload.schemes[j];
        if (!s || typeof s !== "object") continue;
        var nm = s.name || "";
        if (!nm || have[nm]) continue;
        have[nm] = true;
        list.push(s);
        added++;
      }
      Config.disableSchemes = list;
      // saveConf 会把 curScheme 写回 disableSchemes[currentDisableIdx]，
      // 必须无条件同步到新 list 的对应槽位，否则旧引用会把第 0 套覆盖回去。
      Config.curScheme = list[Config.currentDisableIdx] || list[0] || Config.curScheme;
      Config.saveConf();
      console.log("[hxBanSync] saved total", Config.disableSchemes.length, "added", added);

      var msg;
      if (added === 0) {
        msg = Lua.tr("hx_ban_sync_latest");
      } else if (payload.admin && payload.pushed) {
        msg = Lua.tr("hx_ban_sync_admin").arg(added);
      } else {
        msg = Lua.tr("hx_ban_sync_ok").arg(added);
      }
      App.showToast(msg);
    }
  }
}
