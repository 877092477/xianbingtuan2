//
//  Tools.h
//  DoctorAndE
//
//  Created by skytoup on 14-11-4.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
/**
 *  工具集合
 */
@interface Tools : NSObject


/**
 *  显示一个信息提示，1秒后消失
 *
 *  @param message 提示的信息
 */
+ (void)showMessage:(NSString *)message;


/**
 *  显示一个信息提示框
 *
 *  @param message 提示的信息
 *  @param sec     显示时间（秒）
 */
+ (void)showMessage:(NSString *)message andTime:(float)sec;

/**
 *  显示一个信息提示框
 *
 *  @param message  提示信息
 *  @param sec      显示时间（秒）
 *  @param delaySec 延迟的时间
 */
+ (void)showMessage:(NSString *)message andTime:(float)sec withDelay:(float)delaySec;

/**
 *  显示一个信息提示框
 *
 *  @param message  提示信息
 *  @param delaySec 延迟的时间
 */
+ (void)showMessage:(NSString *)message withDelay:(float)delaySec;

/**
 *  <#Description#>
 *
 *  @param text      <#text description#>
 *  @param view      <#view description#>
 *  @param jidHandle <#jidHandle description#>
 *  @param jid       <#jid description#>
 */
+ (void)showHUD:(NSString *)text andView:(UIView *)view andHUD:(MBProgressHUD *)hud  andTime:(float)sec;

/**
 *  jid处理
 *
 *  @param jid jid
 *
 *  @return 处理好的jid
 */
+ (NSString *)jidHandle:(NSString*)jid;
/**
 *  时间处理
 *
 *  @param dateTime 时间戳
 *
 *  @return 格式化的时间
 */
+ (NSString*)dateHandle:(long)dateTime;
/**
 *  处理聊天图片路径
 *
 *  @param imgsStr   聊天图片路径
 *  @param isForward 取前面，还是后面
 *
 *  @return imgPath
 */
+ (NSString*)imgPathHandle:(NSString*)imgsStr withForward:(BOOL)isForward;
/**
 *  生成uuid
 *
 *  @return uuid
 */
+ (NSString*) createUuid;

/**
 *  检测分组名称是否正确
 *
 *  @param groupName 分组名称
 *
 *  @return 是否正确
 */
+ (BOOL)checkGroupName:(NSString*)groupName;
/**
 *  检测群聊名称是否正确
 *
 *  @param groupChatName 群聊名称
 *
 *  @return 是否正确
 */
+ (BOOL)checkGroupChatName:(NSString*)groupChatName;
/**
 *  检测是否联网
 *
 *  @param 
 *
 *  @return 是否联网
 */
+(BOOL)testConnection;
/**
 *  检测是否联网
 *
 *  @param 是否联网
 *
 *  @return 联网状态 0为断网
 */
+(int)isConnection;

@end