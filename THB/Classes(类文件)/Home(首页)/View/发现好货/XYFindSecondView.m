//
//  XYFindSecondView.m
//  TestGoodsView
//
//  Created by zhongxueyu on 16/3/23.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "XYFindSecondView.h"
#define ViewHeight frame.size.height
#define ViewWidth  frame.size.width
#define imageWidth 38  // 图片宽度,高度等
#define imageTopH  5  // 图片距顶距离
@implementation XYFindSecondView
@synthesize titleLabel,detailTitleLable;
-(id)initWithFrame:(CGRect)frame title:(NSString *)title detailTitle:(NSString *)detailTitle imageStr:(NSString *)imageStr
{
    self = [super initWithFrame:frame];
//     NSLog(@"frame is %f",CGRectframe);
    NSLog(@"ViewWidth is %f",ViewWidth);
    NSLog(@"ViewHeight is %f",ViewHeight);
    if (self) {
        
        {
            self.layer.borderWidth = 0.2;
            self.layer.borderColor =RGB(220, 220, 220).CGColor;
            //title
            titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, imageTopH,ViewWidth, 15)];
            
            titleLabel.text=title;
            titleLabel.textAlignment=NSTextAlignmentLeft;
            titleLabel.font= kFONT14;
            [self addSubview:titleLabel];
            
            detailTitleLable=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame)+5,ViewWidth, 15)];
            detailTitleLable.text=detailTitle;
            detailTitleLable.textColor = RGB(182, 182, 182);
            detailTitleLable.textAlignment=NSTextAlignmentLeft;
            detailTitleLable.font=kFONT14;
            [self addSubview:detailTitleLable];
        
            //image
            UIImageView *firstImageView=[[UIImageView alloc]initWithFrame:CGRectMake(1,CGRectGetMaxY(detailTitleLable.frame),ViewWidth-2,ViewHeight-imageTopH-CGRectGetHeight(titleLabel.frame)-CGRectGetHeight(detailTitleLable.frame)-8)];
            [firstImageView setUrlImg:imageStr];
            [self addSubview:firstImageView];
            
            
        }
        
    }
    return self;
}

@end
