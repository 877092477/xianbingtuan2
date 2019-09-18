//
//  FNBaseSettingModel.h
//  SuperMode
//
//  Created by jimmy on 2017/6/6.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNTabModel.h"
@interface FNBaseSettingModel : NSObject
/**
 *  checkVersion
 */
@property (nonatomic, copy)NSString* checkVersion;
/**
 *  AppleAppID
 */
@property (nonatomic, copy)NSString* AppleAppID;
/**
 *  CompanyName
 */
@property (nonatomic, copy)NSString* CompanyName;
/**
 *  appopentaobao_onoff,0，手淘打开；1.强制H5
 */
@property (nonatomic, copy)NSString* appopentaobao_onoff;
/**
 *  AppIcon
 */
@property (nonatomic, copy)NSString* AppIcon;
/**
 *  AppDisplayName
 */
@property (nonatomic, copy)NSString* AppDisplayName;

/**
 *  AppLogo
 */
@property (nonatomic, copy)NSString* AppLogo;
/**
 *  ContactPhone
 */
@property (nonatomic, copy)NSString* ContactPhone;
/**
 *  app_gmfl_bili
 */
@property (nonatomic, copy)NSString* app_gmfl_bili;
/**
 *  AppStoreUrl
 */
@property (nonatomic, copy)NSString* AppStoreUrl;
/**
 *  TaoKePid
 */
@property (nonatomic, copy)NSString* TaoKePid;
/**
 *  ContactUs
 */
@property (nonatomic, copy)NSString* ContactUs;
/**
 *  defaultImg
 */
@property (nonatomic, copy)NSString* defaultImg;
/**
 *  app_seach_str
 */
@property (nonatomic, copy)NSString* app_seach_str;
/**
 *  CustomUnit
 */
@property (nonatomic, copy)NSString* CustomUnit;
/**
 *  APP_alliance_appkey
 */
@property (nonatomic, copy)NSString* APP_alliance_appkey;
/**
 *  app_invitation_list_onoff
 */
@property (nonatomic, copy)NSString* app_invitation_list_onoff;
/**
 *  djtg_lv
 */
@property (nonatomic, copy)NSString* djtg_lv;
/**
 *  APP_adzoneId
 */
@property (nonatomic, copy)NSString* APP_adzoneId;
/**
 *  是否需要填写邀请码 0否 1是
 */
@property (nonatomic, copy)NSString* extendreg;

/**
 *  vip_extend_onoff
 */
@property (nonatomic, copy)NSString* vip_extend_onoff;
/**
 *  ggapitype
 */
@property (nonatomic, copy)NSString* ggapitype;

/**
 *  vip_name
 */
@property (nonatomic, copy)NSString* vip_name;

/**
 *  app_daoshoujia_name
 */
@property (nonatomic, copy)NSString* app_daoshoujia_name;

/**
 *  app_quanhoujia_name
 */
@property (nonatomic, copy)NSString* app_quanhoujia_name;

/**
 *  setzfb_wzurl
 */
@property (nonatomic, copy)NSString* setzfb_wzurl;

/**
 *  dgapp_yhq_onoff
 */
@property (nonatomic, copy)NSString* dgapp_yhq_onoff;
/**
 *  WeChatAppSecret
 */
@property (nonatomic, copy)NSString* WeChatAppSecret;

/**
 *  商品打开方式：0.链接优先；1.强制ID打开
 */
@property (nonatomic, copy)NSString* dg_goods_open_type;
/**
 *  kepler_zeus
 */
@property (nonatomic, copy)NSString* kepler_zeus;
/**
 *  jd_open_app
 */
@property (nonatomic, copy)NSString* jd_open_app;
/**
 *  pdd_open_app
 */
@property (nonatomic, copy)NSString* pdd_open_app;
/**
 *  app_goods_fenxiang_type
 */
@property (nonatomic, copy)NSString* app_goods_fenxiang_type;
/**
 *  app_fanli_onoff
 */
