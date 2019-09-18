//
//  FNcalendarPopDeView.h
//  THB
//
//  Created by Jimmy on 2018/12/27.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol FNcalendarPopDeViewDegate <NSObject>
// 选择日期
- (void)popSeletedDateClick:(NSString *)date;

- (void)popSeletedDateStyleClick:(NSDate *)date;

@end
@interface FNcalendarPopDeView : UIView

+ (void)showCalendarView;
@property(nonatomic ,weak) id<FNcalendarPopDeViewDegate> delegate;
//展示最小时间
-(instancetype)initWithFrame:(CGRect)frame withMinimumDate:(NSString*)date;
@end

NS_ASSUME_NONNULL_END
