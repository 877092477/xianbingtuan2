//
//  UIImage+Extension.h
//  JYJ微博
//
//  Created by JYJ on 15/3/11.
//  Copyright (c) 2015年 JYJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  返回拉伸图片
 */
+ (UIImage *)resizedImage:(NSString *)name;
/**
 *  用颜色返回一张图片
 */
+ (UIImage *)createImageWithColor:(UIColor*) color;
/**
 *  带边框的图片
 *
 *  @param name        图片
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;


/**
 *  使用图像名创建图像视图
 *
 *  @param imageName 图像名称
 *
 *  @return UIImageView
 */
+ (instancetype)imageViewWithImageName:(NSString *)imageName;

/**
 * 圆形图片
 */
- (UIImage *)circleImage;
-(UIImage*)transformtoSize:(CGSize)Newsize;

/**
 不模糊缩放图片返回新尺寸图片
 */
-(UIImage *)scaleFromImage:(UIImage *)image toSize:(CGSize)size;

/**
 将图片压缩到指定大小
 */

+(UIImage *)scaleImage:(UIImage *)image toKb:(NSInteger)kb;

+ (NSData *)scaleData:(UIImage *)image toKb:(NSInteger)kb;

@end
