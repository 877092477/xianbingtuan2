//
//  FNNewStoreGoodsHeaderCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/26.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStoreGoodsHeaderCell.h"
#import "SDCycleScrollView.h"

@interface FNNewStoreGoodsHeaderCell()

@property (nonatomic, strong) UIImageView *vHeader;
@property (nonatomic, strong) SDCycleScrollView* bannerView;
@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UILabel *lblOPrice;
@property (nonatomic, strong) UIImageView *imgQuan;
@property (nonatomic, strong) UILabel *lblQuan;
@property (nonatomic, strong) UIImageView *imgFan;
@property (nonatomic, strong) UILabel *lblFan;
@property (nonatomic, strong) UIButton *btnSub;
@property (nonatomic, strong) UILabel *lblCount;
@property (nonatomic, strong) UIButton *btnAdd;
@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, strong) UIImageView *imgLocation;
@property (nonatomic, strong) UILabel *lblLocation;
@property (nonatomic, strong) UILabel *lblDistance;
@property (nonatomic, strong) UILabel *lblSales;

@property (nonatomic, strong) UIImageView *imgUpgradeBg;
@property (nonatomic, strong) UIImageView *imgUpgrade;
@property (nonatomic, strong) UILabel *lblUpgrade;
@property (nonatomic, strong) UIButton *btnUpgrade;

@property (nonatomic, strong) UIView *vZgz;
@property (nonatomic, strong) UIButton *imgZgz;
@property (nonatomic, strong) UILabel *lblZgz;
@property (nonatomic, strong) UILabel *lblZgzPrice;
@property (nonatomic, strong) UIView *vFxz;
@property (nonatomic, strong) UIButton *imgFxz;
@property (nonatomic, strong) UILabel *lblFxz;
@property (nonatomic, strong) UILabel *lblFxzPrice;

@end

@implementation FNNewStoreGoodsHeaderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _vHeader = [[UIImageView alloc] init];
    _lblPrice = [[UILabel alloc] init];
    _lblOPrice = [[UILabel alloc] init];
    _imgQuan = [[UIImageView alloc] init];
    _lblQuan = [[UILabel alloc] init];
    _imgFan = [[UIImageView alloc] init];
    _lblFan = [[UILabel alloc] init];
    _btnSub = [[UIButton alloc] init];
    _lblCount = [[UILabel alloc] init];
    _btnAdd = [[UIButton alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _imgLocation = [[UIImageView alloc] init];
    _lblLocation = [[UILabel alloc] init];
    _lblDistance = [[UILabel alloc] init];
    _lblSales = [[UILabel alloc] init];
    _imgUpgradeBg = [[UIImageView alloc] init];
    _imgUpgrade = [[UIImageView alloc] init];
    _lblUpgrade = [[UILabel alloc] init];
    _btnUpgrade = [[UIButton alloc] init];
    
    [self.contentView addSubview:_vHeader];
    [self.contentView addSubview:_lblPrice];
    [self.contentView addSubview:_lblOPrice];
    [self.contentView addSubview:_imgQuan];
    [_imgQuan addSubview:_lblQuan];
    [self.contentView addSubview:_imgFan];
    [_imgFan addSubview:_lblFan];
    [self.contentView addSubview:_btnSub];
    [self.contentView addSubview:_lblCount];
    [self.contentView addSubview:_btnAdd];
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_imgLocation];
    [self.contentView addSubview:_lblLocation];
    [self.contentView addSubview:_lblDistance];
    [self.contentView addSubview:_lblSales];
    [self.contentView addSubview:_imgUpgradeBg];
    [_imgUpgradeBg addSubview:_imgUpgrade];
    [_imgUpgradeBg addSubview:_lblUpgrade];
    [self.contentView addSubview:_btnUpgrade];
    
    [_vHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.mas_equalTo(self.vHeader.mas_width);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.equalTo(self.vHeader.mas_bottom).offset(20);
    }];
    [_lblOPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblPrice.mas_right).offset(2);
        make.bottom.equalTo(self.lblPrice);
    }];
    [_imgQuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lblPrice);
        make.height.mas_equalTo(15);
        make.left.equalTo(self.lblOPrice.mas_right).offset(6);
    }];
    [_lblQuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgQuan).offset(4);
        make.right.equalTo(self.imgQuan).offset(-4);
        make.centerY.equalTo(self.imgQuan);
    }];
    [_imgFan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lblPrice);
        make.height.mas_equalTo(15);
        make.left.equalTo(self.imgQuan.mas_right).offset(6);
    }];
    [_lblFan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgFan).offset(4);
        make.right.equalTo(self.imgFan).offset(-4);
        make.centerY.equalTo(self.imgFan);
    }];
    [_btnSub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vHeader.mas_bottom).offset(19);
        make.right.equalTo(self.lblCount.mas_left);
        make.width.height.mas_equalTo(20);
    }];
    [_lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.btnAdd);
        make.width.mas_equalTo(24);
        make.right.equalTo(self.btnAdd.mas_left);
    }];
    [_btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vHeader.mas_bottom).offset(19);
        make.right.equalTo(@-15);
        make.width.height.mas_equalTo(20);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.equalTo(self.vHeader.mas_bottom).offset(53);
        make.right.lessThanOrEqualTo(@-12);
    }];
    [_imgLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.equalTo(self.vHeader.mas_bottom).offset(86);
        make.width.height.mas_equalTo(13);
    }];
    [_lblLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgLocation.mas_right).offset(4);
        make.centerY.equalTo(self.imgLocation);
    }];
    [_lblDistance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblLocation.mas_right).offset(8);
        make.centerY.equalTo(self.imgLocation);
        make.right.lessThanOrEqualTo(self.lblSales.mas_left).offset(-10);
    }];
    [_lblSales mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-12);
        make.centerY.equalTo(self.imgLocation);
    }];
    [_imgUpgradeBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.right.equalTo(@-12);
        make.top.equalTo(self.vHeader.mas_bottom).offset(114);
        make.height.mas_equalTo(24);
    }];
    [_imgUpgrade mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.centerY.equalTo(@0);
        make.width.height.mas_equalTo(14);
    }];
    [_lblUpgrade mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgUpgrade.mas_right).offset(4);
        make.centerY.equalTo(@0);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [_btnUpgrade mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imgUpgradeBg).offset(-4);
        make.centerY.equalTo(self.imgUpgradeBg);
    }];
    
    self.backgroundColor = UIColor.whiteColor;
    
    _vHeader.contentMode = UIViewContentModeScaleAspectFill;
    _vHeader.layer.masksToBounds = YES;
    _lblPrice.textColor = RGB(254, 67, 62);
    _lblPrice.font = kFONT15;
    
    _lblOPrice.textColor = RGB(153, 153, 153);
    _lblOPrice.font = kFONT12;
    
    
    _lblQuan.font = kFONT11;
    
    _lblFan.font = kFONT11;
    
    _lblTitle.font = [UIFont boldSystemFontOfSize:18];
    _lblTitle.textColor = RGB(51, 51, 51);
    
    _lblLocation.font = kFONT13;
    _lblLocation.textColor = RGB(128, 128, 128);
    
    _lblDistance.font = kFONT12;
    _lblDistance.textColor = RGB(128, 128, 128);
    
    _lblSales.font = kFONT12;
    _lblSales.textColor = RGB(128, 128, 128);
    
    _lblUpgrade.font = kFONT10;
    _btnUpgrade.titleLabel.font = kFONT10;
    
    [_btnSub setImage: IMAGE(@"store_goods_sub") forState: UIControlStateNormal];
    
    _lblCount.font = kFONT13;
    _lblCount.textColor = RGB(140, 140, 140);
    _lblCount.text = @"0";
    _lblCount.textAlignment = NSTextAlignmentCenter;
    
    [_btnAdd setImage: IMAGE(@"store_goods_add") forState: UIControlStateNormal];
    
    [_btnAdd addTarget:self action:@selector(onAddClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnSub addTarget:self action:@selector(onSubClick) forControlEvents:UIControlEventTouchUpInside];
    
    _vZgz = [[UIView alloc] init];
    _imgZgz = [[UIButton alloc] init];
    _lblZgz = [[UILabel alloc] init];
    _lblZgzPrice = [[UILabel alloc] init];
    _vFxz = [[UIView alloc] init];
    _imgFxz = [[UIButton alloc] init];
    _lblFxz = [[UILabel alloc] init];
    _lblFxzPrice = [[UILabel alloc] init];
    
    [self.contentView addSubview:_vZgz];
    [_vZgz addSubview:_imgZgz];
    [_vZgz addSubview:_lblZgz];
    [_vZgz addSubview:_lblZgzPrice];
    [self.contentView addSubview:_vFxz];
    [_vFxz addSubview:_imgFxz];
    [_vFxz addSubview:_lblFxz];
    [_vFxz addSubview:_lblFxzPrice];
    
    [_vZgz mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(42);
        make.top.equalTo(@108);
    }];
    [_imgZgz mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@1);
