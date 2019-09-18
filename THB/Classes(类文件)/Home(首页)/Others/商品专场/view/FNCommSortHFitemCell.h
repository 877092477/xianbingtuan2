//
//  FNCommSortHFitemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNCommodityFieldModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNCommSortHFitemCell : UICollectionViewCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong)UIImageView   *bgImgView;
@property (nonatomic, strong)UIImageView   *stateImgView; 
@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)FNCommoditySortItemModel   *model;
@end

NS_ASSUME_NONNULL_END
