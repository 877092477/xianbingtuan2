//
//  FNNewConnenctionCateAlertView.h
//  新版嗨如意
//
//  Created by Weller on 2019/6/11.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//@class FNNewConnenctionCateAlertView;
//@protocol FNNewConnenctionCateAlertViewDelegate <NSObject>
//
//- (void)cateView: (FNNewConnenctionCateAlertView*)view didSelect: (NSInteger) index;
//
//@end

@interface FNNewConnenctionCateAlertView : UIView

typedef void(^ClickBlock)(NSInteger index);
typedef void(^CloseBlock)();

//@property (nonatomic, weak) id<FNNewConnenctionCateAlertViewDelegate> delegate;

+ (instancetype)sharedInstance;
- (void)showBelow: (UIView*)view titles: (NSArray<NSString*>*) titles block: (ClickBlock)block closeBlock: (CloseBlock)closeBlock;
- (void)setSelectedIndex: (NSInteger)index;

@end

NS_ASSUME_NONNULL_END
