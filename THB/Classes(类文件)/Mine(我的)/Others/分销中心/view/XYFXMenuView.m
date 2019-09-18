//
//  XYFXMenuView.m
//  THB
//
//  Created by zhongxueyu on 16/7/29.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "XYFXMenuView.h"
#define frameWidth frame.size.width
#define imageWidth 38  // 图片宽度,高度等
#define imageTopH  15  // 图片距顶距离

@implementation XYFXMenuView

-(id)initWithFrame:(CGRect)frame title:(NSString *)title imageStr:(NSString *)imageStr{
    self = [super initWithFrame:frame];
    if (self) {
        
        {
            // image
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake((frameWidth-imageWidth)/2,imageTopH,imageWidth,imageWidth)];

            imageView.image = IMAGE(imageStr);
            //            imageView.image=[UIImage imageNamed:imageStr];
            [self addSubview:imageView];
        }
        
        {
            // title
            UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, imageTopH+imageWidth+5,frameWidth, imageWidth/2)];
            titleLabel.text=title;
            titleLabel.textAlignment=NSTextAlignmentCenter;
            titleLabel.font=kFONT14;
            [self addSubview:titleLabel];
        }
    }
    return self;
}
@end
