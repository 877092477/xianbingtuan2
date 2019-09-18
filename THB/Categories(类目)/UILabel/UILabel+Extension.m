//
//  UILabel+Extension.m
//  Weibo11
//
//  Created by JYJ on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+ (instancetype)labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize {
    return [self labelWithTitle:title color:color fontSize:fontSize alignment:NSTextAlignmentCenter];
}

+ (instancetype)labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment {
    
    UILabel *label = [[UILabel alloc] init];
    
    label.text = title;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.numberOfLines = 0;
    label.textAlignment = alignment;
    [label sizeToFit];
    
    return label;
}

+ (instancetype)labelWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font {
    return [self labelWithTitle:title color:color font:font alignment:NSTextAlignmentCenter];
}

+ (instancetype)labelWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font alignment:(NSTextAlignment)alignment {
    
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = color;
    label.font = font;
    label.numberOfLines = 0;
    label.textAlignment = alignment;
    [label sizeToFit];
    return label;
}


- (void)addAttchmentImage:(UIImage *)image andBounds:(CGRect)rect atIndex:(NSInteger)index{
    NSTextAttachment* attchment = [NSTextAttachment new];
    attchment.image = image;
    attchment.bounds = rect;
    NSAttributedString *att = [NSAttributedString attributedStringWithAttachment:attchment];
    NSMutableAttributedString* matt = [[NSMutableAttributedString alloc]initWithString:self.text];
    [matt insertAttributedString:att atIndex:index];
    self.attributedText = matt;
}
- (void)addSingleAttributed:(NSDictionary *)att ofRange:(NSRange)range{
    NSMutableAttributedString* matt = [[NSMutableAttributedString alloc]initWithString:self.text];
    [matt addAttributes:att range:range];
    self.attributedText = matt;
}

//异步获取Label的图片
-(void)HttpLabelLeftImage:(NSString *)imgUrl label:(UILabel *)label imageX:(CGFloat)imageX imageY:(CGFloat)imageY imageH:(CGFloat)imageH atIndex:(NSInteger)index{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        // 处理耗时操作的代码块...
//        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:URL(imgUrl)]];
//        //通知主线程刷新
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //回调或者说是通知主线程刷新，
//            [label addAttchmentImage:img andBounds:CGRectMake(imageX, imageY, imageH*img.size.width/img.size.height, imageH) atIndex:index];
//        });
//    });
    
    [[SDWebImageManager sharedManager] downloadImageWithURL:URL(imgUrl) options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *img, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (finished) {
            [label addAttchmentImage:img andBounds:CGRectMake(imageX, imageY, imageH*img.size.width/img.size.height, imageH) atIndex:index];
        }
    }];
}


#pragma mark - 改变字段字体
- (void)fn_changeFontWithTextFont:(UIFont *)textFont changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSCaseInsensitiveSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSFontAttributeName value:textFont range:textRange];
    }
    self.attributedText = attributedString;
}
#pragma mark - 改变行间距
- (void)fn_changeLineSpaceWithTextLineSpace:(CGFloat)textLineSpace
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:textLineSpace];
    [self fn_changeParagraphStyleWithTextParagraphStyle:paragraphStyle];
}
#pragma mark - 段落样式
- (void)fn_changeParagraphStyleWithTextParagraphStyle:(NSParagraphStyle *)paragraphStyle
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    [self setAttributedText:attributedString];
}
#pragma mark - 改变字段颜色
- (void)fn_changeColorWithTextColor:(UIColor *)textColor
{
    [self fn_changeColorWithTextColor:textColor changeText:self.text];
}
- (void)fn_changeColorWithTextColor:(UIColor *)textColor changeText:(NSString *)text
{
    [self fn_changeColorWithTextColor:textColor changeTexts:@[text]];
}

- (void)fn_changeColorWithTextColor:(UIColor *)textColor changeTexts:(NSArray <NSString *>*)texts
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    for (NSString *text in texts) {
        NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
        if (textRange.location != NSNotFound) {
            [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:textRange];
        }
    }
    self.attributedText = attributedString;
}
#pragma mark - 改变字的删除线 textStrikethroughStyle 为NSUnderlineStyle
- (void)fn_changeStrikethroughStyleWithTextStrikethroughStyle:(NSNumber *)textStrikethroughStyle
{
    [self fn_changeStrikethroughStyleWithTextStrikethroughStyle:textStrikethroughStyle changeText:self.text];
}
- (void)fn_changeStrikethroughStyleWithTextStrikethroughStyle:(NSNumber *)textStrikethroughStyle changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSStrikethroughStyleAttributeName value:textStrikethroughStyle range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的删除线颜色
- (void)fn_changeStrikethroughColorWithTextStrikethroughColor:(UIColor *)textStrikethroughColor
{
    [self fn_changeStrikethroughColorWithTextStrikethroughColor:textStrikethroughColor changeText:self.text];
}
- (void)fn_changeStrikethroughColorWithTextStrikethroughColor:(UIColor *)textStrikethroughColor changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSStrikethroughColorAttributeName value:textStrikethroughColor range:textRange];
    }
    self.attributedText = attributedString;
}
@end
