//
//  QJSlideButtonView.m
//  QJSlideView
//
//  Created by Justin on 16/3/10.
//  Copyright © 2016年 Justin. All rights reserved.
//

#import "QJSlideButtonView.h"
#import "Masonry.h"

/**
 *  screen -->> width/height
 */
#define Screen_Width    ([UIScreen mainScreen].bounds.size.width)
#define Screen_Height   ([UIScreen mainScreen].bounds.size.height)

#define ButtonSpace     Screen_Width * 20/414
#define BaseTag         10000

#define TITLEFONT 15*Screen_Height/736
#define TitleH  35


/**
 *  clolor
 */



@interface QJSlideButtonView()<UIScrollViewDelegate>

@property(nonatomic, strong)UIImageView *lineView;

@property(nonatomic, strong)NSMutableArray *titleContentOrigin_X_Arr;

@property(nonatomic, strong)NSMutableArray *titleContentSize_Width_Arr;

@property(nonatomic, strong)NSMutableArray *buttons;


@end

@implementation QJSlideButtonView{
    NSInteger BeforeButtonTag;
    NSInteger contentSize_width;
    NSInteger centerWordLocation_X;
    NSInteger rollInt;
    UIColor *textColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithcontroller:(UIViewController *)VC TitleArr:(NSArray *)titleArr
{
    self = [super init];
    if (self) {
        self.frame = [self getViewFrame];
        self.backgroundColor = [UIColor whiteColor];
        self.pagingEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        [VC.view addSubview:self];
        self.titleContentOrigin_X_Arr = [[NSMutableArray alloc] initWithCapacity:0];
        self.titleContentSize_Width_Arr = [[NSMutableArray alloc] initWithCapacity:0];
        self.titleArr = titleArr;
        [self confingSubviews];
        [self locateCenterWordPosition];
        rollInt=0;
    }
    return self;
}
- (id)initWithcontroller:(UIViewController *)VC TitleArr:(NSArray *)titleArr withRoll:(NSInteger)roll withTextColor:(UIColor *)corlor
{
    self = [super init];
    if (self) {
        self.frame = [self getViewFrame];
        self.backgroundColor = [UIColor whiteColor];
        self.pagingEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        [VC.view addSubview:self];
        rollInt=roll;
        textColor=corlor;
        self.titleContentOrigin_X_Arr = [[NSMutableArray alloc] initWithCapacity:0];
        self.titleContentSize_Width_Arr = [[NSMutableArray alloc] initWithCapacity:0];
        self.titleArr = titleArr;
        [self confingSubviews];
        [self locateCenterWordPosition];
        
    }
    return self;
}
- (id)initWithTitleArr:(NSArray *)titleArr withRoll:(NSInteger)roll withTextColor:(UIColor *)corlor{
    self = [super init];
    if (self) {
        self.frame = [self getViewFrame];
        self.backgroundColor = [UIColor whiteColor];
        self.pagingEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        rollInt=roll;
        textColor=corlor;
        self.titleContentOrigin_X_Arr = [[NSMutableArray alloc] initWithCapacity:0];
        self.titleContentSize_Width_Arr = [[NSMutableArray alloc] initWithCapacity:0];
        self.titleArr = titleArr;
        [self confingSubviews];
        [self locateCenterWordPosition];
        
        
    }
    return self;
}
-(CGRect)getViewFrame
{
    CGRect frame = CGRectZero;
    frame.size.height = TitleH;
    frame.size.width = Screen_Width;
    frame.origin.x = 0;
    frame.origin.y = 0;
    return frame;
}
 
-(void)confingSubviews
{
    float contentWidth = 0.0;
    float Origin_X = ButtonSpace/2;
    if (_buttons) {
        for (UIView *v in _buttons) {
            [v removeFromSuperview];
        }
    }
    self.buttons = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.titleArr.count; i ++) {
        UIButton *titleBt = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title = [self.titleArr objectAtIndex:i];
        [titleBt setTag:BaseTag + i];
        if (i == 0) {
            titleBt.selected = YES;
            BeforeButtonTag = i;
        }
        [titleBt setTitle:title forState:UIControlStateNormal];
        titleBt.titleLabel.font = [UIFont systemFontOfSize:TITLEFONT];
        [titleBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleBt setTitleColor:RED forState:UIControlStateSelected];
        [titleBt addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
        [titleBt setBackgroundColor:[UIColor whiteColor]];
        if(textColor){
            [titleBt setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
            [titleBt setTitleColor:textColor forState:UIControlStateSelected];
            titleBt.titleLabel.font = [UIFont systemFontOfSize:13];
        }

        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:TITLEFONT + 1]};
        CGSize textSize = [title boundingRectWithSize:CGSizeMake(ButtonSpace*11, TitleH) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
        [self addSubview:titleBt];
        [self.buttons addObject:titleBt];
        
        [titleBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(Origin_X);
            make.top.equalTo(self.mas_top);
            make.height.mas_equalTo(36-5);
            make.width.mas_equalTo(textSize.width);
        }];
        [self.titleContentOrigin_X_Arr addObject:@(Origin_X)];
        contentWidth += (textSize.width + ButtonSpace);
        Origin_X += textSize.width + ButtonSpace;
        [self.titleContentSize_Width_Arr addObject:@(textSize.width)];
    }
    contentSize_width = contentWidth + ButtonSpace/2;
    self.contentSize = CGSizeMake(contentSize_width, TitleH);

    [self addSubview:self.lineView];
    self.lineView.frame = CGRectMake([self.titleContentOrigin_X_Arr[0] floatValue], TitleH - 3, [self.titleContentSize_Width_Arr[0] floatValue], 3);

}

