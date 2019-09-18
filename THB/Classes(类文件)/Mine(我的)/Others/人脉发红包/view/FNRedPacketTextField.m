//
//  FNRedPacketTextField.m
//  THB
//
//  Created by Jimmy on 2019/2/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNRedPacketTextField.h"

@implementation FNRedPacketTextField

// 创建
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
//通过xib创建
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpUI];
}

- (void)setUpUI
{
    
    //字体大小
    self.font = [UIFont systemFontOfSize:15];
    //字体颜色
    self.textColor =  [UIColor blackColor];
    //光标颜色
    self.tintColor= self.textColor;
    //占位符的颜色和大小
    [self setValue:RGB(204, 204, 204) forKeyPath:@"_placeholderLabel.textColor"];
    [self setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    // 不成为第一响应者
    [self resignFirstResponder];
}
/**
 * 当前文本框聚焦时就会调用
 */
- (BOOL)becomeFirstResponder
{
    // 修改占位文字颜色
    [self setValue:RGB(204, 204, 204) forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}

/**
 * 当前文本框失去焦点时就会调用
 */
- (BOOL)resignFirstResponder
{
    // 修改占位文字颜色
    [self setValue:RGB(204, 204, 204) forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}
////控制placeHolder的位置
//-(CGRect)placeholderRectForBounds:(CGRect)bounds
//{
//    
//    CGSize placeholderSize = [[self placeholder]sizeWithAttributes:
//                   @{NSFontAttributeName:self.font}];
//                   
//    CGRect inset = CGRectMake(bounds.size.width-placeholderSize.width-5, bounds.origin.y, bounds.size.width -5, bounds.size.height);
//    return inset;
//}
//
////控制显示文本的位置
//-(CGRect)textRectForBounds:(CGRect)bounds
//{
//    CGSize textSize = [[self text]sizeWithAttributes:
//                              @{NSFontAttributeName:self.font}];
//    CGRect inset = CGRectMake(bounds.size.width-textSize.width-5, bounds.origin.y, bounds.size.width -5, bounds.size.height);
//    return inset;
//}
//
////控制编辑文本的位置
//-(CGRect)editingRectForBounds:(CGRect)bounds
//{
//    CGSize textSize = [[self text]sizeWithAttributes:
//                       @{NSFontAttributeName:self.font}];
//    CGRect inset = CGRectMake(bounds.size.width-textSize.width-5, bounds.origin.y, bounds.size.width -5, bounds.size.height);
//    return inset;
//}

@end
