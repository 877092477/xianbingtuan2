//
//  JMRebateRuleView.m
//  THB
//
//  Created by jimmy on 2017/4/21.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMRebateRuleView.h"
const CGFloat _rr_rebateBtnheight = 40;
@implementation JMRebateRuleView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addJXTouch:^{
            NSLog(@"sss");
        }];
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    _logoImgView = [UIImageView new];
    [self addSubview:_logoImgView];
    [_logoImgView autoSetDimension:(ALDimensionWidth) toSize:80];
    [_logoImgView autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    [_logoImgView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:_jm_leftMargin];
    self.imgHeightCons = [_logoImgView autoSetDimension:(ALDimensionHeight) toSize:0];
    
    _rebateBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _rebateBtn.cornerRadius = _rr_rebateBtnheight*0.5;
    _rebateBtn.backgroundColor = RED;
    [_rebateBtn setTitleColor:FNWhiteColor forState:UIControlStateNormal];
    [self addSubview:_rebateBtn];
    [_rebateBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_leftMargin*2];
    [_rebateBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_leftMargin*2];
    [_rebateBtn autoSetDimension:(ALDimensionHeight) toSize:_rr_rebateBtnheight];
    [_rebateBtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_logoImgView withOffset:_jm_leftMargin];
    
    _rebateDetailBtn = [UILabel new];
    _rebateDetailBtn.textColor = RED;
    _rebateDetailBtn.text = @"返还详情 ";
    [_rebateDetailBtn addAttchmentImage:IMAGE(@"vipshop_right") andBounds:(CGRectMake(0, -3, 20, 15)) atIndex:5];
    _rebateDetailBtn.font =kFONT14;
    [self addSubview:_rebateDetailBtn];
    [_rebateDetailBtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_rebateBtn withOffset:_jm_leftMargin];
    [_rebateDetailBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:_jm_leftMargin];
    
    
    
    _webView = [UIWebView new];
    _webView.backgroundColor = FNWhiteColor;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_webView];
    [_webView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, _jm_margin10, 0, _jm_margin10)) excludingEdge:(ALEdgeTop)];
    [_webView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_rebateDetailBtn withOffset:_jm_margin10];
    
    
    
    
}

@end
