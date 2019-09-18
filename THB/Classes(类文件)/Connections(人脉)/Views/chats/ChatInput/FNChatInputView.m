//
//  FNChatInputView.m
//  THB
//
//  Created by Weller Zhao on 2019/1/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNChatInputView.h"

@interface FNChatInputView() <UITextViewDelegate>

@property (nonatomic, strong) UIButton *btnLeft;
@property (nonatomic, strong) UIButton *btnHolder;
@property (nonatomic, strong) UIButton *btnEmoji;
@property (nonatomic, strong) UIButton *btnAdd;
@property (nonatomic, strong) UIButton *btnSend;

@property (nonatomic, assign, setter=setIsVoice:) BOOL isVoice;
@property (nonatomic, assign, setter=setIsEmoji:) BOOL isEmoji;
@property (nonatomic, assign) CGFloat inputHeight;

@property (nonatomic, assign) BOOL isUp;

@end

@implementation FNChatInputView

#define MinHeight 50

#define InputMinHeight 30
#define InputMaxHeight 90

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _inputHeight = InputMinHeight;
        _isVoice = YES;
        _isEmoji = YES;
        _isUp = NO;
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(MinHeight).priorityHigh();
    }];
    
    _btnLeft = [[UIButton alloc] init];
    _txvInput = [[UITextView alloc] init];
    _btnHolder = [[UIButton alloc] init];
    _btnEmoji = [[UIButton alloc] init];
    _btnAdd = [[UIButton alloc] init];
    _btnSend = [[UIButton alloc] init];
    
    [self addSubview:_btnLeft];
    [self addSubview:_txvInput];
    [self addSubview:_btnHolder];
    [self addSubview:_btnEmoji];
    [self addSubview:_btnAdd];
    [self addSubview:_btnSend];
    
    @weakify(self)
    [_btnLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.width.height.mas_equalTo(MinHeight);
        make.bottom.equalTo(@0);
        make.top.greaterThanOrEqualTo(@0);
    }];
    [_txvInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self_weak_.btnLeft.mas_right);
        make.right.equalTo(self_weak_.btnEmoji.mas_left);
        make.top.equalTo(@10);
        make.bottom.equalTo(@-10);
        make.height.mas_equalTo(InputMinHeight);
    }];
    [_btnHolder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self_weak_.btnLeft.mas_right);
        make.right.equalTo(self_weak_.btnEmoji.mas_left);
        make.bottom.equalTo(@0);
        make.height.mas_equalTo(MinHeight);
    }];
    [_btnEmoji mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self_weak_.btnAdd.mas_left);
        make.width.height.mas_equalTo(MinHeight);
        make.bottom.equalTo(@0);
        make.top.greaterThanOrEqualTo(@0);
    }];
    [_btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.width.height.mas_equalTo(MinHeight);
        make.bottom.equalTo(@0);
        make.top.greaterThanOrEqualTo(@0);
    }];
    
    [_btnSend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(MinHeight);
        make.bottom.equalTo(@0);
        make.top.greaterThanOrEqualTo(@0);
    }];
    
    [_btnLeft setImage:IMAGE(@"connection_button_voice") forState:UIControlStateNormal];
    [_btnEmoji setImage:IMAGE(@"connection_button_emoji") forState:UIControlStateNormal];
    [_btnAdd setImage:IMAGE(@"connection_button_add") forState:UIControlStateNormal];
    _btnSend.backgroundColor = RGB(75, 151, 243);
    _btnSend.cornerRadius = 4;
    [_btnSend setTitle:@"发送" forState:UIControlStateNormal];
    [_btnSend setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    _btnSend.titleLabel.font = kFONT14;
    
    _txvInput.borderColor = FNHomeBackgroundColor;
    _txvInput.borderWidth = 1;
    _txvInput.font = kFONT16;
    _txvInput.cornerRadius = 4;
    _txvInput.allowsEditingTextAttributes = YES;
    _txvInput.returnKeyType = UIReturnKeySend;
    _txvInput.delegate = self;
    
    [_btnHolder setHidden:YES];
    [_btnHolder setTitle:@"按住 说话" forState:UIControlStateNormal];
    [_btnHolder setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    _btnHolder.titleLabel.font = [UIFont systemFontOfSize:14];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longPressGesture.minimumPressDuration = 0.2;
    [_btnHolder addGestureRecognizer:longPressGesture];
    
    [_btnLeft addTarget:self action:@selector(onLeftButtonClick:)];
    [_btnEmoji addTarget:self action:@selector(onEmojiButtonClick:)];
    [_btnAdd addTarget:self action:@selector(onAddButtonClick:)];
    [_btnSend addTarget:self action:@selector(onSendButtonClick:)];
}

- (void) showSend {
    [_btnAdd mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btnSend.mas_left).offset(-8);
        make.width.height.mas_equalTo(MinHeight);
        make.bottom.equalTo(@0);
        make.top.greaterThanOrEqualTo(@0);
    }];
    
    [_btnSend mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-8);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(MinHeight- 20);
        make.centerY.equalTo(@0);
        
    }];
}

