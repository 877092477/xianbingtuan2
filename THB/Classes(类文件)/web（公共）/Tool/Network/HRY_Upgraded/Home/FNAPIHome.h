//
//  FNAPIHome.h
//  THB
//
//  Created by jimmy on 2017/5/4.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNRequestTool.h"

@interface FNAPIHome : FNRequestTool
/**
 3.1幻灯片
 接口描述：用于获取首页幻灯片
 
 请求URL：
 
 ?act=api&ctrl=getSlides
 
 @param params 请求参数(Ps:参数只有time ,sign可传nil)
 @param success 成功回调
 @param failure 失败回调
 @param flag 是否隐藏错误提示
 */

+ (FNAPIHome *)apiHomeForBannerWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag;
/**
 3.2首页图标
 接口描述：首页图标
 
 请求URL：
 
 ?act=api&ctrl=getIcon
 
 @param params 请求参数(Ps:参数只有time ,sign可传nil)
 @param success 成功回调
 @param failure 失败回调
 @param flag 是否隐藏错误提示
 */

+ (FNAPIHome *)apiHomeForQuickEntranceWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag;
/**
 3.3首页分类导航
 接口描述：首页分类导航
 
 请求URL：
 
 ?act=api&ctrl=getCates
 
 @param params 请求参数(Ps:参数只有time ,sign可传nil)
 @param success 成功回调
 @param failure 失败回调
 @param flag 是否隐藏错误提示
 */

+ (FNAPIHome *)apiHomeForNavCategoriesWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag;

/**
 3.3首页分类导航
 接口描述：首页分类导航
 
 请求URL：
 
 ?act=api&ctrl=getCates
 
 @param params 请求参数(Ps:参数只有time ,sign可传nil)
 @param success 成功回调
 @param failure 失败回调
 @param flag 是否隐藏错误提示
 */

+ (FNAPIHome *)apiHomeForNewNavCategoriesWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag;

/**
 3.4首页商品
 接口描述：首页商品
 
 请求URL：
 
 ?act=api&ctrl=getGoods
 
 @param params 请求参数(Ps:参数只有time ,sign可传nil)
 @param success 成功回调
 @param failure 失败回调
 @param flag 是否隐藏错误提示
 */

+ (FNAPIHome *)apiHomeForNewProductsWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag;

/**
 3.4首页商品
 接口描述：首页商品
 
 请求URL：
 
 ?act=api&ctrl=getGoods
 
 @param params 请求参数(Ps:参数只有time ,sign可传nil)
 @param success 成功回调
 @param failure 失败回调
 @param flag 是否隐藏错误提示
 */

+ (FNAPIHome *)apiHomeForProductsWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag;

/**
 3.5首页商品弹框(新)
 接口描述：首页商品弹框
 
 请求URL：
 
 ?act=api&ctrl=getkuang
 
 @param params 请求参数(Ps:参数只有time ,sign可传nil)
 @param success 成功回调
 @param failure 失败回调
 @param flag 是否隐藏错误提示
 */

+ (FNAPIHome *)apiHomeForPromotionalProductWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag;

/**
 3.6首页中间图文（新）
 接口描述：首页中间图文
 
 请求URL：
 
 ?act=api&ctrl=gettuwen

 @param params 请求参数(Ps:参数只有time ,sign可传nil)
 @param success 成功回调
 @param failure 失败回调
 @param flag 是否隐藏错误提示
 */

+ (FNAPIHome *)apiHomeForSpecialAreaWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag;

/**
 3.7首页海报图（新）
 接口描述：正在热抢
 
 请求URL：
 
 ?act=api&ctrl=getpic
 
 @param params 请求参数
 @param success 成功回调
 @param failure 失败回调
 @param flag 是否隐藏错误提示
 */
+ (FNAPIHome *)apiHomeForPosterWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag;

/**
 3.7首页热搜头部栏目
 接口描述：热搜头部按钮
 
 请求URL：
 
 ?mod=appapi&act=appJdPdd&ctrl=getType
 
 @param params 请求参数
 @param success 成功回调
 @param failure 失败回调
 @param flag 是否隐藏错误提示
 */
+ (FNAPIHome *)apiHomeForHotSearchHeadColumnWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag;

#pragma mark - brand sale
/**
 1.1 店铺列表
 接口描述：店铺列表
 
 请求URL：
 
 ?act=api&ctrl=getDp
 
 @param params 请求参数
 @param success 成功回调
 @param failure 失败回调
 @param flag 是否隐藏错误提示
 */
+ (FNAPIHome *)apiBrandForStoreListWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag;

/**
 1.3品牌特卖分类
 接口描述：
 
 请求URL：
 
 ?mod=wap&act=Api&ctrl=getShopCates
 
 @param params 请求参数
 @param success 成功回调
 @param failure 失败回调
 @param flag 是否隐藏错误提示
 */
+ (FNAPIHome *)apiBrandForStoreCategoriesWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag;

#pragma mark - 商城返利
/**
 1.5商城返利幻灯片(俊)
 接口描述：用于获取商城返利幻灯片
 
 请求URL：
 
 ?mod=default&act=api&ctrl=getSlides
 
 @param params is_index 是否为首页	1是 0不是,如果不是传cid
 @param success 请求成功回调
 @param failure 请求失败回调
 */
+ (FNAPIHome *)apiHomeRequestRebateBannerWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag;
/**
 1.8商品详情最下面的显示（俊）
 接口描述：用于获取商品详情最下面的显示（1.1）
 
 请求URL：
 
 ?mod=mlt&act=xrfl&ctrl=tburl
 
 @param params is_index 是否为首页	1是 0不是,如果不是传cid
 @param success 请求成功回调
 @param failure 请求失败回调
 */

+ (FNAPIHome*)apiHomeRequestProductDetailToolWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag;

/**
 4.6红包提示设置
 接口描述：用于红包提示设置
 请求URL：
 
 ?mod=mlt&act=qhb&ctrl=hbtx
 
 @param params is_index 是否为首页	1是 0不是,如果不是传cid
 @param success 请求成功回调
 @param failure 请求失败回调
 */
+ (FNAPIHome*)apiHomeRequestSetNoticeWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag;

@end
