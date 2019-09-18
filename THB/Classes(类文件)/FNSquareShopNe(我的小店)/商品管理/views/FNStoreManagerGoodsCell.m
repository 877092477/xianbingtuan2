//
//  FNStoreManagerGoodsCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/9.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreManagerGoodsCell.h"

@interface FNStoreManagerGoodsCell()

@property (nonatomic, strong) UIImageView *imgGoods;
@property (nonatomic, strong) UIImageView *imgStatus;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;
@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UILabel *lblOPrice;
@property (nonatomic, strong) UIButton *btnEdit;

@property (nonatomic, strong) UIView *vSort;
@property (nonatomic, strong) UIButton *btnUp;
@property (nonatomic, strong) UIButton *btnDown;

@end

@implementation FNStoreManagerGoodsCell

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
    _btnEdit = [[UIButton alloc] init];
    
    _vSort = [[UIView alloc] init];
    _btnUp = [[UIButton alloc] init];
    _btnDown = [[UIButton alloc] init];
    
    [self.contentView addSubview:_imgGoods];
    [self.contentView addSubview:_imgStatus];
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_lblDesc];
    [self.contentView addSubview:_lblPrice];
    [self.contentView addSubview:_lblOPrice];
    [self.contentView addSubview:_btnEdit];
    
    [self.contentView addSubview:_vSort];
    [_vSort addSubview:_btnUp];
    [_vSort addSubview:_btnDown];
    
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
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgGoods.mas_right).offset(12);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(8);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgGoods.mas_right).offset(12);
        make.top.equalTo(self.lblDesc.mas_bottom).offset(8);
    }];
    [_lblOPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblPrice.mas_right).offset(4);
        make.bottom.equalTo(self.lblPrice);
        make.right.lessThanOrEqualTo(self.btnEdit.mas_left).offset(-20);
    }];
    [_btnEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-15);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(self.imgGoods);
    }];
    
    [_vSort mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.btnEdit);
    }];
    [_btnUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(@0);
        
    }];
    [_btnDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(@0);
        make.left.equalTo(self.btnUp.mas_right).offset(20);
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
    
    [_btnEdit setTitle: @"编辑" forState: UIControlStateNormal];
    [_btnEdit setTitleColor: RGB(255, 102, 102) forState: UIControlStateNormal];
    _btnEdit.titleLabel.font = kFONT11;
    _btnEdit.cornerRadius = 4;
    _btnEdit.layer.borderWidth = 1;
    _btnEdit.layer.borderColor = RGB(255, 102, 102).CGColor;
    _btnEdit.enabled = NO;
    
    [_btnUp setImage:IMAGE(@"store_manager_button_up_normal") forState: UIControlStateNormal];
    [_btnUp setImage:IMAGE(@"store_manager_button_up_disabled") forState: UIControlStateDisabled];
    [_btnDown setImage:IMAGE(@"store_manager_button_down_normal") forState: UIControlStateNormal];
    [_btnDown setImage:IMAGE(@"store_manager_button_down_disabled") forState: UIControlStateDisabled];
    
    [_btnEdit addTarget:self action:@selector(onEditClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnUp addTarget:self action:@selector(onUpClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnDown addTarget:self action:@selector(onDownClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void) setModel: (FNStoreManagerGoodsModel*)model {
    if ([model.status isEqualToString:@"on_sale"]) {
        _imgStatus.image = IMAGE(@"store_manager_goods_status_sale");
    } else if ([model.status isEqualToString:@"no_stock"]) {
        _imgStatus.image = IMAGE(@"store_manager_goods_status_no_stock");
    } else if ([model.status isEqualToString:@"no_shelves"]) {
        _imgStatus.image = IMAGE(@"store_manager_goods_status_no_shelves");
    }
    
    [_imgGoods sd_setImageWithURL: URL(model.img)];
    _lblTitle.text = model.title;
    _lblDesc.text = model.stock_str;
    _lblPrice.text = model.price;
    _lblOPrice.text = model.cost_price;
}

- (void) setEditable: (BOOL)editable upable: (BOOL)upable downable: (BOOL)downable {
    _btnEdit.hidden = !editable;
    _vSort.hidden = editable;
    
    _btnUp.enabled = upable;
    _btnDown.enabled = downable;
}

- (void)onEditClick {
    if ([_delegate respondsToSelector:@selector(cellDidEditClick:)]) {
        [_delegate cellDidEditClick:self];
    }
}

- (void)onUpClick {
    if ([_delegate respondsToSelector:@selector(cellDidUpClick:)]) {
        [_delegate cellDidUpClick:self];
    }
}

- (void)onDownClick {
    if ([_delegate respondsToSelector:@selector(cellDidDownClick:)]) {
        [_delegate cellDidDownClick:self];
    }
}

@end
