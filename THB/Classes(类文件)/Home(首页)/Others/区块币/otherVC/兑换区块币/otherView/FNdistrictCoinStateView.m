//
//  FNdistrictCoinStateView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/6.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdistrictCoinStateView.h"

@implementation FNdistrictCoinStateView

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //self.layer.cornerRadius = 10/2;
        //self.clipsToBounds = YES;
        [self initializedSubviews];
    } return self;
}
// 准备弹出(初始化弹层位置)
- (void)willPopupContainer:(DSHPopupContainer *)container; {
    CGRect frame = self.frame;
    frame.size = CGSizeMake(286, 220);
    frame.origin.x = (container.frame.size.width - frame.size.width) * .5;
    frame.origin.y = (container.frame.size.height - frame.size.height) * .5;
    self.frame = frame;
}

// 已弹出(做弹出动画)
- (void)didPopupContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeScale(1.f, 1.f);
    }];
}

// 将要移除(做移除动画)
- (void)willDismissContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    CGRect frame = self.frame;
    frame.origin.y = container.frame.size.height;
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0.f;
    }];
}

- (void)initializedSubviews{
    
    self.stateImg=[[UIImageView alloc]init];
    [self addSubview:self.stateImg];
    
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.rightBtn];
    
    [self.rightBtn setImage:IMAGE(@"FN_DR_gbImg") forState:UIControlStateNormal];
    
    self.stateLB=[[UILabel alloc]init];
    [self addSubview:self.stateLB];
    
    self.stateLB.font=[UIFont systemFontOfSize:18];
    self.stateLB.textColor=RGB(51, 51, 51);
    self.stateLB.textAlignment=NSTextAlignmentCenter;
    
    self.stateImg.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.stateLB.sd_layout
    .leftSpaceToView(self, 5).rightSpaceToView(self, 5).bottomSpaceToView(self, 37).heightIs(26);
    
    self.rightBtn.sd_layout
    .rightSpaceToView(self, 0).topSpaceToView(self, 0).heightIs(49).widthIs(49);
    self.rightBtn.imageView.sd_layout
    .centerXEqualToView(self.rightBtn).centerYEqualToView(self.rightBtn).heightIs(15).widthIs(15);
}

@end
