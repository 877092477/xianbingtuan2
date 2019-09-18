//
//  AppDelegate.h
//  THB
//
//  Created by zhongxueyu on 16/3/12.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HightRebatesViewController.h"
#import "FNRequestTool.h"
#import "FNBridgeViewController.h"
#import "HomeViewController.h"

static NSString *channel = @"Publish channel";
static BOOL isProduction = TRUE;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (FNRequestTool *)requestTab;
- (FNRequestTool *)reqeustBaseSetting;

@end

