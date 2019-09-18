//
//  FNPromotionalNewCell.m
//  THB
//
//  Created by Weller Zhao on 2019/1/30.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNPromotionalNewCell.h"

@interface FNPromotionalNewCell()

@property (nonatomic, strong) UIImageView *imgIndex;
@property (nonatomic, strong) UILabel *lblIndex;

@property (nonatomic, strong) UIImageView *imgSales;
@property (nonatomic, strong) UILabel *lblSales;


@end

@implementation FNPromotionalNewCell

- (void)setViewType: (NSString*)type {
    _view_type = type;
    if ([NSString checkIsSuccess:type andElement:@"0"]) {
        [_imgIndex setHidden:YES];
        [_lblIndex setHidden:YES];
        [_imgSales setHidden:YES];
        [_lblSales setHidden:YES];
    } else {
        [_imgIndex setHidden:NO];
        [_lblIndex setHidden:NO];
        [_imgSales setHidden:NO];
        [_lblSales setHidden:NO];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    @weakify(self)
    _imgIndex = [[UIImageView alloc] init];
    [self.contentView addSubview:_imgIndex];
    [_imgIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@8);
    }];
    
    _lblIndex = [[UILabel alloc] init];
    [self.contentView addSubview:_lblIndex];
    [_lblIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self_weak_.imgIndex);
    }];
    
    _imgSales = [[UIImageView alloc] init];
    [self.contentView addSubview:_imgSales];
    [_imgSales mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.lessThanOrEqualTo(@0);
        make.bottom.equalTo(self_weak_.GoodsImage).offset(-30);
    }];
    
    _lblSales = [[UILabel alloc] init];
    [self.contentView addSubview:_lblSales];
    [_lblSales mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self_weak_.imgSales);
        make.left.equalTo(self_weak_.imgSales).offset(20);
        make.right.lessThanOrEqualTo(self_weak_.imgSales).offset(-20);
    }];
    
    _imgIndex.image = IMAGE(@"ranking_bj");
    
    _lblIndex.font = kFONT12;
    _lblIndex.textColor = FNWhiteColor;
    _lblIndex.textAlignment = NSTextAlignmentCenter;
    
    _imgSales.image = IMAGE(@"generalize_bj");
    
    _lblSales.font = kFONT10;
    _lblSales.textColor = FNGlobalTextGrayColor;
    
}

- (void)setModel:(FNBaseProductModel *)model{
    [super setModel:model];
    if (model == nil) {
        return;
    }
    if (![NSString isEmpty: model.px_id]) {
        self.lblIndex.text = model.px_id;
        self.imgIndex.hidden = NO;
    }else{
        self.imgIndex.hidden = YES;
    }
    self.lblSales.text = model.str_tg;
}

@end
