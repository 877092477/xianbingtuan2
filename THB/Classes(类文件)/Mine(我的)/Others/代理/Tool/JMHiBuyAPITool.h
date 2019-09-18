//
//  JMHiBuyAPITool.h
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
#import "FNRequestTool.h"

@interface JMHiBuyAPITool : FNRequestTool
/**
 *1.1首页中间的5个广告
     接口描述：用于获取首页中间的5个广告
     
     请求URL：
     
     ?mod=defult&act=api&ctrl=midcategorynav
 *
 *  @param params  请求参数（时间轴，签名，时间）
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)apiHiBuyForHomeADWithParams:(NSMutableDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure;



/**
 1.3购买会员页面显示
 接口描述：用于获取购买会员页面显示
 
 请求URL：
 
 ?mod=appapi&act=vip&ctrl=upgrade

 @param params 请求参数（时间轴，签名，时间）
 @param success 成功回调
 @param failure  失败回调
 */
+ (void)apiHiBuyForUpgradeMemberWithParams:(NSMutableDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure;

/**
 1.4会员立即购买
 接口描述：用于会员立即购买
 
 请求URL：
 
 ?mod=appapi&act=payment&ctrl=vipRecharge
 
 @param params 请求参数（时间轴，签名，时间）
 @param success 成功回调
 @param failure  失败回调
 */
+ (void)apiHiBuyForUpgradeMemberOperatingWithParams:(NSMutableDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure;

/**
 1.9 嗨代言
 接口描述：用于获取嗨代言
 
 请求URL：
 
 ?mod=gh&act=dyshare&ctrl=index
 
 @param params 请求参数（时间轴，签名，时间）
 @param success 成功回调
 @param failure  失败回调
 */
+ (void)apiHiBuyForHiShareHomeWithParams:(NSMutableDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure;

/**
 1.10嗨代言介绍图
 接口描述：用于获取嗨代言介绍
 
 请求URL：
 
 ?mod=gh&act=ghdy&ctrl=index
 
 @param params 请求参数（时间轴，签名，时间）
 @param success 成功回调
 @param failure  失败回调
 */
+ (void)apiHiBuyForHiImageWithParams:(NSMutableDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure;
/**
 1.12收支明细
 接口描述：用于获取收支明细
 
 请求URL：
 
 ?mod=gh&act=ghdy&ctrl=szDetail
 
 @param params 请求参数（时间轴，签名，时间）
 @param success 成功回调
 @param failure  失败回调
 */
+ (void)apiHiBuyForMineBillWithParams:(NSMutableDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure;
/**
 1.15登录+验证码验证
 接口描述：用于获取登录+验证码验证
 
 请求URL：
 
 ?mod=gh&act=ghdy&ctrl=login
 
 @param params 请求参数（时间轴，签名，时间）
 @param success 成功回调
 @param failure  失败回调
 */
+ (void)apiHiBuyForLoginWithCodeWithParams:(NSMutableDictionary *)params success:(RequestSuccess)success failure:(RequestFailure)failure;

@end
