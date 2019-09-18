//
//  SuperViewController.h
//  THB
//
//  Created by zhongxueyu on 16/3/30.
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

#import "JMViewController.h"
#import "FNBaseProductModel.h"
#import "UIScrollView+EmptyDataSet.h"
#import <UShareUI/UShareUI.h>
#import "AlibabaAuthSDK/ALBBSDK.h"
/** 推广注册 **/
#define registerPromotion @"mod=wap&act=register&tgid="
static const NSInteger _jm_pageszie = 10;
typedef void(^EndRequestBlock)(NSString* error);
@interface SuperViewController : JMViewController
@property (nonatomic, strong)NSString* uniqueIdentifier;
@property (strong, nonatomic) UIWindow *window;


/**
 用于标记当前controller是否在Tabbar中显示，可以根据该属性显示/隐藏返回按钮，计算底部高度
 */
@property(nonatomic,assign)BOOL understand;

/** table view**/
@property (nonatomic,strong) UITableView* jm_tableview;

/** collection view**/
@property (nonatomic,strong) UICollectionView* jm_collectionview;

/** 是否要更新订单状态 **/
@property (nonatomic,assign) BOOL updateOrderStatus;

/** 订单号 **/
@property (nonatomic,strong) NSString *orderNum;

/** 页码 **/
@property (nonatomic,assign) NSInteger jm_page;
@property (nonatomic, strong)UIWebView* backwebview;

@property (nonatomic, strong)NSLayoutConstraint* btmcons;

@property (nonatomic, assign) BOOL isNeedLogin;


/**
 是否需要在tabbar中强制全屏显示，默认不需要
 如：抖券功能需要，重写该方法

 @return
 */
- (BOOL)isFullScreenShow;

/**
 是否需要登录

 @return 
 */
- (BOOL)needLogin;

- (void)warnToLogin;
- (void)gologin;
- (void)presentLogin;
/*
 **跳转到优惠券详情页
 **goodsID 产品Id
 **couponDes 优惠券描述
 **andCouponUrl 优惠券链接
*/
- (void)goToProductDetailsWithId:(NSString *)goodsID couponDes:(NSString *)couponDes andCouponUrl:(NSString *)url;

/*
 **跳转到网页详情页面
 webType:0.普通网页；1.淘宝网页;2.京东网页;3.带底部和提示的商城网页;
 jsonInfo: 网页头部json
 */
-(void)goWebDetailWithWebType:(NSString *)webType URL:(NSString *)url withHeaderInfo: (nullable NSString*)jsonInfo;
-(void)goWebDetailWithWebType:(NSString *)webType URL:(NSString *)url;

/*
 **跳转到产品的详情
 **传产品的Model
*/
-(void)goToProductDetailsWithModel:(id)productModel;
/*
 **跳转到产品的详情
 **传产品的Model
 */
-(void)goToJDProductDetailsWithModel:(id)productModel;
-(void)goToJDProductDetailsWithURL:(NSString*)url;
/*
 **跳转到产品的详情
 **传产品的Model
 */
-(void)goToPddProductDetailsWithModel:(id)productModel;
-(void)goToWphProductDetailsWithModel:(id)productModel;
/** 跳转到普通网页 **/
- (void)goWebWithUrl:(NSString *)url;

/** 抓取数据 **/
-(void)initWebViewMethod;

/** 把订单号分割成后台要的格式 **/
-(NSString *)getOrderNumMethod:(NSString *)orderNum;

/** 设置详情页打开方式 **/
-(void)initBaiChuanSDKMethod:(BOOL)setIsForceH5;

/**
 go other page

 @param model model
 */
//- (void)goToOtherPageWithModel:(id)model;
/**
跳转百川

 @param ID ID
 */
-(void)goTBDetailWithID:(NSString *)ID animated:(BOOL)animated;




/**
 通过fnuo_id，一般只用于免单商品跳转

 @param fnuo_id fnuo_id
 @param pid pid
 @param adzoneId adzoneId
 @param APP_alliance_appkey APP_alliance_appkey 
 */
- (void)openDetailWithID: (NSString*)fnuo_id withPid: (NSString*)pid adzoneId: (NSString*)adzoneId APP_alliance_appkey: (NSString*)APP_alliance_appkey;


/**
 跳转到商品详情

 @param model 商品model
 @param data json数据，可加快接口请求速度
 @param isLive isLive
 */
- (void)goProductVCWithModel:(id)model withData: (nullable NSDictionary*)data isLive: (BOOL)isLive;

/**
 跳转到商品详情

 @param model 商品model
 @param data json数据，可加快接口请求速度
 */
- (void)goProductVCWithModel:(id)model withData: (nullable NSDictionary*)data;

/**
 go to product vc

 @param model model
 */
- (void)goProductVCWithModel:(id)model;

/**
 load baichun page without coupon

 @param url :loaded url
 */
- (void)goBaiChunWithoutCoupon:(NSString*)url;
/**
 share product action

 @param model model
 */
- (void)shareProductWithModel:(id)model;


/**
 是否已经授权验证

 */
- (void)authShare:(void (^) (BOOL isAuthed))block;


/**
 分享小程序

 @param title 标题
 @param content 内容
 @param image 图片
 @param username 小程序username，如 gh_3ac2059ac66f
 @param path 小程序页面路径，如 pages/page10007/page10007
 @param webpageUrl 兼容微信低版本网页地址
 */
- (void)shareMiniProgram: (NSString*)title content: (NSString*)content image: (UIImage*)image username: (NSString*)username path: (NSString*)path webpageUrl: (NSString*)webpageUrl;

- (void)umengShareWithURL:(NSString *)url image:(id)image shareTitle:(NSString *)shareTitle andInfo:(NSString *)info withType:(UMSocialPlatformType)type;
- (void)umengShareWithURL:(NSString *)url image:(id)image shareTitle:(NSString*)shareTitle andInfo:(NSString *)info;

/**
 It's for loading other view controller

 @param model : the data source for vc ,including the sign of the view controller that you wanna show
 @param info : additional info
 */
- (void)loadOtherVCWithModel:(id)model andInfo:(id)info outBlock:(void (^) (id info))block;

/**
 跳转会员升级
 */
- (void)loadMembershipUpgradeViewController;

//-(void)openDetailWithModel:(id)model;

/**
 刷新基本设置

 @param is_share 只在需要分享/升级前调用的基本设置传YES，其它情况不传
 @param block
 */
- (void)refreshSetting:(BOOL)is_share block: (void(^)(void)) block;
- (void)refreshSetting: (void(^)(void)) block;
- (BOOL)showNeedAuth: (void(^)(BOOL)) block;
- (BOOL)showNeedSwitchAccount: (void(^)(BOOL)) block;
- (void)setIllegal: (BOOL)isIllegal block: (void(^)(BOOL)) block  ;

-(void)bcAuth: (void(^)())callback;

//普通跳转
-(void)didFNSkipController:(NSString*)controller;
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;


-(void)jumpToActionFromWebJSMethod:(NSString *)identifier data:(id)data;

//- (void)apiRequesteDetail: (NSString*)url;
@end
