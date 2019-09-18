//
//  FNNetCouponeRechargeCardCollectionCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNetCouponeRechargeCardCollectionCell.h"

@interface FNNetCouponeRechargeCardCollectionCell()

@end

@implementation FNNetCouponeRechargeCardCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _imgNormal = [[UIImageView alloc] init];
    _imgSelected = [[UIImageView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblPrice = [[UILabel alloc] init];
    
    [self.contentView addSubview:_imgNormal];
    [self.contentView addSubview:_imgSelected];
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_lblPrice];
    
    [_imgNormal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_imgSelected mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@4);
        make.right.lessThanOrEqualTo(@-4);
        make.top.equalTo(@20);
        make.centerX.equalTo(@0);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@4);
        make.right.lessThanOrEqualTo(@-4);
        make.bottom.equalTo(@-14);
        make.centerX.equalTo(@0);
    }];
    
    _lblTitle.font = kFONT15;
    _lblTitle.adjustsFontSizeToFitWidth = YES;
    _lblPrice.font = kFONT12;
    
    _imgSelected.hidden = YES;
    
}

- (void)setIsSelected:(BOOL)selected {
    _imgSelected.hidden = !selected;
    _imgNormal.hidden = selected;
}

@end
