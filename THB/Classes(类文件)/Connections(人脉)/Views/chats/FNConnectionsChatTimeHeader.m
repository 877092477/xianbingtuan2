//
//  FNConnectionsChatTimeHeader.m
//  THB
//
//  Created by Weller Zhao on 2019/1/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsChatTimeHeader.h"

@interface FNConnectionsChatTimeHeader()

@property (nonatomic, strong) UILabel *lblTime;

@end

@implementation FNConnectionsChatTimeHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    UIView *vContentView = [[UIView alloc] init];
    vContentView.backgroundColor = UIColor.clearColor;
    self.backgroundView = vContentView;
    
    _lblTime = [[UILabel alloc] init];
    [self.contentView addSubview:_lblTime];
    [_lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
    }];
    
    _lblTime.textColor = RGB(255, 51, 153);
    _lblTime.font = kFONT12;
}

- (void)setTime: (NSString*)time {
    _lblTime.text = time;
}

@end
