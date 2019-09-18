//
//  FNStoreBottomView.h
//  新版嗨如意
//
//  Created by Weller on 2019/6/20.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNStoreBottomView;
@protocol FNStoreBottomViewDelegate <NSObject>

- (void)didCarClick: (FNStoreBottomView*)view;
- (void)didPayClick: (FNStoreBottomView*)view;

@end

@interface FNStoreBottomView : UIView

@property (nonatomic, weak) id<FNStoreBottomViewDelegate> delegate;

- (void)setCount: (NSString*)count withPrice: (NSString*)price canBuy:(BOOL) canBuy payTitle: (NSString*)payTitle;

@end

NS_ASSUME_NONNULL_END
