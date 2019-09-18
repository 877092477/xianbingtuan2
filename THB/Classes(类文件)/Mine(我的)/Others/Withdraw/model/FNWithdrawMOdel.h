//
//  FNWithdrawMOdel.h
//  SuperMode
//
//  Created by jimmy on 2017/6/27.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNWithdrawMOdel : NSObject

/**
 *     topImg
 */
@property (nonatomic, copy)NSString* topImg;

/**
 *     topStr1
 */
@property (nonatomic, copy)NSString* topStr1;

/**
 *     topStr2
 */
@property (nonatomic, copy)NSString* topStr2;

/**
 *     topStr6
 */
@property (nonatomic, copy)NSString* topStr6;

/**
 *     topStr3
 */
@property (nonatomic, copy)NSString* topStr3;

/**
 *     icon
 */
@property (nonatomic, copy)NSString* icon;
/**
 *  金额
 */
@property (nonatomic, copy)NSString* money;
/**
 *  可提现余额
 */
@property (nonatomic, copy)NSString* moneyStr;
/**
 *  温馨提示
 */
@property (nonatomic, copy)NSString* wxStr;
/**
 *  最低提现
 */
@property (nonatomic, copy)NSString* txStr;
/**
 *  	最低提现金额
 */
@property (nonatomic, copy)NSString* txXiaxian;

/**
 *     phone
 */
@property (nonatomic, copy)NSString* phone;


/**
 提现手续费(百分比)
 */
@property (nonatomic, copy)NSString* bili;

@end
