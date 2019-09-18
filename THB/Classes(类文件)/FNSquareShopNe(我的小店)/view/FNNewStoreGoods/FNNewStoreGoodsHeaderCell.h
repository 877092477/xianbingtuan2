//
//  FNNewStoreGoodsHeaderCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/26.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreGoodsDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNNewStoreGoodsHeaderCell;
@protocol FNNewStoreGoodsHeaderCellDelegate <NSObject>

- (void) goodsCellDidSubClick: (FNNewStoreGoodsHeaderCell*)cell;
- (void) goodsCellDidAddClick: (FNNewStoreGoodsHeaderCell*)cell;

- (void) goodsCellDidBuyClick: (FNNewStoreGoodsHeaderCell*)cell;
- (void) goodsCellDidShareClick: (FNNewStoreGoodsHeaderCell*)cell;

@end

@interface FNNewStoreGoodsHeaderCell : UICollectionViewCell

@property (nonatomic, weak) id<FNNewStoreGoodsHeaderCellDelegate> delegate;

- (void)setModel: (FNStoreGoodsDetailModel*)model;

@end

NS_ASSUME_NONNULL_END
