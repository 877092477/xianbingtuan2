//
//  FNNetCouponeRechargeFooterCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNetCouponeRechargeFooterCell.h"

@implementation FNNetCouponeRechargeFooterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _btnPay = [[UIButton alloc] init];
    _lblPolicy = [[UILabel alloc] init];
    
    [self.contentView addSubview:_btnPay];
    [self.contentView addSubview:_lblPolicy];
    
    [_btnPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(72);
        make.width.mas_equalTo(326);
        make.top.equalTo(@10);
        make.centerX.equalTo(@0);
    }];
    
    [_lblPolicy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnPay.mas_bottom).offset(20);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
        make.centerX.equalTo(@0);
    }];
    
    _lblPolicy.textColor = RGB(142, 112, 108);
    _lblPolicy.font = kFONT10;
    
    [_btnPay addTarget:self action:@selector(onRechargeClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onRechargeClick {
    if ([_delegate respondsToSelector:@selector(didRechargeClick:)]) {
        [_delegate didRechargeClick:self];
    }
}

@end
