//
//  FNNewConnectionEmptyView.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/13.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewConnectionEmptyView.h"

@interface FNNewConnectionEmptyView()

@property (nonatomic, strong) UIImageView *imgEmpty;


@end

@implementation FNNewConnectionEmptyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    _imgEmpty = [[UIImageView alloc] init];
    [self addSubview: _imgEmpty];
    [_imgEmpty mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    
    _lblTitle = [[UILabel alloc] init];
    [self addSubview: _lblTitle];
    [_lblTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgEmpty.mas_bottom);
        make.centerX.equalTo(@0);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
    }];
    
    _imgEmpty.image = IMAGE(@"connection_image_empty");
    
    _lblTitle.textColor = RGB(153, 153, 153);
    _lblTitle.font = kFONT12;
    
    self.backgroundColor = UIColor.clearColor;
}


@end
