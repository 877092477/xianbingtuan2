//
//  FNCreaditCardShareHeaderView.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/21.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNCreaditCardShareHeaderView.h"

@interface FNCreaditCardShareHeaderView()

//@property (nonatomic, strong) UIView* bannerView;
//@property (nonatomic, strong) UIImageView* imgHeader;
//
//@property (nonatomic, strong) UIView *vContent;
//@property (nonatomic, strong) UILabel *lblTitle;
//@property (nonatomic, strong) UIView *vTag;
//@property (nonatomic, strong) UILabel *lblCount;
//@property (nonatomic, strong) UIButton *btnBuy;
//@property (nonatomic, strong) UILabel *lblBuy;
//@property (nonatomic, strong) UIButton *btnShare;
//@property (nonatomic, strong) UILabel *lblShare;
//@property (nonatomic, strong) UILabel *lblRule;

@end

@implementation FNCreaditCardShareHeaderView

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
    _imgHeader = [[UIImageView alloc] init];
    
    _vContent = [[UIView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _vTag = [[UIView alloc] init];
    _lblCount = [[UILabel alloc] init];
    _btnBuy = [[UIButton alloc] init];
    _lblBuy = [[UILabel alloc] init];
    _btnShare = [[UIButton alloc] init];
    _lblShare = [[UILabel alloc] init];
    _lblRule = [[UILabel alloc] init];
    
    [self addSubview:_bannerView];
    [_bannerView addSubview: _imgHeader];
    
    [self addSubview: _vContent];
    [_vContent addSubview:_lblTitle];
    [_vContent addSubview:_vTag];
    [_vContent addSubview:_lblCount];
    [_vContent addSubview:_btnBuy];
    [_vContent addSubview:_lblBuy];
    [_vContent addSubview:_btnShare];
    [_vContent addSubview:_lblShare];
    [_vContent addSubview:_lblRule];
    
    [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@12);
        make.height.mas_equalTo(112);
    }];
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.height.mas_equalTo(95);
        make.width.mas_equalTo(150);
//        make.right.equalTo(@-16);
        make.centerY.equalTo(@0);
    }];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.bannerView.mas_bottom).offset(12);
        make.right.lessThanOrEqualTo(@-16);
        make.bottom.equalTo(@-12);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@16);
        make.right.lessThanOrEqualTo(@-16);
    }];
    [_vTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@16);
        make.right.lessThanOrEqualTo(self.lblCount.mas_left).offset(-16);
        make.height.mas_equalTo(20);
    }];
    [_lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-16);
        make.top.equalTo(self.vTag);
    }];
    [_btnBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.left.equalTo(@16);
        make.top.equalTo(self.vTag.mas_bottom).offset(8);
    }];
    [_lblBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.btnBuy);
        make.left.equalTo(self.btnBuy.mas_left).offset(8);
        make.right.equalTo(self.btnBuy.mas_right).offset(-8);
    }];
    [_btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.left.equalTo(self.btnBuy.mas_right).offset(4);
        make.top.equalTo(self.vTag.mas_bottom).offset(8);
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
    
    _vContent.backgroundColor = UIColor.whiteColor;
    
    _imgHeader.contentMode = UIViewContentModeScaleAspectFit;
    
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
    
    
}




@end
