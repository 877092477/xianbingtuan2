//
//  XYShopRebatesCell.m
//  THB
//
//  Created by zhongxueyu on 16/3/24.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "XYShopRebatesCell.h"

@implementation XYShopRebatesCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //给Cell加边框
        self.contentView.layer.masksToBounds=YES;
        self.contentView.layer.borderWidth=1.0f; //边框宽度
        self.contentView.layer.borderColor=[RGB(220, 220, 220)CGColor];
        // Initialization code
        //        self.backgroundColor = [UIColor purpleColor];
        
//        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)/2)];
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(4, 10, CGRectGetWidth(self.contentView.frame)-8, 50)];
        self.imgView.contentMode = UIViewContentModeScaleAspectFit;

        [self.contentView addSubview:self.imgView];
        
        self.rebates = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)/2+CGRectGetHeight(self.frame)/4, CGRectGetWidth(self.frame), 20)];
        self.rebates.font = kFONT14;
        self.rebates.textAlignment = NSTextAlignmentCenter;
        self.rebates.adjustsFontSizeToFitWidth = YES;
        self.rebates.textColor = [UIColor grayColor];
        self.rebates.alpha = 0.f;
        
        // 执行动画
        [UIView animateWithDuration:IMGDuration animations:^{
            self.rebates.alpha = 1.f;
        }];
        [self addSubview:self.rebates];
        
    }
    return self;
}

@end
