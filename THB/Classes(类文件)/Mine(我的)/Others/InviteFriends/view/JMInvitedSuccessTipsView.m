//
//  JMInvitedSuccessTipsView.m
//  THB
//
//  Created by jimmy on 2017/4/7.
//  Copyright © 2017年 方诺科技. All rights reserved.
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

#import "JMInvitedSuccessTipsView.h"

@implementation JMInvitedSuccessTipsView
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
    UIView* bgView = [UIView new];
    bgView.backgroundColor = [FNBlackColor colorWithAlphaComponent:0.4];
    bgView.cornerRadius = 20;
    [self addSubview:bgView];
    
    UIImageView* avatarImgView = [UIImageView new];
    [bgView addSubview:avatarImgView];
    _avatarImgView = avatarImgView;
    
    UILabel* tipsLabel = [UILabel new];
    tipsLabel.textColor = FNWhiteColor;
    [bgView addSubview:tipsLabel];
    _tipsLabel = tipsLabel;
    
    [bgView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, _jm_margin10, 0, 0)) excludingEdge:(ALEdgeRight)];
    
    [_avatarImgView autoSetDimensionsToSize:(CGSizeMake(40, 40))];
    [_avatarImgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [_avatarImgView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [_tipsLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_avatarImgView withOffset:5];
    [_tipsLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_tipsLabel autoSetDimension:(ALDimensionWidth) toSize:FNDeviceWidth-40-3*_jm_margin10 relation:(NSLayoutRelationLessThanOrEqual)];
    
    
    
}

@end
