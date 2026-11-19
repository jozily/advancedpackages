-- 彩虹默认禁将方案（6 套），由 advancedpackages 内置随包分发。
-- 由 hx__3v3_extra_rules.lua 的 hx_ban_sync 任务读写；结构同客户端
-- freekill.client.config.json 的 disableSchemes 单项。
-- 数据来源：用户提供的 6 套默认清单，2026-11-17。
return {
  {
    name = "小弟界将池",
    banCardPkg = {
      "delight_token",
      "mobile_cards",
      "chaos_mode_cards",
      "espionage_cards",
      "vanished_dragon_cards",
      "variation_cards",
      "certamen_cards",
      "derived_cards",
      "3v3_cards",
      "1v1_cards",
      "hegemony_cards",
      "strategic_advantage",
      "lord_cards",
      "m_lord_cards",
      "ty_1v2_cards",
      "mobile_derived",
      "huan1v1_cards",
      "cpt_1v1_cards",
      "ofl_token",
      "bloodbath_longbench_cards",
      "ol_derived",
      "overseas_derived",
      "standard_ex_cards",
      "tenyear_token",
      "srxs_cards",
      "nine_variations",
      "wrd_cards",
      "maneuvering",
      "standard_cards",
    },
    banPkg = {
      ["1v1_generals"] = {
      },
      ["1v1_test_mobile"] = {
      },
      ["1v1_test_ol"] = {
      },
      ["1v1_test_tenyear"] = {
      },
      ["3v3_generals"] = {
      },
      ["assassins"] = {
      },
      ["beginning"] = {
      },
      ["bgmdiy"] = {
      },
      ["bloodybattle_generals"] = {
      },
      ["conclusion"] = {
      },
      ["continue"] = {
      },
      ["cpt_1v1_generals"] = {
      },
      ["cpt_lord_generals"] = {
        "cpt_ex__zhenji",
        "cpt_ex__chenqun",
        "cpt_ex__ganning",
        "cpt_ex__jvshou",
        "cpt_ex__guotupangji",
      },
      ["decline"] = {
      },
      ["dlex"] = {
      },
      ["dlfire"] = {
      },
      ["dlforest"] = {
      },
      ["dlgod"] = {
      },
      ["dllt"] = {
      },
      ["dlmountain"] = {
      },
      ["dlonly"] = {
      },
      ["dlother"] = {
      },
      ["dlstandard"] = {
      },
      ["dlwind"] = {
      },
      ["dlyj"] = {
      },
      ["espionage_beta"] = {
      },
      ["fire"] = {
      },
      ["forest"] = {
        "lusu",
      },
      ["formation"] = {
      },
      ["gamemode_generals"] = {
      },
      ["hegemony_nos"] = {
      },
      ["hegemony_standard"] = {
      },
      ["huansha"] = {
      },
      ["jiange_generals"] = {
      },
      ["jyzs"] = {
      },
      ["king_bloodybattle"] = {
      },
      ["lord_ex"] = {
      },
      ["m_shzl_ex"] = {
        "m_ex__xuhuang",
      },
      ["m_yj_ex"] = {
        "m_ex__xusheng",
        "m_ex__liaohua",
        "m_ex__manchong",
        "m_ex__caifuren",
      },
      ["majian"] = {
      },
      ["mashe"] = {
      },
      ["mini_ambition"] = {
      },
      ["mini_extreme"] = {
      },
      ["mini_other"] = {
      },
      ["mini_re"] = {
      },
      ["mini_shzl"] = {
      },
      ["mini_yj"] = {
      },
      ["minisp"] = {
      },
      ["mobile_bingshi"] = {
      },
      ["mobile_heg"] = {
      },
      ["mobile_jsrg"] = {
      },
      ["mobile_lxxh"] = {
        "mobile__simazhao",
      },
      ["mobile_rare"] = {
        "liuzan",
        "pangdegong",
      },
      ["mobile_shiji"] = {
        "mobile__wujing",
        "mobile__gaolan",
        "mobile__cuiyan",
        "mobile__lvfan",
        "mobile__zhujun",
      },
      ["mobile_sp"] = {
        "mobile__guanyinping",
        "mobile__dongbai",
        "mobile__dongcheng",
        "taoqian",
        "mobile__zhangyiy",
        "mobile__zhangqiying",
        "m_sp__simazhao",
      },
      ["mobile_test"] = {
      },
      ["momentum"] = {
      },
      ["moon_26_bloodbattle"] = {
      },
      ["mou_neng"] = {
      },
      ["mou_shi"] = {
      },
      ["mou_tong"] = {
      },
      ["mou_yu"] = {
      },
      ["mou_zhi"] = {
        "mou__caocao",
      },
      ["mountain"] = {
      },
      ["offline_heg"] = {
      },
      ["ofl_mougong"] = {
      },
      ["ofl_other"] = {
      },
      ["ofl_rare"] = {
      },
      ["ol_exyj"] = {
        "ol_ex__zhangchunhua",
        "ol_ex__fazheng",
        "ol_ex__wuguotai",
      },
      ["ol_jsrg"] = {
      },
      ["ol_menfa"] = {
      },
      ["ol_mo"] = {
      },
      ["ol_mou"] = {
        "olmou__taishici",
      },
      ["ol_other"] = {
      },
      ["ol_qifu"] = {
      },
      ["ol_shzl"] = {
        "ol__zhoutai",
        "ol__zhoufei",
      },
      ["ol_sp_pack"] = {
        "ol_sp__machao",
        "ol_sp__caoren",
        "ol_sp__menghuo",
        "ol_sp__sunce",
      },
      ["ol_test"] = {
      },
      ["ol_wende"] = {
        "zhanghuyuechen",
        "ol__simashi",
        "ol__simazhao",
        "ol__wangyuanji",
        "ol__jiachong",
        "weiguan",
        "ol__huaxin",
        "wangxiang",
        "xinchang",
      },
      ["ol_xinghe"] = {
        "ol__sunhao",
        "liuqi",
        "qinghegongzhu",
        "dongyun",
        "sunqian",
        "sunhong",
        "ol__xingcai",
        "ol__zhugeguo",
        "himiko",
        "ol__zhugeke",
        "ol__mazhong",
        "luzhiw",
        "ol__zhuling",
        "dengzhong",
        "macheng",
        "ol__zhangyiy",
        "ol__mengda",
        "ol__huangzu",
        "gaogan",
        "guohuaij",
        "heqi",
        "ol__zhujun",
        "ol__sufei",
      },
      ["ol_yj"] = {
        "ol__jikang",
        "ol__guohuai",
      },
      ["online_heg"] = {
      },
      ["overseas_bingshi"] = {
      },
      ["overseas_ex"] = {
      },
      ["overseas_heg"] = {
      },
      ["overseas_if"] = {
      },
      ["overseas_mougong"] = {
      },
      ["overseas_other"] = {
      },
      ["overseas_rare"] = {
      },
      ["overseas_sp"] = {
      },
      ["overseas_strategizing"] = {
      },
      ["overseas_sxrm"] = {
      },
      ["overseas_wuxia"] = {
      },
      ["overseas_yizhu"] = {
      },
      ["piracy_e"] = {
      },
      ["piracy_s"] = {
      },
      ["power"] = {
      },
      ["pride"] = {
      },
      ["qgzx"] = {
      },
      ["rage"] = {
      },
      ["rise"] = {
      },
      ["shadow"] = {
        "wangping",
        "luji",
      },
      ["shzj"] = {
      },
      ["shzl_god"] = {
        "godzhouyu",
        "godlvbu",
        "godzhaoyun",
        "godliubei",
        "godluxun",
      },
      ["sixiangfengyin"] = {
      },
      ["sp"] = {
        "liuxie",
      },
      ["sp_jsp"] = {
      },
      ["sp_re"] = {
      },
      ["sp_star"] = {
      },
      ["srxs"] = {
      },
      ["standard"] = {
      },
      ["standard_ex"] = {
        "ex__xiahoudun",
        "yijik",
        "ex__huanggai",
        "ex__sunshangxiang",
      },
      ["suspicion"] = {
      },
      ["tenyear_ex"] = {
        "ty_ex__caozhi",
        "ty_ex__chengong",
        "ty_ex__xunyou",
        "ty_ex__wangyi",
        "ty_ex__guanxingzhangbao",
        "ty_ex__chengpu",
        "ty_ex__caochong",
        "ty_ex__guohuai",
        "ty_ex__guanping",
        "ty_ex__jianyong",
        "ty_ex__liufeng",
        "ty_ex__wuyi",
        "ty_ex__guyong",
        "ty_ex__caoxiu",
        "ty_ex__zhongyao",
        "ty_ex__xiahoushi",
        "ty_ex__sunxiu",
        "ty_ex__gongsunyuan",
        "ty_ex__handang",
        "ty_ex__zhuran",
      },
      ["tenyear_heg"] = {
      },
      ["tenyear_huicui"] = {
        "ty__zhujun",
        "ty__dingyuan",
        "zhangmiao",
        "ty__hucheer",
        "yanrou",
        "lijue",
        "liangxing",
        "shamoke",
        "xinpi",
        "ty__niujin",
        "sunlang",
        "ty__panfeng",
        "caoxing",
        "zhanghu",
        "ty__gaolan",
        "ty__miheng",
        "ty__xunchen",
        "ty__dengzhi",
      },
      ["tenyear_mou"] = {
      },
      ["tenyear_other"] = {
      },
      ["tenyear_sp"] = {
      },
      ["tenyear_star"] = {
      },
      ["tenyear_test"] = {
      },
      ["tenyear_wei"] = {
      },
      ["tenyear_xinghuo"] = {
        "ty_ex__sundeng",
        "yanjun",
        "ty_ex__simalang",
        "ty_ex__wenpin",
        "ty__mayunlu",
        "ty_ex__gongsunzan",
      },
      ["tenyear_yj"] = {
      },
      ["test_p_0"] = {
      },
      ["thunder"] = {
        "haozhao",
        "zhugezhan",
      },
      ["transformation"] = {
      },
      ["transition"] = {
      },
      ["txhy"] = {
      },
      ["wangzhan"] = {
        "wzzz__liubei",
        "wzzz__guojia",
        "wzzz__xunyu",
        "wzzz__caoang",
        "wzzz__wangji",
        "wzzz__zhonghui",
        "wzzz__zhangliao",
        "wzzz__zhugeliang",
        "wzzz__mizhu",
        "wzzz__huangyueying",
        "wzzz__masu",
        "wzzz__zhangfei",
        "wzzz__bulianshi",
        "wzzz__lingtong",
        "wzzz__luxun",
        "wzzz__buzhi",
        "wzzz__zhoufang",
        "wzzz__lvmeng",
        "wzzz__diaochan",
        "wzzz__yujin",
        "wzzz2__lvbu",
        "wzzz__liru",
      },
      ["wind"] = {
      },
      ["wrd"] = {
      },
      ["yj2011"] = {
      },
      ["yj2012"] = {
      },
      ["yj2013"] = {
      },
      ["yj2014"] = {
      },
      ["yj2015"] = {
      },
      ["yj2016"] = {
      },
      ["yj2017"] = {
      },
      ["yjtw2013"] = {
      },
      ["yjtw2017"] = {
      },
      ["zcfy"] = {
      },
      ["zfxp"] = {
      },
      ["zqdl"] = {
      },
    },
    normalPkg = {
      ["ol_ex_shzl"] = {
        "ol_ex__caocao",
        "ol_ex__liubei",
        "ol_ex__zhaoyun",
        "ol_ex__lvmeng",
        "ol_ex__huangzhong",
        "ol_ex__weiyan",
        "ol_ex__yuji",
        "ol_ex__xunyu",
        "ol_ex__wolong",
        "ol_ex__pangde",
        "ol_ex__yanliangwenchou",
        "ol_ex__xuhuang",
        "ol_ex__menghuo",
        "ol_ex__lusu",
        "ol_ex__dongzhuo",
        "ol_ex__liushan",
        "ol_ex__zuoci",
        "ol_ex__caiwenji",
        "ol_ex__gongsunzan",
      },
    },
  }, -- 1 小弟彩虹王战界9.12
  {
    name = "小弟谋将池",
    banCardPkg = {
      "delight_token",
      "mobile_cards",
      "chaos_mode_cards",
      "espionage_cards",
      "vanished_dragon_cards",
      "certamen_cards",
      "derived_cards",
      "3v3_cards",
      "1v1_cards",
      "hegemony_cards",
      "strategic_advantage",
      "lord_cards",
      "srxs_cards",
      "wrd_cards",
      "mobile_derived",
      "cpt_1v1_cards",
      "ofl_token",
      "bloodbath_longbench_cards",
      "ol_derived",
      "overseas_derived",
      "standard_ex_cards",
      "tenyear_token",
      "kanncards",
      "lordcards",
      "ol_hegcards",
      "jyzs_cards",
      "m_lord_cards",
      "nine_variations",
      "ty_1v2_cards",
      "maneuvering",
      "variation_cards",
      "standard_cards",
    },
    banPkg = {
      ["1v1_generals"] = {
      },
      ["1v1_test_mobile"] = {
      },
      ["1v1_test_ol"] = {
      },
      ["1v1_test_tenyear"] = {
      },
      ["3v3_generals"] = {
      },
      ["assassins"] = {
      },
      ["beginning"] = {
      },
      ["bgmdiy"] = {
      },
      ["bloodybattle_generals"] = {
      },
      ["conclusion"] = {
        "js__zhugeliang",
      },
      ["continue"] = {
      },
      ["cpt_1v1_generals"] = {
      },
      ["cpt_lord_generals"] = {
        "cpt_ex__xunyu",
        "cpt_ex__cenhun",
      },
      ["decline"] = {
      },
      ["dlex"] = {
      },
      ["dlfire"] = {
      },
      ["dlforest"] = {
      },
      ["dlgod"] = {
      },
      ["dllt"] = {
      },
      ["dlmountain"] = {
      },
      ["dlonly"] = {
      },
      ["dlother"] = {
      },
      ["dlstandard"] = {
      },
      ["dlwind"] = {
      },
      ["dlyj"] = {
      },
      ["espionage_beta"] = {
      },
      ["fire"] = {
      },
      ["forest"] = {
      },
      ["formation"] = {
      },
      ["gamemode_generals"] = {
      },
      ["hegemony_standard"] = {
      },
      ["huansha"] = {
      },
      ["jiange_generals"] = {
      },
      ["jyzs"] = {
      },
      ["king_bloodybattle"] = {
      },
      ["lord_ex"] = {
      },
      ["m_shzl_ex"] = {
        "m_ex__xiahoudun",
        "m_ex__zhoufei",
      },
      ["m_yj_ex"] = {
        "m_ex__yujin",
        "m_ex__zhonghui",
        "m_ex__zhuran",
        "m_ex__wuyi",
      },
      ["majian"] = {
      },
      ["mashe"] = {
      },
      ["mini_ambition"] = {
      },
      ["mini_extreme"] = {
      },
      ["mini_other"] = {
      },
      ["mini_re"] = {
      },
      ["mini_shzl"] = {
      },
      ["mini_yj"] = {
      },
      ["minisp"] = {
      },
      ["mobile_bingshi"] = {
      },
      ["mobile_heg"] = {
      },
      ["mobile_jsrg"] = {
      },
      ["mobile_lxxh"] = {
        "mobile__caomao",
      },
      ["mobile_rare"] = {
        "mxing__xuhuang",
      },
      ["mobile_shiji"] = {
        "luotong",
        "mobile__wangcan",
        "godsunce",
      },
      ["mobile_sp"] = {
        "mobile__caoying",
        "mobile__xurong",
        "wanglang",
        "mobile__wangyuanji",
      },
      ["mobile_test"] = {
      },
      ["momentum"] = {
      },
      ["moon_26_bloodbattle"] = {
      },
      ["mou_neng"] = {
        "mou__zhangliao",
      },
      ["mou_shi"] = {
        "mou__guojia",
        "mou__fazheng",
      },
      ["mou_tong"] = {
      },
      ["mou_yu"] = {
        "mou__huanggai",
      },
      ["mou_zhi"] = {
      },
      ["mountain"] = {
      },
      ["offline_heg"] = {
      },
      ["ofl_mougong"] = {
        "ofl_mou__caocao",
        "ofl_mou__liubei",
        "ofl_mou__guanyu",
        "ofl_mou__huangyueying",
      },
      ["ofl_other"] = {
        "ofl_ex__jiaxu",
        "ofl_ex__zhurong",
      },
      ["ofl_rare"] = {
        "cqym__lijue",
      },
      ["ol_ex_shzl"] = {
        "ol_ex__huaxiong",
        "ol_ex__lidian",
        "ol_ex__yuanshao",
        "ol_ex__xuhuang",
      },
      ["ol_exyj"] = {
        "ol_ex__caozhi",
        "ol_ex__zhangchunhua",
        "ol_ex__guanxingzhangbao",
        "ol_ex__guohuai",
        "ol_ex__xiahoushi",
      },
      ["ol_jsrg"] = {
      },
      ["ol_menfa"] = {
        "olz__zhongyao",
        "olz__wangyun",
        "olz__wangling",
        "olz__xunshu",
        "olz__zhongyu",
        "olz__xuncan",
      },
      ["ol_mo"] = {
      },
      ["ol_mou"] = {
        "olmou__jiangwei",
        "olmou__xiaoqiao",
        "olmou__zhangxiu",
        "olmou__sunjian",
        "olmou__guanyu",
      },
      ["ol_other"] = {
      },
      ["ol_qifu"] = {
        "ol__zhangqiying",
        "yuantanyuanshang",
        "ol__zhouchu",
      },
      ["ol_shzl"] = {
        "ol__godzhangjiao",
        "godsunquan",
      },
      ["ol_sp_pack"] = {
        "ol_sp__zhanghe",
        "ol__zhouqun",
      },
      ["ol_test"] = {
      },
      ["ol_wende"] = {
        "zhongyan",
        "shibao",
      },
      ["ol_xinghe"] = {
        "ol__maliang",
        "ol__zhugejin",
        "ol__yangyi",
        "ol__yanghu",
        "quhuang",
        "sunhong",
        "ol__dengzhi",
        "tianchou",
        "ol__wenqin",
        "ol__xujing",
        "ol__mengda",
      },
      ["ol_yj"] = {
        "ol__guyong",
      },
      ["online_heg"] = {
      },
      ["overseas_bingshi"] = {
      },
      ["overseas_ex"] = {
      },
      ["overseas_heg"] = {
      },
      ["overseas_if"] = {
      },
      ["overseas_mougong"] = {
      },
      ["overseas_other"] = {
      },
      ["overseas_rare"] = {
      },
      ["overseas_sp"] = {
        "os__godlvmeng",
      },
      ["overseas_strategizing"] = {
      },
      ["overseas_sxrm"] = {
      },
      ["overseas_wuxia"] = {
      },
      ["overseas_yizhu"] = {
      },
      ["piracy_e"] = {
      },
      ["piracy_s"] = {
      },
      ["power"] = {
      },
      ["pride"] = {
      },
      ["rage"] = {
      },
      ["rise"] = {
      },
      ["shadow"] = {
        "xuyou",
      },
      ["shzj"] = {
        "shzj_yiling__shamoke",
      },
      ["shzl_god"] = {
        "godsimayi",
      },
      ["sixiangfengyin"] = {
      },
      ["sp"] = {
        "xingcai",
      },
      ["sp_jsp"] = {
      },
      ["sp_re"] = {
      },
      ["sp_star"] = {
      },
      ["srxs"] = {
      },
      ["standard"] = {
      },
      ["standard_ex"] = {
      },
      ["suspicion"] = {
      },
      ["tenyear_ex"] = {
        "ty_ex__fazheng",
        "ty_ex__yujin",
        "ty_ex__bulianshi",
        "ty_ex__liubiao",
        "ty_ex__zhuran",
        "ty_ex__liru",
        "ty_ex__chenqun",
        "ty_ex__caorui",
        "ty_ex__guotupangji",
        "ty_ex__liuchen",
      },
      ["tenyear_heg"] = {
      },
      ["tenyear_huicui"] = {
        "ty__chenlin",
        "ty__liuhong",
        "ty__dongcheng",
        "tangji",
        "ty__zhangchangpu",
        "dufuren",
        "zhoushan",
        "zhaoyanw",
        "wenyang",
        "ty__liuzan",
        "duanwei",
        "chunyuqiong",
        "guozhao",
        "ruanyu",
        "ty__yangwan",
        "laiyinger",
        "liubian",
        "ty__sunhao",
      },
      ["tenyear_mou"] = {
        "tymou__guanping",
        "tymou__dongcheng",
        "tymou__huanggai",
        "tymou__jvshou",
      },
      ["tenyear_other"] = {
      },
      ["tenyear_sp"] = {
        "ty__caochun",
      },
      ["tenyear_star"] = {
        "tystar__sunjian",
      },
      ["tenyear_test"] = {
      },
      ["tenyear_wei"] = {
      },
      ["tenyear_xinghuo"] = {
        "ty_ex__guohuanghou",
        "ty_ex__huangyueying",
        "ty__mayunlu",
        "panjun",
      },
      ["tenyear_yj"] = {
        "sunli",
      },
      ["test_p_0"] = {
      },
      ["thunder"] = {
      },
      ["transformation"] = {
      },
      ["transition"] = {
        "js__guojia",
      },
      ["txhy"] = {
      },
      ["wangzhan"] = {
        "wzzz__lusu",
        "wzzz__duyu",
      },
      ["wind"] = {
      },
      ["wrd"] = {
      },
      ["yj2011"] = {
      },
      ["yj2012"] = {
      },
      ["yj2013"] = {
      },
      ["yj2014"] = {
        "zhangsong",
      },
      ["yj2015"] = {
      },
      ["yj2016"] = {
      },
      ["yj2017"] = {
      },
      ["yjtw2013"] = {
      },
      ["yjtw2017"] = {
      },
      ["zcfy"] = {
      },
      ["zfxp"] = {
      },
      ["zqdl"] = {
      },
    },
    normalPkg = {
    },
  }, -- 2 小弟彩虹血战谋将池
  {
    name = "小弟阴间池",
    banCardPkg = {
      "2hu__standard_cards",
      "brainhole_cards",
      "mjs_cards",
      "mjs_cards_token",
      "fz1_token",
      "evol__cards",
      "ridersys",
      "ridersyspve",
      "cf_firemode_1v1_cards",
      "cfcards",
      "yyfy_token",
      "huixiang__poker",
      "huixiang_token",
      "action_cards",
      "action_cards_ol",
      "hl_treasure",
      "jbs_cards",
      "jilve_standard_cards",
      "king_token",
      "king_game",
      "mini_lol_token",
      "lol_token",
      "mc_token",
      "buchen_token",
      "moli_token",
      "moepack_cardex",
      "moepack_cardmagic",
      "moepack_cards",
      "moepack_token",
      "niceness_token",
      "qunyou_cards",
      "LoR_normal_cards",
      "LoR_EGO_cards",
      "th_jie_fuzhi1_cards",
      "th_jie_fuzhi2_cards",
      "th_jie_fuzhi3_cards",
      "LoR_Abnormality_Pages",
      "regicide_cards",
      "tyj_cards",
      "wanyidongxue",
      "wdtx_cards",
      "ym_derived",
      "jyzs_cards",
      "lordcards",
      "ol_hegcards",
      "kanncards",
      "brainhole_cards",
      "wd_xushi_cards",
      "delight_token",
      "mobile_cards",
      "chaos_mode_cards",
      "espionage_cards",
      "vanished_dragon_cards",
      "certamen_cards",
      "derived_cards",
      "3v3_cards",
      "1v1_cards",
      "hegemony_cards",
      "strategic_advantage",
      "lord_cards",
      "ty_1v2_cards",
      "srxs_cards",
      "wrd_cards",
      "mobile_derived",
      "cpt_1v1_cards",
      "ofl_token",
      "bloodbath_longbench_cards",
      "ol_derived",
      "overseas_derived",
      "standard_ex_cards",
      "tenyear_token",
      "m_lord_cards",
      "nine_variations",
      "maneuvering",
      "standard_cards",
      "variation_cards",
    },
    banPkg = {
      ["1v1_generals"] = {
      },
      ["1v1_test_mobile"] = {
      },
      ["1v1_test_ol"] = {
      },
      ["1v1_test_tenyear"] = {
      },
      ["2hu__hfd"] = {
      },
      ["2hu__hyy"] = {
      },
      ["2hu__xsh"] = {
      },
      ["3v3_generals"] = {
      },
      ["EX"] = {
      },
      ["EagleUnion"] = {
      },
      ["GameWin"] = {
      },
      ["LoC"] = {
      },
      ["LoR"] = {
      },
      ["MahjongSoul_feng"] = {
      },
      ["MahjongSoul_hs"] = {
      },
      ["MahjongSoul_lsp"] = {
      },
      ["MahjongSoul_luouy"] = {
      },
      ["MahjongSoul_rolely"] = {
      },
      ["MahjongSoul_zcdiy"] = {
      },
      ["RoyalNavy"] = {
      },
      ["SakuraEmpire"] = {
      },
      ["TXBM"] = {
      },
      ["YC_Coins"] = {
      },
      ["YC_Mo"] = {
      },
      ["YC_Music"] = {
      },
      ["YC_Ren"] = {
      },
      ["YC_Shen"] = {
      },
      ["YC_Xian"] = {
      },
      ["YC_Yao"] = {
      },
      ["abstract"] = {
      },
      ["accessible"] = {
      },
      ["anime"] = {
      },
      ["ao"] = {
      },
      ["aola"] = {
      },
      ["assassins"] = {
      },
      ["ave_mujica"] = {
      },
      ["backdoor"] = {
      },
      ["beginning"] = {
        "js__nanhualaoxian",
      },
      ["bgmdiy"] = {
      },
      ["biaojieshenhua"] = {
      },
      ["borage"] = {
      },
      ["brainhole"] = {
      },
      ["caidog"] = {
      },
      ["campsis"] = {
      },
      ["cathayensis"] = {
      },
      ["cf_gensoul"] = {
      },
      ["chaoyue"] = {
      },
      ["competion"] = {
      },
      ["conclusion"] = {
      },
      ["conquer1"] = {
      },
      ["continue"] = {
      },
      ["continuous"] = {
      },
      ["contribution"] = {
      },
      ["cornel"] = {
      },
      ["cpt_1v1_generals"] = {
      },
      ["cpt_lord_generals"] = {
      },
      ["cswz"] = {
      },
      ["decline"] = {
      },
      ["deify"] = {
      },
      ["dlex"] = {
      },
      ["dlfire"] = {
      },
      ["dlforest"] = {
      },
      ["dlgod"] = {
      },
      ["dllt"] = {
      },
      ["dlmountain"] = {
      },
      ["dlnian"] = {
      },
      ["dlonly"] = {
      },
      ["dlother"] = {
      },
      ["dlstandard"] = {
      },
      ["dlwind"] = {
      },
      ["dlyin"] = {
      },
      ["dlyj"] = {
      },
      ["dlzhan"] = {
      },
      ["dual"] = {
      },
      ["emopack_anime"] = {
      },
      ["emopack_dream"] = {
      },
      ["emopack_game"] = {
      },
      ["emopack_odd"] = {
      },
      ["emopack_sgs"] = {
      },
      ["emopack_wave"] = {
      },
      ["emopack_wind"] = {
      },
      ["espionage_beta"] = {
      },
      ["evoltruster"] = {
      },
      ["fangzhouone"] = {
      },
      ["fangzhouone2"] = {
      },
      ["fangzhouone3"] = {
      },
      ["fangzhouone4"] = {
      },
      ["fangzhouthree"] = {
      },
      ["fangzhoutwo"] = {
      },
      ["fangzhoutwo2"] = {
      },
      ["fate"] = {
      },
      ["fengyun1"] = {
      },
      ["fengyun2"] = {
      },
      ["fire"] = {
      },
      ["fk_heg_sp"] = {
      },
      ["flow"] = {
      },
      ["forest"] = {
      },
      ["formation"] = {
      },
      ["fox"] = {
      },
      ["game"] = {
      },
      ["gamemode_generals"] = {
      },
      ["girlth"] = {
      },
      ["glory"] = {
      },
      ["glory_days"] = {
      },
      ["guichu"] = {
      },
      ["gzg"] = {
      },
      ["hegemony_nos"] = {
      },
      ["hegemony_standard"] = {
      },
      ["huansha"] = {
      },
      ["huiwan1"] = {
      },
      ["huiwan2"] = {
      },
      ["huiwan3"] = {
      },
      ["huixiangtx"] = {
      },
      ["huixiangxs"] = {
      },
      ["huixiangyi"] = {
      },
      ["huixiangzh"] = {
      },
      ["huoying"] = {
      },
      ["hxdoro"] = {
      },
      ["hxqunyou"] = {
      },
      ["hxstar"] = {
      },
      ["inazuma"] = {
      },
      ["iris"] = {
      },
      ["jbs_legend"] = {
      },
      ["jbs_wild"] = {
      },
      ["jbsbuqun"] = {
      },
      ["jbsgensoul"] = {
      },
      ["jbspve"] = {
      },
      ["jbstougao"] = {
      },
      ["jbstougao2"] = {
      },
      ["jbstougao3"] = {
      },
      ["jbstougao4"] = {
      },
      ["jbsxianhuan"] = {
      },
      ["jbszf"] = {
      },
      ["jiange_generals"] = {
      },
      ["jianzhong"] = {
      },
      ["jie"] = {
      },
      ["jilve_a"] = {
      },
      ["jilve_b"] = {
      },
      ["jilve_c"] = {
      },
      ["jilve_evil"] = {
      },
      ["jilve_god"] = {
      },
      ["jilve_godsp"] = {
      },
      ["jilve_legend"] = {
      },
      ["jilve_limit"] = {
      },
      ["jilve_s"] = {
      },
      ["jilve_sr"] = {
      },
      ["jilve_zuoyou"] = {
      },
      ["jinghong"] = {
      },
      ["jingtao"] = {
      },
      ["jinh_zhbh"] = {
      },
      ["jiudecade"] = {
      },
      ["jsct"] = {
      },
      ["jyzs"] = {
      },
      ["kaman_fu"] = {
      },
      ["kaman_renjianti"] = {
      },
      ["kaman_teshu"] = {
      },
      ["kaman_zhu"] = {
      },
      ["kerria"] = {
      },
      ["king_bloodybattle"] = {
      },
      ["king_gamemode_generals"] = {
      },
      ["kings"] = {
      },
      ["klgod"] = {
      },
      ["kljie"] = {
      },
      ["klmou"] = {
      },
      ["klother"] = {
      },
      ["klsan"] = {
      },
      ["klshi"] = {
      },
      ["klsp"] = {
      },
      ["klssft"] = {
      },
      ["klxia"] = {
      },
      ["klxing"] = {
      },
      ["kuang"] = {
      },
      ["kuanglang"] = {
      },
      ["lily"] = {
      },
      ["limitedevent"] = {
      },
      ["liyue"] = {
      },
      ["lol"] = {
      },
      ["lord_ex"] = {
      },
      ["luan"] = {
      },
      ["lunar_devteam"] = {
      },
      ["lunar_lab"] = {
      },
      ["lunar_players"] = {
      },
      ["lunar_sp1"] = {
      },
      ["lunar_xsg"] = {
      },
      ["m_shzl_ex"] = {
      },
      ["m_yj_ex"] = {
        "m_ex__jvshou",
      },
      ["majian"] = {
      },
      ["mashe"] = {
      },
      ["meritocracy"] = {
      },
      ["mini_ambition"] = {
      },
      ["mini_extreme"] = {
      },
      ["mini_lol"] = {
      },
      ["mini_other"] = {
      },
      ["mini_re"] = {
      },
      ["mini_shzl"] = {
      },
      ["mini_yj"] = {
      },
      ["minisp"] = {
      },
      ["mjs_chuhanzhizheng"] = {
      },
      ["mjs_gongxingtianfa"] = {
      },
      ["mjs_hanwushengshi"] = {
      },
      ["mjs_hezonglianheng"] = {
      },
      ["mjs_qianlidanji"] = {
      },
      ["mjs_qinsaoliuhe"] = {
      },
      ["mjs_sanguoyunqi"] = {
      },
      ["mobile_bingshi"] = {
        "m_shi__weiyan",
        "m_shi__yuji",
        "m_shi__guoyuan",
      },
      ["mobile_heg"] = {
      },
      ["mobile_heg_standard"] = {
      },
      ["mobile_jsrg"] = {
      },
      ["mobile_lxxh"] = {
      },
      ["mobile_rare"] = {
        "majun",
        "mxing__wanglang",
        "shichangshi",
      },
      ["mobile_shiji"] = {
        "godguojia",
        "mobile__wenyang",
        "mobile__godmachao",
      },
      ["mobile_sp"] = {
        "yangbiao",
      },
      ["mobile_test"] = {
      },
      ["moepack"] = {
      },
      ["moepack_flower"] = {
      },
      ["moepack_ghost"] = {
      },
      ["moepack_heart"] = {
      },
      ["moepack_heyday"] = {
      },
      ["moepack_moesp"] = {
      },
      ["moepack_moesp2"] = {
      },
      ["moepack_moesp3"] = {
      },
      ["moepack_moon"] = {
      },
      ["moepack_passer"] = {
      },
      ["moepack_tears"] = {
      },
      ["moli"] = {
      },
      ["momentum"] = {
      },
      ["mondstadt"] = {
      },
      ["moon_26_bloodbattle"] = {
      },
      ["mou_neng"] = {
      },
      ["mou_shi"] = {
        "mou__diaochan",
      },
      ["mou_tong"] = {
      },
      ["mou_yu"] = {
        "mou__huangzhong",
      },
      ["mou_zhi"] = {
        "mou__sunquan",
      },
      ["mountain"] = {
      },
      ["movement"] = {
      },
      ["mygo"] = {
      },
      ["new_heg_diy_my_new"] = {
      },
      ["new_heg_generals"] = {
      },
      ["new_heg_guojifu"] = {
      },
      ["new_heg_jyzs"] = {
      },
      ["new_heg_kann"] = {
      },
      ["new_heg_kuo"] = {
      },
      ["new_heg_ld"] = {
      },
      ["new_heg_offline"] = {
      },
      ["new_heg_special"] = {
      },
      ["new_heg_test"] = {
      },
      ["new_heg_zhbh"] = {
      },
      ["new_heg_zqdl"] = {
      },
      ["new_story"] = {
      },
      ["nod_krai"] = {
      },
      ["nt"] = {
      },
      ["offline_heg"] = {
      },
      ["ofl_mougong"] = {
      },
      ["ofl_other"] = {
        "ofl_wenxin__caocao",
        "ofl_wenxin__caopi",
      },
      ["ofl_rare"] = {
      },
      ["ol_ex_shzl"] = {
        "ol_ex__weiyan",
        "ol_ex__lusu",
      },
      ["ol_exyj"] = {
        "ol_ex__liru",
        "ol_ex__zhangsong",
      },
      ["ol_heg_special"] = {
      },
      ["ol_jsrg"] = {
      },
      ["ol_menfa"] = {
        "olz__xunchen",
        "olz__xunyou",
        "olz__xuncai",
        "olz__wuxian",
        "olz__xunyu",
        "olz__zhonghui",
        "olz__xunshix",
      },
      ["ol_mo"] = {
        "ol_evil__lvbu",
        "ol_evil__simayi",
        "ol_evil__zhangfei",
        "ol_evil__sunquan",
      },
      ["ol_mou"] = {
        "olmou__pangtong",
        "olmou__yuanshao",
        "olmou__wenchou",
        "olmou__yuanshu",
        "olmou__huangyueying",
        "olmou__xizhicai",
        "olmou__huaxiong",
        "olmou__zhangxiu",
        "olmou__jiaxu",
        "olmou__xuyou",
        "olmou__jiangwei",
        "olmou__zhurong",
        "olmou__luzhi",
        "olmou__xiaoqiao",
        "olmou__zhangrang",
        "olmou__guojia",
      },
      ["ol_other"] = {
      },
      ["ol_qifu"] = {
        "ol__jiangwan",
        "ol__caochun",
        "ol__guozhao",
        "caoxiancaohua",
        "caoying",
        "ol__baosanniang",
      },
      ["ol_shzl"] = {
        "godsunquan",
        "ol__godhuangzhong",
      },
      ["ol_sp_pack"] = {
        "ol__wanglang",
        "ol_sp__caocao",
      },
      ["ol_standard"] = {
      },
      ["ol_test"] = {
      },
      ["ol_wende"] = {
        "ol__duyu",
      },
      ["ol_xinghe"] = {
        "wangrongh",
        "zhanghua",
        "ol__dingfuren",
        "ol__sunru",
        "ol__chendeng",
        "ol__wenqin",
        "caimao",
      },
      ["ol_yj"] = {
      },
      ["olld"] = {
      },
      ["online_heg"] = {
      },
      ["originality"] = {
      },
      ["other"] = {
      },
      ["overseas_bingshi"] = {
      },
      ["overseas_ex"] = {
      },
      ["overseas_heg"] = {
      },
      ["overseas_if"] = {
      },
      ["overseas_mougong"] = {
      },
      ["overseas_other"] = {
      },
      ["overseas_rare"] = {
      },
      ["overseas_sp"] = {
        "os__jiakui",
      },
      ["overseas_strategizing"] = {
      },
      ["overseas_sxrm"] = {
      },
      ["overseas_wuxia"] = {
      },
      ["overseas_yizhu"] = {
      },
      ["piracy_e"] = {
      },
      ["piracy_s"] = {
      },
      ["policy"] = {
      },
      ["possibilities"] = {
      },
      ["power"] = {
      },
      ["pride"] = {
      },
      ["qgzx"] = {
      },
      ["qiyu"] = {
      },
      ["qsgs_gamemode"] = {
      },
      ["quede"] = {
      },
      ["qunxiongzhulu"] = {
      },
      ["qunyou"] = {
      },
      ["qwisdom"] = {
      },
      ["qyitian"] = {
      },
      ["regicide"] = {
      },
      ["regret"] = {
      },
      ["ren"] = {
      },
      ["rise"] = {
        "js__simazhao",
      },
      ["rosemary"] = {
      },
      ["runefrenzy_gensoul"] = {
      },
      ["sb"] = {
      },
      ["sbsb"] = {
      },
      ["shadow"] = {
      },
      ["shzj"] = {
      },
      ["shzl_god"] = {
        "godganning",
      },
      ["singularity"] = {
      },
      ["sixiangfengyin"] = {
      },
      ["skdisha"] = {
      },
      ["skhunlie"] = {
      },
      ["skjiangxing"] = {
      },
      ["sklegendary"] = {
      },
      ["skpojun"] = {
      },
      ["skrenjie"] = {
      },
      ["sksanying"] = {
      },
      ["sksr"] = {
      },
      ["sktanlang"] = {
      },
      ["sktiangang"] = {
      },
      ["skyinyang"] = {
      },
      ["sp"] = {
      },
      ["sp_jsp"] = {
      },
      ["sp_re"] = {
      },
      ["sp_star"] = {
      },
      ["spr1"] = {
      },
      ["spr2"] = {
      },
      ["spr3"] = {
      },
      ["srxs"] = {
      },
      ["stable"] = {
      },
      ["standard"] = {
      },
      ["standard_ex"] = {
      },
      ["suomi_tebiepian"] = {
      },
      ["suspicion"] = {
      },
      ["tang_heg"] = {
      },
      ["tang_ld"] = {
      },
      ["tenyear_ex"] = {
        "ty_ex__zhonghui",
        "ty_ex__lingtong",
      },
      ["tenyear_heg"] = {
      },
      ["tenyear_huicui"] = {
        "sunchen",
        "zhangjinyun",
        "zhugejing",
        "fanyufeng",
        "wanniangongzhu",
        "liuyong",
        "mu__zhoufei",
        "ty__wangchang",
        "yanfuren",
        "zhoushan",
        "chentai",
        "ty__huaman",
        "ty__mengda",
        "ty__zhangrang",
        "mengyou",
        "wufan",
        "ty__caosong",
        "zhanggong",
        "zhangyao",
        "ty__yangyi",
        "niufu",
        "yuantanyuanshangyuanxi",
        "ty__panshu",
        "zhaoang",
        "ruanji",
        "caomao",
        "ty__sunyi",
        "renwan",
        "caoxian",
        "ganfurenmifuren",
        "wenyang",
        "pangshanmin",
        "ty__xiahouxuan",
        "zhaozhi",
        "tianshangyi",
      },
      ["tenyear_mini_huicui"] = {
      },
      ["tenyear_mini_shzl"] = {
      },
      ["tenyear_mini_standard"] = {
      },
      ["tenyear_mini_xinghuo"] = {
      },
      ["tenyear_mou"] = {
        "tymou__liuxie",
        "tymou__zhuran",
        "tymou__zhangxiu",
        "tymou__lusu",
        "tymou__xusheng",
        "tymou__guanping",
        "tymou__chenlin",
        "tymou__simashi",
        "tymou__guanyu",
        "tymou__pangtong",
        "tymou__jvshou",
        "tymou__wuyi",
        "tymou__fazheng",
        "tymou__caohong",
        "tymou__caoshuang",
      },
      ["tenyear_other"] = {
      },
      ["tenyear_sp"] = {
        "caoyi",
        "godzhangjiao",
        "godzhonghui",
        "ty__godliubei",
        "godxuchu",
        "ty__godzhangliao",
      },
      ["tenyear_star"] = {
        "tystar__yuanshao",
        "tystar__fazheng",
        "tystar__xunyu",
        "tystar__dongyun",
      },
      ["tenyear_test"] = {
      },
      ["tenyear_wei"] = {
      },
      ["tenyear_xinghuo"] = {
      },
      ["tenyear_yj"] = {
        "ty__majun",
        "wufu",
        "xunxu",
      },
      ["test"] = {
      },
      ["test_p_0"] = {
      },
      ["thunder"] = {
      },
      ["toge"] = {
      },
      ["totalpossibilities"] = {
      },
      ["transformation"] = {
      },
      ["transition"] = {
      },
      ["tsld"] = {
      },
      ["tu"] = {
      },
      ["txhy"] = {
      },
      ["tyj_idv"] = {
      },
      ["tyj_lol"] = {
      },
      ["tyj_sp"] = {
      },
      ["tyj_ty"] = {
      },
      ["tyj_wow"] = {
      },
      ["tyjheg_tang"] = {
      },
      ["tyjheg_yuan"] = {
      },
      ["ultimate"] = {
      },
      ["wangzhan"] = {
      },
      ["wanyichunfeng"] = {
      },
      ["wanyifanxing"] = {
      },
      ["wanyixiayang"] = {
      },
      ["warlords_generals"] = {
      },
      ["water_zhonglang"] = {
      },
      ["wdtx"] = {
      },
      ["wind"] = {
      },
      ["wrd"] = {
      },
      ["yinbiao"] = {
      },
      ["yinshen"] = {
      },
      ["yj2011"] = {
      },
      ["yj2012"] = {
      },
      ["yj2013"] = {
      },
      ["yj2014"] = {
      },
      ["yj2015"] = {
      },
      ["yj2016"] = {
      },
      ["yj2017"] = {
      },
      ["yjtw2013"] = {
      },
      ["yjtw2017"] = {
      },
      ["ym1"] = {
      },
      ["ym2"] = {
      },
      ["yugioh"] = {
      },
      ["zcfy"] = {
      },
      ["zfxp"] = {
      },
      ["zhong"] = {
      },
      ["zm_neng"] = {
      },
      ["zm_shi"] = {
      },
      ["zm_tong"] = {
      },
      ["zm_yu"] = {
      },
      ["zm_zhi"] = {
      },
      ["zqdl"] = {
      },
      ["zunzhiming"] = {
      },
      ["zztx"] = {
      },
    },
    normalPkg = {
      ["bloodybattle_generals"] = {
        "btl__dingfuren",
        "btl__caohua",
        "btl_delight__xizhicai",
      },
      ["rage"] = {
        "sx__zhangzhao",
        "sx__caoren",
        "sx__zhaoyun",
        "sx2__caocao",
        "jiahua",
        "sx__sunshangxiang",
        "sx__lusu",
        "sx__zhugeliang",
        "sx__zhouyu",
      },
    },
  }, -- 3 小弟彩虹血战阴
  {
    name = "小弟顶阴池",
    banCardPkg = {
      "bloodybattle_3v3_cards",
      "delight_token",
      "mobile_cards",
      "chaos_mode_cards",
      "espionage_cards",
      "vanished_dragon_cards",
      "variation_cards",
      "certamen_cards",
      "derived_cards",
      "3v3_cards",
      "1v1_cards",
      "hegemony_cards",
      "strategic_advantage",
      "nine_variations",
      "lord_cards",
      "m_lord_cards",
      "ty_1v2_cards",
      "srxs_cards",
      "wrd_cards",
      "mobile_derived",
      "ofl_token",
      "bloodbath_longbench_cards",
      "ol_derived",
      "overseas_derived",
      "standard_ex_cards",
      "tenyear_token",
    },
    banPkg = {
      ["1v1_generals"] = {
      },
      ["3v3_generals"] = {
      },
      ["assassins"] = {
      },
      ["beginning"] = {
      },
      ["bgmdiy"] = {
      },
      ["conclusion"] = {
      },
      ["continue"] = {
      },
      ["decline"] = {
      },
      ["dlex"] = {
      },
      ["dlfire"] = {
      },
      ["dlforest"] = {
      },
      ["dlgod"] = {
      },
      ["dllt"] = {
      },
      ["dlmountain"] = {
      },
      ["dlonly"] = {
      },
      ["dlother"] = {
      },
      ["dlstandard"] = {
      },
      ["dlwind"] = {
      },
      ["dlyj"] = {
      },
      ["espionage_beta"] = {
      },
      ["fire"] = {
      },
      ["forest"] = {
      },
      ["formation"] = {
      },
      ["gamemode_generals"] = {
      },
      ["hegemony_nos"] = {
      },
      ["hegemony_standard"] = {
      },
      ["huansha"] = {
      },
      ["jiange_generals"] = {
      },
      ["jyzs"] = {
      },
      ["king_bloodybattle"] = {
      },
      ["lord_ex"] = {
      },
      ["m_shzl_ex"] = {
      },
      ["m_yj_ex"] = {
      },
      ["majian"] = {
      },
      ["mashe"] = {
      },
      ["mini_ambition"] = {
      },
      ["mini_extreme"] = {
      },
      ["mini_other"] = {
      },
      ["mini_re"] = {
      },
      ["mini_shzl"] = {
      },
      ["mini_yj"] = {
      },
      ["minisp"] = {
      },
      ["mobile_bingshi"] = {
        "m_shi__zhouyu",
      },
      ["mobile_heg"] = {
      },
      ["mobile_jsrg"] = {
      },
      ["mobile_lxxh"] = {
      },
      ["mobile_rare"] = {
        "mobile__godsimayi",
      },
      ["mobile_shiji"] = {
        "godxunyu",
        "mobile__godjiangwei",
      },
      ["mobile_sp"] = {
      },
      ["mobile_test"] = {
      },
      ["momentum"] = {
      },
      ["mou_neng"] = {
      },
      ["mou_shi"] = {
      },
      ["mou_tong"] = {
      },
      ["mou_yu"] = {
      },
      ["mou_zhi"] = {
      },
      ["mountain"] = {
      },
      ["offline_heg"] = {
      },
      ["ofl_mougong"] = {
      },
      ["ofl_other"] = {
      },
      ["ofl_rare"] = {
      },
      ["ol_ex_shzl"] = {
        "ol_ex__xunyu",
        "ol_ex__lusu",
      },
      ["ol_exyj"] = {
      },
      ["ol_jsrg"] = {
      },
      ["ol_menfa"] = {
        "olz__zhongyan",
      },
      ["ol_mo"] = {
      },
      ["ol_mou"] = {
        "olmou__zhugeliang",
        "olmou__dongzhuo",
        "olmou__xuyou",
      },
      ["ol_other"] = {
      },
      ["ol_qifu"] = {
        "ol__baosanniang",
        "caoying",
        "wolongfengchu",
        "ol__feiyi",
      },
      ["ol_shzl"] = {
      },
      ["ol_sp_pack"] = {
        "ol_sp__liubei",
      },
      ["ol_test"] = {
      },
      ["ol_wende"] = {
      },
      ["ol_xinghe"] = {
        "weizi",
      },
      ["ol_yj"] = {
      },
      ["online_heg"] = {
      },
      ["overseas_bingshi"] = {
      },
      ["overseas_ex"] = {
      },
      ["overseas_heg"] = {
      },
      ["overseas_if"] = {
      },
      ["overseas_mougong"] = {
      },
      ["overseas_other"] = {
      },
      ["overseas_rare"] = {
      },
      ["overseas_sp"] = {
      },
      ["overseas_strategizing"] = {
      },
      ["overseas_sxrm"] = {
      },
      ["overseas_wuxia"] = {
      },
      ["overseas_yizhu"] = {
      },
      ["piracy_e"] = {
      },
      ["piracy_s"] = {
      },
      ["power"] = {
      },
      ["pride"] = {
      },
      ["qgzx"] = {
      },
      ["rage"] = {
        "sx__zhouyu",
      },
      ["rise"] = {
      },
      ["shadow"] = {
      },
      ["shzj"] = {
      },
      ["shzl_god"] = {
      },
      ["sixiangfengyin"] = {
      },
      ["sp"] = {
      },
      ["sp_jsp"] = {
      },
      ["sp_re"] = {
      },
      ["sp_star"] = {
      },
      ["srxs"] = {
      },
      ["standard"] = {
      },
      ["standard_ex"] = {
      },
      ["suspicion"] = {
        "sx__caocao",
      },
      ["tenyear_ex"] = {
        "ty_ex__zhangsong",
      },
      ["tenyear_heg"] = {
      },
      ["tenyear_huicui"] = {
        "ty__zhaoyan",
        "ty__huban",
        "guannings",
        "ty__nanhualaoxian",
        "zhangxuan",
        "ty__sunru",
        "lvlingqi",
        "huangwudie",
        "tenggongzhu",
        "weifengw",
        "ty__zhugejun",
        "ty__zhangmancheng",
        "mu__caiwenji",
        "mu__daqiao",
        "mu__xiaoqiao",
        "mu__diaochan",
        "ty__wenqin",
        "simahui",
        "ty__puyuan",
        "zerong",
        "zhaoang",
        "ty__liuye",
        "xuelingyun",
        "ty__ruiji",
        "bailingyun",
        "xuwen",
        "caomao",
        "ty__qinghegongzhu",
        "caofang",
        "ty__fengfangnv",
        "caoxian",
        "ty__tengfanglan",
        "zhoubuyi",
        "ty__xujing",
        "renwan",
      },
      ["tenyear_mou"] = {
        "tymou__zhouyu",
        "tymou__lusu",
        "tymou__jiaxu",
        "tymou__xunyu",
        "tymou__jiangwei",
        "tymou__luxun",
        "tymou__pangtong",
        "tymou__zhugeliang",
        "tymou__dongcheng",
        "tymou__wangping",
        "tymou__chengyu",
        "tymou__luotong",
      },
      ["tenyear_other"] = {
      },
      ["tenyear_sp"] = {
        "godzhangfei",
        "godhuangzhong",
        "godpangtong",
        "xurong",
        "zhangqiying",
        "zhouyi",
        "ty__wanglang",
        "wm__zhugeliang",
        "wm__huangfusong",
        "wm__zhangfei",
      },
      ["tenyear_star"] = {
        "tystar__dongzhuo",
        "tystar__yuanshao",
        "tystar__zhangchunhua",
        "tystar__dongyun",
      },
      ["tenyear_test"] = {
      },
      ["tenyear_wei"] = {
        "ty_wei__gongsunzan",
        "ty_wei__caopi",
        "ty_wei__caocao",
        "ty_wei__sunce",
        "ty_wei__liubei",
      },
      ["tenyear_xinghuo"] = {
      },
      ["tenyear_yj"] = {
        "ty__majun",
      },
      ["test_p_0"] = {
      },
      ["thunder"] = {
      },
      ["transformation"] = {
      },
      ["transition"] = {
      },
      ["txhy"] = {
      },
      ["wangzhan"] = {
      },
      ["wind"] = {
      },
      ["wrd"] = {
      },
      ["yj2011"] = {
      },
      ["yj2012"] = {
      },
      ["yj2013"] = {
      },
      ["yj2014"] = {
      },
      ["yj2015"] = {
      },
      ["yj2016"] = {
      },
      ["yj2017"] = {
      },
      ["yjtw2013"] = {
      },
      ["yjtw2017"] = {
      },
      ["zcfy"] = {
      },
      ["zfxp"] = {
      },
      ["zqdl"] = {
      },
    },
    normalPkg = {
      ["bloodybattle_generals"] = {
        "btl_delight__xizhicai",
      },
    },
  }, -- 4 小弟2026-09-14T10:48:43.833Z
  {
    name = "小弟仙界池",
    banCardPkg = {
      "bloodybattle_3v3_cards",
      "delight_token",
      "mobile_cards",
      "chaos_mode_cards",
      "espionage_cards",
      "vanished_dragon_cards",
      "variation_cards",
      "certamen_cards",
      "derived_cards",
      "3v3_cards",
      "1v1_cards",
      "hegemony_cards",
      "strategic_advantage",
      "nine_variations",
      "lord_cards",
      "m_lord_cards",
      "ty_1v2_cards",
      "srxs_cards",
      "wrd_cards",
      "mobile_derived",
      "ofl_token",
      "bloodbath_longbench_cards",
      "ol_derived",
      "overseas_derived",
      "standard_ex_cards",
      "tenyear_token",
    },
    banPkg = {
      ["1v1_generals"] = {
      },
      ["3v3_generals"] = {
      },
      ["assassins"] = {
      },
      ["beginning"] = {
      },
      ["bgmdiy"] = {
      },
      ["bloodybattle_generals"] = {
      },
      ["conclusion"] = {
      },
      ["continue"] = {
      },
      ["decline"] = {
      },
      ["dlex"] = {
      },
      ["dlfire"] = {
      },
      ["dlforest"] = {
      },
      ["dlgod"] = {
      },
      ["dllt"] = {
      },
      ["dlmountain"] = {
      },
      ["dlonly"] = {
      },
      ["dlother"] = {
      },
      ["dlstandard"] = {
      },
      ["dlwind"] = {
      },
      ["dlyj"] = {
      },
      ["espionage_beta"] = {
      },
      ["fire"] = {
      },
      ["forest"] = {
      },
      ["formation"] = {
      },
      ["gamemode_generals"] = {
      },
      ["hegemony_nos"] = {
      },
      ["hegemony_standard"] = {
      },
      ["huansha"] = {
      },
      ["jiange_generals"] = {
      },
      ["jyzs"] = {
      },
      ["king_bloodybattle"] = {
      },
      ["lord_ex"] = {
      },
      ["m_shzl_ex"] = {
      },
      ["m_yj_ex"] = {
      },
      ["majian"] = {
      },
      ["mashe"] = {
      },
      ["mini_ambition"] = {
      },
      ["mini_extreme"] = {
      },
      ["mini_other"] = {
      },
      ["mini_re"] = {
      },
      ["mini_shzl"] = {
      },
      ["mini_yj"] = {
      },
      ["minisp"] = {
      },
      ["mobile_bingshi"] = {
        "m_shi__zhouyu",
      },
      ["mobile_heg"] = {
      },
      ["mobile_jsrg"] = {
      },
      ["mobile_lxxh"] = {
      },
      ["mobile_rare"] = {
      },
      ["mobile_shiji"] = {
        "godxunyu",
        "mobile__godjiangwei",
      },
      ["mobile_sp"] = {
      },
      ["mobile_test"] = {
      },
      ["momentum"] = {
      },
      ["mou_neng"] = {
      },
      ["mou_shi"] = {
      },
      ["mou_tong"] = {
      },
      ["mou_yu"] = {
      },
      ["mou_zhi"] = {
      },
      ["mountain"] = {
      },
      ["offline_heg"] = {
      },
      ["ofl_mougong"] = {
      },
      ["ofl_other"] = {
      },
      ["ofl_rare"] = {
      },
      ["ol_ex_shzl"] = {
      },
      ["ol_exyj"] = {
      },
      ["ol_jsrg"] = {
      },
      ["ol_menfa"] = {
      },
      ["ol_mo"] = {
        "ol_evil__diaochan",
      },
      ["ol_mou"] = {
        "olmou__zhugeliang",
      },
      ["ol_other"] = {
      },
      ["ol_qifu"] = {
        "ol__baosanniang",
        "caoshuang",
        "wolongfengchu",
        "ol__panshu",
        "ol__fengfangnv",
      },
      ["ol_shzl"] = {
      },
      ["ol_sp_pack"] = {
        "ol_sp__liubei",
        "ol__nanhualaoxian",
        "ol__miheng",
      },
      ["ol_test"] = {
      },
      ["ol_wende"] = {
      },
      ["ol_xinghe"] = {
        "ol__huangchengyan",
      },
      ["ol_yj"] = {
      },
      ["online_heg"] = {
      },
      ["overseas_bingshi"] = {
      },
      ["overseas_ex"] = {
      },
      ["overseas_heg"] = {
      },
      ["overseas_if"] = {
        "os_if__caoang",
      },
      ["overseas_mougong"] = {
      },
      ["overseas_other"] = {
      },
      ["overseas_rare"] = {
      },
      ["overseas_sp"] = {
      },
      ["overseas_strategizing"] = {
      },
      ["overseas_sxrm"] = {
        "os_sx__caocao",
      },
      ["overseas_wuxia"] = {
      },
      ["overseas_yizhu"] = {
      },
      ["piracy_e"] = {
      },
      ["piracy_s"] = {
      },
      ["power"] = {
      },
      ["pride"] = {
      },
      ["qgzx"] = {
      },
      ["rage"] = {
      },
      ["rise"] = {
      },
      ["shadow"] = {
      },
      ["shzj"] = {
      },
      ["shzl_god"] = {
      },
      ["sixiangfengyin"] = {
      },
      ["sp"] = {
      },
      ["sp_jsp"] = {
      },
      ["sp_re"] = {
      },
      ["sp_star"] = {
      },
      ["srxs"] = {
      },
      ["standard"] = {
      },
      ["standard_ex"] = {
      },
      ["suspicion"] = {
      },
      ["tenyear_ex"] = {
      },
      ["tenyear_heg"] = {
      },
      ["tenyear_huicui"] = {
        "ty__xushao",
        "panghui",
        "panghong",
        "mamiao",
        "weifengw",
        "yuanyin",
        "guanning",
        "ty__huangchengyan",
        "ty__liuba",
        "ty__lifeng",
        "mu__miheng",
        "bailingyun",
        "ty__qinghegongzhu",
        "ty__xiahouhui",
        "ty_sp__zhenji",
        "caojinyu",
        "liutan",
        "wenyuan",
        "lizhaoyi",
        "zhongyu",
      },
      ["tenyear_mou"] = {
        "tymou__simayi",
        "tymou__zhugeliang",
        "tymou__caoang",
        "tymou__xuyou",
        "tymou__dongcheng",
        "tymou__dengai",
        "tymou__huangquan",
      },
      ["tenyear_other"] = {
      },
      ["tenyear_star"] = {
        "tystar__caoren",
      },
      ["tenyear_test"] = {
      },
      ["tenyear_xinghuo"] = {
      },
      ["tenyear_yj"] = {
        "chenshi",
        "ty__zhanghuan",
      },
      ["test_p_0"] = {
      },
      ["thunder"] = {
      },
      ["transformation"] = {
      },
      ["transition"] = {
      },
      ["txhy"] = {
      },
      ["wangzhan"] = {
      },
      ["wind"] = {
      },
      ["wrd"] = {
      },
      ["yj2011"] = {
      },
      ["yj2012"] = {
      },
      ["yj2013"] = {
      },
      ["yj2014"] = {
      },
      ["yj2015"] = {
      },
      ["yj2016"] = {
      },
      ["yj2017"] = {
      },
      ["yjtw2013"] = {
      },
      ["yjtw2017"] = {
      },
      ["zcfy"] = {
      },
      ["zfxp"] = {
      },
      ["zqdl"] = {
      },
    },
    normalPkg = {
      ["tenyear_sp"] = {
        "ty__godguanyu",
        "ty__godliubei",
        "ty__godzhangliao",
        "godzhangjiao",
        "goddianwei",
        "godxuchu",
        "godzhonghui",
        "ty__godcaopi",
        "ty__baosanniang",
        "xurong",
        "ty__caochun",
        "zhangqiying",
        "zhouyi",
        "caoyi",
        "guotiying",
        "liupanxi",
        "ty__wanglang",
        "wm__lukang",
      },
      ["tenyear_wei"] = {
        "ty_wei__dongzhuo",
        "ty_wei__caozhang",
        "ty_wei__guanyinping",
      },
    },
  }, -- 5 小弟2026-09-15T04:47:48.193Z
  {
    name = "26王战池",
    banCardPkg = {
      "ol_hegcards",
      "kanncards",
      "lordcards",
      "jyzs_cards",
      "delight_token",
      "huan1v1_cards",
      "cpt_1v1_cards",
      "standard_cards",
      "maneuvering",
      "mod_ex_cards",
      "mobile_cards",
      "chaos_mode_cards",
      "espionage_cards",
      "vanished_dragon_cards",
      "variation_cards",
      "certamen_cards",
      "derived_cards",
      "3v3_cards",
      "1v1_cards",
      "hegemony_cards",
      "strategic_advantage",
      "lord_cards",
      "ling_cards",
      "ling_1v1_cards",
      "ty_1v2_cards",
      "wrd_cards",
      "mobile_derived",
      "ofl_token",
      "bloodbath_longbench_cards",
      "ol_derived",
      "overseas_derived",
      "seaborn_cards",
      "standard_ex_cards",
      "tenyear_token",
      "tuntian_cards",
      "tyj_cards",
      "tea_ex_cards",
      "teyvat_cards",
      "m_lord_cards",
      "nine_variations",
      "srxs_cards",
      "maneuvering",
      "standard_cards",
      "maneuvering",
      "standard_cards",
      "mini_token",
    },
    banPkg = {
      ["1v1_generals"] = {
      },
      ["1v1_test_mobile"] = {
      },
      ["1v1_test_ol"] = {
      },
      ["1v1_test_tenyear"] = {
      },
      ["3v3_generals"] = {
      },
      ["EX"] = {
      },
      ["accessible"] = {
      },
      ["anime"] = {
      },
      ["assassins"] = {
      },
      ["backdoor"] = {
      },
      ["beginning"] = {
      },
      ["bgmdiy"] = {
      },
      ["bloodybattle_generals"] = {
      },
      ["caidog"] = {
      },
      ["competion"] = {
      },
      ["conclusion"] = {
      },
      ["continue"] = {
      },
      ["cpt_1v1_generals"] = {
      },
      ["cpt_lord_generals"] = {
      },
      ["decline"] = {
      },
      ["dlex"] = {
      },
      ["dlfire"] = {
      },
      ["dlforest"] = {
      },
      ["dlgod"] = {
      },
      ["dllt"] = {
      },
      ["dlmountain"] = {
      },
      ["dlonly"] = {
      },
      ["dlother"] = {
      },
      ["dlstandard"] = {
      },
      ["dlwind"] = {
      },
      ["dlyj"] = {
      },
      ["espionage_beta"] = {
      },
      ["fire"] = {
      },
      ["fk_heg_sp"] = {
      },
      ["flow"] = {
      },
      ["forest"] = {
      },
      ["formation"] = {
      },
      ["game"] = {
      },
      ["gamemode_generals"] = {
      },
      ["greed"] = {
      },
      ["hegemony_nos"] = {
      },
      ["hegemony_standard"] = {
      },
      ["huansha"] = {
      },
      ["jiange_generals"] = {
      },
      ["jinh_zhbh"] = {
      },
      ["jyzs"] = {
      },
      ["king_bloodybattle"] = {
        "king_btl__wenpin",
        "king_btl__guanyu",
        "king_btl__zhugejin",
        "king_btl__diaochan",
        "king_btl__yanliangwenchou",
        "king_btl__duyu",
        "king_btl__guanxingzhangbao",
        "king_btl__wolong",
        "king_btl__zumao",
        "king_btl__liru",
        "king_btl__wangping",
        "king_btl__zhugeke",
        "king_btl__dianwei",
        "king_btl__xiahoudun",
        "king_btl__xuhuang",
        "king_btl__wangji",
        "king_btl__chenqun",
        "king_btl__caoang",
        "king_btl__maojie",
        "king_btl__simayi",
        "kbtl_sp__machao",
        "king_btl__xiahoushi",
        "king_btl__zhangzhaozhanghong",
        "king_btl__wenyang",
        "king_btl__huaxiong",
        "king_btl__chengong",
        "king_btl__jvshou",
        "king_btl__mateng",
        "king_btl__gongsunzan",
        "king_btl__maliang",
        "king_btl__shamoke",
        "king_btl__gaolan",
        "king_btl__zhuling",
        "king_btl__xusheng",
        "king_btl__sunshangxiang",
        "king_btl__liubei",
        "king_btl__zhangfei",
        "king_btl__dingfeng",
        "king_btl__bulianshi",
        "king_btl__panfeng",
        "king_btl__liufeng",
        "king_btl__zhugeliang",
        "king_btl__cuiyan",
        "king_btl__jiangqin",
        "king_btl__liushan",
        "king_btl__zhangyiy",
        "king_btl__qiaozhou",
        "king_btl__liuzan",
        "king_btl__cenhun",
        "king_btl__yujin",
        "king_btl__hansui",
        "king_btl__quyi",
        "king_btl__pangdegong",
        "king_btl__menghuo",
        "king_btl__lvbu",
        "king_btl__zhaoyun",
        "king_btl__jianggan",
        "king_btl__lingtong",
        "king_btl__luzhiw",
        "king_btl__lidian",
        "king_btl__xunyou",
        "king_btl__caocao",
        "king_btl__yanrou",
        "king_btl__caorui",
        "king_btl__haozhao",
        "king_btl__xiahouyuan",
        "king_btl__zhongyao",
        "king_btl2__zhangyiy",
        "king_btl__furong",
        "king_btl__machao",
        "king_btl__masu",
        "king_btl__xingcai",
        "king_btl__wuyi",
        "king_btl__qinmi",
        "king_btl__zhugezhan",
        "king_btl__mizhu",
        "king_btl__weiyan",
        "king_btl__jiangwei",
        "king_btl__fazheng",
        "king_btl__huangyueying",
        "kbtl_sp__pangtong",
        "king_btl__zhuhuan",
        "king_btl__sunhao",
        "king_btl__lingcao",
        "king_btl__sunquan",
        "king_btl__huanggai",
        "king_btl__zhoufang",
        "king_btl__buzhi",
        "king_btl__quancong",
        "king_btl__zhuran",
        "king_btl__guyong",
        "king_btl__taishici",
        "king_btl__zhanghe",
        "king_btl__gongsunyuan",
        "kbtl_sp__sunce",
        "king_btl__liuxie",
        "king_btl__xuyou",
        "king_btl__dingyuan",
        "king_btl__caifuren",
        "king_btl__daqiao",
      },
      ["limitedevent"] = {
      },
      ["lord_ex"] = {
      },
      ["m_shzl_ex"] = {
      },
      ["m_yj_ex"] = {
      },
      ["majian"] = {
      },
      ["mashe"] = {
      },
      ["meritocracy"] = {
      },
      ["mini_ambition"] = {
      },
      ["mini_extreme"] = {
      },
      ["mini_other"] = {
      },
      ["mini_re"] = {
      },
      ["mini_shzl"] = {
      },
      ["mini_yj"] = {
      },
      ["minisp"] = {
      },
      ["mobile_bingshi"] = {
      },
      ["mobile_heg"] = {
      },
      ["mobile_heg_standard"] = {
      },
      ["mobile_jsrg"] = {
      },
      ["mobile_lxxh"] = {
      },
      ["mobile_mougong"] = {
      },
      ["mobile_rare"] = {
      },
      ["mobile_shiji"] = {
      },
      ["mobile_sp"] = {
      },
      ["mobile_test"] = {
      },
      ["momentum"] = {
      },
      ["moon_26_bloodbattle"] = {
      },
      ["mou_neng"] = {
      },
      ["mou_shi"] = {
      },
      ["mou_tong"] = {
      },
      ["mou_yu"] = {
      },
      ["mou_zhi"] = {
      },
      ["mountain"] = {
      },
      ["movement"] = {
      },
      ["new_heg_diy_my_new"] = {
      },
      ["new_heg_generals"] = {
      },
      ["new_heg_guojifu"] = {
      },
      ["new_heg_jyzs"] = {
      },
      ["new_heg_kann"] = {
      },
      ["new_heg_kuo"] = {
      },
      ["new_heg_ld"] = {
      },
      ["new_heg_offline"] = {
      },
      ["new_heg_special"] = {
      },
      ["new_heg_test"] = {
      },
      ["new_heg_zhbh"] = {
      },
      ["new_heg_zqdl"] = {
      },
      ["offline_heg"] = {
      },
      ["ofl_mougong"] = {
      },
      ["ofl_other"] = {
      },
      ["ofl_rare"] = {
      },
      ["ol_ex_shzl"] = {
      },
      ["ol_exyj"] = {
      },
      ["ol_heg_special"] = {
      },
      ["ol_jsrg"] = {
      },
      ["ol_menfa"] = {
      },
      ["ol_mo"] = {
      },
      ["ol_mou"] = {
      },
      ["ol_other"] = {
      },
      ["ol_qifu"] = {
      },
      ["ol_shzl"] = {
      },
      ["ol_sp_pack"] = {
      },
      ["ol_standard"] = {
      },
      ["ol_test"] = {
      },
      ["ol_wende"] = {
      },
      ["ol_xinghe"] = {
      },
      ["ol_yj"] = {
      },
      ["olld"] = {
      },
      ["online_heg"] = {
      },
      ["overseas_bingshi"] = {
      },
      ["overseas_ex"] = {
      },
      ["overseas_heg"] = {
      },
      ["overseas_if"] = {
      },
      ["overseas_mougong"] = {
      },
      ["overseas_other"] = {
      },
      ["overseas_rare"] = {
      },
      ["overseas_sp"] = {
      },
      ["overseas_strategizing"] = {
      },
      ["overseas_sxrm"] = {
      },
      ["overseas_wuxia"] = {
      },
      ["overseas_yizhu"] = {
      },
      ["piracy_e"] = {
      },
      ["piracy_s"] = {
      },
      ["policy"] = {
      },
      ["power"] = {
      },
      ["pride"] = {
      },
      ["qgzx"] = {
      },
      ["qiyu"] = {
      },
      ["rage"] = {
      },
      ["reissue"] = {
      },
      ["rise"] = {
      },
      ["shadow"] = {
      },
      ["shzj"] = {
      },
      ["shzl_god"] = {
      },
      ["sixiangfengyin"] = {
      },
      ["sp"] = {
      },
      ["sp_jsp"] = {
      },
      ["sp_re"] = {
      },
      ["sp_star"] = {
      },
      ["srxs"] = {
      },
      ["stable"] = {
      },
      ["standard"] = {
      },
      ["standard_ex"] = {
      },
      ["suspicion"] = {
      },
      ["tang_heg"] = {
      },
      ["tang_ld"] = {
      },
      ["tenyear_ex"] = {
      },
      ["tenyear_heg"] = {
      },
      ["tenyear_huicui"] = {
      },
      ["tenyear_mou"] = {
      },
      ["tenyear_other"] = {
      },
      ["tenyear_sp"] = {
      },
      ["tenyear_star"] = {
      },
      ["tenyear_test"] = {
      },
      ["tenyear_wei"] = {
      },
      ["tenyear_xinghuo"] = {
      },
      ["tenyear_yj"] = {
      },
      ["test_p_0"] = {
      },
      ["thunder"] = {
      },
      ["transformation"] = {
      },
      ["transition"] = {
      },
      ["txhy"] = {
      },
      ["tyjheg_tang"] = {
      },
      ["tyjheg_yuan"] = {
      },
      ["wangzhan"] = {
      },
      ["warlords_generals"] = {
      },
      ["wind"] = {
      },
      ["wrd"] = {
      },
      ["yj2011"] = {
      },
      ["yj2012"] = {
      },
      ["yj2013"] = {
      },
      ["yj2014"] = {
      },
      ["yj2015"] = {
      },
      ["yj2016"] = {
      },
      ["yj2017"] = {
      },
      ["yjtw2013"] = {
      },
      ["yjtw2017"] = {
      },
      ["zcfy"] = {
      },
      ["zfxp"] = {
      },
      ["zqdl"] = {
      },
    },
    normalPkg = {
    },
  }, -- 6 26王战血战26.10.18
}