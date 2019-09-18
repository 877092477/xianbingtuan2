//
//  FNarticleRecommendItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNArticleDeailsXModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNarticleRecommendItemCellDelegate <NSObject>
// 点击头像或者名字
- (void)didArticleRecommendHeadItemAction:(NSIndexPath*)indexS;
@end
@interface FNarticleRecommendItemCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *bgImgView;
@property (nonatomic, strong)UIImageView   *showImg;
@property (nonatomic, strong)UIImageView   *headImg;
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)UIButton  *checkBtn;
@property (nonatomic, strong)UIButton  *likeBtn;
@property (nonatomic, strong)FNArticleItemXModel  *model;

@property (nonatomic ,weak) id<FNarticleRecommendItemCellDelegate> delegate;
@property (nonatomic, strong)NSIndexPath  *indexS;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
