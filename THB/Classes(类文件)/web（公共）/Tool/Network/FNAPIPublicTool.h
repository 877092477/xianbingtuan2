//
//  FNAPIPublicTool.h
//  LikeKaGou
//
//  Created by jimmy on 16/10/10.
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
#import "XYNetworkAPI.h"
#import "NSString+Times.h"
/**
 *  name: api 请求工具
 *
 * description: 
 *                     commender模式，其属性为所有请求的公共参数
 *                     可以用其子类扩展请求参数，建议每个请求模块分一个子类
 *                     公共方法为post请求，完成请求参数附值即可调用
 */
typedef void(^SuccessRequest)(id respondObject);
typedef void(^FailureRequest)(NSString* error);

@interface FNAPIPublicTool : NSObject
/**
 *  api url
 */
@property (nonatomic, copy)NSString* apiURL;
/**
 *  Time
 */
@property (nonatomic, copy)NSString* time;
/**
*  pagenumber
 */
@property (nonatomic, strong)NSNumber* p;
/**
 *  page size
 */
@property (nonatomic, strong)NSNumber* num;
/**
 *  请求网络
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)startRequestSuccess:(SuccessRequest)success failure:(FailureRequest)failure;


@end
