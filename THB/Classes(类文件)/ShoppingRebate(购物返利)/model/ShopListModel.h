//
//  ShopListModel.h
//  THB
//
//  Created by zhongxueyu on 16/4/8.
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

#import <Foundation/Foundation.h>


@interface ShopListModel : NSObject

@property (nonatomic, assign) NSInteger success;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *shop_name;

@property (nonatomic, copy) NSString *scdg_logo;

@property (nonatomic, copy) NSString *scdg_dizhi;

@property (nonatomic, copy) NSString *scdg_bili;

@property (nonatomic, copy) NSString *returnbili;
@property (nonatomic, copy) NSString *scxq_url;
/**
 *  scdg_intr
 */
@property (nonatomic, copy)NSString* scdg_intr;

@end

