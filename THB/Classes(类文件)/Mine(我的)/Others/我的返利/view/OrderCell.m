//
//  OrderCell.m
//  THB
//
//  Created by Weller Zhao on 2018/12/26.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "OrderCell.h"

@interface OrderCell()

@property (nonatomic, strong) UIView *vBackground;

@property (nonatomic, strong) UIButton *btnCopy;

//@property (nonatomic, strong) UIView *vShop;
@property (nonatomic, strong) UIView *vLine;

@end

@implementation OrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    self.backgroundColor = UIColor.clearColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.vBackground = [[UIView alloc] init];
    self.imgHeader = [[UIImageView alloc] init];
    self.lblTitle = [[UILabel alloc] init];
    self.lblMoney = [[UILabel alloc] init];
    self.lblTime = [[UILabel alloc] init];
    self.lblOrderNum = [[UILabel alloc] init];
    self.btnCopy = [[UIButton alloc] init];
    self.lblCommissionTitle = [[UILabel alloc] init];
    self.lblCommission = [[UILabel alloc] init];
    self.vState = [[UIView alloc] init];
    self.lblState = [[UILabel alloc] init];
    self.vLine = [[UIView alloc] init];
    
    self.vShop = [[UIView alloc] init];
    self.lblShop = [[UILabel alloc] init];
    self.lblType = [[UILabel alloc] init];
    
    [self.contentView addSubview:self.vBackground];
    [self.vBackground addSubview:self.imgHeader];
    [self.vBackground addSubview:self.lblTitle];
    [self.vBackground addSubview:self.lblMoney];
    [self.vBackground addSubview:self.lblTime];
    [self.vBackground addSubview:self.lblOrderNum];
    [self.vBackground addSubview:self.btnCopy];
    [self.vBackground addSubview:self.lblCommissionTitle];
    [self.vBackground addSubview:self.lblCommission];
    [self.vBackground addSubview:self.vState];
    [self.vState addSubview:self.lblState];
    [self.vBackground addSubview:self.vLine];
    [self.vBackground addSubview:self.vShop];
    [self.vShop addSubview:self.lblShop];
    [self.vBackground addSubview:self.lblType];
    
    [self.vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.width.height.mas_equalTo(90);
        make.bottom.equalTo(@-10);
    }];
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(10);
        make.top.equalTo(self.imgHeader);
        make.right.lessThanOrEqualTo(self.lblMoney.mas_left).offset(-10);
    }];
    [self.lblTitle setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.lblMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.top.equalTo(self.imgHeader);
    }];
    [self.lblMoney setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(10);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(4);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [self.lblOrderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(10);
        make.top.equalTo(self.lblTime.mas_bottom).offset(4);
        make.right.equalTo(self.btnCopy.mas_left).offset(-10);
    }];
    [self.btnCopy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.lessThanOrEqualTo(@-10);
        make.width.mas_equalTo(34);
        make.height.mas_equalTo(14);
        make.centerY.equalTo(self.lblOrderNum);
    }];
    [self.lblCommissionTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lblCommission.mas_left);
        make.bottom.equalTo(self.imgHeader);
    }];
    [self.lblCommission mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.vState.mas_left).offset(-10);
        make.bottom.equalTo(self.imgHeader);
    }];
    [self.vState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.bottom.equalTo(self.imgHeader);
        make.height.mas_equalTo(18);
    }];
    [self.lblState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.right.equalTo(@-8);
        make.centerY.equalTo(@0);
    }];
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.right.bottom.equalTo(@0);
    }];
    [self.vShop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.imgHeader);
        make.left.equalTo(self.imgHeader.mas_right).offset(10);
        make.height.mas_equalTo(15);
    }];
    [self.lblShop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.left.equalTo(@8);
        make.right.equalTo(@-8);
    }];
    [self.lblType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lblShop);
        make.left.equalTo(self.vShop.mas_right).offset(4);
        make.right.lessThanOrEqualTo(self.lblCommissionTitle.mas_left).offset(-4);
    }];
    
    self.vBackground.backgroundColor = UIColor.whiteColor;
    
    self.imgHeader.contentMode = UIViewContentModeScaleToFill;
    
    self.lblTitle.textColor = RGB(24, 24, 24);
    self.lblTitle.font = kFONT12;
    
    self.lblMoney.textColor = RGB(24, 24, 24);
    self.lblMoney.font = kFONT12;
    
    self.lblTime.textColor = RGB(140, 140, 140);
    self.lblTime.font = kFONT11;
    
    [self.btnCopy setTitle:@"复制" forState:UIControlStateNormal];
    [self.btnCopy setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
    self.btnCopy.titleLabel.font = [UIFont systemFontOfSize:9];
    self.btnCopy.cornerRadius = 7;
    self.btnCopy.borderColor = RGB(140, 140, 140);
    self.btnCopy.borderWidth = 1;
    
    self.lblOrderNum.textColor = RGB(140, 140, 140);
    self.lblOrderNum.font = kFONT11;
    
    self.lblCommissionTitle.text = @"佣金";
    self.lblCommissionTitle.textColor = RGB(77, 77, 77);
    self.lblCommissionTitle.font = kFONT12;
    
    self.lblCommission.textColor = RGB(255, 90, 90);
    self.lblCommission.font = kFONT16;
    
    self.lblState.text = @"已付款";
    self.lblState.textColor = UIColor.whiteColor;
    self.lblState.font = kFONT11;
    
    self.vState.backgroundColor = RED;
    self.vState.cornerRadius = 9;
    
    self.vShop.borderColor = RGB(236, 171, 45);
    self.vShop.borderWidth = 1;
    
    self.lblShop.textColor = RGB(236, 171, 45);
    self.lblShop.font = kFONT11;
    
    self.lblType.textColor = RGB(77, 77, 77);
    self.lblType.font = kFONT11; 
    
    
    self.vLine.backgroundColor = FNHomeBackgroundColor;
    
    [_btnCopy addTarget:self action:@selector(onCopyClick)];
    
    self.logisticsBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.vBackground addSubview:self.logisticsBtn];
//    [self.logisticsBtn setTitle:@"查看物流" forState:UIControlStateNormal];
//    self.logisticsBtn.backgroundColor=RGB(255, 91, 34);
//    self.logisticsBtn.titleLabel.font=kFONT10;
//    self.logisticsBtn.cornerRadius=4;
//    self.logisticsBtn.imageView.contentMode=UIViewContentModeScaleAspectFill;
//    self.logisticsBtn.imageView.clipsToBounds = YES;
    self.logisticsBtn.sd_layout
    .rightSpaceToView(self.vBackground, 10).centerYEqualToView(self.btnCopy).widthIs(60).heightIs(22);
     [self.logisticsBtn addTarget:self action:@selector(logisticsBtnClick)];
}

- (void)onCopyClick {
    if ([_delegate respondsToSelector:@selector(didCopyClick:)])
        [_delegate didCopyClick:self];
}


- (void)logisticsBtnClick {
    if ([_delegate respondsToSelector:@selector(didCheckLogisticsClick:)])
        [_delegate didCheckLogisticsClick:self];
}


@end
