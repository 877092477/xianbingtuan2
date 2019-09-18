//
//  FNpredictDurationListView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNpredictDurationListView.h"

@implementation FNpredictDurationListView

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initializedSubviews];
    } return self;
}
// 准备弹出(初始化弹层位置)
- (void)willPopupContainer:(DSHPopupContainer *)container; {
    CGRect frame = self.frame;
    frame.size = CGSizeMake(FNDeviceWidth, 0);
    frame.origin.x = 0;
    frame.origin.y = container.frame.size.height;// - frame.size.height;
    self.frame = frame;
}

// 已弹出(做弹出动画)
- (void)didPopupContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    
    [UIView animateWithDuration:duration animations:^{
        CGRect frame = CGRectMake(0, container.frame.size.height - 306, FNDeviceWidth,306);
        self.frame = frame;
    }];
}

// 将要移除(做移除动画)
- (void)willDismissContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    CGRect frame = self.frame;
    frame.origin.y = container.frame.size.height;
    frame.size.height=0;
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0.f;
    }];
}
- (void)initializedSubviews{
    self.leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.leftBtn];
    self.leftBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.rightBtn];
    self.rightBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.rightBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:RGB(253, 119, 0) forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightBtnClick)];
    
    self.leftBtn.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 0).heightIs(42).widthIs(50);
    
    self.rightBtn.sd_layout
    .rightSpaceToView(self, 0).topSpaceToView(self, 0).heightIs(42).widthIs(50);
    self.dataArr=[NSMutableArray arrayWithCapacity:0];
    for (NSInteger i=1; i<61; i++) {
        [self.dataArr addObject:[NSString stringWithFormat:@"%ld",(long)i]];
    }
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, FNDeviceWidth, 256)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self addSubview:pickerView];
    [pickerView selectRow:29 inComponent:0 animated:YES];
    self.durationStr=@"30分钟";
    //pickerView.showsSelectionIndicator = YES;
}
-(void)rightBtnClick{
    if ([self.delegate respondsToSelector:@selector(didpredictPredictDurationListAction:withContent:)]) {
        [self.delegate didpredictPredictDurationListAction:self.index withContent:self.durationStr];
    }
}
#pragma mark - dataSouce
//有几行
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
//行中有几列
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    //return [self.dataArr[component] count];
    return self.dataArr.count;
}
//列显示的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger) row forComponent:(NSInteger)component {
    NSString *minStr=[NSString stringWithFormat:@"%@分钟",self.dataArr[row]];
    return minStr;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}
#pragma mark - delegate
// 选中某一组的某一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.durationStr=self.dataArr[row];
    XYLog(@"%@", self.durationStr);
}
@end
