//
//  FNStoreManagerGoodsHeaderView.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/9.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNStoreManagerGoodsHeaderView;
@protocol FNStoreManagerGoodsHeaderViewDelegate <NSObject>

- (void)headerViewDidSortClick: (FNStoreManagerGoodsHeaderView*)headerView;

@end

@interface FNStoreManagerGoodsHeaderView : UITableViewHeaderFooterView

@property (nonatomic, weak) id<FNStoreManagerGoodsHeaderViewDelegate> delegate;

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIButton *btnSort;

@end

NS_ASSUME_NONNULL_END
