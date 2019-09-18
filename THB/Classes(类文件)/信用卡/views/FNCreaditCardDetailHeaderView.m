//
//  FNCreaditCardDetailHeaderView.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/20.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNCreaditCardDetailHeaderView.h"
#import "SDCycleScrollView.h"

@interface FNCreaditCardDetailHeaderView()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIView* bannerView;
@property (nonatomic, strong) UIView *vLine;

@end

@implementation FNCreaditCardDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    _bannerView = [[UIView alloc] init];
    _imgBanner = [[UIImageView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _vTag = [[UIView alloc] init];
    _lblCount = [[UILabel alloc] init];
    _btnBuy = [[UIButton alloc] init];
    _lblBuy = [[UILabel alloc] init];
    _btnShare = [[UIButton alloc] init];
    _lblShare = [[UILabel alloc] init];
    _lblRule = [[UILabel alloc] init];
    
    [self addSubview:_bannerView];
    [_bannerView addSubview:_imgBanner];
    [self addSubview:_lblTitle];
    [self addSubview:_vTag];
    [self addSubview:_lblCount];
    [self addSubview:_btnBuy];
    [self addSubview:_lblBuy];
    [self addSubview:_btnShare];
    [self addSubview:_lblShare];
    [self addSubview:_lblRule];
    
    [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.mas_equalTo(214);
    }];
    [_imgBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(20, 20, 20, 20));
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self.bannerView.mas_bottom).offset(16);
        make.right.lessThanOrEqualTo(@-16);
    }];
    [_vTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(16);
        make.right.lessThanOrEqualTo(self.lblCount.mas_left).offset(-16);
        make.height.mas_equalTo(0);
    }];
    [_lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-16);
        make.top.equalTo(self.vTag);
    }];
    [_btnBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.left.equalTo(@16);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(8);
    }];
    [_lblBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.btnBuy);
        make.left.equalTo(self.btnBuy.mas_left).offset(8);
        make.right.equalTo(self.btnBuy.mas_right).offset(-8);
    }];
    [_btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.left.equalTo(self.btnBuy.mas_right).offset(4);
        make.top.equalTo(self.btnBuy);
    }];
    [_lblShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.btnShare);
        make.left.equalTo(self.btnShare.mas_left).offset(8);
        make.right.equalTo(self.btnShare.mas_right).offset(-8);
    }];
    [_lblRule mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self.btnBuy.mas_bottom).offset(12);
    }];
    
    _imgBanner.contentMode = UIViewContentModeScaleAspectFit;
    
    self.backgroundColor = UIColor.whiteColor;
    self.bannerView.backgroundColor = RGB(250, 250, 250);
    
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = kFONT15;
    
    _lblBuy.textColor = UIColor.whiteColor;
    _lblBuy.font = kFONT16;
    
    _lblShare.textColor = UIColor.whiteColor;
    _lblShare.font = kFONT16;
    
    _lblCount.textColor = RGB(153, 153, 153);
    _lblCount.font = kFONT11;
    
    _lblRule.textColor = RGB(153, 153, 153);
    _lblRule.font = kFONT12;
    
    _vLine = [[UIView alloc] init];
    [self addSubview: _vLine];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.mas_equalTo(10);
    }];
    _vLine.backgroundColor = RGB(250, 250, 250);
    
}


@end
