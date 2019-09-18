//
//  FNNetCouponeRechargeHeaderCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNetCouponeRechargeHeaderCell.h"

@implementation FNNetCouponeRechargeHeaderCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        _lblTitle = [[UILabel alloc] init];
        _lblTitle.textColor = RGB(48, 52, 59);
        _lblTitle.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:_lblTitle];
        [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.right.lessThanOrEqualTo(@-20);
            make.centerY.equalTo(@0);
        }];
    }
    return self;
}

@end
