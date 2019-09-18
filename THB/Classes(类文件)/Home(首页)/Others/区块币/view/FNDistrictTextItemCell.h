//
//  FNDistrictTextItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNDistrictCoinModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNDistrictTextItemCell : UICollectionViewCell
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UIView   *lineView;
@property (nonatomic, strong)FNDistrictCoinModel *model;
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
