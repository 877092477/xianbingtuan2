//
//  FNStoreGoodsSpecHeaderCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreGoodsSpecManagerModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNStoreGoodsSpecHeaderCell;
@protocol FNStoreGoodsSpecHeaderCellDelegate <NSObject>

- (void)cell: (FNStoreGoodsSpecHeaderCell*)cell didSpecClickAt: (NSInteger)index;
- (void)didAddClick: (FNStoreGoodsSpecHeaderCell*)cell;

@end

@interface FNStoreGoodsSpecHeaderCell : UITableViewCell

@property (nonatomic, weak) id<FNStoreGoodsSpecHeaderCellDelegate> delegate;


@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;

- (void)setSpecs: (NSArray<FNStoreGoodsSpecManagerModel*> *) specs;
- (void)setSelectAt: (NSInteger)index;

@end

NS_ASSUME_NONNULL_END
