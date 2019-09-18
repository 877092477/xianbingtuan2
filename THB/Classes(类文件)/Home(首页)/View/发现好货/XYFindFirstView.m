//
//  XYFindFirstView.m
//  TestGoodsView
//
//  Created by zhongxueyu on 16/3/23.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "XYFindFirstView.h"
#define ViewHeight frame.size.height
#define ViewWidth  frame.size.width
#define imageWidth 38  // 图片宽度,高度等
#define imageTopH  8  // 图片距顶距离
@implementation XYFindFirstView
@synthesize titleLabel,detailTitleLable;
-(id)initWithFrame:(CGRect)frame title:(NSString *)title detailTitle:(NSString *)detailTitle image1Str:(NSString *)image1 image2Str:(NSString *)image2
{
    self = [super initWithFrame:frame];
    if (self) {
        
        {
            self.layer.borderWidth = 0.2;
            self.layer.borderColor = RGB(220, 220, 220).CGColor;
            //title
            titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, imageTopH,ViewWidth/2, 15)];
            titleLabel.text=title;
            titleLabel.textAlignment=NSTextAlignmentLeft;
            titleLabel.font=kFONT14;
            [self addSubview:titleLabel];
            
            detailTitleLable=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame)+5,ViewWidth/2, 15)];
            detailTitleLable.text=detailTitle;
            detailTitleLable.textColor = RGB(182, 182, 182);
            detailTitleLable.textAlignment=NSTextAlignmentLeft;
            detailTitleLable.font=kFONT14;
            [self addSubview:detailTitleLable];
        }
        {
//            XYLog(@"imgArray is %@",imageStr);
            //image
            UIImageView *firstImageView=[[UIImageView alloc]initWithFrame:CGRectMake(1,CGRectGetMaxY(detailTitleLable.frame),ViewWidth/2-2,ViewHeight-imageTopH-CGRectGetHeight(titleLabel.frame)-CGRectGetHeight(detailTitleLable.frame)-8)];
            [firstImageView setUrlImg:image1];
            [self addSubview:firstImageView];
            XYLog(@"image1 is %@",image1);
            UIImageView *secondImageView=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(firstImageView.frame),ViewHeight/2-(ViewWidth/4),ViewWidth/2,ViewWidth/2)];
            [secondImageView setUrlImg:image2];
            XYLog(@"image1 is %@",image2);
            [self addSubview:secondImageView];
        }
        
    }
    return self;
}
@end
