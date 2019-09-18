//
//  FNArtcleTopSlideNCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYCyclePagerView.h"
#import "TYPageControl.h"
#import "FNartcleTopFuzzyImgCell.h"
#import "SDCycleScrollView.h"
#import "DRNRealTimeBlurView.h"
#import "FNArtcleTopStreamerNView.h"
#import "FNExpertSortNaNodel.h"
#import "NewPagedFlowView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNArtcleTopSlideNCellDelegate <NSObject>
// 点击轮播图
- (void)tendSlideClickAction:(NSInteger)sender;
@end
@interface FNArtcleTopSlideNCell : UICollectionViewCell<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate,NewPagedFlowViewDataSource, NewPagedFlowViewDelegate>

@property (nonatomic, strong)TYCyclePagerView* pagerView;

@property (nonatomic, strong)TYPageControl *pageControl;

@property (nonatomic, strong)NewPagedFlowView *pageFlowView; 

/** 磨砂view **/
@property (nonatomic, strong)DRNRealTimeBlurView* polishimg;

@property (nonatomic, strong)UIImageView   *bgImgView;
 
/** Array **/
@property (nonatomic, strong)FNExpertNaModel *dataModel;

/** 横幅 **/
@property (nonatomic, strong)FNArtcleTopStreamerNView* streamerNView;

@property (nonatomic ,weak) id<FNArtcleTopSlideNCellDelegate> delegate;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
