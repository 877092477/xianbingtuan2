//
//  FNStoreManagerGoodsSpecView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/13.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreManagerGoodsSpecView.h"

@interface FNStoreManagerGoodsSpecRowView : UIView

@property (nonatomic, strong) UILabel *lblName;
@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UILabel *lblStock;

@end

@implementation FNStoreManagerGoodsSpecRowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void) configUI {
    _lblName = [[UILabel alloc] init];
    _lblPrice = [[UILabel alloc] init];
    _lblStock = [[UILabel alloc] init];
    
    [self addSubview:_lblName];
    [self addSubview:_lblPrice];
    [self addSubview:_lblStock];
    
    [_lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(@0);
        make.width.equalTo(self).dividedBy(4);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.width.equalTo(self).dividedBy(4);
        make.left.equalTo(self.lblName.mas_right);
    }];
    [_lblStock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.width.equalTo(self).dividedBy(4);
        make.left.equalTo(self.lblPrice.mas_right);
    }];
    
    _lblName.textColor = RGB(51, 51, 51);
    _lblPrice.textColor = RGB(51, 51, 51);
    _lblStock.textColor = RGB(51, 51, 51);
    _lblName.font = kFONT12;
    _lblPrice.font = kFONT12;
    _lblStock.font = kFONT12;
}

@end

@interface FNStoreManagerGoodsSpecView()

@property (nonatomic, strong) UIView *vContent;

@property (nonatomic, strong) FNStoreManagerGoodsSpecRowView *vTitle;

@property (nonatomic, strong) NSMutableArray<FNStoreManagerGoodsSpecRowView*> *rows;

@end

@implementation FNStoreManagerGoodsSpecView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _rows = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _vContent = [[UIView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _vTitle = [[FNStoreManagerGoodsSpecRowView alloc] init];
    
    [self addSubview:_vContent];
    [_vContent addSubview:_lblTitle];
    [_vContent addSubview:_vTitle];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@22);
        make.right.lessThanOrEqualTo(@-20);
    }];
    
    [_vTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblTitle.mas_bottom).offset(10);
        make.left.equalTo(@22);
        make.right.equalTo(@-22);
        make.height.mas_equalTo(22);
    }];
    
    _vContent.backgroundColor = UIColor.whiteColor;
    _lblTitle.font = kFONT12;
    _lblTitle.textColor = RGB(153, 153, 153);
    
}

- (void)setSpec: (FNStoreGoodsSpecManagerModel*)model {
    for (FNStoreManagerGoodsSpecRowView *view in _rows) {
        [view removeFromSuperview];
    }
    [_rows removeAllObjects];
    
    
    _vTitle.lblName.text =  @"规格选项";
    _vTitle.lblPrice.text =  @"价格(元)";
    _vTitle.lblStock.text =  @"库存";
    self.hidden = YES;
    if (model) {
        self.hidden = NO;
        for (NSInteger index = 0; index < model.list.count; index++) {
            FNStoreManagerGoodsSpecRowView *view = [[FNStoreManagerGoodsSpecRowView alloc] init];
            [self.vContent addSubview: view];
            [_rows addObject:view];
            
            FNStoreGoodsSpecDataModel *spec = model.list[index];
            view.lblName.text =  spec.name;
            view.lblPrice.text =  spec.price;
            view.lblStock.text =  [spec.stock kr_isNotEmpty] ? spec.stock : @"不限制";
            
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                if (index == 0)
                    make.top.equalTo(self.vTitle.mas_bottom).offset(0);
                else
                    make.top.equalTo(_rows[index - 1].mas_bottom);
                make.left.equalTo(@22);
                make.right.equalTo(@-22);
                make.height.mas_equalTo(22);
                make.bottom.lessThanOrEqualTo(@-10);
            }];
        }
    }
}

@end
