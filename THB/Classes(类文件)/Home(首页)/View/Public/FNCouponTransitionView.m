//
//  FNCouponTransitionView.m
//  THB
//
//  Created by jimmy on 2017/5/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNCouponTransitionView.h"
#import "ReplicatorLineAnimationView.h"
#import "FNBaseProductModel.h"
static const CGFloat _sub_height = 40;
static FNCouponTransitionView* _couponInstance = nil;

@interface FNCouponTransitionSubView : UIView
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, strong)UILabel* priceLabel;
@end
@implementation FNCouponTransitionSubView
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
    _titleLabel = [ UILabel new];
    _titleLabel.font = kFONT14;
    [self addSubview:_titleLabel];
    [_titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_leftMargin];
    [_titleLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    _priceLabel = [ UILabel new];
    _priceLabel.font = kFONT14;
    [self addSubview:_priceLabel];
    [_priceLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_leftMargin];
    [_priceLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
}

@end
@interface FNCouponTransitionView ()
@property (nonatomic, weak) UIView*   mainView;
@property (nonatomic, weak) UIImageView*  logoOne;
@property (nonatomic, weak) UIImageView* logoTarget;
@property (nonatomic, strong)ReplicatorLineAnimationView* lineView;
@property (nonatomic, strong) NSMutableArray<FNCouponTransitionSubView *>* views;
@end
@implementation FNCouponTransitionView
- (NSMutableArray<FNCouponTransitionSubView *> *)views
{
    if (_views == nil) {
        _views = [NSMutableArray new];
    }
    return _views;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
+ (instancetype)shareInstance{
    if (_couponInstance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _couponInstance = [[FNCouponTransitionView alloc]initWithFrame:FNKeyWindow.bounds];
        });
    }
    return _couponInstance;
}

#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    UIView* mainView = [UIView new];
    mainView.cornerRadius = 5;
    mainView.backgroundColor = FNWhiteColor;
    [self addSubview:mainView];
    _mainView = mainView;
    
    UIImageView* logoOne = [UIImageView new];
    logoOne.image = IMAGE(@"jump_logo");
    [logoOne sizeToFit];
    [_mainView addSubview:logoOne];
    _logoOne = logoOne;
    
    UIImage *image = [UIImage imageNamed:@"jump_btn"];
    UIButton* btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"即将前往" forState:UIControlStateNormal];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    btn.userInteractionEnabled = NO;
    [btn sizeToFit];
    btn.titleLabel.font = kFONT13;
    [_mainView addSubview:btn];
    
    CGRect   rect  = CGRectMake(0, 0, image.size.width, image.size.height);
//    ReplicatorLineAnimationView *replicatorLineView = [[ReplicatorLineAnimationView alloc] initWithFrame:rect];
//    replicatorLineView.direction = kReplicatorRight;
//    replicatorLineView.speed     = 0.5f;
//    replicatorLineView.image     = image;
//    [replicatorLineView startAnimation];
//    [_mainView addSubview:replicatorLineView];
//    _lineView = replicatorLineView;
    
    UIImageView* logoTarget = [UIImageView new];
    logoTarget.image = IMAGE(@"jump_taobao");
    [logoTarget sizeToFit];
    [_mainView addSubview:logoTarget];
    _logoTarget = logoTarget;
    
    for (NSInteger i = 0; i <3; i++) {
        FNCouponTransitionSubView* view = [[FNCouponTransitionSubView alloc]initWithFrame:(CGRectZero)];
        if (i == 2) {
            view.titleLabel.textColor = FNWhiteColor;
            view.priceLabel.textColor = FNWhiteColor;
        }
        [_mainView addSubview:view];
        [self.views addObject:view];
    }
    
    /*
     layout all subviews
     */
    CGFloat witdth = FNDeviceWidth*3/4;
    [_mainView autoSetDimension:(ALDimensionWidth) toSize:witdth];
    [_mainView autoCenterInSuperview];
    
    [btn autoSetDimensionsToSize:btn.size];
    [btn autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    [btn autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:_logoOne];
    
    [_logoOne autoSetDimensionsToSize:_logoOne.size];
    [_logoOne autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:_jm_leftMargin*2];
    [_logoOne autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:btn withOffset:-_jm_leftMargin];
    
    [_logoTarget autoSetDimensionsToSize:_logoTarget.size];
    [_logoTarget autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:_jm_leftMargin*2];
    [_logoTarget autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:btn withOffset:_jm_leftMargin];
    
    [self.views[0] autoSetDimension:(ALDimensionHeight) toSize:_sub_height];
    [self.views[0] autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [self.views[0] autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.views[0] autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_logoOne withOffset:_jm_leftMargin*2];
    
    [self.views[1] autoSetDimension:(ALDimensionHeight) toSize:_sub_height];
    [self.views[1] autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [self.views[1] autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.views[1] autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.views[0]  withOffset:0];
    
    [self.views[2] autoSetDimension:(ALDimensionHeight) toSize:_sub_height];
    [self.views[2] autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [self.views[2] autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.views[2] autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.views[1]  withOffset:0];
    
    [_mainView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.views[2] withOffset:10];
}
- (void)beginAniamtions{
    [FNKeyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        _couponInstance.backgroundColor = [FNBlackColor colorWithAlphaComponent:0.3];
    }];
    [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [_couponInstance.mainView.layer setValue:@(0) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.23 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [_couponInstance.mainView.layer setValue:@(1.2) forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.09 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [_couponInstance.mainView.layer setValue:@(.9) forKeyPath:@"transform.scale"];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.05 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [_couponInstance.mainView.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
                } completion:^(BOOL finished) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self removeFromSuperview];
                    });
                }];
            }];
        }];
    }];

}
#pragma mark - public method
+ (void)showWithModel:(FNBaseProductModel *)model{
    _couponInstance = [FNCouponTransitionView shareInstance];
    _couponInstance.views[2].backgroundColor = FNMainGobalControlsColor;
    _couponInstance.model = model;
}
- (void)setModel:(FNBaseProductModel *)model{
    _model = model;
    if (_model) {
        if ([NSString checkIsSuccess:model.shop_id andElement:@"1"]) {//tao bao
            _couponInstance.logoTarget.image = IMAGE(@"jump_taobao");
        }else if ([NSString checkIsSuccess:model.shop_id andElement:@"2"]){
            _couponInstance.logoTarget.image = IMAGE(@"jump_tmall");
        }
        self.views[0].titleLabel.text = @"原价";
        self.views[1].titleLabel.text = @"先领券";
        self.views[2].titleLabel.text = @"券后价";
        
        self.views[0].priceLabel.text = [NSString stringWithFormat:@"¥ %@",_model.goods_cost_price];
        self.views[1].priceLabel.text = [NSString stringWithFormat:@"¥ %@",_model.yhq_price];
        self.views[2].priceLabel.text = [NSString stringWithFormat:@"¥ %@",_model.juanhou_price];
        [self.lineView startAnimation];
        [self beginAniamtions];
    }
}
+ (void)hiddenCouopon{

    [UIView animateWithDuration:0.3 animations:^{
        _couponInstance.mainView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        if (finished) {
            [_couponInstance removeFromSuperview];
        }
    }];
}
@end
