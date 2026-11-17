-- 精选原画（皮肤形式）：参考 lunarltk_skins / fengsui_skins 的 SkinPack 实现。
-- 图片仍留在原资源目录，本文件只按武将注册皮肤，不移动、不删除、不复制任何图片。
-- 删除本文件或从 advancedpackages/init.lua 移除引用即可整体撤销。

local extension = Package:new("advanced_art_skins", Package.SkinPack)
extension.extensionName = "advancedpackages"

-- 每个原画子目录一次注册：path 直接指向该目录的 image/generals，
-- 皮肤名即图片文件名（武将 id），界面显示名由下方翻译表给出。
extension:addSkinPackage {
  path = "/精选原画/resource/1【OL】夏侯徽②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "xiahouhui" },
      skins = { "xiahouhui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/1【手杀】曹髦②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__caomao" },
      skins = { "mobile__caomao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/bulianshi/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__bulianshi" },
      skins = { "king_btl__bulianshi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/buzhi/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__buzhi" },
      skins = { "king_btl__buzhi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/caifuren/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__caifuren" },
      skins = { "king_btl__caifuren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/caoang/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__caoang" },
      skins = { "king_btl__caoang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/caocao/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__caocao" },
      skins = { "king_btl__caocao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/caohua/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "btl__caohua" },
      skins = { "btl__caohua.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/caoren/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__caoren" },
      skins = { "king_btl__caoren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/caorui/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__caorui" },
      skins = { "king_btl__caorui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/chengong/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__chengong" },
      skins = { "king_btl__chengong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/chenqun/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__chenqun" },
      skins = { "king_btl__chenqun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/cuiyan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__cuiyan" },
      skins = { "king_btl__cuiyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/daqiao/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__daqiao" },
      skins = { "king_btl__daqiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/dengai/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__dengai" },
      skins = { "king_btl__dengai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/dianwei/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__dianwei" },
      skins = { "king_btl__dianwei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/diaochan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__diaochan" },
      skins = { "king_btl__diaochan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/dingyuan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__dingyuan" },
      skins = { "king_btl__dingyuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/fazheng/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__fazheng" },
      skins = { "king_btl__fazheng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/gaoshun/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__gaoshun" },
      skins = { "king_btl__gaoshun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/gongsunyuan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__gongsunyuan" },
      skins = { "king_btl__gongsunyuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/gongsunzan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__gongsunyuan" },
      skins = { "ty_ex__gongsunyuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/guanxingzhangbao/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__guanxingzhangbao" },
      skins = { "king_btl__guanxingzhangbao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/guanyinping/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__guanyinping" },
      skins = { "king_btl__guanyinping.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/guanyu/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__guanyu" },
      skins = { "king_btl__guanyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/guojia/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__guojia" },
      skins = { "king_btl__guojia.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/guotupangji/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__guotupangji" },
      skins = { "king_btl__guotupangji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/haozhao/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__haozhao" },
      skins = { "king_btl__haozhao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/huanggai/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__huanggai" },
      skins = { "king_btl__huanggai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/huangquan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__huangquan" },
      skins = { "king_btl__huangquan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/huaxiong/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__huaxiong" },
      skins = { "king_btl__huaxiong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/jianggan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__jianggan" },
      skins = { "king_btl__jianggan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/jiangwei/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__jiangwei" },
      skins = { "king_btl__jiangwei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/jiaxu/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__jiaxu" },
      skins = { "king_btl__jiaxu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/jushou/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__jvshou" },
      skins = { "king_btl__jvshou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/lidian/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__lidian" },
      skins = { "king_btl__lidian.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/lingtong/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__lingtong" },
      skins = { "king_btl__lingtong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/liushan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__liushan" },
      skins = { "king_btl__liushan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/liuxie/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__liuxie" },
      skins = { "king_btl__liuxie.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/lusu/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__lusu" },
      skins = { "king_btl__lusu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/luxun/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__luxun" },
      skins = { "king_btl__luxun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/luzhi/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__luzhiw" },
      skins = { "king_btl__luzhiw.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/machao/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__machao" },
      skins = { "king_btl__machao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/mateng/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__mateng" },
      skins = { "king_btl__mateng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/mifuren/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "ty__mifuren" },
      skins = { "ty__mifuren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/mizhu/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__mizhu" },
      skins = { "king_btl__mizhu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/panfeng/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__panfeng" },
      skins = { "king_btl__panfeng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/qinmi/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__qinmi" },
      skins = { "king_btl__qinmi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/quyi/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__quyi" },
      skins = { "king_btl__quyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/shamoke/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__shamoke" },
      skins = { "king_btl__shamoke.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/simayi/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__simayi" },
      skins = { "king_btl__simayi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/sp_machao/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "kbtl_sp__machao" },
      skins = { "kbtl_sp__machao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/sp_pangtong/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "kbtl_sp__pangtong" },
      skins = { "kbtl_sp__pangtong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/sundeng/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__sundeng" },
      skins = { "king_btl__sundeng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/sunhao/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__sunhao" },
      skins = { "king_btl__sunhao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/sunquan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__sunquan" },
      skins = { "king_btl__sunquan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/sunshangxiang/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__sunshangxiang" },
      skins = { "king_btl__sunshangxiang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/taishici/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__taishici" },
      skins = { "king_btl__taishici.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/wangji/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__wangji" },
      skins = { "king_btl__wangji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/wangping/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__wangping" },
      skins = { "king_btl__wangping.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/weiyan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__weiyan" },
      skins = { "king_btl__weiyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/wenyang/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__wenyang" },
      skins = { "king_btl__wenyang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/wolong/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__wolong" },
      skins = { "king_btl__wolong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/wuyi/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__wuyi" },
      skins = { "king_btl__wuyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/xiahoushi/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__xiahoushi" },
      skins = { "king_btl__xiahoushi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/xiahouyuan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__xiahouyuan" },
      skins = { "king_btl__xiahouyuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/xuhuang/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__xuhuang" },
      skins = { "king_btl__xuhuang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/xunyou/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__xunyou" },
      skins = { "king_btl__xunyou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/xunyu/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__xunyu" },
      skins = { "king_btl__xunyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/xusheng/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__xusheng" },
      skins = { "king_btl__xusheng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/xuyou/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__xuyou" },
      skins = { "king_btl__xuyou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/yanliangwenchou/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__yanliangwenchou" },
      skins = { "king_btl__yanliangwenchou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/yanrou/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__yanrou" },
      skins = { "king_btl__yanrou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/yujin/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__yujin" },
      skins = { "king_btl__yujin.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/zhangchunhua/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhangchunhua" },
      skins = { "king_btl__zhangchunhua.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/zhangliao/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhangliao" },
      skins = { "king_btl__zhangliao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/zhangxingcai/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__xingcai" },
      skins = { "king_btl__xingcai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/zhangyi/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhangyiy" },
      skins = { "king_btl__zhangyiy.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/zhaoyun/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhaoyun" },
      skins = { "king_btl__zhaoyun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/zhongyao/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhongyao" },
      skins = { "king_btl__zhongyao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/zhoufang/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhoufang" },
      skins = { "king_btl__zhoufang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/zhugejin/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhugejin" },
      skins = { "king_btl__zhugejin.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/zhugeke/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhugeke" },
      skins = { "king_btl__zhugeke.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/zhugeke/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "zhugeke" },
      skins = { "zhugeke.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/zhugeliang/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhugeliang" },
      skins = { "king_btl__zhugeliang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/zhugezhan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhugezhan" },
      skins = { "king_btl__zhugezhan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/zhuhuan/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhuhuan" },
      skins = { "king_btl__zhuhuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/zhuran/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhuran" },
      skins = { "king_btl__zhuran.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/zhurong/packages/bloodybattle/image/generals",
  content = {
    {
      enabled_generals = { "king_btl__zhurong" },
      skins = { "king_btl__zhurong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】(晋司马师x夏侯徽)①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__simashi" },
      skins = { "ol__simashi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】(杨艳x杨芷)①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "yangyan" },
      skins = { "yangyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】(杨艳x杨芷)①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "yangzhi" },
      skins = { "yangzhi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】(牛辅x董翓)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__dongxie" },
      skins = { "ol__dongxie.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】(牛辅x董翓)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__niufu" },
      skins = { "ol__niufu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】(界周妃x芮姬)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__zhoufei" },
      skins = { "ol__zhoufei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】(界周妃x芮姬)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ruiji" },
      skins = { "ruiji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】(界赵云x马云禄)②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "mayunlu" },
      skins = { "mayunlu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】(界赵云x马云禄)②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__zhaoyun" },
      skins = { "ol_ex__zhaoyun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】(郭照x曹丕)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__guozhao" },
      skins = { "ol__guozhao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】(郭照x曹丕)/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "caopi" },
      skins = { "caopi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】SP张郃(旧音)①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_sp__zhanghe" },
      skins = { "ol_sp__zhanghe.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】SP曹仁①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_sp__caoren" },
      skins = { "ol_sp__caoren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】SP曹操至臻①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_sp__caocao" },
      skins = { "ol_sp__caocao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】SP贾诩①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_sp__jiaxu" },
      skins = { "ol_sp__jiaxu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】SP马超⑥/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_sp__machao" },
      skins = { "ol_sp__machao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】SP黄月英①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_sp__huangyueying" },
      skins = { "ol_sp__huangyueying.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】丁尚涴①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__dingfuren" },
      skins = { "ol__dingfuren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】何太后⑤/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__hetaihou" },
      skins = { "ol__hetaihou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】关索③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__guansuo" },
      skins = { "ol__guansuo.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】冯方女①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__fengfangnv" },
      skins = { "ol__fengfangnv.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】刘琦②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "liuqi" },
      skins = { "liuqi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】卑弥呼⑦/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "himiko" },
      skins = { "himiko.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】卞夫人②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__bianfuren" },
      skins = { "ol__bianfuren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】卢氏②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "lushi" },
      skins = { "lushi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】卧龙凤雏(方言)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "wolongfengchu" },
      skins = { "wolongfengchu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】卫兹①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "weizi" },
      skins = { "weizi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】卫瓘①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "weiguan" },
      skins = { "weiguan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】吕伯奢①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "lvboshe" },
      skins = { "lvboshe.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】吕玲绮①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__lvlingqi" },
      skins = { "ol__lvlingqi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】吴国太④/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__wuguotai" },
      skins = { "ol_ex__wuguotai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】夏侯玄①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "xiahouxuan" },
      skins = { "xiahouxuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】孔淑①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "kongshu" },
      skins = { "kongshu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】孙乾①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "sunqian" },
      skins = { "sunqian.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】孙亮①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__sunliang" },
      skins = { "ol__sunliang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】孙皓②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__sunhao" },
      skins = { "ol__sunhao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】孙茹①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__sunru" },
      skins = { "ol__sunru.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】孙鲁育①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__sunluyu" },
      skins = { "ol__sunluyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】嵇康②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__jikang" },
      skins = { "ol__jikang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】左棻③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "zuofen" },
      skins = { "zuofen.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】张昌蒲④/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__zhangchangpu" },
      skins = { "ol__zhangchangpu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】张星彩⑥/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__xingcai" },
      skins = { "ol__xingcai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】张春华①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__zhangchunhua" },
      skins = { "ol_ex__zhangchunhua.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】张琪瑛③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__zhangqiying" },
      skins = { "ol__zhangqiying.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】张芝①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "zhangzhi" },
      skins = { "zhangzhi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】张虎乐綝①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "zhanghuyuechen" },
      skins = { "zhanghuyuechen.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】张陵①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "zhangling" },
      skins = { "zhangling.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】张鲁①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "zhanglu" },
      skins = { "zhanglu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】戏志才③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "xizhicai" },
      skins = { "xizhicai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】族(王浑x钟琰)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "olz__wanghun" },
      skins = { "olz__wanghun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】族(王浑x钟琰)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "olz__zhongyan" },
      skins = { "olz__zhongyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】族吴苋(方言)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "olz__wuxian" },
      skins = { "olz__wuxian.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】族杨修①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "olz__yangxiu" },
      skins = { "olz__yangxiu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】族王凌①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "olz__wangling" },
      skins = { "olz__wangling.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】族荀淑(方言)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "olz__xunshu" },
      skins = { "olz__xunshu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】族钟会(方言)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "olz__zhonghui" },
      skins = { "olz__zhonghui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】晋(杜预x宣公主)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__duyu" },
      skins = { "ol__duyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】晋(杜预x宣公主)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "xuangongzhu" },
      skins = { "xuangongzhu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】晋周处①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__zhouchu" },
      skins = { "ol__zhouchu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】晋王元姬③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__wangyuanji" },
      skins = { "ol__wangyuanji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】晋羊徽瑜③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__yanghuiyu" },
      skins = { "ol__yanghuiyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】晋羊祜①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__yanghu" },
      skins = { "ol__yanghu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】曹婴⑤/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "caoying" },
      skins = { "caoying.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】曹宪曹华①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "caoxiancaohua" },
      skins = { "caoxiancaohua.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】曹纯⑤/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__caochun" },
      skins = { "ol__caochun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】曹金玉①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__caojinyu" },
      skins = { "ol__caojinyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】李典②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__lidian" },
      skins = { "ol_ex__lidian.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】李婉④/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__liwan" },
      skins = { "ol__liwan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】杨仪①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__yangyi" },
      skins = { "ol__yangyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】杨婉①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__yangwan" },
      skins = { "ol__yangwan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】步骘①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "buzhi" },
      skins = { "buzhi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】清河公主①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "qinghegongzhu" },
      skins = { "qinghegongzhu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】滕芳兰①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__tengfanglan" },
      skins = { "ol__tengfanglan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】牛金①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__niujin" },
      skins = { "ol__niujin.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】王朗③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__wanglang" },
      skins = { "ol__wanglang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】王荣③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "wangrongh" },
      skins = { "wangrongh.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界于吉④/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__yuji" },
      skins = { "ol_ex__yuji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界伏皇后⑦/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__fuhuanghou" },
      skins = { "ol_ex__fuhuanghou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界典韦④/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__dianwei" },
      skins = { "ol_ex__dianwei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界刘备⑨/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__liubei" },
      skins = { "ol_ex__liubei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界刘禅③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__liushan" },
      skins = { "ol_ex__liushan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界华雄③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__huaxiong" },
      skins = { "ol_ex__huaxiong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界卧龙诸葛亮⑫/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__wolong" },
      skins = { "ol_ex__wolong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界吕蒙②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__lvmeng" },
      skins = { "ol_ex__lvmeng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界周泰①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__zhoutai" },
      skins = { "ol__zhoutai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界夏侯渊⑦/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__xiahouyuan" },
      skins = { "ol_ex__xiahouyuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界太史慈①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__taishici" },
      skins = { "ol_ex__taishici.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界姜维③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__jiangwei" },
      skins = { "ol_ex__jiangwei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界孙策⑥/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__sunce" },
      skins = { "ol_ex__sunce.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界孙鲁班②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__sunluban" },
      skins = { "ol_ex__sunluban.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界小乔①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__xiaoqiao" },
      skins = { "ol_ex__xiaoqiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界左慈⑨/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__zuoci" },
      skins = { "ol_ex__zuoci.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界庞德①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__pangde" },
      skins = { "ol_ex__pangde.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界张角①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__zhangjiao" },
      skins = { "ol_ex__zhangjiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界徐晃④/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__xuhuang" },
      skins = { "ol_ex__xuhuang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界徐盛②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__xusheng" },
      skins = { "ol_ex__xusheng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界曹仁①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__caoren" },
      skins = { "ol__caoren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界曹冲⑥/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__caochong" },
      skins = { "ol_ex__caochong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界曹操⑤/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__caocao" },
      skins = { "ol_ex__caocao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界曹节①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__caojie" },
      skins = { "ol_ex__caojie.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界朱桓⑥/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__zhuhuan" },
      skins = { "ol_ex__zhuhuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界李儒①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__liru" },
      skins = { "ol_ex__liru.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界法正②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__fazheng" },
      skins = { "ol_ex__fazheng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界王异①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__wangyi" },
      skins = { "ol_ex__wangyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界祝融⑤/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__zhurong" },
      skins = { "ol_ex__zhurong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界荀彧⑦/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__xunyu" },
      skins = { "ol_ex__xunyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界董卓②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__dongzhuo" },
      skins = { "ol_ex__dongzhuo.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界蔡夫人③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__caifuren" },
      skins = { "ol_ex__caifuren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界蔡文姬②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__caiwenji" },
      skins = { "ol_ex__caiwenji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界袁绍③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__yuanshao" },
      skins = { "ol_ex__yuanshao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界贾诩②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__jiaxu" },
      skins = { "ol_ex__jiaxu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界辛宪英⑧/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__xinxianying" },
      skins = { "ol_ex__xinxianying.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界邓艾④/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__dengai" },
      skins = { "ol_ex__dengai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界郭皇后①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__guohuanghou" },
      skins = { "ol_ex__guohuanghou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界钟会①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__zhonghui" },
      skins = { "ol_ex__zhonghui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界高顺③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__gaoshun" },
      skins = { "ol_ex__gaoshun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界魏延①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__weiyan" },
      skins = { "ol_ex__weiyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界鲁肃①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__lusu" },
      skins = { "ol_ex__lusu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】界黄忠④/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_ex__huangzhong" },
      skins = { "ol_ex__huangzhong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】石苞①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "shibao" },
      skins = { "shibao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】神曹操②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__godcaocao" },
      skins = { "ol__godcaocao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】程昱⑥/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "chengyu" },
      skins = { "chengyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】糜竺①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "mizhu" },
      skins = { "mizhu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】胡金定①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__hujinding" },
      skins = { "ol__hujinding.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】苏飞②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__sufei" },
      skins = { "ol__sufei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】荀谌①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__xunchen" },
      skins = { "ol__xunchen.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】董允③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "dongyun" },
      skins = { "dongyun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】董昭①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__dongzhao" },
      skins = { "ol__dongzhao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】董白①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "dongbai" },
      skins = { "dongbai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】蒋琬(方言)/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__jiangwan" },
      skins = { "ol__jiangwan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】薛灵芸⑥/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__xuelingyun" },
      skins = { "ol__xuelingyun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】袁姬①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__yuanji" },
      skins = { "ol__yuanji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】许靖①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__xujing" },
      skins = { "ol__xujing.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】诸葛果③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__zhugeguo" },
      skins = { "ol__zhugeguo.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】诸葛瑾⑥/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__zhugejin" },
      skins = { "ol__zhugejin.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】诸葛诞④/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__zhugedan" },
      skins = { "ol__zhugedan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】谋姜维④/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "olmou__jiangwei" },
      skins = { "olmou__jiangwei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】谋庞统⑤/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "olmou__pangtong" },
      skins = { "olmou__pangtong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】费祎①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__feiyi" },
      skins = { "ol__feiyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】贾充②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__jiachong" },
      skins = { "ol__jiachong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】赵俨①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "zhaoyan" },
      skins = { "zhaoyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】蹋顿①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "tadun" },
      skins = { "tadun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】邓芝①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__dengzhi" },
      skins = { "ol__dengzhi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】郭槐①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "guohuaij" },
      skins = { "guohuaij.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】钟琰①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "zhongyan" },
      skins = { "zhongyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】陈登①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__chendeng" },
      skins = { "ol__chendeng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】魔司马懿①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_evil__simayi" },
      skins = { "ol_evil__simayi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】魔吕布①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_evil__lvbu" },
      skins = { "ol_evil__lvbu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】魔张飞①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_evil__zhangfei" },
      skins = { "ol_evil__zhangfei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】魔曹操①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_evil__caocao" },
      skins = { "ol_evil__caocao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】魔貂蝉②/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol_evil__diaochan" },
      skins = { "ol_evil__diaochan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】鲁芝③/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "luzhiw" },
      skins = { "luzhiw.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】鲍三娘①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__baosanniang" },
      skins = { "ol__baosanniang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【OL】黄权①/packages/ol/image/generals",
  content = {
    {
      enabled_generals = { "ol__huangquan" },
      skins = { "ol__huangquan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【SP】刘协②/packages/sp/image/generals",
  content = {
    {
      enabled_generals = { "liuxie" },
      skins = { "liuxie.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【SP】曹昂②/packages/sp/image/generals",
  content = {
    {
      enabled_generals = { "caoang" },
      skins = { "caoang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【SP】曹洪⑤/packages/sp/image/generals",
  content = {
    {
      enabled_generals = { "caohong" },
      skins = { "caohong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【SP】杨修①/packages/sp/image/generals",
  content = {
    {
      enabled_generals = { "yangxiu" },
      skins = { "yangxiu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【SP】蔡文姬⑥/packages/sp/image/generals",
  content = {
    {
      enabled_generals = { "sp__caiwenji" },
      skins = { "sp__caiwenji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【SP】貂蝉④/packages/sp/image/generals",
  content = {
    {
      enabled_generals = { "starsp__diaochan" },
      skins = { "starsp__diaochan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【SP】赵云②/packages/sp/image/generals",
  content = {
    {
      enabled_generals = { "starsp__zhaoyun" },
      skins = { "starsp__zhaoyun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【SP】陈琳③/packages/sp/image/generals",
  content = {
    {
      enabled_generals = { "chenlin" },
      skins = { "chenlin.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【SP】魏姜维⑤/packages/sp/image/generals",
  content = {
    {
      enabled_generals = { "jsp__jiangwei" },
      skins = { "jsp__jiangwei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【一将成名】关平②/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "guanping" },
      skins = { "guanping.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【一将成名】刘谌①/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "liuchen" },
      skins = { "liuchen.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【一将成名】吴苋⑦/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "wuxian" },
      skins = { "wuxian.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【一将成名】孙登②/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "sundeng" },
      skins = { "sundeng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【一将成名】孙资刘放③/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "sunziliufang" },
      skins = { "sunziliufang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【一将成名】张让②/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "zhangrang" },
      skins = { "zhangrang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【一将成名】徐庶⑤/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "xushu" },
      skins = { "xushu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【一将成名】徐氏⑦/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "xushi" },
      skins = { "xushi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【一将成名】旧王异⑤/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "nos__wangyi" },
      skins = { "nos__wangyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【一将成名】曹冲⑥/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "caochong" },
      skins = { "caochong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【一将成名】曹叡④/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "caorui" },
      skins = { "caorui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【一将成名】朱治①/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "zhuzhi" },
      skins = { "zhuzhi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【一将成名】李严①/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "liyans" },
      skins = { "liyans.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【一将成名】步练师③/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "bulianshi" },
      skins = { "bulianshi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【一将成名】满宠①/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "manchong" },
      skins = { "manchong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【一将成名】王异⑤/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "wangyi" },
      skins = { "wangyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【一将成名】秦宓②/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "qinmi" },
      skins = { "qinmi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【一将成名】郭图逢纪②/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "guotupangji" },
      skins = { "guotupangji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【一将成名】钟繇①/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "zhongyao" },
      skins = { "zhongyao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【一将成名】鲁肃②/packages/yj/image/generals",
  content = {
    {
      enabled_generals = { "lusu" },
      skins = { "lusu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】(乐曹植x崔令仪)/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "cuilingyi" },
      skins = { "cuilingyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】(乐曹植x崔令仪)/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "mu__caozhi" },
      skins = { "mu__caozhi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】(关索x鲍三娘)②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__baosanniang" },
      skins = { "ty__baosanniang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】(关索x鲍三娘)②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__guansuo" },
      skins = { "ty__guansuo.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】(夏侯氏x张星彩)/packages/mini/image/generals",
  content = {
    {
      enabled_generals = { "mini__zhangxingcai" },
      skins = { "mini__zhangxingcai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】(夏侯氏x张星彩)/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__xiahoushi" },
      skins = { "ty_ex__xiahoushi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】(孙鲁班x孙鲁育)②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__sunluyu" },
      skins = { "ty__sunluyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】(孙鲁班x孙鲁育)②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__sunluban" },
      skins = { "ty_ex__sunluban.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】(曹髦x卞玥）/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "bianyue" },
      skins = { "bianyue.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】(曹髦x卞玥）/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "caomao" },
      skins = { "caomao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】(界曹叡x界郭皇后)/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__caorui" },
      skins = { "ty_ex__caorui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】(界曹叡x界郭皇后)/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__guohuanghou" },
      skins = { "ty_ex__guohuanghou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】(蒯祺x诸葛梦雪)/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "kuaiqi" },
      skins = { "kuaiqi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】(蒯祺x诸葛梦雪)/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhugemengxue" },
      skins = { "zhugemengxue.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】(诸葛梦雪x若雪)/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhugeruoxue" },
      skins = { "zhugeruoxue.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】(谋司马师x夏侯徽)/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__xiahouhui" },
      skins = { "ty__xiahouhui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】(谋司马师x夏侯徽)/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tymou__simashi" },
      skins = { "tymou__simashi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】SP关羽①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_sp__guanyu" },
      skins = { "ty_sp__guanyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】SP庞统①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "sp__pangtong" },
      skins = { "sp__pangtong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】SP甄姬②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_sp__zhenji" },
      skins = { "ty_sp__zhenji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】SP赵云①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_sp__zhaoyun" },
      skins = { "ty_sp__zhaoyun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】SP黄月英④/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__huangyueying" },
      skins = { "ty_ex__huangyueying.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】丁原②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__dingyuan" },
      skins = { "ty__dingyuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】丁尚涴①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "dingfuren" },
      skins = { "dingfuren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】万年公主③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "wanniangongzhu" },
      skins = { "wanniangongzhu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】东海龙王①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "longwang" },
      skins = { "longwang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】严夫人①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "yanfuren" },
      skins = { "yanfuren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】严畯③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "yanjun" },
      skins = { "yanjun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】乐大乔③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "mu__daqiao" },
      skins = { "mu__daqiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】乐小乔③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "mu__xiaoqiao" },
      skins = { "mu__xiaoqiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】乐祢衡①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "mu__miheng" },
      skins = { "mu__miheng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】乐綝①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "yuechen" },
      skins = { "yuechen.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】乐蔡文姬①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "mu__caiwenji" },
      skins = { "mu__caiwenji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】乐诸葛果①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "mu__zhugeguo" },
      skins = { "mu__zhugeguo.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】乐貂蝉③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "mu__diaochan" },
      skins = { "mu__diaochan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】乐进③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__yuejin" },
      skins = { "ty__yuejin.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】乐邹氏①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "mu__zoushi" },
      skins = { "mu__zoushi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】任婉①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "renwan" },
      skins = { "renwan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】何晏②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "heyan" },
      skins = { "heyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】兀突骨①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__wutugu" },
      skins = { "ty__wutugu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】全惠解①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "quanhuijie" },
      skins = { "quanhuijie.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】公孙度①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "gongsundu" },
      skins = { "gongsundu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】关宁②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "guannings" },
      skins = { "guannings.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】冯妤①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__fengfangnv" },
      skins = { "ty__fengfangnv.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】刘宏①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__liuhong" },
      skins = { "ty__liuhong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】刘巴①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__liuba" },
      skins = { "ty__liuba.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】刘晔④/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__liuye" },
      skins = { "ty__liuye.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】刘永①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "liuyong" },
      skins = { "liuyong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】刘焉⑨/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "liuyan" },
      skins = { "liuyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】刘矜刘佩①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "liujinliupei" },
      skins = { "liujinliupei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】刘辩②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "liubian" },
      skins = { "liubian.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】南华老仙④/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__nanhualaoxian" },
      skins = { "ty__nanhualaoxian.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】卢弈①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "luyi" },
      skins = { "luyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】司马孚①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__simafu" },
      skins = { "ty__simafu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】司马徽⑤/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "simahui" },
      skins = { "simahui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】吕玲绮②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "lvlingqi" },
      skins = { "lvlingqi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】周善①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhoushan" },
      skins = { "zhoushan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】周宣③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhouxuan" },
      skins = { "zhouxuan.jpg", "dream_zhouxuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】周鲂⑤/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhoufang" },
      skins = { "zhoufang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】唐咨①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__tangzi" },
      skins = { "ty__tangzi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】唐姬②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tangji" },
      skins = { "tangji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】夏侯令女①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "xiahoulingnv" },
      skins = { "xiahoulingnv.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】夏侯杰②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "xiahoujie" },
      skins = { "xiahoujie.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】大小乔⑥/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__daqiaoxiaoqiao" },
      skins = { "ty__daqiaoxiaoqiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】威关银屏(武)/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_wei__guanyinping" },
      skins = { "ty_wei__guanyinping.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】威刘备④/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_wei__liubei" },
      skins = { "ty_wei__liubei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】威孙尚香(武)/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_wei__sunshangxiang" },
      skins = { "ty_wei__sunshangxiang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】威张星彩(武)/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_wei__xingcai" },
      skins = { "ty_wei__xingcai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】威曹丕①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_wei__caopi" },
      skins = { "ty_wei__caopi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】威董卓①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_wei__dongzhuo" },
      skins = { "ty_wei__dongzhuo.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】孙礼①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "sunli" },
      skins = { "sunli.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】孙綝②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "sunchen" },
      skins = { "sunchen.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】孙翎鸾②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "sunlingluan" },
      skins = { "sunlingluan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】宣公主①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__xuangongzhu" },
      skins = { "ty__xuangongzhu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】庞德公①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__pangdegong" },
      skins = { "ty__pangdegong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】张媱②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhangyao" },
      skins = { "zhangyao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】张昌蒲③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__zhangchangpu" },
      skins = { "ty__zhangchangpu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】张琪瑛①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhangqiying" },
      skins = { "zhangqiying.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】张让①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__zhangrang" },
      skins = { "ty__zhangrang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】徐荣④/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "xurong" },
      skins = { "xurong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】文鸯③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "wenyang" },
      skins = { "wenyang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】星孙坚①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tystar__sunjian" },
      skins = { "tystar__sunjian.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】星孙尚香②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tystar__sunshangxiang" },
      skins = { "tystar__sunshangxiang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】星曹仁①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tystar__caoren" },
      skins = { "tystar__caoren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】星荀彧①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tystar__xunyu" },
      skins = { "tystar__xunyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】星董卓②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tystar__dongzhuo" },
      skins = { "tystar__dongzhuo.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】星袁绍①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tystar__yuanshao" },
      skins = { "tystar__yuanshao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】是仪①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "shiyi" },
      skins = { "shiyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】曹华②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "caohua" },
      skins = { "caohua.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】曹宪③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "caoxian" },
      skins = { "caoxian.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】曹性①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "caoxing" },
      skins = { "caoxing.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】曹纯①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__caochun" },
      skins = { "ty__caochun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】曹芳①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "caofang" },
      skins = { "caofang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】曹金玉②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "caojinyu" },
      skins = { "caojinyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】朱佩兰①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhupeilan" },
      skins = { "zhupeilan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】李傕①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "lijue" },
      skins = { "lijue.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】李典①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__lidian" },
      skins = { "ty__lidian.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】杜夔①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "dukui" },
      skins = { "dukui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】杜夫人④/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "dufuren" },
      skins = { "dufuren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】来莺儿①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "laiyinger" },
      skins = { "laiyinger.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】柏灵筠②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "bailingyun" },
      skins = { "bailingyun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】柳婒①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "liutan" },
      skins = { "liutan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】梁兴②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "liangxing" },
      skins = { "liangxing.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】樊玉凤①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "fanyufeng" },
      skins = { "fanyufeng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】段煨②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "duanwei" },
      skins = { "duanwei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】沙摩柯⑧/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "shamoke" },
      skins = { "shamoke.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】滕公主①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tenggongzhu" },
      skins = { "tenggongzhu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】潘淑①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__panshu" },
      skins = { "ty__panshu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】潘濬①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "panjun" },
      skins = { "panjun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】灵雎①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__lingju" },
      skins = { "ty__lingju.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】猪猪侠侠联动系列/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "xuyou" },
      skins = { "xuyou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】猪猪侠侠联动系列/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "chengui" },
      skins = { "chengui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】猪猪侠侠联动系列/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "goddianwei" },
      skins = { "goddianwei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】猪猪侠侠联动系列/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "godhuangzhong" },
      skins = { "godhuangzhong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】猪猪侠侠联动系列/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "godpangtong" },
      skins = { "godpangtong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】猪猪侠侠联动系列/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "godzhangfei" },
      skins = { "godzhangfei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】猪猪侠侠联动系列/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__puyuan" },
      skins = { "ty__puyuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】猪猪侠侠联动系列/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__lingtong" },
      skins = { "ty_ex__lingtong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】猪猪侠侠联动系列/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_wei__lvbu" },
      skins = { "ty_wei__lvbu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】猪猪侠侠联动系列/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_wei__zhangliao" },
      skins = { "ty_wei__zhangliao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】猪猪侠侠联动系列/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tymou__dengai" },
      skins = { "tymou__dengai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】猪猪侠侠联动系列/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tymou__huanggai" },
      skins = { "tymou__huanggai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】猪猪侠侠联动系列/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tymou__luotong" },
      skins = { "tymou__luotong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】王双①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "wangshuang" },
      skins = { "wangshuang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】王悦①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "wangyues" },
      skins = { "wangyues.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】王昶①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__wangchang" },
      skins = { "ty__wangchang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】王桃②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "wangtao" },
      skins = { "wangtao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】王荣①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__wangrongh" },
      skins = { "ty__wangrongh.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】甘夫人⑥/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__ganfuren" },
      skins = { "ty__ganfuren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】甘糜夫人②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ganfurenmifuren" },
      skins = { "ganfurenmifuren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】田丰①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__tianfeng" },
      skins = { "ty__tianfeng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界SP太史慈②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__taishici" },
      skins = { "ty_ex__taishici.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界于禁⑥/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__yujin" },
      skins = { "ty_ex__yujin.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界伏皇后①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__fuhuanghou" },
      skins = { "ty_ex__fuhuanghou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界关平④/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__guanping" },
      skins = { "ty_ex__guanping.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界刘封⑥/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__liufeng" },
      skins = { "ty_ex__liufeng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界刘琦①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__liuqi" },
      skins = { "ty__liuqi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界刘表①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__liubiao" },
      skins = { "ty_ex__liubiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界刘谌②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__liuchen" },
      skins = { "ty_ex__liuchen.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界司马朗②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__simalang" },
      skins = { "ty_ex__simalang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界吴懿①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__wuyi" },
      skins = { "ty_ex__wuyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界夏侯霸③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__xiahouba" },
      skins = { "ty__xiahouba.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界孙休③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__sunxiu" },
      skins = { "ty_ex__sunxiu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界张嶷①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__zhangyi" },
      skins = { "ty_ex__zhangyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界张春华②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__zhangchunhua" },
      skins = { "ty_ex__zhangchunhua.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界张松⑥/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__zhangsong" },
      skins = { "ty_ex__zhangsong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界徐庶①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__xushu" },
      skins = { "ty_ex__xushu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界曹休①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__caoxiu" },
      skins = { "ty_ex__caoxiu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界曹真③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__caozhen" },
      skins = { "ty_ex__caozhen.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界朱治⑧/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__zhuzhi" },
      skins = { "ty_ex__zhuzhi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界朱然①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__zhuran" },
      skins = { "ty_ex__zhuran.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界李儒⑤/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__liru" },
      skins = { "ty_ex__liru.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界步练师②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__bulianshi" },
      skins = { "ty_ex__bulianshi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界沮授④/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__jvshou" },
      skins = { "ty_ex__jvshou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界王异①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__wangyi" },
      skins = { "ty_ex__wangyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界简雍①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__jianyong" },
      skins = { "ty_ex__jianyong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界荀攸①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__xunyou" },
      skins = { "ty_ex__xunyou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界诸葛诞④/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__zhugedan" },
      skins = { "ty_ex__zhugedan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界辛宪英①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__xinxianying" },
      skins = { "ty__xinxianying.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界钟会②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__zhonghui" },
      skins = { "ty_ex__zhonghui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界陈宫①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__chengong" },
      skins = { "ty_ex__chengong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界陈群④/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__chenqun" },
      skins = { "ty_ex__chenqun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】界高顺①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__gaoshun" },
      skins = { "ty_ex__gaoshun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】神关羽②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__godguanyu" },
      skins = { "ty__godguanyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】神刘备①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__godliubei" },
      skins = { "ty__godliubei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】神姜维①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "godjiangwei" },
      skins = { "godjiangwei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】神孙权②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__godsunquan" },
      skins = { "ty__godsunquan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】神张角①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "godzhangjiao" },
      skins = { "godzhangjiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】神邓艾①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "goddengai" },
      skins = { "goddengai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】神钟会①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "godzhonghui" },
      skins = { "godzhonghui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】神马超③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "godmachao" },
      skins = { "godmachao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】程昱①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__chengyu" },
      skins = { "ty__chengyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】笮融①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zerong" },
      skins = { "zerong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】管宁②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "guanning" },
      skins = { "guanning.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】羊祜①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__yanghu" },
      skins = { "ty__yanghu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】花鬘⑦/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__huaman" },
      skins = { "ty__huaman.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】苏飞②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__sufei" },
      skins = { "ty__sufei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】荀谌③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__xunchen" },
      skins = { "ty__xunchen.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】莫琼树②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "moqiongshu" },
      skins = { "moqiongshu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】葛玄①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "gexuan" },
      skins = { "gexuan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】董承①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__dongcheng" },
      skins = { "ty__dongcheng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】董白①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__dongbai" },
      skins = { "ty__dongbai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】董贵人①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "dongguiren" },
      skins = { "dongguiren.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】蒋干①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "jianggan" },
      skins = { "jianggan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】薛灵芸①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "xuelingyun" },
      skins = { "xuelingyun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】许贡①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__xugong" },
      skins = { "ty__xugong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】许邵③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__xushao" },
      skins = { "ty__xushao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】许靖③/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__xujing" },
      skins = { "ty__xujing.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】诸葛京①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhugejing" },
      skins = { "zhugejing.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】诸葛尚①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhugeshang" },
      skins = { "zhugeshang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】诸葛果②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__zhugeguo" },
      skins = { "ty__zhugeguo.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】谋曹爽①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tymou__caoshuang" },
      skins = { "tymou__caoshuang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】谋诸葛瑾①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tymou__zhugejin" },
      skins = { "tymou__zhugejin.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】谋陈琳①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "tymou__chenlin" },
      skins = { "tymou__chenlin.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】谯周①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__qiaozhou" },
      skins = { "ty__qiaozhou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】贾充①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__jiachong" },
      skins = { "ty__jiachong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】赵俨①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__zhaoyan" },
      skins = { "ty__zhaoyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】赵嫣①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhaoyanw" },
      skins = { "zhaoyanw.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】赵直①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhaozhi" },
      skins = { "zhaozhi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】赵襄①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__zhaoxiang" },
      skins = { "ty__zhaoxiang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】郑浑①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "zhenghun" },
      skins = { "zhenghun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】郭照①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "guozhao" },
      skins = { "guozhao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】钟繇①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty_ex__zhongyao" },
      skins = { "ty_ex__zhongyao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】阎柔②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "yanrou" },
      skins = { "yanrou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】陆郁生①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "luyusheng" },
      skins = { "luyusheng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】陈式①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "chenshi" },
      skins = { "chenshi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】陈琳①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__chenlin" },
      skins = { "ty__chenlin.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】韩馥②/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "hanfu" },
      skins = { "hanfu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】马伶俐①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "malingli" },
      skins = { "malingli.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】麴义①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__quyi" },
      skins = { "ty__quyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】黄承彦①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "ty__huangchengyan" },
      skins = { "ty__huangchengyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【十周年】黄舞蝶①/packages/tenyear/image/generals",
  content = {
    {
      enabled_generals = { "huangwudie" },
      skins = { "huangwudie.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【小程序】SP蔡文姬①/packages/mini/image/generals",
  content = {
    {
      enabled_generals = { "mini_sp__caiwenji" },
      skins = { "mini_sp__caiwenji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【小程序】极(大乔x小乔)①/packages/mini/image/generals",
  content = {
    {
      enabled_generals = { "miniex__daqiao" },
      skins = { "miniex__daqiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【小程序】极(大乔x小乔)①/packages/mini/image/generals",
  content = {
    {
      enabled_generals = { "miniex__xiaoqiao" },
      skins = { "miniex__xiaoqiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【小程序】极郭嘉①/packages/mini/image/generals",
  content = {
    {
      enabled_generals = { "miniex__guojia" },
      skins = { "miniex__guojia.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【小程序】魏SP姜维⑤/packages/mini/image/generals",
  content = {
    {
      enabled_generals = { "mini_sp__jiangwei" },
      skins = { "mini_sp__jiangwei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】SP司马昭②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_sp__simazhao" },
      skins = { "m_sp__simazhao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】兀突骨①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__wutugu" },
      skins = { "mobile__wutugu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】关银屏②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__guanyinping" },
      skins = { "mobile__guanyinping.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】刘璋①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "liuzhang" },
      skins = { "liuzhang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】势程普②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_shi__chengpu" },
      skins = { "m_shi__chengpu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】势魏延③/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_shi2__weiyan" },
      skins = { "m_shi2__weiyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】势魏延③/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_shi3__weiyan" },
      skins = { "m_shi3__weiyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】势魏延③/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_shi__weiyan" },
      skins = { "m_shi__weiyan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】嵇康②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__jikang" },
      skins = { "mobile__jikang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】庞羲①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "pangxi" },
      skins = { "pangxi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】张琪瑛③/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__zhangqiying" },
      skins = { "mobile__zhangqiying.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】张翼①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "zhiyi" },
      skins = { "zhiyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】徐荣②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__xurong" },
      skins = { "mobile__xurong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】文鸯(吴)②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__wenyang" },
      skins = { "mobile__wenyang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】星徐晃②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mxing__xuhuang" },
      skins = { "mxing__xuhuang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】星甘宁①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mxing__ganning" },
      skins = { "mxing__ganning.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】星黄忠③/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mxing__huangzhong" },
      skins = { "mxing__huangzhong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】曹婴⑤/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__caoying" },
      skins = { "mobile__caoying.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】曹纯⑤/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "caochun" },
      skins = { "caochun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】李丰①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "lifeng" },
      skins = { "lifeng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】杜预④/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__duyu" },
      skins = { "mobile__duyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】杨彪③/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "yangbiao" },
      skins = { "yangbiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】桥公②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "qiaogong" },
      skins = { "qiaogong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】清河公主①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__qinghegongzhu" },
      skins = { "mobile__qinghegongzhu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】灵雎②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__lingju" },
      skins = { "mobile__lingju.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】王元姬⑤/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__wangyuanji" },
      skins = { "mobile__wangyuanji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】界吴懿②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__wuyi" },
      skins = { "m_ex__wuyi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】界周妃④/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__zhoufei" },
      skins = { "m_ex__zhoufei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】界小乔③/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__xiaoqiao" },
      skins = { "m_ex__xiaoqiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】界廖化③/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__liaohua" },
      skins = { "m_ex__liaohua.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】界徐盛④/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__xusheng" },
      skins = { "m_ex__xusheng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】界曹植①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__caozhi" },
      skins = { "m_ex__caozhi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】界朱然⑦/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__zhuran" },
      skins = { "m_ex__zhuran.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】界李儒②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__liru" },
      skins = { "m_ex__liru.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】界步练师⑤/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__bulianshi" },
      skins = { "m_ex__bulianshi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】界蔡文姬②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__caiwenji" },
      skins = { "m_ex__caiwenji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】界郭皇后②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__guohuanghou" },
      skins = { "m_ex__guohuanghou.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】界钟会⑤/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "m_ex__zhonghui" },
      skins = { "m_ex__zhonghui.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】神吕布⑤/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__godlvbu" },
      skins = { "mobile__godlvbu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】神荀彧①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "godxunyu" },
      skins = { "godxunyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】神郭嘉①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "godguojia" },
      skins = { "godguojia.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】神鲁肃①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "godlusu" },
      skins = { "godlusu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】祢衡①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "miheng" },
      skins = { "miheng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】羊徽瑜①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__yanghuiyu" },
      skins = { "mobile__yanghuiyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】胡金定③/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "hujinding" },
      skins = { "hujinding.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】郭女王①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__guozhao" },
      skins = { "mobile__guozhao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】陶谦②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "taoqian" },
      skins = { "taoqian.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】马云騄⑥/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mobile__mayunlu" },
      skins = { "mobile__mayunlu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】马钧②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "majun" },
      skins = { "majun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【手杀】骆统②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "luotong" },
      skins = { "luotong.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【江山如故】合诸葛亮①/packages/jsrg/image/generals",
  content = {
    {
      enabled_generals = { "js__zhugeliang" },
      skins = { "js__zhugeliang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【界限突破】伊籍③/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "yijik" },
      skins = { "yijik.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【界限突破】界关羽⑫/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__guanyu" },
      skins = { "ex__guanyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【界限突破】界司马懿④/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__simayi" },
      skins = { "ex__simayi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【界限突破】界吕布④/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__lvbu" },
      skins = { "ex__lvbu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【界限突破】界周瑜②/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__zhouyu" },
      skins = { "ex__zhouyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【界限突破】界夏侯惇⑪/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__xiahoudun" },
      skins = { "ex__xiahoudun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【界限突破】界大乔㉓/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__daqiao" },
      skins = { "ex__daqiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【界限突破】界孙尚香⑰/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__sunshangxiang" },
      skins = { "ex__sunshangxiang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【界限突破】界张辽④/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__zhangliao" },
      skins = { "ex__zhangliao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【界限突破】界甄姬①/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__zhenji" },
      skins = { "ex__zhenji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【界限突破】界甘宁②/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__ganning" },
      skins = { "ex__ganning.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【界限突破】界诸葛亮③/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__zhugeliang" },
      skins = { "ex__zhugeliang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【界限突破】界貂蝉⑰/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__diaochan" },
      skins = { "ex__diaochan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【界限突破】界郭嘉③/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__guojia" },
      skins = { "ex__guojia.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【界限突破】界陆逊①/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__luxun" },
      skins = { "ex__luxun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【界限突破】界黄月英③/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__huangyueying" },
      skins = { "ex__huangyueying.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【界限突破】界黄盖①/packages/standard_ex/image/generals",
  content = {
    {
      enabled_generals = { "ex__huanggai" },
      skins = { "ex__huanggai.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【神话再临】周妃⑥/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "zhoufei" },
      skins = { "zhoufei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【神话再临】孙亮②/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "sunliang" },
      skins = { "sunliang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【神话再临】张绣⑪/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "zhangxiu" },
      skins = { "zhangxiu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【神话再临】王基④/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "wangji" },
      skins = { "wangji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【神话再临】王平⑩/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "wangping" },
      skins = { "wangping.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【神话再临】神吕布⑥/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "godlvbu" },
      skins = { "godlvbu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【神话再临】神周瑜①/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "godzhouyu" },
      skins = { "godzhouyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【神话再临】神甘宁⑤/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "godganning" },
      skins = { "godganning.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【神话再临】神诸葛③/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "godzhugeliang" },
      skins = { "godzhugeliang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【神话再临】神赵云②/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "godzhaoyun" },
      skins = { "godzhaoyun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【神话再临】神陆逊②/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "godluxun" },
      skins = { "godluxun.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【神话再临】荀彧④/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "xunyu" },
      skins = { "xunyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【神话再临】诸葛瞻⑩/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "zhugezhan" },
      skins = { "zhugezhan.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【神话再临】郝昭①/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "haozhao" },
      skins = { "haozhao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【神话再临】陆抗③/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "lukang" },
      skins = { "lukang.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【神话再临】陆绩①/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "luji" },
      skins = { "luji.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【神话再临】陈到①/packages/shzl/image/generals",
  content = {
    {
      enabled_generals = { "chendao" },
      skins = { "chendao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【线下】势小乔⑧(E)/packages/offline_new/image/generals",
  content = {
    {
      enabled_generals = { "ofl__xiaoqiao" },
      skins = { "ofl__xiaoqiao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【线下】神黄月英①/packages/offline_new/image/generals",
  content = {
    {
      enabled_generals = { "godhuangyueying" },
      skins = { "godhuangyueying.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【谋攻】谋刘备②/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mou__liubei" },
      skins = { "mou__liubei.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【谋攻】谋刘赪①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mou__liucheng" },
      skins = { "mou__liucheng.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【谋攻】谋张辽①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mou__zhangliao" },
      skins = { "mou__zhangliao.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【谋攻】谋曹丕①/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mou__caopi" },
      skins = { "mou__caopi.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【谋攻】谋荀彧⑦/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mou__xunyu" },
      skins = { "mou__xunyu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【谋攻】谋贾诩④/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mou__jiaxu" },
      skins = { "mou__jiaxu.jpg" },
    },
  },
}

extension:addSkinPackage {
  path = "/精选原画/resource/【谋攻】谋郭嘉④/packages/mobile/image/generals",
  content = {
    {
      enabled_generals = { "mou__guojia" },
      skins = { "mou__guojia.jpg" },
    },
  },
}

Fk:loadTranslationTable {
  ["advanced_art_skins"] = "精选原画",
  ["bailingyun.jpg"] = "小弟精选",
  ["bianyue.jpg"] = "小弟精选",
  ["btl__caohua.jpg"] = "小弟精选",
  ["bulianshi.jpg"] = "小弟精选",
  ["buzhi.jpg"] = "小弟精选",
  ["caoang.jpg"] = "小弟精选",
  ["caochong.jpg"] = "小弟精选",
  ["caochun.jpg"] = "小弟精选",
  ["caofang.jpg"] = "小弟精选",
  ["caohong.jpg"] = "小弟精选",
  ["caohua.jpg"] = "小弟精选",
  ["caojinyu.jpg"] = "小弟精选",
  ["caomao.jpg"] = "小弟精选",
  ["caopi.jpg"] = "小弟精选",
  ["caorui.jpg"] = "小弟精选",
  ["caoxian.jpg"] = "小弟精选",
  ["caoxiancaohua.jpg"] = "小弟精选",
  ["caoxing.jpg"] = "小弟精选",
  ["caoying.jpg"] = "小弟精选",
  ["chendao.jpg"] = "小弟精选",
  ["chengui.jpg"] = "小弟精选",
  ["chengyu.jpg"] = "小弟精选",
  ["chenlin.jpg"] = "小弟精选",
  ["chenshi.jpg"] = "小弟精选",
  ["cuilingyi.jpg"] = "小弟精选",
  ["dingfuren.jpg"] = "小弟精选",
  ["dongbai.jpg"] = "小弟精选",
  ["dongguiren.jpg"] = "小弟精选",
  ["dongyun.jpg"] = "小弟精选",
  ["duanwei.jpg"] = "小弟精选",
  ["dufuren.jpg"] = "小弟精选",
  ["dukui.jpg"] = "小弟精选",
  ["ex__daqiao.jpg"] = "小弟精选",
  ["ex__diaochan.jpg"] = "小弟精选",
  ["ex__ganning.jpg"] = "小弟精选",
  ["ex__guanyu.jpg"] = "小弟精选",
  ["ex__guojia.jpg"] = "小弟精选",
  ["ex__huanggai.jpg"] = "小弟精选",
  ["ex__huangyueying.jpg"] = "小弟精选",
  ["ex__luxun.jpg"] = "小弟精选",
  ["ex__lvbu.jpg"] = "小弟精选",
  ["ex__simayi.jpg"] = "小弟精选",
  ["ex__sunshangxiang.jpg"] = "小弟精选",
  ["ex__xiahoudun.jpg"] = "小弟精选",
  ["ex__zhangliao.jpg"] = "小弟精选",
  ["ex__zhenji.jpg"] = "小弟精选",
  ["ex__zhouyu.jpg"] = "小弟精选",
  ["ex__zhugeliang.jpg"] = "小弟精选",
  ["fanyufeng.jpg"] = "小弟精选",
  ["ganfurenmifuren.jpg"] = "小弟精选",
  ["gexuan.jpg"] = "小弟精选",
  ["goddengai.jpg"] = "小弟精选",
  ["goddianwei.jpg"] = "小弟精选",
  ["godganning.jpg"] = "小弟精选",
  ["godguojia.jpg"] = "小弟精选",
  ["godhuangyueying.jpg"] = "小弟精选",
  ["godhuangzhong.jpg"] = "小弟精选",
  ["godjiangwei.jpg"] = "小弟精选",
  ["godlusu.jpg"] = "小弟精选",
  ["godluxun.jpg"] = "小弟精选",
  ["godlvbu.jpg"] = "小弟精选",
  ["godmachao.jpg"] = "小弟精选",
  ["godpangtong.jpg"] = "小弟精选",
  ["godxunyu.jpg"] = "小弟精选",
  ["godzhangfei.jpg"] = "小弟精选",
  ["godzhangjiao.jpg"] = "小弟精选",
  ["godzhaoyun.jpg"] = "小弟精选",
  ["godzhonghui.jpg"] = "小弟精选",
  ["godzhouyu.jpg"] = "小弟精选",
  ["godzhugeliang.jpg"] = "小弟精选",
  ["gongsundu.jpg"] = "小弟精选",
  ["guanning.jpg"] = "小弟精选",
  ["guannings.jpg"] = "小弟精选",
  ["guanping.jpg"] = "小弟精选",
  ["guohuaij.jpg"] = "小弟精选",
  ["guotupangji.jpg"] = "小弟精选",
  ["guozhao.jpg"] = "小弟精选",
  ["hanfu.jpg"] = "小弟精选",
  ["haozhao.jpg"] = "小弟精选",
  ["heyan.jpg"] = "小弟精选",
  ["himiko.jpg"] = "小弟精选",
  ["huangwudie.jpg"] = "小弟精选",
  ["hujinding.jpg"] = "小弟精选",
  ["jianggan.jpg"] = "小弟精选",
  ["js__zhugeliang.jpg"] = "小弟精选",
  ["jsp__jiangwei.jpg"] = "小弟精选",
  ["kbtl_sp__machao.jpg"] = "小弟精选",
  ["kbtl_sp__pangtong.jpg"] = "小弟精选",
  ["king_btl__bulianshi.jpg"] = "小弟精选",
  ["king_btl__buzhi.jpg"] = "小弟精选",
  ["king_btl__caifuren.jpg"] = "小弟精选",
  ["king_btl__caoang.jpg"] = "小弟精选",
  ["king_btl__caocao.jpg"] = "小弟精选",
  ["king_btl__caoren.jpg"] = "小弟精选",
  ["king_btl__caorui.jpg"] = "小弟精选",
  ["king_btl__chengong.jpg"] = "小弟精选",
  ["king_btl__chenqun.jpg"] = "小弟精选",
  ["king_btl__cuiyan.jpg"] = "小弟精选",
  ["king_btl__daqiao.jpg"] = "小弟精选",
  ["king_btl__dengai.jpg"] = "小弟精选",
  ["king_btl__dianwei.jpg"] = "小弟精选",
  ["king_btl__diaochan.jpg"] = "小弟精选",
  ["king_btl__dingyuan.jpg"] = "小弟精选",
  ["king_btl__fazheng.jpg"] = "小弟精选",
  ["king_btl__gaoshun.jpg"] = "小弟精选",
  ["king_btl__gongsunyuan.jpg"] = "小弟精选",
  ["king_btl__guanxingzhangbao.jpg"] = "小弟精选",
  ["king_btl__guanyinping.jpg"] = "小弟精选",
  ["king_btl__guanyu.jpg"] = "小弟精选",
  ["king_btl__guojia.jpg"] = "小弟精选",
  ["king_btl__guotupangji.jpg"] = "小弟精选",
  ["king_btl__haozhao.jpg"] = "小弟精选",
  ["king_btl__huanggai.jpg"] = "小弟精选",
  ["king_btl__huangquan.jpg"] = "小弟精选",
  ["king_btl__huaxiong.jpg"] = "小弟精选",
  ["king_btl__jianggan.jpg"] = "小弟精选",
  ["king_btl__jiangwei.jpg"] = "小弟精选",
  ["king_btl__jiaxu.jpg"] = "小弟精选",
  ["king_btl__jvshou.jpg"] = "小弟精选",
  ["king_btl__lidian.jpg"] = "小弟精选",
  ["king_btl__lingtong.jpg"] = "小弟精选",
  ["king_btl__liushan.jpg"] = "小弟精选",
  ["king_btl__liuxie.jpg"] = "小弟精选",
  ["king_btl__lusu.jpg"] = "小弟精选",
  ["king_btl__luxun.jpg"] = "小弟精选",
  ["king_btl__luzhiw.jpg"] = "小弟精选",
  ["king_btl__machao.jpg"] = "小弟精选",
  ["king_btl__mateng.jpg"] = "小弟精选",
  ["king_btl__mizhu.jpg"] = "小弟精选",
  ["king_btl__panfeng.jpg"] = "小弟精选",
  ["king_btl__qinmi.jpg"] = "小弟精选",
  ["king_btl__quyi.jpg"] = "小弟精选",
  ["king_btl__shamoke.jpg"] = "小弟精选",
  ["king_btl__simayi.jpg"] = "小弟精选",
  ["king_btl__sundeng.jpg"] = "小弟精选",
  ["king_btl__sunhao.jpg"] = "小弟精选",
  ["king_btl__sunquan.jpg"] = "小弟精选",
  ["king_btl__sunshangxiang.jpg"] = "小弟精选",
  ["king_btl__taishici.jpg"] = "小弟精选",
  ["king_btl__wangji.jpg"] = "小弟精选",
  ["king_btl__wangping.jpg"] = "小弟精选",
  ["king_btl__weiyan.jpg"] = "小弟精选",
  ["king_btl__wenyang.jpg"] = "小弟精选",
  ["king_btl__wolong.jpg"] = "小弟精选",
  ["king_btl__wuyi.jpg"] = "小弟精选",
  ["king_btl__xiahoushi.jpg"] = "小弟精选",
  ["king_btl__xiahouyuan.jpg"] = "小弟精选",
  ["king_btl__xingcai.jpg"] = "小弟精选",
  ["king_btl__xuhuang.jpg"] = "小弟精选",
  ["king_btl__xunyou.jpg"] = "小弟精选",
  ["king_btl__xunyu.jpg"] = "小弟精选",
  ["king_btl__xusheng.jpg"] = "小弟精选",
  ["king_btl__xuyou.jpg"] = "小弟精选",
  ["king_btl__yanliangwenchou.jpg"] = "小弟精选",
  ["king_btl__yanrou.jpg"] = "小弟精选",
  ["king_btl__yujin.jpg"] = "小弟精选",
  ["king_btl__zhangchunhua.jpg"] = "小弟精选",
  ["king_btl__zhangliao.jpg"] = "小弟精选",
  ["king_btl__zhangyiy.jpg"] = "小弟精选",
  ["king_btl__zhaoyun.jpg"] = "小弟精选",
  ["king_btl__zhongyao.jpg"] = "小弟精选",
  ["king_btl__zhoufang.jpg"] = "小弟精选",
  ["king_btl__zhugejin.jpg"] = "小弟精选",
  ["king_btl__zhugeke.jpg"] = "小弟精选",
  ["king_btl__zhugeliang.jpg"] = "小弟精选",
  ["king_btl__zhugezhan.jpg"] = "小弟精选",
  ["king_btl__zhuhuan.jpg"] = "小弟精选",
  ["king_btl__zhuran.jpg"] = "小弟精选",
  ["king_btl__zhurong.jpg"] = "小弟精选",
  ["kongshu.jpg"] = "小弟精选",
  ["kuaiqi.jpg"] = "小弟精选",
  ["laiyinger.jpg"] = "小弟精选",
  ["liangxing.jpg"] = "小弟精选",
  ["lifeng.jpg"] = "小弟精选",
  ["lijue.jpg"] = "小弟精选",
  ["liubian.jpg"] = "小弟精选",
  ["liuchen.jpg"] = "小弟精选",
  ["liujinliupei.jpg"] = "小弟精选",
  ["liuqi.jpg"] = "小弟精选",
  ["liutan.jpg"] = "小弟精选",
  ["liuxie.jpg"] = "小弟精选",
  ["liuyan.jpg"] = "小弟精选",
  ["liuyong.jpg"] = "小弟精选",
  ["liuzhang.jpg"] = "小弟精选",
  ["liyans.jpg"] = "小弟精选",
  ["longwang.jpg"] = "小弟精选",
  ["luji.jpg"] = "小弟精选",
  ["lukang.jpg"] = "小弟精选",
  ["luotong.jpg"] = "小弟精选",
  ["lushi.jpg"] = "小弟精选",
  ["lusu.jpg"] = "小弟精选",
  ["luyi.jpg"] = "小弟精选",
  ["luyusheng.jpg"] = "小弟精选",
  ["luzhiw.jpg"] = "小弟精选",
  ["lvboshe.jpg"] = "小弟精选",
  ["lvlingqi.jpg"] = "小弟精选",
  ["m_ex__bulianshi.jpg"] = "小弟精选",
  ["m_ex__caiwenji.jpg"] = "小弟精选",
  ["m_ex__caozhi.jpg"] = "小弟精选",
  ["m_ex__guohuanghou.jpg"] = "小弟精选",
  ["m_ex__liaohua.jpg"] = "小弟精选",
  ["m_ex__liru.jpg"] = "小弟精选",
  ["m_ex__wuyi.jpg"] = "小弟精选",
  ["m_ex__xiaoqiao.jpg"] = "小弟精选",
  ["m_ex__xusheng.jpg"] = "小弟精选",
  ["m_ex__zhonghui.jpg"] = "小弟精选",
  ["m_ex__zhoufei.jpg"] = "小弟精选",
  ["m_ex__zhuran.jpg"] = "小弟精选",
  ["m_shi2__weiyan.jpg"] = "小弟精选",
  ["m_shi3__weiyan.jpg"] = "小弟精选",
  ["m_shi__chengpu.jpg"] = "小弟精选",
  ["m_shi__weiyan.jpg"] = "小弟精选",
  ["m_sp__simazhao.jpg"] = "小弟精选",
  ["majun.jpg"] = "小弟精选",
  ["malingli.jpg"] = "小弟精选",
  ["manchong.jpg"] = "小弟精选",
  ["mayunlu.jpg"] = "小弟精选",
  ["miheng.jpg"] = "小弟精选",
  ["mini__zhangxingcai.jpg"] = "小弟精选",
  ["mini_sp__caiwenji.jpg"] = "小弟精选",
  ["mini_sp__jiangwei.jpg"] = "小弟精选",
  ["miniex__daqiao.jpg"] = "小弟精选",
  ["miniex__guojia.jpg"] = "小弟精选",
  ["miniex__xiaoqiao.jpg"] = "小弟精选",
  ["mizhu.jpg"] = "小弟精选",
  ["mobile__caomao.jpg"] = "小弟精选",
  ["mobile__caoying.jpg"] = "小弟精选",
  ["mobile__duyu.jpg"] = "小弟精选",
  ["mobile__godlvbu.jpg"] = "小弟精选",
  ["mobile__guanyinping.jpg"] = "小弟精选",
  ["mobile__guozhao.jpg"] = "小弟精选",
  ["mobile__jikang.jpg"] = "小弟精选",
  ["mobile__lingju.jpg"] = "小弟精选",
  ["mobile__mayunlu.jpg"] = "小弟精选",
  ["mobile__qinghegongzhu.jpg"] = "小弟精选",
  ["mobile__wangyuanji.jpg"] = "小弟精选",
  ["mobile__wenyang.jpg"] = "小弟精选",
  ["mobile__wutugu.jpg"] = "小弟精选",
  ["mobile__xurong.jpg"] = "小弟精选",
  ["mobile__yanghuiyu.jpg"] = "小弟精选",
  ["mobile__zhangqiying.jpg"] = "小弟精选",
  ["moqiongshu.jpg"] = "小弟精选",
  ["mou__caopi.jpg"] = "小弟精选",
  ["mou__guojia.jpg"] = "小弟精选",
  ["mou__jiaxu.jpg"] = "小弟精选",
  ["mou__liubei.jpg"] = "小弟精选",
  ["mou__liucheng.jpg"] = "小弟精选",
  ["mou__xunyu.jpg"] = "小弟精选",
  ["mou__zhangliao.jpg"] = "小弟精选",
  ["mu__caiwenji.jpg"] = "小弟精选",
  ["mu__caozhi.jpg"] = "小弟精选",
  ["mu__daqiao.jpg"] = "小弟精选",
  ["mu__diaochan.jpg"] = "小弟精选",
  ["mu__miheng.jpg"] = "小弟精选",
  ["mu__xiaoqiao.jpg"] = "小弟精选",
  ["mu__zhugeguo.jpg"] = "小弟精选",
  ["mu__zoushi.jpg"] = "小弟精选",
  ["mxing__ganning.jpg"] = "小弟精选",
  ["mxing__huangzhong.jpg"] = "小弟精选",
  ["mxing__xuhuang.jpg"] = "小弟精选",
  ["nos__wangyi.jpg"] = "小弟精选",
  ["ofl__xiaoqiao.jpg"] = "小弟精选",
  ["ol__baosanniang.jpg"] = "小弟精选",
  ["ol__bianfuren.jpg"] = "小弟精选",
  ["ol__caochun.jpg"] = "小弟精选",
  ["ol__caojinyu.jpg"] = "小弟精选",
  ["ol__caoren.jpg"] = "小弟精选",
  ["ol__chendeng.jpg"] = "小弟精选",
  ["ol__dengzhi.jpg"] = "小弟精选",
  ["ol__dingfuren.jpg"] = "小弟精选",
  ["ol__dongxie.jpg"] = "小弟精选",
  ["ol__dongzhao.jpg"] = "小弟精选",
  ["ol__duyu.jpg"] = "小弟精选",
  ["ol__feiyi.jpg"] = "小弟精选",
  ["ol__fengfangnv.jpg"] = "小弟精选",
  ["ol__godcaocao.jpg"] = "小弟精选",
  ["ol__guansuo.jpg"] = "小弟精选",
  ["ol__guozhao.jpg"] = "小弟精选",
  ["ol__hetaihou.jpg"] = "小弟精选",
  ["ol__huangquan.jpg"] = "小弟精选",
  ["ol__hujinding.jpg"] = "小弟精选",
  ["ol__jiachong.jpg"] = "小弟精选",
  ["ol__jiangwan.jpg"] = "小弟精选",
  ["ol__jikang.jpg"] = "小弟精选",
  ["ol__liwan.jpg"] = "小弟精选",
  ["ol__lvlingqi.jpg"] = "小弟精选",
  ["ol__niufu.jpg"] = "小弟精选",
  ["ol__niujin.jpg"] = "小弟精选",
  ["ol__simashi.jpg"] = "小弟精选",
  ["ol__sufei.jpg"] = "小弟精选",
  ["ol__sunhao.jpg"] = "小弟精选",
  ["ol__sunliang.jpg"] = "小弟精选",
  ["ol__sunluyu.jpg"] = "小弟精选",
  ["ol__sunru.jpg"] = "小弟精选",
  ["ol__tengfanglan.jpg"] = "小弟精选",
  ["ol__wanglang.jpg"] = "小弟精选",
  ["ol__wangyuanji.jpg"] = "小弟精选",
  ["ol__xingcai.jpg"] = "小弟精选",
  ["ol__xuelingyun.jpg"] = "小弟精选",
  ["ol__xujing.jpg"] = "小弟精选",
  ["ol__xunchen.jpg"] = "小弟精选",
  ["ol__yanghu.jpg"] = "小弟精选",
  ["ol__yanghuiyu.jpg"] = "小弟精选",
  ["ol__yangwan.jpg"] = "小弟精选",
  ["ol__yangyi.jpg"] = "小弟精选",
  ["ol__yuanji.jpg"] = "小弟精选",
  ["ol__zhangchangpu.jpg"] = "小弟精选",
  ["ol__zhangqiying.jpg"] = "小弟精选",
  ["ol__zhouchu.jpg"] = "小弟精选",
  ["ol__zhoufei.jpg"] = "小弟精选",
  ["ol__zhoutai.jpg"] = "小弟精选",
  ["ol__zhugedan.jpg"] = "小弟精选",
  ["ol__zhugeguo.jpg"] = "小弟精选",
  ["ol__zhugejin.jpg"] = "小弟精选",
  ["ol_evil__caocao.jpg"] = "小弟精选",
  ["ol_evil__diaochan.jpg"] = "小弟精选",
  ["ol_evil__lvbu.jpg"] = "小弟精选",
  ["ol_evil__simayi.jpg"] = "小弟精选",
  ["ol_evil__zhangfei.jpg"] = "小弟精选",
  ["ol_ex__caifuren.jpg"] = "小弟精选",
  ["ol_ex__caiwenji.jpg"] = "小弟精选",
  ["ol_ex__caocao.jpg"] = "小弟精选",
  ["ol_ex__caochong.jpg"] = "小弟精选",
  ["ol_ex__caojie.jpg"] = "小弟精选",
  ["ol_ex__dengai.jpg"] = "小弟精选",
  ["ol_ex__dianwei.jpg"] = "小弟精选",
  ["ol_ex__dongzhuo.jpg"] = "小弟精选",
  ["ol_ex__fazheng.jpg"] = "小弟精选",
  ["ol_ex__fuhuanghou.jpg"] = "小弟精选",
  ["ol_ex__gaoshun.jpg"] = "小弟精选",
  ["ol_ex__guohuanghou.jpg"] = "小弟精选",
  ["ol_ex__huangzhong.jpg"] = "小弟精选",
  ["ol_ex__huaxiong.jpg"] = "小弟精选",
  ["ol_ex__jiangwei.jpg"] = "小弟精选",
  ["ol_ex__jiaxu.jpg"] = "小弟精选",
  ["ol_ex__lidian.jpg"] = "小弟精选",
  ["ol_ex__liru.jpg"] = "小弟精选",
  ["ol_ex__liubei.jpg"] = "小弟精选",
  ["ol_ex__liushan.jpg"] = "小弟精选",
  ["ol_ex__lusu.jpg"] = "小弟精选",
  ["ol_ex__lvmeng.jpg"] = "小弟精选",
  ["ol_ex__pangde.jpg"] = "小弟精选",
  ["ol_ex__sunce.jpg"] = "小弟精选",
  ["ol_ex__sunluban.jpg"] = "小弟精选",
  ["ol_ex__taishici.jpg"] = "小弟精选",
  ["ol_ex__wangyi.jpg"] = "小弟精选",
  ["ol_ex__weiyan.jpg"] = "小弟精选",
  ["ol_ex__wolong.jpg"] = "小弟精选",
  ["ol_ex__wuguotai.jpg"] = "小弟精选",
  ["ol_ex__xiahouyuan.jpg"] = "小弟精选",
  ["ol_ex__xiaoqiao.jpg"] = "小弟精选",
  ["ol_ex__xinxianying.jpg"] = "小弟精选",
  ["ol_ex__xuhuang.jpg"] = "小弟精选",
  ["ol_ex__xunyu.jpg"] = "小弟精选",
  ["ol_ex__xusheng.jpg"] = "小弟精选",
  ["ol_ex__yuanshao.jpg"] = "小弟精选",
  ["ol_ex__yuji.jpg"] = "小弟精选",
  ["ol_ex__zhangchunhua.jpg"] = "小弟精选",
  ["ol_ex__zhangjiao.jpg"] = "小弟精选",
  ["ol_ex__zhaoyun.jpg"] = "小弟精选",
  ["ol_ex__zhonghui.jpg"] = "小弟精选",
  ["ol_ex__zhuhuan.jpg"] = "小弟精选",
  ["ol_ex__zhurong.jpg"] = "小弟精选",
  ["ol_ex__zuoci.jpg"] = "小弟精选",
  ["ol_sp__caocao.jpg"] = "小弟精选",
  ["ol_sp__caoren.jpg"] = "小弟精选",
  ["ol_sp__huangyueying.jpg"] = "小弟精选",
  ["ol_sp__jiaxu.jpg"] = "小弟精选",
  ["ol_sp__machao.jpg"] = "小弟精选",
  ["ol_sp__zhanghe.jpg"] = "小弟精选",
  ["olmou__jiangwei.jpg"] = "小弟精选",
  ["olmou__pangtong.jpg"] = "小弟精选",
  ["olz__wanghun.jpg"] = "小弟精选",
  ["olz__wangling.jpg"] = "小弟精选",
  ["olz__wuxian.jpg"] = "小弟精选",
  ["olz__xunshu.jpg"] = "小弟精选",
  ["olz__yangxiu.jpg"] = "小弟精选",
  ["olz__zhonghui.jpg"] = "小弟精选",
  ["olz__zhongyan.jpg"] = "小弟精选",
  ["pangxi.jpg"] = "小弟精选",
  ["panjun.jpg"] = "小弟精选",
  ["qiaogong.jpg"] = "小弟精选",
  ["qinghegongzhu.jpg"] = "小弟精选",
  ["qinmi.jpg"] = "小弟精选",
  ["quanhuijie.jpg"] = "小弟精选",
  ["renwan.jpg"] = "小弟精选",
  ["ruiji.jpg"] = "小弟精选",
  ["shamoke.jpg"] = "小弟精选",
  ["shibao.jpg"] = "小弟精选",
  ["shiyi.jpg"] = "小弟精选",
  ["simahui.jpg"] = "小弟精选",
  ["sp__caiwenji.jpg"] = "小弟精选",
  ["sp__pangtong.jpg"] = "小弟精选",
  ["starsp__diaochan.jpg"] = "小弟精选",
  ["starsp__zhaoyun.jpg"] = "小弟精选",
  ["sunchen.jpg"] = "小弟精选",
  ["sundeng.jpg"] = "小弟精选",
  ["sunli.jpg"] = "小弟精选",
  ["sunliang.jpg"] = "小弟精选",
  ["sunlingluan.jpg"] = "小弟精选",
  ["sunqian.jpg"] = "小弟精选",
  ["sunziliufang.jpg"] = "小弟精选",
  ["tadun.jpg"] = "小弟精选",
  ["tangji.jpg"] = "小弟精选",
  ["taoqian.jpg"] = "小弟精选",
  ["tenggongzhu.jpg"] = "小弟精选",
  ["ty__baosanniang.jpg"] = "小弟精选",
  ["ty__caochun.jpg"] = "小弟精选",
  ["ty__chengyu.jpg"] = "小弟精选",
  ["ty__chenlin.jpg"] = "小弟精选",
  ["ty__daqiaoxiaoqiao.jpg"] = "小弟精选",
  ["ty__dingyuan.jpg"] = "小弟精选",
  ["ty__dongbai.jpg"] = "小弟精选",
  ["ty__dongcheng.jpg"] = "小弟精选",
  ["ty__fengfangnv.jpg"] = "小弟精选",
  ["ty__ganfuren.jpg"] = "小弟精选",
  ["ty__godguanyu.jpg"] = "小弟精选",
  ["ty__godliubei.jpg"] = "小弟精选",
  ["ty__godsunquan.jpg"] = "小弟精选",
  ["ty__guansuo.jpg"] = "小弟精选",
  ["ty__huaman.jpg"] = "小弟精选",
  ["ty__huangchengyan.jpg"] = "小弟精选",
  ["ty__jiachong.jpg"] = "小弟精选",
  ["ty__lidian.jpg"] = "小弟精选",
  ["ty__lingju.jpg"] = "小弟精选",
  ["ty__liuba.jpg"] = "小弟精选",
  ["ty__liuhong.jpg"] = "小弟精选",
  ["ty__liuqi.jpg"] = "小弟精选",
  ["ty__liuye.jpg"] = "小弟精选",
  ["ty__mifuren.jpg"] = "小弟精选",
  ["ty__nanhualaoxian.jpg"] = "小弟精选",
  ["ty__pangdegong.jpg"] = "小弟精选",
  ["ty__panshu.jpg"] = "小弟精选",
  ["ty__puyuan.jpg"] = "小弟精选",
  ["ty__qiaozhou.jpg"] = "小弟精选",
  ["ty__quyi.jpg"] = "小弟精选",
  ["ty__simafu.jpg"] = "小弟精选",
  ["ty__sufei.jpg"] = "小弟精选",
  ["ty__sunluyu.jpg"] = "小弟精选",
  ["ty__tangzi.jpg"] = "小弟精选",
  ["ty__tianfeng.jpg"] = "小弟精选",
  ["ty__wangchang.jpg"] = "小弟精选",
  ["ty__wangrongh.jpg"] = "小弟精选",
  ["ty__wutugu.jpg"] = "小弟精选",
  ["ty__xiahouba.jpg"] = "小弟精选",
  ["ty__xiahouhui.jpg"] = "小弟精选",
  ["ty__xinxianying.jpg"] = "小弟精选",
  ["ty__xuangongzhu.jpg"] = "小弟精选",
  ["ty__xugong.jpg"] = "小弟精选",
  ["ty__xujing.jpg"] = "小弟精选",
  ["ty__xunchen.jpg"] = "小弟精选",
  ["ty__xushao.jpg"] = "小弟精选",
  ["ty__yanghu.jpg"] = "小弟精选",
  ["ty__yuejin.jpg"] = "小弟精选",
  ["ty__zhangchangpu.jpg"] = "小弟精选",
  ["ty__zhangrang.jpg"] = "小弟精选",
  ["ty__zhaoxiang.jpg"] = "小弟精选",
  ["ty__zhaoyan.jpg"] = "小弟精选",
  ["ty__zhugeguo.jpg"] = "小弟精选",
  ["ty_ex__bulianshi.jpg"] = "小弟精选",
  ["ty_ex__caorui.jpg"] = "小弟精选",
  ["ty_ex__caoxiu.jpg"] = "小弟精选",
  ["ty_ex__caozhen.jpg"] = "小弟精选",
  ["ty_ex__chengong.jpg"] = "小弟精选",
  ["ty_ex__chenqun.jpg"] = "小弟精选",
  ["ty_ex__fuhuanghou.jpg"] = "小弟精选",
  ["ty_ex__gaoshun.jpg"] = "小弟精选",
  ["ty_ex__gongsunyuan.jpg"] = "小弟精选",
  ["ty_ex__guanping.jpg"] = "小弟精选",
  ["ty_ex__guohuanghou.jpg"] = "小弟精选",
  ["ty_ex__huangyueying.jpg"] = "小弟精选",
  ["ty_ex__jianyong.jpg"] = "小弟精选",
  ["ty_ex__jvshou.jpg"] = "小弟精选",
  ["ty_ex__lingtong.jpg"] = "小弟精选",
  ["ty_ex__liru.jpg"] = "小弟精选",
  ["ty_ex__liubiao.jpg"] = "小弟精选",
  ["ty_ex__liuchen.jpg"] = "小弟精选",
  ["ty_ex__liufeng.jpg"] = "小弟精选",
  ["ty_ex__simalang.jpg"] = "小弟精选",
  ["ty_ex__sunluban.jpg"] = "小弟精选",
  ["ty_ex__sunxiu.jpg"] = "小弟精选",
  ["ty_ex__taishici.jpg"] = "小弟精选",
  ["ty_ex__wangyi.jpg"] = "小弟精选",
  ["ty_ex__wuyi.jpg"] = "小弟精选",
  ["ty_ex__xiahoushi.jpg"] = "小弟精选",
  ["ty_ex__xunyou.jpg"] = "小弟精选",
  ["ty_ex__xushu.jpg"] = "小弟精选",
  ["ty_ex__yujin.jpg"] = "小弟精选",
  ["ty_ex__zhangchunhua.jpg"] = "小弟精选",
  ["ty_ex__zhangsong.jpg"] = "小弟精选",
  ["ty_ex__zhangyi.jpg"] = "小弟精选",
  ["ty_ex__zhonghui.jpg"] = "小弟精选",
  ["ty_ex__zhongyao.jpg"] = "小弟精选",
  ["ty_ex__zhugedan.jpg"] = "小弟精选",
  ["ty_ex__zhuran.jpg"] = "小弟精选",
  ["ty_ex__zhuzhi.jpg"] = "小弟精选",
  ["ty_sp__guanyu.jpg"] = "小弟精选",
  ["ty_sp__zhaoyun.jpg"] = "小弟精选",
  ["ty_sp__zhenji.jpg"] = "小弟精选",
  ["ty_wei__caopi.jpg"] = "小弟精选",
  ["ty_wei__dongzhuo.jpg"] = "小弟精选",
  ["ty_wei__guanyinping.jpg"] = "小弟精选",
  ["ty_wei__liubei.jpg"] = "小弟精选",
  ["ty_wei__lvbu.jpg"] = "小弟精选",
  ["ty_wei__sunshangxiang.jpg"] = "小弟精选",
  ["ty_wei__xingcai.jpg"] = "小弟精选",
  ["ty_wei__zhangliao.jpg"] = "小弟精选",
  ["tymou__caoshuang.jpg"] = "小弟精选",
  ["tymou__chenlin.jpg"] = "小弟精选",
  ["tymou__dengai.jpg"] = "小弟精选",
  ["tymou__huanggai.jpg"] = "小弟精选",
  ["tymou__luotong.jpg"] = "小弟精选",
  ["tymou__simashi.jpg"] = "小弟精选",
  ["tymou__zhugejin.jpg"] = "小弟精选",
  ["tystar__caoren.jpg"] = "小弟精选",
  ["tystar__dongzhuo.jpg"] = "小弟精选",
  ["tystar__sunjian.jpg"] = "小弟精选",
  ["tystar__sunshangxiang.jpg"] = "小弟精选",
  ["tystar__xunyu.jpg"] = "小弟精选",
  ["tystar__yuanshao.jpg"] = "小弟精选",
  ["wangji.jpg"] = "小弟精选",
  ["wangping.jpg"] = "小弟精选",
  ["wangrongh.jpg"] = "小弟精选",
  ["wangshuang.jpg"] = "小弟精选",
  ["wangtao.jpg"] = "小弟精选",
  ["wangyi.jpg"] = "小弟精选",
  ["wangyues.jpg"] = "小弟精选",
  ["wanniangongzhu.jpg"] = "小弟精选",
  ["weiguan.jpg"] = "小弟精选",
  ["weizi.jpg"] = "小弟精选",
  ["wenyang.jpg"] = "小弟精选",
  ["wolongfengchu.jpg"] = "小弟精选",
  ["wuxian.jpg"] = "小弟精选",
  ["xiahouhui.jpg"] = "小弟精选",
  ["xiahoujie.jpg"] = "小弟精选",
  ["xiahoulingnv.jpg"] = "小弟精选",
  ["xiahouxuan.jpg"] = "小弟精选",
  ["xizhicai.jpg"] = "小弟精选",
  ["xuangongzhu.jpg"] = "小弟精选",
  ["xuelingyun.jpg"] = "小弟精选",
  ["xunyu.jpg"] = "小弟精选",
  ["xurong.jpg"] = "小弟精选",
  ["xushi.jpg"] = "小弟精选",
  ["xushu.jpg"] = "小弟精选",
  ["xuyou.jpg"] = "小弟精选",
  ["yanfuren.jpg"] = "小弟精选",
  ["yangbiao.jpg"] = "小弟精选",
  ["yangxiu.jpg"] = "小弟精选",
  ["yangyan.jpg"] = "小弟精选",
  ["yangzhi.jpg"] = "小弟精选",
  ["yanjun.jpg"] = "小弟精选",
  ["yanrou.jpg"] = "小弟精选",
  ["yijik.jpg"] = "小弟精选",
  ["yuechen.jpg"] = "小弟精选",
  ["zerong.jpg"] = "小弟精选",
  ["zhanghuyuechen.jpg"] = "小弟精选",
  ["zhangling.jpg"] = "小弟精选",
  ["zhanglu.jpg"] = "小弟精选",
  ["zhangqiying.jpg"] = "小弟精选",
  ["zhangrang.jpg"] = "小弟精选",
  ["zhangxiu.jpg"] = "小弟精选",
  ["zhangyao.jpg"] = "小弟精选",
  ["zhangzhi.jpg"] = "小弟精选",
  ["zhaoyan.jpg"] = "小弟精选",
  ["zhaoyanw.jpg"] = "小弟精选",
  ["zhaozhi.jpg"] = "小弟精选",
  ["zhenghun.jpg"] = "小弟精选",
  ["zhiyi.jpg"] = "小弟精选",
  ["zhongyan.jpg"] = "小弟精选",
  ["zhongyao.jpg"] = "小弟精选",
  ["zhoufang.jpg"] = "小弟精选",
  ["zhoufei.jpg"] = "小弟精选",
  ["zhoushan.jpg"] = "小弟精选",
  ["zhouxuan.jpg"] = "小弟精选",
  ["dream_zhouxuan.jpg"] = "大梦仙尊",
  ["zhugejing.jpg"] = "小弟精选",
  ["zhugeke.jpg"] = "小弟精选",
  ["zhugemengxue.jpg"] = "小弟精选",
  ["zhugeruoxue.jpg"] = "小弟精选",
  ["zhugeshang.jpg"] = "小弟精选",
  ["zhugezhan.jpg"] = "小弟精选",
  ["zhupeilan.jpg"] = "小弟精选",
  ["zhuzhi.jpg"] = "小弟精选",
  ["zuofen.jpg"] = "小弟精选",
}

return extension
