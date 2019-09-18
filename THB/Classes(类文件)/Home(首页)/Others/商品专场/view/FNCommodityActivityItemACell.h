//
//  FNCommodityActivityItemACell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYCyclePagerView.h"
#import "FNCommActivityItemHACell.h"
#import "FNBaseProductModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNCommodityActivityItemACellDelegate <NSObject>
// 点击更多
- (void)didCommodityActivityItemMoreAction:(NSIndexPath*)indexS;
- (void)didCommodityActivityItemGoodsAction:(FNBaseProductModel*)model;
@end
@interface FNCommodityActivityItemACell : UICollectionViewCell<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>

@property (nonatomic, strong)TYCyclePagerView* pagerView;
@property (nonatomic, strong)UIImageView   *bgImgView;
@property (nonatomic, strong)UIImageView   *topImgView;
@property (nonatomic ,weak) id<FNCommodityActivityItemACellDelegate> delegate;
@property (nonatomic, strong)NSIndexPath  *indexS;
@property (nonatomic, strong)NSArray* dataArr;
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
