//
//  PasswordInputView.h
//  THB
//
//  Created by Weller Zhao on 2019/2/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PasswordInputView;
@protocol PasswordInputViewDelegate <NSObject>

- (void) inputView: (PasswordInputView*) inputview didFinishedEdit: (NSString*)text;

@end

@interface PasswordInputView : UIView

@property (nonatomic, weak) id<PasswordInputViewDelegate> delegate;


/**
 初始化

 @param count 密码个数
 @return 
 */
- (instancetype)initWithCount:(int)count;

- (void)becomeFirstResponder;
- (void)clearUpPassword;

- (NSString*)getText;

@end

NS_ASSUME_NONNULL_END
