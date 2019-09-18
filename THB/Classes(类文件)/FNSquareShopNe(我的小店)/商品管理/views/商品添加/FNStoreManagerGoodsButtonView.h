//
//  FNStoreManagerGoodsButtonView.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNStoreManagerGoodsButtonView;
@protocol FNStoreManagerGoodsButtonViewDelegate <NSObject>

- (void)onButtonViewTitleClick: (FNStoreManagerGoodsButtonView*)view;

@end

@interface FNStoreManagerGoodsButtonView : UIView

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;
@property (nonatomic, weak) id<FNStoreManagerGoodsButtonViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
