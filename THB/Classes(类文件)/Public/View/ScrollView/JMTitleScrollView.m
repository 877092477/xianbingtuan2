//
//  JMTitleScrollerView.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/1.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMTitleScrollView.h"

@interface JMTitleScrollView ()
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *highlightColor;
@property (nonatomic, weak) UIView *indicator;//horizontalIndicator:red       

@property (nonatomic, assign)CGFloat buttonSpacing;
@property (nonatomic, assign)CGFloat fontSize;
@property (nonatomic, assign)CGFloat textLength;

@property (nonatomic, strong) NSMutableArray<UIButton *>* buttons;
@end
@implementation JMTitleScrollView
- (NSMutableArray <UIButton *>*)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray new];
    }
    return _buttons;
}
NSInteger _currentPage = 0;
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titles fontSize:(CGFloat)font _textLength:(CGFloat)length andButtonSpacing:(CGFloat)buttonSpacing type:(ScorllType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        self.normalColor = [UIColor colorWithRed:109/255.0 green:109/255.0 blue:109/255.0 alpha:1.0];
        self.highlightColor = FNMainGobalControlsColor;
        self.buttonSpacing = buttonSpacing;
        
        _fontSize = font;
        _textLength = length;
        self.titleArray = titles;
    }
    return self;
}
- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    if (_titleArray && _titleArray.count>0) {
        if (self.subviews.count > 0 && self.buttons.count > 0 && self.buttons.count == _titleArray.count ) {
            [self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj setTitle:_titleArray[idx] forState:UIControlStateNormal];
            }];
                        [self.buttons removeAllObjects];
                        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                        [self initializedSubviews];
        }else{
            [self.buttons removeAllObjects];
            [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self initializedSubviews];
        }
        
    }
}
- (void)initializedSubviews
{
    CGFloat contentWith = 0;
    for (NSInteger i = 0; i<_titleArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i+100;
        CGFloat height = self.height-10;
        NSString *text = _titleArray[i];
        
        _textLength = text.length ;
        if(btn.tag==100){
            btn.selected=YES;
        }
        if (self.type == StableType) {
            CGFloat width = self.width/_titleArray.count;
            
            btn.frame = CGRectMake(i*width, 5, width, height);
        }
       
        else {
            btn.frame = CGRectMake(contentWith+_buttonSpacing*i+12, 5, _textLength*_fontSize+10, height);
            contentWith += btn.width;
        }
        
        btn.titleLabel.font = [UIFont systemFontOfSize:_fontSize];
        [btn setTitle:_titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.highlightColor forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(observeTitleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.buttons addObject:btn];
    }
    //set the arrange of scrollerview
    if (self.type == VariableType ) {
        self.contentSize =  CGSizeMake(contentWith+self.buttonSpacing*(_titleArray.count-1)+5*2, self.height);
    }
    else {
        self.contentSize = CGSizeMake(FNDeviceWidth, 44);
    }
    self.backgroundColor = [UIColor whiteColor];
    self.showsHorizontalScrollIndicator = false;
    NSString *text = _titleArray[0];
    //
    UIView *indicator = [[UIView alloc]initWithFrame:CGRectMake(self.type == StableType? 0:12, self.height-5, self.type == StableType? self.width/_titleArray.count:_fontSize*text.length, 2)];
    indicator.layer.zPosition = 2;
    indicator.backgroundColor = self.highlightColor;
    _currentPage = 0 ;
    [self addSubview:indicator];
    _indicator = indicator;
}
#pragma mark - button clicked
- (void)observeTitleButtonClicked:(UIButton *)btn
{
    if (btn.selected == YES) {
        return;
    }
    [self anmatiedBtn:btn];
    //
    NSInteger clickedIndex = btn.tag - 100;
    if ([self.tDelegate respondsToSelector:@selector(clickedTitleView:atIndex:)]) {
        [self.tDelegate clickedTitleView:self atIndex:clickedIndex];
    }
}
//do animation
- (void)anmatiedBtn:(UIButton *)btn{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            btn.selected = NO;
        }
    }
    btn.selected = YES;
    __weak JMTitleScrollView *weakSelf = self;
    NSInteger clickedIndex = btn.tag - 100;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.indicator.width =self.type == StableType ? btn.currentTitle.length*_fontSize+10:btn.width;
        weakSelf.indicator.centerX  = btn.centerX;
        
    } completion:^(BOOL finished) {
        _currentPage = clickedIndex;
        if (self.type == VariableType) {
            
            //将指示器所指向的标签分类放置到屏幕中间
            CGFloat width = btn.x - self.contentOffset.x;
            if (fabs(width) > self.width/2) {
                CGFloat length = width - self.width/2;
                CGFloat contentOffSetX = self.contentOffset.x + length > self.contentSize.width-self.width?self.contentSize.width-self.width:self.contentOffset.x + length;
                [self setContentOffset:CGPointMake(contentOffSetX, 0) animated:YES];
            }else {
                CGFloat length = width - self.width/2;
                CGFloat contentOffSetX = 0;
                if (btn.x > self.width*0.5) {
                    contentOffSetX = self.contentOffset.x + length > self.contentSize.width-self.width?self.contentSize.width-self.width:self.contentOffset.x + length;
                }else {
                    contentOffSetX = 0;
                }
                [self setContentOffset:CGPointMake(contentOffSetX, 0) animated:YES];
            }
        }
    }];
    
}
#pragma mark - public method
- (void)setBottomViewAtIndex:(NSInteger)index
{
    if (self.titleArray&& self.titleArray.count == 0) {
        return;
    }
    UIButton *btn = (UIButton *)[self viewWithTag:index+100];
    [self anmatiedBtn:btn];
}
 
- (void)setIsShowIndicator:(BOOL)isShowIndicator{
    _isShowIndicator = isShowIndicator;
    self.indicator.hidden = !_isShowIndicator;
}
@end
