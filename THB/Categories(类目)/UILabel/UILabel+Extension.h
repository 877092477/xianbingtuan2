//
//  UILabel+Extension.h
//  Weibo11
//
//  Created by JYJ on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

/**
* 创建 UILabel
*
*  @param title    标题
*  @param color    标题颜色
*  @param fontSize 字体大小
*
*  @return UILabel(文本水平居中)
*/
+ (instancetype)labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize;


/**
 * 创建 UILabel
 *
 *  @param title    标题
 *  @param color    标题颜色
 *  @param font     字体
 *
 *  @return UILabel(文本水平居中)
 */
+ (instancetype)labelWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font;


/**
 *  创建 UILabel
 *
 *  @param title     标题
 *  @param color     标题颜色
 *  @param fontSize  字体大小
 *  @param alignment 对齐方式
 *
 *  @return UILabel
 */
+ (instancetype)labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment;


/**
 *  创建 UILabel
 *
 *  @param title     标题
 *  @param color     标题颜色
 *  @param font      字体
 *  @param alignment 对齐方式
 *
 *  @return UILabel
 */
+ (instancetype)labelWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font alignment:(NSTextAlignment)alignment;

/**
 添加图片
 
 @param image 图片
 @param rect bounds
 @param index 添加位置
 */
- (void)addAttchmentImage:(UIImage *)image andBounds:(CGRect)rect atIndex:(NSInteger)index;

/**
 添加属性
 
 @param att 属性
 @param range 范围
 */
- (void)addSingleAttributed:(NSDictionary *)att ofRange:(NSRange)range;

//异步获取图片
-(void)HttpLabelLeftImage:(NSString *)imgUrl label:(UILabel *)label imageX:(CGFloat)imageX imageY:(CGFloat)imageY imageH:(CGFloat)imageH atIndex:(NSInteger)index;


#pragma mark - 改变字段字体
/**
 *  改变句中某些字段的字体
 *
 *  @param textFont 改变的字体
 *  @param text     改变的字段
 */
- (void)fn_changeFontWithTextFont:(UIFont *)textFont changeText:(NSString *)text;
#pragma mark - 改变行间距
/**
 *  改变句中所有的行间距
 *
 *  @param lineSpace 改变的行间距
 */
- (void)fn_changeLineSpaceWithTextLineSpace:(CGFloat)textLineSpace;
/**
 *  改变句中段落样式
 *
 *  @param paragraphStyle 段落样式
 */
- (void)fn_changeParagraphStyleWithTextParagraphStyle:(NSParagraphStyle *)paragraphStyle;
#pragma mark - 改变字段颜色
/**
 *  改变句中所有字体颜色
 *
 *  @param textColor 改变的颜色
 */
- (void)fn_changeColorWithTextColor:(UIColor *)textColor;
/**
 *  改变句中某些字段的字体颜色
 *
 *  @param textColor 改变的颜色
 *  @param text      改变的字段
 */
- (void)fn_changeColorWithTextColor:(UIColor *)textColor changeText:(NSString *)text;

/**
 *  改变句中一些字段的字体颜色
 *
 *  @param textColor 改变的颜色
 *  @param texts     改变的字段们
 */
- (void)fn_changeColorWithTextColor:(UIColor *)textColor changeTexts:(NSArray <NSString *>*)texts;

#pragma mark - 改变字的删除线 textStrikethroughStyle 为NSUnderlineStyle
/**
 *  改变所有字段的删除线
 *
 *  @param textStrikethroughStyle 改变的删除线类型
 */
- (void)fn_changeStrikethroughStyleWithTextStrikethroughStyle:(NSNumber *)textStrikethroughStyle;
/**
 *  改变句中某些字段的删除线
 *
 *  @param textStrikethroughStyle 改变的删除线类型
 *  @param text                   改变的字段
 */
- (void)fn_changeStrikethroughStyleWithTextStrikethroughStyle:(NSNumber *)textStrikethroughStyle changeText:(NSString *)text;

#pragma mark - 改变字的删除线颜色
/**
 *  改变所有字段的删除线颜色
 *
 *  @param textStrikethroughColor 改变的删除线颜色
 */
- (void)fn_changeStrikethroughColorWithTextStrikethroughColor:(UIColor *)textStrikethroughColor NS_AVAILABLE(10_0, 7_0);
/**
 *  改变句中某些字段的删除线颜色
 *
 *  @param textStrikethroughColor 改变的删除线颜色
 *  @param text                   改变的字段
 */
- (void)fn_changeStrikethroughColorWithTextStrikethroughColor:(UIColor *)textStrikethroughColor changeText:(NSString *)text NS_AVAILABLE(10_0, 7_0);
@end
