//
//  FNLiveCouponeSpecialView.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MenuModel;
@interface FNLiveCouponeSpecialView : UIView
@property (nonatomic, strong)NSArray<MenuModel *>* specialArray;
@property (nonatomic, copy)void (^specialViewClicked) (NSInteger index);
@property (nonatomic, assign)BOOL timerHide;
@end

NS_ASSUME_NONNULL_END
