//
//  FNStoreManagerGoodsEmptyView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/9.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreManagerGoodsEmptyView.h"

@interface FNStoreManagerGoodsEmptyView()

@property (nonatomic, strong) UIImageView *imgEmpty;

@end

@implementation FNStoreManagerGoodsEmptyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _imgEmpty = [[UIImageView alloc] init];
    _lblEmpty = [[UILabel alloc] init];
    _btnAdd = [[UIButton alloc] init];
    
    [self addSubview:_imgEmpty];
    [self addSubview:_lblEmpty];
    [self addSubview:_btnAdd];
    
    [_imgEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@-80);
    }];
    [_lblEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.imgEmpty.mas_bottom).offset(12);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.width.mas_equalTo(118);
        make.height.mas_equalTo(38);
        make.top.equalTo(self.lblEmpty.mas_bottom).offset(16);
    }];
    self.backgroundColor = UIColor.whiteColor;
    _imgEmpty.image = IMAGE(@"store_manager_empty");
    
    _lblEmpty.text = @"还没有商品哦，马上添加";
    _lblEmpty.textColor = RGB(153, 153, 153);
    _lblEmpty.font = kFONT12;
    
    _btnAdd.backgroundColor = RGB(255, 102, 102);
    _btnAdd.cornerRadius = 19;
    _btnAdd.titleLabel.font = kFONT14;
    [_btnAdd setTitle: @"添加商品" forState: UIControlStateNormal];
    [_btnAdd setTitleColor: UIColor.whiteColor forState: UIControlStateNormal];
    [_btnAdd setImage: IMAGE(@"store_manager_button_add") forState: UIControlStateNormal];
    [_btnAdd layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:8];
    [_btnAdd addTarget:self action:@selector(onAddClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onAddClick {
    if ([_delegate respondsToSelector:@selector(didAddClick:)]) {
        [_delegate didAddClick:self];
    }
}

@end
