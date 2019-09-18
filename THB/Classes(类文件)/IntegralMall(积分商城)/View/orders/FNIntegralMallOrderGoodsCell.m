//
//  FNIntegralMallOrderGoodsCell.m
//  THB
//
//  Created by Weller Zhao on 2019/1/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNIntegralMallOrderGoodsCell.h"

@interface FNIntegralMallOrderGoodsCell()



@end

@implementation FNIntegralMallOrderGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.imgGoods = [[UIImageView alloc] init];
    self.lblTitle = [[UILabel alloc] init];
    self.lblDesc = [[UILabel alloc] init];
    self.lblPrice = [[UILabel alloc] init];
    self.lblCount = [[UILabel alloc] init];
    
    [self.contentView addSubview:self.imgGoods];
    [self.contentView addSubview:self.lblTitle];
    [self.contentView addSubview:self.lblDesc];
    [self.contentView addSubview:self.lblPrice];
    [self.contentView addSubview:self.lblCount];
    
    [self.imgGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@10);
        make.width.height.mas_equalTo(100);
        make.bottom.equalTo(@-10);
    }];
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(self.imgGoods.mas_right).offset(20);
        make.right.lessThanOrEqualTo(@-15);
    }];
    [self.lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblTitle.mas_bottom).offset(10);
        make.left.equalTo(self.imgGoods.mas_right).offset(20);
        make.right.lessThanOrEqualTo(@-15);
    }];
    [self.lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@-10);
        make.left.equalTo(self.imgGoods.mas_right).offset(20);
        make.right.lessThanOrEqualTo(self.lblCount.mas_left).offset(-10);
    }];
    [self.lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-15);
        make.bottom.equalTo(@-10);
    }];
    
    self.backgroundColor = RGB(240, 240, 240);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.lblTitle.textColor = UIColor.blackColor;
    self.lblTitle.font = kFONT14;
    self.lblTitle.numberOfLines = 2;
    
    self.lblDesc.textColor = RGB(140, 140, 140);
    self.lblDesc.font = kFONT12;
    
    self.lblPrice.textColor = RGB(255, 131, 20);
    self.lblPrice.font = [UIFont systemFontOfSize:18];
    
    self.lblCount.textColor = RGB(24, 24, 24);
    self.lblCount.font = kFONT14;
}

@end
