//
//  FNVideoMarketingModel.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNVideoMarketingItemModel : NSObject

// nav
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* right_str;
@property (nonatomic, copy) NSString* is_show;

// banner
@property (nonatomic, copy) NSString* content;
@property (nonatomic, copy) NSString* btntitle;
@property (nonatomic, copy) NSString* color;
@property (nonatomic, copy) NSString* contentcolor;
@property (nonatomic, copy) NSString* btncolor;
@property (nonatomic, copy) NSString* banner_sort;
@property (nonatomic, copy) NSString* font_color;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, copy) NSString* img;
@property (nonatomic, copy) NSString* SkipUIIdentifier;
@property (nonatomic, copy) NSString* yhq_price;
@property (nonatomic, copy) NSString* goods_price;
@property (nonatomic, copy) NSString* search_keyword;
@property (nonatomic, copy) NSString* goodsingle_lable;
@property (nonatomic, strong) NSArray* is_brand;
@property (nonatomic, strong) NSArray* is_live;
@property (nonatomic, strong) NSArray* is_video;
@property (nonatomic, copy) NSString* dtk_goods_onoff;
@property (nonatomic, copy) NSString* fnuo_id;
@property (nonatomic, copy) NSString* shop_type;
@property (nonatomic, copy) NSString* goods_pd_onoff;
@property (nonatomic, copy) NSString* jdgoods_pd_onoff;
@property (nonatomic, copy) NSString* yhq_onoff;
@property (nonatomic, copy) NSString* start_price;
@property (nonatomic, copy) NSString* end_price;
@property (nonatomic, copy) NSString* goods_sales;
@property (nonatomic, copy) NSString* commission;
@property (nonatomic, copy) NSString* show_type_str;
@property (nonatomic, copy) NSString* double_bjimg;
@property (nonatomic, copy) NSString* UIIdentifier;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* view_type;
@property (nonatomic, copy) NSString* goodslist_img;
@property (nonatomic, copy) NSString* goodslist_str;
@property (nonatomic, strong) NSArray* goods_detail;
@property (nonatomic, copy) NSString* is_need_login;
@property (nonatomic, copy) NSString* integral_id;
@property (nonatomic, copy) NSString* keyword;
@property (nonatomic, copy) NSString* goods_type_name;
@property (nonatomic, copy) NSString* getGoodsType;
@property (nonatomic, strong) NSArray* goods_msg;
@property (nonatomic, copy) NSString* goods_title;
@property (nonatomic, copy) NSString* goodsInfo;
@property (nonatomic, copy) NSString* show_name;

// exchange
@property (nonatomic, copy) NSString* btnimg;
@property (nonatomic, copy) NSString* act_str;
@property (nonatomic, copy) NSString* act_str_color;
@property (nonatomic, copy) NSString* time_str;
@property (nonatomic, copy) NSString* time_str_color;
@property (nonatomic, copy) NSString* tip_img;

// movie
@property (nonatomic, copy) NSString* ID;
@property (nonatomic, copy) NSString* score;
@property (nonatomic, copy) NSString* movie_url;
@property (nonatomic, copy) NSString* show_type;
@property (nonatomic, copy) NSString* old_url;
@property (nonatomic, copy) NSString* is_visit;
@property (nonatomic, copy) NSString* visit_str;
@property (nonatomic, copy) NSString* info1;
@property (nonatomic, copy) NSString* info2;
@property (nonatomic, copy) NSString* hot;

@end

@interface FNVideoMarketingModel : NSObject

@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* mac;
@property (nonatomic, copy) NSString* jiange;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* content;
@property (nonatomic, copy) NSString* img;
@property (nonatomic, strong) NSArray<FNVideoMarketingItemModel*>* list;

@end

NS_ASSUME_NONNULL_END
