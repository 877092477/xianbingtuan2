//
//  FNMineHeaderModel.h
//  THB
//
//  Created by Weller Zhao on 2018/12/27.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNNMineGradeModel : NSObject

@property (nonatomic, copy) NSString* jfdh_onoff;
@property (nonatomic, copy) NSString* str;
@property (nonatomic, copy) NSString* str1;
@property (nonatomic, copy) NSString* str2;
@property (nonatomic, copy) NSString* str_color;
@property (nonatomic, copy) NSString* str_color1;
@property (nonatomic, copy) NSString* str_color2;
@property (nonatomic, copy) NSString* val_color;
@property (nonatomic, copy) NSString* mem_jf_bjimg;
@property (nonatomic, copy) NSString* mem_jf_ico;
@property (nonatomic, copy) NSString* mem_jf_ico1;
@property (nonatomic, copy) NSString* integral;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, strong) NSArray<MenuModel*> *list;

@end

@interface FNMineHeaderModel : NSObject

@property (nonatomic, copy) NSString* tgid;
@property (nonatomic, copy) NSString* tid;
@property (nonatomic, copy) NSString* head_img;
@property (nonatomic, copy) NSString* nickname;
@property (nonatomic, copy) NSString* color;
@property (nonatomic, copy) NSString* bj_img;
@property (nonatomic, copy) NSString* vip_btn_str;
@property (nonatomic, copy) NSString* vip_btn_color;
@property (nonatomic, copy) NSString* vip_btn_fontcolor;
@property (nonatomic, copy) NSString* is_vip_max;
@property (nonatomic, copy) NSString* vip_color;
@property (nonatomic, copy) NSString* vip_logo;
@property (nonatomic, copy) NSString* vip_name;
@property (nonatomic, copy) NSString* is_vip_btn_show;
@property (nonatomic, copy) NSString* user_top_img_bili;

@property (nonatomic, copy) NSString* is_need_location;
@property (nonatomic, copy) NSString* location_title;
@property (nonatomic, copy) NSString* location_tip;
@property (nonatomic, copy) NSString* is_force_location;

@property (nonatomic, copy) NSString* all_sum;
@property (nonatomic, copy) NSString* sum_str;
@property (nonatomic, copy) NSString* sum_btn_str;
@property (nonatomic, copy) NSString* sum_ico;
@property (nonatomic, copy) NSString* sum_bjimg;
@property (nonatomic, copy) NSString* sum_onoff;
@property (nonatomic, copy) NSString* SkipUIIdentifier;
@property (nonatomic, copy) NSString* sum_str_color;
@property (nonatomic, copy) NSString* sum_val_color;
@property (nonatomic, copy) NSString* sum_btn_color;

@property (nonatomic, copy) NSString* couponlimit_bjimg;
@property (nonatomic, copy) NSString* coupon_money;
@property (nonatomic, copy) NSString* coupon_info;
@property (nonatomic, copy) NSString* coupon_info_color;
@property (nonatomic, copy) NSString* coupon_show;

@property (nonatomic, strong) FNNMineGradeModel* jf_data;

@end

NS_ASSUME_NONNULL_END
