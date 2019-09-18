//
//  FNBannerViewCell.h
//  THB
//
//  Created by zhongxueyu on 2018/8/20.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNComponentBaseCell.h"
#import "SDCycleScrollView.h"
#import "Index_huandengpian_01Model.h"
@interface FNBannerViewCell : FNComponentBaseCell<SDCycleScrollViewDelegate>
#pragma mark- Views
/** 幻灯片 **/
@property (nonatomic, strong)SDCycleScrollView* bannerView;

#pragma mark - Model
@property (nonatomic, strong)Index_huandengpian_01Model* model;


#pragma mark- Array
@property (nonatomic, strong)NSArray* bannerArray;

#pragma mark- Block
@property (nonatomic, copy)void (^BannerClickedBlock)(NSInteger index);

@end
