//
//  FNLiveCouponeCatCell.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SliderControl.h"

NS_ASSUME_NONNULL_BEGIN

@class FNLiveCouponeStoreCell;
@protocol FNLiveCouponeCatCellDelegate <NSObject>

- (void)cell: (FNLiveCouponeStoreCell*)cell didItemSelectedAt: (NSInteger)index;

@end

@interface FNLiveCouponeCatCell : UICollectionViewCell

@property (nonatomic, strong) SliderControl *slider;

@property (nonatomic, weak) id<FNLiveCouponeCatCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