-(UIImageView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIImageView alloc] init];
        _lineView.backgroundColor =RED;
        if(textColor){
            _lineView.backgroundColor =textColor;
        }
    }
    return _lineView;
}

- (void)selectType:(UIButton *)bt
{
    __weak typeof(self) weakself = self;
    CGFloat Origin_X = [self.titleContentOrigin_X_Arr[bt.tag - BaseTag] floatValue];
    if (BeforeButtonTag != bt.tag - BaseTag) {
        [self changeBeforeBtStatus:^{
            if (BeforeButtonTag < bt.tag - BaseTag) {
                /**
                 *  整体往左滚
                 */
                if (Origin_X < centerWordLocation_X) {
                    //no any reaction
                    NSLog(@"no any reaction");
                }else if (self.contentSize.width - Origin_X < Screen_Width - centerWordLocation_X){
                    if(rollInt==0){
                      [self setContentOffset:CGPointMake(self.contentSize.width - Screen_Width, 0)  animated:YES];
                    }
                }else{
                    if(rollInt==0){
                      [self setContentOffset:CGPointMake(Origin_X -centerWordLocation_X, 0)  animated:YES];
                    }
                }
                
            }else{
                /**
                 *  整体往右滚
                 */
                if (Origin_X < centerWordLocation_X) {
                    if(rollInt==0){
                      [self setContentOffset:CGPointMake(0, 0)  animated:YES];
                    }
                }else if (contentSize_width - Origin_X - 2 *ButtonSpace < centerWordLocation_X){
                    // no any reaction
                    NSLog(@"no any reaction");
                }else{
                    if(rollInt==0){
                      [self setContentOffset:CGPointMake(Origin_X - centerWordLocation_X, 0)  animated:YES];
                    }
                }
            }
            NSInteger index = bt.tag - BaseTag;
            bt.selected = !bt.selected;
            [weakself startAnimation:index];
        }];
        if (self.sbBlock) {
            self.sbBlock(bt.tag - BaseTag);
        }
        
    }else{
        return;
    }
}
-(void)startAnimation:(NSInteger)index {
    [self startAnimation:index isAnimate: YES];
}
-(void)startAnimation:(NSInteger)index isAnimate: (BOOL) animate
{
    if (animate) {
        [UIView animateWithDuration:0.2 animations:^{
            self.lineView.frame = CGRectMake([self.titleContentOrigin_X_Arr[index] floatValue], TitleH - 3, [self.titleContentSize_Width_Arr[index] floatValue], 3);
            NSLog(@"当前分类--->>%@",self.titleArr[index]);
        } completion:^(BOOL finished) {
            BeforeButtonTag = index;
        }];
    } else {
        self.lineView.frame = CGRectMake([self.titleContentOrigin_X_Arr[index] floatValue], TitleH - 3, [self.titleContentSize_Width_Arr[index] floatValue], 3);
        BeforeButtonTag = index;
    }

}

