//
//  FNMineIcon.m
//  THB
//
//  Created by Weller Zhao on 2018/12/25.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNMineIcon.h"

@interface FNMineIcon()

@property (nonatomic, strong) UIButton *btnBackground;
@property (nonatomic, strong) UIView *vBackground;

@end

@implementation FNMineIcon

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
        make.left.top.greaterThanOrEqualTo(@0);
        make.right.bottom.lessThanOrEqualTo(@0);
    }];
    
    [_imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@0);
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(@0);
        make.width.height.mas_equalTo(28);
    }];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.left.greaterThanOrEqualTo(self);
        make.right.lessThanOrEqualTo(self);
        make.top.equalTo(_imgIcon.mas_bottom).offset(8);
        make.bottom.equalTo(@0);
    }];
    [_btnBackground addTarget:self action:@selector(didIconClick:)];
    
    _imgIcon.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)didIconClick: (id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didIconClick:)]) {
        [_delegate didIconClick:self];
    }
}

@end
