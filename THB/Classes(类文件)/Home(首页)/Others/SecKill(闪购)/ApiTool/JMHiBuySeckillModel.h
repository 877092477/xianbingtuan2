//
//  JMHiBuySeckillModel.h
//  THB
//
//  Created by jimmy on 2017/3/29.
//  Copyright © 2017年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */
#import <Foundation/Foundation.h>
@class FNHSecKillProudctModel;
@interface JMHiBuySeckillModel : NSObject
/**
 *  倒计时
 */
@property (nonatomic, copy)NSString* end_time;
/**
 *  title
 */
@property (nonatomic, copy)NSString* str_index;
/**
 *  数量
 */
@property (nonatomic, copy)NSString* qg_count;
/**
 *  商品
 */
@property (nonatomic, strong)NSArray<FNHSecKillProudctModel *>* goods;

@end
