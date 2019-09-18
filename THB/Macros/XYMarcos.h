//
//  XYMarcos.h
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

#ifndef XYMarcos_h
#define XYMarcos_h
//只在debug下才输出日志, 在程序运行时取消log
#ifdef DEBUG
#define XYLog(...)  NSLog(__VA_ARGS__)
#else
#define XYLog(...)
#endif
#define iOS9   ([UIDevice currentDevice].systemVersion.floatValue>=9.0)
//调用函数
#define LogFun  MyLog(@"%s",__func__);

//输出视图的frame边界
#define LogFrame(view)  MyLog(@"%@",NSStringFromCGRect(view.frame) );

#define IMAGE(imageName)        ([UIImage imageNamed:imageName])  // 创建图片
#define URL(url)                ([NSURL URLWithString: url])
//输出所有子视图
#define LogSubviews(view)  MyLog(@"%@",view.subviews);

#define iOS7   ([UIDevice currentDevice].systemVersion.floatValue>=7.0)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ColorWithRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

/**
 *  各种KEY
 */
#define APPKEY @"123"

#define XYSuccess                 @"success"
#define XYMessage                 @"msg"
#define XYData                    @"data"
#define XYRows                    @"rows"
#define XYTotal                   @"total"
#define XYErrorCheckNetwork       @"请检查网络..."
#define XYErrorSeverError         @"服务器错误"
#define XYMsg                     @"没有更多数据了"
#define XYAddLikeMsg              @"已添加到我的喜欢列表"
#define XYAddSorderLikeMsg        @"已添加到我喜欢的晒单列表"
#define XYDeleteLikeMsg           @"已取消喜欢"
#define XYDeleteSOrderMsg         @"已删除"
#define XYAddFlowerMsg            @"您的鲜花已送出~"
#define XYAddFollowMsg            @"已添加关注"
#define XYDeleteFollowMsg         @"已取消关注"


#define XYNoLoginMsg   @"您当前处于未登录状态，登录之后购买才可以获得返利哦~"
#define XYOtherLogin   @"您的账号在其他终端登陆，请重新登陆！"
#define NoToken   @"请先登录"
#define NoLoginMsgTime  1
#define TIME_LONG_NOW   ([[NSDate date] timeIntervalSince1970])   // 现在的时间戳
#define VIEW_GET_WIDTH(VIEW)    (VIEW.frame.size.width)           // 获取view的宽度
#define TIME 1  //提示时间
//颜色
#define SAMColor(r, g, b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
/**
 *  UI相关
 */
#define XYScreenWidth ([[UIScreen mainScreen]bounds].size.width)
#define XYScreenHeight ([[UIScreen mainScreen]bounds].size.height)
#define XYScreenBounds ([[UIScreen mainScreen] bounds])
//#define XYStatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define XYOnePixelHeight (1.0/[[UIScreen mainScreen] scale])
#define XYScreenScale  ([[UIScreen mainScreen] scale])
#define XYTabBarHeight  (isIphoneX ? 83: 49.0)
//#define XYTabBarHeight  49


/**
 *  用户信息相关
 */
#define XYAccessToken                       @"accessToken"

#define XYLoginData                           @"loginData"
#define XYUserID                            @"userId"
#define XYUserNick                          @"nickname"
#define XYUserPhone                         @"phone"
#define XYhead_img                          @"head_img"
#define XYrealname                          @"realname"
#define XYvip                               @"vip"
#define XYintegral                          @"integral"
#define XYemail                             @"email"
#define XYtaobao_au                         @"taobao_au"
#define XYqq                                @"qq"
#define XYqq_au                             @"qq_au"
#define XYsina_au                           @"sina_au"
#define XYzfb_au                            @"zfb_au"
#define XYmoney                             @"money"
#define XYmoney2                             @"money2"

