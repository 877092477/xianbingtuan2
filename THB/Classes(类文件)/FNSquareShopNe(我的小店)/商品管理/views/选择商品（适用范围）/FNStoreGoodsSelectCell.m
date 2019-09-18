//
//  FNStoreGoodsSelectCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/16.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreGoodsSelectCell.h"

@interface FNStoreGoodsSelectCell()

@property (nonatomic, strong) UIImageView *imgGoods;
@property (nonatomic, strong) UIImageView *imgStatus;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;
@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UILabel *lblOPrice;
@property (nonatomic, strong) UIImageView *imgCheck;

@end

@implementation FNStoreGoodsSelectCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI {
    _imgGoods = [[UIImageView alloc] init];
    _imgStatus = [[UIImageView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _lblPrice = [[UILabel alloc] init];
    _lblOPrice = [[UILabel alloc] init];
    _imgCheck = [[UIImageView alloc] init];
    
    [self.contentView addSubview:_imgGoods];
    [self.contentView addSubview:_imgStatus];
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_lblDesc];
    [self.contentView addSubview:_lblPrice];
    [self.contentView addSubview:_lblOPrice];
    [self.contentView addSubview:_imgCheck];
    
    [_imgGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.width.height.mas_equalTo(72);
        make.centerY.equalTo(@0);
    }];
    [_imgStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.imgGoods);
        make.height.mas_equalTo(18);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgGoods.mas_right).offset(12);
        make.top.equalTo(self.imgGoods).offset(8);
        make.right.lessThanOrEqualTo(self.imgCheck.mas_left).offset(-20);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgGoods.mas_right).offset(12);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(8);
        make.right.lessThanOrEqualTo(self.imgCheck.mas_left).offset(-20);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgGoods.mas_right).offset(12);
        make.top.equalTo(self.lblDesc.mas_bottom).offset(8);
    }];
    [_lblOPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblPrice.mas_right).offset(4);
        make.bottom.equalTo(self.lblPrice);
        make.right.lessThanOrEqualTo(self.imgCheck.mas_left).offset(-20);
    }];
    [_imgCheck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-28);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(12);
        make.centerY.equalTo(self.imgGoods);
    }];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _imgGoods.cornerRadius = 4;
    _imgGoods.contentMode = UIViewContentModeScaleAspectFill;
    
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = kFONT14;
    
    _lblDesc.textColor = RGB(153, 153, 153);
    _lblDesc.font = kFONT10;
    
    _lblPrice.textColor = RGB(254, 67, 62);
    _lblPrice.font = kFONT15;
    
    _lblOPrice.textColor = RGB(153, 153, 153);
    _lblOPrice.font = [UIFont systemFontOfSize:9];
    
    
    _imgCheck.image = IMAGE(@"store_goods_select_check_disabled");

}

- (void) setIsSelected: (BOOL) isSelected {
    _imgCheck.image = IMAGE(isSelected ? @"store_goods_select_check_enabled" : @"store_goods_select_check_disabled");
}

- (void) setModel: (FNStoreManagerGoodsModel*)model {
    
    [_imgGoods sd_setImageWithURL: URL(model.img)];
    _lblTitle.text = model.title;
    _lblDesc.text = model.stock_str;
    _lblPrice.text = model.price;
    _lblOPrice.text = model.cost_price;
    
    [self setIsSelected: model.isSelected];
}


@end
