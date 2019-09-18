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

#import "FNAlertWithImgView.h"
#define FNAlertVerticalMargin 15
#define FNAlertHorizontalMargin 15*2
#define FNBgViewWidth (FNDeviceWidth - 2*FNAlertHorizontalMargin)

FNAlertWithImgView * _fn_alert = nil;
@interface FNAlertWithImgView ()
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, assign)NSInteger index;
@property (nonatomic, strong)UIImageView* imgview;
@property (nonatomic, strong)UIView* lineTop;
@property (nonatomic, strong)UIView* lineMid;

@end
@implementation FNAlertWithImgView
+ (FNAlertWithImgView *)shareinstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _fn_alert = [[self alloc] initWithFrame:FNKeyWindow.bounds];
    });
    return _fn_alert;
}
- (UIView *)lineTop{
    if (_lineTop == nil) {
        _lineTop = [UIView new];
        _lineTop.backgroundColor = FNHomeBackgroundColor;
        
    }
    return _lineTop;
}
- (UIView *)lineMid{
    if (_lineMid == nil) {
        _lineMid = [UIView new];
        _lineMid.backgroundColor = FNHomeBackgroundColor;
        
    }
    return _lineMid;
}
- (UIImageView *)imgview{
    if (_imgview == nil) {
        _imgview = [UIImageView new];
        _imgview.size = IMAGE(@"relation_warn").size;
    }
    return _imgview;
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
        _titleLabel.textAlignment =NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [UILabel new];
        _contentLabel.font = kFONT14;
        _contentLabel.text = self.content;
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment =NSTextAlignmentCenter;
    }
    return _contentLabel;
}
+ (instancetype)alertWithTitle:(NSString *)title content:(NSString *)content firstTitle:(NSString *)firstTitle andSecondTitle:(NSString *)secondTitle topImg:(id)img  clickBlock:(AIClickBlock)clickblock {
    FNAlertWithImgView *alert = [FNAlertWithImgView shareinstance];
    if ([FNKeyWindow.subviews containsObject:alert]) {
        return nil;
    }
    alert.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    alert.title = title;
    alert.content = content;
    alert.firstTitle = firstTitle;
    alert.secondTitle = secondTitle;
    alert.clickeblock  = clickblock;
    alert.img = img;
    [alert initializedSubviews];
    return alert;
}

#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.backgroundView = nil;
    self.contentLabel = nil;
    self.titleLabel = nil;
    self.firstButton = nil;
    self.secondButton = nil;
    self.imgview = nil;
    self.lineTop = nil;
    self.lineMid = nil;
    
    
    [self addSubview:self.backgroundView];
    [self.backgroundView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:FNAlertHorizontalMargin];
    [self.backgroundView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:FNAlertHorizontalMargin];
    [self.backgroundView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [self.backgroundView addSubview:self.firstButton];
    
    [self.backgroundView addSubview:self.secondButton];
    [self.backgroundView addSubview:self.lineTop];
    [self.backgroundView addSubview:self.lineMid];
    
    if (self.img) {
        if ([self.img isKindOfClass:[UIImage class]]) {
            self.imgview.image = self.img;
        }else if ([self.img isKindOfClass:[NSString class]] && [self.img containsString:@"http"]){
            [self.imgview setUrlImg:self.img];
        }else{
            self.imgview.image =IMAGE(self.img);
        }
        [self.backgroundView addSubview:self.imgview];
        [self.imgview autoSetDimensionsToSize:self.imgview.size];
        [self.imgview autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:_jmsize_15*2];
        [self.imgview autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    }
    if (self.title) {
        
        
        [self.backgroundView addSubview:self.titleLabel];
        if (self.img) {
            [_titleLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.imgview withOffset:_jmsize_15];
            [_titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:FNAlertHorizontalMargin];
            [_titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:FNAlertHorizontalMargin];
            
        }else{
            [_titleLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(FNAlertVerticalMargin, FNAlertHorizontalMargin, 0, FNAlertHorizontalMargin)) excludingEdge:(ALEdgeBottom)];
        }
        
        
        if (self.content == nil) {
            [self layoutWithLabel:self.titleLabel];
        }
    }
    
    if (self.content) {
        [_backgroundView addSubview:self.contentLabel];
        [_contentLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:FNAlertHorizontalMargin];
        [_contentLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:FNAlertHorizontalMargin];
        if (self.title) {
            [_contentLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.titleLabel withOffset:FNAlertVerticalMargin];
        }else{
            [_contentLabel autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:FNAlertVerticalMargin*1.5];
        }
        [self layoutWithLabel:self.contentLabel];
    }
    
}
- (void)layoutWithLabel:(UILabel *)label{
    CGFloat margin = 0;
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.lineTop autoSetDimension:(ALDimensionHeight) toSize:1];
    [self.lineTop autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.lineTop autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    
    CGFloat margin1 = (self.width - FNAlertHorizontalMargin*2-self.firstButton.width-_secondButton.width)/3;
    [self.firstButton autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:label withOffset:FNAlertVerticalMargin];
    [self.firstButton autoSetDimensionsToSize:CGSizeMake(self.firstButton.width+20, self.firstButton.height+20)];
    
    [self.secondButton autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:label withOffset:FNAlertVerticalMargin];
    [self.secondButton autoSetDimensionsToSize:CGSizeMake(self.secondButton.width+20, self.secondButton.height+20)];
    if (self.firstTitle == nil || self.secondTitle == nil) {
        if (self.firstTitle == nil) {
            [self.lineTop autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:self.secondButton];
            [self.secondButton autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
        }else{
            [self.lineTop autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:self.firstButton];
            [self.firstButton autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
        }
    }else{
        [self.lineMid autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
        [self.lineMid autoSetDimension:(ALDimensionWidth) toSize:1];
        [self.lineMid autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionHeight) ofView:self.firstButton];
        [self.lineMid autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];
//        [self.firstButton autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:margin1];
//        [self.secondButton autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:margin1];
        [self.firstButton autoConstrainAttribute:ALEdgeRight toAttribute:ALAxisVertical ofView:self.backgroundView withOffset:-20];
        [self.self.secondButton autoConstrainAttribute:ALEdgeLeft toAttribute:ALAxisVertical ofView:self.backgroundView withOffset:20];
        [self.lineTop autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:self.firstButton];
    }
    margin = FNAlertVerticalMargin;
    [self layoutIfNeeded];
    
    [self.backgroundView autoSetDimension:(ALDimensionHeight) toSize:CGRectGetMaxY(self.secondButton.frame)];
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
//        if (finished) {
//            if (selfWeak.clickeblock) {
//                selfWeak.clickeblock(selfWeak.index);
//            }
//
//        }
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