#define XYgrowth                            @"growth"
#define XYsex                               @"sex"
#define XYloginname                         @"loginname"
#define XYcheckNum                          @"checkNum"
#define XYcheckTime                         @"checkTime"
#define XYReturnMoney                       @"returnmoney"
#define XYTid                               @"tid"
#define XYthree_nickname                    @"three_nickname"
#define XTrealname                          @"realname"
#define XYlike_count                        @"like_count"
#define XYInvitImg                          @"InvitImg"
#define XYtotalAward                        @"totalAward"
#define XYLaunchImg                         @"launchImg"
#define XYLaunchData                        @"launchData"
#define XYShareImg                          @"ShareImg"
#define XYShareWord                         @"ShareWord"
#define XYAddress                           @"address"
#define XYProvince                          @"Province"
#define XYCity                              @"City"
#define XYDistrict                          @"District"
#define XYcount                             @"count"
#define XYQQOpenID                          @"openid"
#define XYMeunHeight                        @"height"
#define XYFcommission                       @"commission"
#define FromNoti                            @"fromNoti"
#define XYisNeedTid                         @"isNeedTid"
#define XYFindGoods                         @"FindGoods"
#define XYisShake                           @"isShake"
#define XYzztx                    @"zztx"
#define XYlhbtx                    @"lhbtx"
#define XYhbtx                    @"hbtx"
#define XYgywm                  @"gywm"
#define XYextend_id              @"extend_id"
#define XYVoiceMute              @"isVoiceMute"
/**
 * 定位相关
 */
#define XYCITY                                @"city"
#define XYNomalCITY                           @"nomalCity"

#define SetFromNoti  [[NSUserDefaults standardUserDefaults] valueForKey:FromNoti]
#define UserisShake  [[NSUserDefaults standardUserDefaults] valueForKey:XYisShake]?[[NSUserDefaults standardUserDefaults] valueForKey:XYisShake]:@""

#define CITY  [[NSUserDefaults standardUserDefaults] valueForKey:XYCITY]

#define NomalCITY  [[NSUserDefaults standardUserDefaults] valueForKey:XYNomalCITY]


#define UserQQOpenID  [[NSUserDefaults standardUserDefaults] valueForKey:XYQQOpenID]?[[NSUserDefaults standardUserDefaults] valueForKey:XYQQOpenID]:@""

#define UserAccessToken  [[NSUserDefaults standardUserDefaults] valueForKey:XYAccessToken]?[[NSUserDefaults standardUserDefaults] valueForKey:XYAccessToken]:@""

#define UserNick  [[NSUserDefaults standardUserDefaults] valueForKey:XYUserNick]?[[NSUserDefaults standardUserDefaults] valueForKey:XYUserNick]:@""
#define UserPhone  [[NSUserDefaults standardUserDefaults] valueForKey:XYUserPhone]?[[NSUserDefaults standardUserDefaults] valueForKey:XYUserPhone]:@""
#define Userhead_img  [[NSUserDefaults standardUserDefaults] valueForKey:XYhead_img]?[[NSUserDefaults standardUserDefaults] valueForKey:XYhead_img]:@""
#define Userrealname  [[NSUserDefaults standardUserDefaults] valueForKey:XYrealname]
#define Uservip  [[NSUserDefaults standardUserDefaults] valueForKey:XYvip]
#define Useremail  [[NSUserDefaults standardUserDefaults] valueForKey:XYemail]?[[NSUserDefaults standardUserDefaults] valueForKey:XYemail]:@""
#define Userintegral  [[NSUserDefaults standardUserDefaults] valueForKey:XYintegral]
#define Usertaobao_au  [[NSUserDefaults standardUserDefaults] valueForKey:XYtaobao_au]
#define Userqq  [[NSUserDefaults standardUserDefaults] valueForKey:XYqq]
#define Userqq_au  [[NSUserDefaults standardUserDefaults] valueForKey:XYqq_au]
#define Usersina_au  [[NSUserDefaults standardUserDefaults] valueForKey:XYsina_au]
#define Userzfb_au  [[NSUserDefaults standardUserDefaults] valueForKey:XYzfb_au]?[[NSUserDefaults standardUserDefaults] valueForKey:XYzfb_au]:@""
#define Usermoney  [[NSUserDefaults standardUserDefaults] valueForKey:XYmoney]
#define Usergrowth  [[NSUserDefaults standardUserDefaults] valueForKey:XYgrowth]
#define Usersex  [[NSUserDefaults standardUserDefaults] valueForKey:XYsex]
#define Usercount  [[NSUserDefaults standardUserDefaults] valueForKey:XYcount]
#define Userlhbtx  [[NSUserDefaults standardUserDefaults] valueForKey:XYlhbtx]
#define Userhbtx  [[NSUserDefaults standardUserDefaults] valueForKey:XYhbtx]
#define Usergywm [[NSUserDefaults standardUserDefaults] valueForKey:XYgywm]

