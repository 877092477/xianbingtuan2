//
//  PasswordInputView.m
//  THB
//
//  Created by Weller Zhao on 2019/2/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "PasswordInputView.h"

@interface PasswordInputView()<UITextFieldDelegate>

@property (nonatomic, assign) int count;

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSMutableArray *dotArray; //用于存放黑色的点点

@end

@implementation PasswordInputView

- (instancetype)initWithCount:(int)count
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.count = count;
        [self configUI];
    }
    return self;
}

- (void)becomeFirstResponder {
    [self.textField becomeFirstResponder];
}

- (void)configUI {
    [self addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    //页面出现时让键盘弹出
    [self.textField becomeFirstResponder];
    [self initPwdTextField];
    
    @weakify(self)
    [self addJXTouch:^{
        [self_weak_ becomeFirstResponder];
    }];
}

- (NSString*)getText {
    return self.textField.text;
}

- (void)initPwdTextField
{
    NSMutableArray<UIView*> *squares = [[NSMutableArray alloc] init];
    for (int i = 0; i < _count; i ++) {
        UIView *vSquare = [[UIView alloc] init];
        [squares addObject:vSquare];
        [self addSubview:vSquare];
        int index = i;
        [vSquare mas_makeConstraints:^(MASConstraintMaker *make) {
            if (index == 0) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(squares[index - 1].mas_right);
                make.width.equalTo(squares[index - 1]);
            }
            make.top.bottom.equalTo(@0);
            if (index == _count - 1)
                make.right.equalTo(@0);
        }];
    }
    for (int i = 0; i < _count - 1; i ++) {
        UIView *line = [[UIView alloc] init];
        [self addSubview:line];
        int index = i;
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(squares[index].mas_right);
            make.top.bottom.equalTo(@0);
            make.width.mas_equalTo(1);
        }];
        line.backgroundColor = [UIColor grayColor];
    }
    self.dotArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < _count; i ++) {
        UIView *point = [[UIView alloc] init];
        [self.dotArray addObject:point];
        [self addSubview:point];
        int index = i;
        [point mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(8);
            make.center.equalTo(squares[index]);
        }];
        point.backgroundColor = [UIColor blackColor];
        point.layer.cornerRadius = 4;
        point.clipsToBounds = YES;
        point.hidden = YES; //先隐藏
        
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"变化%@", string);
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if(string.length == 0) {
        //判断是不是删除键
        return YES;
    }
    else if(textField.text.length >= _count) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        NSLog(@"输入的字符个数大于6，忽略输入");
        return NO;
    } else {
        return YES;
    }
}

/**
 *  清除密码
 */
- (void)clearUpPassword
{
    self.textField.text = @"";
    [self textFieldDidChange:self.textField];
}

/**
 *  重置显示的点
 */
- (void)textFieldDidChange:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
    for (UIView *dotView in self.dotArray) {
        dotView.hidden = YES;
    }
    for (int i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.dotArray objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == _count) {
        NSLog(@"输入完毕");
        if ([_delegate respondsToSelector:@selector(inputView:didFinishedEdit:)]) {
            [_delegate inputView:self didFinishedEdit:textField.text];
        }
    }
}

#pragma mark - init

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        _textField.backgroundColor = [UIColor whiteColor];
        //输入的文字颜色为白色
        _textField.textColor = [UIColor whiteColor];
        //输入框光标的颜色为白色
        _textField.tintColor = [UIColor whiteColor];
        _textField.delegate = self;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.layer.borderColor = [[UIColor grayColor] CGColor];
        _textField.layer.borderWidth = 1;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

/**
 * /禁止可被粘贴复制
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

@end
