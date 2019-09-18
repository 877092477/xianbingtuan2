//
//  FNUpgradeModel.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/17.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNUpgradeTopModel : NSObject


@property (nonatomic, copy) NSString* bjimg;
@property (nonatomic, copy) NSString* returnimg;
@property (nonatomic, copy) NSString* top_title;
@property (nonatomic, copy) NSString* top_title_color;
@property (nonatomic, copy) NSString* name_color;
@property (nonatomic, copy) NSString* lv_str;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* head_img;
@property (nonatomic, copy) NSString* lv_color;
@property (nonatomic, copy) NSString* vip_logo;

@end

@interface FNUpgradeDataModel : NSObject
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* font_color;
@property (nonatomic, copy) NSString* SkipUIIdentifier;
@property (nonatomic, copy) NSString* fnuo_id;
@property (nonatomic, copy) NSString* shop_type;
@property (nonatomic, copy) NSString* goods_pd_onoff;
@property (nonatomic, copy) NSString* tb618_type;
@property (nonatomic, copy) NSString* goodsingle_lable;
@property (nonatomic, copy) NSString* wl_type;
@property (nonatomic, copy) NSString* jdgoods_pd_onoff;
@property (nonatomic, copy) NSString* dtk_goods_onoff;
@property (nonatomic, copy) NSString* yhq_onoff;
@property (nonatomic, copy) NSString* search_keyword;
@property (nonatomic, copy) NSString* start_price;
@property (nonatomic, copy) NSString* end_price;
@property (nonatomic, copy) NSString* commission;
@property (nonatomic, copy) NSString* goods_sales;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, copy) NSString* outlink_style;
@property (nonatomic, copy) NSString* outlink_check_fontcolor;
@property (nonatomic, copy) NSString* outlink_check_bgcolor;
@property (nonatomic, copy) NSString* outlink_pull_onoff;
@property (nonatomic, copy) NSString* outlink_navhide_onoff;
@property (nonatomic, copy) NSString* submit;
@property (nonatomic, copy) NSString* img;
@property (nonatomic, copy) NSString* model_img;
@property (nonatomic, copy) NSString* model_type;
@property (nonatomic, copy) NSString* model_title;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* show_type_str;
@property (nonatomic, copy) NSString* jsonInfo;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* view_type;
@property (nonatomic, copy) NSString* goodslist_str;
@property (nonatomic, copy) NSString* goodslist_img;
@property (nonatomic, copy) NSString* UIIdentifier;
@property (nonatomic, copy) NSString* is_showcate;
@property (nonatomic, copy) NSString* login;
@property (nonatomic, strong) NSArray* goods_detail;
@property (nonatomic, copy) NSString* is_need_login;
@property (nonatomic, copy) NSString* keyword;
@property (nonatomic, copy) NSString* goods_type_name;
@property (nonatomic, copy) NSString* getGoodsType;
@property (nonatomic, strong) NSArray* goods_msg;
@property (nonatomic, copy) NSString* goods_title;
@property (nonatomic, copy) NSString* goodsInfo;
@property (nonatomic, copy) NSString* show_name;

@end

@interface FNUpgradeModel : NSObject

@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* mac;
@property (nonatomic, copy) NSString* jiange;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, strong) NSArray<FNUpgradeDataModel*>* list;


@property (nonatomic, assign) CGFloat bili;

@end

@interface FNUpgradeCateModel : NSObject

@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString* catename;

@end

NS_ASSUME_NONNULL_END
