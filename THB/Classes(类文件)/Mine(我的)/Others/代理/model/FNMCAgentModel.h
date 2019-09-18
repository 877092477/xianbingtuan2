//
//  FNMCAgentModel.h
//  THB
//
//  Created by jimmy on 2017/8/1.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FNMCAgentTYModel;
@interface FNMCAgentModel : NSObject
/**
 *  	用户id
 */
@property (nonatomic, copy)NSString* ID;
/**
 *  头像
 */
@property (nonatomic, copy)NSString* head_img;
/**
 *  	昵称
 */
@property (nonatomic, copy)NSString* nickname;
/**
 *  	手机号
 */
@property (nonatomic, copy)NSString* phone;
/**
 *  账号余额
 */
@property (nonatomic, copy)NSString* dlcommission;
/**
 *  提现链接
 */
@property (nonatomic, copy)NSString* tx_url;
/**
 *  	本月预估收入
 */
@property (nonatomic, copy)NSString* byyg;
/**
 *  	上月预估收入
 */
@property (nonatomic, copy)NSString* syyg;
/**
 *  推广pid
 */
@property (nonatomic, copy)NSString* tg_pid;

@property (nonatomic, copy)NSString* str1;

@property (nonatomic, copy)NSString* str2;

@property (nonatomic, copy)NSString* icon;
/**
 *  今日or昨日数组
 */
@property (nonatomic, strong)NSArray<FNMCAgentTYModel *>* today_yes;
@end

@interface FNMCAgentTYModel : NSObject
/**
 *  	结算预估收入
 */
@property (nonatomic, copy)NSString* hl_money;
/**
 *  	付款笔数
 */
@property (nonatomic, copy)NSString* count;
/**
 *  money
 */
@property (nonatomic, copy)NSString* money;
@end
