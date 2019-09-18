//
//  FNNewStorePayAlertCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/30.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStorePayAlertCell.h"

@implementation FNNewStorePayAlertCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI {
    
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _imgRight = [[UIImageView alloc] init];
    _vLine = [[UIView alloc] init];
    
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_lblDesc];
    [self.contentView addSubview:_imgRight];
    [self.contentView addSubview:_vLine];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@18);
        make.centerY.equalTo(@0);
        make.right.lessThanOrEqualTo(self.lblDesc).offset(-20);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imgRight.mas_left).offset(-10);
        make.centerY.equalTo(@0);
    }];
    [_imgRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-13);
        make.centerY.equalTo(@0);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    
    _lblTitle.textColor = RGB(153, 153, 153);
    _lblTitle.font = kFONT13;
    
    _lblDesc.textColor = RGB(51, 51, 51);
    _lblDesc.font = kFONT13;
    
    _imgRight.image = IMAGE(@"FJ_minRight_img");
    
    _vLine.backgroundColor = RGB(240, 240, 240);
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
