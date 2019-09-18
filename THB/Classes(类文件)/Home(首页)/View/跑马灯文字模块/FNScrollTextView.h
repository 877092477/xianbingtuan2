//
//  FNScrollTextView.h
//  超级模式
//
//  Created by Fnuo-iOS on 2018/3/16.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FNScrollTextView;

@protocol FNScrollTextViewDelegate <NSObject>

@optional
- (void)scrollTextView:(FNScrollTextView *)scrollTextView currentTextIndex:(NSInteger)index;
- (void)scrollTextView:(FNScrollTextView *)scrollTextView clickIndex:(NSInteger)index content:(NSString *)content;

@end

@interface FNScrollTextView : UIView

@property (nonatomic,assign) id <FNScrollTextViewDelegate>delegate;

/* textDataArr 支持 NSString 和 NSAttributedString 类型 */
@property (nonatomic,copy)   NSArray * textDataArr;

@property (nonatomic,copy)   UIFont  * textFont;
@property (nonatomic,copy)   UIColor * textColor;
@property (nonatomic)        NSTextAlignment textAlignment;

@property (nonatomic,assign) BOOL touchEnable; // defualt is YES

- (void)startScrollBottomToTopWithSpace;//从下到上留间隔
- (void)startScrollTopToBottomWithSpace;//从上到下留间隔

- (void)startScrollBottomToTopWithNoSpace;//从下到上不留间隔
- (void)startScrollTopToBottomWithNoSpace;//从上到下不留间隔

- (void)stop;//停止
- (void)stopToEmpty;

@end
