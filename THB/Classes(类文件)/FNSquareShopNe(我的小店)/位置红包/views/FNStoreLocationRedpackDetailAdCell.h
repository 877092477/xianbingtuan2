//
//  FNStoreLocationRedpackDetailAdCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/29.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNStoreLocationRedpackDetailAdCell;
@protocol FNStoreLocationRedpackDetailAdCellDelegate <NSObject>

- (void)adCellDidClose: (FNStoreLocationRedpackDetailAdCell*)cell;

@end

@interface FNStoreLocationRedpackDetailAdCell : UICollectionViewCell

@property (nonatomic, weak) id<FNStoreLocationRedpackDetailAdCellDelegate> delegate;

@property (nonatomic, strong) UIImageView *imgAd;

@end

NS_ASSUME_NONNULL_END
