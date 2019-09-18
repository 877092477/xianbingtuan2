//
//  FNStoreManagerGoodsFooterView.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/10.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNStoreManagerGoodsFooterView;
@protocol FNStoreManagerGoodsFooterViewDelegate <NSObject>

- (void)footerViewDidAddClick: (FNStoreManagerGoodsFooterView*)headerView;

@end

@interface FNStoreManagerGoodsFooterView : UITableViewHeaderFooterView

@property (nonatomic, weak) id<FNStoreManagerGoodsFooterViewDelegate> delegate;
@property (nonatomic, strong) UIButton *btnAdd;

@end

NS_ASSUME_NONNULL_END
