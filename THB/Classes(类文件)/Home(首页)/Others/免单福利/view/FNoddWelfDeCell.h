//
//  FNoddWelfDeCell.h
//  THB
//
//  Created by Jimmy on 2018/12/18.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDCycleScrollView.h"
#import "FNwelfDeModel.h"


@protocol FNoddWelfDeCelllDegate <NSObject>

// 点击
- (void)oddWelfBannerClick:(FNwelfDeListItemModel*)model; 

@end

@interface FNoddWelfDeCell : UICollectionViewCell<SDCycleScrollViewDelegate>


/** 幻灯片 **/
@property (nonatomic, strong)SDCycleScrollView* bannerView;


@property (nonatomic, strong)FNwelfDeListItemModel* model;



@property (nonatomic, strong)NSArray* bannerArray;


@property(nonatomic ,weak) id<FNoddWelfDeCelllDegate> delegate;

@end


