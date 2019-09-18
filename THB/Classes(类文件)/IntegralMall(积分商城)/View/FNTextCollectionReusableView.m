//
//  FNTextCollectionReusableView.m
//  THB
//
//  Created by Weller Zhao on 2019/1/7.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNTextCollectionReusableView.h"

@interface FNTextCollectionReusableView()

@property (nonatomic, strong) UILabel* lblTitle;

@end

@implementation FNTextCollectionReusableView

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
    [self addSubview:_lblTitle];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.greaterThanOrEqualTo(@10);
        make.bottom.lessThanOrEqualTo(@-10);
        make.centerY.equalTo(@0);
    }];
    
    _lblTitle.font = kFONT14;
    _lblTitle.textColor = RGB(24, 24, 24);
}

- (void)setTitle: (NSString*)title {
    _lblTitle.text = title;
}

@end
