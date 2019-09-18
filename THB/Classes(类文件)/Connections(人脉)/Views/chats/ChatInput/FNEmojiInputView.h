//
//  FNEmojiInputView.h
//  THB
//
//  Created by Weller Zhao on 2019/1/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNEmojiInputView;
@protocol FNEmojiInputViewDelegate <NSObject>

- (void)didSendClick: (FNEmojiInputView*)inputView;
- (void)inputView: (FNEmojiInputView*)inputView didEmojiClick: (NSString*)emoji;
- (void)didDeleteClick: (FNEmojiInputView*)inputView;

@end

@interface FNEmojiInputView : UIView

@property (nonatomic, weak) id<FNEmojiInputViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
