//
//  FNBaseProductModel.h
//  LikeKaGou
//
//  Created by jimmy on 16/9/29.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNBaseProductModel : NSObject
@property (nonatomic, copy) NSString *ID;
/** 返利的 **/

@property (nonatomic, copy) NSString *goods_sales;

/**1.淘宝，2.天猫 3.京东 */
@property (nonatomic, copy) NSString *shop_id;

@property (nonatomic, copy) NSString *shop_type;

@property (nonatomic, copy) NSString *goods_title;

@property (nonatomic, copy) NSString *goods_quanfont_bjimg;

@property (nonatomic, copy) NSString *goods_quanbj_bjimg;

@property (nonatomic, copy) NSString *goods_fanli_bjimg;

@property (nonatomic, copy) NSString *goods_sharezhuan_img;


@property (nonatomic, copy) NSString *returnbili;

@property (nonatomic, copy) NSString *djs_time;

@property (nonatomic, copy) NSString *fnuo_id;

@property (nonatomic, copy) NSString *open_iid;

@property (nonatomic, copy) NSString *yhq_price;

@property (nonatomic, copy) NSString *goods_cost_price;

@property (nonatomic, copy) NSString *goods_img;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, copy) NSString *returnfb;

@property (nonatomic, copy) NSString *dp_id;

@property (nonatomic, copy) NSString *goods_price;

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, copy) NSString *commission;

@property (nonatomic, copy) NSString *goods_type;

@property (nonatomic, assign) NSInteger is_mylike;

@property (nonatomic, copy) NSString *cate_id;

@property (nonatomic, copy) NSString *highcommission_wap_url;

@property (nonatomic, copy) NSString *jd_url;

@property (nonatomic, copy) NSString *fcommission;

@property (nonatomic, copy) NSString *fnuo_url;

@property (nonatomic, copy) NSString *is_qg;

@property (nonatomic, copy) NSString *jindu;

@property (nonatomic, copy)NSString* yhq_span;

@property (nonatomic, copy)NSString* qh_money;

@property (nonatomic, copy)NSString* yhq_url;

@property (nonatomic, copy)NSString* qh_price;

@property (nonatomic, copy)NSString* fxz_money;

/**
 *  juanhou_price
 */
@property (nonatomic, strong)NSString* juanhou_price;
/**
 *  is_support
 */
@property (nonatomic, copy)NSString* is_support;

@property (nonatomic, strong)NSString* qgStr;

@property (nonatomic, strong)NSString* yhq;

/**
 *  是否隐藏自购返利 0显示 1隐藏
 */
@property (nonatomic, strong)NSString* is_hide_fl;

/**
 *  是否隐藏分享赚返利 0显示 1隐藏
 */
@property (nonatomic, strong)NSString* is_hide_sharefl;

/**
 *  bei
 */
@property (nonatomic, copy)NSString* bei;

/**
 *  超高返
 */
@property (nonatomic, copy)NSString* highcommission_url;

@property (nonatomic, copy)NSString* app_fanli_off_str;

@property (nonatomic, copy)NSString* ico;

@property (nonatomic, copy)NSString* is_qiangguang;

/**
 *  cr_str
 */
@property (nonatomic, copy)NSString* cr_str;

@property (nonatomic, copy)NSString* n_icon;

@property (nonatomic, copy)NSString* px_id;

@property (nonatomic, copy)NSString* str_tg;

@property (nonatomic, copy)NSString* zhe;

@property (nonatomic, copy)NSString* str_img;

@property (nonatomic, copy)NSString* goods_ico_one;

@property (nonatomic, copy)NSString* fxz;

@property (nonatomic, copy)NSString* is_collect;

/**
 is_not_dqst
 */
@property (nonatomic, copy)NSString* is_not_dqst;
/**
 baichun url
 */
@property (nonatomic, copy)NSString* bc_url;
/**
 wz_data
 */
@property (nonatomic, copy)NSArray* wz_data;
/**
 str
 */
@property (nonatomic, copy)NSString* str;
@property (nonatomic, copy)NSString* stock;

@property (nonatomic, copy)NSString* couponPrice;

@property (nonatomic, copy)NSString* detailurl;

@property (nonatomic, copy)NSString* fbili;

@property (nonatomic, copy) NSString *shop_img;

@property (nonatomic, copy) NSString *fcommissionshow;

