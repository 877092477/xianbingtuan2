//
//  ALBBCustomWebViewController.h
//  THB
//
//  Created by zhongxueyu on 2017/4/12.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"

typedef enum : NSUInteger {
    DetailTypeInSite,
    DetailTypeOutSite,
} DetailType;
@interface ALBBCustomWebViewController : SuperViewController<UIWebViewDelegate, NSURLConnectionDelegate>

@property (strong, nonatomic) UIWebView *webView;
/**
 *  url
 */
@property (nonatomic, copy)NSString* url;
/**
 *  shop_id
 */
@property (nonatomic, copy)NSString* shop_id;

/**
 喜欢标志
 */
@property (nonatomic, copy)NSString* is_mylike;

/**
 商品ID
 */
@property (nonatomic, copy)NSString* ID;

/**
 商品img
 */
@property (nonatomic, copy)NSString* goods_img;

/**
 商品标题
 */
@property (nonatomic, copy)NSString* goods_title;


@property (nonatomic, copy)NSString* goods_cost_price;

@property (nonatomic, copy)NSString* yhq_price;

@property (nonatomic, copy)NSString* juanhou_price;

@property (nonatomic, copy)NSString* fcommission;

@property (nonatomic, copy)NSString* couponURL;

/**
 *  is show bottom
 */
@property (nonatomic, assign)BOOL isShow;
//@property (nonatomic, assign)BOOL iscoupon;
@property (nonatomic, assign)DetailType detailType;
@property (nonatomic, strong)FNBaseProductModel* product;


/**
 判断是否从fnuo_id pushed
 */
@property (nonatomic, assign)BOOL isPush;

/**
 判断是否外链
 */
@property (nonatomic, assign)BOOL isWeb;

/**
 判断是否不领
 */
@property (nonatomic, assign)BOOL isNotCoupon;
/**
 在商品中返回了一个字段is_not_dqst == 1  1不唤起手淘 0唤起手淘
 判断如果是1就不唤起手淘然后用fnuo_url打开 
 */
//@property (nonatomic, copy)NSString* is_not_dqst;
@property (nonatomic, copy)NSString* is_dq_yhqurl;

@end
