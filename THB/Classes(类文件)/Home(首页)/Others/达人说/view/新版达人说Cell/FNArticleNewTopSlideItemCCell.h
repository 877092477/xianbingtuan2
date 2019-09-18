//
//  FNArticleNewTopSlideItemCCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNExpertSortNaNodel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNArticleNewTopSlideItemCCell : UICollectionViewCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic, strong)UIImageView   *bgImgView;
@property (nonatomic, strong)UIImageView   *showImg; 
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UILabel   *contentLB;
@property (nonatomic, strong)FNEssayItemDModel *model;
@end

NS_ASSUME_NONNULL_END
