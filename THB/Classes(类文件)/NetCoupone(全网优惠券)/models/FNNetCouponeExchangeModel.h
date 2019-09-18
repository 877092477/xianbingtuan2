//
//  FNNetCouponeExchangeModel.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/9.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNNetCouponeExchangeModel : NSObject
@property (nonatomic, copy) NSString* top_title;
@property (nonatomic, copy) NSString* top_right_btn;
@property (nonatomic, copy) NSString* rule_img;
@property (nonatomic, copy) NSString* rule_url;
@property (nonatomic, copy) NSString* str;
@property (nonatomic, copy) NSString* str_color;
@property (nonatomic, copy) NSString* coupon_money;
@property (nonatomic, copy) NSString* coupon_money_color;
@property (nonatomic, copy) NSString* lj_str;
@property (nonatomic, copy) NSString* lj_str_color;
@property (nonatomic, copy) NSString* coupon_bjimg;
@property (nonatomic, copy) NSString* bjimg;
@property (nonatomic, copy) NSString* btn_img;
@property (nonatomic, copy) NSString* info_img;
@property (nonatomic, copy) NSString* sao_img;
@property (nonatomic, copy) NSString* input_str;
@property (nonatomic, copy) NSString* info_str;
@property (nonatomic, copy) NSString* info_color;
@property (nonatomic, copy) NSString* info_bjcolor;
@property (nonatomic, strong) NSArray<NSDictionary*>* btm_str;
@property (nonatomic, copy) NSString* bjcolor;
@end

NS_ASSUME_NONNULL_END
