//
//  QJSlideButtonView.h
//  QJSlideView
//
//  Created by Justin on 16/3/10.
//  Copyright © 2016年 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SBViewBlock)(NSInteger index);

@interface QJSlideButtonView : UIScrollView

@property(nonatomic, strong)NSArray *titleArr;

- (id)initWithcontroller:(UIViewController *)VC TitleArr:(NSArray *)titleArr;

-(void)setSBScrollViewContentOffset:(NSInteger)index;
-(void)setSBScrollViewContentOffset:(NSInteger)index isAnimate: (BOOL)animate;

-(void)seScrollViewPitchOn:(NSInteger)index;
-(void)seScrollViewPitchOn:(NSInteger)index isAnimate: (BOOL)animate;

@property(nonatomic, copy)SBViewBlock sbBlock;

- (id)initWithcontroller:(UIViewController *)VC TitleArr:(NSArray *)titleArr withRoll:(NSInteger)roll withTextColor:(UIColor *)corlor;

- (id)initWithTitleArr:(NSArray *)titleArr withRoll:(NSInteger)roll withTextColor:(UIColor *)corlor;

@end
