//
//  FNStoreManagerGoodsAddImageView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreManagerGoodsAddImageView.h"
#import "FNImageCollectionViewCell.h"

@interface FNStoreManagerGoodsAddImageView()

@property (nonatomic, strong) UIView *vContent;

@end

@implementation FNStoreManagerGoodsAddImageView

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
    _btnClose = [[UIButton alloc] init];
    
    [self addSubview:_vContent];
    [_vContent addSubview:_lblTitle];
    [_vContent addSubview:_btnImage];
    [_vContent addSubview:_btnClose];

    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.bottom.equalTo(@0);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@20);
        make.right.lessThanOrEqualTo(self.btnImage.mas_left).offset(-20);
    }];
    [_btnImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-12);
        make.centerY.equalTo(@0);
        make.height.width.mas_equalTo(48);
    }];

    [_btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btnImage.mas_right);
        make.top.equalTo(self.btnImage.mas_top);
        make.width.height.mas_equalTo(14);
    }];
    
    _vContent.backgroundColor = UIColor.whiteColor;
    
    _lblTitle.textColor = RGB(24, 24, 24);
    _lblTitle.font = kFONT14;
    
    
    [_btnClose setBackgroundImage:IMAGE(@"store_goods_button_add_image_close") forState: UIControlStateNormal];
    _btnClose.hidden = YES;
    
    [_btnImage addTarget:self action:@selector(onAddClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnClose addTarget:self action:@selector(onCloseClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void) onAddClick {
    if ([_delegate respondsToSelector:@selector(didAddImageClick:)]) {
        [_delegate didAddImageClick:self];
    }
}

- (void) onCloseClick {
    if ([_delegate respondsToSelector:@selector(didCloseImageClick:)]) {
        [_delegate didCloseImageClick:self];
    }
}

@end
