//
//  FNUpgradeHeaderView.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/17.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNUpgradeHeaderView.h"

@implementation FNUpgradeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _imgHeader = [[UIImageView alloc] init];
    _lblName = [[UILabel alloc] init];
    _imgLevel = [[UIImageView alloc] init];
    _lblLevel = [[UILabel alloc] init];
    
    [self addSubview:_imgHeader];
    [self addSubview:_lblName];
    [self addSubview:_imgLevel];
    [self addSubview:_lblLevel];

    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.width.height.mas_equalTo(50);
        make.centerY.equalTo(@0);
    }];
    [_lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(10);
        make.centerY.equalTo(@0);
    }];
    [_imgLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblName.mas_right).offset(10);
        make.height.mas_equalTo(15);
        make.centerY.equalTo(@0);
    }];
    [_lblLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgLevel).offset(4);
        make.right.equalTo(self.imgLevel).offset(-4);
        make.centerY.equalTo(self.imgLevel);
    }];
    
    _imgHeader.layer.cornerRadius = 25;
    _imgHeader.layer.masksToBounds = YES;
    _imgHeader.layer.borderWidth = 2;
    _imgHeader.layer.borderColor = UIColor.whiteColor.CGColor;
    
    _lblName.font = [UIFont boldSystemFontOfSize:15];
    
    _lblLevel.font = [UIFont systemFontOfSize:9];
}

@end
