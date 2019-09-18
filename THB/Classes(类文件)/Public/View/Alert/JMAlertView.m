//
//  JMAlertView.m
//  RedPacket
//
//  Created by jimmy on 16/12/23.
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

#import "JMAlertView.h"
#define JMAlertVerticalMargin 15
#define JMAlertHorizontalMargin 15*2
#define JMBgViewWidth (FNDeviceWidth - 2*JMAlertHorizontalMargin)

JMAlertView * _alert = nil;
@interface JMAlertView ()
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, assign)NSInteger index;

@end
@implementation JMAlertView
+ (JMAlertView *)shareinstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _alert = [[self alloc] initWithFrame:FNKeyWindow.bounds];
    });
    return _alert;
}
- (UIView *)backgroundView{
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc]init];
        _backgroundView.backgroundColor = [UIColor whiteColor];
        _backgroundView.cornerRadius = 5;
    }
    return _backgroundView;
}
- (UIButton *)firstButton{
    if (_firstButton == nil) {
        _firstButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_firstButton setTitle:self.firstTitle forState:UIControlStateNormal];
        [_firstButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _firstButton.titleLabel.font = kFONT14;
        [_firstButton sizeToFit];
        [_firstButton addTarget:self action:@selector(buttonClickCenter:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _firstButton;
}
- (UIButton *)secondButton{
    if (_secondButton == nil) {
        _secondButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_secondButton setTitle:self.secondTitle forState:UIControlStateNormal];
        _secondButton.titleLabel.font = kFONT14;
        [_secondButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_secondButton addTarget:self action:@selector(buttonClickCenter:) forControlEvents:UIControlEventTouchUpInside];
        [_secondButton sizeToFit];
        
    }
    return _secondButton;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.text = self.title;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}
- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [UILabel new];
        _contentLabel.font = kFONT14;
        _contentLabel.text = self.content;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}
+ (instancetype)alertWithTitle:(NSString *)title content:(NSString *)content firstTitle:(NSString *)firstTitle andSecondTitle:(NSString *)secondTitle alertType:(AlertType)type clickBlock:(void (^)(NSInteger index))clickblock {
    JMAlertView *alert = [JMAlertView shareinstance];
    if ([FNKeyWindow.subviews containsObject:alert]) {
        return nil;
    }
    alert.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    alert.title = title;
    alert.content = content;
    alert.firstTitle = firstTitle;
    alert.secondTitle = secondTitle;
    alert.clickeblock  = clickblock;
    alert.type = type;
    return alert;
}
- (void)setType:(AlertType)type{
    _type = type;
    [self initializedSubviews];
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.backgroundView = nil;
    self.contentLabel = nil;
    self.titleLabel = nil;
    self.firstButton = nil;
    self.secondButton = nil;

    [self addSubview:self.backgroundView];
    [self.backgroundView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:JMAlertHorizontalMargin];
    [self.backgroundView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:JMAlertHorizontalMargin];
    [self.backgroundView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];

    [self.backgroundView addSubview:self.firstButton];

    [self.backgroundView addSubview:self.secondButton];

    
    if (self.title) {

        
        [self.backgroundView addSubview:self.titleLabel];

        
        [_titleLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(JMAlertVerticalMargin, JMAlertHorizontalMargin, 0, JMAlertHorizontalMargin)) excludingEdge:(ALEdgeBottom)];
        if (self.content == nil) {
            [self layoutWithLabel:self.titleLabel];
        }
    }
    
    if (self.content) {
        [_backgroundView addSubview:self.contentLabel];
        [_contentLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:JMAlertHorizontalMargin];
        [_contentLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:JMAlertHorizontalMargin];
        if (self.title) {
            [_contentLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.titleLabel withOffset:JMAlertVerticalMargin];
        }else{
            [_contentLabel autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:JMAlertVerticalMargin*1.5];
        }
        [self layoutWithLabel:self.contentLabel];
    }
    
}
- (void)layoutWithLabel:(UILabel *)label{
    CGFloat margin = 0;
    switch (self.type) {
        case AlertTypeAlert:
        {
            self.contentLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
      
            CGFloat margin = (self.width - JMAlertHorizontalMargin*2-self.firstButton.width-_secondButton.width)/3;
            [self.firstButton autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:label withOffset:JMAlertVerticalMargin];
            [self.firstButton autoSetDimensionsToSize:CGSizeMake(self.firstButton.width+20, self.firstButton.height+20)];
            
            [self.secondButton autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:label withOffset:JMAlertVerticalMargin];
            [self.secondButton autoSetDimensionsToSize:CGSizeMake(self.secondButton.width+20, self.secondButton.height+20)];
            if (self.firstTitle == nil || self.secondTitle == nil) {
                if (self.firstTitle == nil) {
                    [self.secondButton autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
                }else{
                    [self.firstButton autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
                }
            }else{
                [self.firstButton autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:margin];
                [self.secondButton autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:margin];
            }
            margin = JMAlertVerticalMargin;
            break;
        }
        case AlertTypeList:
        {
            self.contentLabel.textAlignment = NSTextAlignmentLeft;
            self.titleLabel.textAlignment = NSTextAlignmentLeft;
            self.firstButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            self.secondButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            
            [self.firstButton autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:label withOffset:JMAlertVerticalMargin];
            [self.firstButton autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:JMAlertHorizontalMargin];
            [self.firstButton autoSetDimension:(ALDimensionHeight) toSize:40];
            [self.firstButton autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:JMAlertHorizontalMargin];
            
            [self.secondButton autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_firstButton withOffset:0];
            [self.secondButton autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:JMAlertHorizontalMargin];
            [self.secondButton autoSetDimension:(ALDimensionHeight) toSize:40];
            [self.secondButton autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:JMAlertHorizontalMargin];
            
            UIView *line1 = [UIView new];
            line1.backgroundColor = FNHomeBackgroundColor;
            [self.backgroundView addSubview:line1];
            
            UIView *line2 = [UIView new];
            line2.backgroundColor = FNHomeBackgroundColor;
            [self.backgroundView addSubview:line2];
            
            [line1 autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:self.firstButton];
            [line1 autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
            [line1 autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
            [line1 autoSetDimension:(ALDimensionHeight) toSize:1.0];
            
            [line2 autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.firstButton];
            [line2 autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
            [line2 autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
            [line2 autoSetDimension:(ALDimensionHeight) toSize:1.0];
            break;
        }
        case AlertTypeActionSheet:
        {
            break;
        }
        default:
            break;
    }
    [self layoutIfNeeded];

    [self.backgroundView autoSetDimension:(ALDimensionHeight) toSize:CGRectGetMaxY(self.secondButton.frame)+margin];
}
- (void)showAlert{
    
    [FNKeyWindow addSubview:self];
    @WeakObj(self);
    [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [selfWeak.backgroundView.layer setValue:@(0) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.23 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [selfWeak.backgroundView.layer setValue:@(1.2) forKeyPath:@"transform.scale"];
            selfWeak.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.09 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [selfWeak.backgroundView.layer setValue:@(.9) forKeyPath:@"transform.scale"];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.05 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [selfWeak.backgroundView.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
                } completion:^(BOOL finished) {

                }];
            }];
        }];
    }];
}
- (void)buttonClickCenter:(UIButton *)btn{
    if (self.firstButton == btn) {
        if (self.clickeblock) {
            self.clickeblock(0);
        }
    }else{
        if (self.clickeblock) {
            self.clickeblock(1);
        }
    }
//    self.type = AlertTypeList;
    [self dismiss];
}
- (void)dismiss{
    @WeakObj(self);
    [UIView animateWithDuration:0.3 animations:^{
        selfWeak.backgroundView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        selfWeak.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    } completion:^(BOOL finished) {
        if (finished && selfWeak.type == AlertTypeAlert) {
            if (selfWeak.clickeblock) {
                selfWeak.clickeblock(selfWeak.index);
            }
            
        }
        [selfWeak removeFromSuperview];
    }];
    
    
    
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (point.x < self.backgroundView.x || point.x > CGRectGetMaxX(self.backgroundView.frame) || point.y < self.backgroundView.y || point.y > CGRectGetMaxY(self.backgroundView.frame)) {
        [self dismiss];
    }
    return [super hitTest:point withEvent:event];
}
@end
