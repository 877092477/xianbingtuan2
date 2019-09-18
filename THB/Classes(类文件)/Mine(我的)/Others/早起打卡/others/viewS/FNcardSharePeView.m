//
//  FNcardSharePeView.m
//  THB
//
//  Created by 李显 on 2019/2/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcardSharePeView.h"

@implementation FNcardSharePeView

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
    self.bgView.frame = CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight);
    [self addSubview:self.bgView];
    
    self.imageView=[[UIImageView alloc]init];
    self.imageView.frame = CGRectMake(FNDeviceWidth/2-95, FNDeviceHeight/2-200, 190, 339);
    [self.bgView addSubview:self.imageView];
    
    self.imageView.cornerRadius=5;
    
    
    self.oneBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.oneBtn sizeToFit];
    self.oneBtn.titleLabel.font=kFONT12;
    [self.oneBtn setTitle:@"保存照片" forState:UIControlStateNormal];
    [self.oneBtn setImage:IMAGE(@"fn_dkBCimg") forState:UIControlStateNormal];
    [self.bgView addSubview:self.oneBtn];
    
    
    self.twoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.twoBtn sizeToFit];
    self.twoBtn.titleLabel.font=kFONT12;
    [self.twoBtn setTitle:@"微信" forState:UIControlStateNormal];
    [self.twoBtn setImage:IMAGE(@"fn_dawximg") forState:UIControlStateNormal];
    [self.bgView addSubview:self.twoBtn];
    
    self.threeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.threeBtn sizeToFit];
    self.threeBtn.titleLabel.font=kFONT12;
    [self.threeBtn setTitle:@"朋友圈" forState:UIControlStateNormal];
    [self.threeBtn setImage:IMAGE(@"fn_dkPYQimg") forState:UIControlStateNormal];
    [self.bgView addSubview:self.threeBtn];
    
    self.leftLine=[[UIView alloc]init];
    self.leftLine.backgroundColor=[UIColor whiteColor];
    [self.bgView addSubview:self.leftLine];
    
    self.rightLine=[[UIView alloc]init];
    self.rightLine.backgroundColor=[UIColor whiteColor];
    [self.bgView addSubview:self.rightLine];
    
    self.titleLB=[[UILabel alloc]init];
    self.titleLB.text=@"分享方式";
    self.titleLB.textColor=[UIColor whiteColor];
    self.titleLB.font=[UIFont systemFontOfSize:12];
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    [self.bgView addSubview:self.titleLB];
    
    
    
    
    
    self.cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setImage:IMAGE(@"fn_daSGB_img") forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.cancelBtn];
    
    self.titleLB.sd_layout
    .centerXEqualToView(self.bgView).widthIs(75).topSpaceToView(self.imageView, 30).heightIs(20);
    
    self.leftLine.sd_layout
    .centerYEqualToView(self.titleLB).rightSpaceToView(self.titleLB, 5).heightIs(1).widthIs(60);
    
    self.rightLine.sd_layout
    .centerYEqualToView(self.titleLB).leftSpaceToView(self.titleLB, 5).heightIs(1).widthIs(60);
    
    self.twoBtn.sd_layout
    .centerXEqualToView(self.bgView).topSpaceToView(self.titleLB, 15).heightIs(70).widthIs(50);
    [self.twoBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    
    
    self.oneBtn.sd_layout
    .rightSpaceToView(self.twoBtn, 35).centerYEqualToView(self.twoBtn).heightIs(70).widthIs(50);
    [self.oneBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    
    self.threeBtn.sd_layout
    .leftSpaceToView(self.twoBtn, 35).centerYEqualToView(self.twoBtn).heightIs(70).widthIs(50);
    [self.threeBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    
    self.cancelBtn.sd_layout
    .leftSpaceToView(self.imageView, 5).bottomSpaceToView(self.imageView, 15).heightIs(30).widthIs(30);
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
@end
