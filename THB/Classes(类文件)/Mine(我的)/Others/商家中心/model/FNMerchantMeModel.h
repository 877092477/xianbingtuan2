//
//  FNMerchantMeModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNMerchantMeModel : NSObject
@property (nonatomic, copy)NSString* type;
@property (nonatomic, copy)NSString* name;
@property (nonatomic, copy)NSString* name_color;
@property (nonatomic, copy)NSString* jiange;
@property (nonatomic, copy)NSString* img;
@property (nonatomic, copy)NSArray*  list;

@property (nonatomic, copy)NSString* left_line_color;
@property (nonatomic, copy)NSString* more_btn;
@property (nonatomic, copy)NSString* more_btn_color;
@end

@interface FNMerchantItemMeModel : NSObject
@property (nonatomic, copy)NSString* number;
@property (nonatomic, copy)NSString* tips;
@property (nonatomic, copy)NSString* number_color;
@property (nonatomic, copy)NSString* tips_color;
@property (nonatomic, assign)BOOL  lineState;

@property (nonatomic, copy)NSString*title;
@property (nonatomic, copy)NSString*banner_sort;
@property (nonatomic, copy)NSString*font_color;
@property (nonatomic, copy)NSString*url;
@property (nonatomic, copy)NSString*img;
@property (nonatomic, copy)NSString*SkipUIIdentifier;
@property (nonatomic, copy)NSString*jsonInfo;
@property (nonatomic, copy)NSString*yhq_price;
@property (nonatomic, copy)NSString*goods_price;
@property (nonatomic, copy)NSString*search_keyword;
@property (nonatomic, copy)NSString*goodsingle_lable;
@property (nonatomic, copy)NSString*is_brand;
@property (nonatomic, copy)NSString*is_live;
@property (nonatomic, copy)NSString*is_video;
@property (nonatomic, copy)NSString*dtk_goods_onoff;
@property (nonatomic, copy)NSString*fnuo_id;
@property (nonatomic, copy)NSString*shop_type;
@property (nonatomic, copy)NSString*goods_pd_onoff;
@property (nonatomic, copy)NSString*jdgoods_pd_onoff;
@property (nonatomic, copy)NSString*yhq_onoff;
@property (nonatomic, copy)NSString*start_price;
@property (nonatomic, copy)NSString*end_price;
@property (nonatomic, copy)NSString*goods_sales;
@property (nonatomic, copy)NSString*commission;
@property (nonatomic, copy)NSString*show_type_str;
@property (nonatomic, copy)NSString*double_bjimg;
@property (nonatomic, copy)NSString*name;
@property (nonatomic, copy)NSString*UIIdentifier;
@property (nonatomic, copy)NSString*type;
@property (nonatomic, copy)NSString*goodslist_img;
@property (nonatomic, copy)NSString*goodslist_str;
@property (nonatomic, copy)NSString*view_type;
@property (nonatomic, copy)NSString*is_showcate;
@property (nonatomic, copy)NSArray*goods_detail;
@property (nonatomic, copy)NSString*is_need_login;
@property (nonatomic, copy)NSString*keyword;
@property (nonatomic, copy)NSString*goods_type_name;
@property (nonatomic, copy)NSString*getGoodsType;
@property (nonatomic, copy)NSString*goods_msg;
@property (nonatomic, copy)NSString*goods_title;
@property (nonatomic, copy)NSString*goodsInfo;
@property (nonatomic, copy)NSString*show_name;
@property (nonatomic, copy)NSString*title_color;
@property (nonatomic, copy)NSString*time;
@property (nonatomic, copy)NSString*time_color;
@property (nonatomic, copy)NSString*price;
@property (nonatomic, copy)NSString*price_color;

//@property (nonatomic, copy)NSString*number;
@property (nonatomic, copy)NSString*icon;
//@property (nonatomic, copy)NSString*tips;
@property (nonatomic, copy)NSString*color;
@property (nonatomic, copy)NSString*yesterday_add;
@property (nonatomic, copy)NSString*yesterday_add_color;
@end


@interface FNMerchantHeadMeModel : NSObject
@property (nonatomic, copy)NSString* id;
@property (nonatomic, copy)NSString* name;
@property (nonatomic, copy)NSString* img;
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* set_btn;
@property (nonatomic, copy)NSString* color;
@property (nonatomic, copy)NSString* bili;
@property (nonatomic, copy)NSString* top_bj;
@property (nonatomic, copy)NSString* status;
@end
NS_ASSUME_NONNULL_END
