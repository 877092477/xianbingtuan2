//
//  ShopRebatesCell.m
//  THB
//
//  Created by Weller Zhao on 2018/12/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "ShopRebatesCell.h"

@interface ShopRebatesCell()


@end

@implementation ShopRebatesCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        _isCircle = YES;
    }
    return self;
}

- (void)configUI {
    self.imgHeader = [[UIImageView alloc] init];
    self.lblTitle = [[UILabel alloc] init];
    self.lblDesc = [[UILabel alloc] init];
    
    [self.contentView addSubview: self.imgHeader];
    [self.contentView addSubview: self.lblTitle];
    [self.contentView addSubview: self.lblDesc];
    
    [self.imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.width.equalTo(self).dividedBy(2);
        make.height.equalTo(self.imgHeader.mas_width);
        make.top.equalTo(@16);
    }];
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.left.greaterThanOrEqualTo(@8);
        make.right.lessThanOrEqualTo(@-8);
        make.top.equalTo(self.imgHeader.mas_bottom).offset(12);
        make.height.mas_equalTo(12);
    }];
    [self.lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.left.greaterThanOrEqualTo(@8);
        make.right.lessThanOrEqualTo(@-8);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(4);
//        make.bottom.equalTo(@-12);
        make.height.mas_equalTo(10);
    }];
    
    self.backgroundColor = FNWhiteColor;
    
    self.imgHeader.contentMode = UIViewContentModeScaleAspectFill;
    
    self.lblTitle.font = kFONT12;
    self.lblTitle.textColor = RGB(24, 24, 24);
    
    self.lblDesc.font = kFONT10;
    self.lblDesc.textColor = RGB(161, 161, 161);
    
    self.imgHeader.borderColor = FNHomeBackgroundColor;
    self.imgHeader.borderWidth = 1;
    self.imgHeader.contentMode = UIViewContentModeScaleToFill;
//    self.imgHeader.cornerRadius = self.imgHeader.bounds.size.width / 2;
    [self layoutSubviews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_isCircle){
        self.imgHeader.borderWidth = 1;
        self.imgHeader.cornerRadius = self.imgHeader.bounds.size.width / 2;
    }else {
        self.imgHeader.borderWidth = 0;
        self.imgHeader.cornerRadius = 0;
        self.imgHeader.layer.masksToBounds = NO;
    }
}

@end