-(void)locateCenterWordPosition
{
    for (int i = 0; i < self.titleContentOrigin_X_Arr.count; i ++) {
        NSInteger origin_x = [self.titleContentOrigin_X_Arr[i] integerValue];
        NSInteger contentWidth = [self.titleContentSize_Width_Arr[i] integerValue];
        if (origin_x < Screen_Width/2 && origin_x + contentWidth > Screen_Width/2) {
            centerWordLocation_X = origin_x;
        }
    }
}

- (void)changeBeforeBtStatus:(void(^)())block
{
    UIButton *beforeBt = (UIButton *)[self viewWithTag:BaseTag + BeforeButtonTag];
    beforeBt.selected = !beforeBt.selected;
    if (block) {
        block();
    }
}
-(void)setSBScrollViewContentOffset:(NSInteger)index {
    [self setSBScrollViewContentOffset:index isAnimate:YES];
}
-(void)setSBScrollViewContentOffset:(NSInteger)index isAnimate: (BOOL) animate
{
    CGFloat Origin_X = [self.titleContentOrigin_X_Arr[index] floatValue];
    UIButton *nowBt = (UIButton *)[self viewWithTag:BaseTag + index];

    if (BeforeButtonTag < nowBt.tag - BaseTag) {
        /**
         *  整体往左滚
         */
        if (Origin_X < centerWordLocation_X) {
            //no any reaction
            NSLog(@"no any reaction");
        }else if (self.contentSize.width - Origin_X < Screen_Width - centerWordLocation_X){
            [self setContentOffset:CGPointMake(self.contentSize.width - Screen_Width, 0)  animated:YES];
        }else{
            [self setContentOffset:CGPointMake(Origin_X -centerWordLocation_X, 0)  animated:YES];
        }
        
    }else{
        /**
         *  整体往右滚
         */
        if (Origin_X < centerWordLocation_X) {
            [self setContentOffset:CGPointMake(0, 0)  animated:YES];
        }else if (contentSize_width - Origin_X - 2 *ButtonSpace < centerWordLocation_X){
            // no any reaction
            NSLog(@"no any reaction");
        }else{
            [self setContentOffset:CGPointMake(Origin_X - centerWordLocation_X, 0)  animated:YES];
        }
    }
    __weak typeof(self) weakself = self;
    [self changeBeforeBtStatus:^{
        UIButton *nowBt = (UIButton *)[self viewWithTag:BaseTag + index];
        nowBt.selected = !nowBt.selected;
        [weakself startAnimation:index isAnimate:animate];
    }];
}
-(void)seScrollViewPitchOn:(NSInteger)index{
    [self seScrollViewPitchOn: index isAnimate: YES];
}
    
-(void)seScrollViewPitchOn:(NSInteger)index isAnimate: (BOOL)animate {
    __weak typeof(self) weakself = self;
    [self changeBeforeBtStatus:^{
        UIButton *nowBt = (UIButton *)[self viewWithTag:BaseTag + index];
        nowBt.selected = !nowBt.selected;
        [weakself startAnimation:index isAnimate:animate];
    }];
    
    [self selectType: _buttons[index]];
}
@end
