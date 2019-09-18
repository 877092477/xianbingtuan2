//
//  FNLiveCouponeSearchHeaderReusableView.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNLiveCouponeSearchHeaderReusableView;
@protocol FNLiveCouponeSearchHeaderReusableViewDelegate <NSObject>

- (void)didClearClick: (FNLiveCouponeSearchHeaderReusableView*)view;

@end

@interface FNLiveCouponeSearchHeaderReusableView : UICollectionReusableView

@property (nonatomic, weak) id<FNLiveCouponeSearchHeaderReusableViewDelegate> delegate;

@property (nonatomic, strong) UILabel *lblTitle;
- (void)setTitle: (NSString*)title isClearShow: (BOOL)isShow;

@end

NS_ASSUME_NONNULL_END
