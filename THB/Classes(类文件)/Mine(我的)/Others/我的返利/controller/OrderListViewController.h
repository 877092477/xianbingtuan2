//
//  OrderListViewController.h
//  THB
//
//  Created by zhongxueyu on 16/4/6.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有 2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import <UIKit/UIKit.h>
#import "SuperViewController.h"

#import "secondViewController.h"
#import "ALBBDetailsViewController.h"
@interface OrderListViewController : SuperViewController

/** 订单类型 1.淘宝 2.商城 3.京东 4.拼多多 */
@property (nonatomic,assign) NSNumber *type;

/** 订单状态 0.全部 1.未结算 2.已结算 3.无效订单 */
@property (nonatomic,assign) NSNumber *statu;
@end
