//
//  FNMineHeader.m
//  THB
//
//  Created by Jimmy on 2018/1/16.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNMineHeader.h"
@interface FNMineHeader()
@property (nonatomic, strong)UIView* contentview;
@property (nonatomic, strong)UILabel* rankLabel;
@property (nonatomic, strong)UIImageView* avatarImgView;
@property (nonatomic, strong)UILabel* phoneLabel;

@property (nonatomic, strong)UIButton* loginBtn;



@end
@implementation FNMineHeader
- (UILabel *)rankLabel{
    if (_rankLabel == nil) {
        _rankLabel = [UILabel new];
        _rankLabel.font = kFONT12;
        _rankLabel.textColor = FNWhiteColor;
        _rankLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _rankLabel;
}

- (UILabel *)phoneLabel{
    if (_phoneLabel == nil) {
        _phoneLabel = [UILabel new];
        _phoneLabel.font = kFONT12;
        _phoneLabel.textColor = FNWhiteColor;
        _phoneLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _phoneLabel;
}

- (UIImageView *)avatarImgView{
    if (_avatarImgView == nil) {
        _avatarImgView = [UIImageView new];
        _avatarImgView.size = CGSizeMake(0.4*self.height, 0.4*self.height);
        _avatarImgView.cornerRadius = _avatarImgView.width*0.5;
        _avatarImgView.borderColor = FNWhiteColor;
        _avatarImgView.borderWidth = 5;
        
    }
    return _avatarImgView;
}
- (UIView *)contentview{
    if (_contentview== nil) {
        _contentview = [UIView new];
        _contentview.hidden = YES;
        @weakify(self);
        [_contentview addJXTouch:^{
            @strongify(self);
            if (self.profileClicked) {
                self.profileClicked();
            }
        }];
        [_contentview addSubview:self.phoneLabel];
         [self.phoneLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(_jmsize_10, _jmsize_10, _jmsize_10, _jmsize_10)) excludingEdge:(ALEdgeTop)];
        
        
        
        [_contentview addSubview:self.avatarImgView];
        [self.avatarImgView autoSetDimensionsToSize:self.avatarImgView.size];
        [self.avatarImgView autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
        [self.avatarImgView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:self.phoneLabel withOffset:-_jmsize_10];
        
        [self.avatarImgView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeTop) ofView:_contentview withOffset:45];
        
        [_contentview addSubview:self.rankLabel];
        [self.rankLabel autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:self.avatarImgView withOffset:-_jmsize_10];
        [self.rankLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.phoneLabel];
        [self.rankLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self.phoneLabel];
        
    }
    return _contentview;
}

- (UIButton *)loginBtn{
    if (_loginBtn == nil) {
        _loginBtn = [UIButton buttonWithTitle:@"登录/注册" titleColor:FNWhiteColor font:kFONT14 target:self action:@selector(loginBtnAction)];
        [_loginBtn sizeToFit];
        _loginBtn.borderColor = FNWhiteColor;
        _loginBtn.borderWidth = 1;
        _loginBtn.cornerRadius = 5;
        _loginBtn.hidden = NO;
        _loginBtn.size = CGSizeMake(_loginBtn.width+_jmsize_10, _loginBtn.height);
        
    }
    return _loginBtn;
}
- (void)jm_setupViews{
    [self addSubview:self.contentview];
    [self.contentview autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    [self.contentview autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0.14*self.height];
    [self.contentview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeTop) ofView:self.rankLabel withOffset:-_jmsize_10];
    
    [self addSubview:self.loginBtn];
    [self.loginBtn autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    [self.loginBtn autoSetDimensionsToSize:self.loginBtn.size];
    [self.loginBtn autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.contentview withOffset:_jm_margin10];
    
//    self.upgradeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    self.upgradeButton.titleLabel.font=kFONT12;
//    self.upgradeButton.backgroundColor=RGB(255, 226, 55);
//    self.upgradeButton.cornerRadius=15;
//    [self addSubview:self.upgradeButton];
//    self.upgradeButton.sd_layout
//    .centerXEqualToView(self).heightIs(30).bottomSpaceToView(self, 15);
//    [self.upgradeButton setupAutoSizeWithHorizontalPadding:15 buttonHeight:30];
//
//    [self.upgradeButton updateLayout];
//    [self updateLayout];
    
}
- (void)setModel:(ProfileModel *)model{
    _model = model;
    if (_model) {
        [self.avatarImgView setUrlImg:_model.head_img];
        self.phoneLabel.text = self.model.phone;
        self.rankLabel.text = self.model.vip_name;
        
        self.contentview.hidden = NO;
        self.loginBtn.hidden = YES;
        
       
        
    }else{
        self.loginBtn.hidden = NO;
        self.contentview.hidden = YES; 
        
    }
    
}

#pragma mark - action
- (void)loginBtnAction{
    if (self.loginClicked) {
        self.loginClicked();
    }
}
@end