#define Userloginname  [[NSUserDefaults standardUserDefaults] valueForKey:XYloginname]
#define UsercheckNum  [[NSUserDefaults standardUserDefaults] valueForKey:XYcheckNum]
#define UsercheckTime  [[NSUserDefaults standardUserDefaults] valueForKey:XYcheckTime]
#define UserReturnMoney  [[NSUserDefaults standardUserDefaults] valueForKey:XYReturnMoney]
#define UserTid  [[NSUserDefaults standardUserDefaults] valueForKey:XYTid]
#define Userthree_nickname [[NSUserDefaults standardUserDefaults] valueForKey:XYthree_nickname]
#define Userlike_count [[NSUserDefaults standardUserDefaults] valueForKey:XYlike_count]
#define UserInvitImg [[NSUserDefaults standardUserDefaults] valueForKey:XYInvitImg]
#define UsertotalAward  [[NSUserDefaults standardUserDefaults] valueForKey:XYtotalAward]
#define Userfcommission  [[NSUserDefaults standardUserDefaults] valueForKey:XYFcommission]
#define Userzztx  [[NSUserDefaults standardUserDefaults] valueForKey:XYzztx]

#define UserLaunchImg  [[NSUserDefaults standardUserDefaults] valueForKey:XYLaunchImg]
#define UserShareImg  [[NSUserDefaults standardUserDefaults] valueForKey:XYShareImg]
#define UserShareWord  [[NSUserDefaults standardUserDefaults] valueForKey:XYShareWord]
#define UserAddress  [[NSUserDefaults standardUserDefaults] valueForKey:XYAddress]?[[NSUserDefaults standardUserDefaults] valueForKey:XYAddress]:@""
#define UserProvince  [[NSUserDefaults standardUserDefaults] valueForKey:XYProvince]
#define UserCity  [[NSUserDefaults standardUserDefaults] valueForKey:XYCity]
#define UserDistrict  [[NSUserDefaults standardUserDefaults] valueForKey:XYDistrict]
#define UserMeunHeight  [[NSUserDefaults standardUserDefaults] valueForKey:XYMeunHeight]?[[NSUserDefaults standardUserDefaults] valueForKey:XYMeunHeight]:@90
#define UserisNeedTid  [[NSUserDefaults standardUserDefaults] valueForKey:XYisNeedTid]
#define UserFindGoodsHeight  [[NSUserDefaults standardUserDefaults] valueForKey:XYFindGoods]?[[NSUserDefaults standardUserDefaults] valueForKey:XYFindGoods]:@120
#define Userextend_id [[NSUserDefaults standardUserDefaults] valueForKey:XYextend_id]





/**
 *  Device相关
 */
/**  系统版本是否大于V  */
#define SLSystemVersionGreaterThan(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
/**  系统版本是否等于V  */
#define SLSystemVersionEqualTo(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
/**  系统版本是否小于V  */
#define SLSystemVersionLessThan(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

/**
 *  Log相关
 */
#define SLLog(s, ...) NSLog( @"[%@ %@] %@",NSStringFromClass([self class]), NSStringFromSelector(_cmd),[NSString stringWithFormat:(s), ##__VA_ARGS__] )
//4、打印开关控制
#define DEBUGLOG 1
/**
 *  路径相关
 */
#define SLUserDocumentDirectoryPath ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject])
#define SLUserCacheDirectoryPath ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject])

/** 淘扑 **/
/** 我的返利 **/
#define WDFL @"wdfl"
#define url_wdfl  [[NSUserDefaults standardUserDefaults] valueForKey:WDFL]

/** 消息通知 **/
#define XXTZ @"xxtz"
#define url_xxtz  [[NSUserDefaults standardUserDefaults] valueForKey:XXTZ]

/** 我的订单 **/
#define WDDD @"wddd"
#define url_wddd  [[NSUserDefaults standardUserDefaults] valueForKey:WDDD]

/** 提现记录 **/
#define TXJL @"txjl"
#define url_txjl  [[NSUserDefaults standardUserDefaults] valueForKey:TXJL]

/** 超级好友 **/
#define CJHY @"cjhy"
#define url_cjhy  [[NSUserDefaults standardUserDefaults] valueForKey:CJHY]

/** 绑定订单 **/
#define BDDD @"bddd"
#define url_bddd  [[NSUserDefaults standardUserDefaults] valueForKey:BDDD]

//后台图片、视频、语音上传大小限制kb
#define MAX_IMAGE_SIZE 2000
#define MAX_VIDEO_SIZE 1800
#define MAX_VOICE_SIZE 1800

// 人脉聊天消息超时（秒）
#define ChatOverTime 20

#endif /* XYMarcos_h */
