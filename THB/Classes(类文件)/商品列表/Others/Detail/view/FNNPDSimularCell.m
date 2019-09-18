//
//  FNNPDSimularCell.m
//  THB
//
//  Created by Jimmy on 2017/12/16.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNNPDSimularCell.h"
@interface FNNPDSimularCell()
@property (nonatomic, strong)UIImageView* imgview;
@property (nonatomic, strong)UILabel* couponLabel;
@property (nonatomic, strong)UILabel* desLabel;
@property (nonatomic, strong)UIImageView* priceimgview;
@property (nonatomic, strong)UILabel* priceLabel;
@end
@implementation FNNPDSimularCell
- (UIImageView *)imgview{
    if (_imgview == nil) {
        _imgview = [UIImageView new];
        [_imgview addSubview:self.couponLabel];
        [self.couponLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [self.couponLabel autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];
        [self.couponLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_imgview withMultiplier:0.7 relation:(NSLayoutRelationLessThanOrEqual)];
        [self.couponLabel autoSetDimension:(ALDimensionHeight) toSize:18];
        
    }
    return _imgview;
}
- (UILabel *)couponLabel{
    if (_couponLabel == nil) {
        _couponLabel = [UILabel new];
        _couponLabel.font = kFONT12;
        _couponLabel.textColor = FNMainGobalControlsColor;
        _couponLabel.adjustsFontSizeToFitWidth = YES;
        _couponLabel.textAlignment = NSTextAlignmentCenter;
        _couponLabel.borderColor = FNMainGobalControlsColor;
        _couponLabel.borderWidth = 1;
        _couponLabel.backgroundColor = FNWhiteColor;
        _couponLabel.cornerRadius = 3;
    }
    return _couponLabel;
}
- (UILabel *)desLabel{
    if (_desLabel == nil) {
        _desLabel = [UILabel new];
        _desLabel.font = kFONT14;
        _desLabel.numberOfLines = 2;
        
    }
    return _desLabel;
}
- (UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [UILabel new];
        _priceLabel.font = [UIFont boldSystemFontOfSize:14];
        _priceLabel.textColor = FNMainGobalControlsColor;
        _priceLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _priceLabel;
}

- (UIImageView *)priceimgview{
    if (_priceimgview == nil) {
        _priceimgview = [UIImageView new];
        _priceimgview.size = IMAGE(@"list_after_quan").size;
    }
    return _priceimgview;
}
- (void)jm_setupViews{
    [self.contentView addSubview:self.imgview];
    [self.imgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.imgview autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionHeight) ofView:self.imgview];
    
    [self.contentView addSubview:self.desLabel];
    [self.desLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.imgview];
    [self.desLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self.imgview];
    [self.desLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.imgview withOffset:5];
    
    [self.contentView addSubview:self.priceimgview];
    [self.priceimgview autoSetDimensionsToSize:self.priceimgview.size];
    [self.priceimgview autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.imgview];
    [self.priceimgview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.desLabel withOffset:5];
    
    [self.contentView addSubview:self.priceLabel];
//    [self.priceLabel autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:_jmsize_10];
    [self.priceLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.priceimgview withOffset:5];
    [self.priceLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:self.contentView withMultiplier:0.6];
    [self.priceimgview autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.priceLabel];
    
}


//class method: get cell instance
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNNPDSimularCell";
    FNNPDSimularCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    return cell;
}

- (void)setModel:(FNBaseProductModel *)model{
    _model = model;
    if (_model) {
        [self.imgview setUrlImg:self.model.goods_img];
        
        self.couponLabel.text = [NSString stringWithFormat:@"  %@  ",self.model.yhq_span];
        self.couponLabel.hidden = !self.model.yhq.boolValue;
        
        self.desLabel.text = self.model.goods_title;
        
        self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",self.model.goods_price.floatValue];
        [self.priceimgview setUrlImg:self.model.goods_ico_one];
        
    }
}
@end
