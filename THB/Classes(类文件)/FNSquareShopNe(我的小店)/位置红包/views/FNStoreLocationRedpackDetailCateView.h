//
//  FNStoreLocationRedpackDetailCateView.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/29.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreLocationRedpackReceiveDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNStoreLocationRedpackDetailCateView;
@protocol FNStoreLocationRedpackDetailCateViewDelegate <NSObject>

- (void) cateView: (FNStoreLocationRedpackDetailCateView*)cateView didItemSelectedAt: (NSInteger)index;

@end

@interface FNStoreLocationRedpackDetailCateView : UICollectionReusableView

@property (nonatomic, weak) id<FNStoreLocationRedpackDetailCateViewDelegate> delegate;

- (void)setModel: (FNStoreLocationRedpackReceiveDetailModel*)model;
- (void) setSelectedAt: (NSInteger) index;

@end

NS_ASSUME_NONNULL_END
