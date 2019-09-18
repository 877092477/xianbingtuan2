//
//  FNPartnerApplyInputView.m
//  SuperMode
//
//  Created by jimmy on 2017/10/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPartnerApplyInputView.h"
const CGFloat _paiv_top_height = 30;
const CGFloat _paiv_textview_rate = 0.55;
const CGFloat _paiv_textfiled_h = 40;
@implementation FNPartnerApplyInputView
- (FNPartnerApplyTitleView *)topview{
    if (_topview == nil) {
        _topview = [FNPartnerApplyTitleView new];
        _topview.titleLabel.text = @"填写相关信息";
        _topview.backgroundColor = FNWhiteColor;
    }
    return _topview;
}

- (FNCustomeTextView *)textview{
    if (_textview == nil) {
        _textview = [[FNCustomeTextView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth-15*2, _paiv_textview_rate*(JMScreenWidth-15*2)))];
        _textview.borderColor = FNHomeBackgroundColor;
        _textview.borderWidth = 1;
        _textview.placeholder = @"请描述一下您的申请合伙人的意向";
        _textview.placeholderColor = FNHomeBackgroundColor;
        _textview.cornerRadius = 5;
    }
    return _textview;
}

- (UITextField *)nameTF{
    if (_nameTF == nil) {
        _nameTF = [[UITextField alloc]init];
        _nameTF.borderStyle= UITextBorderStyleRoundedRect;
        _nameTF.font = kFONT14;
        _nameTF.placeholder = @"请填写您的名字";
    }
    return _nameTF;
}
- (UITextField *)qqTF{
    if (_qqTF == nil) {
        _qqTF = [[UITextField alloc]init];
        _qqTF.borderStyle= UITextBorderStyleRoundedRect;
        _qqTF.font = kFONT14;
        _qqTF.placeholder = @"请填写您的QQ";
        _qqTF.keyboardType = UIKeyboardTypePhonePad;
    }
    return _qqTF;
}
- (UITextField *)phoneTF{
    if (_phoneTF == nil) {
        _phoneTF = [[UITextField alloc]init];
        _phoneTF.borderStyle= UITextBorderStyleRoundedRect;
        _phoneTF.keyboardType = UIKeyboardTypePhonePad;
        _phoneTF.font = kFONT14;
        _phoneTF.placeholder = @"请填写您的手机号";
    }
    return _phoneTF;
}

- (UIView *)contactview{
    if (_contactview == nil) {
        _contactview = [UIView new];
        
        FNPartnerApplyTitleView* titleview = [FNPartnerApplyTitleView new];
        titleview.titleLabel.textColor = FNMainGobalControlsColor;
        titleview.titleLabel.text = @"有问题 联系客服帮忙";
        [_contactview addSubview:titleview];
        [titleview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
        [titleview autoSetDimension:(ALDimensionHeight) toSize:_paiv_top_height];
        
        UIView* bgview = [UIView new];
        [_contactview addSubview:bgview];
        [bgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
        [bgview autoSetDimension:(ALDimensionHeight) toSize:_paiv_top_height];
        
        
        [bgview addSubview:self.contactLabel];
        [self.contactLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10*2];
        [self.contactLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.contactLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10*2];
        
    }
    return _contactview;
}
- (UILabel *)contactLabel{
    if (_contactLabel == nil) {
        _contactLabel = [UILabel new];
        _contactLabel.font = kFONT14;
        _contactLabel.textColor = FNMainGobalControlsColor;
    }
    return _contactLabel;
}
- (UIView *)typedview{
    if (_typedview == nil) {
        _typedview = [UIView new];
        _typedview.backgroundColor = FNWhiteColor;
        [_typedview addSubview:self.textview];
        [self.textview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, 15, 0, 15))excludingEdge:(ALEdgeBottom)];
        [self.textview autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionWidth) ofView:self.textview withMultiplier:_paiv_textview_rate];
        
        [_typedview addSubview:self.nameTF];
        [self.nameTF autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:15];
        [self.nameTF autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:15];
        [self.nameTF autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.textview withOffset:_jmsize_10];
        [self.nameTF autoSetDimension:(ALDimensionHeight) toSize:_paiv_textfiled_h];
        
        [_typedview addSubview:self.qqTF];
        [self.qqTF autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:15];
        [self.qqTF autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:15];
        [self.qqTF autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.nameTF withOffset:_jmsize_10];
        [self.qqTF autoSetDimension:(ALDimensionHeight) toSize:_paiv_textfiled_h];
        
        [_typedview addSubview:self.phoneTF];
        [self.phoneTF autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:15];
        [self.phoneTF autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:15];
        [self.phoneTF autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.qqTF withOffset:_jmsize_10];
        [self.phoneTF autoSetDimension:(ALDimensionHeight) toSize:_paiv_textfiled_h];
        
        [_typedview addSubview:self.contactview];
        [self.contactview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [self.contactview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        [self.contactview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.phoneTF withOffset:_jmsize_10];
        [self.contactview autoSetDimension:(ALDimensionHeight) toSize:_paiv_top_height*2];
        
        
    }
    return _typedview;
}

- (UIButton *)applybtn{
    if (_applybtn == nil) {
        _applybtn = [UIButton buttonWithTitle:@"申请成为合伙人" titleColor:FNWhiteColor font:[UIFont boldSystemFontOfSize:15] target:self action:@selector(applybtnAction)];
        _applybtn.backgroundColor = FNMainGobalControlsColor;
        _applybtn.cornerRadius = 5;
    }
    return _applybtn;
}


#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    [self addSubview:self.topview];
    [self.topview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.topview autoSetDimension:(ALDimensionHeight) toSize:_paiv_top_height];
    
    [self addSubview:self.typedview];
    [self.typedview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.typedview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [self.typedview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.topview];
    [self.typedview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.contactview withOffset:_jmsize_10];
    
    [self addSubview:self.applybtn];
    [self.applybtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.typedview withOffset:_jmsize_10];
    [self.applybtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:15];
    [self.applybtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:15];
    [self.applybtn autoSetDimension:(ALDimensionHeight) toSize:40];
    
    [self layoutIfNeeded];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.height = CGRectGetMaxY(self.applybtn.frame)+_jmsize_10;
}
- (void)applybtnAction{
    if ([NSString isEmpty:self.textview.textView.text]) {
        [FNTipsView showTips:self.textview.placeholder];
        return;
    }
    if ([NSString isEmpty:self.nameTF.text]) {
        [FNTipsView showTips:self.nameTF.placeholder];
        return;
    }
    if ([NSString isEmpty:self.qqTF.text]) {
        [FNTipsView showTips:self.qqTF.placeholder];
        return;
    }
    if ([NSString isEmpty:self.phoneTF.text]) {
        [FNTipsView showTips:self.phoneTF.placeholder];
        return;
    }
    [self endEditing:YES];
    if (self.applyBlock) {
        self.applyBlock();
    }
}
@end
