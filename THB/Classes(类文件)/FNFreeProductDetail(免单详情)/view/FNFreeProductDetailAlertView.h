//
//  FNFreeProductDetailAlertView.h
//  THB
//
//  Created by Weller on 2018/12/19.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNFreeProductDetailAlertView;
@protocol FNFreeProductDetailAlertViewDelegate <NSObject>

- (void)didAcceptClick: (FNFreeProductDetailAlertView*)view;
- (void)didLeaveClick: (FNFreeProductDetailAlertView*)view;

@end

@interface FNFreeProductDetailAlertView : UIView

@property (nonatomic, weak) id<FNFreeProductDetailAlertViewDelegate> delegate;


/**
 显示弹出框

 @param desc 文字
 @param closable 点击背景是否可关闭
 */
- (void)show: (NSString*)desc backgroundClosable: (BOOL)closable;

/**
 关闭弹出框
 */
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
