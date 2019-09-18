//
//  JMInviteFriendAwardView.m
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

#import "JMInviteFriendAwardView.h"
#import "JMInviteFriendModel.h"
@interface JMInviteFriendAwardView ()
@property (nonatomic, weak)UIImageView* bgImgView;
@property (nonatomic, weak)UIImageView* rebateImgView;
@property (nonatomic, weak)UILabel* tipsLabel;

@property (nonatomic, strong)NSLayoutConstraint* rebateImgHeightCons;


@end
@implementation JMInviteFriendAwardView
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
    UIImageView* bgImgView = [UIImageView new];
//    bgImgView.image = [IMAGE(@"invite_myreward_bj1") stretchableImageWithLeftCapWidth:FNDeviceWidth-_jm_leftMargin*2  topCapHeight:50];
    bgImgView.image = IMAGE(@"invite_myreward_bj1");
    [self addSubview:bgImgView];
    _bgImgView = bgImgView;
    
    UIImageView*  questionMarkImgView = [UIImageView new];
    questionMarkImgView.image = IMAGE(@"invite_help");
    [questionMarkImgView sizeToFit];
    [self addSubview:questionMarkImgView];
    _questionMarkImgView  = questionMarkImgView;
    
    UIImageView* rebateImgView = [UIImageView new];
    [self addSubview:rebateImgView];
    _rebateImgView = rebateImgView;
    
    UIButton* inviteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [inviteBtn setTitle:@"立即邀请" forState:UIControlStateNormal];
    [inviteBtn setTitleColor:FNWhiteColor forState:(UIControlStateNormal)];
    inviteBtn.backgroundColor = FNColor(218, 31, 23);
    inviteBtn.cornerRadius = 20;
    [inviteBtn addTarget:self action:@selector(inviteButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:inviteBtn];
    _inviteButton = inviteBtn;
    
    UILabel* tipsLabel = [UILabel new];
    tipsLabel.font = kFONT12;
    tipsLabel.text = @"被邀请好友可得0元新人红包";
    tipsLabel.textColor = FNColor(135, 82, 42);
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tipsLabel];
    _tipsLabel = tipsLabel;
    
    UIButton* invitedRuleBtnn = [UIButton buttonWithTitle:@"邀请规则  >" titleColor:RED font:kFONT14 target:self action:nil];
    [invitedRuleBtnn sizeToFit];
    [invitedRuleBtnn addTarget:self action:@selector(ruleButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:invitedRuleBtnn];
    _invitedRuleBtn = invitedRuleBtnn;
    
    
    //layout
    [_bgImgView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    
    [_rebateImgView autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_bgImgView withOffset:_jm_leftMargin];
    [_rebateImgView autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:_bgImgView withOffset:-_jm_leftMargin];
    [_rebateImgView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeTop) ofView:_bgImgView withOffset:_jm_leftMargin*2];
    _rebateImgHeightCons = [_rebateImgView autoSetDimension:(ALDimensionHeight) toSize:0];
    
    [_inviteButton autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_bgImgView withOffset:_jm_leftMargin];
    [_inviteButton autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:_bgImgView withOffset:-_jm_leftMargin];
    [_inviteButton autoSetDimension:(ALDimensionHeight) toSize:40];
    [_inviteButton autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_rebateImgView withOffset:_jm_leftMargin];
    
    [_tipsLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_inviteButton withOffset:_jm_margin10];
    [_tipsLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_leftMargin];
    [_tipsLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_leftMargin];
    
    [_invitedRuleBtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_tipsLabel withOffset:_jm_margin10];
    [_invitedRuleBtn autoSetDimensionsToSize:_invitedRuleBtn.size];
    [_invitedRuleBtn autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    
    [_bgImgView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_invitedRuleBtn withOffset:_jm_leftMargin];
    
    [_questionMarkImgView autoSetDimensionsToSize:(_questionMarkImgView.size)];
    [_questionMarkImgView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
    [_questionMarkImgView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    
    [self layoutIfNeeded];
    self.height = CGRectGetMaxY(_bgImgView.frame);
    self.viewHeight = CGRectGetMaxY(_bgImgView.frame);
}
#pragma mark - actions
- (void)inviteButtonAction{
    if (self.buttonClickedBlock) {
        self.buttonClickedBlock(IFButtonTypeInvite);
    }
}
- (void)ruleButtonAction{
    if (self.buttonClickedBlock) {
        self.buttonClickedBlock(IFButtonTypeRule);
    }
}
#pragma mark -  setter && getter
- (void)setModel:(JMInviteFriendModel *)model{
    _model = model;
    if (_model) {
        @WeakObj(self);
        [_rebateImgView sd_setImageWithURL:[NSURL URLWithString:_model.jl_bj] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                selfWeak.rebateImgHeightCons.constant = image.size.height*(FNDeviceWidth-_jm_leftMargin*4)/image.size.width;
                [selfWeak layoutIfNeeded];
                selfWeak.height = CGRectGetMaxY(selfWeak.bgImgView.frame);
                selfWeak.viewHeight = selfWeak.height;
                if (selfWeak.changeHeightBlock) {
                    selfWeak.changeHeightBlock(selfWeak.viewHeight);
                }
            }
        }];
        _tipsLabel.text = model.str4;
        
    }
}
@end
