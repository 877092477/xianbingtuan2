//
//  FNHeroRankModel.h
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNHeroRankModel : NSObject
/**
 *  头像
 */
@property (nonatomic, copy)NSString* head_img;
/**
 *  排序数字
 */
@property (nonatomic, copy)NSString* num;
/**
 *  贡献佣金
 */
@property (nonatomic, copy)NSString* commission_sum;
/**
 *  昵称
 */
@property (nonatomic, copy)NSString* nickname;
/**
 *  dlfl_sum
 */
@property (nonatomic, copy)NSString* dlfl_sum;
/**
 *  logo图
 */
@property (nonatomic, copy)NSString* logo;
/**
 *  commission
 */
@property (nonatomic, copy)NSString* commission;

/**
 *  count
 */
@property (nonatomic, copy)NSString* count;
/**
 *  val
 */
@property (nonatomic, copy)NSString* val;
/**
 *  img
 */
@property (nonatomic, copy)NSString* img;
@end
