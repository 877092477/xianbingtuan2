//
//  FNPartnerApplyTitleView.m
//  SuperMode
//
//  Created by jimmy on 2017/10/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPartnerApplyTitleView.h"

@implementation FNPartnerApplyTitleView

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = kFONT14;
        
    }
    return _titleLabel;
}
- (UIView *)line{
    if (_line == nil) {
        _line = [UIView new];
        _line.backgroundColor = FNMainGobalControlsColor;
    }
    return _line;
}

#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    [self addSubview:self.line];
    [self.line autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:15];
    [self.line autoSetDimensionsToSize:(CGSizeMake(1.5, 20))];
    [self.line autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.line withOffset:5];
    [self.titleLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [self.titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:15];

}
@end
