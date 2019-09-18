//
//  FNLiveCouponeBannerCell.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "Index_huandengpian_01Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNLiveCouponeBannerCell : UICollectionViewCell
#pragma mark- Views
/** 幻灯片 **/
@property (nonatomic, strong)SDCycleScrollView* bannerView;

#pragma mark - Model
@property (nonatomic, strong)Index_huandengpian_01Model* model;


- (void)setBannerArray:(NSArray *)bannerArray withHeight: (CGFloat)height speed: (CGFloat)speed;

#pragma mark- Block
@property (nonatomic, copy)void (^BannerClickedBlock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
