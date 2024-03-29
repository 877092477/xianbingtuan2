//
//  UIView+KRKit.m
//  KRKit
//
//  Created by 小普 on 15/4/30.
//  Copyright (c) 2015年 36kr. All rights reserved.
//

#import "UIView+KRKit.h"
#import <objc/runtime.h>
@import QuartzCore;

@implementation UIView (KRLayout)

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (UIView *)topSuperView
{
    UIView *topSuperView = self.superview;
    
    if (topSuperView == nil) {
        topSuperView = self;
    } else {
        while (topSuperView.superview) {
            topSuperView = topSuperView.superview;
        }
    }
    
    return topSuperView;
}

- (void)setTopSuperView:(UIView *)topSuperView
{
    
}

- (void)kr_widthEqualToView:(UIView *)view
{
    self.width = view.width;
}

- (void)kr_heightEqualToView:(UIView *)view
{
    self.height = view.height;
}

- (void)kr_sizeEqualToView:(UIView *)view
{
    self.size = view.size;
}

- (void)kr_centerXEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewCenterPoint = [superView convertPoint:view.center toView:self.topSuperView];
    CGPoint centerPoint = [self.topSuperView convertPoint:viewCenterPoint toView:self.superview];
    self.centerX = centerPoint.x;
}

- (void)kr_centerYEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewCenterPoint = [superView convertPoint:view.center toView:self.topSuperView];
    CGPoint centerPoint = [self.topSuperView convertPoint:viewCenterPoint toView:self.superview];
    self.centerY = centerPoint.y;
}

- (void)kr_top:(CGFloat)top fromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.top = newOrigin.y + top + view.height;
}

- (void)kr_bottom:(CGFloat)bottom fromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.top = newOrigin.y - bottom - self.height;
}

- (void)kr_left:(CGFloat)left fromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.left = newOrigin.x - left - self.width;
}

- (void)kr_right:(CGFloat)right fromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.left = newOrigin.x + right + view.width;
}

- (void)kr_fillWidth
{
    self.frame = CGRectMake(0, self.top, self.superview.width, self.height);
}

- (void)kr_fillHeight
{
    self.frame = CGRectMake(self.left, 0, self.width, self.superview.height);
}

- (void)kr_fill
{
    self.frame = CGRectMake(0, 0, self.superview.width, self.superview.height);
}

- (void)kr_removeAllSubviews
{
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (void)kr_hideSubView {
    NSArray *views = self.subviews;
    
    [UIView animateWithDuration:0.3f animations:^{
        for (int i = 0; i < views.count; i ++) {
            UIView *view = views[i];
            if (view.tag != 101) {
                CGRect rect = view.frame;
                rect.origin.x += XYScreenWidth;
                view.frame = rect;
            }
            
        }
    }];

}
- (void)kr_showSubView {
    NSArray *views = self.subviews;
    for (int i = 0; i < views.count; i ++) {
        UIView *view = views[i];
        if (view.tag != 101) {
            CGRect rect = view.frame;
            rect.origin.y += XYScreenHeight;
            view.frame = rect;
        }
        
    }
    [UIView animateWithDuration:0.3f animations:^{
        for (int i = 0; i < views.count; i ++) {
            UIView *view = views[i];
            if (view.tag != 101) {
                CGRect rect = view.frame;
                rect.origin.y -= XYScreenHeight;
                view.frame = rect;
            }
            
        }
    }];

}

- (void)kr_shake {
    CAKeyframeAnimation *animationKey = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animationKey setDuration:0.5f];
    
    NSArray *array = [[NSArray alloc] initWithObjects:
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      nil];
    [animationKey setValues:array];
    
    NSArray *times = [[NSArray alloc] initWithObjects:
                      [NSNumber numberWithFloat:0.1f],
                      [NSNumber numberWithFloat:0.2f],
                      [NSNumber numberWithFloat:0.3f],
                      [NSNumber numberWithFloat:0.4f],
                      [NSNumber numberWithFloat:0.5f],
                      [NSNumber numberWithFloat:0.6f],
                      [NSNumber numberWithFloat:0.7f],
                      [NSNumber numberWithFloat:0.8f],
                      [NSNumber numberWithFloat:0.9f],
                      [NSNumber numberWithFloat:1.0f],
                      nil];
    [animationKey setKeyTimes:times];

    
    [self.layer addAnimation:animationKey forKey:@"ViewShake"];
}

@end

static char kWhenTappedBlockKey;
//static char kWhenTouchedDownBlockKey;
//static char kWhenTouchedUpBlockKey;

@implementation UIView (KREvent)

#pragma mark - Private

- (void)runBlockForKey:(void *)blockKey
{
    void(^block)(void);
    block = objc_getAssociatedObject(self, blockKey);
    if (block) {
        block();
    }
}

- (void)setBlock:(void(^)(void))block forKey:(void *)key
{
    self.userInteractionEnabled = YES;
    objc_setAssociatedObject(self, key, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)tapped
{
    [self runBlockForKey:&kWhenTappedBlockKey];
}

#pragma mark - Public

//- (void)kr_whenTapped:(void(^)(void))block
//{
//    self.userInteractionEnabled = YES;
//
//    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
//    tapGR.delegate = self;
//    tapGR.numberOfTapsRequired = 1;
//    [self addGestureRecognizer:tapGR];
//    [self setBlock:block forKey:&kWhenTappedBlockKey];
//}
//
//- (void)kr_whenTouchedDown:(void(^)(void))block
//{
//    [self setBlock:block forKey:&kWhenTouchedDownBlockKey];
//}
//
//- (void)kr_whenTouchedUp:(void(^)(void))block
//{
//    [self setBlock:block forKey:&kWhenTouchedUpBlockKey];
//}

#pragma mark - Override

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [super touchesBegan:touches withEvent:event];
//    [self runBlockForKey:&kWhenTouchedDownBlockKey];
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [super touchesBegan:touches withEvent:event];
//    [self runBlockForKey:&kWhenTouchedUpBlockKey];
//}

@end

@implementation UIView (Debug)

- (void)kr_markBorderWithRandomColor
{
    self.layer.borderColor = [UIColor colorWithRed:(arc4random() % 255 )/ 255.f green:(arc4random() % 255 )/ 255.f blue:(arc4random() % 255 )/ 255.f alpha:1].CGColor;
    self.layer.borderWidth = 1.0f;
}

- (void)kr_markBorderWithRandomColorRecursive
{
    [self kr_markBorderWithRandomColor];
    for (UIView *v in self.subviews) {
        [v kr_markBorderWithRandomColorRecursive];
    }
}

#pragma mark - UIGestureRecognizerDelegate
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    // 输出点击的view的类名
//    NSLog(@"KRkit:%@", NSStringFromClass([touch.view class]));
//    
//    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
//        return NO;
//    }
//    return  YES;
//}

@end