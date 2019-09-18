//
//  FNAPIMine.h
//  THB
//
//  Created by jimmy on 2017/5/22.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNRequestTool.h"

@interface FNAPIMine : FNRequestTool
/**
 4.0.0获取验证码
 例子：http://192.168.0.135:8080/v55/?act=api&ctrl=getcode
 
 @param params 请求参数(Ps:参数只有time ,sign可传nil)
 @param success 成功回调
 @param failure 失败回调
 @param flag 是否隐藏错误提示
 */

+ (FNAPIMine *)apiMineForGetCodeWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag;
/**
 4.0.1检验验证码
 例子：http://192.168.0.135:8080/v55/?act=api&ctrl=checkcode
 
 @param params 请求参数(Ps:参数只有time ,sign可传nil)
 @param success 成功回调
 @param failure 失败回调
 @param flag 是否隐藏错误提示
 */

+ (FNAPIMine *)apiMineForCheckCodeWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag;
/**
 4.10邀请好友 实时文字（左上角）
 接口描述：用于邀请好友 实时文字（左上角）
 
 请求URL：
 
 ?mod=mlt&act=xrfl&ctrl=yqdt
 
 @param params 请求参数(Ps:参数只有time ,sign可传nil)
 @param success 成功回调
 @param failure 失败回调
 @param flag 是否隐藏错误提示
 */

+ (FNAPIMine *)apiMineRequestInvitedTestWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag;
/**
 1.6邀请好友页面（俊）
 接口描述：用于获取店铺列表
 
 请求URL：
 
 ?mod=mlt&act=xrfl&ctrl=yqFriend
 
 @param params 请求参数(Ps:参数只有time ,sign可传nil)
 @param success 成功回调
 @param failure 失败回调
 @param flag 是否隐藏错误提示
 */

+ (FNAPIMine *)apiMineRequestFriendsInvitedWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag;
/**
 1.13收支明细
 接口描述：用于获取收支明细
 
 请求URL：
 
 ?mod=gh&act=ghdy&ctrl=szDetail
 
 @param params 请求参数(Ps:参数只有time ,sign可传nil)
 @param success 成功回调
 @param failure 失败回调
 @param flag 是否隐藏错误提示
 */

+ (FNAPIMine *)apiMineApiForMineBillWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag;
/**
 5.0会员中心图标
 简要描述：
 
 会员中心图标
 请求URL：
 
 ?mod=appapi&act=dg_userico
 
 @param params 请求参数(Ps:参数只有time ,sign可传nil)
 @param success 成功回调
 @param failure 失败回调
 @param flag 是否隐藏错误提示
 */

+ (FNAPIMine *)apiMineApiForMineFunctionsWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag;

@end
