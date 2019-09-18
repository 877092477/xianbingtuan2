//
//  FNStoreGoodsSpecHeaderView.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreGoodsSpecManagerModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNStoreGoodsSpecHeaderView;
@protocol FNStoreGoodsSpecHeaderViewDelegate <NSObject>

- (void)didSpecHeaderClick: (FNStoreGoodsSpecHeaderView*)headerView;

@end

@interface FNStoreGoodsSpecHeaderView : UITableViewHeaderFooterView

@property (nonatomic, weak) id<FNStoreGoodsSpecHeaderViewDelegate> delegate;

- (void)setModel: (FNStoreGoodsSpecManagerModel*)model;
@end

NS_ASSUME_NONNULL_END
