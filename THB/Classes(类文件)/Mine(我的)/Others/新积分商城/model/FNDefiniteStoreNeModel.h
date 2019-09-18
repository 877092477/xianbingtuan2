//
//  FNDefiniteStoreNeModel.h
//  THB
//
//  Created by Jimmy on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNDefiniteStoreNeModel : NSObject

@property (nonatomic , copy) NSString              * name;

@property (nonatomic , copy) NSString              * type;

@property (nonatomic , copy) NSString              * mac;

@property (nonatomic , copy) NSString              * ui_type;

@property (nonatomic , copy) NSString              * str_img;

@property (nonatomic , copy) NSString              * str;

@property (nonatomic , copy) NSString              * miandan_tiplogo;

@property (nonatomic , copy) NSString              * url;

@property (nonatomic , copy) NSString              * img;

@property (nonatomic , copy) NSArray               * list;

@end

@interface FNDefiniteListItemModel : NSObject



@property (nonatomic , copy) NSString              * integral_id;

@property (nonatomic , copy) NSString              * title;

@property (nonatomic , copy) NSString              * font_color;

@property (nonatomic , copy) NSString              * img;

//@property (nonatomic , copy) NSString              * description;

@property (nonatomic , copy) NSString              * SkipUIIdentifier;

@property (nonatomic , copy) NSString              * ktype;

@property (nonatomic , copy) NSString              * url;

@property (nonatomic , copy) NSString              * UIIdentifier;

@property (nonatomic , copy) NSArray               * img1;


@property (nonatomic , copy) NSString              * name;

@property (nonatomic , copy) NSString              * type;

@property (nonatomic , copy) NSString              * view_type;

@property (nonatomic , copy) NSString              * goodslist_img;

@property (nonatomic , copy) NSString              * goodslist_str;

@property (nonatomic , copy) NSArray               * goods_detail;

@property (nonatomic , copy) NSString              * is_need_login;

@property (nonatomic , copy) NSString              * fnuo_id;

@property (nonatomic , copy) NSArray               * shop_type;


@property (nonatomic , copy) NSString              * start_price;

@property (nonatomic , copy) NSString              * end_price;

@property (nonatomic , copy) NSString              * commission;

@property (nonatomic , copy) NSString              * goods_sales;

@property (nonatomic , copy) NSString              * keyword;

@property (nonatomic , copy) NSString              * yhq_onoff;

@property (nonatomic , copy) NSString              * goods_pd_onoff;

@property (nonatomic , copy) NSString              * dtk_goods_onoff;

@property (nonatomic , copy) NSString              * goods_type_name;

@property (nonatomic , copy) NSString              * show_name;

@property (nonatomic , copy) NSString              * banner_speed;

@property (nonatomic , copy) NSString              * banner_bili;

@property (nonatomic , copy) NSArray               * goods_msg;

@property (nonatomic , copy) NSString              * str;

@property (nonatomic , copy) NSString              * str2;

@property (nonatomic , copy) NSString              * str3;

@property (nonatomic , copy) NSString              * integral;

@property (nonatomic , copy) NSString              * id;


@property (nonatomic , copy) NSString              * goods_title;
@property (nonatomic , copy) NSString              * goods_img;
@property (nonatomic , copy) NSString              * goods_price;
@property (nonatomic , copy) NSString              * goods_cost_price;
@property (nonatomic , copy) NSString              * stock;
@property (nonatomic , copy) NSString              * fl_price;
@property (nonatomic , copy) NSString              * dp_id;
@property (nonatomic , copy) NSString              * start_time;
@property (nonatomic , copy) NSString              * end_time;
@property (nonatomic , copy) NSString              * provcity;
@property (nonatomic , copy) NSString              * shop_title;
@property (nonatomic , copy) NSString              * getGoodsType;
@property (nonatomic , copy) NSString              * pg_url;
@property (nonatomic , copy) NSString              * fcommission;
@property (nonatomic , copy) NSString              * fbili;
@property (nonatomic , copy) NSString              * zhe;
@property (nonatomic , copy) NSString              * fcommissionshow;
@property (nonatomic , copy) NSString              * fnuo_url;
@property (nonatomic , copy) NSString              * tdj_data;
@property (nonatomic , copy) NSString              * detailurl;
@property (nonatomic , copy) NSString              * jindu;
@property (nonatomic , copy) NSString              * fl_bj_img;
@property (nonatomic , copy) NSString              * is_rob;

@property (nonatomic , copy) NSString              * pt_str;

@end

@interface FNDefiniteScreenModel : NSObject

@property (nonatomic , copy) NSString              * name;

@property (nonatomic , copy) NSString              * up_sort;

@property (nonatomic , copy) NSString              * down_sort;

@property (nonatomic , copy) NSString              * is_has_up;
@end

@interface FNDefiniteProductModel : NSObject
@property (nonatomic , copy) NSArray               * attr_data;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * sales;
@property (nonatomic , copy) NSString              * data;
@property (nonatomic , copy) NSString              * label;
@property (nonatomic , copy) NSString              * label_color;
@property (nonatomic , copy) NSArray               * detail_label;
@property (nonatomic , copy) NSString              * goods_type;
@property (nonatomic , copy) NSString              * postage;
@property (nonatomic , copy) NSString              * nowIntegral;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * detail_getimg;
@property (nonatomic , copy) NSArray               * banner_img;
@property (nonatomic , copy) NSString              * str;
@property (nonatomic , copy) NSString              * str_color;
@property (nonatomic , copy) NSString              * sales_str;
@property (nonatomic , copy) NSString              * goods_img;
@property (nonatomic , copy) NSString              * goods_title;
@property (nonatomic , copy) NSString              * goods_cost_price;
@property (nonatomic , copy) NSString              * stock;
@property (nonatomic , copy) NSString              * btn_str;
@property (nonatomic , copy) NSString              * btn_color;
@property (nonatomic , copy) NSString              * btn_bjcolor;
@property (nonatomic , copy) NSString              * tip_str;
@property (nonatomic , copy) NSString              * tip_bjcolor;
@property (nonatomic , copy) NSString              * tip_color;
@property (nonatomic , copy) NSString              * is_can_buy;
@property (nonatomic , copy) NSString              * postage_str;
@property (nonatomic , copy) NSString              * kf_bjcolor;
@property (nonatomic , copy) NSString              * kf_str;
@property (nonatomic , copy) NSString              * kf_fontcolor;
@property (nonatomic , copy) NSString              * kf_img;
@property (nonatomic , copy) NSString              * buy_img;
@property (nonatomic , copy) NSArray               * detail_img;

@property (nonatomic , copy) NSString              * integral_id;
@property (nonatomic , copy) NSString              * UIIdentifier;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * view_type;
@property (nonatomic , copy) NSString              * SkipUIIdentifier;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * is_need_login;
@property (nonatomic , copy) NSString              * goodslist_img;
@property (nonatomic , copy) NSString              * goodslist_str;


@property (nonatomic , copy) NSString              * f_str;
@property (nonatomic , copy) NSString              * fxz;
@property (nonatomic , copy) NSString              * goods_fanli_bjimg;
@property (nonatomic , copy) NSString              * goods_sharebtn_bjico;
@property (nonatomic , copy) NSString              * goods_sharebtn_bjimg;
@property (nonatomic , copy) NSString              * goodsfcommissionstr_color;
@property (nonatomic , copy) NSString              * goodssharestr_btncolor;

@end
NS_ASSUME_NONNULL_END
