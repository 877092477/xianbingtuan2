//
//  FNNewStoreCarAlertCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/27.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStoreCarAlertCell.h"

@interface FNNewStoreCarAlertCell()

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;
@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UIButton *btnSub;
@property (nonatomic, strong) UILabel *lblCount;
@property (nonatomic, strong) UIButton *btnAdd;

@end

@implementation FNNewStoreCarAlertCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI {
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _lblPrice = [[UILabel alloc] init];
    _btnSub = [[UIButton alloc] init];
    _lblCount = [[UILabel alloc] init];
    _btnAdd = [[UIButton alloc] init];
    
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_lblDesc];
    [self.contentView addSubview:_lblPrice];
    [self.contentView addSubview:_btnSub];
    [self.contentView addSubview:_lblCount];
    [self.contentView addSubview:_btnAdd];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@15);
        make.right.lessThanOrEqualTo(self.lblPrice.mas_left).offset(-10);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(4);
        make.right.lessThanOrEqualTo(self.lblPrice.mas_left).offset(-10);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btnSub.mas_left).offset(-20);
        make.centerY.equalTo(@0);
    }];
    [_btnSub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.centerY.equalTo(@0);
        make.right.equalTo(self.lblCount.mas_left).offset(-2);
    }];
    [_lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(20);
        make.centerY.equalTo(@0);
        make.right.equalTo(self.btnAdd.mas_left).offset(-2);
    }];
    [_btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.centerY.equalTo(@0);
        make.right.equalTo(@-15);
    }];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _lblTitle.textColor = RGB(60, 60, 60);
    _lblTitle.font = kFONT14;
    
    _lblDesc.textColor = RGB(153, 153, 153);
    _lblDesc.font = kFONT10;
    
    _lblPrice.textColor = RGB(244, 47, 25);
    _lblPrice.font = kFONT14;
    
    [_btnSub setImage: IMAGE(@"store_goods_sub") forState: UIControlStateNormal];
    
    _lblCount.font = kFONT13;
    _lblCount.textColor = RGB(140, 140, 140);
    _lblCount.text = @"0";
    _lblCount.textAlignment = NSTextAlignmentCenter;
    
    [_btnAdd setImage: IMAGE(@"store_goods_add") forState: UIControlStateNormal];
    
    [_btnSub addTarget:self action:@selector(onSubClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnAdd addTarget:self action:@selector(onAddClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setModel: (FNStoreCarModel*)model {
    _lblTitle.text = model.goods_title;
    _lblDesc.text = model.tips;
    _lblCount.text = model.count;
    _lblPrice.text = [NSString stringWithFormat:@"￥%@", model.price];
}

- (void)onSubClick {
    if ([_delegate respondsToSelector:@selector(didSubClick:)]) {
        [_delegate didSubClick:self];
    }
}

- (void)onAddClick {
    if ([_delegate respondsToSelector:@selector(didAddClick:)]) {
        [_delegate didAddClick:self];
    }
}

@end
