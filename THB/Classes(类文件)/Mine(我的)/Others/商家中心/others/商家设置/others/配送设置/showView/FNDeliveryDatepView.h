//
//  FNDeliveryDatepView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSHPopupContainer.h"
#import "PGDatePicker.h"
#import "PGPickerView.h"
#import "NSDate+HXExtension.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNDeliveryDatepViewDelegate <NSObject>
// 选择的时间
- (void)inDateConfirmActionWithContent:(NSString*)start withContent:(NSString*)end;

@end
@interface FNDeliveryDatepView : UIView<DSHCustomPopupView,PGDatePickerDelegate>
@property (nonatomic, strong)UIButton  *leftBtn;
@property (nonatomic, strong)UIButton  *rightBtn;
@property (nonatomic, strong)PGDatePicker *startDatePicker;
@property (nonatomic, strong)PGDatePicker *endDatePicker;
@property (nonatomic, strong)PGPickerView *packView;
@property (nonatomic, strong)NSString *startDate;
@property (nonatomic, strong)NSString *endDate;
@property (nonatomic, weak)id<FNDeliveryDatepViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
