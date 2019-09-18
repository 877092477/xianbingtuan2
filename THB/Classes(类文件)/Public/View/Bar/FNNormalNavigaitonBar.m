//
//  FNNormalNavigaitonBar.m
//  SuperMode
//
//  Created by jimmy on 2017/10/16.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNNormalNavigaitonBar.h"

@implementation FNNormalNavigaitonBar
- (UIView *)contentview{
    if (_contentview == nil) {
        _contentview = [UIView new];
    }
    return _contentview;
}

- (UIButton *)backbtn{
    if (_backbtn == nil) {
        _backbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_backbtn setImage:IMAGE(@"return") forState:(UIControlStateNormal)];
        [_backbtn sizeToFit];
        
        [self.contentview addSubview:_backbtn];
        [_backbtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [_backbtn autoSetDimensionsToSize:CGSizeMake(_backbtn.width+10, _backbtn.height+10)];
        [_backbtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:15];
    }
    return _backbtn;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = kFONT17;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentview addSubview:self.titleLabel];
        [self.titleLabel autoCenterInSuperview];
        [self.titleLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:self.contentview withMultiplier:0.7];
    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIBlurEffect* effect = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleLight)];
        UIVisualEffectView* effectview = [[UIVisualEffectView alloc]initWithEffect:effect];
        
        [self addSubview:self.contentview];
        [self.contentview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
        [self.contentview autoSetDimension:(ALDimensionHeight) toSize:44];
        
        [self insertSubview:effectview atIndex:0];
        self.backgroundColor =  FNWhiteColor;
    }
    return self;
}
@end
