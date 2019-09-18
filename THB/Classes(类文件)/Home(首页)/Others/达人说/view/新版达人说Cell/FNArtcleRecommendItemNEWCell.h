//
//  FNArtcleRecommendItemNEWCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNExpertSortNaNodel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNArtcleRecommendItemNEWCellDelegate <NSObject>
// 点击头像或者名字
- (void)didRecommendItemNEWCellAction:(NSIndexPath*)indexS;
@end
@interface FNArtcleRecommendItemNEWCell : UICollectionViewCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong)UIImageView   *bgImgView;
@property (nonatomic, strong)UIImageView   *showImg;

@property (nonatomic, strong)UIImageView   *headImg;
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UILabel   *contentLB;
@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)UIButton  *checkBtn;
@property (nonatomic, strong)UIButton  *amountBtn;

@property (nonatomic, strong)FNEssayItemDModel *model;
 
@property (nonatomic, strong)NSIndexPath  *indexS;

@property (nonatomic ,weak) id<FNArtcleRecommendItemNEWCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
