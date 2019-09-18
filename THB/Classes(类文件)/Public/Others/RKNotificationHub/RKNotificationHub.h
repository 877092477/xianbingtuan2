//
//  RKNotificationHub.h
//  RKNotificationHub
//
//  Created by Richard Kim on 9/30/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
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


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  The default diameter of the notification hub view.
 */
FOUNDATION_EXPORT CGFloat const RKNotificationHubDefaultDiameter;

@interface RKNotificationHub : NSObject

//%%% setup
- (id)initWithView:(UIView *)view;
- (id)initWithBarButtonItem:(UIBarButtonItem *)barButtonItem;
- (id)initWithTabBarButtonItem:(UITabBarItem *)barButtonItem;

//%%% adjustment methods
- (void)setView:(UIView *)view andCount:(int)startCount;
- (void)setCircleAtFrame:(CGRect)frame;
- (void)setCircleColor:(UIColor*)circleColor labelColor:(UIColor*)labelColor;
- (void)setCircleBorderColor:(UIColor *)color borderWidth:(CGFloat)width;
- (void)moveCircleByX:(CGFloat)x Y:(CGFloat)y;
- (void)scaleCircleSizeBy:(CGFloat)scale;
@property (nonatomic, strong) UIFont *countLabelFont;

//%%% changing the count
- (void)increment;
- (void)incrementBy:(int)amount;
- (void)decrement;
- (void)decrementBy:(int)amount;
@property (nonatomic, assign) int count;

//%%% hiding / showing the count
- (void)hideCount;
- (void)showCount;

//%%% animations
- (void)pop;
- (void)blink;
- (void)bump;

@property (nonatomic)UIView *hubView;

@end
