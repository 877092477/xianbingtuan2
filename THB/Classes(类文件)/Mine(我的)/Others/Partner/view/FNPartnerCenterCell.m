//
//  FNPartnerCenterCell.m
//  SuperMode
//
//  Created by jimmy on 2017/10/16.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPartnerCenterCell.h"

@implementation FNPartnerCenterCell
- (UIImageView *)iconimgview{
    if (_iconimgview == nil) {
        _iconimgview = [UIImageView new];
    }
    return _iconimgview;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = kFONT14;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.textAlignment  =NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UILabel *)subLabel{
    if (_subLabel == nil) {
        _subLabel =[UILabel new];
        _subLabel.font = kFONT12;
        _subLabel.textColor  = FNGlobalTextGrayColor;
        _subLabel.adjustsFontSizeToFitWidth = YES;
        _subLabel.textAlignment  =NSTextAlignmentCenter;
    }
    return _subLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    [self.contentView addSubview:self.iconimgview];
    [self.iconimgview autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    [self.iconimgview autoConstrainAttribute:ALEdgeBottom toAttribute:ALAxisHorizontal ofView:self.contentView];
    [self.iconimgview autoSetDimensionsToSize:(CGSizeMake(40, 40))];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
    [self.titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
    [self.titleLabel autoConstrainAttribute:ALEdgeTop toAttribute:ALAxisHorizontal ofView:self.contentView withOffset:_jmsize_10];
    
    [self.contentView addSubview:self.subLabel];
    [self.subLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
    [self.subLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
    [self.subLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.titleLabel withOffset:5];
    
}
//class method: get cell instance
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNPartnerCenterCell";
    FNPartnerCenterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}

@end
