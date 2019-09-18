//
//  FNDistrictDealitemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/30.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNDistrictCoinModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNDistrictDealitemCell : UICollectionViewCell
@property (nonatomic, strong)FNDistrictCoinBtnItemModel *model;
@property (nonatomic, strong)UIImageView   *bgImgView;
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
