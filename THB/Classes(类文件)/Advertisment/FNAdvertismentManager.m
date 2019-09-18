//
//  FNAdvertismentManager.m
//  SuperMode
//
//  Created by Jimmy Ng on 2017/11/29.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNAdvertismentManager.h"
#import "XYNavigationController.h"
#import "FNAdvertisMentController.h"

#import "QJCheckVersionUpdate.h"
@interface FNAdvertismentManager()
@property (nonatomic,strong) UIWindow *subWindow;
@end
@implementation FNAdvertismentManager
+(FNAdvertismentManager *)shareManager{
    static FNAdvertismentManager *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[FNAdvertismentManager alloc] init];
    });
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        FNAdvertisMentController* imgvc = [FNAdvertisMentController new];
        imgvc.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:URL(UserLaunchImg)]];
        @weakify(self);
        imgvc.removWindow = ^{
            @strongify(self);
            if (self.finishedWindow) {
                self.finishedWindow();
                self.finishedWindow = nil;
            }
        
        };
        XYNavigationController* nab = [[XYNavigationController alloc]initWithRootViewController:imgvc];
        
        
        self.subWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        UIViewController* vc = [UIViewController new];
        vc.view.backgroundColor = RED;
        self.subWindow.rootViewController = nab;
        
        self.subWindow.rootViewController.view.userInteractionEnabled = YES;
        self.subWindow.windowLevel = UIWindowLevelAlert;
        [self.subWindow makeKeyAndVisible];
        
    }
    return self;
}
+(void)hideWithOptions:(UIViewAnimationOptions)options{
    FNAdvertismentManager* manager = [FNAdvertismentManager shareManager];
    [UIView transitionWithView:manager.subWindow duration:1.0 options:options animations:^{
        manager.subWindow.alpha = 0;
    } completion:^(BOOL finished) {
        manager.subWindow.hidden = YES;
        manager.subWindow = nil;
    }];
}

@end