@property (nonatomic, copy) NSString *fx_commission;

@property (nonatomic, copy) NSString *fx_commission_bili;

@property (nonatomic, copy) NSString *goodsfcommissionstr_color;

@property (nonatomic, copy) NSString *jd;

@property (nonatomic, copy) NSString *pdd;

@property (nonatomic, copy) NSString *wph;

@property (nonatomic, copy) NSString *price_str;

@property (nonatomic, copy) NSString *provcity;

@property (nonatomic, copy) NSString *px_img;

@property (nonatomic, copy) NSString *str_status;

@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, copy) NSString *share_img;

@property (nonatomic, copy) NSString *is_start;

@property (nonatomic, copy) NSString *getGoodsType;

@property (nonatomic, copy) NSString *fan_all_str;

@property (nonatomic, copy) NSString *store_id;

@property (nonatomic, copy) NSString *shop_title;

//判断是那里进入
@property (nonatomic, copy)NSString* VCName;

 //店铺图标
@property (nonatomic, copy)NSString* goods_store_img;

//热销图标
@property (nonatomic, copy)NSString* goods_sales_ico;

@property (nonatomic, copy)NSString* goods_flstyle;

//抽奖状态: 0,1
@property (nonatomic, copy)NSString* app_choujiang_onoff;
 //分享文字颜色
@property (nonatomic, copy)NSString* goodssharestr_color;

@property (nonatomic, copy)NSString* goodsyhqstr_color;
//券背景图
@property (nonatomic, copy)NSString* quan_bjimg;

@property (nonatomic, copy)NSString* goods_description;


//商品图片的升级赚文字
@property (nonatomic, copy)NSDictionary* img_sjz;
//商品图片的分享赚文字
@property (nonatomic, copy)NSDictionary* img_fxz;

@property (nonatomic, strong) NSDictionary *mid_zgz;

@property (nonatomic, copy)NSString* miaoshu;

@property (nonatomic, copy)NSString* taoqianggou_quan_img;

@property (nonatomic, copy)NSString* taoqianggou_remind_img;

@property (nonatomic, copy)NSString* taoqianggou_cancelremind_img;

@property (nonatomic, copy)NSString* qg_time;
@property (nonatomic, copy)NSString* remind;

@property (nonatomic, copy)NSString* taoqianggou_quan_color;

@property (nonatomic, copy)NSString* short_title;
@property (nonatomic, copy)NSString* seller_id;

@property (nonatomic, strong)NSDictionary* btn_zgz;

@property (nonatomic, strong)NSDictionary* btn_fxz;

@property (nonatomic, copy) NSString* goodsInfo;

@property (nonatomic, copy)NSString* fcommission_str;
@property (nonatomic, copy)NSString* goodsbank_quan_img;
@property (nonatomic, copy)NSString* quan_str;
@property (nonatomic, copy)NSString* quan_color;
@property (nonatomic, assign)NSInteger someState;
@property (nonatomic, copy)NSString *is_dq_yhqurl;
@property (nonatomic, copy)NSString* store_jump_url;

@property (nonatomic, copy)NSString* video;

@property (nonatomic, copy)NSString *btn_img;
@property (nonatomic, copy) NSString *str_color;

@property (nonatomic, copy) NSString *hot_img;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *info_color;
@property (nonatomic, copy) NSString *shadow_color;

@property (nonatomic, copy) NSString *SkipUIIdentifier;
@property (nonatomic, copy) NSString *h5_url;

@property (nonatomic, strong) NSArray<NSString*>* imgArr;

/// 用于记录json数据
@property (nonatomic, strong) NSDictionary* data;
//goods_title;
//short_title;
//goods_price;
//goods_cost_price;
//goods_sales;
//commission;
//fcommission;
//fx_commission;
//shop_title;
//seller_id;
//shop_type;

@property (nonatomic, copy) NSString *goods_sharebtn_bjico;
@property (nonatomic, copy) NSString *goods_sharebtn_bjimg;
@property (nonatomic, copy) NSString *price_color;
@property (nonatomic, copy) NSString *price_fontcolor;
@property (nonatomic, copy) NSString *goodssharestr_btncolor;
@property (nonatomic, copy) NSString *shoptitle_color;

@property (nonatomic, copy) NSString *act_type;//免单


@end


