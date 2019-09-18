//
//  CatagoryProductCell.m
//  THB
//
//  Created by zhongxueyu on 16/4/6.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有 2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "CatagoryProductCell.h"

@implementation CatagoryProductCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //给图片加边框
        self.imgView.layer.masksToBounds=YES;
        self.imgView.layer.borderWidth=3.0f; //边框宽度
        self.imgView.layer.borderColor=[RGB(238, 238, 238) CGColor];//边框颜色
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, CGRectGetWidth(self.frame)-2, CGRectGetWidth(self.frame))];
//        self.imgView.alpha = 0.f;
//        
//        // 执行动画
//        [UIView animateWithDuration:IMGDuration animations:^{
//            self.imgView.alpha = 1.f;
//        }];
        [self addSubview:self.imgView];
        
        //标题
        self.goodsTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgView.frame)+2, CGRectGetWidth(self.frame), 20)];
        self.goodsTitle.font = kFONT13;
        self.goodsTitle.textColor = RGB(123, 122, 123);
        self.goodsTitle.textAlignment = NSTextAlignmentCenter;
//        self.goodsTitle.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.goodsTitle];
        
    }
    return self;
}
@end
