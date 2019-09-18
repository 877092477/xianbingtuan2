//
//  FNPopUpTool.m
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

#import "FNPopUpTool.h"
#define PopUpAnimationDuration 0.5f
@interface FNPopUpTool ()
@property (nonatomic, weak) UIView* contentView;
@property (nonatomic, weak) UIView* coverView;
@property (nonatomic, assign) FMPopupAnimationDirection direction;
@property (nonatomic, assign) BOOL hiddenAnimated;

@end
@implementation FNPopUpTool
static FNPopUpTool *sharedView;
+ (instancetype)sharedInstance
{
    

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedView = [[self alloc] initWithFrame:FNKeyWindow.bounds];
    });
    return sharedView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    UIView *coverView = [[UIView alloc]initWithFrame:CGRectZero];
    coverView.backgroundColor = FNBlackColorWithAlpha(0);
    [coverView addJXTouch:^{
        [FNPopUpTool hiddenAnimated:YES];
    }];
    [self addSubview:coverView];
    _coverView = coverView;
}
- (void)setContentView:(UIView *)contentView
{
    
    _contentView = contentView;
    if (_contentView) {
        [self addSubview:_contentView];
        _coverView.frame = CGRectMake(0, CGRectGetMaxY(_contentView.frame), self.width, self.height - CGRectGetMaxY(_contentView.frame));
    }
}
+ (void)showViewWithContentView:(UIView *)contentView withDirection:(FMPopupAnimationDirection)direction finished:(hiddenBlock)block;
{
    FNPopUpTool *popUp = [FNPopUpTool sharedInstance];
    popUp.alpha = 1.0;
    popUp.backgroundColor = [UIColor clearColor];
    popUp.contentView = contentView;
    popUp.direction = direction;
    popUp.block = block;
    [popUp show];
}
- (void)show
{
    //添加到keyWindow上
    if (self.direction != FMPopupAnimationDirectionNone) {
        [FNKeyWindow addSubview:self];
    }
    

    if (self.direction == 0) {
        self.direction = FMPopupAnimationDirectionTop;
    }
    
    switch (self.direction) {
        case FMPopupAnimationDirectionTop:
        {
            [self showFormTop];
            break;
        }
        case FMPopupAnimationDirectionBottom:
        {
            [self showFormBottom];
            break;
        }
        case FMPopupAnimationDirectionLeft:
        {
            [self showFormLeft];
            break;
        }
        case FMPopupAnimationDirectionRight:
        {
            [self showFormRight];
            break;
        }
        case FMPopupAnimationDirectionNone:
        {
            [self showWithOutDirection];
            break;
        }
        default:
            break;
    }

    /*
     CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
     shake.duration = PopUpAnimationDuration;
     shake.autoreverses = NO;//自动反向
     shake.repeatCount = 0;//重复次数
     shake.removedOnCompletion = YES;
     shake.delegate = self;
     shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)];
     shake.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, y+_contentView.height, 0)];//左右旋转角度，x,y,z轴
     [[self layer] addAnimation:shake forKey:@"shakeAnimation"];
     */
    

}
#pragma mark - public
+ (void)hiddenAnimated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:PopUpAnimationDuration animations:^{
            sharedView.alpha = 0;
         } completion:^(BOOL finished) {
             if (finished) {
                 [sharedView removeFromSuperview];
                 [sharedView.contentView  removeFromSuperview];
                 sharedView.contentView = nil;
             }
         }];
    }else {
        [sharedView removeFromSuperview];
        [sharedView.contentView  removeFromSuperview];
        sharedView.contentView = nil;
    }
    if (sharedView.block) {
        sharedView.block();
    }
}
#pragma mark - animation
- (void)showFormTop
{
    //添加到keyWindow上
    CGFloat y = _contentView.y;
    CGFloat cy = _coverView.y;
    _contentView.y = -_contentView.height;
    _coverView.y = self.height;
    
    
    [UIView animateWithDuration:0.5f animations:^{
        _contentView.y = y;
        _coverView.backgroundColor = FNBlackColorWithAlpha(0.5);
        _coverView.y = cy;
    }];
}
- (void)showFormBottom
{
    
    CGFloat y = _contentView.y;
    CGFloat cy = _coverView.y;
    _contentView.y = self.height;
    _coverView.y = CGRectGetMaxY(_contentView.frame);
    
    
    [UIView animateWithDuration:PopUpAnimationDuration animations:^{
        _contentView.y = y;
        _coverView.backgroundColor = FNBlackColorWithAlpha(0.5);
        self.backgroundColor = FNBlackColorWithAlpha(0.5);
        _coverView.y = cy;
    }];
}
- (void)showFormLeft
{
 
    CGFloat x = _contentView.x;
    CGFloat cy = _coverView.y;
    _contentView.x = -_contentView.width;
    _coverView.y = self.height;
    
    
    [UIView animateWithDuration:PopUpAnimationDuration animations:^{
        _contentView.x = x;
        _coverView.backgroundColor = FNBlackColorWithAlpha(0.5);
        _coverView.y = cy;
    }];
}
- (void)showFormRight
{
 
    CGFloat x = _contentView.x;
    CGFloat cy = _coverView.y;
    _contentView.x = self.width+CGRectGetMaxX(_contentView.frame);
    _coverView.y = self.height;
    
    
    [UIView animateWithDuration:PopUpAnimationDuration animations:^{
        _contentView.x = x;
        _coverView.backgroundColor = FNBlackColorWithAlpha(0.5);
        _coverView.y = cy;
    }];
}
- (void)showWithOutDirection
{
    
    [UIView animateWithDuration:PopUpAnimationDuration animations:^{
        [FNKeyWindow addSubview:self];
        _coverView.backgroundColor = FNBlackColorWithAlpha(0.5);
    }];
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect frame = _contentView.frame;
    if (point.y < frame.origin.y ) {
        [FNPopUpTool hiddenAnimated:YES];
        return [super hitTest:point withEvent:event];
    }else {
        
        return [super hitTest:point withEvent:event];
    }
    
}

@end
