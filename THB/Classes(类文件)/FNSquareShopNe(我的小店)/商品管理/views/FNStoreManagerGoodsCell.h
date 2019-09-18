//
//  FNStoreManagerGoodsCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/9.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreManagerGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNStoreManagerGoodsCell;
@protocol FNStoreManagerGoodsCellDelegate <NSObject>

- (void) cellDidEditClick: (FNStoreManagerGoodsCell*)cell;
- (void) cellDidUpClick: (FNStoreManagerGoodsCell*)cell;
- (void) cellDidDownClick: (FNStoreManagerGoodsCell*)cell;

@end

@interface FNStoreManagerGoodsCell : UITableViewCell

@property (nonatomic, weak) id<FNStoreManagerGoodsCellDelegate> delegate;

- (void) setModel: (FNStoreManagerGoodsModel*)model;
- (void) setEditable: (BOOL)editable upable: (BOOL)upable downable: (BOOL)downable;

@end

NS_ASSUME_NONNULL_END
