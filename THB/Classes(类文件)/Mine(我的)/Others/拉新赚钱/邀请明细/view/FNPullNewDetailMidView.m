//
//  FNPullNewDetailMidView.m
//  THB
//
//  Created by Fnuo-iOS on 2018/5/10.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNPullNewDetailMidView.h"

@implementation FNPullNewDetailMidView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIView *leftView = [[UIView alloc]init];
        leftView.backgroundColor = [UIColor clearColor];
        [self addSubview:leftView];
        
        UIView *midView = [[UIView alloc]init];
        midView.backgroundColor = [UIColor clearColor];
        [self addSubview:midView];
        
        UIView *rightView = [[UIView alloc]init];
        rightView.backgroundColor = [UIColor clearColor];
        [self addSubview:rightView];
        
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.bottom.equalTo(@-10);
            make.width.equalTo(rightView.mas_width);
            make.left.equalTo(@0);
            make.right.equalTo(midView.mas_left).offset(0);
        }];
        
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.bottom.equalTo(@-10);
            make.width.equalTo(midView.mas_width);
            make.right.equalTo(@0);
        }];
        
        [midView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.bottom.equalTo(@-10);
            make.width.equalTo(leftView.mas_width);
            make.left.equalTo(leftView.mas_right).offset(1);
            make.right.equalTo(rightView.mas_left).offset(-1);
        }];
        
        UIView *line1=[UIView new];
        line1.backgroundColor=FNGlobalTextGrayColor;
        [self addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.bottom.equalTo(@-10);
            make.width.equalTo(@1);
            make.left.equalTo(leftView.mas_right).offset(0);
        }];
        
        UIView *line2=[UIView new];
        line2.backgroundColor=FNGlobalTextGrayColor;
        [self addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.bottom.equalTo(@-10);
            make.width.equalTo(@1);
            make.right.equalTo(rightView.mas_left).offset(0);
        }];
        
        UILabel *leftLabel=[UILabel new];
        leftLabel.textColor=FNGlobalTextGrayColor;
        leftLabel.textAlignment=NSTextAlignmentCenter;
        leftLabel.font=kFONT12;
        leftLabel.text=@"注册时间";
        [leftView addSubview:leftLabel];
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.left.right.equalTo(@0);
            make.height.equalTo(@10);
        }];
        
        UILabel *midLabel=[UILabel new];
        midLabel.textColor=FNGlobalTextGrayColor;
        midLabel.textAlignment=NSTextAlignmentCenter;
        midLabel.font=kFONT12;
        midLabel.text=@"激活时间";
        [midView addSubview:midLabel];
        [midLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.left.right.equalTo(@0);
            make.height.equalTo(@10);
        }];
        
        UILabel *rightLabel=[UILabel new];
        rightLabel.textColor=FNGlobalTextGrayColor;
        rightLabel.textAlignment=NSTextAlignmentCenter;
        rightLabel.font=kFONT12;
        rightLabel.text=@"激活时间";
        [rightView addSubview:rightLabel];
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.left.right.equalTo(@0);
            make.height.equalTo(@10);
        }];
        
        UILabel *leftTime=[UILabel new];
        leftTime.numberOfLines=2;
        leftTime.textColor=FNBlackColor;
        leftTime.textAlignment=NSTextAlignmentCenter;
        leftTime.font=kFONT14;
        [leftView addSubview:leftTime];
        [leftTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(leftLabel.mas_bottom).offset(5);
            make.bottom.equalTo(@-10);
            make.left.equalTo(@5);
            make.right.equalTo(@-5);
        }];
        self.leftTime=leftTime;
        
        UILabel *midTime=[UILabel new];
        midTime.numberOfLines=2;
        midTime.textColor=FNBlackColor;
        midTime.textAlignment=NSTextAlignmentCenter;
        midTime.font=kFONT14;
        [midView addSubview:midTime];
        [midTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(midLabel.mas_bottom).offset(5);
            make.bottom.equalTo(@-10);
            make.left.equalTo(@5);
            make.right.equalTo(@-5);
        }];
        self.midTime=midTime;
        
        UILabel *rightTime=[UILabel new];
        rightTime.numberOfLines=2;
        rightTime.textColor=FNBlackColor;
        rightTime.textAlignment=NSTextAlignmentCenter;
        rightTime.font=kFONT14;
        [rightView addSubview:rightTime];
        [rightTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(rightLabel.mas_bottom).offset(5);
            make.bottom.equalTo(@-10);
            make.left.equalTo(@5);
            make.right.equalTo(@-5);
        }];
        self.rightTime=rightTime;
    }
    return self;
}

@end
