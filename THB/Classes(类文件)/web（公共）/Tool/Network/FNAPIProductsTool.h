//
//  FNAPIProductsTool.h
//  LikeKaGou
//
//  Created by jimmy on 16/10/12.
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

#import "FNAPIPublicTool.h"
/**
 *  商品api请求
 */
@interface FNAPIProductsTool : FNAPIPublicTool
/**
 *  goods id
 */
@property (nonatomic, copy)NSString* gid;
/**
 *  优惠券类型
 */
@property (nonatomic, strong)NSNumber* type;
/**
 *  分类id
 */
@property (nonatomic, copy)NSString* cid;
/**
 *  搜索关键字
 */
@property (nonatomic, copy)NSString* keyword;
/**
 *  sort
 */
@property (nonatomic, strong)NSNumber* sort;
/**
 *  start_price
 */
@property (nonatomic, copy)NSString* start_price;
/**
 *  end_price
 */
@property (nonatomic, copy)NSString* end_price;
/**
 *  is_tmall
 */
@property (nonatomic, copy)NSNumber* is_tmall;


/**
 *  商品详情请求
 *
 *  @param goodId  请求参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)apiProductsRequestProdetailWithGoodsId:(NSString *)goodId success:(SuccessRequest)
success failure:(FailureRequest)failure;
/**
 *  优惠券商品列表请求
 *
 *  @param params  请求参数（类型：1 热门排行。2 新品推荐。3 精选专题。4 爱米铺独家。5 领券购。6 九块九，cid(分类id)
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)apiProductsRequestCouponListWithParams:(NSMutableDictionary *)params success:(SuccessRequest)success failure:(FailureRequest)failure;
@end
