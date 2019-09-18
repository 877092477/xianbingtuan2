//
//  FNdrawRedPacketNaView.m
//  THB
//
//  Created by Jimmy on 2019/2/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdrawRedPacketNaView.h"
@interface FNdrawRedPacketNaView ()

//@property (nonatomic, strong)FNBNBouncedModel *BouncedModel;
@property (nonatomic, strong) UIImageView* bgImageView;
@property (nonatomic, strong) UIImageView* ImageView;
@property (nonatomic, strong) UIButton*  closedBtn;

@end
@implementation FNdrawRedPacketNaView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [FNBlackColor colorWithAlphaComponent:0.3];
        [self jm_setupViews];
    }
    return self;
}

#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    
    _bgImageView= [UIImageView new];
    _bgImageView.contentMode=UIViewContentModeScaleAspectFit;
    _bgImageView.image=IMAGE(@"FN_RB_Bimg");
    [self addSubview:_bgImageView];
    
    
    _ImageView = [UIImageView new];
    _ImageView.contentMode=UIViewContentModeScaleAspectFit;
    _ImageView.image=IMAGE(@"FN_red_bImg");
    [self addSubview:_ImageView];
  
    
    _closedBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_closedBtn setImage:IMAGE(@"FN_hs_SJimg") forState:UIControlStateNormal];
    [_closedBtn sizeToFit];
    _closedBtn.hidden=YES;
    [_closedBtn addTarget:self action:@selector(BouncedDismiss) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_closedBtn];
    
    CGFloat bgTopSpace=FNDeviceHeight/2-100;
    _bgImageView.sd_layout.
    leftSpaceToView(self, 7).rightSpaceToView(self, 7).topSpaceToView(self, bgTopSpace).heightIs(170);
    
    _ImageView.sd_layout
    .topEqualToView(_bgImageView).centerXEqualToView(self).widthIs(196).heightIs(248);
    
    _closedBtn.sd_layout
    .leftEqualToView(_ImageView).bottomSpaceToView(_ImageView, 7).widthIs(16).heightIs(16);
    
    
    
    @weakify(self);
    [_ImageView addJXTouch:^{
        @strongify(self);
        [self purchaseAction];
    }];
}
-(void)BouncedDismiss{
    if (self.purchaseBlock) {
        self.purchaseBlock(@"关闭");
    }
    [self dismissView];
}
//-(void)setBouncedModel:(FNBNBouncedModel *)BouncedModel{
//    _BouncedModel=BouncedModel;
//    if (_BouncedModel) {
//        [_ImageView setUrlImg:BouncedModel.img];
//    }
//}

- (void)purchaseAction{
    if (self.purchaseBlock) {
        self.purchaseBlock(@"领取");
    }
    [self dismissView];
}
- (void)showAnimation{
    self.ImageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.bgImageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.5f animations:^{
        self.ImageView.transform = CGAffineTransformMakeScale(1, 1);
        self.bgImageView.transform = CGAffineTransformMakeScale(1, 1);
        self.closedBtn.hidden=NO;
    }];
}

- (void)dismissView{
    [UIView animateWithDuration:0.5f animations:^{
        self.closedBtn.hidden=YES;
        self.ImageView.hidden=YES;
        self.bgImageView.hidden=YES;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

+ (void)showWithModel:(id)model view:(UIView *)view purchaseblock:(void (^)(id model))block{
    
    FNdrawRedPacketNaView *bouncedView = [[FNdrawRedPacketNaView alloc]initWithFrame:FNKeyWindow.bounds];
    bouncedView.purchaseBlock = block;
    //bouncedView.BouncedModel =model;
    [view addSubview:bouncedView];
    [bouncedView showAnimation];
}

@end
