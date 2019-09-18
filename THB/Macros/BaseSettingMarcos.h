//
//  BaseSettingMarcos.h
//  THB
//
//  Created by zhongxueyu on 16/10/25.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#ifndef BaseSettingMarcos_h
#define BaseSettingMarcos_h
//声明字段

#define XYJPushKey                  @"JPushKey"




#define XYextendreg                 @"extendreg"




#define XYvip_name                   @"vip_name"
#define XYapp_invitaion_list_onoff                   @"app_invitaion_list_onoff"
#define XYappopentaobao_onoff                   @"appopentaobao_onoff"
#define XYWeChatAppSecret                   @"WeChatAppSecret"






//读取

#define SettingJPushKey  [[NSUserDefaults standardUserDefaults] valueForKey:XYJPushKey]



#define Setting_CompanyName  [[NSUserDefaults standardUserDefaults] valueForKey:XYCompanyName]

#define Setting_checkVersion  [[NSUserDefaults standardUserDefaults] valueForKey:XYextendreg]?[FNBaseSettingModel settingInstance].checkVersion:@""



#define Setting_app_invitaion_list_onoff  [[NSUserDefaults standardUserDefaults] valueForKey:XYapp_invitaion_list_onoff]?[[NSUserDefaults standardUserDefaults] valueForKey:XYapp_invitaion_list_onoff]:@""

#define Setting_vip_name  [[NSUserDefaults standardUserDefaults] valueForKey:XYvip_name]?[[NSUserDefaults standardUserDefaults] valueForKey:XYvip_name]:@""
#define Setting_appopentaobao_onoff  [[NSUserDefaults standardUserDefaults] valueForKey:XYappopentaobao_onoff]?[[NSUserDefaults standardUserDefaults] valueForKey:XYappopentaobao_onoff]:@"0"
#define JMWeChatAppSecret  [[NSUserDefaults standardUserDefaults] valueForKey:XYWeChatAppSecret]?[[NSUserDefaults standardUserDefaults] valueForKey:XYWeChatAppSecret]:TempWeChatAppSecret

//储存历史记录文件
#define HistoryPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"histDatas.data"]

/** App版本 **/
#define FNCurrentVersion [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"]

#define WebViewNormalStye [FNBaseSettingModel.settingInstance.outlink_style isEqualToString:@"1"]

#endif /* BaseSettingMarcos_h */
