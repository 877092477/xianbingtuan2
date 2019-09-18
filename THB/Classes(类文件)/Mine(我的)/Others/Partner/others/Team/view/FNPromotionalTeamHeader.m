//
//  FNPromotionalTeamHeader.m
//  SuperMode
//
//  Created by jimmy on 2017/10/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPromotionalTeamHeader.h"

@implementation FNPromotionalTeamHeader
- (UILabel *)countLabel{
    if (_countLabel == nil) {
        _countLabel = [UILabel new];
        _countLabel.font = kFONT14;
        _countLabel.textColor = FNWhiteColor;
        _countLabel.textAlignment =  NSTextAlignmentCenter;
    }
    return _countLabel;
}

- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        _moneyLabel = [UILabel new];
        _moneyLabel.font = kFONT14;
        _moneyLabel.textColor = FNWhiteColor;
        _moneyLabel.textAlignment =  NSTextAlignmentCenter;
        _moneyLabel.text = @"0.00f";
    }
    return _moneyLabel;
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    self.backgroundColor = FNMainGobalControlsColor;
    [self addSubview:self.countLabel];
    [self.countLabel autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:15*2];
    [self.countLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:15];
    [self.countLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:15];
    
    [self addSubview:self.moneyLabel];
    [self.moneyLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, 15, 15*2, 15))excludingEdge:(ALEdgeTop)];
}
@end
