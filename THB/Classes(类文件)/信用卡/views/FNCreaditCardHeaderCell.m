//
//  FNCreaditCardHeaderCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/20.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNCreaditCardHeaderCell.h"

@interface FNCreaditCardHeaderCell()

@property (nonatomic, strong) UIView *vLine;

@end

@implementation FNCreaditCardHeaderCell

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
    
    _imgIcon = [[UIImageView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _vLine = [[UIView alloc] init];
    
    [self addSubview:_imgIcon];
    [self addSubview:_lblTitle];
    [self addSubview:_vLine];
    
    [_imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@8);
        make.width.height.mas_equalTo(24);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgIcon.mas_right).offset(0);
        make.right.lessThanOrEqualTo(@-20);
        make.centerY.equalTo(@0);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = [UIFont boldSystemFontOfSize:15];
    
    _vLine.backgroundColor = RGB(240, 240, 240);
}

@end
