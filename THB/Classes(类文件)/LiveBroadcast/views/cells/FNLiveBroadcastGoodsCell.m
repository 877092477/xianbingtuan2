//
//  FNLiveBroadcastGoodsCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveBroadcastGoodsCell.h"

@interface FNLiveBroadcastGoodsCell()

@property (nonatomic, strong) UIView *vContent;

@end

@implementation FNLiveBroadcastGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI {
    _imgHeader = [[UIImageView alloc] init];
    _vContent = [[UIView alloc] init];
    _lblTitle = [[UILabel alloc] init];;
    _lblDesc = [[UILabel alloc] init];;
    _lblPrice = [[UILabel alloc] init];;
    _imgQuan1 = [[UIImageView alloc] init];;
    _imgQuan2 = [[UIImageView alloc] init];;
    _lblQuan = [[UILabel alloc] init];;
    _btnBuy = [[UIButton alloc] init];;
    
    [self.contentView addSubview:_imgHeader];
    [self.contentView addSubview:_vContent];
    [_vContent addSubview:_lblTitle];
    [_vContent addSubview:_lblDesc];
    [_vContent addSubview:_lblPrice];
    [_vContent addSubview:_imgQuan1];
    [_vContent addSubview:_imgQuan2];
    [_vContent addSubview:_lblQuan];
    [_vContent addSubview:_btnBuy];
    
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@20);
        make.width.height.mas_equalTo(36);
        make.bottom.lessThanOrEqualTo(@-20);
    }];
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@70);
        make.top.equalTo(@20);
        make.right.equalTo(@-70);
        make.bottom.equalTo(@-20);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@10);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblTitle.mas_bottom).offset(10);
        make.left.equalTo(@10);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblDesc.mas_bottom).offset(10);
        make.left.equalTo(@10);
        make.height.mas_equalTo(18);
    }];
    [_imgQuan1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lblPrice);
        make.left.equalTo(self.lblPrice.mas_right).offset(14);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(22);
    }];
    [_imgQuan2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lblPrice);
        make.left.equalTo(self.imgQuan1.mas_right);
        make.height.mas_equalTo(18);
        make.width.mas_greaterThanOrEqualTo(50);
    }];
    [_lblQuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.imgQuan2);
        make.left.greaterThanOrEqualTo(self.imgQuan2).offset(4);
        make.right.lessThanOrEqualTo(self.imgQuan2).offset(-4);
        make.height.mas_equalTo(18);
    }];
    [_btnBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblPrice.mas_bottom).offset(10);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.bottom.equalTo(@-14);
        make.height.mas_equalTo(40);
    }];
    
    _imgHeader.cornerRadius = 13;
    _imgHeader.contentMode = UIViewContentModeScaleToFill;
    
    _vContent.cornerRadius = 5;
    _vContent.borderColor = RGB(249, 240, 249);
    _vContent.borderWidth = 1;
    
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = kFONT12;
    _lblTitle.numberOfLines = 2;
    
    _lblDesc.textColor = RGB(102, 102, 102);
    _lblDesc.font = kFONT10;
    _lblDesc.numberOfLines = 2;
    
    _lblPrice.textColor = RGB(245, 66, 110);
    _lblPrice.font = [UIFont systemFontOfSize:18];
    
    _lblQuan.textColor = RGB(245, 66, 110);
    _lblQuan.font = [UIFont systemFontOfSize:13];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [_btnBuy addTarget:self action:@selector(onBuyClick)];
    _btnBuy.titleLabel.font = kFONT15;
}

- (void) onBuyClick {
    if ([_delegate respondsToSelector:@selector(didBuyClick:)]) {
        [_delegate didBuyClick:self];
    }
}

@end
