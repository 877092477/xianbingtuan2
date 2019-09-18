//
//  FNCashGiftCarouselNeCell.h
//  THB
//
//  Created by 李显 on 2018/10/15.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "FNGiftSeekHeNeModel.h"

@protocol FNCashGiftCarouselNeCellDelegate <NSObject>
/** 点击图片**/
- (void)CashGiftCarouselClickAction:(NSInteger)sender;
@end

@interface FNCashGiftCarouselNeCell : UICollectionViewCell<SDCycleScrollViewDelegate>

/** indexPath **/
@property (nonatomic, strong)NSIndexPath* indexPath;
/** 幻灯片 **/
@property (nonatomic, strong)SDCycleScrollView* bannerView;
/** delegate **/
@property(nonatomic ,weak) id<FNCashGiftCarouselNeCellDelegate> delegate;
/** Model **/
@property (nonatomic, strong)FNGiftSeekHeNeModel* model;
/** data **/
@property (nonatomic, strong)NSArray* bannerArray;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end