@property (nonatomic, copy)NSString* app_fanli_onoff;
/**
 JDAppKey
 */
@property (nonatomic, copy)NSString* JDAppKey;

/**
 JDAppSecret
 */
@property (nonatomic, copy)NSString* JDAppSecret;

/**
 JDKeplerID
 */
@property (nonatomic, copy)NSString* JDKeplerID;

/**
 buy_jingdong_onoff
 */
@property (nonatomic, copy)NSString* buy_jingdong_onoff;

/**
 buy_pinduoduo_onoff
 */
@property (nonatomic, copy)NSString* buy_pinduoduo_onoff;

/**
 buy_pinduoduo_onoff
 */
@property (nonatomic, copy)NSString* buy_taobao_onoff;

/**
 app_jdgoods_fenxiang_type
 */
@property (nonatomic, copy)NSString* app_jdgoods_fenxiang_type;

/**
 app_pddgoods_fenxiang_type
 */
@property (nonatomic, copy)NSString* app_pddgoods_fenxiang_type;

/**
 hhrshare_flstr
 */
@property (nonatomic, copy)NSString* hhrshare_flstr;

/**
 hhrshare_noflstr
 */
@property (nonatomic, copy)NSString* hhrshare_noflstr;

/**
 all_fx_onoff
 */
@property (nonatomic, assign)NSString* all_fx_onoff;
/**
 *  tab
 */
//@property (nonatomic, strong)NSArray<FNTabModel *>* tabs;
/**
 *  ksrk 快速入口背景图
 */
@property (nonatomic, copy)NSString* ksrk;
/**
 *  图文背景图
 */
@property (nonatomic, copy)NSString* tw;
/**
 *  超高返精选图标
 */
@property (nonatomic, copy)NSString* index_cgfjx_ico;
/**
 *  超高返顶部图标
 */
@property (nonatomic, copy)NSString* index_cgfdb_ico;
/**
 *  超级券顶部图标
 */
@property (nonatomic, copy)NSString* index_cjqjx_ico;
@property (nonatomic, copy)NSString* app_choujiang_onoff;
/**
 * 用来判断合伙人是否需要验证，如果要验证，则使用会员中心的hhr_checks的判断合伙人审核状态，0的时候，点击的时候提示，您的申请正在审核中；1.跳转到合伙人中心；2.您的申请审核失败，请重新提交，然后跳转到申请界面；3.跳转到申请界面
 */
@property (nonatomic, copy)NSString* hhr_openCheck;

/**
 goods_flstyle
 */
@property (nonatomic, copy)NSString* goods_flstyle;

/**
 基本设置返回这个字段，用来控制商品详情下面的购买按钮，0的话就是新的样式
 */
@property (nonatomic, copy)NSString* goods_detail_yhq_onoff;
/**
 基本设置返回一个字段，隐藏和显示提现按钮,0显示 1隐藏
 */
@property (nonatomic, copy)NSString* txdoing_onoff;
@property (nonatomic, copy)NSString* yxb_str;

/**
 邀请好友页面文字(给你最超值的宝贝)
 */
@property (nonatomic, copy)NSString* yq_ym_str;
/**
 邀请好友页面文字(100%精选品质 大牌折扣)
 */
@property (nonatomic, copy)NSString* yq_ym_str1;

/**
 0开启  1关闭
这个判断复制搜索的功能
 */
@property (nonatomic, copy)NSString* indexsearch_onoff;
/**
 user_top_img
 */
@property (nonatomic, copy)NSString* user_top_img;

@property (nonatomic, copy)NSString* YJCustomUnit;

@property (nonatomic, copy)NSString* agent_name_str;

@property (nonatomic, copy)NSString* app_dtk_twojump_onoff;

@property (nonatomic, copy)NSString* app_fanli_off_str;

@property (nonatomic, copy)NSString* app_jd_seach_list_coupon_type;

