//
//  FNHSecKillTBDSectionHeaderView.m
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 16/8/5.
//  Copyright © 2016年 jimmy. All rights reserved.
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

#import "FNHSecKillTBDSectionHeaderView.h"
#import "JMDrawLine.h"
@implementation FNHSecKillTBDSectionHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    UIImageView *timeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_seckill_time"]];
    [timeImageView sizeToFit];
    [self addSubview:timeImageView];
    
    UILabel *starLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    starLabel.text = @"即将开抢";
    starLabel.font = FNFontDefault(FNGlobalFontNormalSize);
    [self addSubview:starLabel];
    
    JMDrawLine *bottomLine = [JMDrawLine createLineInRect:CGRectMake(0, self.height-1, self.width, 1) drawType:RealLineHorizonal andColor:FNHomeBackgroundColor];
    [self addSubview:bottomLine];
    //layout
    CGFloat horizonalMargin = 20;
    [timeImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [timeImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:horizonalMargin];
    [timeImageView autoSetDimensionsToSize:timeImageView.size];
    
    [starLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [starLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:timeImageView withOffset:horizonalMargin];
    
}

@end
