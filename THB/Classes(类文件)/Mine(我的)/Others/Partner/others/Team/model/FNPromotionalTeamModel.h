//
//  FNPromotionalTeamModel.h
//  SuperMode
//
//  Created by jimmy on 2017/10/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PTMfan;
@interface FNPromotionalTeamModel : NSObject
/**
 *  成员邀请的合伙人数量
 */
@property (nonatomic, copy)NSString* count_right;
/**
 *  我邀请的合伙人数量
 */
@property (nonatomic, copy)NSString* count;
/**
 *  累计人数
 */
@property (nonatomic, copy)NSString* all_count;
/**
 *  累计佣金
 */
@property (nonatomic, copy)NSString* sum;
/**
 *  数组
 */
@property (nonatomic, strong)NSArray<PTMfan *>* fan;
/**
 *  family
 */
@property (nonatomic, copy)NSString* family;

@end

@interface PTMfan:NSObject
/**
 *  ID
 */
@property (nonatomic, copy)NSString* ID;
/**
 *  头像
 */
@property (nonatomic, copy)NSString* head_img;
/**
 *  昵称
 */
@property (nonatomic, copy)NSString* nickname;
/**
 *  注册时间
 */
@property (nonatomic, copy)NSString* reg_time;
/**
 *  会员等级
 */
@property (nonatomic, copy)NSString* Vname;
/**
 *  贡献佣金
 */
@property (nonatomic, copy)NSString* commission;

/**
 *  td_ts
 */
@property (nonatomic, copy)NSString* td_ts;
/**
 *  extend_id
 */
@property (nonatomic, copy)NSString* extend_id;
/**
 *  count
 */
@property (nonatomic, copy)NSString* count;
/**
 *  is_sqdl
 */
@property (nonatomic, copy)NSString* is_sqdl;

@end
