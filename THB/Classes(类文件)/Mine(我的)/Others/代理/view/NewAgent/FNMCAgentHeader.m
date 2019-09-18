//
//  FNMCAgentHeader.m
//  THB
//
//  Created by jimmy on 2017/7/27.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNMCAgentHeader.h"

@implementation FNMCAgentHeader

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
    CGFloat margin_v = 15;
    CGFloat imgw = 70;
    //
    self.avatarImgView = [UIImageView new];
    self.avatarImgView.cornerRadius = imgw*0.5;
    self.avatarImgView.image = IMAGE(@"agent_head");
    [self addSubview:self.avatarImgView];
    [self.avatarImgView autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    [self.avatarImgView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:margin_v];
    [self.avatarImgView autoSetDimensionsToSize:(CGSizeMake(imgw, imgw))];

    _namelabel = [UILabel new];
    _namelabel.font = kFONT14;
    _namelabel.textColor = FNWhiteColor;
    _namelabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_namelabel];
    [_namelabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:margin_v];
    [_namelabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:margin_v];
    [_namelabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.avatarImgView withOffset:margin_v-5];
    
    
    _phoneLabel = [UILabel new];
    _phoneLabel.font = kFONT14;
    _phoneLabel.textColor = FNWhiteColor;
    _phoneLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_phoneLabel];
    [_phoneLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.namelabel withOffset:margin_v-5];
    [_phoneLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:margin_v];
    [_phoneLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:margin_v];
    
    self.height = imgw+ margin_v*4-10 +14*2;
    
    
}
@end
