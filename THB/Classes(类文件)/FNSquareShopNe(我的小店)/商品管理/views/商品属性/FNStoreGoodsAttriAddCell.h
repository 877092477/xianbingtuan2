//
//  FNStoreGoodsAttriAddCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/13.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreGoodsSpecManagerModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNStoreGoodsAttriAddCell;
@protocol FNStoreGoodsAttriAddCellDelegate <NSObject>

- (void)cell: (FNStoreGoodsAttriAddCell*)cell didAttriClickAt: (NSInteger)index;
- (void)didAddAttriClick: (FNStoreGoodsAttriAddCell*)cell;


@end

@interface FNStoreGoodsAttriAddCell : UITableViewCell

@property (nonatomic, weak) id<FNStoreGoodsAttriAddCellDelegate> delegate;

- (void)setTitles: (NSArray<NSString*> *) titles;

- (void)setSelections: (NSArray<NSString*> *)selections;

@end

NS_ASSUME_NONNULL_END
