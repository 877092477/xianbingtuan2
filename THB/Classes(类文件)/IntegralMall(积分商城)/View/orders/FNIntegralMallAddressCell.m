//
//  FNIntegralMallAddressCell.m
//  THB
//
//  Created by Weller Zhao on 2019/1/7.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNIntegralMallAddressCell.h"

@interface FNIntegralMallAddressCell()

@property (nonatomic, strong) UILabel *lblName;
@property (nonatomic, strong) UILabel *lblPhone;
@property (nonatomic, strong) UILabel *lblAddress;
@property (nonatomic, strong) UIImageView *imgAddress;
@property (nonatomic, strong) UIImageView *imgRight;
@property (nonatomic, strong) UIImageView *imgLine;

@end

@implementation FNIntegralMallAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.lblName = [[UILabel alloc] init];
    self.lblPhone = [[UILabel alloc] init];
    self.lblAddress = [[UILabel alloc] init];
    self.imgAddress = [[UIImageView alloc] init];
    self.imgRight = [[UIImageView alloc] init];
    self.imgLine = [[UIImageView alloc] init];
    
    [self.contentView addSubview: self.lblName];
    [self.contentView addSubview: self.lblPhone];
    [self.contentView addSubview: self.lblAddress];
    [self.contentView addSubview: self.imgAddress];
    [self.contentView addSubview: self.imgRight];
    [self.contentView addSubview: self.imgLine];
    
    [self.lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgAddress.mas_right).offset(10);
        make.top.equalTo(@15);
        make.right.lessThanOrEqualTo(self.lblPhone.mas_left).offset(-10);
    }];
    [self.lblPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-30);
        make.top.equalTo(@15);
    }];
    [self.lblAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgAddress.mas_right).offset(10);
        make.right.lessThanOrEqualTo(@-30);
        make.top.equalTo(_lblName.mas_bottom).offset(14);
    }];
    [self.imgAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(@0);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(18);
    }];
    [self.imgRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.centerY.equalTo(@0);
    }];
    [self.imgLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@-10);
        make.height.equalTo(@10);
        make.top.equalTo(self.lblAddress.mas_bottom).offset(15);
    }];
    
    self.contentView.backgroundColor = FNWhiteColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.imgAddress.image = IMAGE(@"integral_order_image_location");
    self.imgRight.image = IMAGE(@"integral_order_image_more");
    self.imgLine.image = IMAGE(@"integral_order_image_line");
    
    self.lblName.textColor = RGB(60, 60, 60);
    self.lblName.font = kFONT14;
    self.lblName.text = @"收货人：";
    
    self.lblPhone.textColor = RGB(60, 60, 60);
    self.lblPhone.font = kFONT14;
    
    self.lblAddress.textColor = RGB(60, 60, 60);
    self.lblAddress.font = kFONT13;
    self.lblAddress.text = @"收货地址：";
    self.lblAddress.numberOfLines = 0;
    
    self.imgLine.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setName: (NSString*)name withPhone: (NSString*)phone andAddress: (NSString*)address {
    _lblName.text = [NSString stringWithFormat:@"收货人：%@", name];
    _lblPhone.text = phone;
    _lblAddress.text = [NSString stringWithFormat:@"收货地址：%@", address];
}

@end
