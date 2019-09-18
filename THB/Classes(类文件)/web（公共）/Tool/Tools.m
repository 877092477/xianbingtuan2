//
//  Tools.m
//  DoctorAndE
//
//  Created by skytoup on 14-11-4.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "Tools.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "Reachability.h"
#import <CommonCrypto/CommonHMAC.h>
#import <netdb.h>
#import <arpa/inet.h>

@implementation Tools


+ (void)showMessage:(NSString *)message
{
    [Tools showMessage:message andTime:TIME];
}

+ (void)showMessage:(NSString *)message andTime:(float)sec
{

    UIWindow        *window = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD   *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];

    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.labelFont = [UIFont systemFontOfSize:18];
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:sec];

    [window bringSubviewToFront:hud];
}
+ (void)showMessage:(NSString *)message andTime:(float)sec withDelay:(float)delaySec
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySec * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Tools showMessage:message andTime:sec];
        });
}

+ (void)showMessage:(NSString *)message withDelay:(float)delaySec
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySec * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Tools showMessage:message];
        });
}

+ (void)showHUD:(NSString *)text andView:(UIView *)view andHUD:(MBProgressHUD *)hud  andTime:(float)sec
{
//    UIWindow        *window = [[UIApplication sharedApplication] keyWindow];
    hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.labelFont = [UIFont systemFontOfSize:18];
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:sec];
    
//    [view bringSubviewToFront:hud];
//    [view addSubview:hud];
//    hud.labelText = text;//显示提示
//    hud.dimBackground = YES;//使背景成黑灰色，让MBProgressHUD成高亮显示
//    hud.square = YES;//设置显示框的高度和宽度一样
//    [hud show:YES];
}

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);

    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}





+ (NSString *)jidHandle:(NSString *)jid
{
    NSRange r = [jid rangeOfString:@"/"];
    NSUInteger     l = r.length ? r.location : 0;

    return [jid substringWithRange:NSMakeRange(0, l ? l : jid.length)];
}

+ (NSString *)dateHandle:(long)dateTime
{
    long    aDayTime = 24 * 60 * 60;
    long    diff = TIME_LONG_NOW - dateTime;

    NSDate          *date = [NSDate dateWithTimeIntervalSince1970:dateTime];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];

    if (diff < aDayTime) {                                          // 今天
        format.dateFormat = @"今天 HH:mm";
    } else if ((diff >= aDayTime) && (diff < aDayTime * 2)) {       // 昨天
        format.dateFormat = @"昨天 HH:mm";
    } else if ((diff >= aDayTime * 2) && (diff < aDayTime * 3)) {   // 前天
        format.dateFormat = @"前天 HH:mm";
    } else {
        format.dateFormat = @"MM-dd HH:mm";
    }

    return [format stringFromDate:date];
}

+ (NSString *)imgPathHandle:(NSString *)imgsStr withForward:(BOOL)isForward
{
    NSRange r = [imgsStr rangeOfString:@";"];

    if (isForward) {
        return [imgsStr substringToIndex:r.location];
    } else {
        return [imgsStr substringFromIndex:r.location + 1];
    }
}

+ (NSString *)createUuid
{
    CFUUIDRef   uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref = CFUUIDCreateString(NULL, uuid_ref);

    CFRelease(uuid_ref);
    NSString                    *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    __autoreleasing NSString    *r = [uuid lowercaseString];
    CFRelease(uuid_string_ref);
    return r;
}

+ (void)addImaginaryLineInView:(UIView*)view {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRect){ {0, 0}, {320, 480} }];
    NSArray *subViews = view.subviews;
    for(UIView *v in subViews) {
        if([v isKindOfClass:[UIImageView class] ]) {
            [v removeFromSuperview];
        }
    }
    [view addSubview:imageView];

    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    
    CGFloat lengths[] = {4,2};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor grayColor].CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, 0);    //开始画线
    CGContextAddLineToPoint(line, VIEW_GET_WIDTH(view), 0);
    CGContextStrokePath(line);
    
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

+ (BOOL)checkGroupName:(NSString*)groupName
{
    BOOL isTrue = NO;
    if ([groupName rangeOfString:@" "].length) {
        [Tools showMessage:@"分组名字不能包含空格"];
    } else if (groupName.length > 30) {
        [Tools showMessage:@"分组名字不能大于30个字"];
    } else if (!groupName.length) {

    } else {
        isTrue = YES;
    }
    return isTrue;
}

+ (BOOL)checkGroupChatName:(NSString*)groupChatName
{
    BOOL isTrue = NO;
    if (!groupChatName.length) {
        [Tools showMessage:@"群名称不能为空"];
    } else if ([groupChatName rangeOfString:@" "].length) {
        [Tools showMessage:@"群名称不能包含空格"];
    } else if (groupChatName.length > 30) {
        [Tools showMessage:@"群名称不能超过30个字"];
    } else {
        isTrue = YES;
    }
    return isTrue;
}

+(BOOL)testConnection {
    

    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

+(int)isConnection{
    
    static int netWorkState;
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络,不花钱
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        netWorkState = status;
        
//        NSLog(@"%d",netWorkState);
    }];
    return netWorkState;
    
}

@end