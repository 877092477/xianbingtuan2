//
//  FNJDFeaturedListCell.m
//  THB
//
//  Created by jimmy on 2017/5/24.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNJDFeaturedListCell.h"

@interface FNJDFeaturedListCell ()

@end
@implementation FNJDFeaturedListCell

#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    [super initializedSubviews];
    
    self.desLabel.textAlignment = NSTextAlignmentCenter;
    self.priceLabel.textAlignment = NSTextAlignmentRight;
    self.rebateLabel.textColor = FNMainGobalControlsColor;
    self.proImgView.cornerRadius = 5;
    //laytout
    [self.proImgView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.proImgView autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionWidth) ofView:self.proImgView];
    
    [self.desLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.proImgView withOffset: _jm_margin10];
    [self.desLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:5];
    [self.desLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:5];
    
    [self.priceLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:5];
    [self.priceLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.desLabel withOffset: _jm_margin10*0.5];
    [NSLayoutConstraint constraintWithItem:self.priceLabel attribute:(NSLayoutAttributeRight) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeCenterX) multiplier:1.0 constant:-5].active = YES;
    
    [self.rebateLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:5];
    [self.rebateLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.desLabel withOffset:5];
    
    [NSLayoutConstraint constraintWithItem:self.rebateLabel attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeCenterX) multiplier:1.0 constant:5].active = YES;
}
//class method: get cell instance
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNJDFeaturedListCell";
    FNJDFeaturedListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}
- (void)setModel:(FNBaseProductModel *)model{
    _model = model;
    if (_model) {
        [self.proImgView setUrlImg:_model.goods_img];
        self.desLabel.text = _model.goods_title;
        self.priceLabel.text = [NSString stringWithFormat:@"¥%@",_model.goods_price];
        self.rebateLabel.text = [NSString stringWithFormat:@" ¥%@",_model.fcommission];
        [self.rebateLabel addAttchmentImage:IMAGE(@"fan") andBounds:(CGRectMake(0, -3, 15, 15)) atIndex:0];
    }
}
@end
