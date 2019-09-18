//
//  FNNetCouponeRechargePayCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNetCouponeRechargePayCell.h"

@interface FNNetCouponeRechargePayCell()

@property (nonatomic, strong) UIImageView *imgCheck;

@end

@implementation FNNetCouponeRechargePayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _imgIcon = [[UIImageView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _imgCheck = [[UIImageView alloc] init];
    
    [self.contentView addSubview:_imgIcon];
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_imgCheck];
    
    [_imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.centerY.equalTo(@0);
        make.width.height.mas_equalTo(25);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgIcon.mas_right).offset(20);
        make.centerY.equalTo(@0);
        make.right.lessThanOrEqualTo(self.imgCheck.mas_left).offset(-20);
    }];
    [_imgCheck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-25);
        make.centerY.equalTo(@0);
    }];
    
    _lblTitle.textColor = RGB(48, 52, 59);
    _lblTitle.font = [UIFont boldSystemFontOfSize:15];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setIsSelected:(BOOL)selected {
    
    _imgCheck.image = IMAGE(selected ? @"net_coupone_image_check_selected" : @"net_coupone_image_check_normal");
}

@end
