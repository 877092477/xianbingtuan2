//
//  FNmerPhotoDeletePuView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/1.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerPhotoDeletePuView.h"

@implementation FNmerPhotoDeletePuView

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        [self initializedSubviews];
    } return self;
}
// 准备弹出(初始化弹层位置)
- (void)willPopupContainer:(DSHPopupContainer *)container; {
    CGRect frame = self.frame;
    frame.size = CGSizeMake(FNDeviceWidth-50, 170);
    frame.origin.x = 25;
    frame.origin.y = container.frame.size.height/2-95;
    self.frame = frame;
}

// 已弹出(做弹出动画)
- (void)didPopupContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.6f;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.layer addAnimation:animation forKey:nil];
}

// 将要移除(做移除动画)
- (void)willDismissContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    
    
    [UIView animateWithDuration:0.6f animations:^{
        self.transform = (CGAffineTransformMakeScale(0.1, 0.1));
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    } ];
}

- (void)initializedSubviews{
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.hintLB=[[UILabel alloc]init];
    [self addSubview:self.hintLB];
    
    self.titleLB.font=[UIFont systemFontOfSize:18];
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.hintLB.font=[UIFont systemFontOfSize:14];
    self.hintLB.textColor=RGB(102, 102, 102);
    self.hintLB.textAlignment=NSTextAlignmentLeft;
    self.hintLB.numberOfLines=2;
    
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.rightBtn];
    
    self.leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.leftBtn];
    
    self.leftBtn.titleLabel.font=kFONT14;
    [self.leftBtn setTitleColor:RGB(255, 120, 37) forState:UIControlStateNormal];
    [self.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    self.rightBtn.titleLabel.font=kFONT14;
    [self.rightBtn setTitleColor:RGB(255, 120, 37) forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"删除" forState:UIControlStateNormal];
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 28).rightSpaceToView(self, 28).heightIs(24).topSpaceToView(self, 25);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self, 28).rightSpaceToView(self, 28).topSpaceToView(self.titleLB, 15).bottomSpaceToView(self, 50);
    
    self.rightBtn.sd_layout
    .rightSpaceToView(self, 17).widthIs(63).heightIs(30).bottomSpaceToView(self, 17);
    
    self.leftBtn.sd_layout
    .rightSpaceToView(self.rightBtn, 17).widthIs(63).heightIs(30).bottomSpaceToView(self, 17);
    
    self.titleLB.text=@"确定要删除  门店内景 吗？";
    self.hintLB.text=@"删除标签后，这个标签内的所有照片都会被删除,这个标签内的所有照片都会被删除";
    [self.hintLB fn_changeLineSpaceWithTextLineSpace:5];
}
@end
