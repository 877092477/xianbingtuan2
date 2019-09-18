//
//  FNStoreJoinFormItemView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/19.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreJoinFormItemView.h"

@interface FNStoreJoinFormItemView()


@property (nonatomic, strong) UIView *vLine;

@end

@implementation FNStoreJoinFormItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _lblTitle = [[UILabel alloc] init];
    _textField = [[UITextField alloc] init];
    _vLine = [[UIView alloc] init];
    
    [self addSubview:_lblTitle];
    [self addSubview:_textField];
    [self addSubview:_vLine];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@0);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@-16);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(@0);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@-16);
        make.bottom.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    
    _lblTitle.textColor = RGB(24, 24, 24);
    _lblTitle.font = kFONT12;
    
    _textField.font = kFONT14;
    
    _imgIcon = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 30, 30)];
    _imgIcon.contentMode = UIViewContentModeCenter;
    
    _textField.leftView = _imgIcon;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    
    _vLine.backgroundColor = RGB(232, 232, 232);
}

@end
