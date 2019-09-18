//
//  FNHomeSpecialView.h
//  THB
//
//  Created by jimmy on 2017/5/4.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuModel;
@interface FNHomeSpecialView : UIView
@property (nonatomic, strong)NSArray<MenuModel *>* specialArray;
@property (nonatomic, copy)void (^specialViewClicked) (NSInteger index);
@property (nonatomic, assign)BOOL timerHide;
@end

