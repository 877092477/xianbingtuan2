//
//  SVProgressHUD+runtime.m
//  THB
//
//  Created by Weller Zhao on 2018/12/22.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "SVProgressHUD+runtime.h"

@interface SVProgressHUD ()

@end

@implementation SVProgressHUD (runtime)

+ (void)showGif {
    NSString *imageStr = [FNBaseSettingModel settingInstance].loading_goods_img;
    if (imageStr && ![imageStr isEqualToString:@""]) {
        [[SDWebImageManager sharedManager] downloadImageWithURL:URL(imageStr) options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (finished) {
                
                [SVProgressHUD setImageViewSize: image.size];
                [SVProgressHUD showImage:image status:@""];
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
                [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
                [SVProgressHUD setInfoImage:image];
                [SVProgressHUD showInfoWithStatus:@""];
            }
        }];
    } else {
        [SVProgressHUD showGif];
    }
    
}


+ (NSTimeInterval)displayDuration:(NSString*)string {
    return 10;
}

+ (void)load
{
    // 1.获取系统URLWithString方法
    Method showMethod = class_getClassMethod([SVProgressHUD class], @selector(show));
    
    // 2.获取自定义的SHURLWithString方法
    Method showGifMethod = class_getClassMethod([SVProgressHUD class], @selector(showGif));
    
    // runtime方法之一：交换两个方法的实现。
    method_exchangeImplementations(showMethod, showGifMethod);
    
    Method durationMethod = class_getClassMethod([SVProgressHUD class], @selector(displayDurationForString:));
    
    // 2.获取自定义的SHURLWithString方法
    Method durationNewMethod = class_getClassMethod([SVProgressHUD class], @selector(displayDuration:));
    
    // runtime方法之一：交换两个方法的实现。
    method_exchangeImplementations(durationMethod, durationNewMethod);
    
    [self config];
    
}

+ (void) config {
    
    [SVProgressHUD setMinimumDismissTimeInterval:10];
}

@end
