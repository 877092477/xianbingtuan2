//
//  OrderHeaderView.h
//  THB
//
//  Created by Weller Zhao on 2018/12/26.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class OrderHeaderView;
@protocol OrderHeaderViewDelegate <NSObject>

- (void)didStartTimeClick: (OrderHeaderView*) headerView;
- (void)didEndTimeClick: (OrderHeaderView*) headerView;

@end

@interface OrderHeaderView : UIView

@property (nonatomic, strong) UILabel *lblOrder;

@property (nonatomic, strong) UIButton *screenBtn;

@property (nonatomic, copy, setter=setStartTime:) NSString *startTime;
@property (nonatomic, copy, setter=setEndTime:) NSString *endTime;

@property (nonatomic, copy, setter=setJointTime:) NSString *jointTime;

@property (nonatomic, weak) id<OrderHeaderViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