- (void) hideSend {
    [_btnAdd mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.width.height.mas_equalTo(MinHeight);
        make.bottom.equalTo(@0);
        make.top.greaterThanOrEqualTo(@10);
    }];
    
    [_btnSend mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(MinHeight);
        make.bottom.equalTo(@0);
        make.top.greaterThanOrEqualTo(@0);
    }];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    
    NSLog(@"%@", self.txvInput.text);
    if (_txvInput.text.length > 0) {
        [self showSend];
    } else {
        [self hideSend];
    }
    CGRect frame = self.txvInput.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [self.txvInput sizeThatFits:constraintSize];
    if (size.height<=InputMinHeight) {
        size.height=InputMinHeight;
    }else{
        if (size.height >= InputMaxHeight)
        {
            size.height = InputMaxHeight;
            self.txvInput.scrollEnabled = YES;   // 允许滚动
        }
        else
        {
            self.txvInput.scrollEnabled = NO;    // 不允许滚动
        }
    }
    @weakify(self)
    [UIView animateWithDuration:0.2 animations:^{
        [self_weak_.txvInput mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height);
        }];
        [self_weak_ layoutIfNeeded];
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        if ([_delegate respondsToSelector: @selector(inputView:didSendButtonClick:)]) {
            [_delegate inputView:self didSendButtonClick:textView];
        }
        return NO;
    }return YES;
    
}


#pragma mark - Action

- (void)onLeftButtonClick: (id)sender {
    
    if (_isVoice) {
        _isEmoji = YES;
        [self.btnLeft setImage:IMAGE(@"connection_button_keyboard") forState:UIControlStateNormal];
        [self.btnEmoji setImage:IMAGE(@"connection_button_emoji") forState:UIControlStateNormal];
        if ([_delegate respondsToSelector:@selector(inputView:didVoiceButtonClick:)]) {
            [_delegate inputView:self didVoiceButtonClick:sender];
        }
    } else {
        [self.btnLeft setImage:IMAGE(@"connection_button_voice") forState:UIControlStateNormal];
        if ([_delegate respondsToSelector:@selector(inputView:didKeyboardButtonClick:)]) {
            [_delegate inputView:self didKeyboardButtonClick:sender];
        }
    }
    
    self.isVoice = !self.isVoice;
}

- (void)onEmojiButtonClick: (id)sender {
    if (_isEmoji) {
        if ([_delegate respondsToSelector:@selector(inputView:didEmojiButtonClick:)]) {
            [_delegate inputView:self didEmojiButtonClick:sender];
        }
    } else {
        if ([_delegate respondsToSelector:@selector(inputView:didKeyboardButtonClick:)]) {
            [_delegate inputView:self didKeyboardButtonClick:sender];
        }
    }
    
    self.isEmoji = !self.isEmoji;
}