//        make.centerY.equalTo(@0);
//        make.width.height.mas_equalTo(40);
        make.edges.equalTo(@0);
    }];
    [_lblZgz mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.top.equalTo(@8);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [_lblZgzPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.top.equalTo(self.lblZgz.mas_bottom).offset(2);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [_vFxz mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(42);
        make.top.equalTo(self.vZgz.mas_bottom).offset(12);
    }];
    [_imgFxz mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@1);
//        make.centerY.equalTo(@0);
//        make.width.height.mas_equalTo(40);
        make.edges.equalTo(@0);
    }];
    [_lblFxz mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.top.equalTo(@8);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [_lblFxzPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.top.equalTo(self.lblFxz.mas_bottom).offset(2);
        make.right.lessThanOrEqualTo(@-10);
    }];
    
//    _vZgz.backgroundColor = RGBA(0, 0, 0, 0.2);
    _lblZgz.textColor = UIColor.whiteColor;
    _lblZgz.font = kFONT12;
    
    _lblZgzPrice.textColor = UIColor.whiteColor;
    _lblZgzPrice.font = kFONT11;
    
//    _vFxz.backgroundColor = RGBA(0, 0, 0, 0.2);
    _lblFxz.textColor = UIColor.whiteColor;
    _lblFxz.font = kFONT12;
    _lblFxzPrice.textColor = UIColor.whiteColor;
    _lblFxzPrice.font = kFONT11;
    
    [_imgZgz addTarget:self action:@selector(onBuyClick) forControlEvents:UIControlEventTouchUpInside];
    [_imgFxz addTarget:self action:@selector(onShareClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setModel: (FNStoreGoodsDetailModel*)model {

    _lblPrice.text = [NSString stringWithFormat: @"￥%@", model.goods_price];
    _lblOPrice.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",model.goods_cost_price] attributes:@{NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle)}];
    [_imgQuan sd_setImageWithURL:URL(model.yhq_bjimg)];
    _lblQuan.text = model.yhq_font;
    _lblQuan.textColor = [UIColor colorWithHexString: model.yhq_font_color];
    _imgQuan.hidden = ![model.yhq_font kr_isNotEmpty];
    
    [_imgFan sd_setImageWithURL:URL(model.fanli_bjimg)];
    _lblFan.text = model.fanli_font;
    _lblFan.textColor = [UIColor colorWithHexString: model.fanli_font_color];
    _imgFan.hidden = ![model.fanli_font kr_isNotEmpty];
    
    _lblCount.text = model.count;
    _btnSub.hidden = [model.count isEqualToString:@"0"];

    _lblTitle.text = model.goods_title;
    
    [_imgLocation sd_setImageWithURL:URL(model.map_icon)];
    _lblLocation.text = model.store_name;
    _lblDistance.text = model.distance_str;
    _lblSales.text = model.sales_str;
    
    NSDictionary *img_zgzDic=model.zgz;
    _vZgz.hidden = [img_zgzDic[@"is_show"] isEqualToString:@"0"];
    [_imgZgz sd_setBackgroundImageWithURL:URL(img_zgzDic[@"bj_img"]) forState: UIControlStateNormal];
    _lblZgz.text = img_zgzDic[@"str"];
    _lblZgz.textColor = [UIColor colorWithHexString: img_zgzDic[@"font_color"]];
    _lblZgzPrice.text = [NSString stringWithFormat:@"￥%@", img_zgzDic[@"commission"]];
    _lblZgzPrice.textColor = [UIColor colorWithHexString: img_zgzDic[@"font_color"]];
    
    
    NSDictionary *img_fxzDic=model.fxz;
    _vFxz.hidden = [img_fxzDic[@"is_show"] isEqualToString:@"0"];
    [_imgFxz sd_setBackgroundImageWithURL:URL(img_fxzDic[@"bj_img"]) forState: UIControlStateNormal];
    _lblFxz.text = img_fxzDic[@"str"];
    _lblFxz.textColor = [UIColor colorWithHexString: img_fxzDic[@"font_color"]];
    _lblFxzPrice.text = [NSString stringWithFormat:@"￥%@", img_fxzDic[@"commission"]];
    _lblFxzPrice.textColor = [UIColor colorWithHexString: img_fxzDic[@"font_color"]];
    
    NSDictionary *img_sjzDic=model.sjz;
    NSInteger sjShow=[img_sjzDic[@"is_show"] integerValue];
    if(sjShow==0){
        _imgUpgradeBg.hidden=YES;
        _btnUpgrade.hidden = YES;
    }else{
        _imgUpgradeBg.hidden=NO;
        _btnUpgrade.hidden = NO;

    }
    
    [_imgUpgradeBg sd_setImageWithURL:URL(img_sjzDic[@"img"])];
    [_imgUpgrade sd_setImageWithURL:URL(img_sjzDic[@"icos"])];
    
    _lblUpgrade.text = img_sjzDic[@"str"];
    _lblUpgrade.textColor = [UIColor colorWithHexString: img_sjzDic[@"font_color"]];
    [_btnUpgrade setTitle: img_sjzDic[@"str1"] forState: UIControlStateNormal];
    [_btnUpgrade setTitleColor: [UIColor colorWithHexString: img_sjzDic[@"font_color"]] forState: UIControlStateNormal];
    
    [_imgFan mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lblPrice);
        make.height.mas_equalTo(15);
        if (self.imgQuan.hidden) {
            make.left.equalTo(self.lblOPrice.mas_right).offset(6);
        } else {
            make.left.equalTo(self.imgQuan.mas_right).offset(6);
        }
    }];
    
    [_vHeader sd_setImageWithURL: URL(model.goods_img)];
}

#pragma mark - Action

- (void)onSubClick {
    if ([_delegate respondsToSelector:@selector(goodsCellDidSubClick:)]) {
        [_delegate goodsCellDidSubClick:self];
    }
}

- (void)onAddClick {
    if ([_delegate respondsToSelector:@selector(goodsCellDidAddClick:)]) {
        [_delegate goodsCellDidAddClick:self];
    }
}


- (void)onBuyClick {
    if ([_delegate respondsToSelector:@selector(goodsCellDidBuyClick:)]) {
        [_delegate goodsCellDidBuyClick:self];
    }
}

- (void)onShareClick {
    if ([_delegate respondsToSelector:@selector(goodsCellDidShareClick:)]) {
        [_delegate goodsCellDidShareClick:self];
    }
}
@end
