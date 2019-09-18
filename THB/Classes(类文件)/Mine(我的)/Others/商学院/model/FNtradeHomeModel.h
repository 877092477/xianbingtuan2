//
//  FNtradeHomeModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNtradeHomeModel : NSObject
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* select_tips;
@property (nonatomic, copy)NSString* recommend_icon;
@property (nonatomic, copy)NSString* banner_bili;
@property (nonatomic, copy)NSArray*  banner;
@property (nonatomic, copy)NSArray*  cate;
@end


@interface FNtradeHomeBannerItemModel : NSObject
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* id;
@property (nonatomic, copy)NSString* img;
@property (nonatomic, copy)NSString* SkipUIIdentifier;
@property (nonatomic, copy)NSString* url;
@property (nonatomic, copy)NSString* sort;
@property (nonatomic, copy)NSString* status;
@property (nonatomic, copy)NSString* create_time;
@property (nonatomic, copy)NSString* UIIdentifier;
@property (nonatomic, copy)NSString* name;
@property (nonatomic, copy)NSString* type;
@property (nonatomic, copy)NSString* view_type;
@property (nonatomic, copy)NSString* goodslist_img;
@property (nonatomic, copy)NSString* goodslist_str;
@property (nonatomic, copy)NSArray* goods_detail;
@property (nonatomic, copy)NSString* is_need_login;
@property (nonatomic, copy)NSString* integral_id;
@property (nonatomic, copy)NSString* fnuo_id;
@property (nonatomic, copy)NSString* shop_type;
@property (nonatomic, copy)NSString* start_price;
@property (nonatomic, copy)NSString* end_price;
@property (nonatomic, copy)NSString* commission;
@property (nonatomic, copy)NSString* goods_sales;
@property (nonatomic, copy)NSString* keyword;
@property (nonatomic, copy)NSString* yhq_onoff;
@property (nonatomic, copy)NSString* goods_pd_onoff;
@property (nonatomic, copy)NSString* dtk_goods_onoff;
@property (nonatomic, copy)NSString* show_type_str;
@property (nonatomic, copy)NSString* goods_type_name;
@property (nonatomic, copy)NSString* getGoodsType;
@property (nonatomic, copy)NSString* share_title;
@property (nonatomic, copy)NSString* share_content;
@property (nonatomic, copy)NSString* share_img;
@property (nonatomic, copy)NSString* goods_msg;
@property (nonatomic, copy)NSString* goods_title;
@property (nonatomic, copy)NSString* goodsInfo;
@property (nonatomic, copy)NSString* jsonInfo;
@property (nonatomic, copy)NSString* check_font_color;
@property (nonatomic, copy)NSString* font_color;
@property (nonatomic, copy)NSString* show_name;
@end

@interface FNtradeHomeCateItemModel : NSObject
@property (nonatomic, copy)NSString* id;
@property (nonatomic, copy)NSString* name;
@property (nonatomic, copy)NSString* img;
@property (nonatomic, copy)NSString* is_video;
@end

@interface FNtradeHomeRecommendItemModel : NSObject 

@property (nonatomic, copy)NSString* id;
@property (nonatomic, copy)NSString* thumbnail;
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* author;
@property (nonatomic, copy)NSString* browse;
@property (nonatomic, copy)NSString* type;
@property (nonatomic, copy)NSString* create_time;
@property (nonatomic, copy)NSString* play_icon;
@property (nonatomic, copy)NSString* browse_icon;
@property (nonatomic, copy)NSString* time_icon;
@property (nonatomic, copy)NSString* atricle_url;
@end

NS_ASSUME_NONNULL_END
