//
//  FNUpgradeTwoCollectionViewCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/18.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNUpgradeTwoCollectionViewCell.h"

@interface FNUpgradeTwoCollectionViewCell()


@end

@implementation FNUpgradeTwoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _imgLeft = [[UIImageView alloc] init];
    _imgRight = [[UIImageView alloc] init];
    
    [self.contentView addSubview:_imgLeft];
    [self.contentView addSubview:_imgRight];
    
    [_imgLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(self.contentView.mas_centerX);
        make.top.bottom.equalTo(@0);
    }];
    [_imgRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.left.equalTo(self.contentView.mas_centerX);
        make.top.bottom.equalTo(@0);
    }];
    
    @weakify(self);
    [_imgLeft addJXTouch:^{
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(didLeftClick:)]) {
            [self.delegate didLeftClick:self];
        }
    }];
    [_imgRight addJXTouch:^{
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(didRightClick:)]) {
            [self.delegate didRightClick:self];
        }
    }];
    
}

- (void)setJiange: (CGFloat)jiange {
    [_imgLeft mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-jiange));
    }];
    [_imgRight mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-jiange));
    }];
}

@end
