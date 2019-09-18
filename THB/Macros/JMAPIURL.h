//
//  JMAPIURL.h
//  THB
//
//  Created by jimmy on 2017/5/4.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 首页
 */
/** 1首页数据 */
extern NSString* const _api_home;

/**1.1 跑马灯 **/
extern NSString* const _api_home_marqueeApi;

/** 1.5商城返利幻灯片 */
extern NSString* const _api_home_rebatebanner;
/**3.1 幻灯片 */
extern NSString* const _api_home_getSlides;
/**3.2 首页快速入口 */
extern NSString* const _api_home_getIcon;
/**3.3首页分类导航 */
extern NSString* const _api_home_getCates;
/**3.4首页商品（1.2店铺详情商品） */
extern NSString* const _api_home_getGoods;
/**3.5首页商品弹框(新)*/
extern NSString* const _api_home_proGoods;
// 3.6首页中间图文（新）
extern NSString* const _api_home_gettuwen;
//3.7首页海报图（新）
extern NSString* const _api_home_getpic;
extern NSString* const _api_home_getType;
extern NSString* const _api_Newhome_getGoods ;
extern NSString* const _api_Newhome_getCates ;
extern NSString* const _api_home_productdetailtool;
extern NSString* const _home_api_invitedText;
extern NSString* const _home_api_invitefriend ;

extern NSString* const _api_home_recommendproduct;
/** 省**/
extern NSString* const _api_home_getProvince;
/** 获取市 */
extern NSString* const _api_home_getCity;
/** 获取区 */
extern NSString* const _api_home_getDistrict ;
/** 逛逛 */
extern NSString* const _api_home_getCatesChild;
/** 删除我的喜欢 */
extern NSString* const _api_home_deletemylike;
/** 添加我的喜欢 */
extern NSString* const _api_home_addmylike;
/** 热门搜索 */
extern NSString* const _api_home_getkeyword;
/** 摇一摇 */
extern NSString* const _api_home_shake ;
/** 摇一摇记录 */
extern NSString* const _api_home_shakerecord;
/** 摇一摇信息 */
extern NSString* const _api_home_shakemessage;
/**秒杀闪购**/
extern NSString* const _api_home_seckillhome;
extern NSString* const _api_home_seckilpro;

/*
 店铺（品牌特卖）
 */
/**1.1 店铺列表 */
extern NSString* const _api_brand_getDp;
/**1.3品牌特卖分类 */
extern NSString* const _api_brand_getShopCates;

/*
 购物返利
 */
/** 商城返利 */
extern NSString* const _api_shoprebate_getmallalliance;
/** 淘宝返利 */
extern NSString* const _api_shoprebate_gettaobaoUrl;
extern NSString* const _api_shoprebate_getmallalliancecates ;


/*
 优惠券
 */
//4.2优惠券商品列表
extern NSString* const _api_coupon_yhq_goodslist;

/*
我的
 */
/** 获取验证码 */
extern NSString* const _api_mine_getcode;
/** 检验验证码 */
extern NSString* const _api_mine_checkcode ;
extern NSString* const _api_mine_bill;
extern NSString* const _api_mine_aboutus;
/** 修改用户信息 */
extern NSString* const _api_mine_updateUser;
/** 修改密码 */
extern NSString* const _api_mine_updatePwd;
/** 忘记密码 */
extern NSString* const _api_mine_forgetPwd;
/** 获取用户信息 */
extern NSString* const _api_mine_getUserInfo;
/** 添加浏览足迹 */
extern NSString* const _api_mine_addfootmark;
/** 获取浏览足迹 */
extern NSString* const _api_mine_getfootmark;
/** 获取我的喜欢 */
extern NSString* const _api_mine_getmylike;
/** 积分明细 */
extern NSString* const _api_mine_getIntegral;
/** 兑换商品 */
extern NSString* const _api_mine_getExchangeres;
/** 获取消息信息 */
extern NSString* const _api_mine_getMsg;
/** 获取消息详情 */
extern NSString* const _api_mine_getMsgDetail;
/** 版本 */
extern NSString* const _api_mine_checkVersion;
/** 意见反馈 */
extern NSString* const _api_mine_setideasBox;
/** 查看邀请规则 */
extern NSString* const _api_mine_incentiverules;
/** 常见问题 */
extern NSString* const _api_mine_commproblem;
/** 使用帮助 */
extern NSString* const _api_mine_usehelp ;
/** 关于我们 */
extern NSString* const _api_mine_AboutUs;
/** 服务协议 */
extern NSString* const _api_mine_ServiceProxy;
/** 淘宝下单 */
extern NSString* const _api_mine_tbrecord;
/** 淘宝返利--获取用户订单 */
extern NSString* const _api_mine_getOrder;
/** 设置-文章 */
extern NSString* const _api_mine_gethelper;
/** 邀请有奖-图片 */
extern NSString* const _api_mine_getpic;
/**找回订单 */
extern NSString* const _api_mine_reorder;
/** 邀请有奖-获取top3 */
extern NSString* const _api_mine_getExtendtopthree;
/** 获取商城订单 */
extern NSString* const _api_mine_getShopOrder ;
/** 访问获取订单 */
extern NSString* const _api_mine_flushOrder;
/** 获取用户邀请人 */
extern NSString* const _api_mine_getExtend ;
/** 获取自己的邀请奖励 */
extern NSString* const _api_mine_getmyself ;
/** 晒单鲜花的帮助中心 **/
extern NSString* const _api_mine_helper;
/** 会员等级 */
extern NSString* const _api_mine_Level ;
/** 我的积分 */
extern NSString* const _api_mine_IntegralWAP ;
/** 跟单 */
extern NSString* const _api_mine_followOrder ;
/** 返利教程 */
extern NSString* const _api_mine_course ;
/** 提现 */
extern NSString* const _api_mine_Draw;
/** 提现历史 */
extern NSString* const _api_mine_DrawHistory;
/** 商家报名 */
extern NSString* const _api_mine_describe;
/** 分享页面 */
extern NSString* const _api_mine_invfriends1 ;
/** 分享内容 */
extern NSString* const _api_mine_getShareInfo;
/** 5.0会员中心图标 */
extern NSString* const _api_mine_functions;
/**代理中心 */
extern NSString* const _api_mine_agentcenter;


