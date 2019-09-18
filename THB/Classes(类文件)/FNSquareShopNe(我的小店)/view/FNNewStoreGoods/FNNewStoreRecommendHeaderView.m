//
//  FNNewStoreRecommendHeaderView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/6.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStoreRecommendHeaderView.h"

@implementation FNNewStoreRecommendHeaderView

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
        make.center.equalTo(@0);
    }];
    
    _lblTitle.font = kFONT17;
    _lblTitle.textColor = RGB(102, 102, 102);
}

@end
