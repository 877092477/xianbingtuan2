//
//  FNNewStoreDetailCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/6/20.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNstoreInformationDaModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNNewStoreDetailCell;
@protocol FNNewStoreDetailCellDelegate <NSObject>

- (void)cell:(FNNewStoreDetailCell*)cell didImageClickAt: (NSInteger) index;
- (void)cellDidLocationClick: (FNNewStoreDetailCell*)cell;
- (void)cellDidCallClick: (FNNewStoreDetailCell*)cell;
- (void)cellDidPayClick: (FNNewStoreDetailCell*)cell;

@end

@interface FNNewStoreDetailCell : UICollectionViewCell

@property (nonatomic, weak) id<FNNewStoreDetailCellDelegate> delegate;

- (void)setModel: (FNstoreInformationDaModel*)model;

@end

NS_ASSUME_NONNULL_END
