//
//  FNPublicMacros.h
//  优惠券列表
//
//  Created by jimmy on 16/10/25.
//  Copyright © 2016年 钟学瑜. All rights reserved.
//

#ifndef FNPublicMacros_h
#define FNPublicMacros_h

//other
#define FNKeyWindow [UIApplication sharedApplication].keyWindow
#define FNGetJSON(d) [NSString getStringFromJOSNData:(d)]//字典转JSON
#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;

//color

#define FNColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define FNColorAndAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define FNMainBarTintColor RED //导航栏颜色
#define FNMainGobalControlsColor RED   //全局主要控件高亮突出的颜色,如果有特殊请另外声明
#define FNMainGobalTextColor RED    //全局主要文字高亮的颜色,如果有特殊请另外声明
#define FNWhiteColor [UIColor whiteColor]
#define FNBlackColor [UIColor blackColor]
#define FNOrange FNColor (244,129,38)


#define FNBlackColorWithAlpha(a) [UIColor colorWithRed:(0)/255.0 green:(0)/255.0 blue:(0)/255.0 alpha:a]
#define FNHomeBackgroundColor  [UIColor colorWithHexString:@"eeeeee"]
#define FNDefaultBarColor  [UIColor colorWithHexString:@"ffffff"]
#define FNGlobalTextGrayColor [UIColor colorWithHexString:@"999999"]
#define FNGlobalTextDeepGrayColor [UIColor colorWithHexString:@"666666"]
#define FNMainTextNormalColor FNColor(134,135,136)
//sec kill
#define FNSecKillScheduleToolBgColor FNColor(55,50,44)

//params
#define APPKEY @"123"
#define SignKey @"sign"
#define TimeKey @"time"
#define platformkey @"platform"
#define systemVersionkey @"systemVersion"
#define versionkey @"version"
#define appVersionkey @"appVersion"
#define resolutionRatiokey @"resolutionRatio"
#define TokenKey @"token"
#define jiangeKey @"jiange"
#define typeKey @"type"
#define listKey @"list"
#define end_colorKey @"end_color"

#define TOKEN @"123"
#define PageNumber @"p"//页码

#define PageSize @"num"//页面条数
#define SuccessKey @"success"
#define SuccessValue @"1"
#define DataKey @"data"
#define MsgKey @"msg"


#ifdef DEBUG
#define XYLog(...)  NSLog(__VA_ARGS__)
#else
#define XYLog(...)
#endif

#define FNDeviceWidth  [UIApplication sharedApplication].keyWindow.bounds.size.width
#define FNDeviceHeight  [UIApplication sharedApplication].keyWindow.bounds.size.height
#define JMScreenWidth [UIScreen mainScreen].bounds.size.width
#define JMScreenHeight [UIScreen mainScreen].bounds.size.height

//为空键值对
#define FAST_Model_NoNull(dictname,value) [model valueForKey:dictname]!= nil &&[model valueForKey:dictname]!=[NSNull null]? [model valueForKey:dictname] : value;

// 适配宏
#define HeightRealValue(value) ((value/1334.0)*FNDeviceHeight)
#define SafeAreaTopHeight (JMScreenHeight == 812.0 ? 88 : 64)

//font size
#define FNFontDefault(f) [UIFont fontWithDevice:f];
#define FNGlobalFontNormalSize 14
#define FNNormalFont FNFontDefault(FNGlobalFontNormalSize)
#define LeftSpace 15
/** 这个类用来存放一些提示的声明 **/

#define XYNoLoginMsg   @"您当前处于未登录状态，登录之后购买才可以获得返利哦~"

//failuer reques
#define FNFailureRequest @"请求失败，请重试"
#define FNEmptyData @"暂无数据"

//notification 
#define FNNotificationCenter [NSNotificationCenter defaultCenter]
//Home
#define HomeEndCountdown @"end count down"

#define HomeEndRefresh @"end refresh"

#define JMEmptyCheck(a,b) [NSString emptyCheck:(a) replace:(b)]

/**四、商品 **/

//4.1商品详情
#define FNAPIProductOpDetail @"mod=appapi&act=yhq_goods&ctrl=goodsdetail"
#define TBPCURL @"https://buyertrade.taobao.com/trade/itemlist/list_bought_items.htm?spm=875.7931836/B.a2226mz.8.TwK3Pc&t=20110530"
#define TBH5URL @"https://h5.m.taobao.com/mlapp/olist.html?spm=a2141.7756461.2.6"


#define ResultStatusDict @{@"9000":ResultStatus9000,@"80006004":ResultStatus8000And6004,@"4000":ResultStatus4000,@"5000":ResultStatus5000,@"6001":ResultStatus6001,@"6002":ResultStatus6002}
#define ResultStatus9000 @"订单支付成功"
#define ResultStatus8000And6004 @"正在处理中,请查询订单的支付状态"
#define ResultStatus4000 @"订单支付失败"
#define ResultStatus5000 @"订单支付成功"
#define ResultStatus6001 @"您已取消支付"
#define ResultStatus6002 @"网络连接出错"
#define ResultOthers @"支付错误"


#define ExceptionStatus @"ExceptionStatus"

//缓存路径
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

#endif /* FNPublicMacros_h */
