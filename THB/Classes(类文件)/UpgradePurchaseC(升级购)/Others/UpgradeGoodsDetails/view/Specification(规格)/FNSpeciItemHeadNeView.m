//
//  FNSpeciItemHeadNeView.m
//  THB
//
//  Created by Jimmy on 2018/9/27.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNSpeciItemHeadNeView.h"

@implementation FNSpeciItemHeadNeView
#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    _headerLabel = [[UILabel alloc] init];
    _headerLabel.font  = kFONT14;
    [self addSubview:_headerLabel];
    
    
    _bottomView = [UIView new];
    _bottomView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
    [self addSubview:_bottomView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat DCMargin = 10;
    [_headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.centerY.mas_equalTo(self);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(DCMargin);
        make.right.mas_equalTo(-DCMargin);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - Setter Getter Methods
- (void)setHeadTitle:(FNUpGoodsAttrNModel *)headTitle
{
    _headTitle = headTitle;
    _headerLabel.text = headTitle.name;
}

@end
