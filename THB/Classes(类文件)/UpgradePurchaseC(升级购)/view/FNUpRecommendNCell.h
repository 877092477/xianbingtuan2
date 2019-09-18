//
//  FNUpRecommendNCell.h
//  THB
//
//  Created by Jimmy on 2018/9/25.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNUpgradeNMode.h"

@interface FNUpRecommendNCell : UICollectionViewCell
/** 商品图片 **/
@property (nonatomic, strong)UIImageView* GoodsImage;

/** 商品标题 **/
@property (nonatomic, strong)UILabel* GoodsTitleLabel;

/** 原价 **/
@property (nonatomic, strong)UILabel* originPriceLabel;

@property (nonatomic, strong)FNRecommendNMode* model;

@property (nonatomic, strong)NSIndexPath* indexPath;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end
