//
//  FNCreaditCardDetailHeaderCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/21.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNCreaditCardDetailHeaderCell.h"

@interface FNCreaditCardDetailHeaderCell()

@property (nonatomic, strong) UIView *vLine1;
@property (nonatomic, strong) UIView *vLine2;

@end

@implementation FNCreaditCardDetailHeaderCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    self.backgroundView = ({
        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = UIColor.whiteColor;
        view;
    });
    
    _vLine1 = [[UIImageView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _vLine2 = [[UIView alloc] init];
    
    [self addSubview:_vLine1];
    [self addSubview:_lblTitle];
    [self addSubview:_vLine2];
    
    [_vLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@16);
        make.width.mas_equalTo(4);
        make.height.mas_equalTo(20);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vLine1.mas_right).offset(8);
        make.right.lessThanOrEqualTo(@-20);
        make.centerY.equalTo(@0);
    }];
    [_vLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = [UIFont boldSystemFontOfSize:15];
    
    _vLine1.backgroundColor = RGB(51, 51, 51);
    _vLine1.cornerRadius = 2;
    
    _vLine2.backgroundColor = RGB(240, 240, 240);
}

@end
