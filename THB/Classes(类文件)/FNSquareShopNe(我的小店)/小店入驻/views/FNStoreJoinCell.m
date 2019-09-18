//
//  FNStoreJoinCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/19.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreJoinCell.h"

@interface FNStoreJoinCell()

@property (nonatomic, strong) UIView *vIndex;
@property (nonatomic, strong) UILabel *lblIndex;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;
@property (nonatomic, strong) UIImageView *imgRight;

@end

@implementation FNStoreJoinCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI {
    _vIndex = [[UIView alloc] init];
    _lblIndex = [[UILabel alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _imgRight = [[UIImageView alloc] init];
    
    [self.contentView addSubview:_vIndex];
    [_vIndex addSubview:_lblIndex];
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_lblDesc];
    [self.contentView addSubview:_imgRight];
    
    [_vIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@20);
        make.width.height.mas_equalTo(18);
    }];
    [_lblIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vIndex.mas_right).offset(8);
        make.centerY.equalTo(self.vIndex);
        make.right.lessThanOrEqualTo(self.imgRight.mas_left).offset(-10);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(self.vIndex.mas_bottom).offset(10);
        make.right.lessThanOrEqualTo(self.imgRight.mas_left).offset(-10);
        make.bottom.lessThanOrEqualTo(@-15);
    }];
    [_imgRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.width.mas_equalTo(@90);
        make.height.mas_equalTo(@90);
        make.centerY.equalTo(@0);
    }];
    
    _vIndex.cornerRadius = 9;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _lblIndex.textColor = UIColor.whiteColor;
    _lblIndex.font = kFONT14;
    
    _lblTitle.textColor = RGB(24, 24, 24);
    _lblTitle.font = kFONT14;
    
    
    _lblDesc.textColor = RGB(60, 60, 60);
    _lblDesc.font = kFONT12;
    _lblDesc.numberOfLines = 0;
    
    _imgRight.contentMode = UIViewContentModeScaleAspectFit;
    
    UIView *vLine = [[UIView alloc] init];
    [self.contentView addSubview:vLine];
    [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.left.equalTo(@10);
        make.bottom.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    vLine.backgroundColor = RGB(232, 232, 232);
}

- (void)setModel: (FNStoreJoinItemModel*) model withIndex: (NSString*)index{
    _vIndex.backgroundColor = [UIColor colorWithHexString: model.bj_color];
    _lblIndex.textColor = [UIColor colorWithHexString: model.font_color];
    _lblIndex.text = index;
    
    _lblTitle.text = model.title;
    _lblDesc.text = model.desc;
    [_imgRight sd_setImageWithURL:URL(model.img)];
}

@end
