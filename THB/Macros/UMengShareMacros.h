//
//  UMengShareMacros.h
//  THB
//
//  Created by zhongxueyu on 16/5/5.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#ifndef UMengShareMacros_h
#define UMengShareMacros_h

#define TaoKeUnionId @""
#define TaoKeSubPid @""
#define My_isv_code      UserAccessToken?UserAccessToken:@""


#warning Key相关资料已经转移至CustomParams文件
//#define BaiChuanKey @"23430346"
//
///** 友盟Key **/
//#define UmengAppkey @"57aac46967e58e9f7600204f"
//
///** QQ相关 **/
//#define QQKey @"SGsFc9j2vu2xwQPz"
//#define QQAppId @"1105605716"
//
///** 微信相关 **/
//#define WeChatAppID @"wx7f995405e40245d7"
//#define TempWeChatAppSecret @"0f30792ae14e37a0c92a070e54df9c33"
//
///** 新浪相关 **/
//#define SinaAppKey @"2180230632"
//#define SinaAppSecret @"15b5959a00eb2b91d1654f357d8a798b"
//
///** 极光推送相关 **/
//#define JPushKey @"0ac6426e23a61c2f203c4b8b"
//
///** 填写你的域名 **/
//#define IP @"http://www.hairuyi.com/?"
//
///** 官网 **/
//#define OffcialIP @"http://www.hairuyi.com"


/** 填写包名 **/
#define AlisdkSchemes [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleIdentifier"]


#define APPID  [FNBaseSettingModel settingInstance].AppleAppID

#define ShareUrl   [NSString stringWithFormat:@"%@mod=wap&act=other&ctrl=invfriends1&name=%@&tid=%@",IP,UserNick,UserTid]


/** App占位图 **/
#define DEFAULT IMAGE(@"APP底图.png")


/** AppLogo图（用于设置页面中展示) **/
#define JM_AppLogo IMAGE(@"logo")

/** 分销分享的icon **/
#define Share_AppIcon IMAGE(@"icon120")


/** App所属公司名（用于设置页面中展示) **/
#define JM_CompanyName [NSString stringWithFormat:@"%@",[FNBaseSettingModel settingInstance].CompanyName]


/** 网页内网IP */
#define WAP198 @"http://192.168.0.128:8080/v55411/?"


#define AppType @"0"

#endif /* UMengShareMacros_h */
