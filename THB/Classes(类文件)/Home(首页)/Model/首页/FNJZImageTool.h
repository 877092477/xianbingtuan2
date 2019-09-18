//
//  FNJZImageTool.h
//  THB
//
//  Created by Jimmy on 2018/9/18.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNJZImageTool : NSObject
//将图片保存到本地
+ (void)SaveImageToLocal:(UIImage*)image Keys:(NSString*)key;

//本地是否有相关图片
+ (BOOL)LocalHaveImage:(NSString*)key;

//从本地获取图片
+ (UIImage*)GetImageFromLocal:(NSString*)key;

//将图片从本地删除
+ (void)RemoveImageToLocalKeys:(NSString*)key;
//存储DataImage
+ (void)SaveImageDataToLocal:(NSData*)imageData Keys:(NSString*)key;
//从本地获取图片data
+ (NSData*)GetImageFromDataLocal:(NSString*)key;
@end
