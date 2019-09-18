//
//  FNSecKillTitleView.m
//  LikeFeiNiuShopApp
//
//  Created by jimmy on 2017/1/11.
//  Copyright © 2017年 方诺科技. All rights reserved.
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
#import "FNSecKillTitleView.h"
#define WordsKern 4.0
@implementation FNSecKillTitleView
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
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = kFONT14;
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    
    UILabel *subscribeLabel = [UILabel new];
    subscribeLabel.font = kFONT14;
    [self addSubview:subscribeLabel];
    _subscribeLabel = subscribeLabel;
    
    UILabel *timeLabel = [UILabel new];
    timeLabel.font = kFONT14;
//    timeLabel.text = @"00:00:00";
    timeLabel.textColor = FNMainTextNormalColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel sizeToFit];
    [self addSubview:timeLabel];
    _timeLabel = timeLabel;
    
    UIImageView *imgView = [UIImageView new];
    imgView.image  = [UIImage imageNamed:@"home_seckill_se_time"];
    [self insertSubview:imgView atIndex:0];
    
    
    _mztimeLabel = [[MZTimerLabel alloc]initWithLabel:_timeLabel andTimerType:MZTimerLabelTypeTimer];
    _mztimeLabel.timeLabel.textAlignment = NSTextAlignmentCenter;
    _mztimeLabel.timeLabel.textColor = FNMainTextNormalColor;
    
    
    [_titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:LeftSpace];
    [_titleLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [_timeLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_timeLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:LeftSpace];
    
    [imgView autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_timeLabel];
    [imgView autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:_timeLabel];
    [imgView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [_subscribeLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_subscribeLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:timeLabel withOffset:-10];
    
    UIView *line = [UIView new];
    line.backgroundColor = FNHomeBackgroundColor;
    [self addSubview:line];
    [line autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [line autoSetDimension:(ALDimensionHeight) toSize:1.0];
    
}
- (void)setTitle:(NSString *)title subTitle:(NSString *)subTitle starTime:(NSString *)startime andEndTime:(NSString *)endTime{
    
    _titleLabel.text = title;
    _subscribeLabel.text = [subTitle isEqualToString:@"疯抢中"]?@"距结束:":@"距开始:";
    NSTimeInterval time = 0;
    if ([subTitle isEqualToString:@"疯抢中"]) {
        NSDate *date1=[NSDate dateWithTimeIntervalSince1970:endTime.doubleValue];
       time = [date1 timeIntervalSinceDate:[NSDate new]];
    }else{
        NSDate *date1=[NSDate dateWithTimeIntervalSince1970:startime.doubleValue];
        time = [date1 timeIntervalSinceDate:[NSDate new]];
    }
    [_mztimeLabel setCountDownTime:time];
    [_mztimeLabel startWithEndingBlock:^(NSTimeInterval countTime) {
        [FNNotificationCenter postNotificationName:HomeEndCountdown object:nil];
    } andObersvingBlock:^(UILabel *label) {
        if (label.text.length > 0) {
            
            NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:label.text];
            [att addAttribute:NSKernAttributeName value:@(WordsKern) range:NSMakeRange(1, 1)];
            [att addAttribute:NSKernAttributeName value:@(WordsKern) range:NSMakeRange(2, 1)];
            [att addAttribute:NSKernAttributeName value:@(WordsKern) range:NSMakeRange(4, 1)];
            [att addAttribute:NSKernAttributeName value:@(WordsKern) range:NSMakeRange(5, 1)];
            label.attributedText = att;
            
        }
    }];
}
@end
