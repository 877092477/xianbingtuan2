//
//  FNStoreBottomView.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/20.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreBottomView.h"

@interface FNStoreBottomView()

@property (nonatomic, strong) UIView *vBackground;
@property (nonatomic, strong) UIButton *btnPay;

@property (nonatomic, strong) UIView *vCar;
@property (nonatomic, strong) UIButton *btnCar;
@property (nonatomic, strong) UIImageView *vCount;
@property (nonatomic, strong) UILabel *lblCount;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;


@end

@implementation FNStoreBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _vBackground = [[UIView alloc] init];
    _btnPay = [[UIButton alloc] init];
    _vCar = [[UIView alloc] init];
    _btnCar = [[UIButton alloc] init];
    _vCount = [[UIImageView alloc] init];
    _lblCount = [[UILabel alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    
    [self addSubview: _vBackground];
    [_vBackground addSubview: _btnPay];
    [_vBackground addSubview: _vCar];
    [_vBackground addSubview: _btnCar];
    [_vBackground addSubview: _vCount];
    [_vCount addSubview: _lblCount];
    [_vBackground addSubview: _lblTitle];
    [_vBackground addSubview: _lblDesc];
    
    [_vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(@0);
        make.height.mas_equalTo(48);
    }];
    [_btnPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(@0);
        make.width.mas_equalTo(105);
    }];
    [_vCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@-10);
        make.width.height.mas_equalTo(50);
    }];
    [_btnCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.vCar);
        make.width.height.mas_equalTo(40);
    }];
    [_vCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.vCar);
        make.top.equalTo(self.vCar);
        make.height.mas_equalTo(14);
        make.width.mas_greaterThanOrEqualTo(14);
    }];
    [_lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.left.greaterThanOrEqualTo(@4);
        make.right.lessThanOrEqualTo(@-4);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vCar.mas_right).offset(20);
        make.top.equalTo(@10);
        make.right.lessThanOrEqualTo(self.btnPay.mas_left).offset(-20);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vCar.mas_right).offset(20);
        make.bottom.equalTo(@-10);
        make.right.lessThanOrEqualTo(self.btnPay.mas_left).offset(-20);
    }];
    
    _vBackground.backgroundColor = RGB(68, 68, 68);
    
    _vCar.backgroundColor = RGB(68, 68, 68);
    _vCar.cornerRadius = 25;
    
    _lblTitle.textColor = RGB(153, 153, 153);
    _lblTitle.font = kFONT13;
    
    _lblDesc.textColor = RGB(153, 153, 153);
    _lblDesc.font = [UIFont systemFontOfSize:9];
    
    _btnPay.backgroundColor = RGB(242, 58, 77);
    [_btnPay setTitleColor: UIColor.whiteColor forState: UIControlStateNormal];
    _btnPay.titleLabel.font = kFONT15;
    [_btnPay setTitle: @"去结算" forState: UIControlStateNormal];
    
    [_btnCar setImage: IMAGE(@"store_button_car_normal") forState: UIControlStateNormal];
    [_btnCar setImage: IMAGE(@"store_button_car_disable") forState: UIControlStateDisabled];
    [_btnCar addTarget:self action:@selector(onCarClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnPay addTarget:self action:@selector(onPayClick) forControlEvents:UIControlEventTouchUpInside];
    
    _vCount.image = IMAGE(@"store_goods_car_badge");
    
    _lblCount.textColor = UIColor.whiteColor;
    _lblCount.font = [UIFont systemFontOfSize: 10];
    
//    _lblTitle.text = @"未选购商品";
//    _lblDesc.text = @"外卖则需配送费3元，15元起送";
    
    _btnCar.enabled = YES;
    
}

- (void)setCount: (NSString*)count withPrice: (NSString*)price canBuy:(BOOL) canBuy payTitle: (NSString*)payTitle {
    if ([count kr_isNotEmpty] && ![count isEqualToString: @"0"]) {
        _btnCar.enabled = YES;
        _vCount.hidden = NO;
    } else {
        _btnCar.enabled = NO;
        _vCount.hidden = YES;
    }
    _lblCount.text = count;
    _lblTitle.text = price;
    
    _btnPay.enabled = canBuy;
    if (canBuy) {
        _btnPay.backgroundColor = RGB(242, 58, 77);
    } else {
        _btnPay.backgroundColor = RGB(85, 85, 85);
    }
    [_btnPay setTitle:payTitle forState: UIControlStateNormal];
}

- (void)onCarClick {
    if ([_delegate respondsToSelector:@selector(didCarClick:)]) {
        [_delegate didCarClick:self];
    }
}

- (void)onPayClick {
    if ([_delegate respondsToSelector:@selector(didPayClick:)]) {
        [_delegate didPayClick:self];
    }
}

@end
