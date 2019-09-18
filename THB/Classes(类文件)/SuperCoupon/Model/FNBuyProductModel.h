//
//  FNBuyProductModel.h
//  LikeKaGou
//
//  Created by jimmy on 16/9/29.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "FNBaseProductModel.h"

@interface FNBuyProductModel : FNBaseProductModel
/**
 *  orginal
 */
@property (nonatomic, copy)NSString* orgPrice;
/**
 *  discountPrice
 */
@property (nonatomic, copy)NSString* disPrice;
/**
 *  user
 */
@property (nonatomic, copy)NSString* userCount;
/**
 *  persent
 */
@property (nonatomic, copy)NSString* persent;
/**
 *  state
 */
@property (nonatomic, copy)NSString* state;


@property (nonatomic, copy) NSString *ID;

/**
 *  优惠券总数
 */
@property (nonatomic, copy) NSString *yhq_sum;

@property (nonatomic, copy) NSString *zhe;

/**
 *  多少人领优惠券
 */
@property (nonatomic, copy) NSString *yhq_n;

@property (nonatomic, copy) NSString *fbili;



#pragma mark - 优惠券列表
@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *shop;

@property (nonatomic, copy) NSString *yhq;











@end
