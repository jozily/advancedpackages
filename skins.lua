-- 精选原画（皮肤形式）：参考 lunarltk_skins / fengsui_skins 的 SkinPack 实现。
-- 图片仍留在原资源目录，本文件只按武将注册皮肤，不移动、不删除、不复制任何图片。
-- 删除本文件或从 advancedpackages/init.lua 移除引用即可整体撤销。

local extension = Package:new("advanced_art_skins", Package.SkinPack)
extension.extensionName = "advancedpackages"

-- 每个原画子目录一次注册：path 直接指向该目录的 image/generals，
-- 皮肤名即图片文件名（武将 id），界面显示名由下方翻译表给出。
extension:addSkinPackage {
  path = "/精选原画/精选/1【OL】夏侯徽②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "xiahouhui" },
      skins = { "xiahouhui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/1【手杀】曹髦②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__caomao" },
      skins = { "mobile__caomao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/bulianshi/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__bulianshi" },
      skins = { "king_btl__bulianshi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/buzhi/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__buzhi" },
      skins = { "king_btl__buzhi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/caifuren/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__caifuren" },
      skins = { "king_btl__caifuren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/caoang/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__caoang" },
      skins = { "king_btl__caoang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/caocao/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__caocao" },
      skins = { "king_btl__caocao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/caohua/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "btl__caohua" },
      skins = { "btl__caohua.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/caoren/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__caoren" },
      skins = { "king_btl__caoren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/caorui/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__caorui" },
      skins = { "king_btl__caorui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/chengong/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__chengong" },
      skins = { "king_btl__chengong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/chenqun/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__chenqun" },
      skins = { "king_btl__chenqun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/cuiyan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__cuiyan" },
      skins = { "king_btl__cuiyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/daqiao/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__daqiao" },
      skins = { "king_btl__daqiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/dengai/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__dengai" },
      skins = { "king_btl__dengai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/dianwei/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__dianwei" },
      skins = { "king_btl__dianwei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/diaochan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__diaochan" },
      skins = { "king_btl__diaochan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/dingyuan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__dingyuan" },
      skins = { "king_btl__dingyuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/fazheng/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__fazheng" },
      skins = { "king_btl__fazheng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/gaoshun/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__gaoshun" },
      skins = { "king_btl__gaoshun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/gongsunyuan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__gongsunyuan" },
      skins = { "king_btl__gongsunyuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/gongsunzan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__gongsunyuan" },
      skins = { "ty_ex__gongsunyuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/guanxingzhangbao/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__guanxingzhangbao" },
      skins = { "king_btl__guanxingzhangbao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/guanyinping/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__guanyinping" },
      skins = { "king_btl__guanyinping.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/guanyu/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__guanyu" },
      skins = { "king_btl__guanyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/guojia/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__guojia" },
      skins = { "king_btl__guojia.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/guotupangji/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__guotupangji" },
      skins = { "king_btl__guotupangji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/haozhao/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__haozhao" },
      skins = { "king_btl__haozhao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/huanggai/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__huanggai" },
      skins = { "king_btl__huanggai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/huangquan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__huangquan" },
      skins = { "king_btl__huangquan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/huaxiong/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__huaxiong" },
      skins = { "king_btl__huaxiong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/jianggan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__jianggan" },
      skins = { "king_btl__jianggan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/jiangwei/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__jiangwei" },
      skins = { "king_btl__jiangwei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/jiaxu/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__jiaxu" },
      skins = { "king_btl__jiaxu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/jushou/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__jvshou" },
      skins = { "king_btl__jvshou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/lidian/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__lidian" },
      skins = { "king_btl__lidian.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/lingtong/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__lingtong" },
      skins = { "king_btl__lingtong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/liushan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__liushan" },
      skins = { "king_btl__liushan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/liuxie/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__liuxie" },
      skins = { "king_btl__liuxie.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/lusu/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__lusu" },
      skins = { "king_btl__lusu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/luxun/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__luxun" },
      skins = { "king_btl__luxun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/luzhi/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__luzhiw" },
      skins = { "king_btl__luzhiw.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/machao/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__machao" },
      skins = { "king_btl__machao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/mateng/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__mateng" },
      skins = { "king_btl__mateng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/mifuren/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "ty__mifuren" },
      skins = { "ty__mifuren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/mizhu/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__mizhu" },
      skins = { "king_btl__mizhu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/panfeng/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__panfeng" },
      skins = { "king_btl__panfeng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/qinmi/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__qinmi" },
      skins = { "king_btl__qinmi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/quyi/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__quyi" },
      skins = { "king_btl__quyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/shamoke/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__shamoke" },
      skins = { "king_btl__shamoke.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/simayi/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__simayi" },
      skins = { "king_btl__simayi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/sp_machao/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "kbtl_sp__machao" },
      skins = { "kbtl_sp__machao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/sp_pangtong/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "kbtl_sp__pangtong" },
      skins = { "kbtl_sp__pangtong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/sundeng/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__sundeng" },
      skins = { "king_btl__sundeng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/sunhao/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__sunhao" },
      skins = { "king_btl__sunhao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/sunquan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__sunquan" },
      skins = { "king_btl__sunquan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/sunshangxiang/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__sunshangxiang" },
      skins = { "king_btl__sunshangxiang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/taishici/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__taishici" },
      skins = { "king_btl__taishici.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/wangji/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__wangji" },
      skins = { "king_btl__wangji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/wangping/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__wangping" },
      skins = { "king_btl__wangping.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/weiyan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__weiyan" },
      skins = { "king_btl__weiyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/wenyang/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__wenyang" },
      skins = { "king_btl__wenyang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/wolong/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__wolong" },
      skins = { "king_btl__wolong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/wuyi/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__wuyi" },
      skins = { "king_btl__wuyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/xiahoushi/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__xiahoushi" },
      skins = { "king_btl__xiahoushi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/xiahouyuan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__xiahouyuan" },
      skins = { "king_btl__xiahouyuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/xuhuang/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__xuhuang" },
      skins = { "king_btl__xuhuang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/xunyou/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__xunyou" },
      skins = { "king_btl__xunyou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/xunyu/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__xunyu" },
      skins = { "king_btl__xunyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/xusheng/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__xusheng" },
      skins = { "king_btl__xusheng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/xuyou/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__xuyou" },
      skins = { "king_btl__xuyou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/yanliangwenchou/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__yanliangwenchou" },
      skins = { "king_btl__yanliangwenchou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/yanrou/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__yanrou" },
      skins = { "king_btl__yanrou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/yujin/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__yujin" },
      skins = { "king_btl__yujin.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/zhangchunhua/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhangchunhua" },
      skins = { "king_btl__zhangchunhua.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/zhangliao/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhangliao" },
      skins = { "king_btl__zhangliao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/zhangxingcai/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__xingcai" },
      skins = { "king_btl__xingcai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/zhangyi/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhangyiy" },
      skins = { "king_btl__zhangyiy.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/zhaoyun/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhaoyun" },
      skins = { "king_btl__zhaoyun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/zhongyao/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhongyao" },
      skins = { "king_btl__zhongyao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/zhoufang/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhoufang" },
      skins = { "king_btl__zhoufang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/zhugejin/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhugejin" },
      skins = { "king_btl__zhugejin.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/zhugeke/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhugeke", "zhugeke" },
      skins = { "king_btl__zhugeke.jpg", "zhugeke.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/zhugeliang/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhugeliang" },
      skins = { "king_btl__zhugeliang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/zhugezhan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhugezhan" },
      skins = { "king_btl__zhugezhan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/zhuhuan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhuhuan" },
      skins = { "king_btl__zhuhuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/zhuran/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhuran" },
      skins = { "king_btl__zhuran.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/zhurong/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhurong" },
      skins = { "king_btl__zhurong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】(晋司马师x夏侯徽)①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__simashi" },
      skins = { "ol__simashi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】(杨艳x杨芷)①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "yangyan", "yangzhi" },
      skins = { "yangyan.jpg", "yangzhi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】(牛辅x董翓)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__dongxie", "ol__niufu" },
      skins = { "ol__dongxie.jpg", "ol__niufu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】(界周妃x芮姬)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__zhoufei", "ruiji" },
      skins = { "ol__zhoufei.jpg", "ruiji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】(界赵云x马云禄)②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "mayunlu", "ol_ex__zhaoyun" },
      skins = { "mayunlu.jpg", "ol_ex__zhaoyun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】(郭照x曹丕)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__guozhao" },
      skins = { "ol__guozhao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】(郭照x曹丕)/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "caopi" },
      skins = { "caopi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】SP张郃(旧音)①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_sp__zhanghe" },
      skins = { "ol_sp__zhanghe.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】SP曹仁①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_sp__caoren" },
      skins = { "ol_sp__caoren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】SP曹操至臻①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_sp__caocao" },
      skins = { "ol_sp__caocao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】SP贾诩①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_sp__jiaxu" },
      skins = { "ol_sp__jiaxu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】SP马超⑥/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_sp__machao" },
      skins = { "ol_sp__machao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】SP黄月英①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_sp__huangyueying" },
      skins = { "ol_sp__huangyueying.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】丁尚涴①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__dingfuren" },
      skins = { "ol__dingfuren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】何太后⑤/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__hetaihou" },
      skins = { "ol__hetaihou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】关索③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__guansuo" },
      skins = { "ol__guansuo.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】冯方女①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__fengfangnv" },
      skins = { "ol__fengfangnv.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】刘琦②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "liuqi" },
      skins = { "liuqi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】卑弥呼⑦/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "himiko" },
      skins = { "himiko.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】卞夫人②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__bianfuren" },
      skins = { "ol__bianfuren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】卢氏②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "lushi" },
      skins = { "lushi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】卧龙凤雏(方言)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "wolongfengchu" },
      skins = { "wolongfengchu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】卫兹①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "weizi" },
      skins = { "weizi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】卫瓘①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "weiguan" },
      skins = { "weiguan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】吕伯奢①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "lvboshe" },
      skins = { "lvboshe.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】吕玲绮①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__lvlingqi" },
      skins = { "ol__lvlingqi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】吴国太④/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__wuguotai" },
      skins = { "ol_ex__wuguotai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】夏侯玄①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "xiahouxuan" },
      skins = { "xiahouxuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】孔淑①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "kongshu" },
      skins = { "kongshu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】孙乾①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "sunqian" },
      skins = { "sunqian.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】孙亮①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__sunliang" },
      skins = { "ol__sunliang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】孙皓②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__sunhao" },
      skins = { "ol__sunhao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】孙茹①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__sunru" },
      skins = { "ol__sunru.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】孙鲁育①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__sunluyu" },
      skins = { "ol__sunluyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】嵇康②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__jikang" },
      skins = { "ol__jikang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】左棻③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "zuofen" },
      skins = { "zuofen.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】张昌蒲④/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__zhangchangpu" },
      skins = { "ol__zhangchangpu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】张星彩⑥/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__xingcai" },
      skins = { "ol__xingcai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】张春华①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__zhangchunhua" },
      skins = { "ol_ex__zhangchunhua.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】张琪瑛③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__zhangqiying" },
      skins = { "ol__zhangqiying.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】张芝①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "zhangzhi" },
      skins = { "zhangzhi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】张虎乐綝①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "zhanghuyuechen" },
      skins = { "zhanghuyuechen.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】张陵①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "zhangling" },
      skins = { "zhangling.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】张鲁①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "zhanglu" },
      skins = { "zhanglu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】戏志才③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "xizhicai" },
      skins = { "xizhicai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】族(王浑x钟琰)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "olz__wanghun", "olz__zhongyan" },
      skins = { "olz__wanghun.jpg", "olz__zhongyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】族吴苋(方言)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "olz__wuxian" },
      skins = { "olz__wuxian.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】族杨修①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "olz__yangxiu" },
      skins = { "olz__yangxiu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】族王凌①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "olz__wangling" },
      skins = { "olz__wangling.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】族荀淑(方言)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "olz__xunshu" },
      skins = { "olz__xunshu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】族钟会(方言)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "olz__zhonghui" },
      skins = { "olz__zhonghui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】晋(杜预x宣公主)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__duyu", "xuangongzhu" },
      skins = { "ol__duyu.jpg", "xuangongzhu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】晋周处①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__zhouchu" },
      skins = { "ol__zhouchu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】晋王元姬③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__wangyuanji" },
      skins = { "ol__wangyuanji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】晋羊徽瑜③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__yanghuiyu" },
      skins = { "ol__yanghuiyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】晋羊祜①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__yanghu" },
      skins = { "ol__yanghu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】曹婴⑤/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "caoying" },
      skins = { "caoying.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】曹宪曹华①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "caoxiancaohua" },
      skins = { "caoxiancaohua.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】曹纯⑤/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__caochun" },
      skins = { "ol__caochun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】曹金玉①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__caojinyu" },
      skins = { "ol__caojinyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】李典②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__lidian" },
      skins = { "ol_ex__lidian.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】李婉④/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__liwan" },
      skins = { "ol__liwan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】杨仪①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__yangyi" },
      skins = { "ol__yangyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】杨婉①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__yangwan" },
      skins = { "ol__yangwan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】步骘①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "buzhi" },
      skins = { "buzhi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】清河公主①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "qinghegongzhu" },
      skins = { "qinghegongzhu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】滕芳兰①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__tengfanglan" },
      skins = { "ol__tengfanglan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】牛金①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__niujin" },
      skins = { "ol__niujin.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】王朗③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__wanglang" },
      skins = { "ol__wanglang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】王荣③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "wangrongh" },
      skins = { "wangrongh.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界于吉④/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__yuji" },
      skins = { "ol_ex__yuji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界伏皇后⑦/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__fuhuanghou" },
      skins = { "ol_ex__fuhuanghou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界典韦④/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__dianwei" },
      skins = { "ol_ex__dianwei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界刘备⑨/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__liubei" },
      skins = { "ol_ex__liubei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界刘禅③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__liushan" },
      skins = { "ol_ex__liushan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界华雄③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__huaxiong" },
      skins = { "ol_ex__huaxiong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界卧龙诸葛亮⑫/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__wolong" },
      skins = { "ol_ex__wolong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界吕蒙②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__lvmeng" },
      skins = { "ol_ex__lvmeng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界周泰①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__zhoutai" },
      skins = { "ol__zhoutai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界夏侯渊⑦/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__xiahouyuan" },
      skins = { "ol_ex__xiahouyuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界太史慈①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__taishici" },
      skins = { "ol_ex__taishici.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界姜维③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__jiangwei" },
      skins = { "ol_ex__jiangwei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界孙策⑥/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__sunce" },
      skins = { "ol_ex__sunce.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界孙鲁班②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__sunluban" },
      skins = { "ol_ex__sunluban.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界小乔①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__xiaoqiao" },
      skins = { "ol_ex__xiaoqiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界左慈⑨/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__zuoci" },
      skins = { "ol_ex__zuoci.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界庞德①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__pangde" },
      skins = { "ol_ex__pangde.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界张角①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__zhangjiao" },
      skins = { "ol_ex__zhangjiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界徐晃④/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__xuhuang" },
      skins = { "ol_ex__xuhuang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界徐盛②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__xusheng" },
      skins = { "ol_ex__xusheng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界曹仁①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__caoren" },
      skins = { "ol__caoren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界曹冲⑥/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__caochong" },
      skins = { "ol_ex__caochong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界曹操⑤/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__caocao" },
      skins = { "ol_ex__caocao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界曹节①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__caojie" },
      skins = { "ol_ex__caojie.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界朱桓⑥/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__zhuhuan" },
      skins = { "ol_ex__zhuhuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界李儒①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__liru" },
      skins = { "ol_ex__liru.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界法正②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__fazheng" },
      skins = { "ol_ex__fazheng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界王异①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__wangyi" },
      skins = { "ol_ex__wangyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界祝融⑤/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__zhurong" },
      skins = { "ol_ex__zhurong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界荀彧⑦/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__xunyu" },
      skins = { "ol_ex__xunyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界董卓②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__dongzhuo" },
      skins = { "ol_ex__dongzhuo.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界蔡夫人③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__caifuren" },
      skins = { "ol_ex__caifuren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界蔡文姬②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__caiwenji" },
      skins = { "ol_ex__caiwenji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界袁绍③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__yuanshao" },
      skins = { "ol_ex__yuanshao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界贾诩②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__jiaxu" },
      skins = { "ol_ex__jiaxu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界辛宪英⑧/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__xinxianying" },
      skins = { "ol_ex__xinxianying.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界邓艾④/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__dengai" },
      skins = { "ol_ex__dengai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界郭皇后①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__guohuanghou" },
      skins = { "ol_ex__guohuanghou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界钟会①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__zhonghui" },
      skins = { "ol_ex__zhonghui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界高顺③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__gaoshun" },
      skins = { "ol_ex__gaoshun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界魏延①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__weiyan" },
      skins = { "ol_ex__weiyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界鲁肃①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__lusu" },
      skins = { "ol_ex__lusu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】界黄忠④/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__huangzhong" },
      skins = { "ol_ex__huangzhong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】石苞①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "shibao" },
      skins = { "shibao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】神曹操②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__godcaocao" },
      skins = { "ol__godcaocao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】程昱⑥/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "chengyu" },
      skins = { "chengyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】糜竺①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "mizhu" },
      skins = { "mizhu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】胡金定①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__hujinding" },
      skins = { "ol__hujinding.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】苏飞②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__sufei" },
      skins = { "ol__sufei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】荀谌①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__xunchen" },
      skins = { "ol__xunchen.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】董允③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "dongyun" },
      skins = { "dongyun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】董昭①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__dongzhao" },
      skins = { "ol__dongzhao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】董白①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "dongbai" },
      skins = { "dongbai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】蒋琬(方言)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__jiangwan" },
      skins = { "ol__jiangwan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】薛灵芸⑥/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__xuelingyun" },
      skins = { "ol__xuelingyun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】袁姬①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__yuanji" },
      skins = { "ol__yuanji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】许靖①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__xujing" },
      skins = { "ol__xujing.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】诸葛果③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__zhugeguo" },
      skins = { "ol__zhugeguo.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】诸葛瑾⑥/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__zhugejin" },
      skins = { "ol__zhugejin.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】诸葛诞④/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__zhugedan" },
      skins = { "ol__zhugedan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】谋姜维④/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "olmou__jiangwei" },
      skins = { "olmou__jiangwei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】谋庞统⑤/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "olmou__pangtong" },
      skins = { "olmou__pangtong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】费祎①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__feiyi" },
      skins = { "ol__feiyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】贾充②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__jiachong" },
      skins = { "ol__jiachong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】赵俨①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "zhaoyan" },
      skins = { "zhaoyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】蹋顿①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "tadun" },
      skins = { "tadun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】邓芝①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__dengzhi" },
      skins = { "ol__dengzhi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】郭槐①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "guohuaij" },
      skins = { "guohuaij.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】钟琰①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "zhongyan" },
      skins = { "zhongyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】陈登①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__chendeng" },
      skins = { "ol__chendeng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】魔司马懿①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_evil__simayi" },
      skins = { "ol_evil__simayi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】魔吕布①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_evil__lvbu" },
      skins = { "ol_evil__lvbu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】魔张飞①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_evil__zhangfei" },
      skins = { "ol_evil__zhangfei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】魔曹操①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_evil__caocao" },
      skins = { "ol_evil__caocao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】魔貂蝉②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_evil__diaochan" },
      skins = { "ol_evil__diaochan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】鲁芝③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "luzhiw" },
      skins = { "luzhiw.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】鲍三娘①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__baosanniang" },
      skins = { "ol__baosanniang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【OL】黄权①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__huangquan" },
      skins = { "ol__huangquan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【SP】刘协②/packages/sp/image/generals",
  content = {
    {
      enabled_generals = { "liuxie" },
      skins = { "liuxie.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【SP】曹昂②/packages/sp/image/generals",
  content = {
    {
      enabled_generals = { "caoang" },
      skins = { "caoang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【SP】曹洪⑤/packages/sp/image/generals",
  content = {
    {
      enabled_generals = { "caohong" },
      skins = { "caohong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【SP】杨修①/packages/sp/image/generals",
  content = {
    {
      enabled_generals = { "yangxiu" },
      skins = { "yangxiu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【SP】蔡文姬⑥/packages/sp/image/generals",
  content = {
    {
      enabled_generals = { "sp__caiwenji" },
      skins = { "sp__caiwenji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【SP】貂蝉④/packages/sp/image/generals",
  content = {
    {
      enabled_generals = { "starsp__diaochan" },
      skins = { "starsp__diaochan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【SP】赵云②/packages/sp/image/generals",
  content = {
    {
      enabled_generals = { "starsp__zhaoyun" },
      skins = { "starsp__zhaoyun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【SP】陈琳③/packages/sp/image/generals",
  content = {
    {
      enabled_generals = { "chenlin" },
      skins = { "chenlin.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【SP】魏姜维⑤/packages/sp/image/generals",
  content = {
    {
      enabled_generals = { "jsp__jiangwei" },
      skins = { "jsp__jiangwei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【一将成名】关平②/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "guanping" },
      skins = { "guanping.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【一将成名】刘谌①/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "liuchen" },
      skins = { "liuchen.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【一将成名】吴苋⑦/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "wuxian" },
      skins = { "wuxian.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【一将成名】孙登②/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "sundeng" },
      skins = { "sundeng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【一将成名】孙资刘放③/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "sunziliufang" },
      skins = { "sunziliufang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【一将成名】张让②/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "zhangrang" },
      skins = { "zhangrang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【一将成名】徐庶⑤/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "xushu" },
      skins = { "xushu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【一将成名】徐氏⑦/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "xushi" },
      skins = { "xushi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【一将成名】旧王异⑤/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "nos__wangyi" },
      skins = { "nos__wangyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【一将成名】曹冲⑥/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "caochong" },
      skins = { "caochong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【一将成名】曹叡④/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "caorui" },
      skins = { "caorui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【一将成名】朱治①/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "zhuzhi" },
      skins = { "zhuzhi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【一将成名】李严①/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "liyans" },
      skins = { "liyans.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【一将成名】步练师③/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "bulianshi" },
      skins = { "bulianshi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【一将成名】满宠①/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "manchong" },
      skins = { "manchong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【一将成名】王异⑤/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "wangyi" },
      skins = { "wangyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【一将成名】秦宓②/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "qinmi" },
      skins = { "qinmi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【一将成名】郭图逢纪②/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "guotupangji" },
      skins = { "guotupangji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【一将成名】钟繇①/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "zhongyao" },
      skins = { "zhongyao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【一将成名】鲁肃②/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "lusu" },
      skins = { "lusu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】(乐曹植x崔令仪)/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "cuilingyi", "mu__caozhi" },
      skins = { "cuilingyi.jpg", "mu__caozhi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】(关索x鲍三娘)②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__baosanniang", "ty__guansuo" },
      skins = { "ty__baosanniang.jpg", "ty__guansuo.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】(夏侯氏x张星彩)/packages/mini/image/generals",
  content = {
    {
      enabled_generals = { "mini__zhangxingcai" },
      skins = { "mini__zhangxingcai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】(夏侯氏x张星彩)/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__xiahoushi" },
      skins = { "ty_ex__xiahoushi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】(孙鲁班x孙鲁育)②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__sunluyu", "ty_ex__sunluban" },
      skins = { "ty__sunluyu.jpg", "ty_ex__sunluban.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】(曹髦x卞玥）/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "bianyue", "caomao" },
      skins = { "bianyue.jpg", "caomao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】(界曹叡x界郭皇后)/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__caorui", "ty_ex__guohuanghou" },
      skins = { "ty_ex__caorui.jpg", "ty_ex__guohuanghou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】(蒯祺x诸葛梦雪)/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "kuaiqi", "zhugemengxue" },
      skins = { "kuaiqi.jpg", "zhugemengxue.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】(诸葛梦雪x若雪)/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhugeruoxue" },
      skins = { "zhugeruoxue.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】(谋司马师x夏侯徽)/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__xiahouhui", "tymou__simashi" },
      skins = { "ty__xiahouhui.jpg", "tymou__simashi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】SP关羽①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_sp__guanyu" },
      skins = { "ty_sp__guanyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】SP庞统①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "sp__pangtong" },
      skins = { "sp__pangtong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】SP甄姬②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_sp__zhenji" },
      skins = { "ty_sp__zhenji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】SP赵云①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_sp__zhaoyun" },
      skins = { "ty_sp__zhaoyun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】SP黄月英④/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__huangyueying" },
      skins = { "ty_ex__huangyueying.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】丁原②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__dingyuan" },
      skins = { "ty__dingyuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】丁尚涴①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "dingfuren" },
      skins = { "dingfuren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】万年公主③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "wanniangongzhu" },
      skins = { "wanniangongzhu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】东海龙王①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "longwang" },
      skins = { "longwang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】严夫人①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "yanfuren" },
      skins = { "yanfuren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】严畯③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "yanjun" },
      skins = { "yanjun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】乐大乔③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "mu__daqiao" },
      skins = { "mu__daqiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】乐小乔③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "mu__xiaoqiao" },
      skins = { "mu__xiaoqiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】乐祢衡①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "mu__miheng" },
      skins = { "mu__miheng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】乐綝①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "yuechen" },
      skins = { "yuechen.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】乐蔡文姬①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "mu__caiwenji" },
      skins = { "mu__caiwenji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】乐诸葛果①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "mu__zhugeguo" },
      skins = { "mu__zhugeguo.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】乐貂蝉③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "mu__diaochan" },
      skins = { "mu__diaochan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】乐进③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__yuejin" },
      skins = { "ty__yuejin.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】乐邹氏①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "mu__zoushi" },
      skins = { "mu__zoushi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】任婉①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "renwan" },
      skins = { "renwan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】何晏②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "heyan" },
      skins = { "heyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】兀突骨①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__wutugu" },
      skins = { "ty__wutugu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】全惠解①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "quanhuijie" },
      skins = { "quanhuijie.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】公孙度①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "gongsundu" },
      skins = { "gongsundu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】关宁②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "guannings" },
      skins = { "guannings.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】冯妤①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__fengfangnv" },
      skins = { "ty__fengfangnv.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】刘宏①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__liuhong" },
      skins = { "ty__liuhong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】刘巴①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__liuba" },
      skins = { "ty__liuba.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】刘晔④/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__liuye" },
      skins = { "ty__liuye.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】刘永①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "liuyong" },
      skins = { "liuyong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】刘焉⑨/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "liuyan" },
      skins = { "liuyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】刘矜刘佩①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "liujinliupei" },
      skins = { "liujinliupei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】刘辩②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "liubian" },
      skins = { "liubian.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】南华老仙④/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__nanhualaoxian" },
      skins = { "ty__nanhualaoxian.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】卢弈①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "luyi" },
      skins = { "luyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】司马孚①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__simafu" },
      skins = { "ty__simafu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】司马徽⑤/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "simahui" },
      skins = { "simahui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】吕玲绮②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "lvlingqi" },
      skins = { "lvlingqi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】周善①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhoushan" },
      skins = { "zhoushan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】周宣③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhouxuan" },
      skins = { "zhouxuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】周鲂⑤/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhoufang" },
      skins = { "zhoufang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】唐咨①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__tangzi" },
      skins = { "ty__tangzi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】唐姬②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tangji" },
      skins = { "tangji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】夏侯令女①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "xiahoulingnv" },
      skins = { "xiahoulingnv.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】夏侯杰②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "xiahoujie" },
      skins = { "xiahoujie.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】大小乔⑥/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__daqiaoxiaoqiao" },
      skins = { "ty__daqiaoxiaoqiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】威关银屏(武)/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_wei__guanyinping" },
      skins = { "ty_wei__guanyinping.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】威刘备④/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_wei__liubei" },
      skins = { "ty_wei__liubei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】威孙尚香(武)/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_wei__sunshangxiang" },
      skins = { "ty_wei__sunshangxiang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】威张星彩(武)/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_wei__xingcai" },
      skins = { "ty_wei__xingcai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】威曹丕①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_wei__caopi" },
      skins = { "ty_wei__caopi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】威董卓①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_wei__dongzhuo" },
      skins = { "ty_wei__dongzhuo.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】孙礼①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "sunli" },
      skins = { "sunli.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】孙綝②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "sunchen" },
      skins = { "sunchen.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】孙翎鸾②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "sunlingluan" },
      skins = { "sunlingluan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】宣公主①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__xuangongzhu" },
      skins = { "ty__xuangongzhu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】庞德公①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__pangdegong" },
      skins = { "ty__pangdegong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】张媱②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhangyao" },
      skins = { "zhangyao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】张昌蒲③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__zhangchangpu" },
      skins = { "ty__zhangchangpu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】张琪瑛①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhangqiying" },
      skins = { "zhangqiying.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】张让①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__zhangrang" },
      skins = { "ty__zhangrang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】徐荣④/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "xurong" },
      skins = { "xurong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】文鸯③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "wenyang" },
      skins = { "wenyang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】星孙坚①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tystar__sunjian" },
      skins = { "tystar__sunjian.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】星孙尚香②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tystar__sunshangxiang" },
      skins = { "tystar__sunshangxiang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】星曹仁①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tystar__caoren" },
      skins = { "tystar__caoren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】星荀彧①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tystar__xunyu" },
      skins = { "tystar__xunyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】星董卓②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tystar__dongzhuo" },
      skins = { "tystar__dongzhuo.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】星袁绍①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tystar__yuanshao" },
      skins = { "tystar__yuanshao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】是仪①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "shiyi" },
      skins = { "shiyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】曹华②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "caohua" },
      skins = { "caohua.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】曹宪③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "caoxian" },
      skins = { "caoxian.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】曹性①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "caoxing" },
      skins = { "caoxing.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】曹纯①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__caochun" },
      skins = { "ty__caochun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】曹芳①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "caofang" },
      skins = { "caofang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】曹金玉②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "caojinyu" },
      skins = { "caojinyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】朱佩兰①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhupeilan" },
      skins = { "zhupeilan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】李傕①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "lijue" },
      skins = { "lijue.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】李典①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__lidian" },
      skins = { "ty__lidian.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】杜夔①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "dukui" },
      skins = { "dukui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】杜夫人④/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "dufuren" },
      skins = { "dufuren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】来莺儿①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "laiyinger" },
      skins = { "laiyinger.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】柏灵筠②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "bailingyun" },
      skins = { "bailingyun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】柳婒①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "liutan" },
      skins = { "liutan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】梁兴②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "liangxing" },
      skins = { "liangxing.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】樊玉凤①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "fanyufeng" },
      skins = { "fanyufeng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】段煨②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "duanwei" },
      skins = { "duanwei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】沙摩柯⑧/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "shamoke" },
      skins = { "shamoke.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】滕公主①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tenggongzhu" },
      skins = { "tenggongzhu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】潘淑①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__panshu" },
      skins = { "ty__panshu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】潘濬①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "panjun" },
      skins = { "panjun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】灵雎①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__lingju" },
      skins = { "ty__lingju.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】猪猪侠侠联动系列/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "xuyou" },
      skins = { "xuyou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】猪猪侠侠联动系列/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "chengui", "goddianwei", "godhuangzhong", "godpangtong", "godzhangfei", "ty__puyuan", "ty_ex__lingtong", "ty_wei__lvbu", "ty_wei__zhangliao", "tymou__dengai", "tymou__huanggai", "tymou__luotong" },
      skins = { "chengui.jpg", "goddianwei.jpg", "godhuangzhong.jpg", "godpangtong.jpg", "godzhangfei.jpg", "ty__puyuan.jpg", "ty_ex__lingtong.jpg", "ty_wei__lvbu.jpg", "ty_wei__zhangliao.jpg", "tymou__dengai.jpg", "tymou__huanggai.jpg", "tymou__luotong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】王双①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "wangshuang" },
      skins = { "wangshuang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】王悦①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "wangyues" },
      skins = { "wangyues.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】王昶①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__wangchang" },
      skins = { "ty__wangchang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】王桃②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "wangtao" },
      skins = { "wangtao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】王荣①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__wangrongh" },
      skins = { "ty__wangrongh.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】甘夫人⑥/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__ganfuren" },
      skins = { "ty__ganfuren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】甘糜夫人②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ganfurenmifuren" },
      skins = { "ganfurenmifuren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】田丰①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__tianfeng" },
      skins = { "ty__tianfeng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界SP太史慈②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__taishici" },
      skins = { "ty_ex__taishici.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界于禁⑥/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__yujin" },
      skins = { "ty_ex__yujin.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界伏皇后①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__fuhuanghou" },
      skins = { "ty_ex__fuhuanghou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界关平④/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__guanping" },
      skins = { "ty_ex__guanping.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界刘封⑥/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__liufeng" },
      skins = { "ty_ex__liufeng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界刘琦①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__liuqi" },
      skins = { "ty__liuqi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界刘表①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__liubiao" },
      skins = { "ty_ex__liubiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界刘谌②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__liuchen" },
      skins = { "ty_ex__liuchen.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界司马朗②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__simalang" },
      skins = { "ty_ex__simalang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界吴懿①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__wuyi" },
      skins = { "ty_ex__wuyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界夏侯霸③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__xiahouba" },
      skins = { "ty__xiahouba.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界孙休③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__sunxiu" },
      skins = { "ty_ex__sunxiu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界张嶷①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__zhangyi" },
      skins = { "ty_ex__zhangyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界张春华②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__zhangchunhua" },
      skins = { "ty_ex__zhangchunhua.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界张松⑥/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__zhangsong" },
      skins = { "ty_ex__zhangsong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界徐庶①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__xushu" },
      skins = { "ty_ex__xushu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界曹休①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__caoxiu" },
      skins = { "ty_ex__caoxiu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界曹真③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__caozhen" },
      skins = { "ty_ex__caozhen.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界朱治⑧/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__zhuzhi" },
      skins = { "ty_ex__zhuzhi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界朱然①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__zhuran" },
      skins = { "ty_ex__zhuran.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界李儒⑤/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__liru" },
      skins = { "ty_ex__liru.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界步练师②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__bulianshi" },
      skins = { "ty_ex__bulianshi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界沮授④/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__jvshou" },
      skins = { "ty_ex__jvshou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界王异①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__wangyi" },
      skins = { "ty_ex__wangyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界简雍①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__jianyong" },
      skins = { "ty_ex__jianyong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界荀攸①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__xunyou" },
      skins = { "ty_ex__xunyou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界诸葛诞④/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__zhugedan" },
      skins = { "ty_ex__zhugedan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界辛宪英①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__xinxianying" },
      skins = { "ty__xinxianying.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界钟会②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__zhonghui" },
      skins = { "ty_ex__zhonghui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界陈宫①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__chengong" },
      skins = { "ty_ex__chengong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界陈群④/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__chenqun" },
      skins = { "ty_ex__chenqun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】界高顺①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__gaoshun" },
      skins = { "ty_ex__gaoshun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】神关羽②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__godguanyu" },
      skins = { "ty__godguanyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】神刘备①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__godliubei" },
      skins = { "ty__godliubei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】神姜维①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "godjiangwei" },
      skins = { "godjiangwei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】神孙权②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__godsunquan" },
      skins = { "ty__godsunquan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】神张角①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "godzhangjiao" },
      skins = { "godzhangjiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】神邓艾①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "goddengai" },
      skins = { "goddengai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】神钟会①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "godzhonghui" },
      skins = { "godzhonghui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】神马超③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "godmachao" },
      skins = { "godmachao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】程昱①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__chengyu" },
      skins = { "ty__chengyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】笮融①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zerong" },
      skins = { "zerong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】管宁②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "guanning" },
      skins = { "guanning.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】羊祜①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__yanghu" },
      skins = { "ty__yanghu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】花鬘⑦/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__huaman" },
      skins = { "ty__huaman.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】苏飞②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__sufei" },
      skins = { "ty__sufei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】荀谌③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__xunchen" },
      skins = { "ty__xunchen.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】莫琼树②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "moqiongshu" },
      skins = { "moqiongshu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】葛玄①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "gexuan" },
      skins = { "gexuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】董承①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__dongcheng" },
      skins = { "ty__dongcheng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】董白①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__dongbai" },
      skins = { "ty__dongbai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】董贵人①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "dongguiren" },
      skins = { "dongguiren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】蒋干①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "jianggan" },
      skins = { "jianggan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】薛灵芸①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "xuelingyun" },
      skins = { "xuelingyun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】许贡①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__xugong" },
      skins = { "ty__xugong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】许邵③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__xushao" },
      skins = { "ty__xushao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】许靖③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__xujing" },
      skins = { "ty__xujing.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】诸葛京①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhugejing" },
      skins = { "zhugejing.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】诸葛尚①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhugeshang" },
      skins = { "zhugeshang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】诸葛果②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__zhugeguo" },
      skins = { "ty__zhugeguo.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】谋曹爽①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tymou__caoshuang" },
      skins = { "tymou__caoshuang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】谋诸葛瑾①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tymou__zhugejin" },
      skins = { "tymou__zhugejin.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】谋陈琳①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tymou__chenlin" },
      skins = { "tymou__chenlin.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】谯周①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__qiaozhou" },
      skins = { "ty__qiaozhou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】贾充①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__jiachong" },
      skins = { "ty__jiachong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】赵俨①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__zhaoyan" },
      skins = { "ty__zhaoyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】赵嫣①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhaoyanw" },
      skins = { "zhaoyanw.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】赵直①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhaozhi" },
      skins = { "zhaozhi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】赵襄①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__zhaoxiang" },
      skins = { "ty__zhaoxiang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】郑浑①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhenghun" },
      skins = { "zhenghun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】郭照①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "guozhao" },
      skins = { "guozhao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】钟繇①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__zhongyao" },
      skins = { "ty_ex__zhongyao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】阎柔②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "yanrou" },
      skins = { "yanrou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】陆郁生①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "luyusheng" },
      skins = { "luyusheng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】陈式①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "chenshi" },
      skins = { "chenshi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】陈琳①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__chenlin" },
      skins = { "ty__chenlin.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】韩馥②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "hanfu" },
      skins = { "hanfu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】马伶俐①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "malingli" },
      skins = { "malingli.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】麴义①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__quyi" },
      skins = { "ty__quyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】黄承彦①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__huangchengyan" },
      skins = { "ty__huangchengyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【十周年】黄舞蝶①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "huangwudie" },
      skins = { "huangwudie.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【小程序】SP蔡文姬①/packages/mini/image/generals",
  content = {
    {
      enabled_generals = { "mini_sp__caiwenji" },
      skins = { "mini_sp__caiwenji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【小程序】极(大乔x小乔)①/packages/mini/image/generals",
  content = {
    {
      enabled_generals = { "miniex__daqiao", "miniex__xiaoqiao" },
      skins = { "miniex__daqiao.jpg", "miniex__xiaoqiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【小程序】极郭嘉①/packages/mini/image/generals",
  content = {
    {
      enabled_generals = { "miniex__guojia" },
      skins = { "miniex__guojia.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【小程序】魏SP姜维⑤/packages/mini/image/generals",
  content = {
    {
      enabled_generals = { "mini_sp__jiangwei" },
      skins = { "mini_sp__jiangwei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】SP司马昭②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_sp__simazhao" },
      skins = { "m_sp__simazhao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】兀突骨①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__wutugu" },
      skins = { "mobile__wutugu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】关银屏②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__guanyinping" },
      skins = { "mobile__guanyinping.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】刘璋①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "liuzhang" },
      skins = { "liuzhang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】势程普②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_shi__chengpu" },
      skins = { "m_shi__chengpu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】势魏延③/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_shi2__weiyan", "m_shi3__weiyan", "m_shi__weiyan" },
      skins = { "m_shi2__weiyan.jpg", "m_shi3__weiyan.jpg", "m_shi__weiyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】嵇康②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__jikang" },
      skins = { "mobile__jikang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】庞羲①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "pangxi" },
      skins = { "pangxi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】张琪瑛③/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__zhangqiying" },
      skins = { "mobile__zhangqiying.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】张翼①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "zhiyi" },
      skins = { "zhiyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】徐荣②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__xurong" },
      skins = { "mobile__xurong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】文鸯(吴)②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__wenyang" },
      skins = { "mobile__wenyang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】星徐晃②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mxing__xuhuang" },
      skins = { "mxing__xuhuang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】星甘宁①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mxing__ganning" },
      skins = { "mxing__ganning.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】星黄忠③/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mxing__huangzhong" },
      skins = { "mxing__huangzhong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】曹婴⑤/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__caoying" },
      skins = { "mobile__caoying.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】曹纯⑤/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "caochun" },
      skins = { "caochun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】李丰①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "lifeng" },
      skins = { "lifeng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】杜预④/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__duyu" },
      skins = { "mobile__duyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】杨彪③/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "yangbiao" },
      skins = { "yangbiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】桥公②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "qiaogong" },
      skins = { "qiaogong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】清河公主①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__qinghegongzhu" },
      skins = { "mobile__qinghegongzhu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】灵雎②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__lingju" },
      skins = { "mobile__lingju.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】王元姬⑤/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__wangyuanji" },
      skins = { "mobile__wangyuanji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】界吴懿②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__wuyi" },
      skins = { "m_ex__wuyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】界周妃④/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__zhoufei" },
      skins = { "m_ex__zhoufei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】界小乔③/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__xiaoqiao" },
      skins = { "m_ex__xiaoqiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】界廖化③/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__liaohua" },
      skins = { "m_ex__liaohua.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】界徐盛④/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__xusheng" },
      skins = { "m_ex__xusheng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】界曹植①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__caozhi" },
      skins = { "m_ex__caozhi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】界朱然⑦/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__zhuran" },
      skins = { "m_ex__zhuran.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】界李儒②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__liru" },
      skins = { "m_ex__liru.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】界步练师⑤/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__bulianshi" },
      skins = { "m_ex__bulianshi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】界蔡文姬②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__caiwenji" },
      skins = { "m_ex__caiwenji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】界郭皇后②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__guohuanghou" },
      skins = { "m_ex__guohuanghou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】界钟会⑤/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__zhonghui" },
      skins = { "m_ex__zhonghui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】神吕布⑤/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__godlvbu" },
      skins = { "mobile__godlvbu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】神荀彧①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "godxunyu" },
      skins = { "godxunyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】神郭嘉①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "godguojia" },
      skins = { "godguojia.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】神鲁肃①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "godlusu" },
      skins = { "godlusu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】祢衡①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "miheng" },
      skins = { "miheng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】羊徽瑜①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__yanghuiyu" },
      skins = { "mobile__yanghuiyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】胡金定③/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "hujinding" },
      skins = { "hujinding.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】郭女王①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__guozhao" },
      skins = { "mobile__guozhao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】陶谦②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "taoqian" },
      skins = { "taoqian.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】马云騄⑥/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__mayunlu" },
      skins = { "mobile__mayunlu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】马钧②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "majun" },
      skins = { "majun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【手杀】骆统②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "luotong" },
      skins = { "luotong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【江山如故】合诸葛亮①/packages/jsrg/image/generals",
  content = {
    {
      enabled_generals = { "js__zhugeliang" },
      skins = { "js__zhugeliang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【界限突破】伊籍③/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "yijik" },
      skins = { "yijik.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【界限突破】界关羽⑫/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__guanyu" },
      skins = { "ex__guanyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【界限突破】界司马懿④/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__simayi" },
      skins = { "ex__simayi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【界限突破】界吕布④/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__lvbu" },
      skins = { "ex__lvbu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【界限突破】界周瑜②/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__zhouyu" },
      skins = { "ex__zhouyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【界限突破】界夏侯惇⑪/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__xiahoudun" },
      skins = { "ex__xiahoudun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【界限突破】界大乔㉓/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__daqiao" },
      skins = { "ex__daqiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【界限突破】界孙尚香⑰/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__sunshangxiang" },
      skins = { "ex__sunshangxiang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【界限突破】界张辽④/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__zhangliao" },
      skins = { "ex__zhangliao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【界限突破】界甄姬①/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__zhenji" },
      skins = { "ex__zhenji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【界限突破】界甘宁②/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__ganning" },
      skins = { "ex__ganning.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【界限突破】界诸葛亮③/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__zhugeliang" },
      skins = { "ex__zhugeliang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【界限突破】界貂蝉⑰/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__diaochan" },
      skins = { "ex__diaochan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【界限突破】界郭嘉③/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__guojia" },
      skins = { "ex__guojia.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【界限突破】界陆逊①/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__luxun" },
      skins = { "ex__luxun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【界限突破】界黄月英③/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__huangyueying" },
      skins = { "ex__huangyueying.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【界限突破】界黄盖①/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__huanggai" },
      skins = { "ex__huanggai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【神话再临】周妃⑥/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "zhoufei" },
      skins = { "zhoufei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【神话再临】孙亮②/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "sunliang" },
      skins = { "sunliang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【神话再临】张绣⑪/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "zhangxiu" },
      skins = { "zhangxiu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【神话再临】王基④/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "wangji" },
      skins = { "wangji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【神话再临】王平⑩/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "wangping" },
      skins = { "wangping.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【神话再临】神吕布⑥/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "godlvbu" },
      skins = { "godlvbu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【神话再临】神周瑜①/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "godzhouyu" },
      skins = { "godzhouyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【神话再临】神甘宁⑤/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "godganning" },
      skins = { "godganning.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【神话再临】神诸葛③/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "godzhugeliang" },
      skins = { "godzhugeliang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【神话再临】神赵云②/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "godzhaoyun" },
      skins = { "godzhaoyun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【神话再临】神陆逊②/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "godluxun" },
      skins = { "godluxun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【神话再临】荀彧④/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "xunyu" },
      skins = { "xunyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【神话再临】诸葛瞻⑩/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "zhugezhan" },
      skins = { "zhugezhan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【神话再临】郝昭①/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "haozhao" },
      skins = { "haozhao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【神话再临】陆抗③/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "lukang" },
      skins = { "lukang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【神话再临】陆绩①/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "luji" },
      skins = { "luji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【神话再临】陈到①/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "chendao" },
      skins = { "chendao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【线下】势小乔⑧(E)/packages/offline_new/image/generals",
  content = {
    {
      enabled_generals = { "ofl__xiaoqiao" },
      skins = { "ofl__xiaoqiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【线下】神黄月英①/packages/offline_new/image/generals",
  content = {
    {
      enabled_generals = { "godhuangyueying" },
      skins = { "godhuangyueying.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【谋攻】谋刘备②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mou__liubei" },
      skins = { "mou__liubei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【谋攻】谋刘赪①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mou__liucheng" },
      skins = { "mou__liucheng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【谋攻】谋张辽①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mou__zhangliao" },
      skins = { "mou__zhangliao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【谋攻】谋曹丕①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mou__caopi" },
      skins = { "mou__caopi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【谋攻】谋荀彧⑦/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mou__xunyu" },
      skins = { "mou__xunyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【谋攻】谋贾诩④/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mou__jiaxu" },
      skins = { "mou__jiaxu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/精选/【谋攻】谋郭嘉④/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mou__guojia" },
      skins = { "mou__guojia.jpg" },
    },
  },
}

Fk:loadTranslationTable {
  ["advanced_art_skins"] = "精选原画",
  ["bailingyun.jpg"] = "【十周年】柏灵筠②",
  ["bianyue.jpg"] = "【十周年】(曹髦x卞玥）",
  ["btl__caohua.jpg"] = "caohua",
  ["bulianshi.jpg"] = "【一将成名】步练师③",
  ["buzhi.jpg"] = "【OL】步骘①",
  ["caoang.jpg"] = "【SP】曹昂②",
  ["caochong.jpg"] = "【一将成名】曹冲⑥",
  ["caochun.jpg"] = "【手杀】曹纯⑤",
  ["caofang.jpg"] = "【十周年】曹芳①",
  ["caohong.jpg"] = "【SP】曹洪⑤",
  ["caohua.jpg"] = "【十周年】曹华②",
  ["caojinyu.jpg"] = "【十周年】曹金玉②",
  ["caomao.jpg"] = "【十周年】(曹髦x卞玥）",
  ["caopi.jpg"] = "【OL】(郭照x曹丕)",
  ["caorui.jpg"] = "【一将成名】曹叡④",
  ["caoxian.jpg"] = "【十周年】曹宪③",
  ["caoxiancaohua.jpg"] = "【OL】曹宪曹华①",
  ["caoxing.jpg"] = "【十周年】曹性①",
  ["caoying.jpg"] = "【OL】曹婴⑤",
  ["chendao.jpg"] = "【神话再临】陈到①",
  ["chengui.jpg"] = "【十周年】猪猪侠侠联动系列",
  ["chengyu.jpg"] = "【OL】程昱⑥",
  ["chenlin.jpg"] = "【SP】陈琳③",
  ["chenshi.jpg"] = "【十周年】陈式①",
  ["cuilingyi.jpg"] = "【十周年】(乐曹植x崔令仪)",
  ["dingfuren.jpg"] = "【十周年】丁尚涴①",
  ["dongbai.jpg"] = "【OL】董白①",
  ["dongguiren.jpg"] = "【十周年】董贵人①",
  ["dongyun.jpg"] = "【OL】董允③",
  ["duanwei.jpg"] = "【十周年】段煨②",
  ["dufuren.jpg"] = "【十周年】杜夫人④",
  ["dukui.jpg"] = "【十周年】杜夔①",
  ["ex__daqiao.jpg"] = "【界限突破】界大乔㉓",
  ["ex__diaochan.jpg"] = "【界限突破】界貂蝉⑰",
  ["ex__ganning.jpg"] = "【界限突破】界甘宁②",
  ["ex__guanyu.jpg"] = "【界限突破】界关羽⑫",
  ["ex__guojia.jpg"] = "【界限突破】界郭嘉③",
  ["ex__huanggai.jpg"] = "【界限突破】界黄盖①",
  ["ex__huangyueying.jpg"] = "【界限突破】界黄月英③",
  ["ex__luxun.jpg"] = "【界限突破】界陆逊①",
  ["ex__lvbu.jpg"] = "【界限突破】界吕布④",
  ["ex__simayi.jpg"] = "【界限突破】界司马懿④",
  ["ex__sunshangxiang.jpg"] = "【界限突破】界孙尚香⑰",
  ["ex__xiahoudun.jpg"] = "【界限突破】界夏侯惇⑪",
  ["ex__zhangliao.jpg"] = "【界限突破】界张辽④",
  ["ex__zhenji.jpg"] = "【界限突破】界甄姬①",
  ["ex__zhouyu.jpg"] = "【界限突破】界周瑜②",
  ["ex__zhugeliang.jpg"] = "【界限突破】界诸葛亮③",
  ["fanyufeng.jpg"] = "【十周年】樊玉凤①",
  ["ganfurenmifuren.jpg"] = "【十周年】甘糜夫人②",
  ["gexuan.jpg"] = "【十周年】葛玄①",
  ["goddengai.jpg"] = "【十周年】神邓艾①",
  ["goddianwei.jpg"] = "【十周年】猪猪侠侠联动系列",
  ["godganning.jpg"] = "【神话再临】神甘宁⑤",
  ["godguojia.jpg"] = "【手杀】神郭嘉①",
  ["godhuangyueying.jpg"] = "【线下】神黄月英①",
  ["godhuangzhong.jpg"] = "【十周年】猪猪侠侠联动系列",
  ["godjiangwei.jpg"] = "【十周年】神姜维①",
  ["godlusu.jpg"] = "【手杀】神鲁肃①",
  ["godluxun.jpg"] = "【神话再临】神陆逊②",
  ["godlvbu.jpg"] = "【神话再临】神吕布⑥",
  ["godmachao.jpg"] = "【十周年】神马超③",
  ["godpangtong.jpg"] = "【十周年】猪猪侠侠联动系列",
  ["godxunyu.jpg"] = "【手杀】神荀彧①",
  ["godzhangfei.jpg"] = "【十周年】猪猪侠侠联动系列",
  ["godzhangjiao.jpg"] = "【十周年】神张角①",
  ["godzhaoyun.jpg"] = "【神话再临】神赵云②",
  ["godzhonghui.jpg"] = "【十周年】神钟会①",
  ["godzhouyu.jpg"] = "【神话再临】神周瑜①",
  ["godzhugeliang.jpg"] = "【神话再临】神诸葛③",
  ["gongsundu.jpg"] = "【十周年】公孙度①",
  ["guanning.jpg"] = "【十周年】管宁②",
  ["guannings.jpg"] = "【十周年】关宁②",
  ["guanping.jpg"] = "【一将成名】关平②",
  ["guohuaij.jpg"] = "【OL】郭槐①",
  ["guotupangji.jpg"] = "【一将成名】郭图逢纪②",
  ["guozhao.jpg"] = "【十周年】郭照①",
  ["hanfu.jpg"] = "【十周年】韩馥②",
  ["haozhao.jpg"] = "【神话再临】郝昭①",
  ["heyan.jpg"] = "【十周年】何晏②",
  ["himiko.jpg"] = "【OL】卑弥呼⑦",
  ["huangwudie.jpg"] = "【十周年】黄舞蝶①",
  ["hujinding.jpg"] = "【手杀】胡金定③",
  ["jianggan.jpg"] = "【十周年】蒋干①",
  ["js__zhugeliang.jpg"] = "【江山如故】合诸葛亮①",
  ["jsp__jiangwei.jpg"] = "【SP】魏姜维⑤",
  ["kbtl_sp__machao.jpg"] = "sp_machao",
  ["kbtl_sp__pangtong.jpg"] = "sp_pangtong",
  ["king_btl__bulianshi.jpg"] = "bulianshi",
  ["king_btl__buzhi.jpg"] = "buzhi",
  ["king_btl__caifuren.jpg"] = "caifuren",
  ["king_btl__caoang.jpg"] = "caoang",
  ["king_btl__caocao.jpg"] = "caocao",
  ["king_btl__caoren.jpg"] = "caoren",
  ["king_btl__caorui.jpg"] = "caorui",
  ["king_btl__chengong.jpg"] = "chengong",
  ["king_btl__chenqun.jpg"] = "chenqun",
  ["king_btl__cuiyan.jpg"] = "cuiyan",
  ["king_btl__daqiao.jpg"] = "daqiao",
  ["king_btl__dengai.jpg"] = "dengai",
  ["king_btl__dianwei.jpg"] = "dianwei",
  ["king_btl__diaochan.jpg"] = "diaochan",
  ["king_btl__dingyuan.jpg"] = "dingyuan",
  ["king_btl__fazheng.jpg"] = "fazheng",
  ["king_btl__gaoshun.jpg"] = "gaoshun",
  ["king_btl__gongsunyuan.jpg"] = "gongsunyuan",
  ["king_btl__guanxingzhangbao.jpg"] = "guanxingzhangbao",
  ["king_btl__guanyinping.jpg"] = "guanyinping",
  ["king_btl__guanyu.jpg"] = "guanyu",
  ["king_btl__guojia.jpg"] = "guojia",
  ["king_btl__guotupangji.jpg"] = "guotupangji",
  ["king_btl__haozhao.jpg"] = "haozhao",
  ["king_btl__huanggai.jpg"] = "huanggai",
  ["king_btl__huangquan.jpg"] = "huangquan",
  ["king_btl__huaxiong.jpg"] = "huaxiong",
  ["king_btl__jianggan.jpg"] = "jianggan",
  ["king_btl__jiangwei.jpg"] = "jiangwei",
  ["king_btl__jiaxu.jpg"] = "jiaxu",
  ["king_btl__jvshou.jpg"] = "jushou",
  ["king_btl__lidian.jpg"] = "lidian",
  ["king_btl__lingtong.jpg"] = "lingtong",
  ["king_btl__liushan.jpg"] = "liushan",
  ["king_btl__liuxie.jpg"] = "liuxie",
  ["king_btl__lusu.jpg"] = "lusu",
  ["king_btl__luxun.jpg"] = "luxun",
  ["king_btl__luzhiw.jpg"] = "luzhi",
  ["king_btl__machao.jpg"] = "machao",
  ["king_btl__mateng.jpg"] = "mateng",
  ["king_btl__mizhu.jpg"] = "mizhu",
  ["king_btl__panfeng.jpg"] = "panfeng",
  ["king_btl__qinmi.jpg"] = "qinmi",
  ["king_btl__quyi.jpg"] = "quyi",
  ["king_btl__shamoke.jpg"] = "shamoke",
  ["king_btl__simayi.jpg"] = "simayi",
  ["king_btl__sundeng.jpg"] = "sundeng",
  ["king_btl__sunhao.jpg"] = "sunhao",
  ["king_btl__sunquan.jpg"] = "sunquan",
  ["king_btl__sunshangxiang.jpg"] = "sunshangxiang",
  ["king_btl__taishici.jpg"] = "taishici",
  ["king_btl__wangji.jpg"] = "wangji",
  ["king_btl__wangping.jpg"] = "wangping",
  ["king_btl__weiyan.jpg"] = "weiyan",
  ["king_btl__wenyang.jpg"] = "wenyang",
  ["king_btl__wolong.jpg"] = "wolong",
  ["king_btl__wuyi.jpg"] = "wuyi",
  ["king_btl__xiahoushi.jpg"] = "xiahoushi",
  ["king_btl__xiahouyuan.jpg"] = "xiahouyuan",
  ["king_btl__xingcai.jpg"] = "zhangxingcai",
  ["king_btl__xuhuang.jpg"] = "xuhuang",
  ["king_btl__xunyou.jpg"] = "xunyou",
  ["king_btl__xunyu.jpg"] = "xunyu",
  ["king_btl__xusheng.jpg"] = "xusheng",
  ["king_btl__xuyou.jpg"] = "xuyou",
  ["king_btl__yanliangwenchou.jpg"] = "yanliangwenchou",
  ["king_btl__yanrou.jpg"] = "yanrou",
  ["king_btl__yujin.jpg"] = "yujin",
  ["king_btl__zhangchunhua.jpg"] = "zhangchunhua",
  ["king_btl__zhangliao.jpg"] = "zhangliao",
  ["king_btl__zhangyiy.jpg"] = "zhangyi",
  ["king_btl__zhaoyun.jpg"] = "zhaoyun",
  ["king_btl__zhongyao.jpg"] = "zhongyao",
  ["king_btl__zhoufang.jpg"] = "zhoufang",
  ["king_btl__zhugejin.jpg"] = "zhugejin",
  ["king_btl__zhugeke.jpg"] = "zhugeke",
  ["king_btl__zhugeliang.jpg"] = "zhugeliang",
  ["king_btl__zhugezhan.jpg"] = "zhugezhan",
  ["king_btl__zhuhuan.jpg"] = "zhuhuan",
  ["king_btl__zhuran.jpg"] = "zhuran",
  ["king_btl__zhurong.jpg"] = "zhurong",
  ["kongshu.jpg"] = "【OL】孔淑①",
  ["kuaiqi.jpg"] = "【十周年】(蒯祺x诸葛梦雪)",
  ["laiyinger.jpg"] = "【十周年】来莺儿①",
  ["liangxing.jpg"] = "【十周年】梁兴②",
  ["lifeng.jpg"] = "【手杀】李丰①",
  ["lijue.jpg"] = "【十周年】李傕①",
  ["liubian.jpg"] = "【十周年】刘辩②",
  ["liuchen.jpg"] = "【一将成名】刘谌①",
  ["liujinliupei.jpg"] = "【十周年】刘矜刘佩①",
  ["liuqi.jpg"] = "【OL】刘琦②",
  ["liutan.jpg"] = "【十周年】柳婒①",
  ["liuxie.jpg"] = "【SP】刘协②",
  ["liuyan.jpg"] = "【十周年】刘焉⑨",
  ["liuyong.jpg"] = "【十周年】刘永①",
  ["liuzhang.jpg"] = "【手杀】刘璋①",
  ["liyans.jpg"] = "【一将成名】李严①",
  ["longwang.jpg"] = "【十周年】东海龙王①",
  ["luji.jpg"] = "【神话再临】陆绩①",
  ["lukang.jpg"] = "【神话再临】陆抗③",
  ["luotong.jpg"] = "【手杀】骆统②",
  ["lushi.jpg"] = "【OL】卢氏②",
  ["lusu.jpg"] = "【一将成名】鲁肃②",
  ["luyi.jpg"] = "【十周年】卢弈①",
  ["luyusheng.jpg"] = "【十周年】陆郁生①",
  ["luzhiw.jpg"] = "【OL】鲁芝③",
  ["lvboshe.jpg"] = "【OL】吕伯奢①",
  ["lvlingqi.jpg"] = "【十周年】吕玲绮②",
  ["m_ex__bulianshi.jpg"] = "【手杀】界步练师⑤",
  ["m_ex__caiwenji.jpg"] = "【手杀】界蔡文姬②",
  ["m_ex__caozhi.jpg"] = "【手杀】界曹植①",
  ["m_ex__guohuanghou.jpg"] = "【手杀】界郭皇后②",
  ["m_ex__liaohua.jpg"] = "【手杀】界廖化③",
  ["m_ex__liru.jpg"] = "【手杀】界李儒②",
  ["m_ex__wuyi.jpg"] = "【手杀】界吴懿②",
  ["m_ex__xiaoqiao.jpg"] = "【手杀】界小乔③",
  ["m_ex__xusheng.jpg"] = "【手杀】界徐盛④",
  ["m_ex__zhonghui.jpg"] = "【手杀】界钟会⑤",
  ["m_ex__zhoufei.jpg"] = "【手杀】界周妃④",
  ["m_ex__zhuran.jpg"] = "【手杀】界朱然⑦",
  ["m_shi2__weiyan.jpg"] = "【手杀】势魏延③",
  ["m_shi3__weiyan.jpg"] = "【手杀】势魏延③",
  ["m_shi__chengpu.jpg"] = "【手杀】势程普②",
  ["m_shi__weiyan.jpg"] = "【手杀】势魏延③",
  ["m_sp__simazhao.jpg"] = "【手杀】SP司马昭②",
  ["majun.jpg"] = "【手杀】马钧②",
  ["malingli.jpg"] = "【十周年】马伶俐①",
  ["manchong.jpg"] = "【一将成名】满宠①",
  ["mayunlu.jpg"] = "【OL】(界赵云x马云禄)②",
  ["miheng.jpg"] = "【手杀】祢衡①",
  ["mini__zhangxingcai.jpg"] = "【十周年】(夏侯氏x张星彩)",
  ["mini_sp__caiwenji.jpg"] = "【小程序】SP蔡文姬①",
  ["mini_sp__jiangwei.jpg"] = "【小程序】魏SP姜维⑤",
  ["miniex__daqiao.jpg"] = "【小程序】极(大乔x小乔)①",
  ["miniex__guojia.jpg"] = "【小程序】极郭嘉①",
  ["miniex__xiaoqiao.jpg"] = "【小程序】极(大乔x小乔)①",
  ["mizhu.jpg"] = "【OL】糜竺①",
  ["mobile__caomao.jpg"] = "1【手杀】曹髦②",
  ["mobile__caoying.jpg"] = "【手杀】曹婴⑤",
  ["mobile__duyu.jpg"] = "【手杀】杜预④",
  ["mobile__godlvbu.jpg"] = "【手杀】神吕布⑤",
  ["mobile__guanyinping.jpg"] = "【手杀】关银屏②",
  ["mobile__guozhao.jpg"] = "【手杀】郭女王①",
  ["mobile__jikang.jpg"] = "【手杀】嵇康②",
  ["mobile__lingju.jpg"] = "【手杀】灵雎②",
  ["mobile__mayunlu.jpg"] = "【手杀】马云騄⑥",
  ["mobile__qinghegongzhu.jpg"] = "【手杀】清河公主①",
  ["mobile__wangyuanji.jpg"] = "【手杀】王元姬⑤",
  ["mobile__wenyang.jpg"] = "【手杀】文鸯(吴)②",
  ["mobile__wutugu.jpg"] = "【手杀】兀突骨①",
  ["mobile__xurong.jpg"] = "【手杀】徐荣②",
  ["mobile__yanghuiyu.jpg"] = "【手杀】羊徽瑜①",
  ["mobile__zhangqiying.jpg"] = "【手杀】张琪瑛③",
  ["moqiongshu.jpg"] = "【十周年】莫琼树②",
  ["mou__caopi.jpg"] = "【谋攻】谋曹丕①",
  ["mou__guojia.jpg"] = "【谋攻】谋郭嘉④",
  ["mou__jiaxu.jpg"] = "【谋攻】谋贾诩④",
  ["mou__liubei.jpg"] = "【谋攻】谋刘备②",
  ["mou__liucheng.jpg"] = "【谋攻】谋刘赪①",
  ["mou__xunyu.jpg"] = "【谋攻】谋荀彧⑦",
  ["mou__zhangliao.jpg"] = "【谋攻】谋张辽①",
  ["mu__caiwenji.jpg"] = "【十周年】乐蔡文姬①",
  ["mu__caozhi.jpg"] = "【十周年】(乐曹植x崔令仪)",
  ["mu__daqiao.jpg"] = "【十周年】乐大乔③",
  ["mu__diaochan.jpg"] = "【十周年】乐貂蝉③",
  ["mu__miheng.jpg"] = "【十周年】乐祢衡①",
  ["mu__xiaoqiao.jpg"] = "【十周年】乐小乔③",
  ["mu__zhugeguo.jpg"] = "【十周年】乐诸葛果①",
  ["mu__zoushi.jpg"] = "【十周年】乐邹氏①",
  ["mxing__ganning.jpg"] = "【手杀】星甘宁①",
  ["mxing__huangzhong.jpg"] = "【手杀】星黄忠③",
  ["mxing__xuhuang.jpg"] = "【手杀】星徐晃②",
  ["nos__wangyi.jpg"] = "【一将成名】旧王异⑤",
  ["ofl__xiaoqiao.jpg"] = "【线下】势小乔⑧(E)",
  ["ol__baosanniang.jpg"] = "【OL】鲍三娘①",
  ["ol__bianfuren.jpg"] = "【OL】卞夫人②",
  ["ol__caochun.jpg"] = "【OL】曹纯⑤",
  ["ol__caojinyu.jpg"] = "【OL】曹金玉①",
  ["ol__caoren.jpg"] = "【OL】界曹仁①",
  ["ol__chendeng.jpg"] = "【OL】陈登①",
  ["ol__dengzhi.jpg"] = "【OL】邓芝①",
  ["ol__dingfuren.jpg"] = "【OL】丁尚涴①",
  ["ol__dongxie.jpg"] = "【OL】(牛辅x董翓)",
  ["ol__dongzhao.jpg"] = "【OL】董昭①",
  ["ol__duyu.jpg"] = "【OL】晋(杜预x宣公主)",
  ["ol__feiyi.jpg"] = "【OL】费祎①",
  ["ol__fengfangnv.jpg"] = "【OL】冯方女①",
  ["ol__godcaocao.jpg"] = "【OL】神曹操②",
  ["ol__guansuo.jpg"] = "【OL】关索③",
  ["ol__guozhao.jpg"] = "【OL】(郭照x曹丕)",
  ["ol__hetaihou.jpg"] = "【OL】何太后⑤",
  ["ol__huangquan.jpg"] = "【OL】黄权①",
  ["ol__hujinding.jpg"] = "【OL】胡金定①",
  ["ol__jiachong.jpg"] = "【OL】贾充②",
  ["ol__jiangwan.jpg"] = "【OL】蒋琬(方言)",
  ["ol__jikang.jpg"] = "【OL】嵇康②",
  ["ol__liwan.jpg"] = "【OL】李婉④",
  ["ol__lvlingqi.jpg"] = "【OL】吕玲绮①",
  ["ol__niufu.jpg"] = "【OL】(牛辅x董翓)",
  ["ol__niujin.jpg"] = "【OL】牛金①",
  ["ol__simashi.jpg"] = "【OL】(晋司马师x夏侯徽)①",
  ["ol__sufei.jpg"] = "【OL】苏飞②",
  ["ol__sunhao.jpg"] = "【OL】孙皓②",
  ["ol__sunliang.jpg"] = "【OL】孙亮①",
  ["ol__sunluyu.jpg"] = "【OL】孙鲁育①",
  ["ol__sunru.jpg"] = "【OL】孙茹①",
  ["ol__tengfanglan.jpg"] = "【OL】滕芳兰①",
  ["ol__wanglang.jpg"] = "【OL】王朗③",
  ["ol__wangyuanji.jpg"] = "【OL】晋王元姬③",
  ["ol__xingcai.jpg"] = "【OL】张星彩⑥",
  ["ol__xuelingyun.jpg"] = "【OL】薛灵芸⑥",
  ["ol__xujing.jpg"] = "【OL】许靖①",
  ["ol__xunchen.jpg"] = "【OL】荀谌①",
  ["ol__yanghu.jpg"] = "【OL】晋羊祜①",
  ["ol__yanghuiyu.jpg"] = "【OL】晋羊徽瑜③",
  ["ol__yangwan.jpg"] = "【OL】杨婉①",
  ["ol__yangyi.jpg"] = "【OL】杨仪①",
  ["ol__yuanji.jpg"] = "【OL】袁姬①",
  ["ol__zhangchangpu.jpg"] = "【OL】张昌蒲④",
  ["ol__zhangqiying.jpg"] = "【OL】张琪瑛③",
  ["ol__zhouchu.jpg"] = "【OL】晋周处①",
  ["ol__zhoufei.jpg"] = "【OL】(界周妃x芮姬)",
  ["ol__zhoutai.jpg"] = "【OL】界周泰①",
  ["ol__zhugedan.jpg"] = "【OL】诸葛诞④",
  ["ol__zhugeguo.jpg"] = "【OL】诸葛果③",
  ["ol__zhugejin.jpg"] = "【OL】诸葛瑾⑥",
  ["ol_evil__caocao.jpg"] = "【OL】魔曹操①",
  ["ol_evil__diaochan.jpg"] = "【OL】魔貂蝉②",
  ["ol_evil__lvbu.jpg"] = "【OL】魔吕布①",
  ["ol_evil__simayi.jpg"] = "【OL】魔司马懿①",
  ["ol_evil__zhangfei.jpg"] = "【OL】魔张飞①",
  ["ol_ex__caifuren.jpg"] = "【OL】界蔡夫人③",
  ["ol_ex__caiwenji.jpg"] = "【OL】界蔡文姬②",
  ["ol_ex__caocao.jpg"] = "【OL】界曹操⑤",
  ["ol_ex__caochong.jpg"] = "【OL】界曹冲⑥",
  ["ol_ex__caojie.jpg"] = "【OL】界曹节①",
  ["ol_ex__dengai.jpg"] = "【OL】界邓艾④",
  ["ol_ex__dianwei.jpg"] = "【OL】界典韦④",
  ["ol_ex__dongzhuo.jpg"] = "【OL】界董卓②",
  ["ol_ex__fazheng.jpg"] = "【OL】界法正②",
  ["ol_ex__fuhuanghou.jpg"] = "【OL】界伏皇后⑦",
  ["ol_ex__gaoshun.jpg"] = "【OL】界高顺③",
  ["ol_ex__guohuanghou.jpg"] = "【OL】界郭皇后①",
  ["ol_ex__huangzhong.jpg"] = "【OL】界黄忠④",
  ["ol_ex__huaxiong.jpg"] = "【OL】界华雄③",
  ["ol_ex__jiangwei.jpg"] = "【OL】界姜维③",
  ["ol_ex__jiaxu.jpg"] = "【OL】界贾诩②",
  ["ol_ex__lidian.jpg"] = "【OL】李典②",
  ["ol_ex__liru.jpg"] = "【OL】界李儒①",
  ["ol_ex__liubei.jpg"] = "【OL】界刘备⑨",
  ["ol_ex__liushan.jpg"] = "【OL】界刘禅③",
  ["ol_ex__lusu.jpg"] = "【OL】界鲁肃①",
  ["ol_ex__lvmeng.jpg"] = "【OL】界吕蒙②",
  ["ol_ex__pangde.jpg"] = "【OL】界庞德①",
  ["ol_ex__sunce.jpg"] = "【OL】界孙策⑥",
  ["ol_ex__sunluban.jpg"] = "【OL】界孙鲁班②",
  ["ol_ex__taishici.jpg"] = "【OL】界太史慈①",
  ["ol_ex__wangyi.jpg"] = "【OL】界王异①",
  ["ol_ex__weiyan.jpg"] = "【OL】界魏延①",
  ["ol_ex__wolong.jpg"] = "【OL】界卧龙诸葛亮⑫",
  ["ol_ex__wuguotai.jpg"] = "【OL】吴国太④",
  ["ol_ex__xiahouyuan.jpg"] = "【OL】界夏侯渊⑦",
  ["ol_ex__xiaoqiao.jpg"] = "【OL】界小乔①",
  ["ol_ex__xinxianying.jpg"] = "【OL】界辛宪英⑧",
  ["ol_ex__xuhuang.jpg"] = "【OL】界徐晃④",
  ["ol_ex__xunyu.jpg"] = "【OL】界荀彧⑦",
  ["ol_ex__xusheng.jpg"] = "【OL】界徐盛②",
  ["ol_ex__yuanshao.jpg"] = "【OL】界袁绍③",
  ["ol_ex__yuji.jpg"] = "【OL】界于吉④",
  ["ol_ex__zhangchunhua.jpg"] = "【OL】张春华①",
  ["ol_ex__zhangjiao.jpg"] = "【OL】界张角①",
  ["ol_ex__zhaoyun.jpg"] = "【OL】(界赵云x马云禄)②",
  ["ol_ex__zhonghui.jpg"] = "【OL】界钟会①",
  ["ol_ex__zhuhuan.jpg"] = "【OL】界朱桓⑥",
  ["ol_ex__zhurong.jpg"] = "【OL】界祝融⑤",
  ["ol_ex__zuoci.jpg"] = "【OL】界左慈⑨",
  ["ol_sp__caocao.jpg"] = "【OL】SP曹操至臻①",
  ["ol_sp__caoren.jpg"] = "【OL】SP曹仁①",
  ["ol_sp__huangyueying.jpg"] = "【OL】SP黄月英①",
  ["ol_sp__jiaxu.jpg"] = "【OL】SP贾诩①",
  ["ol_sp__machao.jpg"] = "【OL】SP马超⑥",
  ["ol_sp__zhanghe.jpg"] = "【OL】SP张郃(旧音)①",
  ["olmou__jiangwei.jpg"] = "【OL】谋姜维④",
  ["olmou__pangtong.jpg"] = "【OL】谋庞统⑤",
  ["olz__wanghun.jpg"] = "【OL】族(王浑x钟琰)",
  ["olz__wangling.jpg"] = "【OL】族王凌①",
  ["olz__wuxian.jpg"] = "【OL】族吴苋(方言)",
  ["olz__xunshu.jpg"] = "【OL】族荀淑(方言)",
  ["olz__yangxiu.jpg"] = "【OL】族杨修①",
  ["olz__zhonghui.jpg"] = "【OL】族钟会(方言)",
  ["olz__zhongyan.jpg"] = "【OL】族(王浑x钟琰)",
  ["pangxi.jpg"] = "【手杀】庞羲①",
  ["panjun.jpg"] = "【十周年】潘濬①",
  ["qiaogong.jpg"] = "【手杀】桥公②",
  ["qinghegongzhu.jpg"] = "【OL】清河公主①",
  ["qinmi.jpg"] = "【一将成名】秦宓②",
  ["quanhuijie.jpg"] = "【十周年】全惠解①",
  ["renwan.jpg"] = "【十周年】任婉①",
  ["ruiji.jpg"] = "【OL】(界周妃x芮姬)",
  ["shamoke.jpg"] = "【十周年】沙摩柯⑧",
  ["shibao.jpg"] = "【OL】石苞①",
  ["shiyi.jpg"] = "【十周年】是仪①",
  ["simahui.jpg"] = "【十周年】司马徽⑤",
  ["sp__caiwenji.jpg"] = "【SP】蔡文姬⑥",
  ["sp__pangtong.jpg"] = "【十周年】SP庞统①",
  ["starsp__diaochan.jpg"] = "【SP】貂蝉④",
  ["starsp__zhaoyun.jpg"] = "【SP】赵云②",
  ["sunchen.jpg"] = "【十周年】孙綝②",
  ["sundeng.jpg"] = "【一将成名】孙登②",
  ["sunli.jpg"] = "【十周年】孙礼①",
  ["sunliang.jpg"] = "【神话再临】孙亮②",
  ["sunlingluan.jpg"] = "【十周年】孙翎鸾②",
  ["sunqian.jpg"] = "【OL】孙乾①",
  ["sunziliufang.jpg"] = "【一将成名】孙资刘放③",
  ["tadun.jpg"] = "【OL】蹋顿①",
  ["tangji.jpg"] = "【十周年】唐姬②",
  ["taoqian.jpg"] = "【手杀】陶谦②",
  ["tenggongzhu.jpg"] = "【十周年】滕公主①",
  ["ty__baosanniang.jpg"] = "【十周年】(关索x鲍三娘)②",
  ["ty__caochun.jpg"] = "【十周年】曹纯①",
  ["ty__chengyu.jpg"] = "【十周年】程昱①",
  ["ty__chenlin.jpg"] = "【十周年】陈琳①",
  ["ty__daqiaoxiaoqiao.jpg"] = "【十周年】大小乔⑥",
  ["ty__dingyuan.jpg"] = "【十周年】丁原②",
  ["ty__dongbai.jpg"] = "【十周年】董白①",
  ["ty__dongcheng.jpg"] = "【十周年】董承①",
  ["ty__fengfangnv.jpg"] = "【十周年】冯妤①",
  ["ty__ganfuren.jpg"] = "【十周年】甘夫人⑥",
  ["ty__godguanyu.jpg"] = "【十周年】神关羽②",
  ["ty__godliubei.jpg"] = "【十周年】神刘备①",
  ["ty__godsunquan.jpg"] = "【十周年】神孙权②",
  ["ty__guansuo.jpg"] = "【十周年】(关索x鲍三娘)②",
  ["ty__huaman.jpg"] = "【十周年】花鬘⑦",
  ["ty__huangchengyan.jpg"] = "【十周年】黄承彦①",
  ["ty__jiachong.jpg"] = "【十周年】贾充①",
  ["ty__lidian.jpg"] = "【十周年】李典①",
  ["ty__lingju.jpg"] = "【十周年】灵雎①",
  ["ty__liuba.jpg"] = "【十周年】刘巴①",
  ["ty__liuhong.jpg"] = "【十周年】刘宏①",
  ["ty__liuqi.jpg"] = "【十周年】界刘琦①",
  ["ty__liuye.jpg"] = "【十周年】刘晔④",
  ["ty__mifuren.jpg"] = "mifuren",
  ["ty__nanhualaoxian.jpg"] = "【十周年】南华老仙④",
  ["ty__pangdegong.jpg"] = "【十周年】庞德公①",
  ["ty__panshu.jpg"] = "【十周年】潘淑①",
  ["ty__puyuan.jpg"] = "【十周年】猪猪侠侠联动系列",
  ["ty__qiaozhou.jpg"] = "【十周年】谯周①",
  ["ty__quyi.jpg"] = "【十周年】麴义①",
  ["ty__simafu.jpg"] = "【十周年】司马孚①",
  ["ty__sufei.jpg"] = "【十周年】苏飞②",
  ["ty__sunluyu.jpg"] = "【十周年】(孙鲁班x孙鲁育)②",
  ["ty__tangzi.jpg"] = "【十周年】唐咨①",
  ["ty__tianfeng.jpg"] = "【十周年】田丰①",
  ["ty__wangchang.jpg"] = "【十周年】王昶①",
  ["ty__wangrongh.jpg"] = "【十周年】王荣①",
  ["ty__wutugu.jpg"] = "【十周年】兀突骨①",
  ["ty__xiahouba.jpg"] = "【十周年】界夏侯霸③",
  ["ty__xiahouhui.jpg"] = "【十周年】(谋司马师x夏侯徽)",
  ["ty__xinxianying.jpg"] = "【十周年】界辛宪英①",
  ["ty__xuangongzhu.jpg"] = "【十周年】宣公主①",
  ["ty__xugong.jpg"] = "【十周年】许贡①",
  ["ty__xujing.jpg"] = "【十周年】许靖③",
  ["ty__xunchen.jpg"] = "【十周年】荀谌③",
  ["ty__xushao.jpg"] = "【十周年】许邵③",
  ["ty__yanghu.jpg"] = "【十周年】羊祜①",
  ["ty__yuejin.jpg"] = "【十周年】乐进③",
  ["ty__zhangchangpu.jpg"] = "【十周年】张昌蒲③",
  ["ty__zhangrang.jpg"] = "【十周年】张让①",
  ["ty__zhaoxiang.jpg"] = "【十周年】赵襄①",
  ["ty__zhaoyan.jpg"] = "【十周年】赵俨①",
  ["ty__zhugeguo.jpg"] = "【十周年】诸葛果②",
  ["ty_ex__bulianshi.jpg"] = "【十周年】界步练师②",
  ["ty_ex__caorui.jpg"] = "【十周年】(界曹叡x界郭皇后)",
  ["ty_ex__caoxiu.jpg"] = "【十周年】界曹休①",
  ["ty_ex__caozhen.jpg"] = "【十周年】界曹真③",
  ["ty_ex__chengong.jpg"] = "【十周年】界陈宫①",
  ["ty_ex__chenqun.jpg"] = "【十周年】界陈群④",
  ["ty_ex__fuhuanghou.jpg"] = "【十周年】界伏皇后①",
  ["ty_ex__gaoshun.jpg"] = "【十周年】界高顺①",
  ["ty_ex__gongsunyuan.jpg"] = "gongsunzan",
  ["ty_ex__guanping.jpg"] = "【十周年】界关平④",
  ["ty_ex__guohuanghou.jpg"] = "【十周年】(界曹叡x界郭皇后)",
  ["ty_ex__huangyueying.jpg"] = "【十周年】SP黄月英④",
  ["ty_ex__jianyong.jpg"] = "【十周年】界简雍①",
  ["ty_ex__jvshou.jpg"] = "【十周年】界沮授④",
  ["ty_ex__lingtong.jpg"] = "【十周年】猪猪侠侠联动系列",
  ["ty_ex__liru.jpg"] = "【十周年】界李儒⑤",
  ["ty_ex__liubiao.jpg"] = "【十周年】界刘表①",
  ["ty_ex__liuchen.jpg"] = "【十周年】界刘谌②",
  ["ty_ex__liufeng.jpg"] = "【十周年】界刘封⑥",
  ["ty_ex__simalang.jpg"] = "【十周年】界司马朗②",
  ["ty_ex__sunluban.jpg"] = "【十周年】(孙鲁班x孙鲁育)②",
  ["ty_ex__sunxiu.jpg"] = "【十周年】界孙休③",
  ["ty_ex__taishici.jpg"] = "【十周年】界SP太史慈②",
  ["ty_ex__wangyi.jpg"] = "【十周年】界王异①",
  ["ty_ex__wuyi.jpg"] = "【十周年】界吴懿①",
  ["ty_ex__xiahoushi.jpg"] = "【十周年】(夏侯氏x张星彩)",
  ["ty_ex__xunyou.jpg"] = "【十周年】界荀攸①",
  ["ty_ex__xushu.jpg"] = "【十周年】界徐庶①",
  ["ty_ex__yujin.jpg"] = "【十周年】界于禁⑥",
  ["ty_ex__zhangchunhua.jpg"] = "【十周年】界张春华②",
  ["ty_ex__zhangsong.jpg"] = "【十周年】界张松⑥",
  ["ty_ex__zhangyi.jpg"] = "【十周年】界张嶷①",
  ["ty_ex__zhonghui.jpg"] = "【十周年】界钟会②",
  ["ty_ex__zhongyao.jpg"] = "【十周年】钟繇①",
  ["ty_ex__zhugedan.jpg"] = "【十周年】界诸葛诞④",
  ["ty_ex__zhuran.jpg"] = "【十周年】界朱然①",
  ["ty_ex__zhuzhi.jpg"] = "【十周年】界朱治⑧",
  ["ty_sp__guanyu.jpg"] = "【十周年】SP关羽①",
  ["ty_sp__zhaoyun.jpg"] = "【十周年】SP赵云①",
  ["ty_sp__zhenji.jpg"] = "【十周年】SP甄姬②",
  ["ty_wei__caopi.jpg"] = "【十周年】威曹丕①",
  ["ty_wei__dongzhuo.jpg"] = "【十周年】威董卓①",
  ["ty_wei__guanyinping.jpg"] = "【十周年】威关银屏(武)",
  ["ty_wei__liubei.jpg"] = "【十周年】威刘备④",
  ["ty_wei__lvbu.jpg"] = "【十周年】猪猪侠侠联动系列",
  ["ty_wei__sunshangxiang.jpg"] = "【十周年】威孙尚香(武)",
  ["ty_wei__xingcai.jpg"] = "【十周年】威张星彩(武)",
  ["ty_wei__zhangliao.jpg"] = "【十周年】猪猪侠侠联动系列",
  ["tymou__caoshuang.jpg"] = "【十周年】谋曹爽①",
  ["tymou__chenlin.jpg"] = "【十周年】谋陈琳①",
  ["tymou__dengai.jpg"] = "【十周年】猪猪侠侠联动系列",
  ["tymou__huanggai.jpg"] = "【十周年】猪猪侠侠联动系列",
  ["tymou__luotong.jpg"] = "【十周年】猪猪侠侠联动系列",
  ["tymou__simashi.jpg"] = "【十周年】(谋司马师x夏侯徽)",
  ["tymou__zhugejin.jpg"] = "【十周年】谋诸葛瑾①",
  ["tystar__caoren.jpg"] = "【十周年】星曹仁①",
  ["tystar__dongzhuo.jpg"] = "【十周年】星董卓②",
  ["tystar__sunjian.jpg"] = "【十周年】星孙坚①",
  ["tystar__sunshangxiang.jpg"] = "【十周年】星孙尚香②",
  ["tystar__xunyu.jpg"] = "【十周年】星荀彧①",
  ["tystar__yuanshao.jpg"] = "【十周年】星袁绍①",
  ["wangji.jpg"] = "【神话再临】王基④",
  ["wangping.jpg"] = "【神话再临】王平⑩",
  ["wangrongh.jpg"] = "【OL】王荣③",
  ["wangshuang.jpg"] = "【十周年】王双①",
  ["wangtao.jpg"] = "【十周年】王桃②",
  ["wangyi.jpg"] = "【一将成名】王异⑤",
  ["wangyues.jpg"] = "【十周年】王悦①",
  ["wanniangongzhu.jpg"] = "【十周年】万年公主③",
  ["weiguan.jpg"] = "【OL】卫瓘①",
  ["weizi.jpg"] = "【OL】卫兹①",
  ["wenyang.jpg"] = "【十周年】文鸯③",
  ["wolongfengchu.jpg"] = "【OL】卧龙凤雏(方言)",
  ["wuxian.jpg"] = "【一将成名】吴苋⑦",
  ["xiahouhui.jpg"] = "1【OL】夏侯徽②",
  ["xiahoujie.jpg"] = "【十周年】夏侯杰②",
  ["xiahoulingnv.jpg"] = "【十周年】夏侯令女①",
  ["xiahouxuan.jpg"] = "【OL】夏侯玄①",
  ["xizhicai.jpg"] = "【OL】戏志才③",
  ["xuangongzhu.jpg"] = "【OL】晋(杜预x宣公主)",
  ["xuelingyun.jpg"] = "【十周年】薛灵芸①",
  ["xunyu.jpg"] = "【神话再临】荀彧④",
  ["xurong.jpg"] = "【十周年】徐荣④",
  ["xushi.jpg"] = "【一将成名】徐氏⑦",
  ["xushu.jpg"] = "【一将成名】徐庶⑤",
  ["xuyou.jpg"] = "【十周年】猪猪侠侠联动系列",
  ["yanfuren.jpg"] = "【十周年】严夫人①",
  ["yangbiao.jpg"] = "【手杀】杨彪③",
  ["yangxiu.jpg"] = "【SP】杨修①",
  ["yangyan.jpg"] = "【OL】(杨艳x杨芷)①",
  ["yangzhi.jpg"] = "【OL】(杨艳x杨芷)①",
  ["yanjun.jpg"] = "【十周年】严畯③",
  ["yanrou.jpg"] = "【十周年】阎柔②",
  ["yijik.jpg"] = "【界限突破】伊籍③",
  ["yuechen.jpg"] = "【十周年】乐綝①",
  ["zerong.jpg"] = "【十周年】笮融①",
  ["zhanghuyuechen.jpg"] = "【OL】张虎乐綝①",
  ["zhangling.jpg"] = "【OL】张陵①",
  ["zhanglu.jpg"] = "【OL】张鲁①",
  ["zhangqiying.jpg"] = "【十周年】张琪瑛①",
  ["zhangrang.jpg"] = "【一将成名】张让②",
  ["zhangxiu.jpg"] = "【神话再临】张绣⑪",
  ["zhangyao.jpg"] = "【十周年】张媱②",
  ["zhangzhi.jpg"] = "【OL】张芝①",
  ["zhaoyan.jpg"] = "【OL】赵俨①",
  ["zhaoyanw.jpg"] = "【十周年】赵嫣①",
  ["zhaozhi.jpg"] = "【十周年】赵直①",
  ["zhenghun.jpg"] = "【十周年】郑浑①",
  ["zhiyi.jpg"] = "【手杀】张翼①",
  ["zhongyan.jpg"] = "【OL】钟琰①",
  ["zhongyao.jpg"] = "【一将成名】钟繇①",
  ["zhoufang.jpg"] = "【十周年】周鲂⑤",
  ["zhoufei.jpg"] = "【神话再临】周妃⑥",
  ["zhoushan.jpg"] = "【十周年】周善①",
  ["zhouxuan.jpg"] = "【十周年】周宣③",
  ["zhugejing.jpg"] = "【十周年】诸葛京①",
  ["zhugeke.jpg"] = "zhugeke",
  ["zhugemengxue.jpg"] = "【十周年】(蒯祺x诸葛梦雪)",
  ["zhugeruoxue.jpg"] = "【十周年】(诸葛梦雪x若雪)",
  ["zhugeshang.jpg"] = "【十周年】诸葛尚①",
  ["zhugezhan.jpg"] = "【神话再临】诸葛瞻⑩",
  ["zhupeilan.jpg"] = "【十周年】朱佩兰①",
  ["zhuzhi.jpg"] = "【一将成名】朱治①",
  ["zuofen.jpg"] = "【OL】左棻③",
}

return extension
