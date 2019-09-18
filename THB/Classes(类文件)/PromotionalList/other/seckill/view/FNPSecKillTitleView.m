//
//  FNPSecKillTitleView.m
//  THB
//
//  Created by Jimmy on 2017/12/25.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPSecKillTitleView.h"
#import "FNSeckillHomeModel.h"
#define FNDeepRED FNColor(136, 143, 149)
@interface FNPSecKillTitleView ()
@property (nonatomic, strong)NSArray *titleArray;
@property (nonatomic, strong)UIView *indicatorView;
@property (nonatomic, assign)NSInteger currentIndex;
@property (nonatomic, strong)NSMutableArray* views;

@end
@implementation FNPSecKillTitleView
CGFloat _shceduleWidth = 0;
- (NSMutableArray *)views{
    if (_views == nil) {
        _views = [NSMutableArray new];
    }
    return _views;
}
- (UIView *)indicatorView{
    if (_indicatorView == nil) {
        _indicatorView = [UIView new];
        //_indicatorView.backgroundColor = RED;
        _indicatorView.backgroundColor = FNWhiteColor;
        _indicatorView.cornerRadius=5;
    }
    return _indicatorView;
}
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
   
    if (self.views.count>=1) {
        [self.views makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.views removeAllObjects];
        
    }
    if ([self.subviews containsObject:self.indicatorView]) {
        [self removeFromSuperview];
    }
    CGFloat toolViewWidth = self.width;
    CGFloat toolViewHeight = self.height;
   
    
    if (_titleArray.count < 5) {
        _shceduleWidth = toolViewWidth/_titleArray.count;
    }else {
        _shceduleWidth = toolViewWidth/5;
    }
    UIImageView *bgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _titleArray.count * _shceduleWidth, toolViewHeight)];
    [bgImageView setUrlImg:[FNBaseSettingModel settingInstance].taoqianggou_time_img];
    [self addSubview:bgImageView];
    for (NSInteger i = 0; i < _titleArray.count; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i*_shceduleWidth, 5, _shceduleWidth, toolViewHeight-10)];
        //view.backgroundColor = [UIColor clearColor];
        view.tag = 100 + i;
        NSDictionary *dict = _titleArray[i];
        NSString *time = dict[@"time"];
        NSString *title = dict[@"title"];
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        timeLabel.text = time;
        timeLabel.font = kFONT16;
        timeLabel.textColor = FNDeepRED;
        timeLabel.textColor = FNWhiteColor;
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [timeLabel sizeToFit];
        [view addSubview:timeLabel];
        
        UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        stateLabel.text = title;
        stateLabel.textColor = FNDeepRED;
        stateLabel.textColor = FNWhiteColor;
        stateLabel.font = kFONT11;
        stateLabel.textAlignment = NSTextAlignmentCenter;
        [stateLabel sizeToFit];
        [view addSubview:stateLabel];
        if ([stateLabel.text isEqualToString:@"进行中"]) {
            _currentIndex = i;
        }else {
            _currentIndex = 0;
        }
        
        
        //layout
        CGFloat verticalMargin = (toolViewHeight - timeLabel.height - stateLabel.height)/3;
        [timeLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(verticalMargin, 0, 0, 0) excludingEdge:ALEdgeBottom];
        [stateLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, verticalMargin, 0) excludingEdge:ALEdgeTop];
//        [timeLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_margin10];
//        [timeLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_margin10];
//        [timeLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [bgImageView addSubview:view];
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(observingTapGesture:)]];
        
    }
    self.contentSize = CGSizeMake(_titleArray.count * _shceduleWidth, self.height);
    

    self.indicatorView.frame = CGRectMake(0, 5, _shceduleWidth, toolViewHeight-10);
    [bgImageView insertSubview:self.indicatorView atIndex:0];
    
    _currentIndex = 0;
    

    //self.backgroundColor =FNColor(43, 57, 68);
}
#pragma mark  - observing
- (void)observingTapGesture:(UITapGestureRecognizer *)tap
{
    
    UIView *view = tap.view;
    NSInteger currentIndex = view.tag -100;
    [self selectedTimeAtIndex:currentIndex];
    
    if (self.clickedTimeAtIndex) {
        self.clickedTimeAtIndex(currentIndex);
    }
    
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
                label.transform = CGAffineTransformIdentity;
                //label.textColor = FNDeepRED;
                label.textColor = FNWhiteColor;
            } ];
        }
        _indicatorView.centerX  =  selectedView.centerX ;
    } completion:^(BOOL finished) {
        if (finished) {
            _currentIndex = index;
            for (UILabel *label in selectedView.subviews) {
                [UIView animateWithDuration:0.2f animations:^{
                    label.transform = CGAffineTransformMakeScale(1.2, 1.2);
                    //label.textColor = FNWhiteColor; 
                    label.textColor = FNDeepRED;
                    label.textColor = FNColor(230, 70, 79);
                  
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
            for (UIView*view in self.subviews) {
                view.userInteractionEnabled = YES;
            }
        }
    }];
}

- (void)setModel:(NSArray *)model{
    _model = model;
    if (_model && _model.count>=1) {
        NSMutableArray *times = [NSMutableArray new];
        [_model enumerateObjectsUsingBlock:^(App_Miaosha_Time * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [times addObject:@{@"time":obj.date,@"title":obj.str}];
        }];
        self.titleArray = times;
    }
}


@end
