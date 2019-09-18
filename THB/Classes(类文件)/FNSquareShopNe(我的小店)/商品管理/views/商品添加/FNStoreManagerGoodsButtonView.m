//
//  FNStoreManagerGoodsButtonView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreManagerGoodsButtonView.h"

@interface FNStoreManagerGoodsButtonView()

@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UIImageView *imgRight;
@property (nonatomic, strong) UIButton *btnTitle;

@end

@implementation FNStoreManagerGoodsButtonView

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
    _btnTitle = [[UIButton alloc] init];
    _imgRight = [[UIImageView alloc] init];
    _lblDesc = [[UILabel alloc] init];
    
    [self addSubview:_vContent];
    [_vContent addSubview:_lblTitle];
    [_vContent addSubview:_btnTitle];
    [_vContent addSubview:_imgRight];
    [_vContent addSubview:_lblDesc];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.bottom.equalTo(@0);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@20);
        make.right.lessThanOrEqualTo(self.btnTitle.mas_left).offset(-20);
    }];
    [_btnTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.centerY.equalTo(@0);
        make.height.mas_equalTo(48);
    }];
    [_imgRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-12);
        make.centerY.equalTo(@0);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imgRight.mas_left).offset(-16);
        make.left.equalTo(self.btnTitle.mas_left).offset(16);
        make.centerY.equalTo(@0);
    }];
    
    _vContent.backgroundColor = UIColor.whiteColor;
    
    _lblTitle.textColor = RGB(24, 24, 24);
    _lblTitle.font = kFONT14;
    
    _imgRight.image = IMAGE(@"shop_right");
    _imgRight.userInteractionEnabled = NO;
    
    _lblDesc.font = kFONT14;
    
    [_btnTitle addTarget:self action:@selector(onTitleClick) forControlEvents:UIControlEventTouchUpInside];
//    [_btnTitle setImage: IMAGE(@"shop_right") forState: UIControlStateNormal];
    _btnTitle.titleLabel.font = kFONT14;
}

- (void)onTitleClick {
    if ([_delegate respondsToSelector:@selector(onButtonViewTitleClick:)]) {
        [_delegate onButtonViewTitleClick:self];
    }
}

@end
