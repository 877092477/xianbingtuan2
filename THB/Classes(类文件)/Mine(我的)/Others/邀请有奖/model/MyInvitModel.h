//
//  MyInvitModel.h
//  THB
//
//  Created by zhongxueyu on 16/5/1.
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

@interface MyInvitModel : NSObject


@property (nonatomic, copy) NSString *uid;

@property (nonatomic, assign) CGFloat fcommission;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *lv;

@property (nonatomic, copy) NSString *orderStatus;

@end

