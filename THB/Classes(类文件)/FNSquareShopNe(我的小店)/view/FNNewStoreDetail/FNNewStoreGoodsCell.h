//
//  FNNewStoreGoodsCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/24.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNNewStoreGoodsCell;
@protocol FNNewStoreGoodsCellDelegate <NSObject>

- (void)storeGoodsCelldidSubClick: (FNNewStoreGoodsCell*) cell;
- (void)storeGoodsCelldidAddClick: (FNNewStoreGoodsCell*) cell;

@end

@interface FNNewStoreGoodsCell : UICollectionViewCell

@property (nonatomic, weak) id<FNNewStoreGoodsCellDelegate> delegate;

- (void)setIsLeft: (BOOL)isLeft;

- (void)setModel: (FNStoreGoodsModel*)model;

@end

NS_ASSUME_NONNULL_END
