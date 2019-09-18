//
//  FNNewStoreGoodsCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/24.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStoreGoodsCell.h"
#define quanPadding 6
#define textPadding 5
@interface FNNewStoreGoodsCell()

@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UIImageView *imgGoods;
@property (nonatomic, strong) UIButton *btnShare;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIImageView *imgQuan;
@property (nonatomic, strong) UILabel *lblQuan;
@property (nonatomic, strong) UIImageView *imgFan;
@property (nonatomic, strong) UILabel *lblFan;

@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UILabel *lblOPrice;
@property (nonatomic, strong) UILabel *lblSales;
@property (nonatomic, strong) UIButton *btnSub;
@property (nonatomic, strong) UILabel *lblCount;
@property (nonatomic, strong) UIButton *btnAdd;


@end

@implementation FNNewStoreGoodsCell


-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _vContent = [[UIView alloc] init];
    _imgGoods = [[UIImageView alloc] init];
    _btnShare = [[UIButton alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _imgQuan = [[UIImageView alloc] init];
    _lblQuan = [[UILabel alloc] init];
    _imgFan = [[UIImageView alloc] init];
    _lblFan = [[UILabel alloc] init];
    _lblPrice = [[UILabel alloc] init];
    _lblOPrice = [[UILabel alloc] init];
    _lblSales = [[UILabel alloc] init];
    _btnSub = [[UIButton alloc] init];
    _lblCount = [[UILabel alloc] init];
    _btnAdd = [[UIButton alloc] init];
    
    [self.contentView addSubview:_vContent];
    [_vContent addSubview:_imgGoods];
    [_vContent addSubview:_btnShare];
    [_vContent addSubview:_lblTitle];
    [_vContent addSubview:_imgQuan];
    [_imgQuan addSubview:_lblQuan];
    [_vContent addSubview:_imgFan];
    [_imgFan addSubview:_lblFan];
    [_vContent addSubview:_lblPrice];
    [_vContent addSubview:_lblOPrice];
    [_vContent addSubview:_lblSales];
    [_vContent addSubview:_btnSub];
    [_vContent addSubview:_lblCount];
    [_vContent addSubview:_btnAdd];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@6);
        make.left.equalTo(@8);
        make.right.equalTo(@-4);
        make.bottom.equalTo(@0);
    }];
    [_imgGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.mas_equalTo(169);
    }];
    [_btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.imgGoods);
        make.height.mas_equalTo(28);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@9);
        make.top.equalTo(self.imgGoods.mas_bottom).offset(9);
        make.right.lessThanOrEqualTo(@-9);
    }];
    [_imgQuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@9);
        make.top.equalTo(self.imgGoods.mas_bottom).offset(30);
        make.height.mas_equalTo(15);
    }];
    [_lblQuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgQuan).offset(4);
        make.right.equalTo(self.imgQuan).offset(-4);
        make.centerY.equalTo(self.imgQuan);
    }];
    [_imgFan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgQuan.mas_right).offset(6);
        make.top.equalTo(self.imgGoods.mas_bottom).offset(30);
        make.height.mas_equalTo(15);
    }];
    [_lblFan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgFan).offset(4);
        make.right.equalTo(self.imgFan).offset(-4);
        make.centerY.equalTo(self.imgFan);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@9);
        make.top.equalTo(self.imgGoods.mas_bottom).offset(55);
    }];
    [_lblOPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblPrice.mas_right).offset(4);
        make.bottom.equalTo(self.lblPrice);
    }];
    [_lblSales mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@9);
        make.bottom.equalTo(@-9);
    }];
    [_btnSub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lblCount.mas_left).offset(-2);
        make.centerY.equalTo(self.btnAdd);
        make.width.height.mas_equalTo(20);
    }];
    [_lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btnAdd.mas_left).offset(-2);
        make.centerY.equalTo(self.btnAdd);
        make.width.mas_equalTo(20);
    }];
    [_btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(@-9);
        make.width.height.mas_equalTo(20);
    }];
    
    
    _vContent.cornerRadius = 8;
    _vContent.backgroundColor = UIColor.whiteColor;
    
    _imgGoods.contentMode = UIViewContentModeScaleAspectFill;
    _imgGoods.clipsToBounds = YES;
    
    _btnShare.titleLabel.font = kFONT11;
    
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = [UIFont boldSystemFontOfSize:12];
    
    _lblQuan.font = kFONT12;
    _lblFan.font = kFONT12;
    
    _lblPrice.textColor = RGB(254, 67, 62);
    _lblPrice.font = kFONT15;
    _lblOPrice.font = kFONT10;
    _lblOPrice.textColor = RGB(153, 153, 153);
    
    _lblSales.font = kFONT10;
    _lblSales.textColor = RGB(153, 153, 153);
    
    [_btnSub setImage: IMAGE(@"store_goods_sub") forState: UIControlStateNormal];
    
    _lblCount.font = kFONT13;
    _lblCount.textColor = RGB(140, 140, 140);
    _lblCount.text = @"0";
    _lblCount.textAlignment = NSTextAlignmentCenter;
    
    [_btnAdd setImage: IMAGE(@"store_goods_add") forState: UIControlStateNormal];
    
    [_btnSub addTarget:self action:@selector(onSubClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnAdd addTarget:self action:@selector(onAddClick) forControlEvents:UIControlEventTouchUpInside];
}


