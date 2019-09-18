//
//  CircleOfFriendsBannerModel.h
//  THB
//
//  Created by Weller on 2018/12/17.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleOfFriendsBannerModel : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *font_color;
@property(nonatomic, copy) NSString *img;
@property(nonatomic, copy) NSString *description;
@property(nonatomic, copy) NSString *SkipUIIdentifier;
@property(nonatomic, copy) NSString *ktype;
@property(nonatomic, copy) NSString *url;
@property(nonatomic, copy) NSString *UIIdentifier;
@property(nonatomic, copy) NSString *img1;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *view_type;
@property(nonatomic, copy) NSString *goodslist_img;
@property(nonatomic, copy) NSString *goodslist_str;
@property(nonatomic, strong) NSArray *goods_detail;
@property(nonatomic, copy) NSString *is_need_login;
@property(nonatomic, copy) NSString *fnuo_id;
@property(nonatomic, copy) NSString *shop_type;
@property(nonatomic, copy) NSString *start_price;
@property(nonatomic, copy) NSString *end_price;
@property(nonatomic, copy) NSString *commission;
@property(nonatomic, copy) NSString *goods_sales;
@property(nonatomic, copy) NSString *keyword;
@property(nonatomic, copy) NSString *yhq_onoff;
@property(nonatomic, copy) NSString *goods_pd_onoff;
@property(nonatomic, copy) NSString *dtk_goods_onoff;
@property(nonatomic, copy) NSString *show_type_str;
@property(nonatomic, copy) NSString *goods_type_name;
@property(nonatomic, strong) NSArray *goods_msg;
@property(nonatomic, copy) NSString *show_name;
@property(nonatomic, copy) NSString *banner_speed;
@property(nonatomic, copy) NSString *banner_bili;

@end

NS_ASSUME_NONNULL_END
