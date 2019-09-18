//
//  FNNewWelfDeModel.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNNewWelfDeBannerModel : NSObject

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* font_color;
@property (nonatomic, copy) NSString* img;
@property (nonatomic, copy) NSString* description;
@property (nonatomic, copy) NSString* SkipUIIdentifier;
@property (nonatomic, copy) NSString* ktype;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, copy) NSString* UIIdentifier;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* view_type;
@property (nonatomic, copy) NSString* goodslist_img;
@property (nonatomic, copy) NSString* goodslist_str;
@property (nonatomic, strong) NSArray* goods_detail;
@property (nonatomic, copy) NSString* is_need_login;
@property (nonatomic, copy) NSString* integral_id;
@property (nonatomic, copy) NSString* fnuo_id;
@property (nonatomic, copy) NSString* shop_type;
@property (nonatomic, copy) NSString* start_price;
@property (nonatomic, copy) NSString* end_price;
@property (nonatomic, copy) NSString* commission;
@property (nonatomic, copy) NSString* goods_sales;
@property (nonatomic, copy) NSString* keyword;
@property (nonatomic, copy) NSString* yhq_onoff;
@property (nonatomic, copy) NSString* goods_pd_onoff;
@property (nonatomic, copy) NSString* dtk_goods_onoff;
@property (nonatomic, copy) NSString* show_type_str;
@property (nonatomic, copy) NSString* goods_type_name;
@property (nonatomic, copy) NSString* getGoodsType;
@property (nonatomic, strong) NSArray* goods_msg;
@property (nonatomic, copy) NSString* goods_title;
@property (nonatomic, copy) NSString* goodsInfo;
@property (nonatomic, copy) NSString* show_name;

@end

@interface FNNewWelfDeModel : NSObject
    
@property (nonatomic, copy) NSString* top_title;
@property (nonatomic, copy) NSString* order_title;
@property (nonatomic, copy) NSString* flowpath_label_img;
@property (nonatomic, copy) NSString* flowpath_img;
@property (nonatomic, copy) NSString* goods_label_img;

@property (nonatomic, strong) NSArray<FNNewWelfDeBannerModel*>* banner;

@end

NS_ASSUME_NONNULL_END
