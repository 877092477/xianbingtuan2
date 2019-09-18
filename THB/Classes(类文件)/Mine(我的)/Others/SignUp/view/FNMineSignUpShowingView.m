//
//  FNMineSignUpShowingView.m
//  THB
//
//  Created by Jimmy on 2018/1/17.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNMineSignUpShowingView.h"
FNMineSignUpShowingView *_showingview = nil;
@interface FNMineSignUpShowingView()
@property (nonatomic, strong)UIView* mainview;
@property (nonatomic, strong)UIImageView* bgimgview;
@property (nonatomic, strong)NSLayoutConstraint* bgimgviewConh;
@property (nonatomic, strong)UIView* contentview;
@property (nonatomic, strong)UIButton* closeBtn;
@property (nonatomic, strong)UILabel* contentLabel;
@property (nonatomic, strong)UIButton* confirmbtn;
@property (nonatomic, strong)UIView* circleView;
@property (nonatomic, strong)UIImageView* iconImgView;

@end
@implementation FNMineSignUpShowingView
- (UIImageView *)iconImgView{
    if (_iconImgView == nil) {
        _iconImgView = [UIImageView new];
    }
    return _iconImgView;
}
- (UIView *)circleView{
    if (_circleView == nil) {
        _circleView = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, 70, 70))];
        _circleView.cornerRadius = _circleView.width*0.5;
        [_circleView addSubview:self.iconImgView];
        self.iconImgView.cornerRadius = (_circleView.width-_jmsize_10)*0.5;
        [self.iconImgView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(5, 5, 5, 5))];
    }
    return _circleView;
}
- (UIButton *)closeBtn{
    if (_closeBtn == nil) {
        _closeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_closeBtn setImage:IMAGE(@"sign_close") forState:(UIControlStateNormal)];
        [_closeBtn addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];
        [_closeBtn sizeToFit];
    }
    return _closeBtn;
}
- (UILabel *)contentLabel{
    if(_contentLabel == nil){
        _contentLabel = [UILabel new];
        _contentLabel.font = kFONT16;
        _contentLabel.numberOfLines = 3;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}
- (UIButton *)confirmbtn{
    if (_confirmbtn == nil) {
        _confirmbtn = [UIButton buttonWithTitle:@"确定" titleColor:FNWhiteColor font:kFONT14 target:self action:@selector(dismiss)];
        _confirmbtn.backgroundColor = RGB(249, 18, 90);
        _confirmbtn.cornerRadius = 5;
    }
    return _confirmbtn;
}
- (UIView *)contentview{
    if (_contentview == nil) {
        _contentview = [UIView new];
        _contentview.backgroundColor = FNWhiteColor;
        _contentview.cornerRadius = 5;
        
        _contentview.clipsToBounds = NO;
        [_contentview addSubview:self.circleView];
        [self.circleView autoSetDimensionsToSize:self.circleView.size];
        [self.circleView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:-self.circleView.height*0.5];
        [self.circleView autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
        
        [_contentview addSubview:self.closeBtn];
        [self.closeBtn autoSetDimensionsToSize:self.closeBtn.size];
        [self.closeBtn autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:_jmsize_10];
        [self.closeBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        
        [_contentview addSubview:self.contentLabel];
        [self.contentLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.circleView withOffset:30];
        [self.contentLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        [self.contentLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
        
        [_contentview addSubview:self.confirmbtn];
        [self.confirmbtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.contentLabel withOffset:30];
        [self.confirmbtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        [self.confirmbtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
        [self.confirmbtn autoSetDimension:(ALDimensionHeight) toSize:40];
    }
    return _contentview;
}

- (UIImageView *)bgimgview{
    if (_bgimgview == nil) {
        _bgimgview = [UIImageView new];
    }
    return _bgimgview;
}
- (UIView *)mainview{
    if (_mainview == nil) {
        _mainview = [UIView new];
        [_mainview addSubview:self.contentview];
        [self.contentview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0.17*JMScreenWidth];
        [self.contentview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0.17*JMScreenWidth];
        [self.contentview autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.contentview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.confirmbtn withOffset:_jmsize_10];
        
        [_mainview insertSubview:self.bgimgview atIndex:0];
        [self.bgimgview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        [self.bgimgview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [self.bgimgview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.contentview];
        self.bgimgviewConh =[self.bgimgview autoSetDimension:(ALDimensionHeight) toSize:self.bgimgview.height];
        
    }
    return _mainview;
}
- (void)jm_setupViews{
    self.mainview =nil;
    self.contentview = nil;
    self.bgimgview = nil;
    self.circleView = nil;
    self.closeBtn = nil;
    self.iconImgView = nil;
    self.confirmbtn = nil;
    self.contentLabel = nil;
    
    self.mainview.bounds = FNKeyWindow.bounds;
    [self addSubview:self.mainview];
    [self.mainview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
}
+ (FNMineSignUpShowingView *)shareinstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _showingview = [[self alloc] initWithFrame:FNKeyWindow.bounds];
    });
    return _showingview;
}
+ (void)showSignUpViewWithBgImage:(UIImage *)bgImage content:(NSString *)content iconImage:(UIImage *)iconImage hightLightedValue:(NSString *)value block:(MSS_CompeleteBlock)block{
    _showingview = [FNMineSignUpShowingView shareinstance];
    [_showingview jm_setupViews];
    _showingview.iconImgView.image = iconImage;
    _showingview.bgimgview.image = bgImage;
    if (bgImage == nil) {
        _showingview.bgimgview.size = CGSizeMake(JMScreenWidth, JMScreenWidth * 0.75);
        _showingview.bgimgviewConh.constant = JMScreenWidth * 0.75;
    } else {
        _showingview.bgimgview.size = CGSizeMake(JMScreenWidth, bgImage.size.height/bgImage.size.width*JMScreenWidth);
        _showingview.bgimgviewConh.constant = bgImage.size.height/bgImage.size.width*JMScreenWidth;
    }
    _showingview.contentLabel.text = content;
    if ([content containsString:value]) {
        [_showingview.contentLabel addSingleAttributed:@{NSForegroundColorAttributeName:FNMainGobalControlsColor} ofRange:[content rangeOfString:value]];
    }
    [_showingview layoutIfNeeded];
    [_showingview show];
}
- (void)show{
    
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
- (void)btnClickAction:(UIButton *)btn{

    [self dismiss];
}
- (void)dismiss{
    @WeakObj(self);
    [UIView animateWithDuration:0.3 animations:^{
        selfWeak.mainview.transform = CGAffineTransformMakeScale(0.1, 0.1);
        selfWeak.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    } completion:^(BOOL finished) {
        if (self.block) {
            self.block(nil);
        }
        [selfWeak removeFromSuperview];
    }];
    
    
    
}
@end
