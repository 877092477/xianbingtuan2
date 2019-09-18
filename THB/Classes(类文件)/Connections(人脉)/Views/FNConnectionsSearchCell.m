//
//  FNConnectionsSearchCell.m
//  THB
//
//  Created by Weller Zhao on 2019/2/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsSearchCell.h"

@interface FNConnectionsSearchCell()

@end

@implementation FNConnectionsSearchCell

#define Padding 8

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
    [self addSubview:_imgHeader];
    
    @weakify(self)
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.greaterThanOrEqualTo(@Padding);
        make.right.bottom.lessThanOrEqualTo(@-Padding);
        make.width.mas_equalTo(self_weak_.imgHeader.mas_height);
        make.center.equalTo(@0);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imgHeader.cornerRadius = _imgHeader.bounds.size.height / 2;
}

@end
