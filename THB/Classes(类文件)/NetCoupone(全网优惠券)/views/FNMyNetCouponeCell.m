//
//  FNMyNetCouponeCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/10.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNMyNetCouponeCell.h"

@interface FNMyNetCouponeCell()



@end

@implementation FNMyNetCouponeCell

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
    
    _imgBg = [[UIImageView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblPrice = [[UILabel alloc] init];
    _lblTime = [[UILabel alloc] init];
    _btnExchange = [[UIImageView alloc] init];
    _btnView = [[UILabel alloc] init];
    
    [self.contentView addSubview:_imgBg];
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_lblPrice];
    [self.contentView addSubview:_lblTime];
    [self.contentView addSubview:_btnExchange];
    [self.contentView addSubview:_btnView];
    
    [_imgBg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(@0);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.bottom.equalTo(@0);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@55);
        make.top.equalTo(@7);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(self.imgBg).offset(55);
        make.right.lessThanOrEqualTo(self.btnExchange.mas_left).offset(-20);
    }];
    [_lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgBg).offset(55);
        make.bottom.equalTo(self.imgBg).offset(-8);
//        make.right.equalTo(self.btnView.mas_left).offset(-20);
    }];
    [_btnExchange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(self.imgBg).offset(-20);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(83);
    }];
    [_btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imgBg).offset(-4);
        make.bottom.equalTo(self.imgBg).offset(-8);
        make.height.mas_equalTo(10);
    }];
    
    _lblTitle.font = kFONT12;
    _lblPrice.font = [UIFont boldSystemFontOfSize:36];
    
    _lblTime.font = kFONT10;
    _lblTime.textColor = RGB(204, 208, 211);
    
    _btnView.font = kFONT10;
    _btnView.textColor = RGB(194, 193, 194);
}

@end
