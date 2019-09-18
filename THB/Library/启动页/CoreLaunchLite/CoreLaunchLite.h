//
//  CoreLaunchLite.h
//  CoreLaunch
//
//  Created by 冯成林 on 15/10/16.
//  Copyright © 2015年 冯成林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CoreLaunchLite : NSObject


/** 执行动画 */
//-(void)animWithWindow:(UIWindow *)window image:(UIImage *)image;
//-(void)animWithWindow:(UIWindow *)window imageUrl: (NSString*)imgUrl;

+ (instancetype)shareManager;
//+ (void)hideWithOptions:(UIViewAnimationOptions)options;

- (void)hideImage;


@end
