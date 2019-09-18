//
//  FNshopTendSlideNeCell.h
//  69橙子
//
//  Created by Jimmy on 2018/11/21.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "SDCycleScrollView.h"

@protocol FNshopTendSlideNeCellDelegate <NSObject>
// 点击轮播图
- (void)tendSlideClickAction:(NSInteger)sender;
@end

@interface FNshopTendSlideNeCell : UICollectionViewCell<SDCycleScrollViewDelegate>
/** 幻灯片 **/
@property (nonatomic, strong)SDCycleScrollView* bannerView;
/** Array **/
@property (nonatomic, strong)NSArray* bannerArray;

@property(nonatomic ,weak) id<FNshopTendSlideNeCellDelegate> delegate;
@end


