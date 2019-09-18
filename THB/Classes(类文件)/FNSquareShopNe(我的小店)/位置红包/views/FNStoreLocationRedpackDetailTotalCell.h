//
//  FNStoreLocationRedpackDetailTotalCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/28.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreLocationRedpackReceiveDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNStoreLocationRedpackDetailTotalCell;
@protocol FNStoreLocationRedpackDetailTotalCellDelegate <NSObject>

- (void) didTotalCellMoreClick: (FNStoreLocationRedpackDetailTotalCell*)cell;

@end

@interface FNStoreLocationRedpackDetailTotalCell : UICollectionViewCell

@property (nonatomic, weak) id<FNStoreLocationRedpackDetailTotalCellDelegate> delegate;

- (void)setModel: (FNStoreLocationRedpackReceiveDetailModel*)model;

@end

NS_ASSUME_NONNULL_END
