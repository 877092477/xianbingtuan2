//
//  FNIntergralMailBottomView.h
//  THB
//
//  Created by Weller Zhao on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNIntergralMailBottomView;
@protocol FNIntergralMailBottomViewDelegate <NSObject>

- (void)didLeftClick: (FNIntergralMailBottomView*)view;
- (void)didCenterClick: (FNIntergralMailBottomView*)view;
- (void)didRightClick: (FNIntergralMailBottomView*)view;
- (void)didTipsClick: (FNIntergralMailBottomView*)view;


@end

@interface FNIntergralMailBottomView : UIView

@property (nonatomic, weak) id<FNIntergralMailBottomViewDelegate> delegate;

@property (nonatomic, strong) UIButton *btnLeft;
@property (nonatomic, strong) UIImageView *imgLeft;
@property (nonatomic, strong) UILabel* lblLeft;
@property (nonatomic, strong) UIButton *btnCenter;
@property (nonatomic, strong) UIButton *btnRight;

- (void)setTips: (NSString*)tips withTitleColor: (UIColor*)color backgroundColor: (UIColor*)bgColor isHidden: (BOOL)isHidden;
//- (void)setLeftButton: (NSString*)title withIcon: (NSString*)iconUrl titleColor: (UIColor*)titleColor backgroundColor: (UIColor*)bgColor;
//- (void)setRightButton: (NSString*)title withTitleColor: (UIColor*)titleColor backgroundColor: (UIColor*)bgColor isEnable: (BOOL)isEnable;

@end

NS_ASSUME_NONNULL_END
