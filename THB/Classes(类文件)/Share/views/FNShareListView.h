//
//  FNShareListView.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/4.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNShareListView;
@protocol FNShareListViewDelegate <NSObject>

- (void)shareListView: (FNShareListView*)view didClickAt: (NSInteger) index;

@end

@interface FNShareListView : UIView

@property (nonatomic, weak) id<FNShareListViewDelegate> delegate;

- (void)setImages: (NSArray<NSString*>*) images withTitles: (NSArray<NSString*>*) titles ;

@end

NS_ASSUME_NONNULL_END
