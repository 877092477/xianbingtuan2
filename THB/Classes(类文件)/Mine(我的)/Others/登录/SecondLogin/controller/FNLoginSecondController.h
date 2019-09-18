//
//  FNLoginSecondController.h
//  THB
//
//  Created by Jimmy on 2018/1/12.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import <AlibabaAuthSDK/ALBBSDK.h>
#import "XYTabBarViewController.h"

#import "AppDelegate.h"
#import <TencentOpenAPI/QQApiInterface.h>       //QQ互联 SDK
#import <TencentOpenAPI/TencentOAuth.h>

typedef void(^SndCallBackBlcok) ();//回调
@interface FNLoginSecondController : SuperViewController
@property(nonatomic, strong) loginSuccessCallback loginSuccessCallback;
@property(nonatomic, strong) loginFailureCallback loginFailedCallback;

@property(nonatomic, assign) BOOL isFromWeb;
@property (nonatomic,copy)SndCallBackBlcok callBackBlock;//block
@end
