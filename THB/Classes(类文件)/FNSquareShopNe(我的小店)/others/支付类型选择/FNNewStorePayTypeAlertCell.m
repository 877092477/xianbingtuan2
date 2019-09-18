//
//  FNNewStorePayTypeAlertCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/1.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStorePayTypeAlertCell.h"

@interface FNNewStorePayTypeAlertCell()

@property (nonatomic, strong) UIView *vText;
@property (nonatomic, strong) UIView *vLine;

@end

@implementation FNNewStorePayTypeAlertCell

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
    _vText = [[UIView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _imgState = [[UIImageView alloc] init];
    _vLine = [[UIView alloc] init];
    
    [self.contentView addSubview:_imgIcon];
    [self.contentView addSubview:_vText];
    [_vText addSubview:_lblTitle];
    [_vText addSubview:_lblDesc];
    [self.contentView addSubview:_imgState];
    [self.contentView addSubview:_vLine];
    
    [_imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerY.equalTo(@0);
        make.width.height.mas_equalTo(28);
    }];
    [_vText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgIcon.mas_right).equalTo(@16);
        make.centerY.equalTo(@0);
        make.right.lessThanOrEqualTo(self.imgState.mas_left).offset(-20);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@4);
        make.right.lessThanOrEqualTo(@0);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(4);
        make.right.lessThanOrEqualTo(@0);
        make.bottom.equalTo(@0);
    }];
    [_imgState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-15);
        make.centerY.equalTo(@0);
        make.width.height.mas_equalTo(18);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.equalTo(@58);
        make.right.equalTo(@-15);
        make.height.mas_equalTo(1);
    }];
    
    _lblTitle.textColor = RGB(24, 24, 24);
    _lblTitle.font = kFONT16;
    
    _lblDesc.textColor = RGB(140, 140, 140);
    _lblDesc.font = kFONT12;

    _vLine.backgroundColor = RGB(232, 232, 232);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setSelected: NO animated: NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    _imgState.image = IMAGE(selected ? @"store_pay_type_image_selected" : @"store_pay_type_image_normal");
}

@end
