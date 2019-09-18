//
//  FNStoreManagerGoodsAddAdImageView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/30.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreManagerGoodsAddAdImageView.h"


@interface FNStoreManagerGoodsAddAdImageView()


@property (nonatomic, strong) UIView *vContent;

@end

@implementation FNStoreManagerGoodsAddAdImageView

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
    _btnImage = [[UIButton alloc] init];
    
    [self addSubview:_vContent];
    [_vContent addSubview:_lblTitle];
    [_vContent addSubview:_btnImage];
    
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
    [_btnImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(12);
        make.height.width.mas_equalTo(83);
        make.bottom.equalTo(@-20);
    }];
    
    _vContent.backgroundColor = UIColor.whiteColor;
    
    _lblTitle.textColor = RGB(24, 24, 24);
    _lblTitle.font = kFONT14;
    
    [_btnImage setBackgroundImage: IMAGE(@"FN_xdSJ_adimg") forState: UIControlStateNormal];
}


@end
