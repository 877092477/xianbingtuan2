//
//  BannerModel.h
//  FnuoApp
//
//  Created by zhongxueyu on 16/2/24.
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

@interface BannerModel : NSObject


@property (nonatomic, assign) NSInteger success;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *slide_id;

@property (nonatomic, copy) NSString *webType;

@property (nonatomic, copy)NSString* view_type;

@end