/*
 注册 , 登录
 */
/** 注册 */
extern NSString* const _api_register_register ;
/** 登陆 */
extern NSString* const _api_login_login;
/** 第三方登陆 */
extern NSString* const _api_login_threelogin ;

/*
 晒单部分 
 */

/** 发布晒单 **/
extern NSString* const _api_showorder_addsorder ;
/** 获取喜欢的晒单 **/
extern NSString* const _api_showorder_getorderlike;
/** 添加喜欢的晒单 **/
extern NSString* const _api_showorder_addorderlike;
/** 删除喜欢的晒单 **/
extern NSString* const _api_showorder_deleteorderlike;
/** 添加关注 **/
extern NSString* const _api_showorder_addfollow;
/** 添加关注 **/
extern NSString* const _api_showorder_deletefollow;
/** 获取关注信息 **/
extern NSString* const _api_showorder_getfollow ;
/** 献花 **/
extern NSString* const _api_showorder_addflower;
/** 获取晒单 **/
extern NSString* const _api_showorder_getsorder;
/** 获取达人排行榜 **/
extern NSString* const _api_showorder_gettop;
/** 详情页获取献花用户信息 **/
extern NSString* const _api_showorder_getflower;
/** 获取用户献花的晒单信息 **/
extern NSString* const _api_showorder_getusersorder;
/** 晒单幻灯片 **/
extern NSString* const _api_showorder_getSlide;
/** 获取他人信息 **/
extern NSString* const _api_showorder_getotheruser;
/** 添加评论 **/
extern NSString* const _api_showorder_addcomment;
/** 获取评论**/
extern NSString* const _api_showorder_getcomment;
/** 获取晒单详情 */
extern NSString* const _api_showorder_getdetails;
/** 搜好友 */
extern NSString* const _api_showorder_seach;
/** 删除晒单 */
extern NSString* const _api_showorder_deletesorder;
/** 查询爱淘宝 **/
extern NSString* const _api_showorder_GETATBProductInfo;
/** 获取好友返利 **/
extern NSString* const _api_showorder_getFirendOrder;
/** 写入缓存（用于判断是不是App) **/
extern NSString* const _api_showorder_WirteCache;


/**
 *  三级分销中心模块接口
 */

/** 分销中心 **/
extern NSString* const _api_threesale_fxzx;
/** 分销中心图标 **/
extern NSString* const _api_threesale_fxico;
/** 我的佣金 **/
extern NSString* const _api_threesale_wdyj;
/** 收益统计 **/
extern NSString* const _api_threesale_sytj;
/** 二维码 **/
extern NSString* const _api_threesale_fxqrcode;
/** 团队成员 **/
extern NSString* const _api_threesale_qdcy;
/** 佣金来源 **/
extern NSString* const _api_threesale_yjly ;
/** 分销订单 **/
extern NSString* const _api_threesale_fxorder;
/** 分销规则URL **/
extern NSString* const _api_threesale_FXURL;


/*
 others
 */
/** 获取启动页图片 */
extern NSString* const _api_others_getstartpic;
/** 基本设置 **/
extern NSString* const _api_others_getset;
/** 免责声明 **/
extern NSString* const _api_others_statement;

/** 一元购链接 **/
extern NSString* const _api_others_yiyuanindex;
/** 抓数据跟单 **/
extern NSString* const _api_others_htmlFllowOrder;

/** 抓数据跟单JS网页 **/
extern NSString* const _api_others_JShtmlFllowOrder;

/** 15.1超高返&&超级券图文位 **/
extern NSString* const _api_others_rebatetuwen;
/** 15.2购物返利栏目商品分类 **/
extern NSString* const _api_others_rebatecate;
/** 15.3超高返&&优惠券广告文 **/
extern NSString* const _api_others_rebateggw;
/** 15.4超级券&&超高返二级分类 **/
extern NSString* const _api_others_rebatesubcate;
/** 15.5热搜关键词 **/
extern NSString* const _api_others_getkeyword;

extern NSString* const _home_api_signup ;
