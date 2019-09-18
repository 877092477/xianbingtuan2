//
//  FNstorePaveSlideNeCell.h
//  69橙子
//
//  Created by Jimmy on 2018/11/22.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDCycleScrollView.h"

@protocol FNstorePaveSlideNeCellDelegate <NSObject>

// 点击轮播图
- (void)storePaveSlideClickAction:(NSInteger)sender;

@end

@interface FNstorePaveSlideNeCell : UICollectionViewCell<SDCycleScrollViewDelegate>

/** 幻灯片 **/
@property (nonatomic, strong)SDCycleScrollView* bannerView;
/** Array **/
@property (nonatomic, strong)NSArray* bannerArray;
/** delegate **/
@property(nonatomic ,weak) id<FNstorePaveSlideNeCellDelegate> delegate;

@end
 
