//
//  FNChatInputView.h
//  THB
//
//  Created by Weller Zhao on 2019/1/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNChatInputView;
@protocol FNChatInputViewDelegate <NSObject>

- (void)inputView: (FNChatInputView*)inputView didVoiceButtonClick: (id)sender;
- (void)inputView: (FNChatInputView*)inputView didKeyboardButtonClick: (id)sender;
- (void)inputView: (FNChatInputView*)inputView didEmojiButtonClick: (id)sender;
- (void)inputView: (FNChatInputView*)inputView didAddButtonClick: (id)sender;
- (void)inputView: (FNChatInputView*)inputView didSendButtonClick: (id)sender;


// 录音长按
- (void)inputView: (FNChatInputView*)inputView didVoicePressBegan: (id)sender;
// 录音结束
- (void)inputView: (FNChatInputView*)inputView didVoicePressEnded: (id)sender;
// 上滑
- (void)inputView: (FNChatInputView*)inputView didVoicePressUp: (id)sender;
// 手势复位
- (void)inputView: (FNChatInputView*)inputView didVoicePressReset: (id)sender;

@end


@interface FNChatInputView : UIView

@property (nonatomic, strong) UITextView  *txvInput;
@property (nonatomic, weak) id<FNChatInputViewDelegate> delegate;


/**
 在光标位置插入字符串

 @param str
 */
- (void)insertString: (NSString*)str;

/**
 删除光标所在字符
 */
- (void)deleteString;

- (void)clearText;

- (void)beginEdit;

@end

NS_ASSUME_NONNULL_END
