//
//  FNStoreManagerGoodsAddAdLinkView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/30.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreManagerGoodsAddAdLinkView.h"

@interface FNStoreManagerGoodsAddAdLinkView()


@property (nonatomic, strong) UIView *vContent;

@end

@implementation FNStoreManagerGoodsAddAdLinkView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _vContent = [[UIView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _textfield = [[UITextField alloc] init];
    
    [self addSubview:_vContent];
    [_vContent addSubview:_lblTitle];
    [_vContent addSubview:_textfield];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.bottom.equalTo(@0);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@20);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(12);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(@-20);
    }];
    
    _vContent.backgroundColor = UIColor.whiteColor;
    
    _lblTitle.textColor = RGB(24, 24, 24);
    _lblTitle.font = kFONT14;
    
    _textfield.font = kFONT14;
}


@end
