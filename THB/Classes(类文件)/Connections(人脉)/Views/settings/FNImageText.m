//
//  FNImageText.m
//  THB
//
//  Created by Weller Zhao on 2019/3/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNImageText.h"

@interface FNImageText()

@property (nonatomic, strong) UIButton *btnBackground;
@property (nonatomic, strong) UIView *vBackground;

@end

@implementation FNImageText


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
    
    [self addSubview:_vBackground];
    [_vBackground addSubview:_imgIcon];
    [_vBackground addSubview:_lblTitle];
    [self addSubview:_btnBackground];
    
    [_btnBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.left.top.equalTo(@0);
        make.right.bottom.equalTo(@0);
    }];
    
    [_imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@0);
        make.left.greaterThanOrEqualTo(self);
        make.right.lessThanOrEqualTo(self);
        make.width.equalTo(_imgIcon.mas_height);
        
    }];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.left.greaterThanOrEqualTo(self);
        make.right.lessThanOrEqualTo(self);
        make.top.equalTo(_imgIcon.mas_bottom).offset(8);
        make.bottom.equalTo(@0);
    }];
    [_btnBackground addTarget:self action:@selector(didIconClick:)];
    
    _imgIcon.contentMode = UIViewContentModeScaleAspectFill;
    _imgIcon.cornerRadius = 4;
    
    _lblTitle.font = kFONT12;
    
}

- (void)didIconClick: (id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didIconClick:)]) {
        [_delegate didIconClick:self];
    }
}


@end
