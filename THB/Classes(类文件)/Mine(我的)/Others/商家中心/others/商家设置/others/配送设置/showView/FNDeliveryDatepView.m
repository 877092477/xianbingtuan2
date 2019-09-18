//
//  FNDeliveryDatepView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNDeliveryDatepView.h"

@implementation FNDeliveryDatepView

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        [self initializedSubviews];
    } return self;
}
// 准备弹出(初始化弹层位置)
- (void)willPopupContainer:(DSHPopupContainer *)container; {
    CGRect frame = self.frame;
    frame.size = CGSizeMake(FNDeviceWidth-50, 288);
    frame.origin.x = 25;
    frame.origin.y = container.frame.size.height/2-144;
    self.frame = frame;
}

// 已弹出(做弹出动画)
- (void)didPopupContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.6f;//0.6f;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.layer addAnimation:animation forKey:nil];
}

// 将要移除(做移除动画)
- (void)willDismissContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    [UIView animateWithDuration:0.6f animations:^{
        self.transform = (CGAffineTransformMakeScale(0.1, 0.1));
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    } ];
}

- (void)initializedSubviews{
    
    UIView *centerXLine=[[UIView alloc]init];
    [self addSubview:centerXLine];
    
    self.leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.leftBtn];
    
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.rightBtn];
    
    self.leftBtn.titleLabel.font=kFONT17;
    [self.leftBtn setTitleColor:RGB(255, 120, 37) forState:UIControlStateNormal];
    [self.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    self.rightBtn.titleLabel.font=kFONT17;
    [self.rightBtn setTitleColor:RGB(255, 120, 37) forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    [self.rightBtn addTarget:self action:@selector(rightBtnClick)];
    
    centerXLine.sd_layout
    .centerXEqualToView(self).widthIs(1).heightIs(73).bottomSpaceToView(self, 0);
    
    self.leftBtn.sd_layout
    .rightSpaceToView(centerXLine, 0).widthIs(115).heightIs(73).bottomSpaceToView(self, 0);
    
    self.rightBtn.sd_layout
    .leftSpaceToView(centerXLine, 0).widthIs(115).heightIs(73).bottomSpaceToView(self, 0);
    
    CGFloat witdh=(FNDeviceWidth-95)/2;
    UIView *centerYLine=[[UIView alloc]init];
    [self addSubview:centerYLine];
    centerYLine.sd_layout
    .centerXEqualToView(self).widthIs(15).heightIs(2).topSpaceToView(self, 125);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        centerYLine.backgroundColor=RGB(51, 51, 51);
        self.startDatePicker = [[PGDatePicker alloc]init];
        self.startDatePicker.backgroundColor = [UIColor whiteColor];
        self.startDatePicker.delegate = self;
        self.startDatePicker.datePickerMode = PGDatePickerModeTime;
        self.startDatePicker.rowHeight=30;
        self.startDatePicker.frame=CGRectMake(15, 73, witdh, 112);
        self.startDatePicker.lineBackgroundColor=[UIColor clearColor];
        self.startDatePicker.textColorOfSelectedRow=RGB(51, 51, 51);
        self.startDatePicker.textFontOfSelectedRow=[UIFont systemFontOfSize:24];
        self.startDatePicker.textColorOfOtherRow=RGB(218, 218, 218);
        self.startDatePicker.textFontOfOtherRow=[UIFont systemFontOfSize:18];
        self.startDatePicker.autoSelected=YES;
        self.startDatePicker.showUnit=PGShowUnitTypeCenter;
        self.startDatePicker.middleTextColor=RGB(51, 51, 51);
        self.startDatePicker.middleTextFont=[UIFont systemFontOfSize:10];
        [self addSubview:self.startDatePicker];
        
        self.endDatePicker = [[PGDatePicker alloc]init];
        self.endDatePicker.backgroundColor = [UIColor whiteColor];
        self.endDatePicker.delegate = self;
        self.endDatePicker.datePickerMode = PGDatePickerModeTime;
        self.endDatePicker.rowHeight=30;
        self.endDatePicker.frame=CGRectMake(15+witdh+15+15, 73, witdh, 112);
        self.endDatePicker.lineBackgroundColor=[UIColor clearColor];
        self.endDatePicker.textColorOfSelectedRow=RGB(51, 51, 51);
        self.endDatePicker.textFontOfSelectedRow=[UIFont systemFontOfSize:24];
        self.endDatePicker.textColorOfOtherRow=RGB(218, 218, 218);
        //self.endDatePicker.textFontOfOtherRow=[UIFont systemFontOfSize:18];
        self.endDatePicker.autoSelected=YES;
        self.endDatePicker.showUnit=PGShowUnitTypeCenter;
        self.endDatePicker.middleTextColor=RGB(51, 51, 51);
        self.endDatePicker.middleTextFont=[UIFont systemFontOfSize:10];
        [self addSubview:self.endDatePicker];
        
        self.startDatePicker.sd_layout
        .widthIs(witdh).heightIs(152).topSpaceToView(self, 50).rightSpaceToView(centerYLine, 0);//centerYEqualToView(centerYLine)
        self.endDatePicker.sd_layout
        .widthIs(witdh).heightIs(152).topSpaceToView(self, 50).leftSpaceToView(centerYLine, 0);//centerYEqualToView(centerYLine)
    
     });
    
}
#pragma mark - PGDatePickerDelegate  选择时间  (时分HH:mm:ss)
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    XYLog(@"dateComponents = %@", dateComponents);
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDate * date = [calendar dateFromComponents:dateComponents];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";//HH:mm:ss
    NSString * dateStr = [formatter stringFromDate:date]; 
    if(datePicker==self.startDatePicker){
       self.startDate=dateStr;
    }
    if(datePicker==self.endDatePicker){
       self.endDate=dateStr;
    }
    
}
-(void)rightBtnClick{
    if([self.startDate kr_isNotEmpty] &&[self.endDate kr_isNotEmpty]){
        if ([self.delegate respondsToSelector:@selector(inDateConfirmActionWithContent:withContent:)]) {
            [self.delegate inDateConfirmActionWithContent:self.startDate withContent:self.endDate];
        }
    }
}
@end
