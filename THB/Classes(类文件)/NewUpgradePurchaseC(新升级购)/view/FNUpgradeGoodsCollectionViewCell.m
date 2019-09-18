//
//  FNUpgradeGoodsCollectionViewCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/18.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNUpgradeGoodsCollectionViewCell.h"

@interface FNUpgradeGoodsCollectionViewCell()


@end

@implementation FNUpgradeGoodsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _vContent = [[UIView alloc] init];
    _imgHeader = [[UIImageView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblPrice = [[UILabel alloc] init];
    _imgTag = [[UIImageView alloc] init];
    _imgButton = [[UIImageView alloc] init];
    _lblButton = [[UILabel alloc] init];
    
    [self.contentView addSubview:_vContent];
    [_vContent addSubview:_imgHeader];
    [_vContent addSubview:_lblTitle];
    [_vContent addSubview:_lblPrice];
    [_vContent addSubview:_imgTag];
    [_vContent addSubview:_imgButton];
    [_vContent addSubview:_lblButton];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(0, 10, 0, 0));
    }];
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@9);
        make.top.equalTo(@12);
        make.right.equalTo(@-12);
        make.height.mas_equalTo(135);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.right.lessThanOrEqualTo(@-12);
        make.top.equalTo(self.imgHeader.mas_bottom).offset(4);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.bottom.equalTo(self.imgButton.mas_top).offset(-14);
    }];
    [_imgTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblPrice.mas_right).offset(8);
        make.centerY.equalTo(self.lblPrice);
        make.right.lessThanOrEqualTo(@-12);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(0);
    }];
    [_imgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.bottom.equalTo(@-18);
        make.height.mas_equalTo(@27);
    }];
    [_lblButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.imgButton);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
    }];
    
    _vContent.layer.backgroundColor = UIColor.whiteColor.CGColor;
    _vContent.layer.cornerRadius = 9;
    
    _imgHeader.contentMode = UIViewContentModeScaleAspectFill;
    _imgHeader.layer.masksToBounds = YES;
    
    _lblTitle.font = [UIFont boldSystemFontOfSize:12];
    _lblTitle.textColor = RGB(32, 32, 36);
    _lblTitle.numberOfLines = 2;
    
    _lblPrice.font = [UIFont boldSystemFontOfSize:12];
    _lblPrice.textColor = RGB(241, 59, 55);
    
    _lblButton.font = [UIFont boldSystemFontOfSize:12];
    _lblButton.textColor = UIColor.whiteColor;
}

- (void) setButton: (NSString*)imageUrl {
    @weakify(self)
    [_imgButton sd_setImageWithURL:[NSURL URLWithString:imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (image) {
            
            [self.imgButton mas_updateConstraints: ^(MASConstraintMaker *make) {
                make.width.mas_equalTo(27 * image.size.width / image.size.height);
            }];
        }
    }];
}

- (void) setTag: (NSString*)imageUrl {
    @weakify(self)
    [_imgTag sd_setImageWithURL:[NSURL URLWithString:imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (image) {
            
            [self.imgTag mas_updateConstraints: ^(MASConstraintMaker *make) {
                make.width.mas_equalTo(13 * image.size.width / image.size.height);
            }];
        }
    }];
}

- (void) setIsLeft: (BOOL)isLeft {
    [_vContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(0, isLeft ? 10 : 0, 0, isLeft ? 0 : 10));
    }];
}
@end