- (void)onAddButtonClick: (id)sender {
    if ([_delegate respondsToSelector:@selector(inputView:didAddButtonClick:)]) {
        [_delegate inputView:self didAddButtonClick:sender];
    }
}

- (void)onSendButtonClick: (id)sender {
    if ([_delegate respondsToSelector: @selector(inputView:didSendButtonClick:)]) {
        [_delegate inputView:self didSendButtonClick:sender];
    }
}

# pragma mark - Guesture
- (void)longPress: (UILongPressGestureRecognizer*)gesture {
    CGPoint point = [gesture locationInView:self.btnHolder];
    switch (gesture.state) {
            
        case UIGestureRecognizerStateBegan:
            if ([_delegate respondsToSelector:@selector(inputView:didVoicePressBegan:)]) {
                [_delegate inputView:self didVoicePressBegan:gesture.view];
            }
            break;
        case UIGestureRecognizerStateEnded:
            if ([_delegate respondsToSelector:@selector(inputView:didVoicePressEnded:)]) {
                [_delegate inputView:self didVoicePressEnded:gesture.view];
            }
            break;
        case UIGestureRecognizerStateChanged:
            if (point.y < 0 && !_isUp) {
                if ([_delegate respondsToSelector:@selector(inputView:didVoicePressUp:)]) {
                    [_delegate inputView:self didVoicePressUp:gesture.view];
                }
                _isUp = YES;
            } else if (point.y > 0  && _isUp){
                if ([_delegate respondsToSelector:@selector(inputView:didVoicePressReset:)]) {
                    [_delegate inputView:self didVoicePressReset:gesture.view];
                }
                _isUp = NO;
            }
            break;
        case UIGestureRecognizerStateCancelled:
            if ([_delegate respondsToSelector:@selector(inputView:didVoicePressEnded:)]) {
                [_delegate inputView:self didVoicePressEnded:gesture.view];
            }
            break;
        default:
            break;
    }
}

# pragma mark -

- (void)beginEdit {
    [self.txvInput becomeFirstResponder];
}

- (void)insertString: (NSString*)str {
    //存储光标位置
    int location = (int)self.txvInput.selectedRange.location;
    //插入表情
    [self.txvInput.textStorage insertAttributedString:[[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName: kFONT16}] atIndex:location];
    //光标位置移动1个单位
    self.txvInput.selectedRange = NSMakeRange(location+str.length, 0);
    [self textViewDidChange:self.txvInput];
}


- (void)deleteString {
    if (self.txvInput.text.length > 0) {
        [self.txvInput deleteBackward];
    }
}

- (void)clearText {
    self.txvInput.text = @"";
    [self textViewDidChange:self.txvInput];
}

- (void)reset {
    self.isEmoji = YES;
    self.isVoice = YES;
}

- (void) setIsEmoji:(BOOL)isEmoji {
    _isEmoji = isEmoji;
    self.isVoice = YES;
    if (!isEmoji) {
        [_btnHolder setHidden:YES];
        [self.btnLeft setImage:IMAGE(@"connection_button_voice") forState:UIControlStateNormal];
        [self.btnEmoji setImage:IMAGE(@"connection_button_keyboard") forState:UIControlStateNormal];
    } else {
        [self.btnEmoji setImage:IMAGE(@"connection_button_emoji") forState:UIControlStateNormal];
    }
}

- (void) setIsVoice:(BOOL)isVoice {
    _isVoice = isVoice;
    if (!isVoice) {
        _isEmoji = YES;
        [self.btnLeft setImage:IMAGE(@"connection_button_keyboard") forState:UIControlStateNormal];
        [self.btnEmoji setImage:IMAGE(@"connection_button_emoji") forState:UIControlStateNormal];

    } else {
        [self.btnLeft setImage:IMAGE(@"connection_button_voice") forState:UIControlStateNormal];
    }
    
    [_btnHolder setHidden:isVoice];
}

@end
