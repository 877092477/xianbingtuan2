//
//  FNIntergralMailBottomView.m
//  THB
//
//  Created by Weller Zhao on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNIntergralMailBottomView.h"

@interface FNIntergralMailBottomView()

@property (nonatomic, strong) UIView *vTips;
@property (nonatomic, strong) UIButton *btnTips;
@property (nonatomic, strong) UIImageView *imgRight;
//@property (nonatomic, strong) UIButton *btnLeft;
//@property (nonatomic, strong) UIButton *btnCenter;
//@property (nonatomic, strong) UIButton *btnRight;

@end

@implementation FNIntergralMailBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.vTips = [[UIView alloc] init];
    self.btnTips = [[UIButton alloc] init];
    self.imgRight = [[UIImageView alloc] init];
    self.btnLeft = [[UIButton alloc] init];
    self.btnCenter = [[UIButton alloc] init];
    self.btnRight = [[UIButton alloc] init];
    
    [self addSubview: self.vTips];
    [self.vTips addSubview: self.imgRight];
    [self.vTips addSubview: self.btnTips];
    [self addSubview: self.btnLeft];
    [self addSubview: self.btnCenter];
    [self addSubview: self.btnRight];
    
    [self.vTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.mas_equalTo(30);
    }];
    [self.btnTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.imgRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.centerY.equalTo(@0);
    }];
    [self.btnLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(self.vTips.mas_bottom);
//        make.width.equalTo(@0).dividedBy(3);
        make.width.equalTo(self).dividedBy(4);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(@0);
    }];
    [self.btnCenter mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(@0);
        make.centerY.equalTo(self.btnLeft);
        make.left.equalTo(self.btnLeft.mas_right);
        make.height.mas_equalTo(44);
//        make.bottom.equalTo(@0);
    }];
    [self.btnRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
//        make.top.equalTo(self.vTips.mas_bottom);
        make.centerY.equalTo(self.btnLeft);
        make.left.equalTo(self.btnCenter.mas_right);
        make.height.mas_equalTo(44);
//        make.bottom.equalTo(@0);
        make.width.equalTo(self.btnCenter);
    }];

//    self.vTips.backgroundColor = RGB(255, 239, 130);
    
//    [self.btnTips setTitle:@"您的积分不足，可进入现金兑换" forState:UIControlStateNormal];
    [self.btnTips setTitleColor:RGB(255, 120, 0) forState:UIControlStateNormal];
    self.btnTips.titleLabel.font = kFONT12;
    
    //self.imgRight.image = IMAGE(@"integral_mall_image_right");
    
    self.lblLeft = [[UILabel alloc] init];
    self.imgLeft = [[UIImageView alloc] init];
    [self.btnLeft addSubview: self.lblLeft];
    [self.btnLeft addSubview: self.imgLeft];
    
    self.lblLeft.textColor = RGB(60, 60, 60);
    self.lblLeft.font = kFONT14;
    [self.lblLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@14);
        make.right.lessThanOrEqualTo(self.btnLeft);
        make.left.greaterThanOrEqualTo(self.btnLeft);
        make.centerX.equalTo(self.btnLeft);
    }];
    
    [self.imgLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.width.mas_equalTo(20);
        make.centerX.equalTo(self.btnLeft);
        make.centerY.equalTo(self.btnLeft).offset(-10);
        make.bottom.equalTo(self.lblLeft.mas_top).offset(-4);
    }];
    
    [self.btnCenter setTitleColor:FNWhiteColor forState:UIControlStateNormal];
    self.btnCenter.titleLabel.font = kFONT12;
    self.btnCenter.titleLabel.numberOfLines = 0;
    self.btnCenter.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.btnRight setTitleColor:FNWhiteColor forState:UIControlStateNormal];
    self.btnRight.titleLabel.font = kFONT12;
    self.btnRight.titleLabel.numberOfLines = 0;
    self.btnRight.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.btnLeft addTarget:self action:@selector(onLeftClick)];
    [self.btnCenter addTarget:self action:@selector(onCenterClick)];
    [self.btnRight addTarget:self action:@selector(onRightClick)];
    [self.btnTips addTarget:self action:@selector(onTipsClick)];
}

- (void) onLeftClick {
    if ([_delegate respondsToSelector:@selector(didLeftClick:)])
        [_delegate didLeftClick:self];
}

- (void) onCenterClick {
    if ([_delegate respondsToSelector:@selector(didCenterClick:)])
        [_delegate didCenterClick:self];
}

- (void) onRightClick {
    if ([_delegate respondsToSelector:@selector(didRightClick:)])
        [_delegate didRightClick:self];
}

- (void) onTipsClick {
    if ([_delegate respondsToSelector:@selector(didTipsClick:)])
        [_delegate didTipsClick:self];
}

- (void)setTips: (NSString*)tips withTitleColor: (UIColor*)color backgroundColor: (UIColor*)bgColor isHidden: (BOOL)isHidden {
    [_btnTips setTitle:tips forState:UIControlStateNormal];
    [_btnTips setTitleColor:color forState:UIControlStateNormal];
    _vTips.backgroundColor = bgColor;
    [_vTips mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(isHidden ? 0 : 30);
    }];
    [_vTips setHidden:isHidden];
}
//- (void)setLeftButton: (NSString*)title withIcon: (NSString*)iconUrl titleColor: (UIColor*)titleColor backgroundColor: (UIColor*)bgColor {
//    [_btnLeft setTitle:title forState:UIControlStateNormal];
//    [_btnLeft sd_setImageWithURL:URL(iconUrl) forState:UIControlStateNormal];
//    [_btnLeft setTitleColor:titleColor forState:UIControlStateNormal];
//    _btnLeft.backgroundColor = bgColor;
//}
//- (void)setRightButton: (NSString*)title withTitleColor: (UIColor*)titleColor backgroundColor: (UIColor*)bgColor isEnable: (BOOL)isEnable {
//    [_btnRight setTitle:title forState:UIControlStateNormal];
//    [_btnRight setTitleColor:titleColor forState:UIControlStateNormal];
//    _btnRight.backgroundColor = bgColor;
//    [_btnRight setEnabled:isEnable];
//}

@end
