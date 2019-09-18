//
//  FDSlideBar.h
//  FDSlideBarDemo
//
//  Created by fergusding on 15/6/4.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FDSlideBarItemSelectedCallback)(NSUInteger index);

@interface FDSlideBar : UIView

//按钮总宽度小于屏幕宽度时，是否居中显示
@property (nonatomic, assign)BOOL is_middle;

// All the titles of FDSilderBar
@property (copy, nonatomic) NSArray *itemsTitle;

// All the item's text color of the normal state
@property (strong, nonatomic) UIColor *itemColor;

// The selected item's text color
@property (strong, nonatomic) UIColor *itemSelectedColor;

// The slider color
@property (strong, nonatomic) UIColor *sliderColor;

// All the item's text fontSize of the normal state
@property (assign, nonatomic) CGFloat fontSize;

// The selected item's text fontSize
@property (assign, nonatomic) CGFloat SelectedfontSize;

// Add the callback deal when a slide bar item be selected
- (void)slideBarItemSelectedCallback:(FDSlideBarItemSelectedCallback)callback;

// Set the slide bar item at index to be selected
- (void)selectSlideBarItemAtIndex:(NSUInteger)index;

//按钮品骏宽度
@property (nonatomic, assign)BOOL is_mean;

//按钮 最大
@property (nonatomic, assign)BOOL is_bubig;

@end