- (void)setIsLeft: (BOOL)isLeft {
    if (isLeft) {
        [_vContent mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@6);
            make.left.equalTo(@8);
            make.right.equalTo(@-4);
            make.bottom.equalTo(@0);
        }];
    } else {
        [_vContent mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@6);
            make.left.equalTo(@4);
            make.right.equalTo(@-8);
            make.bottom.equalTo(@0);
        }];
    }
}

- (void)setModel: (FNStoreGoodsModel*)model {

    [_imgGoods sd_setImageWithURL: URL(model.goods_img)];
    
    [_btnShare sd_setBackgroundImageWithURL: URL(model.share_bjimg) forState:UIControlStateNormal];
    [_btnShare setTitleColor: [UIColor colorWithHexString: model.share_font_color] forState:UIControlStateNormal];
    [_btnShare setTitle: model.share_font forState:UIControlStateNormal];
    _btnShare.hidden = ![model.share_font kr_isNotEmpty];
    
    _lblTitle.text = model.goods_title;
    [_imgQuan sd_setImageWithURL:URL(model.yhq_bjimg)];
    _lblQuan.text = model.yhq_font;
    _lblQuan.textColor = [UIColor colorWithHexString: model.yhq_font_color];
    _imgQuan.hidden = ![model.yhq_font kr_isNotEmpty];
    
    [_imgFan sd_setImageWithURL:URL(model.fanli_bjimg)];
    _lblFan.text = model.fanli_font;
    _lblFan.textColor = [UIColor colorWithHexString: model.fanli_font_color];
    _imgFan.hidden = ![model.fanli_font kr_isNotEmpty];
    
//    _lblPrice.text = model.goods_price;
//    _lblOPrice.text = model.goods_cost_price;
    _lblPrice.text = [NSString stringWithFormat: @"￥%@", model.goods_price];
    _lblOPrice.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥ %@",model.goods_cost_price] attributes:@{NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle)}];
    _lblSales.text = model.sales_str;

    _lblCount.text = [NSString stringWithFormat:@"%@", model.count];
    _btnSub.hidden = [model.count isEqualToString:@"0"];
    
    if([FNCurrentVersion isEqualToString:Setting_checkVersion]){
        _btnShare.hidden = YES;
        _imgQuan.hidden = YES;
        _imgFan.hidden = YES;
    }
    
    
    if (_imgQuan.hidden) {
        [_imgFan mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@9);
            make.top.equalTo(self.imgGoods.mas_bottom).offset(30);
            make.height.mas_equalTo(15);
        }];
    }
}

- (void)onSubClick {

    if ([_delegate respondsToSelector:@selector(storeGoodsCelldidSubClick:)]) {
        [_delegate storeGoodsCelldidSubClick:self];
    }
    
}

- (void)onAddClick {
    if ([_delegate respondsToSelector:@selector(storeGoodsCelldidAddClick:)]) {
        [_delegate storeGoodsCelldidAddClick:self];
    }
}


@end
