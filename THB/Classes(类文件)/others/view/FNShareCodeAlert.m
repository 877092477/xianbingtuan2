//
//  FNShareCodeAlert.m
//  SuperMode
//
//  Created by jimmy on 2017/10/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNShareCodeAlert.h"
static FNShareCodeAlert* _alertview = nil;
@interface FNShareCodeAlert()
@property (nonatomic, strong)UIView* mainview;

@property (nonatomic, strong)UIView* topview;

@property (nonatomic, strong)UIButton*  titleLabel;
@property (nonatomic, strong)UILabel*  contentLabel;
@property (nonatomic, strong)UIImageView * coverimgview;

@property (nonatomic, strong)UIView* btnview;

@end
@implementation FNShareCodeAlert
+ (instancetype)sharedInstance{
    if (_alertview == nil) {
        _alertview = [[FNShareCodeAlert alloc]initWithFrame:FNKeyWindow.bounds];
    }
    return _alertview;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self jm_setupViews];
    }
    return self;
}

- (UIButton *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _titleLabel.titleLabel.font = kFONT16;
        _titleLabel.backgroundColor = FNWhiteColor;
        [_titleLabel setTitleColor:FNBlackColor forState:(UIControlStateNormal)];
        [_titleLabel setTitle:[NSString stringWithFormat:@"   已为您生成%@口令   ",FNDisplayName] forState:(UIControlStateNormal)];
        [_titleLabel sizeToFit];
        _titleLabel.height = 30;
        
    }
    return _titleLabel;
}
- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [UILabel new];
        _contentLabel.font = kFONT14;
        _contentLabel.numberOfLines = 3;
        _contentLabel.textColor = FNGlobalTextGrayColor;
    }
    return _contentLabel;
}
- (UIImageView *)coverimgview{
    if (_coverimgview == nil) {
        _coverimgview = [[UIImageView alloc]initWithImage:IMAGE(@"command_password")];
    }
    return _coverimgview;
}
- (UIView *)topview{
    if (_topview == nil) {
        _topview = [UIView new];
        UIView* bgview = [UIView new];
        bgview.borderColor = FNGlobalTextGrayColor;
        bgview.borderWidth = 1;
        [_topview addSubview:bgview];
        [bgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(self.titleLabel.height*0.5+15, _jmsize_10*2, _jmsize_10*2, _jmsize_10*2))];
        
        [_topview addSubview:self.titleLabel];
        [self.titleLabel autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
        [self.titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:15];
        [self.titleLabel autoSetDimensionsToSize:self.titleLabel.size];
        
        [bgview addSubview:self.contentLabel];
        [self.contentLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(_jmsize_10+self.titleLabel.height*0.5, _jmsize_10, 0, _jmsize_10)) excludingEdge:(ALEdgeBottom)];
        
        [_topview addSubview:self.coverimgview];
        [self.coverimgview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        [self.coverimgview autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:_jmsize_10];
        [self.coverimgview autoSetDimensionsToSize:self.coverimgview.size];
    }
    return _topview;
}

- (UIView *)btnview{
    if (_btnview == nil) {
        _btnview = [UIView new];
        
        UIButton* cancelBtn = [UIButton buttonWithTitle:@"不分享了" titleColor:FNBlackColor font:kFONT14 target:self action:@selector(cancelBtnAction)];
        [cancelBtn sizeToFit];
        [_btnview addSubview:cancelBtn];
        [cancelBtn autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeRight)];
        [cancelBtn autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_btnview withMultiplier:0.5];
        
        UIButton* pasteBtn = [UIButton buttonWithTitle:@"去粘贴" titleColor:FNMainGobalControlsColor font:kFONT14 target:self action:@selector(pasteBtnAction)];
        [pasteBtn sizeToFit];
        [_btnview addSubview:pasteBtn];
        [pasteBtn autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeLeft)];
        [pasteBtn autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_btnview withMultiplier:0.5];
        
        UIView* topline = [UIView new];
        topline.backgroundColor = FNHomeBackgroundColor;
        [_btnview addSubview:topline];
        [topline autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
        [topline autoSetDimension:(ALDimensionHeight) toSize:1];
        
        UIView* midline = [UIView new];
        midline.backgroundColor = FNHomeBackgroundColor;
        [_btnview addSubview:midline];
        [midline autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
        [midline autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];
        [midline autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
        [midline autoSetDimension:(ALDimensionWidth) toSize:1];
    }
    return _btnview;
}
- (UIView *)mainview{
    if (_mainview == nil) {
        _mainview = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth-_jmsize_10*4, 30+15*3+15+_jmsize_10*4+40))];
        _mainview.backgroundColor = FNWhiteColor;
        _mainview.cornerRadius = 5;
        
        [_mainview addSubview:self.topview];
        [self.topview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
        [self.topview autoSetDimension:(ALDimensionHeight) toSize:30+15*3+15+_jmsize_10*4];
        
        [_mainview addSubview:self.btnview];
        
        [self.btnview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
        [self.btnview autoSetDimension:(ALDimensionHeight) toSize:44];
        
        
        
    }
    return _mainview;
}
#pragma mark - action
- (void)cancelBtnAction{
    if (self.block) {
        self.block(0);
    }
    [self dismiss];
}
- (void)pasteBtnAction{
    if (self.block) {
        self.block(1);
    }
    [self dismiss];
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    
    [self addSubview:self.mainview];
    [self.mainview autoSetDimensionsToSize:self.mainview.size];
    [self.mainview autoCenterInSuperview];
    [self layoutIfNeeded];
}
+ (void)showAlertWithContent:(NSString *)content withClickeBlock:(clickBlock)block{
    _alertview = [FNShareCodeAlert sharedInstance];
    _alertview.block = block;
    _alertview.contentLabel.text = content;
    [_alertview showAlert];
}
- (void)showAlert{
    [FNKeyWindow addSubview:self];
    @WeakObj(self);
    [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [selfWeak.mainview.layer setValue:@(0) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.23 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [selfWeak.mainview.layer setValue:@(1.2) forKeyPath:@"transform.scale"];
            selfWeak.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.09 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [selfWeak.mainview.layer setValue:@(.9) forKeyPath:@"transform.scale"];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.05 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [selfWeak.mainview.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
                } completion:^(BOOL finished) {
                    
                }];
            }];
        }];
    }];
}
- (void)dismiss{
    @WeakObj(self);
    [UIView animateWithDuration:0.3 animations:^{
        selfWeak.mainview.transform = CGAffineTransformMakeScale(0.1, 0.1);
        selfWeak.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    } completion:^(BOOL finished) {
        if (finished ) {
            if (selfWeak.block) {
                selfWeak.block(0);
            }
            
        }
        [selfWeak removeFromSuperview];
    }];
    
    
    
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (point.x < self.mainview.x || point.x > CGRectGetMaxX(self.mainview.frame) || point.y < self.mainview.y || point.y > CGRectGetMaxY(self.mainview.frame)) {
        [self dismiss];
    }
    return [super hitTest:point withEvent:event];
}
@end
