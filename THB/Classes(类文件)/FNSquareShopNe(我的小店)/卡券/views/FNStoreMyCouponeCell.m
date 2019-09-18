//
//  FNStoreMyCouponeCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/2.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreMyCouponeCell.h"

@interface FNStoreMyCouponeCell()

@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UIView *vLeft;
@property (nonatomic, strong) UIView *vCenter;
@property (nonatomic, strong) UIView *vRight;
@property (nonatomic, strong) UILabel *lblRight;

@end

@implementation FNStoreMyCouponeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI {
    _vContent = [[UIView alloc] init];
    _vLeft = [[UIView alloc] init];
    _lblPrice = [[UILabel alloc] init];
    _lblCondition = [[UILabel alloc] init];
    _vCenter = [[UIView alloc] init];
    _vRight = [[UIView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblTime = [[UILabel alloc] init];
    _lblRight = [[UILabel alloc] init];
    
    [self.contentView addSubview:_vContent];
    [_vContent addSubview:_vLeft];
    [_vLeft addSubview:_lblPrice];
    [_vLeft addSubview:_lblCondition];
    [_vContent addSubview:_vCenter];
    [_vContent addSubview:_vRight];
    [_vCenter addSubview:_lblTitle];
    [_vCenter addSubview:_lblTime];
    [_vRight addSubview:_lblRight];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.equalTo(@5);
        make.bottom.equalTo(@-5);
    }];
    [_vLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(@0);
//        make.width.mas_equalTo(95);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@10);
        make.right.lessThanOrEqualTo(@-10);
        make.centerX.equalTo(@0);
        make.top.equalTo(@0);
    }];
    [_lblCondition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@10);
        make.right.lessThanOrEqualTo(@-10);
        make.centerX.equalTo(@0);
        make.top.equalTo(self.lblPrice.mas_bottom).offset(4);
        make.bottom.equalTo(@0);
    }];
    [_vCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vLeft.mas_right);
        make.right.equalTo(self.vRight.mas_left).offset(-20);
        make.centerY.equalTo(@0);
    }];
    [_vRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-15);
        make.centerY.equalTo(@0);
        make.width.mas_equalTo(54);
        make.height.mas_equalTo(24);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.lessThanOrEqualTo(@0);
        make.top.equalTo(@0);
    }];
    [_lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.lessThanOrEqualTo(@0);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(4);
        make.bottom.equalTo(@0);
    }];
    [_lblRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _lblPrice.textColor = RGB(255, 41, 41);
    _lblPrice.font = [UIFont systemFontOfSize:24];
    
    _lblCondition.textColor = RGB(140, 140, 140);
    _lblCondition.font = kFONT11;
    
    _lblTitle.textColor = RGB(25, 25, 25);
    _lblTitle.font = [UIFont boldSystemFontOfSize:12];
    
    _lblTime.textColor = RGB(140, 140, 140);
    _lblTime.font = kFONT11;
    
    _lblRight.font = [UIFont boldSystemFontOfSize:13];
    _lblRight.textColor = UIColor.whiteColor;
    _lblRight.text = @"使用";
    
    _vRight.backgroundColor = RGB(255, 58, 58);
    _vRight.cornerRadius = 12;
}

@end
