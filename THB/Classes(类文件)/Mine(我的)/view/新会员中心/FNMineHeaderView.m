//
//  FNMineHeaderView.m
//  THB
//
//  Created by Weller Zhao on 2018/12/25.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNMineHeaderView.h"

@interface FNMineHeaderView()

@property (nonatomic, strong) UIView *vLine;
@property (nonatomic, strong) UIButton *btnCopy;



@end

@implementation FNMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _btnHeader = [[UIButton alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _imgLevel = [[UIImageView alloc] init];
    _lblLevel = [[UILabel alloc] init];
    _lblCode = [[UILabel alloc] init];
    _vLine = [[UIView alloc] init];
    _btnCopy = [[UIButton alloc] init];
    _btnUpgrade = [[UIButton alloc] init];
    _lblUpgrade = [[UILabel alloc] init];
    
    _vSum = [[UIView alloc] init];
    _imgSumBg = [[UIImageView alloc] init];
    _imgSumIcon = [[UIImageView alloc] init];
    _lblSum = [[UILabel alloc] init];
    _btnSum = [[UIButton alloc] init];
    
    _vCoupone = [[UIView alloc] init];
    _imgCoupone = [[UIImageView alloc] init];
    _lblCoupone = [[UILabel alloc] init];
    _lblCouponeDesc = [[UILabel alloc] init];
    
    _vJifen = [[UIView alloc] init];
    _imgJifen = [[UIImageView alloc] init];
    _imgIcon = [[UIImageView alloc] init];
    _lblJifenTitle = [[UILabel alloc] init];
    _btnMore = [[UIButton alloc] init];
    _imgMore = [[UIImageView alloc] init];
    _lblMore = [[UILabel alloc] init];
    _lblJifen = [[UILabel alloc] init];
    _lblJifenUnit = [[UILabel alloc] init];
    _imgJifenExchange = [[UIImageView alloc] init];
    
    [self addSubview:_btnHeader];
    [self addSubview:_lblTitle];
    [self addSubview:_imgLevel];
    [self addSubview:_lblLevel];
    [self addSubview:_lblCode];
    [self addSubview:_vLine];
    [self addSubview:_btnCopy];
    [self addSubview:_btnUpgrade];
    [self addSubview:_lblUpgrade];
    
    [self addSubview:_vSum];
    [_vSum addSubview:_imgSumBg];
    [_vSum addSubview:_imgSumIcon];
    [_vSum addSubview:_lblSum];
    [_vSum addSubview:_btnSum];
    
    [self addSubview:_vCoupone];
    [_vCoupone addSubview:_imgCoupone];
    [_vCoupone addSubview:_lblCoupone];
    [_vCoupone addSubview:_lblCouponeDesc];
    
    [self addSubview:_vJifen];
    [_vJifen addSubview:_imgJifen];
    [_vJifen addSubview:_imgIcon];
    [_vJifen addSubview:_lblJifenTitle];
    [_vJifen addSubview:_btnMore];
    [_vJifen addSubview:_imgMore];
    [_vJifen addSubview:_lblMore];
    [_vJifen addSubview:_lblJifen];
    [_vJifen addSubview:_lblJifenUnit];
    [_vJifen addSubview:_imgJifenExchange];
    
    [_btnHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(80);
//        make.bottom.equalTo(@-30);
        make.top.equalTo(isIphoneX ? @100 : @80);
        make.left.equalTo(@24);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btnHeader).offset(10);
        make.left.equalTo(_btnHeader.mas_right).offset(14);
    }];
    [_imgLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lblTitle.mas_right).offset(6);
        make.right.lessThanOrEqualTo(@-20);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(14);
        make.centerY.equalTo(_lblTitle);
    }];
    [_lblLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_imgLevel).insets(UIEdgeInsetsMake(0, 18, 0, 4));
    }];
    [_lblCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_btnHeader.mas_right).offset(14);
        make.top.equalTo(_lblTitle.mas_bottom).offset(10);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lblCode.mas_right).offset(10);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(1);
        make.centerY.equalTo(_lblCode);
    }];
    [_btnCopy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vLine.mas_right).offset(10);
        make.centerY.equalTo(_lblCode);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_btnUpgrade mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lblCode.mas_bottom).offset(10);
        make.left.equalTo(_btnHeader.mas_right).offset(12);
        make.right.lessThanOrEqualTo(@-20);
        make.height.mas_equalTo(28);
    }];
    [_lblUpgrade mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_btnUpgrade).insets(UIEdgeInsetsMake(8, 20, 8, 20));
    }];
    
    [_vSum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.vJifen.mas_top);
        make.left.right.equalTo(@0);
        make.height.mas_equalTo(50);
    }];
    [_imgSumBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.bottom.equalTo(@0);
    }];
    [_imgSumIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgSumBg).offset(20);
        make.centerY.equalTo(@0);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(22);
    }];
    [_lblSum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgSumIcon.mas_right).offset(10);
        make.centerY.equalTo(@0);
        make.right.lessThanOrEqualTo(self.btnSum.mas_left).offset(-4);
    }];
    [_btnSum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imgSumBg).offset(-20);
        make.centerY.equalTo(@0);
    }];
    
    [_vCoupone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.bottom.equalTo(@0);
    }];
    [_imgCoupone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        make.height.mas_equalTo(0);
    }];
    [_lblCoupone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@24);
        make.top.equalTo(@20);
