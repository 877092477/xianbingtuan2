//
//  FNConnectionsHomeHeaderCell.m
//  THB
//
//  Created by Weller Zhao on 2019/1/14.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsHomeHeaderCell.h"

@interface FNConnectionsHomeHeaderCell()

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIButton *btnMore;

@end

@implementation FNConnectionsHomeHeaderCell


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.lblTitle = [[UILabel alloc] init];
    self.btnMore = [[UIButton alloc] init];
    
    [self.contentView addSubview:self.lblTitle];
    [self.contentView addSubview:self.btnMore];
    
    @weakify(self)
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@16);
        make.right.lessThanOrEqualTo(self_weak_.btnMore.mas_left).offset(-20);
    }];
    
    [self.btnMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(@-20);
//        make.width.mas_equalTo(
    }];
    
    self.lblTitle.textColor = UIColor.blackColor;
    self.lblTitle.font = [UIFont boldSystemFontOfSize:12];
    
    [self.btnMore setTitle:@"查看更多 >" forState:UIControlStateNormal];
    [self.btnMore setTitleColor:RGB(113, 113, 113) forState:UIControlStateNormal];
    self.btnMore.titleLabel.font = kFONT11;
    [self.btnMore addTarget:self action:@selector(onMoreClick)];
}

- (void)setTitle: (NSString*)title withMore: (NSString*)more {
    self.lblTitle.text = title;
    [self.btnMore setTitle:[NSString stringWithFormat:@"%@ >", more] forState:UIControlStateNormal];
    [self.btnMore setHidden:[more isEqualToString:@""]];
}

- (void)onMoreClick {
    if ([_delegate respondsToSelector:@selector(headerCelldidMoreSelected:)]) {
        [_delegate headerCelldidMoreSelected:self];
    }
}

@end
