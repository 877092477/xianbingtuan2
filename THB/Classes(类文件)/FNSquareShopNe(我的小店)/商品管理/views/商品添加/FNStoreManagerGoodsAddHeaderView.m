//
//  FNStoreManagerGoodsAddHeaderView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/10.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreManagerGoodsAddHeaderView.h"

@interface FNStoreManagerGoodsAddHeaderView()


@property (nonatomic, strong) UIView *vContent;

@end


@implementation FNStoreManagerGoodsAddHeaderView

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
    _txfTitle = [[UITextField alloc] init];
    _lblUnit = [[UILabel alloc] init];
    
    [self addSubview:_vContent];
    [_vContent addSubview:_lblTitle];
    [_vContent addSubview:_txfTitle];
    [_vContent addSubview:_lblUnit];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.bottom.equalTo(@0);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@20);
        make.right.lessThanOrEqualTo(self.txfTitle.mas_left).offset(-20);
    }];
    [_txfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lblUnit.mas_left).offset(-12);
        make.centerY.equalTo(@0);
        make.height.mas_equalTo(30);
        make.left.equalTo(self.mas_centerX).offset(-40);
//        make.width.mas_equalTo(120);
    }];
    [_lblUnit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-12);
        make.centerY.equalTo(@0);
    }];
    
    _vContent.backgroundColor = UIColor.whiteColor;
    
    _lblTitle.textColor = RGB(24, 24, 24);
    _lblTitle.font = kFONT14;
    
    _txfTitle.textAlignment = NSTextAlignmentRight;
    _txfTitle.font = kFONT14;
}

@end