//        make.right.lessThanOrEqualTo(@-20);
    }];
    [_lblCouponeDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@24);
        make.bottom.equalTo(@-20);
    }];
    
    _btnHeader.cornerRadius = 40;
    _btnHeader.borderColor = UIColor.whiteColor;
    _btnHeader.borderWidth = 4;
    
    _lblTitle.textColor = UIColor.blackColor;
    _lblTitle.font = [UIFont boldSystemFontOfSize:16];
//    _lblTitle.text = @"Pn_17rakyellt";
    
    _lblLevel.textColor = UIColor.whiteColor;
    _lblLevel.font = [UIFont systemFontOfSize:10];
//    _lblLevel.text = @"金牌代理";
    
    _lblCode.textColor = RGB(24, 24, 24);
    _lblCode.font = [UIFont boldSystemFontOfSize:12];
//    _lblCode.text = @"邀请码 PS1Z88";
    
    _vLine.backgroundColor = RGB(24, 24, 24);
    
    [_btnCopy setTitle:@"复制" forState:UIControlStateNormal];
    [_btnCopy setTitleColor:RGB(24, 24, 24) forState:UIControlStateNormal];
    _btnCopy.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    
    _btnUpgrade.backgroundColor = UIColor.blackColor;
    _btnUpgrade.cornerRadius = 14;
    
    _lblUpgrade.textColor = UIColor.whiteColor;
    _lblUpgrade.font = kFONT12;
//    _lblUpgrade.text = @"升级成为嗨如意合伙人";
    
    [_btnHeader addTarget:self action:@selector(onHeaderClick)];
    [_btnCopy addTarget:self action:@selector(onCopyClick)];
    [_btnUpgrade addTarget:self action:@selector(onUpgradeClick)];
    
    
//    _vSum;
//    _imgSumBg;
//    _imgSumIcon;
    _lblSum.font = [UIFont boldSystemFontOfSize:12];
    _btnSum.titleLabel.font = kFONT12;
    [_btnSum addTarget:self action:@selector(onSumClick)];
    
    _lblCoupone.font = [UIFont boldSystemFontOfSize:30];
    _lblCouponeDesc.font = kFONT12;
    
    [_vJifen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.vCoupone.mas_top).offset(-10);
//        make.left.right.equalTo(@0);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(100);
    }];
    [_imgJifen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.right.bottom.equalTo(@0);
    }];
    [_imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@24);
        make.top.equalTo(@26);
        make.width.height.mas_equalTo(12);
    }];
    [_lblJifenTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgIcon.mas_right).offset(4);
        make.centerY.equalTo(self.imgIcon);
        make.right.lessThanOrEqualTo(self.btnMore.mas_left).offset(-20);
    }];
    [_btnMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.height.mas_equalTo(20);
        make.centerY.equalTo(self.imgIcon);
    }];
    [_imgMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnMore).offset(4);
        make.centerY.equalTo(self.btnMore);
        make.width.height.mas_equalTo(8);
    }];
    [_lblMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgMore.mas_right).offset(2);
        make.right.equalTo(self.btnMore).offset(-4);
        make.centerY.equalTo(self.btnMore);
    }];
    [_lblJifen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgIcon);
        make.bottom.equalTo(@-20);
        
    }];
    [_lblJifenUnit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblJifen.mas_right).offset(6);
        make.bottom.equalTo(self.lblJifen).offset(-4);
        make.right.lessThanOrEqualTo(self.imgJifenExchange).offset(-20);
    }];
    [_imgJifenExchange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.width.mas_equalTo(68);
        make.height.mas_equalTo(22);
        make.bottom.equalTo(self.lblJifen);
    }];
    
    _vJifen;
    _imgJifen;
    _imgIcon;
    _lblJifenTitle.font = kFONT10;
    
    _btnMore;
    _imgMore;
    _lblMore.font = [UIFont systemFontOfSize:9];;
    _lblJifen.font = [UIFont boldSystemFontOfSize:30];
    _lblJifenUnit.font = [UIFont boldSystemFontOfSize:12];
    _imgJifenExchange;
}

- (void)setTextColor: (UIColor*)color {
    _lblTitle.textColor = color;
    _lblCode.textColor = color;
    _vLine.backgroundColor = color;
    [_btnCopy setTitleColor:color forState:UIControlStateNormal];
}

- (void)onHeaderClick {
    if ([self.delegate respondsToSelector:@selector(didHeaderClick:)])
        [self.delegate didHeaderClick:self];
}

- (void)onCopyClick {
    
    if ([self.delegate respondsToSelector:@selector(didCopyClick:)])
        [self.delegate didCopyClick:self];
}

- (void)onUpgradeClick {
    
    if ([self.delegate respondsToSelector:@selector(didUpgradeClick:)])
        [self.delegate didUpgradeClick:self];
}

- (void)onSumClick {
    
    if ([self.delegate respondsToSelector:@selector(didSumClick:)])
        [self.delegate didSumClick:self];
}


@end
