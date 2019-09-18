//
//  SliderControl.h
//  THB
//
//  Created by Weller Zhao on 2018/12/26.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SliderControl;
@protocol SliderControlDelegate <NSObject>

@optional
- (void)sliderControl: (SliderControl*) slider didCellSelectedAtIndex: (NSInteger) index;

@end

@interface SliderControl : UIView

@property (nonatomic, weak, nullable) id <SliderControlDelegate> delegate;

//字体颜色
@property (nonatomic, copy, setter=setTextColor:) UIColor *textColor;
@property (nonatomic, copy, setter=setFont:) UIFont *font;
@property (nonatomic, copy, setter=setHightlightFont:) UIFont *hightlightFont;
//选中字体颜色
@property (nonatomic, copy, setter=setTextHighlightColor:) UIColor *textHighlightColor;
//选中背景色
@property (nonatomic, copy, setter=setHighlightColor:) UIColor *highlightColor;

//若为YES，根据文字适配，否则，等分所有cell
@property (nonatomic, assign) BOOL autoSize;

- (void)setTitles: (NSArray*)titles;
- (void)setSelected:(NSInteger)index animated: (BOOL)animated;

@end

NS_ASSUME_NONNULL_END
