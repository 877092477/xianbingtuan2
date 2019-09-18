//
//  FNCommodityRecommendCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYCyclePagerView.h"
#import "FNCommodityLRslideItemCell.h"
#import "FNBaseProductModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNCommodityRecommendCellDelegate <NSObject>
// 点击切换的商品
- (void)didCommodityRecommendItemAction:(FNBaseProductModel*)model;
- (void)didCommodityRecommendShareGoodsAction:(FNBaseProductModel*)model;
@end
@interface FNCommodityRecommendCell : UICollectionViewCell<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)TYCyclePagerView* pagerView;
@property (nonatomic, weak) id<FNCommodityRecommendCellDelegate> delegate;
@property (nonatomic, strong)NSArray* dataArr;
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
