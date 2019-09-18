//
//  FNMyVideoCardTableViewCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/30.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNMyVideoCardTableViewCell.h"

@interface FNMyVideoCardTableViewCell()

@property (nonatomic, strong) UIImageView *imgLeft;
@property (nonatomic, strong) UIImageView *imgRight;
@property (nonatomic, strong) UIView *vLine;

@end

@implementation FNMyVideoCardTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _imgLeft = [[UIImageView alloc] init];
    _imgRight = [[UIImageView alloc] init];
    _lblType = [[UILabel alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _vLine = [[UIView alloc] init];
    _lblTime = [[UILabel alloc] init];
    _imgCode = [[UIImageView alloc] init];
    
    [self.contentView addSubview:_imgLeft];
    [self.contentView addSubview:_imgRight];
    [self.contentView addSubview:_lblType];
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_vLine];
    [self.contentView addSubview:_lblTime];
    [self.contentView addSubview:_imgCode];
    
    [_imgLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@15);
        make.bottom.equalTo(@0);
        make.width.equalTo(self.imgLeft.mas_height);
    }];
    [_imgRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgLeft.mas_right);
        make.right.equalTo(@-15);
        make.top.bottom.equalTo(self.imgLeft);
    }];
    [_lblType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgRight).offset(25);
        make.top.equalTo(self.imgRight).offset(15);
        make.right.lessThanOrEqualTo(self.imgCode.mas_left).offset(-10);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgRight).offset(25);
        make.top.equalTo(self.lblType).offset(4);
        make.right.lessThanOrEqualTo(self.imgCode.mas_left).offset(-10);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgRight).offset(25);
        make.right.equalTo(self.imgRight).offset(-34);
        make.bottom.equalTo(self.imgRight).offset(-30);
        make.height.mas_equalTo(1);
    }];
    [_lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgRight).offset(25);
        make.right.lessThanOrEqualTo(self.imgRight).offset(-25);
        make.centerY.equalTo(self.imgRight.mas_bottom).offset(-15);
    }];
    [_imgCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgRight).offset(20);
        make.right.equalTo(self.imgRight).offset(-20);
        make.width.height.mas_equalTo(@28);
    }];
    
    self.backgroundColor = UIColor.clearColor;
    
    _lblType.textColor = RGB(153, 153, 153);
    _lblType.font = kFONT14;
    
    _lblTitle.textColor = RGB(153, 153, 153);
    _lblTitle.font = kFONT14;
    
    _vLine.backgroundColor = RGB(228, 228, 228);
    
    _lblTime.textColor = RGB(153, 153, 153);
    _lblTime.font = kFONT12;
}

- (void)setLeftImage: (NSString*)leftImage withRightImage: (NSString*)rightImage {
    @weakify(self)
    [_imgLeft sd_setImageWithURL:URL(leftImage) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (image && error == nil) {
            [self.imgLeft mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(self.imgLeft.mas_height).multipliedBy(image.size.width / image.size.height);
            }];
        }
    }];
    
    [_imgRight sd_setImageWithURL:URL(rightImage)];
}

@end
