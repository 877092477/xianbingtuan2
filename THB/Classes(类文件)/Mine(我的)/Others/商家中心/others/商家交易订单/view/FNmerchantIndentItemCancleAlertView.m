//
//  FNmerchantIndentItemCancleAlertView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/24.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNmerchantIndentItemCancleAlertView.h"

@interface FNmerchantIndentItemCancleAlertView()

@property (nonatomic, strong) UIButton *btnBg;
@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;
@property (nonatomic, strong) UIButton *btnAgree;
@property (nonatomic, strong) UIButton *btnDisagree;
@property (nonatomic, strong) UIButton *btnCancle;
@property (nonatomic, strong) UIButton *btnConfirm;
@property (nonatomic, strong) UITextField *txfDesc;

@property (nonatomic, strong) UIView *vPoint1;
@property (nonatomic, strong) UIView *vPointBorder1;
@property (nonatomic, strong) UIView *vPoint2;
@property (nonatomic, strong) UIView *vPointBorder2;

@property (nonatomic, strong) ConfirmClick block;

@end

@implementation FNmerchantIndentItemCancleAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _btnBg = [[UIButton alloc] init];
    _vContent = [[UIView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _btnAgree = [[UIButton alloc] init];
    _btnDisagree = [[UIButton alloc] init];
    _btnCancle = [[UIButton alloc] init];
    _btnConfirm = [[UIButton alloc] init];
    _txfDesc = [[UITextField alloc] init];
    
    _vPoint1 = [[UIView alloc] init];
    _vPointBorder1 = [[UIView alloc] init];
    _vPoint2 = [[UIView alloc] init];
    _vPointBorder2 = [[UIView alloc] init];
    
    [self addSubview:_btnBg];
    [self addSubview:_vContent];
    [_vPointBorder1 addSubview:_vPoint1];
    [_vContent addSubview:_vPointBorder1];
    [_vPointBorder2 addSubview:_vPoint2];
    [_vContent addSubview:_vPointBorder2];
    
    [_vContent addSubview:_lblTitle];
    [_vContent addSubview:_lblDesc];
    [_vContent addSubview:_btnAgree];
    [_vContent addSubview:_btnDisagree];
    [_vContent addSubview:_btnCancle];
    [_vContent addSubview:_btnConfirm];
    [_vContent addSubview:_txfDesc];
    
    [_btnBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.left.equalTo(@40);
        make.right.equalTo(@-40);
        make.top.greaterThanOrEqualTo(@40);
        make.bottom.lessThanOrEqualTo(@-40);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@20);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(10);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_btnAgree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.lblDesc.mas_bottom).offset(6);
        make.right.equalTo(@-20);
        make.height.mas_equalTo(44);
    }];
    [_btnDisagree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.btnAgree.mas_bottom);
        make.right.equalTo(@-20);
        make.height.mas_equalTo(44);
    }];
    [_txfDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.btnDisagree.mas_bottom).offset(10);
        make.right.equalTo(@-20);
        make.height.mas_equalTo(0);
    }];
    [_btnCancle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btnConfirm.mas_left).offset(-40);
        make.top.equalTo(self.txfDesc.mas_bottom).offset(10);
        make.height.mas_equalTo(38);
        make.bottom.equalTo(@-20);
    }];
    [_btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.top.equalTo(self.txfDesc.mas_bottom).offset(10);
        make.height.mas_equalTo(38);
        make.bottom.equalTo(@-20);
    }];
    
    [_vPoint1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.height.mas_equalTo(10);
    }];
    [_vPointBorder1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btnAgree);
        make.centerY.equalTo(self.btnAgree);
        make.width.height.mas_equalTo(14);
    }];
    [_vPoint2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.height.mas_equalTo(10);
    }];
    [_vPointBorder2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btnDisagree);
        make.centerY.equalTo(self.btnDisagree);
        make.width.height.mas_equalTo(14);
    }];
    
    _btnBg.backgroundColor = RGBA(0, 0, 0, 0.2);
    
    _vContent.backgroundColor = UIColor.whiteColor;
    _vContent.cornerRadius = 4;
    
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.text = @"退款申请";
    _lblTitle.font =[UIFont systemFontOfSize:18];;
    
    _lblDesc.textColor = RGB(153, 153, 153);
    _lblDesc.text = @"确认退款余额将返还至用户账户余额";
    _lblDesc.font =kFONT12;
    
    [_btnAgree setTitle:@"同意退款" forState: UIControlStateNormal];
    [_btnAgree setTitleColor: RGB(51, 51, 51) forState: UIControlStateNormal];
    _btnAgree.titleLabel.font = kFONT15;
    _btnAgree.titleLabel.textAlignment = NSTextAlignmentLeft;
    _btnAgree.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [_btnDisagree setTitle:@"不同意退款" forState: UIControlStateNormal];
    [_btnDisagree setTitleColor: RGB(51, 51, 51) forState: UIControlStateNormal];
    _btnDisagree.titleLabel.font = kFONT15;
    _btnDisagree.titleLabel.textAlignment = NSTextAlignmentLeft;
    _btnDisagree.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [_btnCancle setTitle:@"取消" forState: UIControlStateNormal];
    [_btnCancle setTitleColor: RGB(153, 153, 153) forState: UIControlStateNormal];
    _btnCancle.titleLabel.font = kFONT15;
    
    [_btnConfirm setTitle:@"确认" forState: UIControlStateNormal];
    [_btnConfirm setTitleColor: RGB(255, 85, 85) forState: UIControlStateNormal];
    _btnConfirm.titleLabel.font = kFONT15;
    
    _txfDesc.backgroundColor = RGB(240, 240, 240);
    _txfDesc.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 38)];
    _txfDesc.hidden = YES;
    _txfDesc.placeholder = @"请输入您的留言，以便顾客能够更好的谅解";
    _txfDesc.font = kFONT12;
    _txfDesc.leftViewMode = UITextFieldViewModeAlways;
    
    _vPoint1.cornerRadius = 5;
    _vPoint1.backgroundColor = RGB(255, 85, 85);
    _vPoint1.hidden = YES;
    
    _vPointBorder1.cornerRadius = 7;
    _vPointBorder1.backgroundColor = UIColor.clearColor;
    _vPointBorder1.borderWidth = 1;
    _vPointBorder1.borderColor = RGB(255, 85, 85);
    
    _vPoint2.cornerRadius = 5;
    _vPoint2.backgroundColor = RGB(255, 85, 85);
    _vPoint2.hidden = YES;

    _vPointBorder2.cornerRadius = 7;
    _vPointBorder2.borderWidth = 1;
    _vPointBorder2.borderColor = RGB(255, 85, 85);
    
    
    [_btnAgree addTarget:self action:@selector(item1Click) forControlEvents:UIControlEventTouchUpInside];
    [_btnDisagree addTarget:self action:@selector(item2Click) forControlEvents:UIControlEventTouchUpInside];
    [_btnCancle addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnConfirm addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnBg addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}

- (void)item1Click {
    _vPoint1.hidden = NO;
    _vPoint2.hidden = YES;
    [_txfDesc mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    _txfDesc.hidden = YES;
}

- (void)item2Click {
    _vPoint2.hidden = NO;
    _vPoint1.hidden = YES;
    [_txfDesc mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(38);
    }];
    _txfDesc.hidden = NO;
}

- (void)cancleClick {
    [self dismiss];
}

- (void)confirmClick {
    if (_vPoint1.hidden && _vPoint2.hidden) {
        [FNTipsView showTips:@"是否同意退款？"];
        return ;
    }
    if (_block) {
        _block(!_vPoint1.hidden, _txfDesc.text);
    }
}

- (void)show: (ConfirmClick) block {
    
    _block = block;
    
    self.hidden = NO;
    
    _vPoint1.hidden = YES;
    _vPoint2.hidden = YES;
    [_txfDesc mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    _txfDesc.hidden = YES;
    _txfDesc.text = @"";
}

- (void)dismiss {
    self.hidden = YES;
}

@end
