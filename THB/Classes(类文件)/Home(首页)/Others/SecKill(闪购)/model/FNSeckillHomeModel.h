//
//  FNSeckillHomeModel.h
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 16/11/15.
//  Copyright © 2016年 方诺科技. All rights reserved.
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

@class App_Miaosha_Time;
@interface FNSeckillHomeModel : NSObject

@property (nonatomic, copy) NSString *app_miaosha_title;

@property (nonatomic, strong) NSArray<App_Miaosha_Time *> *app_miaosha_time;

@property (nonatomic, copy) NSString *app_miaosha_title2;

@end
@interface App_Miaosha_Time : NSObject

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *str;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *check;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *str_status;

@end

