//
//  FNNetCouponeHeaderView.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/11.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNetCouponeHeaderView.h"
#import "FNNetCouponeExchangeModel.h"

@interface FNNetCouponeHeaderView()


@end

@implementation FNNetCouponeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    _btnRule = [[UIButton alloc] init];
    _imgCoupone = [[UIImageView alloc] init];
    _lblCoupone = [[UILabel alloc] init];
    _lblMoney = [[UILabel alloc] init];
    _lblCouponeDesc = [[UILabel alloc] init];
    _btnExcharge = [[UIButton alloc] init];
    _imgInfo = [[UIImageView alloc] init];
    _lblInfo = [[UILabel alloc] init];
    _vInfo = [[UIView alloc] init];
    
    [self addSubview:_btnRule];
    [self addSubview:_imgCoupone];
    [self addSubview:_lblCoupone];
    [self addSubview:_lblMoney];
    [self addSubview:_lblCouponeDesc];
    [self addSubview:_btnExcharge];
    [self addSubview:_imgInfo];
    [self addSubview:_vInfo];
    [self addSubview:_lblInfo];
    
    [_btnRule mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@12);
        make.right.equalTo(@-12);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(22);
    }];
    [_imgCoupone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.width.height.mas_equalTo(210);
        make.top.equalTo(@30);
    }];
    [_lblCoupone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.imgCoupone).offset(52);
    }];
    [_lblMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.imgCoupone);
        make.left.greaterThanOrEqualTo(self.imgCoupone).offset(20);
        make.right.lessThanOrEqualTo(self.imgCoupone).offset(-20);
    }];
    [_lblCouponeDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imgCoupone);
        make.bottom.equalTo(self.imgCoupone).offset(-50);
    }];
    [_btnExcharge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.imgCoupone.mas_bottom).offset(12);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(0);
    }];
    [_imgInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.btnExcharge.mas_bottom).offset(16);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(0);
    }];
    [_vInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.lblInfo);
        make.left.equalTo(self.lblInfo).offset(-10);
        make.right.equalTo(self.lblInfo).offset(10);
        make.height.mas_equalTo(23);
    }];
    [_lblInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.imgInfo.mas_bottom).offset(20);
    }];
    
    
    _lblCoupone.font = kFONT15;
    _lblMoney.adjustsFontSizeToFitWidth = YES;
    _lblMoney.font = [UIFont boldSystemFontOfSize:51];
    _lblCouponeDesc.font = kFONT10;
    _lblInfo.font = kFONT12;
    _vInfo.layer.cornerRadius = 5;
    _vInfo.layer.masksToBounds = YES;
}



@end
