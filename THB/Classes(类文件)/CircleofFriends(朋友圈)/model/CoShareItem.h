//
//  CoShareItem.h
//  THB
//
//  Created by Jimmy on 2018/8/30.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoShareItem : NSObject<UIActivityItemSource>
-(instancetype)initWithData:(UIImage *)img andFile:(NSURL *)file;

@property (nonatomic, strong) UIImage *img;
@property (nonatomic, strong) NSURL *path;
@end
