//
//  FNCandiesMyModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNCandiesMyModel : NSObject

@property (nonatomic, copy)NSString* qkb_name;
@property (nonatomic, copy)NSString* dwqkb_all_counts;
@property (nonatomic, copy)NSString* dwqkb_top_bj;
@property (nonatomic, copy)NSString* dwqkb_top_color;
@property (nonatomic, copy)NSString* dwqkb_wode_str;
@property (nonatomic, copy)NSString* dwqkb_explain_str;
@property (nonatomic, copy)NSString* dwqkb_exchange_btn;
@property (nonatomic, copy)NSString* dwqkb_shouyi_btn;
@property (nonatomic, copy)NSString* dwqkb_index_page_color;
@property (nonatomic, copy)NSString* dwqkb_index_page_tips_color;
@property (nonatomic, copy)NSString* dwqkb_my_growth_str;
@property (nonatomic, copy)NSString* dwqkb_my_growth_btn;
@property (nonatomic, copy)NSString* dwqkb_my_sxf_str;
@property (nonatomic, copy)NSString* dwqkb_all_counts_str;
@property (nonatomic, copy)NSString* dwqkb_exitst_counts_str;
@property (nonatomic, copy)NSString* dwqkb_remnant_counts_str;
@property (nonatomic, copy)NSString* dwqkb_rank_list_btn;
@property (nonatomic, copy)NSString* dwqkb_icon;
@property (nonatomic, copy)NSString* list_bj;
@property (nonatomic, copy)NSString* qkb_counts;
@property (nonatomic, copy)NSArray* operation;
@property (nonatomic, copy)NSArray* numerical_value;
@property (nonatomic, copy)NSString* exitst_counts;
@property (nonatomic, copy)NSString* remnant_counts;
@property (nonatomic, copy)NSString* qkb_price;
@property (nonatomic, copy)NSString* qkb_price_str;

@property (nonatomic, copy)NSString* growth;
@property (nonatomic, copy)NSString* sxf;
@property (nonatomic, copy)NSString* dwqkb_rank_is_show;
@property (nonatomic, copy)NSString* dwqkb_all_counts1;
@property (nonatomic, copy)NSString* btn;
@end

@interface FNCandiesMyoperationItemModel : NSObject

@property (nonatomic, copy)NSString* icon;
@property (nonatomic, copy)NSString* str;
@property (nonatomic, copy)NSString* tips;
@property (nonatomic, copy)NSString* type;


@property (nonatomic, copy)NSString* btn;
@property (nonatomic, copy)NSString* counts;
@property (nonatomic, copy)NSString* circle_color;
@end


NS_ASSUME_NONNULL_END
