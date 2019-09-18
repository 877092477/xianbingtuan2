//
//  FNNewConnectionGroupCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/13.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewConnectionGroupCell.h"

@interface FNNewConnectionGroupCell()

@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) UIView *vCount;
@property (nonatomic, strong) UILabel *lblCount;

@end

@implementation FNNewConnectionGroupCell

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
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _lblTime = [[UILabel alloc] init];
    _vLine = [[UIView alloc] init];
    _vCount = [[UIView alloc] init];
    _lblCount = [[UILabel alloc] init];
    
    [self.contentView addSubview:_imgHeader];
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_lblDesc];
    [self.contentView addSubview:_lblTime];
    [self.contentView addSubview:_vLine];
    [self.contentView addSubview:_vCount];
    [_vCount addSubview:_lblCount];
    
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.width.height.mas_equalTo(46);
        make.left.equalTo(@13);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(9);
        make.top.equalTo(self.imgHeader);
        make.right.lessThanOrEqualTo(self.lblTime.mas_left).offset(-10);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imgHeader);
        make.left.equalTo(self.imgHeader.mas_right).offset(9);
        make.right.lessThanOrEqualTo(self.lblTime.mas_left).offset(-10);
    }];
    [_lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-17);
        make.top.equalTo(self.lblTitle);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@25);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    [_vCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.imgHeader);
        make.height.mas_equalTo(20);
        make.width.mas_greaterThanOrEqualTo(20);
    }];
    [_lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.left.greaterThanOrEqualTo(@4);
        make.right.lessThanOrEqualTo(@-4);
    }];
    
    _imgHeader.cornerRadius = 23;
    
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = [UIFont systemFontOfSize:16];
    
    _lblDesc.textColor = RGB(153, 153, 153);
    _lblDesc.font = kFONT14;
    
    _lblTime.textColor = RGB(153, 153, 153);
    _lblTime.font = kFONT11;
    
    _vLine.backgroundColor = RGB(240, 240, 240);
    
    _vCount.backgroundColor = RGB(250, 82, 80);
    _vCount.cornerRadius = 10;
    _vCount.hidden = YES;
    
    _lblCount.textColor = UIColor.whiteColor;
    _lblCount.font = kFONT12;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setCount: (NSString*)count {
    _vCount.hidden = ![count kr_isNotEmpty] || [count isEqualToString: @"0"];
    _lblCount.text = count;
}

@end
