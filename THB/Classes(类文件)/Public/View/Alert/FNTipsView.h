//
//  FNTipsView.h
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 16/8/31.
//  Copyright © 2016年 jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNTipsView : UIView
/**
 *  显示提示
 *
 *  @param tips 提示文字
 */
+ (void)showTips:(NSString *)tips;
/**
 *  显示提示
 *
 *  @param tips     提示文字
 *  @param duration 消失时间
 */
+ (void)showTips:(NSString *)tips withDuration:(CGFloat)duration;
@end
