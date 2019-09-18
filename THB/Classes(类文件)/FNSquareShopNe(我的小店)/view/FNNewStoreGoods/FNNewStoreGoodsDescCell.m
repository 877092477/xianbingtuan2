//
//  FNNewStoreGoodsDescCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/27.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStoreGoodsDescCell.h"

@implementation FNNewStoreGoodsDescCell

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
        make.top.equalTo(@12);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.right.lessThanOrEqualTo(@-20);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(14);
    }];
    
    self.backgroundColor = UIColor.whiteColor;
    
    _lblTitle.font = [UIFont boldSystemFontOfSize:17];
    _lblTitle.textColor = RGB(51, 51, 51);
    
    _lblDesc.font = kFONT12;
    _lblDesc.textColor = RGB(51, 51, 51);
    _lblDesc.numberOfLines = 0;
}

@end
