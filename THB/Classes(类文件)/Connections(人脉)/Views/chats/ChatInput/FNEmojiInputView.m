//
//  FNEmojiInputView.m
//  THB
//
//  Created by Weller Zhao on 2019/1/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNEmojiInputView.h"
#import "AGEmojiKeyboard/AGEmojiKeyboardView.h"

@interface FNEmojiInputView() <AGEmojiKeyboardViewDelegate, AGEmojiKeyboardViewDataSource>

@property (nonatomic, strong) AGEmojiKeyboardView *emojiKeyboardView;
@property (nonatomic, strong) UIButton *btnSend;

@end

@implementation FNEmojiInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    CGRect keyboardRect = CGRectMake(0, 0, self.bounds.size.width, 216);
    AGEmojiKeyboardView *emojiKeyboardView = [[AGEmojiKeyboardView alloc] initWithFrame:keyboardRect
                                                                             dataSource:self];
    emojiKeyboardView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    emojiKeyboardView.delegate = self;
    emojiKeyboardView.segmentsBar.hidden = YES;
    [self addSubview:emojiKeyboardView];
    _btnSend = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - 80, 190, 80, 30)];
    [self addSubview:_btnSend];
    
    [_btnSend setTitle:@"发送" forState:UIControlStateNormal];
    [_btnSend setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [_btnSend addTarget:self action:@selector(onSendClick:)];
    _btnSend.hidden = YES;
    
//    self.backgroundColor = UIColor.whiteColor;
    
}

#pragma mark - Action
- (void)onSendClick: (id)sender {
    if ([_delegate respondsToSelector:@selector(didSendClick:)]) {
        [_delegate didSendClick:self];
    }
}


#pragma mark - AGEmojiKeyboardViewDelegate, AGEmojiKeyboardViewDataSource

- (void)emojiKeyBoardView:(AGEmojiKeyboardView *)emojiKeyBoardView
              didUseEmoji:(NSString *)emoji {
    if ([_delegate respondsToSelector:@selector(inputView:didEmojiClick:)]) {
        [_delegate inputView:self didEmojiClick:emoji];
    }
}

- (void)emojiKeyBoardViewDidPressBackSpace:(AGEmojiKeyboardView *)emojiKeyBoardView {
    if ([_delegate respondsToSelector:@selector(didDeleteClick:)]) {
        [_delegate didDeleteClick:self];
    }
}

- (AGEmojiKeyboardViewCategoryImage)defaultCategoryForEmojiKeyboardView:(AGEmojiKeyboardView *)emojiKeyboardView {
    return AGEmojiKeyboardViewCategoryImageFace;
}



- (UIColor *)randomColor {
    return [UIColor colorWithRed:drand48()
                           green:drand48()
                            blue:drand48()
                           alpha:drand48()];
}

- (UIImage *)randomImage {
    CGSize size = CGSizeMake(30, 10);
    UIGraphicsBeginImageContextWithOptions(size , NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *fillColor = [self randomColor];
    CGContextSetFillColorWithColor(context, [fillColor CGColor]);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    CGContextFillRect(context, rect);
    
    fillColor = [self randomColor];
    CGContextSetFillColorWithColor(context, [fillColor CGColor]);
    CGFloat xxx = 3;
    rect = CGRectMake(xxx, xxx, size.width - 2 * xxx, size.height - 2 * xxx);
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)emojiKeyboardView:(AGEmojiKeyboardView *)emojiKeyboardView imageForSelectedCategory:(AGEmojiKeyboardViewCategoryImage)category {
    UIImage *img = [self randomImage];
    [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return img;
}
- (UIImage *)emojiKeyboardView:(AGEmojiKeyboardView *)emojiKeyboardView imageForNonSelectedCategory:(AGEmojiKeyboardViewCategoryImage)category {
    UIImage *img = [self randomImage];
    [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return img;
}

- (UIImage *)backSpaceButtonImageForEmojiKeyboardView:(AGEmojiKeyboardView *)emojiKeyboardView {
//    UIImage *img = [self randomImage];
//    [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    return img;
    return IMAGE(@"connections_chat_backspace");
}

@end
