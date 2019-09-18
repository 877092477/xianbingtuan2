//
//  FNImageSliderView.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNImageSliderView;
@protocol FNImageSliderViewDelegate <NSObject>

@optional
- (void)sliderControl: (FNImageSliderView*) slider didCellSelectedAtIndex: (NSInteger) index;

@end

@interface FNImageSliderView : UIView

@property (nonatomic, weak, nullable) id <FNImageSliderViewDelegate> delegate;

//字体颜色
@property (nonatomic, copy, setter=setTextColor:) UIColor *textColor;
@property (nonatomic, copy, setter=setFont:) UIFont *font;
@property (nonatomic, copy, setter=setHightlightFont:) UIFont *hightlightFont;
//选中字体颜色
@property (nonatomic, copy, setter=setTextHighlightColor:) UIColor *textHighlightColor;
//选中背景色
@property (nonatomic, copy, setter=setHighlightColor:) UIColor *highlightColor;

- (void)setTitles: (NSArray*)titles imageUrls: (NSArray*)imgUrls;
- (void)setSelected:(NSInteger)index animated: (BOOL)animated;

@end

NS_ASSUME_NONNULL_END
