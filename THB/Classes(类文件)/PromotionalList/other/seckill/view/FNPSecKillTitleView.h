//
//  FNPSecKillTitleView.h
//  THB
//
//  Created by Jimmy on 2017/12/25.
//  Copyright © 2017年 方诺科技. All rights reserved.
//
#import <UIKit/UIKit.h>
/**
 *  秒杀时间轴
 */
@class App_Miaosha_Time;
@interface FNPSecKillTitleView : UIScrollView
@property (nonatomic, copy) void (^clickedTimeAtIndex)(NSInteger index);
@property (nonatomic, strong)NSArray<App_Miaosha_Time *>* model;
- (instancetype)initWithFrame:(CGRect)frame ;
- (void)selectedTimeAtIndex:(NSInteger)index;
@end
