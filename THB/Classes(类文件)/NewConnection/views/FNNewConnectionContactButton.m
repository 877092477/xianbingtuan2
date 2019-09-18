//
//  FNNewConnectionContactButton.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/17.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewConnectionContactButton.h"

@interface FNNewConnectionContactButton()

@property (nonatomic, strong) UIButton *btnBackground;
@property (nonatomic, strong) UIView *vBackground;
@property (nonatomic, strong) UIView *vCount;
@property (nonatomic, strong) UILabel *lblCount;

@end

@implementation FNNewConnectionContactButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _btnBackground = [[UIButton alloc] init];
    _vBackground = [[UIView alloc] init];
    _imgIcon = [[UIImageView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _vCount = [[UIView alloc] init];
    _lblCount = [[UILabel alloc] init];
    
    [self addSubview:_vBackground];
    [_vBackground addSubview:_imgIcon];
    [_vBackground addSubview:_lblTitle];
    [self addSubview:_btnBackground];
    [self addSubview:_vCount];
    [_vCount addSubview:_lblCount];
    
    [_btnBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.left.top.greaterThanOrEqualTo(@0);
        make.right.bottom.lessThanOrEqualTo(@0);
    }];
    
    [_imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@0);
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(@0);
        make.width.height.mas_equalTo(48);
    }];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.left.greaterThanOrEqualTo(self);
        make.right.lessThanOrEqualTo(self);
        make.top.equalTo(_imgIcon.mas_bottom).offset(8);
        make.bottom.equalTo(@0);
        make.height.mas_equalTo(20);
    }];
    [_vCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imgIcon.mas_right);
        make.top.equalTo(self.imgIcon);
        make.height.mas_equalTo(20);
    }];
    [_lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.left.greaterThanOrEqualTo(@7);
        make.right.lessThanOrEqualTo(@-7);
    }];
    [_btnBackground addTarget:self action:@selector(didIconClick:)];
    
    _imgIcon.contentMode = UIViewContentModeScaleAspectFit;
    _imgIcon.cornerRadius = 24;
    
    _vCount.backgroundColor = RGB(249, 82, 80);
    _vCount.cornerRadius = 10;
    
    _lblCount.textColor = UIColor.whiteColor;
    _lblCount.font = kFONT12;
}

- (void)didIconClick: (id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didIconClick:)]) {
        [_delegate didIconClick:self];
    }
}

- (void)setCount: (NSString*)count {
    _vCount.hidden = !([count kr_isNotEmpty] && ![count isEqualToString:@"0"]);
    _lblCount.text = count;
}

@end
