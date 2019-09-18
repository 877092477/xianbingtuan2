//
//  FNLiveCouponeCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveCouponeCell.h"

@interface FNLiveCouponeCell()

@property (nonatomic, strong) UIView *vLine;

@end

@implementation FNLiveCouponeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

-(void) configUI {
    _vLine = [[UIView alloc] init];
    _imgHeader = [[UIImageView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _lblCount = [[UILabel alloc] init];
    _btnAccept = [[UIImageView alloc] init];
    
    [self.contentView addSubview:_vLine];
    [self.contentView addSubview:_imgHeader];
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_lblDesc];
    [self.contentView addSubview:_lblCount];
    [self.contentView addSubview:_btnAccept];
    
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.top.equalTo(@11);
        make.width.height.mas_equalTo(40);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(8);
        make.top.equalTo(self.imgHeader).offset(4);
        make.right.lessThanOrEqualTo(self.btnAccept.mas_left).offset(-10);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(8);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(6);
        make.right.lessThanOrEqualTo(self.btnAccept.mas_left).offset(-10);
    }];
    [_lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(8);
        make.top.equalTo(self.lblDesc.mas_bottom).offset(10);
        make.right.lessThanOrEqualTo(self.btnAccept.mas_left).offset(-10);
    }];
    [_btnAccept mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-18);
        make.width.mas_equalTo(61);
        make.height.mas_equalTo(25);
        make.centerY.equalTo(@0);
    }];
    
    self.backgroundColor = UIColor.whiteColor;
    
    _vLine.backgroundColor = RGB(240, 240, 240);
    
    _imgHeader.cornerRadius = 20;
    _imgHeader.contentMode = UIViewContentModeScaleAspectFill;
    
    _lblTitle.font = kFONT15;
    _lblTitle.textColor = RGB(51, 51, 51);
    
    _lblDesc.font = kFONT15;
    _lblDesc.textColor = RGB(254, 89, 74);
    
    _lblCount.font = kFONT12;
    _lblCount.textColor = RGB(204, 204, 204);
    
}

@end
