//
//  FNVideoCardBuyHeader.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNVideoCardBuyHeader;
@protocol FNVideoCardBuyHeaderDelegate <NSObject>

- (void)header: (FNVideoCardBuyHeader*)header didItemSelectedAt: (NSInteger)index;

@end

@interface FNVideoCardBuyHeader : UIView
@property (nonatomic, strong) UIImageView *imgHeader;

@property (nonatomic, weak) id<FNVideoCardBuyHeaderDelegate> delegate;

- (void)setHeaders: (NSArray*)titles withPrices: (NSArray*)prices andOPrices: (NSArray*)oPrices;
- (void)selectItem: (NSInteger)index;

@end

NS_ASSUME_NONNULL_END
