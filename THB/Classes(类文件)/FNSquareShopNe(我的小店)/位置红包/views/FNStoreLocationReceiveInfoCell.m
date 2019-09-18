//
//  FNStoreLocationReceiveInfoCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/29.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreLocationReceiveInfoCell.h"

@interface FNStoreLocationReceiveInfoCell()


@property (nonatomic, strong) UIView *vLine;

@end

@implementation FNStoreLocationReceiveInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _imgHeader = [[UIImageView alloc] init];
    _lblName = [[UILabel alloc] init];
    _lblTime = [[UILabel alloc] init];
    _lblPrice = [[UILabel alloc] init];
    _vLine = [[UIView alloc] init];
    
    [self.contentView addSubview:_imgHeader];
    [self.contentView addSubview:_lblName];
    [self.contentView addSubview:_lblTime];
    [self.contentView addSubview:_lblPrice];
    [self.contentView addSubview:_vLine];
    
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.width.height.mas_equalTo(34);
        make.left.equalTo(@20);
    }];
    [_lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(10);
        make.top.equalTo(self.imgHeader);
        make.right.lessThanOrEqualTo(self.lblPrice.mas_left).offset(-10);
        make.height.mas_equalTo(14);
    }];
    [_lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(10);
        make.top.equalTo(self.lblName.mas_bottom).offset(8);
        make.right.lessThanOrEqualTo(self.lblPrice.mas_left).offset(-10);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.centerY.equalTo(@0);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.right.equalTo(@-10);
        make.bottom.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    
    _imgHeader.cornerRadius = 17;
    
    _lblName.textColor = RGB(51, 51, 51);
    _lblName.font = kFONT13;
    
    _lblTime.textColor = RGB(153, 153, 153);
    _lblTime.font = kFONT10;
    
    _lblPrice.textColor = RGB(51, 51, 51);
    _lblPrice.font = kFONT13;
    
    _vLine.backgroundColor = RGB(240, 240, 240);
}

@end
