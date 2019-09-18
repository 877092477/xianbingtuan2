//
//  FNArtcleAroundSlideCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYCyclePagerView.h"
#import "FNArticleNewTopSlideItemCCell.h"
#import "FNExpertSortNaNodel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNArtcleAroundSlideCellDelegate <NSObject>
// 点击横向滚动
- (void)tendAroundSlideCellAction:(NSInteger)index;
@end
@interface FNArtcleAroundSlideCell : UICollectionViewCell<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic, strong)UIImageView   *bgImgView;
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)TYCyclePagerView* pagerView;
@property (nonatomic, strong)FNExpertNaModel *dataModel;
@property (nonatomic ,weak) id<FNArtcleAroundSlideCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
