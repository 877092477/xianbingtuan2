//
//  FNStoreManagerGoodsEmptyView.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/9.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNStoreManagerGoodsEmptyView;
@protocol FNStoreManagerGoodsEmptyViewDelegate <NSObject>

- (void)didAddClick: (FNStoreManagerGoodsEmptyView*)view;

@end

@interface FNStoreManagerGoodsEmptyView : UIView

@property (nonatomic,weak) id<FNStoreManagerGoodsEmptyViewDelegate> delegate;

@property (nonatomic, strong) UILabel *lblEmpty;
@property (nonatomic, strong) UIButton *btnAdd;
@end

NS_ASSUME_NONNULL_END
