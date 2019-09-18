//
//  FNresultClockInView.m
//  THB
//
//  Created by Jimmy on 2019/2/27.
//  Copyright © 2019 方诺科技. All rights reserved.
//
//打卡结果
#import "FNresultClockInView.h"

@implementation FNresultClockInView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
} 
-(void)setUpAllView{
    
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3/1.0];
    //backgroundView
    self.bgView = [[UIView alloc]init];
    self.bgView.frame = CGRectMake(FNDeviceWidth/2-145, FNDeviceHeight/2-175, 290, 345);
    [self addSubview:self.bgView];
    
    self.whiteView= [[UIView alloc]init];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:self.whiteView];
    
    self.titleLB=[[UILabel alloc]init];
    self.titleLB.font=[UIFont systemFontOfSize:12];
    //self.titleLB.textColor=[UIColor whiteColor];
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    [self.bgView addSubview:self.titleLB];
    
    self.restLB=[[UILabel alloc]init];
    self.restLB.font=[UIFont systemFontOfSize:24];
    self.restLB.textColor=RGB(255, 60, 60);
    self.restLB.textAlignment=NSTextAlignmentCenter;
    [self.bgView addSubview:self.restLB];
    
    self.stateImg=[[UIImageView alloc]init];
    //self.stateImg.backgroundColor = [UIColor lightGrayColor];
    [self.bgView addSubview:self.stateImg];
    
    self.cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //self.cancelBtn.titleLabel.font=kFONT16;
    //self.cancelBtn.backgroundColor=RGB(246, 245, 245);
    //[self.cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.cancelBtn setImage:IMAGE(@"integral_mall_button_close") forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteView addSubview:self.cancelBtn];
    
    
    self.continueBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.continueBtn.titleLabel.font=kFONT16;
    self.continueBtn.cornerRadius=45/2;
    [self.continueBtn setTitle:@"继续挑战" forState:UIControlStateNormal];
    self.continueBtn.backgroundColor=RGB(72, 146, 255);
    [self.continueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal]; 
    [self.bgView addSubview:self.continueBtn];
    
    self.grandLB=[[UILabel alloc]init];
    self.grandLB.font=[UIFont systemFontOfSize:12];
    self.grandLB.textColor = RGB(232,232,232);
    self.grandLB.textAlignment=NSTextAlignmentCenter;
    [self.bgView addSubview:self.grandLB];
    
    self.leftLine=[[UIView alloc]init];
    self.leftLine.backgroundColor = RGB(232,232,232);
    [self.bgView addSubview:self.leftLine];
    
    self.rightLine=[[UIView alloc]init];
    self.rightLine.backgroundColor = RGB(232,232,232);
    [self.bgView addSubview:self.rightLine];
    
    self.whiteView.sd_layout
    .leftSpaceToView(self.bgView,0).rightSpaceToView(self.bgView,0).bottomSpaceToView(self.bgView, 0).heightIs(270);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.bgView, 5).rightSpaceToView(self.bgView, 5).topSpaceToView(self.bgView, 177).heightIs(20);
    
    self.stateImg.sd_layout
    .centerXEqualToView(self.bgView).topSpaceToView(self.bgView,0).heightIs(163).widthIs(183);
    
    self.restLB.sd_layout
    .leftSpaceToView(self.bgView, 5).rightSpaceToView(self.bgView, 5).topSpaceToView(self.titleLB, 20).heightIs(25);
    
    self.continueBtn.sd_layout
    .centerXEqualToView(self.bgView).bottomSpaceToView(self.bgView, 20).heightIs(45).widthIs(255);
    
    self.grandLB.sd_layout
    .centerXEqualToView(self.bgView).bottomSpaceToView(self.bgView, 75).heightIs(15).widthIs(80);
    
    self.leftLine.sd_layout
    .leftSpaceToView(self.bgView, 20).rightSpaceToView(self.grandLB, 10).centerYEqualToView(self.grandLB).heightIs(1);
    
    self.rightLine.sd_layout
    .leftSpaceToView(self.grandLB, 10).rightSpaceToView(self.bgView, 20).centerYEqualToView(self.grandLB).heightIs(1);
    
    self.cancelBtn.sd_layout
    .rightSpaceToView(self.whiteView, 15).topSpaceToView(self.whiteView, 15).heightIs(25).widthIs(25);
    
    [self showWithView:self.bgView];
    
    
}
-(void)cancelBtnAction{
    [self dismissAlert];
} 
#pragma mark - //添加Alert入场动画
- (void)showWithView:(UIView*)alert{
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5f;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [alert.layer addAnimation:animation forKey:nil];
}
#pragma mark - // 添加消失动画
- (void)dismissAlert{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration: 0.5f animations:^{
        self.transform = (CGAffineTransformMakeScale(0.1, 0.1));
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    } ];
}

-(void)setModel:(FNclockDKDoingModel *)model{
    _model=model;
    if(model){
       [self.stateImg setUrlImg:model.img];
        self.titleLB.text=model.str;//@"奖励金将于每期活动结束后结算";
        self.restLB.text=model.str2;//@"06:37:51分打卡成功";
        self.grandLB.text=model.str3;//@"累计打卡71天";
        
        CGFloat grandW= [self getWidthWithText:self.grandLB.text height:15 font:12];
        
        self.grandLB.sd_layout
        .centerXEqualToView(self.bgView).bottomSpaceToView(self.bgView, 75).heightIs(15).widthIs(grandW);
        
        self.leftLine.sd_layout
        .leftSpaceToView(self.bgView, 20).rightSpaceToView(self.grandLB, 10).centerYEqualToView(self.grandLB).heightIs(1);
        
        self.rightLine.sd_layout
        .leftSpaceToView(self.grandLB, 10).rightSpaceToView(self.bgView, 20).centerYEqualToView(self.grandLB).heightIs(1);
    }
}

- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}

@end
