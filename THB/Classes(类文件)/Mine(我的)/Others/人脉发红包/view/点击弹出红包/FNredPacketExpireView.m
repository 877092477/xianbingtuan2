//
//  FNredPacketExpireView.m
//  THB
//
//  Created by Jimmy on 2019/2/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//
/** 屏幕高度 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SELAnimationTimeInterval  0.6f
//屏幕适配
/**当前设备对应375的比例*/
#define Ratio_375 (SCREEN_WIDTH/375.0)
/**转换成当前比例的数*/
#define Ratio(x) ((int)((x) * Ratio_375))
#import "FNredPacketExpireView.h"

@implementation FNredPacketExpireView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}
+ (void)showExpireView
{
    FNredPacketExpireView *expireView = [[FNredPacketExpireView alloc]init];
    [[UIApplication sharedApplication].delegate.window addSubview:expireView];
}
-(void)setUpAllView{
    
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3/1.0];
    
    CGFloat maxHeight = 720;
    //backgroundView
    self.bgView = [[UIView alloc]init];
    self.bgView.center = self.center;
    self.bgView.bounds = CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight);
    [self addSubview:self.bgView];
    CGFloat whiteW=260;
    CGFloat whiteH=430;
    CGFloat whiteSp=(FNDeviceWidth-260)/2;
    CGFloat whiteTopSp=FNDeviceHeight/2-215-50;
    self.whiteView = [[UIView alloc]initWithFrame:CGRectMake(Ratio(whiteSp), Ratio(whiteTopSp), Ratio(whiteW), Ratio(whiteH))];
    //self.whiteView.backgroundColor = [UIColor clearColor];
    [self.bgView addSubview:self.whiteView];
    
    UIImageView *bgImg=[[UIImageView alloc]init];
    //bgImg.backgroundColor=[UIColor whiteColor];
    bgImg.image=IMAGE(@"FN_hbPW_BGimg");
    [self.whiteView addSubview:bgImg];
    
    self.titleLB=[[UILabel alloc]init];
    self.titleLB.numberOfLines=2;
    self.titleLB.font=[UIFont systemFontOfSize:20];
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    //self.titleLB.text=@"meilinlin的红包";
//    self.titleLB.backgroundColor=[UIColor lightGrayColor];
    self.titleLB.textColor=[UIColor whiteColor];
    [self.whiteView addSubview:self.titleLB];
    
    self.headImg=[[UIImageView alloc]init];
    self.headImg.backgroundColor=[UIColor lightGrayColor];
    [self.whiteView addSubview:self.headImg];
    
    self.remarkLB=[[UILabel alloc]init];
    self.remarkLB.font=[UIFont systemFontOfSize:25];
    self.remarkLB.textAlignment=NSTextAlignmentCenter;
    //self.remarkLB.text=@"该红包已于今天12:13过期";
    self.remarkLB.textColor=[UIColor whiteColor];
    [self.whiteView addSubview:self.remarkLB];
    
    self.checkBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.checkBtn.titleLabel.font=[UIFont systemFontOfSize:20];
    [self.checkBtn setTitle:@"看看大家的手气" forState:UIControlStateNormal];
    //[self.checkBtn addTarget:self action:@selector(checkBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteView addSubview:self.checkBtn];
    
    UIButton *closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.titleLabel.font=[UIFont systemFontOfSize:20];
    [closeBtn setTitleColor:RGB(243, 91, 40) forState:UIControlStateNormal];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(dismissAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:closeBtn];
    
    //self.whiteView.sd_layout
    //.centerXEqualToView(bgView).topSpaceToView(bgView, SafeAreaTopHeight+20).heightIs(430).widthIs(260);
    
    
    
    
    bgImg.sd_layout
    .leftSpaceToView(self.whiteView, 0).rightSpaceToView(self.whiteView, 0).topSpaceToView(self.whiteView, 0).bottomSpaceToView(self.whiteView, 0);
    
    self.titleLB.sd_layout
    .centerXEqualToView(self.whiteView).topSpaceToView(self.whiteView, 50).heightIs(50).widthIs(Ratio(120));
    self.headImg.sd_layout
    .centerYEqualToView(self.titleLB).rightSpaceToView(self.titleLB, 10).heightIs(37).widthIs(37);
    
    self.remarkLB.sd_layout
    .topSpaceToView(self.whiteView, 200).heightIs(40).leftSpaceToView(self.whiteView, 15).rightSpaceToView(self.whiteView, 15);
    
    self.checkBtn.sd_layout
    .bottomSpaceToView(self.whiteView, 90).heightIs(25).leftSpaceToView(self.whiteView, 15).rightSpaceToView(self.whiteView, 15);
    
    closeBtn.sd_layout
    .topSpaceToView(self.whiteView, 20).centerXEqualToView(self.bgView).widthIs(100).heightIs(30);
    
    
    
    
    [self showWithView:self.bgView];
}
-(void)setNameString:(NSString *)nameString{
    _nameString=nameString;
    if(nameString){
       self.titleLB.text=nameString;
       CGFloat nameLBW=[self getWidthWithText:self.titleLB.text height:25 font:20];
       CGFloat nameLBH=25;
       CGFloat nameLBTop=50;
       if (nameLBW>130){
           nameLBTop=25;
           nameLBW=130;
           nameLBH=50;
       }
       self.titleLB.sd_layout
       .centerXEqualToView(self.whiteView).topSpaceToView(self.whiteView, nameLBTop).heightIs(nameLBH).widthIs(nameLBW);
       self.headImg.sd_layout
       .centerYEqualToView(self.titleLB).rightSpaceToView(self.titleLB, 15).heightIs(37).widthIs(37);
    }
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
#pragma mark - // 添加Alert出场动画
- (void)dismissAlert{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration: 0.5f animations:^{
        self.transform = (CGAffineTransformMakeScale(0.1, 0.1));
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    } ];
}

- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}
@end
