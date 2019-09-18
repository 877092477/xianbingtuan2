//
//  FNNetCouponeRechargeHeaderView.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNetCouponeRechargeHeaderView.h"

@interface FNNetCouponeRechargeHeaderView()

@property (nonatomic, strong) UIView *vLine;

@end

@implementation FNNetCouponeRechargeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _lblCoupone = [[UILabel alloc] init];
    _imgIcon = [[UIImageView alloc] init];
    _vLine = [[UIView alloc] init];
    
    [self addSubview:_lblTitle];
    [self addSubview:_lblDesc];
    [self addSubview:_lblCoupone];
    [self addSubview:_imgIcon];
    [self addSubview:_vLine];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.equalTo(@26);
        make.right.lessThanOrEqualTo(self.imgIcon.mas_left).offset(-20);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(14);
        make.right.lessThanOrEqualTo(self.imgIcon.mas_left).offset(-20);
    }];
    [_lblCoupone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.bottom.equalTo(@-23);
        make.right.lessThanOrEqualTo(self.imgIcon.mas_left).offset(-20);
    }];
    [_imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@4);
        make.right.equalTo(@-12);
        make.height.mas_equalTo(132);
        make.width.mas_equalTo(181);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    
    
    _lblTitle.textColor = RGB(35, 33, 40);
    _lblTitle.font = [UIFont boldSystemFontOfSize:18];
    
    _lblDesc.textColor = RGB(35, 33, 40);
    _lblDesc.font = [UIFont boldSystemFontOfSize:18];
    
    _lblCoupone.textColor = RGB(150, 150, 150);
    _lblCoupone.font = kFONT15;
    
    _vLine.backgroundColor = RGB(229, 229, 229);
}

@end
