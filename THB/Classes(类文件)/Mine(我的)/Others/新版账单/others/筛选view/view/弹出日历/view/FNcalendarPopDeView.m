//
//  FNcalendarPopDeView.m
//  THB
//
//  Created by Jimmy on 2018/12/27.
//  Copyright © 2018 方诺科技. All rights reserved.
//
#define DEFAULT_MAX_HEIGHT  350
//SCREEN_WIDTH*0.8
//SCREEN_HEIGHT/3*2
/** 屏幕高度 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SELAnimationTimeInterval  0.6f
//屏幕适配
/**当前设备对应375的比例*/
#define Ratio_375 (SCREEN_WIDTH/375.0)
/**转换成当前比例的数*/
#define Ratio(x) ((int)((x) * Ratio_375))

#import "FNcalendarPopDeView.h"
#import "FSCalendar.h"
#import "NSDate+HXExtension.h"
@interface FNcalendarPopDeView()<FSCalendarDataSource,FSCalendarDelegate>

@property (weak, nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (weak, nonatomic) UIButton *previousButton;
@property (weak, nonatomic) UIButton *nextButton;
@property (strong, nonatomic) NSString *seletedDate;
@property (strong, nonatomic) NSDate *seletedTime;
@property (nonatomic, copy)NSString* minimumDate;
@end
@implementation FNcalendarPopDeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame withMinimumDate:(NSString*)date{
    if (self = [super initWithFrame:frame]) {
        self.minimumDate=date;
        [self setUpAllView];
    }
    return self;
}
+ (void)showCalendarView
{
    FNcalendarPopDeView *calendarView = [[FNcalendarPopDeView alloc]init];
    [[UIApplication sharedApplication].delegate.window addSubview:calendarView];
}
-(void)setUpAllView{

    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3/1.0];
    
    //bgView最大高度
    CGFloat maxHeight = DEFAULT_MAX_HEIGHT;
    
    //backgroundView
    UIView *bgView = [[UIView alloc]init];
    bgView.center = self.center;
    bgView.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self addSubview:bgView];
    //白色view
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT/2-maxHeight/2-50, SCREEN_WIDTH-40, maxHeight)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.masksToBounds = YES;
    whiteView.layer.cornerRadius = 4.0f;
    [bgView addSubview:whiteView];
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, whiteView.frame.size.width, maxHeight-50)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.appearance.headerMinimumDissolvedAlpha = 0;
    calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase;
    //calendar.appearance.weekdayTextColor = [UIColor blackColor];
    //calendar.appearance.headerTitleColor = [UIColor blackColor];
    calendar.appearance.selectionColor = RGB(255,90,0);
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    calendar.locale = locale;
    
    [whiteView addSubview:calendar];
    
    self.calendar = calendar;
    
    
    
    UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    previousButton.frame = CGRectMake(55, 5, 30, 30);
    previousButton.backgroundColor = [UIColor whiteColor];
    previousButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [previousButton setImage:[UIImage imageNamed:@"FJ_xz_img"] forState:UIControlStateNormal];
    [previousButton addTarget:self action:@selector(previousClicked:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:previousButton];
    self.previousButton = previousButton;
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(SCREEN_WIDTH-40-30-40-15, 5, 30, 30);
    nextButton.backgroundColor = [UIColor whiteColor];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextButton setImage:[UIImage imageNamed:@"FJ_xY_img"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:nextButton];
    self.nextButton = nextButton;
    
    //取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem]; 
    cancelButton.frame = CGRectMake(SCREEN_WIDTH-40-30-12.5, 5, 30, 30);
    [cancelButton setImage:[[UIImage imageNamed:@"FJ_CA_img"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:cancelButton];
    
    //取消按钮
    UIButton *cancelTwoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelTwoButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelTwoButton.frame = CGRectMake(SCREEN_WIDTH-40-65-62.5, maxHeight-50, 50, 50);
    cancelTwoButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [cancelTwoButton setTitleColor:RGB(200,200,200) forState:UIControlStateNormal];
    [cancelTwoButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:cancelTwoButton];
    
    //确定按钮
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    confirmButton.titleLabel.font=[UIFont systemFontOfSize:15];
    confirmButton.frame = CGRectMake(SCREEN_WIDTH-40-65, maxHeight-50, 50, 50);
    [confirmButton setTitleColor:RGB(255,90,0) forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:confirmButton];
    
    //显示
    [self showWithAlert:bgView];
}
//确定
-(void)confirmAction{
    if (self.seletedDate == nil) {
        NSDate *today = [NSDate dateWithTimeIntervalSinceNow: 0];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy/MM/dd";
        self.seletedDate=[formatter stringFromDate:today];
        
        NSDate *dayH = [NSDate dateWithTimeIntervalSinceNow: 0];
        self.seletedTime=dayH;
    }
    if ([self.delegate respondsToSelector:@selector(popSeletedDateClick:)]) {
        [self.delegate popSeletedDateClick:self.seletedDate];
    }
    if ([self.delegate respondsToSelector:@selector(popSeletedDateStyleClick:)]) {
        [self.delegate popSeletedDateStyleClick:self.seletedTime];
    }
    
    [self dismissAlert];
}
//上个月
- (void)previousClicked:(id)sender
{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *previousMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:previousMonth animated:YES];
}
//下个月
- (void)nextClicked:(id)sender
{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:nextMonth animated:YES];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date {
    NSLog(@"did select date %@",date);
}
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    NSLog(@"did select date %@",date);
    //设定时间格式,这里可以设置成自己需要的格式
    self.seletedDate=[date dateStringWithFormat:@"yyyy/MM/dd"];
    
    self.seletedTime=date;
    
    
}
- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr=@"";
    if([self.minimumDate kr_isNotEmpty]){
        dateStr=self.minimumDate;
    }else{
        dateStr=@"2000-01-01";
    }
    return [fmt dateFromString:dateStr];
}



#pragma mark - // 取消按钮点击事件
- (void)cancelAction
{
    [self dismissAlert];
}
#pragma mark - //添加Alert入场动画
- (void)showWithAlert:(UIView*)alert{
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = SELAnimationTimeInterval;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [alert.layer addAnimation:animation forKey:nil];
}
#pragma mark - // 添加Alert出场动画
- (void)dismissAlert{
    [UIView animateWithDuration:SELAnimationTimeInterval animations:^{
        self.transform = (CGAffineTransformMakeScale(1.5, 1.5));
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    } ];
    
}

@end
