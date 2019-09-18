//
//  FNBNHomeBouncedView.m
//  THB
//
//  Created by Jimmy on 2018/9/18.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNBNHomeBouncedView.h"

#import "FNBNBouncedModel.h"

#import <POP.h>

FNBNHomeBouncedView *_bouncedView = nil;

@interface FNBNHomeBouncedView ()

@property (nonatomic, strong)FNBNBouncedModel *BouncedModel;

@property (nonatomic, strong) UIImageView* ImageView;
@property (nonatomic, strong) UIButton*  closedBtn;

@end

@implementation FNBNHomeBouncedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [FNBlackColor colorWithAlphaComponent:0.3];
        [self jm_setupViews];
    }
    return self;
}

+ (instancetype)shareInstance{
    if (_bouncedView == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _bouncedView = [[FNBNHomeBouncedView alloc]initWithFrame:FNKeyWindow.bounds];
        });
    }
    return _bouncedView;
}

#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    _ImageView = [UIImageView new]; 
    _ImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self addSubview:_ImageView];
    [_ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(self.ImageView.mas_width);
//        make.height.equalTo(@((self.width-120)*1));
    }];
    
    _closedBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_closedBtn setImage:IMAGE(@"odds_close") forState:UIControlStateNormal];
    [_closedBtn sizeToFit];
    [_closedBtn addTarget:self action:@selector(BouncedDismiss) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_closedBtn];
    [_closedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ImageView.mas_top).offset(-60);
        make.right.equalTo(_ImageView.mas_right).offset(-40);
    }];
    
    @weakify(self);
    [_ImageView addJXTouch:^{
        @strongify(self);
        [self purchaseAction];
    }];
}

-(void)setBouncedModel:(FNBNBouncedModel *)BouncedModel{
    _BouncedModel=BouncedModel;
    if (_BouncedModel) {
//        [_ImageView setUrlImg:BouncedModel.img];
        [_ImageView sd_setImageWithURL:[NSURL URLWithString:BouncedModel.img] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                [_ImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self.mas_centerX);
                    make.centerY.equalTo(self.mas_centerY);
                    make.left.equalTo(@(0));
                    make.right.equalTo(@(0));
                    make.height.equalTo(self.ImageView.mas_width).dividedBy(image.size.width / image.size.height);
                }];
            }
        }];
    }
}

- (void)purchaseAction{
    if (self.purchaseBlock) {
        self.purchaseBlock(self.BouncedModel);
    }
    [self BouncedDismiss];
}
- (void)showAnimation{
    _bouncedView.ImageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.5f animations:^{
        _bouncedView.ImageView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)BouncedDismiss{
    [UIView animateWithDuration:0.5f animations:^{
        _bouncedView.ImageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

+ (void)showWithModel:(id)model view:(UIView *)view purchaseblock:(void (^)(id model))block{
    _bouncedView = [FNBNHomeBouncedView shareInstance];
    _bouncedView.purchaseBlock = block;
    _bouncedView.BouncedModel =model;
    [view addSubview:_bouncedView];
    [_bouncedView showAnimation];
}

@end
