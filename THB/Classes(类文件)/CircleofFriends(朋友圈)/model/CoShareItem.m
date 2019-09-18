//
//  CoShareItem.m
//  THB
//
//  Created by Jimmy on 2018/8/30.
//  Copyright © 2018年 方诺科技. All rights reserved.
//
//分享图片
#import "CoShareItem.h"

@implementation CoShareItem

-(instancetype)initWithData:(UIImage *)img andFile:(NSURL *)file
{
    self = [super init];
    if (self) {
        _img = img;
        _path = file;
    }
    return self;
}

-(instancetype)init
{
    //不期望这种初始化方式，所以返回nil了。
    return nil;
}

#pragma mark - UIActivityItemSource
-(id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController
{
    return _img;
}

-(id)activityViewController:(UIActivityViewController *)activityViewController itemForActivityType:(NSString *)activityType
{
    return _path;
}


 
@end
