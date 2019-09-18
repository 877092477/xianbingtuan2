//
//  JMTitleScrollerView.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/1.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum :NSUInteger{
    StableType,
    VariableType,
    AdaptionType,
}ScorllType;
@class JMTitleScrollView;
@protocol JMTitleScrollViewDelegate <NSObject>
@optional
- (void)clickedTitleView:(JMTitleScrollView *)titleView atIndex:(NSInteger)index;

@end

/**
 *  水平分类scrollView
 */
@interface JMTitleScrollView : UIScrollView
@property (nonatomic, weak) id <JMTitleScrollViewDelegate> tDelegate;
@property (nonatomic, assign)ScorllType type;
@property (nonatomic, strong)NSArray *titleArray;
@property (nonatomic, assign)BOOL isShowIndicator;
- (void)setBottomViewAtIndex:(NSInteger)index; 
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titles fontSize:(CGFloat)font _textLength:(CGFloat)length andButtonSpacing:(CGFloat)buttonSpacing type:(ScorllType)type;

@end
