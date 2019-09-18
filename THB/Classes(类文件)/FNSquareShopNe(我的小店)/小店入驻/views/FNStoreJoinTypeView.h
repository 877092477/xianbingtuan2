//
//  FNStoreJoinTypeView.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/20.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNStoreJoinTypeView;
@protocol FNStoreJoinTypeViewDelegate <NSObject>

- (void)typeView: (FNStoreJoinTypeView*)view didSelectAt: (NSInteger) index;

@end

@interface FNStoreJoinTypeView : UIView

@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, weak) id<FNStoreJoinTypeViewDelegate> delegate;

- (void)setTags: (NSArray<NSString*>*)tags isSelecteds: (NSArray<NSString*>*)isSeleteds;

@end

NS_ASSUME_NONNULL_END
