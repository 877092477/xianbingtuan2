//
//  FNNetCouponeRechargeModel.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNNetCouponeRechargeCardModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *yhq_price;
@property (nonatomic, copy) NSString *pay_price;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *bjimg;
@property (nonatomic, copy) NSString *check_bjimg;
@property (nonatomic, copy) NSString *price_color;
@property (nonatomic, copy) NSString *cost_price_color;
@property (nonatomic, copy) NSString *price_str;
@property (nonatomic, copy) NSString *cost_price_str;

@end

@interface FNNetCouponeRechargePayModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *img;

@end

@interface FNNetCouponeRechargeModel : NSObject

@property (nonatomic, copy) NSString *top_title;
@property (nonatomic, copy) NSString *str;
@property (nonatomic, copy) NSString *str1;
@property (nonatomic, copy) NSString *coupon_str;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *btn_img;
@property (nonatomic, copy) NSString *btm_str;
@property (nonatomic, copy) NSString *rule_str;
@property (nonatomic, copy) NSString *rule_url;
@property (nonatomic, copy) NSString *pay_str;
@property (nonatomic, strong) NSArray<FNNetCouponeRechargeCardModel*> *card_list;
@property (nonatomic, strong) NSArray<FNNetCouponeRechargePayModel*> *pay_list;

@end

NS_ASSUME_NONNULL_END
