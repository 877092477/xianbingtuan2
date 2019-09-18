//
//  FNStoreGoodsSelectHeaderView.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/16.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNStoreGoodsSelectHeaderView;
@protocol FNStoreGoodsSelectHeaderViewDelegate <NSObject>

- (void)didAllClick: (FNStoreGoodsSelectHeaderView*)headerView;

@end

@interface FNStoreGoodsSelectHeaderView : UITableViewHeaderFooterView

@property (nonatomic, weak) id<FNStoreGoodsSelectHeaderViewDelegate> delegate;

@property (nonatomic, strong) UILabel *lblTitle;

- (void)setIsSelected: (BOOL)isSelected;

@end

NS_ASSUME_NONNULL_END
