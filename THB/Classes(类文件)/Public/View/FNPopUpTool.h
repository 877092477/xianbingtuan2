//
//  FNPopUpTool.h
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 16/9/20.
//  Copyright © 2016年 jimmy. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    FMPopupAnimationDirectionTop = 0 ,//default
    FMPopupAnimationDirectionBottom,
    FMPopupAnimationDirectionLeft,
    FMPopupAnimationDirectionRight,
    FMPopupAnimationDirectionNone,
} FMPopupAnimationDirection;
typedef void(^hiddenBlock)(void);
@interface FNPopUpTool : UIView
@property (nonatomic, copy)hiddenBlock block;
+ (instancetype)sharedInstance;
+ (void)showViewWithContentView:(UIView *)contentView withDirection:(FMPopupAnimationDirection)direction finished:(hiddenBlock)block;
+ (void)hiddenAnimated:(BOOL)animated;
@end
