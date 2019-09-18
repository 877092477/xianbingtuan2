//
//  FNdefineBannerTwoCell.h
//  THB
//
//  Created by Jimmy on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "FNDefiniteStoreNeModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNBannerTwoCellDelegate <NSObject>
// 点击
- (void)seletedBannerTwoClick:(FNDefiniteListItemModel*)model;
@end
@interface FNdefineBannerTwoCell : UICollectionViewCell<SDCycleScrollViewDelegate>
/** 幻灯片 **/
@property (nonatomic, strong)SDCycleScrollView* bannerView;

//@property (nonatomic, strong)FNwelfDeListItemModel* model;

@property (nonatomic, strong)NSArray* bannerArray;

@property(nonatomic ,weak) id<FNBannerTwoCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
