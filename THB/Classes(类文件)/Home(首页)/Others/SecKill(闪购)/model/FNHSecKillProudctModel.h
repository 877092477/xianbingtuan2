//
//  FNHSecKillProudctModel.h
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 16/8/4.
//  Copyright © 2016年 jimmy. All rights reserved.
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

@interface FNHSecKillProudctModel : FNBaseProductModel
/**
 *  sale persent
 */
@property (nonatomic, copy)NSString* soldPersent;
/**
 *  state
 */
@property (nonatomic, assign)BOOL state;
/**
 *  sold count
 */
@property (nonatomic, assign)NSInteger soldCount;
/**
 *  remind
 */
@property (nonatomic, assign)BOOL isRemind;
/**
 *  begin date
 */
@property (nonatomic, copy)NSString* beginDate;


//
@property (nonatomic, copy) NSString *ID;



@property (nonatomic, copy) NSString *str2;

@property (nonatomic, copy) NSString *str;

@property (nonatomic, copy) NSString *stock;

@property (nonatomic, copy) NSString *fcommissionshow;

@property (nonatomic, copy) NSString *tixing;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *count;

@property (nonatomic, copy) NSString *gid;

@property (nonatomic, copy)NSString* ds_price;

@property (nonatomic, copy)NSString* is_tlj;

@end
