//
//  FNPartnerCenterHeader.m
//  SuperMode
//
//  Created by jimmy on 2017/10/16.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

const CGFloat _pch_avatar_h = 70;
#import "FNPartnerCenterHeader.h"

@implementation FNPartnerCenterHeader
- (UIImageView *)bgimgview{
    if (_bgimgview == nil) {
        _bgimgview = [[UIImageView alloc]initWithImage:IMAGE(@"partner_bj")];
    }
    return _bgimgview;
}
- (UIImageView *)avatarimgview{
    if (_avatarimgview == nil) {
        _avatarimgview = [UIImageView new];
        _avatarimgview.cornerRadius = _pch_avatar_h*0.5;
    }
    return _avatarimgview;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = FNWhiteColor;
        _nameLabel.font = kFONT16;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}
- (UILabel *)memberLabel{
    if (_memberLabel == nil) {
        _memberLabel = [UILabel new];
        _memberLabel.font = kFONT16;
        
    }
    return _memberLabel;
}
- (UIImageView *)membericon{
    if (_membericon == nil) {
        _membericon = [[UIImageView alloc]initWithImage:IMAGE(@"partner_vip_star")];
    }
    return _membericon;
}
- (UIView *)bgview{
    if (_bgview == nil) {
        _bgview  = [UIView new];
        
        
        [_bgview addSubview:self.membericon];
        
        [self.membericon autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.membericon autoSetDimensionsToSize:self.membericon.size];
        _bgview.height = self.membericon.height+_jmsize_10;
        _bgview.cornerRadius = _bgview.height*0.5;
        UIBlurEffect* effect = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleExtraLight)];
        UIVisualEffectView* effectview = [[UIVisualEffectView alloc]initWithEffect:effect];
        [_bgview insertSubview:effectview atIndex:0];
        [effectview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
        
        [_bgview addSubview:self.memberLabel];
        [self.memberLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.membericon withOffset:5];
        [self.memberLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        

        
    }
    return _bgview;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self jm_setupViews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    [self addSubview:self.bgimgview];
    [self.bgimgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
    [self addSubview:self.avatarimgview];
    [self.avatarimgview autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:JMNavBarHeigth*0.5];
    [self.avatarimgview autoSetDimensionsToSize:(CGSizeMake(_pch_avatar_h, _pch_avatar_h))];
    [self.avatarimgview autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.avatarimgview withOffset:_jmsize_10];
    [self.nameLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:15];
    [self.nameLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:15];
    
    [self addSubview:self.bgview];
    [self.bgview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.nameLabel withOffset:_jmsize_10];
    [self.bgview autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    [self.bgview autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self.memberLabel withOffset:5];
    [self.bgview autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.membericon withOffset:-5];
    [self.bgview autoSetDimension:(ALDimensionHeight) toSize:self.bgview.height];
 
    
    
}
@end
