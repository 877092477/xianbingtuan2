//
//  FNStoreGoodsSpecAddCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNStoreGoodsSpecAddCell;
@protocol FNStoreGoodsSpecAddCellDelegate <NSObject>

- (void)cellDidDeleteClick: (FNStoreGoodsSpecAddCell*)cell;

@end

@interface FNStoreGoodsSpecAddCell : UITableViewCell

- (void)setModel: (FNStoreGoodsSpecDataModel*)model;

@property (nonatomic, strong) UIButton *btnDelete;
@property (nonatomic, weak) id<FNStoreGoodsSpecAddCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
