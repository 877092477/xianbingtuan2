//
//  FNJZImageTool.m
//  THB
//
//  Created by Jimmy on 2018/9/18.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNJZImageTool.h"

@implementation FNJZImageTool
//将图片保存到本地
+ (void)SaveImageToLocal:(UIImage*)image Keys:(NSString*)key {
    
    //首先,需要获取沙盒路径
    NSString *picPath=[NSString stringWithFormat:@"%@/Documents/%@.gif",NSHomeDirectory(),key];
    
    NSLog(@"将图片保存到本地  %@",picPath);
    
    BOOL isHaveImage = [self LocalHaveImage:key];
    if (isHaveImage) {
        NSLog(@"本地已经保存该图片、无需再次存储...");
        return ;
    }
    
    NSData *imgData = UIImageJPEGRepresentation(image,0.5);
    [imgData writeToFile:picPath atomically:YES];
    
}
+ (void)SaveImageDataToLocal:(NSData*)imageData Keys:(NSString*)key{
    
    //首先,需要获取沙盒路径
    NSString *picPath=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),key];
    
    NSLog(@"将图片保存到本地  %@",picPath);
    
    BOOL isHaveImage = [self LocalHaveDataImage:key];
    if (isHaveImage) {
        NSLog(@"本地已经保存该图片、无需再次存储...");
        return ;
    }
    [imageData writeToFile:picPath atomically:YES];
    
}

//从本地获取图片
+ (NSData*)GetImageFromDataLocal:(NSString*)key {
    
    if (!key) {
        return nil;
    }
    
    //读取本地图片非resource
    NSString *picPath=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),key];
    
    NSLog(@"获取图片   %@",picPath);
    
    //NSData* dataimg=[[UIImage alloc]initWithContentsOfFile:picPath];
    NSData *dataimg =[NSData dataWithContentsOfFile:picPath options:0 error:NULL];
    
    return dataimg;
    
}

//从本地获取图片
+ (UIImage*)GetImageFromLocal:(NSString*)key {
    
    if (!key) {
        return nil;
    }
    
    //读取本地图片非resource
    NSString *picPath=[NSString stringWithFormat:@"%@/Documents/%@.gif",NSHomeDirectory(),key];
    
    NSLog(@"获取图片   %@",picPath);
    
    UIImage *img=[[UIImage alloc]initWithContentsOfFile:picPath];
    
    return img;
    
}

//本地是否有图片
+ (BOOL)LocalHaveImage:(NSString*)key {
    
    if (!key) {
        return NO;
    }
    
    //读取本地图片非resource
    NSString *picPath=[NSString stringWithFormat:@"%@/Documents/%@.gif",NSHomeDirectory(),key];
    
    NSLog(@"查询是否存在 %@",picPath);
    
    UIImage *img=[[UIImage alloc]initWithContentsOfFile:picPath];
    
    if (img) {
        return YES;
    }
    return NO;
    
}
//本地是否有图片
+ (BOOL)LocalHaveDataImage:(NSString*)key {
    
    if (!key) {
        return NO;
    }
    
    //读取本地图片非resource
    NSString *picPath=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),key];
    
    NSLog(@"查询是否存在 %@",picPath);
    
    if (picPath) {
        return YES;
    }
    return NO;
    
}



//将图片从本地删除
+ (void)RemoveImageToLocalKeys:(NSString*)key {
    
    NSString *picPath=[NSString stringWithFormat:@"%@/Documents/%@.gif",NSHomeDirectory(),key];
    NSLog(@"将图片从本地删除  %@",picPath);
    [[NSFileManager defaultManager] removeItemAtPath:picPath error:nil];
}

@end