@property (nonatomic, copy)NSString* app_keplerID_kepler;

@property (nonatomic, copy)NSString* app_key_kepler;

@property (nonatomic, copy)NSString* app_secret_kepler;

@property (nonatomic, copy)NSString* duomai_store_str;

@property (nonatomic, copy)NSString* fxdl_hhrshare_onoff;

@property (nonatomic, copy)NSString* fxdl_zdssdl_onoff;

@property (nonatomic, copy)NSString* login_bounce_str;

@property (nonatomic, copy)NSString* mem_set_str4;

@property (nonatomic, copy)NSString* mon_icon;

@property (nonatomic, copy)NSString* search_sort_str;

@property (nonatomic, copy)NSString* tdj_web_url;

@property (nonatomic, copy)NSString* yxb_bjimg;

@property (nonatomic, copy)NSString* yxb_strs;

@property (nonatomic, copy)NSString* yxb_strs1;

@property (nonatomic, copy)NSString* taoqianggou_nav_img;

@property (nonatomic, copy)NSString* taoqianggou_time_img;

@property (nonatomic, copy)NSString* tqg_nav_color;

@property (nonatomic, copy)NSString* index_goods_columnSwitch;

@property (nonatomic, copy)NSString* loading_goods_img;

@property (nonatomic, copy)NSString* quan_bjimg;

//0不需要登录   1 需要登录
@property (nonatomic, copy)NSString* is_need_login;

@property (nonatomic, copy)NSString* iupdate_goods_onoff;

@property (nonatomic, copy)NSString* update_goods_onoff;

//是否隐藏分享 0开启  1关闭
@property (nonatomic, copy)NSString* app_sharegoods_onoff;

//协议政策开关 0隐藏 1显示
@property (nonatomic, copy)NSString* privacy_onoff;

//协议政策 url
@property (nonatomic, copy)NSString* privacy_url;


@property (nonatomic, copy)NSString* apptip_search_img;
@property (nonatomic, copy)NSString* apptip_taobao_img;
@property (nonatomic, copy)NSString* apptip_pdd_img;
@property (nonatomic, copy)NSString* apptip_jd_img;
@property (nonatomic, copy)NSString* apptip_tb_ico;
@property (nonatomic, copy)NSString* apptip_style_onoff;
@property (nonatomic, copy)NSString* pub_wph_goods_onoff; //唯品会图标是否显示,0否 1是
@property (nonatomic, copy)NSString* apptip_wph_img;//唯品会图标
@property (nonatomic, copy)NSString* wph_goods_columnSwitch; //唯品会栏目默认单双列 0显示一列  1显示两列
//样式 1(旧)=>indexstyle_01  样式2(新)=>indexstyle_02
@property (nonatomic, copy)NSString* dg_index_style;

@property (nonatomic, copy)NSString* cates_nocheck_bj_color;
@property (nonatomic, copy)NSString* cates_bj_color;
@property (nonatomic, copy)NSString* cate_notcheck_color;
@property (nonatomic, copy)NSString* cates_check_color;

@property (nonatomic, copy)NSString* miandan_show_url;

@property (nonatomic, copy)NSString* oauth_url;
@property (nonatomic, copy)NSString* oauth_str;
@property (nonatomic, copy)NSString* tb_illegal;
@property (nonatomic, copy)NSString* realtion_oauth_error_str;

@property (nonatomic, copy)NSString* movie_top_str;

@property (nonatomic, copy)NSString* tgid_str;

@property (nonatomic, copy)NSString* iOS_Amap_key;

@property (nonatomic, copy)NSString* live_type_onoff;

@property (nonatomic, copy)NSString* extend_onoff;

@property (nonatomic, copy)NSString* tb_detail_js;

@property (nonatomic, copy)NSString* update_tbauthorization_onoff;

+ (void)saveSetting:(FNBaseSettingModel *)model;
+ (FNBaseSettingModel *)settingInstance;

@end
