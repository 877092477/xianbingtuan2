//
//  FNProfitStatisticsModel.h
//  SuperMode
//
//  Created by jimmy on 2017/10/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PStoday_yes;
@interface FNProfitStatisticsModel : NSObject
/**
 *  累计收益
 */
@property (nonatomic, copy)NSString* commission_sum;
/**
 *  提现链接
 */
@property (nonatomic, copy)NSString* tx_url;
/**
 *  结算收入 本月结算
 */
@property (nonatomic, copy)NSString* byjs;
/**
 *  ID
 */
@property (nonatomic, copy)NSString* ID;
/**
 *  结算收入 上月结算
 */
@property (nonatomic, copy)NSString* syjs;
/**
 *  预估收入 上月预估
 */
@property (nonatomic, copy)NSString* syyg;
/**
 *  累计团队推广收益
 */
@property (nonatomic, copy)NSString* team_sum;
/**
 *  预估收入 本月预估
 */
@property (nonatomic, copy)NSString* byyg;
/**
 *  累计自己推广收益
 */
@property (nonatomic, copy)NSString* own_sum;
/**
 *  可用余额
 */
@property (nonatomic, copy)NSString* dlcommission;

@property (nonatomic, copy)NSString* str1;

@property (nonatomic, copy)NSString* str2;

@property (nonatomic, copy)NSString* icon;

/**
 *  today_yes
 */
@property (nonatomic, strong)NSArray<PStoday_yes *>* today_yes;


@end
@interface PStoday_yes:NSObject
/**
 *  自己推广
 */
@property (nonatomic, copy)NSString* money;
/**
 *  团队推广
 */
@property (nonatomic, copy)NSString* teammoney;
/**
 *  预估收入
 */
@property (nonatomic, copy)NSString* hl_money;

@end
