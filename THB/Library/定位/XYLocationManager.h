//
//  XYLocationManager.h
//  FnuoApp
//
//  Created by zhongxueyu on 16/3/9.
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#warning plist文件中添加
/*
 * NSLocationAlwaysUsageDescription String 应用程序始终使用定位服务
 * NSLocationWhenInUseUsageDescription String 使用应用程序期间，可以使用定位服务
 */

typedef void(^UpdateLocationSuccessBlock) (CLLocation * location, CLPlacemark * placemark);
typedef void(^UpdateLocationErrorBlock) (CLRegion * region, NSError * error);

@interface XYLocationManager : NSObject

+ (instancetype)shareLocationManager;

/*
 * isAlwaysUse  是否后台定位 持续定位（NSLocationAlwaysUsageDescription）
 */
@property (nonatomic, assign) BOOL isAlwaysUse;
/*
 * isRealTime 是否实时定位
 */
@property (nonatomic, assign) BOOL isRealTime;
/*
 * 精度 默认 kCLLocationAccuracyKilometer
 */
@property (nonatomic, assign) CGFloat desiredAccuracy;
/*
 * 更新距离 默认1000米
 */
@property (nonatomic, assign) CGFloat distanceFilter;

//开始定位
- (void)startUpdatingLocationWithSuccess:(UpdateLocationSuccessBlock)success andFailure:(UpdateLocationErrorBlock)error;
@end
