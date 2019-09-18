//
//  FNNewStoreGoodsRuleCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/27.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStoreGoodsRuleCell.h"

@interface FNNewStoreGoodsRuleCell()

@end

@implementation FNNewStoreGoodsRuleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_lblDesc];

    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.centerY.equalTo(@0);
        make.width.mas_equalTo(30);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblTitle.mas_right).offset(10);
        make.right.equalTo(@-20);
        make.centerY.equalTo(@0);
    }];
    
    self.backgroundColor = UIColor.whiteColor;
    
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = [UIFont boldSystemFontOfSize:14];
    
    _lblDesc.textColor = RGB(51, 51, 51);
    _lblDesc.font = kFONT13;
}

@end
