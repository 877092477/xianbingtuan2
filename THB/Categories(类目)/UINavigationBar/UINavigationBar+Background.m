//
//  UINavigationBar+Background.m
//  CustomNavicationController
//
//  Created by YiJiang Chen on 15/10/22.
//  Copyright (c) 2015年 YiJiang Chen. All rights reserved.
//
#import <objc/runtime.h>
#import "UINavigationBar+Background.h"

@implementation UINavigationBar (Background)
static char overlayKey;
static char titleLebleKey;

- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UILabel *)titleLeble
{
    return objc_getAssociatedObject(self, &titleLebleKey);
}

- (void)setTitleLeble:(UILabel *)titleLeble
{
    objc_setAssociatedObject(self, &titleLebleKey, titleLeble, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)cnSetBackgroundColor:(UIColor *)backgroundColor andTitle:(NSString *)title
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, isIphoneX? -44: -20, [UIScreen mainScreen].bounds.size.width, XYNavBarHeigth)];
        self.titleLeble = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, self.overlay.frame.size.width, 20)];
        self.titleLeble.tintColor = [UIColor blackColor];
        self.titleLeble.textAlignment = NSTextAlignmentCenter;
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.overlay atIndex:0];
        [self.overlay addSubview:self.titleLeble];
    }
    self.titleLeble.text = title;
    self.overlay.backgroundColor = backgroundColor;
//    if (!self.overlay) {
//        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + 20)];
//        self.titleLeble = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, self.overlay.frame.size.width, 20)];
//        self.titleLeble.tintColor = [UIColor blackColor];
//        self.titleLeble.textAlignment = NSTextAlignmentCenter;
//        self.overlay.userInteractionEnabled = NO;
//        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        [self insertSubview:self.overlay atIndex:0];
//        [self.overlay addSubview:self.titleLeble];
//    }
//    self.titleLeble.text = title;
//    self.overlay.backgroundColor = backgroundColor;
}

- (void)cnReset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
    self.titleLeble.text = nil;
}

@end
