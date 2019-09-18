//
//  CoreLaunchLite.m
//  CoreLaunch
//
//  Created by 冯成林 on 15/10/16.
//  Copyright © 2015年 冯成林. All rights reserved.
//

#import "CoreLaunchLite.h"
#import "JKCountDownButton.h"
#import "QJCheckVersionUpdate.h"


@interface  CoreLaunchLite()
@property (nonatomic,strong) UIImageView *imageV;
@property (nonatomic,strong) UIWindow *subWindow;

//@property (strong, nonatomic)  JKCountDownButton *getBtn;
@end
#define iphone4x_3_5 ([UIScreen mainScreen].bounds.size.height==480.0f)

#define iphone5x_4_0 ([UIScreen mainScreen].bounds.size.height==568.0f)

#define iphone6_4_7 ([UIScreen mainScreen].bounds.size.height==667.0f)

#define iphone6Plus_5_5 ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.height==414.0f)

@implementation CoreLaunchLite
@synthesize imageV;

+(CoreLaunchLite *)shareManager{
    static CoreLaunchLite *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[CoreLaunchLite alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIViewController *imgVC = [[UIViewController alloc] init];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.clipsToBounds = YES;
        imageV.userInteractionEnabled = NO;
        [imageV sd_setImageWithURL:URL(UserLaunchImg) placeholderImage:[self launchImage]];
        imgVC.view = imageV;
//        XYNavigationController* nab = [[XYNavigationController alloc]initWithRootViewController:imgVC];
        
        
        self.subWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//        UIViewController* vc = [UIViewController new];
//        vc.view.backgroundColor = RED;
        self.subWindow.rootViewController = imgVC;
        
        self.subWindow.rootViewController.view.userInteractionEnabled = YES;
        self.subWindow.windowLevel = UIWindowLevelAlert;
        [self.subWindow makeKeyAndVisible];
        
    }
    return self;
}

- (void)hideImage {
    
    @weakify(self)
    
    [UIView animateWithDuration:0.2 animations:^{
        @strongify(self);
        self.subWindow.alpha = 0;
    } completion:^(BOOL finished) {
        @strongify(self);
        self.subWindow.hidden = YES;
        self.subWindow = nil;
    }];
    
}


/** 执行动画 */
//-(void)animWithWindow:(UIWindow *)window imageUrl: (NSString*)imgUrl{
//    
//    imageV = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    imageV.contentMode = UIViewContentModeScaleAspectFill;
//    imageV.clipsToBounds = YES;
//    imageV.userInteractionEnabled = NO;
//    [imageV sd_setImageWithURL:URL(imgUrl) placeholderImage:[self launchImage]];
//    
//    window.rootViewController.view.userInteractionEnabled = NO;
//    [window.rootViewController.view addSubview:imageV];
//
//    
//}
//
//
//-(void)clickToSkipLaunchImgMethod:(UIButton *)sender{
//    
//}
//
////倒计时
//- (void)secondAction:(JKCountDownButton *)sender{
//    sender.enabled = NO;
//    //button type要 设置成custom 否则会闪动
//    [sender startWithSecond:4];
//    [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
//        NSString *title = [NSString stringWithFormat:@"%d",second];
//        return title;
//    }];
//    [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
//        [imageV removeFromSuperview];
//        return @"0";
//    }];
//}
/**
 *  获取启动图片
 */
//-(UIImage *)launchImage{
//
//    NSString *imageName=@"LaunchImage-700";
//
//    if(iphone5x_4_0) imageName=@"LaunchImage-700-568h";
//
//    if(iphone6_4_7) imageName = @"LaunchImage-800-667h";
//
//    if(iphone6Plus_5_5) imageName = @"LaunchImage-800-Portrait-736h";
//
//    UIImage *image = [UIImage imageNamed:imageName];
//
////    NSAssert(image != nil, @"Charlin Feng提示您：请添加启动图片！");
//
//    return image;
//}

//获取启动图
- (UIImage *)launchImage{
    
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOr = @"Portrait";//垂直
    NSString *launchImage = @"LaunchImage-700";
    NSArray *launchImages =  [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    
    for (NSDictionary *dict in launchImages) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(viewSize, imageSize) && [viewOr isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    return [UIImage imageNamed:launchImage];
}


@end
