//
//  FNMaskBannerViewCell.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/5/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNComponentBaseCell.h"
#import "Index_huandengpian_01Model.h"

NS_ASSUME_NONNULL_BEGIN

@class FNMaskBannerViewCell;
@protocol FNMaskBannerViewCellDelegate <NSObject>

- (void)banner:(FNMaskBannerViewCell *)banner didScrollToIndex:(NSInteger)index percent: (CGFloat)percent;

@end

@interface FNMaskBannerViewCell : FNComponentBaseCell

@property (nonatomic, weak) id<FNMaskBannerViewCellDelegate> delegate;

#pragma mark - Model
@property (nonatomic, strong)Index_huandengpian_01Model* model;
@property (nonatomic, assign) NSTimeInterval time;

- (void)stopPlaying;
- (void)play;


#pragma mark- Array
@property (nonatomic, strong)NSArray* bannerArray;

#pragma mark- Block
@property (nonatomic, copy)void (^BannerClickedBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
