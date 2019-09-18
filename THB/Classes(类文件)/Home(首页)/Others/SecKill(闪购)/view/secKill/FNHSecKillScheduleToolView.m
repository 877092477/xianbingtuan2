//
//  FNSecKillScheduleToolView.m
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 16/8/4.
//  Copyright © 2016年 jimmy. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "FNHSecKillScheduleToolView.h"
#import "FNSeckillHomeModel.h"
#define FNDeepRED FNColor(136, 143, 149)
@interface FNHSecKillScheduleToolView ()
@property (nonatomic, strong)NSArray *titleArray;
@property (nonatomic, strong)UIView *indicatorView;
@property (nonatomic, assign)NSInteger currentIndex;

@end
@implementation FNHSecKillScheduleToolView
CGFloat _shceduleViewWidth = 0;

- (instancetype)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.pagingEnabled = NO;
        self.bounces = NO;
        self.backgroundColor = FNWhiteColor;
        self.showsHorizontalScrollIndicator = NO;

    }
    return self;
}
- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    if (_titleArray.count > 0) {
        if (self.subviews.count > 0) {
            [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        }
        [self initializedSubviews];
    }
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    CGFloat toolViewWidth = self.width;
    CGFloat toolViewHeight = self.height;
    if (_titleArray.count < 3) {
        if (_titleArray.count == 2) {
            _shceduleViewWidth = toolViewWidth/2;
        }else if (_titleArray.count == 1){
            _shceduleViewWidth = toolViewWidth;
        }
    }else {
        _shceduleViewWidth = toolViewWidth/3;
    }
    for (NSInteger i = 0; i < _titleArray.count; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i*_shceduleViewWidth, 0, _shceduleViewWidth, toolViewHeight)];
        view.backgroundColor = [UIColor clearColor];
        view.tag = 100 + i;
        NSDictionary *dict = _titleArray[i];
        NSString *time = dict[@"time"];
        NSString *title = dict[@"title"];
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        timeLabel.text = time;
        timeLabel.font = kFONT17;
        timeLabel.textColor = FNDeepRED;
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [timeLabel sizeToFit];
        [view addSubview:timeLabel];
//        
//        UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectZero];
//        stateLabel.text = title;
//        stateLabel.textColor = FNDeepRED;
//        stateLabel.font = kFONT12;
//        stateLabel.textAlignment = NSTextAlignmentCenter;
//        [stateLabel sizeToFit];
//        [view addSubview:stateLabel];
//        if ([stateLabel.text isEqualToString:@"疯抢中"]) {
//            _currentIndex = i;
//        }else {
//            _currentIndex = 0;
//        }
        
        
        //layout
//        CGFloat verticalMargin = (toolViewHeight - timeLabel.height - stateLabel.height)/3;
//        [timeLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(verticalMargin, 0, 0, 0) excludingEdge:ALEdgeBottom];
//        [stateLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, verticalMargin, 0) excludingEdge:ALEdgeTop];
        [timeLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_margin10];
        [timeLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_margin10];
        [timeLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self addSubview:view];
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(observingTapGesture:)]];
        
    }
    self.contentSize = CGSizeMake(_titleArray.count * _shceduleViewWidth, self.height);
    
    
    UIView *indicatorView = [[UIView alloc]initWithFrame:CGRectMake(5, 0, _shceduleViewWidth-10, toolViewHeight)];
    indicatorView.cornerRadius = 5;
    indicatorView.backgroundColor = RED;
    indicatorView.hidden = YES;
    [self insertSubview:indicatorView atIndex:0];
    _indicatorView = indicatorView;
    _currentIndex = 0;
    
    UIView* bgView = [[UIView alloc]initWithFrame:(CGRectMake(0, 5, self.contentSize.width, self.height-10))];
    bgView.backgroundColor  =FNColor(43, 57, 68);
    [self insertSubview:bgView atIndex:0];

}
#pragma mark  - observing
- (void)observingTapGesture:(UITapGestureRecognizer *)tap
{

    UIView *view = tap.view;
    NSInteger currentIndex = view.tag -100;
    [self selectedTimeAtIndex:currentIndex];

    self.clickedTimeAtIndex(currentIndex);
}

- (void)selectedTimeAtIndex:(NSInteger)index
{
    UIView *selectedView = [self viewWithTag:index+100];
//    if (index == _currentIndex) {
//        
//        return;
//    }
    
    UIView *lastView = [self viewWithTag:_currentIndex+100];
    for (UIView*view in self.subviews) {
        if (view != selectedView) {
            view.userInteractionEnabled = NO;
        }
    }
    _indicatorView.hidden = NO;
    [UIView animateWithDuration:0.3f animations:^{

        for (UILabel *label in lastView.subviews) {
            [UIView animateWithDuration:0.2f animations:^{
//                label.transform = CGAffineTransformIdentity;
                label.textColor = FNDeepRED;
            } ];
        }
        _indicatorView.centerX  =  selectedView.centerX ;
    } completion:^(BOOL finished) {
        if (finished) {
            _currentIndex = index;
            for (UILabel *label in selectedView.subviews) {
                [UIView animateWithDuration:0.2f animations:^{
//                    label.transform = CGAffineTransformMakeScale(1.2, 1.2);
                   label.textColor = FNWhiteColor;
                } ];
            }
            _currentIndex = index;
            
            //将指示器所指向的标签分类放置到屏幕中间
            CGFloat width = selectedView.centerX - self.contentOffset.x;
            if (fabs(width) > self.width/2) {
                CGFloat length = width - self.width/2;
                CGFloat contentOffSetX = self.contentOffset.x + length > self.contentSize.width-self.width?self.contentSize.width-self.width:self.contentOffset.x + length;
                [self setContentOffset:CGPointMake(contentOffSetX, 0) animated:YES];
            }else {
                CGFloat length = width - self.width/2;
                CGFloat contentOffSetX = 0;
                if (selectedView.centerX > self.width*0.5) {
                    contentOffSetX = self.contentOffset.x + length > self.contentSize.width-self.width?self.contentSize.width-self.width:self.contentOffset.x + length;
                }else {
                    contentOffSetX = 0;
                }
                [self setContentOffset:CGPointMake(contentOffSetX, 0) animated:YES];
            }
//            if (index>0 && index <self.titleArray.count-1) {
//                //将指示器所指向的标签分类放置到屏幕中间
//                CGFloat width = selectedView.centerX - self.contentOffset.x;
//                //要移动的距离
//                CGFloat length = width - FNDeviceWidth/2;
//                [self setContentOffset:CGPointMake(self.contentOffset.x+length, 0) animated:YES];
//            }
            for (UIView*view in self.subviews) {
                view.userInteractionEnabled = YES;
            }
        }
    }];
}

- (void)setModel:(FNSeckillHomeModel *)model{
    _model = model;
    if (_model) {
        NSMutableArray *times = [NSMutableArray new];
        [_model.app_miaosha_time enumerateObjectsUsingBlock:^(App_Miaosha_Time * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [times addObject:@{@"time":obj.time,@"title":obj.str}];
        }];
        self.titleArray = times;
    }
}
@end
