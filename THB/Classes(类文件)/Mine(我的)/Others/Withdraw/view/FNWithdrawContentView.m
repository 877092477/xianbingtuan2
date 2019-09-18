//
//  FNWithdrawContentView.m
//  SuperMode
//
//  Created by jimmy on 2017/6/15.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNWithdrawContentView.h"

@implementation FNWithdrawContentView

#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    self.titlelabel = [UILabel new];
    self.titlelabel.textColor = FNGlobalTextGrayColor;
    self.titlelabel.font = kFONT14;
    self.titlelabel.text=@"标题";
    [self addSubview:self.titlelabel];
    
    UIImageView *IconImage=[UIImageView new];
    IconImage.contentMode=UIViewContentModeScaleAspectFit;
    [IconImage setUrlImg:[FNBaseSettingModel settingInstance].mon_icon];
    IconImage.size=CGSizeMake(50, 50);
    [self addSubview:IconImage];
    
    self.textField = [UITextField new];
    self.textField.keyboardType = UIKeyboardTypeDecimalPad;
    self.textField.font =  [UIFont boldSystemFontOfSize:34];
    self.textField.delegate = self;
    [self addSubview:self.textField];
    [self.textField addTarget:self action:@selector(didMoneyChange:) forControlEvents:UIControlEventEditingChanged];
    
    _clearAllBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_clearAllBtn setImage:IMAGE(@"wdclose_off") forState:UIControlStateNormal];
    [_clearAllBtn setImage:IMAGE(@"wdclose_on") forState:UIControlStateHighlighted];
    [_clearAllBtn sizeToFit];
    [_clearAllBtn addTarget:self action:@selector(clearAllBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_clearAllBtn];
    
    UIView* line = [UIView new];
    line.backgroundColor = FNHomeBackgroundColor;
    [self addSubview:line];
    
    _balanceLabel = [UILabel new];
    _balanceLabel.font = kFONT14;
    _balanceLabel.textColor = FNGlobalTextGrayColor;
    _balanceLabel.text=@"可提数量";
    [self addSubview:_balanceLabel];
    
    _withdrawAllBtn = [UIButton buttonWithTitle:@"" titleColor:FNMainGobalControlsColor font:kFONT14 target:self action:@selector(withdrawAllBtnAction:)];
    [self addSubview:_withdrawAllBtn];
    
    //layout
    [_titlelabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(_jmsize_10, _jmsize_15, 0, _jmsize_15)) excludingEdge:(ALEdgeBottom)];
    
    [_textField autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.titlelabel withOffset:_jmsize_10];
    [_textField autoSetDimension:(ALDimensionHeight) toSize:40];
    
    [self.clearAllBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
    [self.clearAllBtn autoSetDimensionsToSize:CGSizeMake(self.clearAllBtn.width+10, self.clearAllBtn.height+10)];
    [self.clearAllBtn autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.textField];
    
    [IconImage autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_15];
    [IconImage autoSetDimension:(ALDimensionWidth) toSize:IconImage.width];
    [IconImage autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.textField];
    
    [self.textField autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:IconImage withOffset:5];
    [self.textField autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:self.clearAllBtn withOffset:-5];
    
    [line autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_textField];
    [line autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:_clearAllBtn];
    [line autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.textField];
    [line autoSetDimension:(ALDimensionHeight) toSize:1.0];
    
    [self.balanceLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:line withOffset:_jmsize_10];
    [self.balanceLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_15];
    
    [self layoutIfNeeded];
    self.height = CGRectGetMaxY(self.balanceLabel.frame) +_jmsize_10;
}
- (void)withdrawAllBtnAction:(UIButton *)btn{
    self.textField.text = self.viewModel.balance;
}
- (void)clearAllBtnAction{
    NSLog(@"clae");
    self.textField.text = @"";
}

- (void)didMoneyChange: (id)sender {
    NSString *str = [NSString stringWithFormat:@"%@", _textField.text];
    double money = [str doubleValue] * [_viewModel.model.bili intValue] / 100;
    if (money >= 0.01) {
        self.balanceLabel.text = [NSString stringWithFormat: @"本次服务费约为：%.2lfRMB", money];
    } else {
        self.balanceLabel.text = _viewModel.model.moneyStr;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"text:%@,new:%@",textField.text,string);
    if (string.length == 0) {
        return YES;
    }
    if (([textField.text containsString:@"."] && [string isEqualToString:@"."] )|| (![string kr_isNumber]  && ![string isEqualToString:@"."])) {
        return NO;
    }else{
        return YES;
    }
}

-(void)setViewModel:(FNWithdrawViewModel *)viewModel{
    _viewModel=viewModel;
    if (_viewModel) {
        self.titlelabel.text = viewModel.model.topStr3;
        self.balanceLabel.text = viewModel.model.moneyStr;
        [self.withdrawAllBtn setTitle:viewModel.model.topStr6 forState:UIControlStateNormal];
        [self.withdrawAllBtn sizeToFit];
        [self.withdrawAllBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_15];
        [self.withdrawAllBtn autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.balanceLabel];
        [self.withdrawAllBtn autoSetDimensionsToSize:self.withdrawAllBtn.size];
    }
}
@end
