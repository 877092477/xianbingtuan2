//
//  FNHomePromotionalView.m
//  THB
//
//  Created by jimmy on 2017/5/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNHomePromotionalView.h"
static FNHomePromotionalView* _promotionalView = nil;

@interface FNHomePromotionalView ()
@property (nonatomic,strong) UIView* mainView;
@property (nonatomic, strong) UIButton* closeBtn;
@property (nonatomic, strong) UIImageView* goodsImgView;
@property (nonatomic, strong) UILabel* desLabel;
@property (nonatomic, strong) UILabel* priceLabel;
@property (nonatomic, strong) UILabel* rebateLabel;
@end
@implementation FNHomePromotionalView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
+ (instancetype)shareInstance{
    if (_promotionalView == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _promotionalView = [[FNHomePromotionalView alloc]initWithFrame:FNKeyWindow.bounds];
        });
    }
    return _promotionalView;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    
    //
    _mainView = [[UIView alloc]initWithFrame:(CGRectMake(15, 187.5, 290, 300))];
    [self addSubview:_mainView];
    @WeakObj(self);
    UIView* infoView = [UIView new];
    infoView.backgroundColor = FNWhiteColor;
    [infoView addJXTouch:^{
        [selfWeak dismissView];
        if (self.clickedblock) {
            self.clickedblock();
        }
    }];
    [_mainView addSubview:infoView];
    
    _closeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_closeBtn setImage:IMAGE(@"popup_close") forState:UIControlStateNormal];
    [_closeBtn sizeToFit];
    [_closeBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:_closeBtn];
    
    _goodsImgView = [UIImageView new];
    _goodsImgView.contentMode = UIViewContentModeScaleAspectFit;
    [_mainView addSubview:_goodsImgView];
    
    _desLabel = [UILabel new];
    _desLabel.font = kFONT14;
    _desLabel.textColor = FNColor(112, 113, 114);
    [_mainView addSubview:_desLabel];
    
    _priceLabel = [UILabel new];
    _priceLabel.textColor = FNColor(112, 113, 114);
    _priceLabel.font = kFONT14;
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [_mainView addSubview:_priceLabel];
    
    _rebateLabel = [UILabel new];
    _rebateLabel.font = kFONT14;
    _rebateLabel.textAlignment = NSTextAlignmentLeft;
    _rebateLabel.textColor = FNGlobalTextGrayColor;
    [_mainView addSubview:_rebateLabel];
    
    //
    
    [_mainView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_leftMargin*3];
    [_mainView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_leftMargin*3];
    [_mainView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];

    [_closeBtn autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
    [_closeBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [_closeBtn autoSetDimensionsToSize:_closeBtn.size];
    
    [infoView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [infoView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [infoView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_closeBtn];

    
    [_goodsImgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_leftMargin];
    [_goodsImgView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_leftMargin];
    [_goodsImgView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:_jm_leftMargin+_closeBtn.height];
    [_goodsImgView autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionWidth) ofView:_goodsImgView];
    
    [_desLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_goodsImgView];
    [_desLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:_goodsImgView];
    [_desLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_goodsImgView withOffset:_jm_margin10];
    
    [_priceLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_desLabel];
    [_priceLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_desLabel withOffset:_jm_margin10];
    [_priceLabel autoConstrainAttribute:ALEdgeRight toAttribute:ALAxisVertical ofView:infoView withOffset:5];
    
    [_priceLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_desLabel];
    [_priceLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_desLabel withOffset:_jm_margin10];
    [_priceLabel autoConstrainAttribute:ALEdgeRight toAttribute:ALAxisVertical ofView:infoView withOffset:-5];
     [_priceLabel autoSetDimension:(ALDimensionHeight) toSize:20];
    
    [_rebateLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:_desLabel];
    [_rebateLabel autoConstrainAttribute:ALEdgeLeft toAttribute:ALAxisVertical ofView:self withOffset:5];
    [_rebateLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.priceLabel];
    [_rebateLabel autoSetDimension:(ALDimensionHeight) toSize:20];
    
    [infoView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_rebateLabel withOffset:10];
    
    [_mainView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:infoView withOffset:_jm_margin10];
}
+ (void)showWithModel:(FNBaseProductModel *)model clickedProBlock:(void (^)(void))block{
    _promotionalView = [FNHomePromotionalView shareInstance];
    [_promotionalView.goodsImgView setUrlImg:model.goods_img];
    _promotionalView.desLabel.text = model.goods_title;
    _promotionalView.priceLabel.text = [NSString stringWithFormat:@"¥ %@",model.goods_price];
    
    _promotionalView.clickedblock = block;
    
    if ([FNBaseSettingModel settingInstance].app_fanli_onoff.boolValue) {//judge the switch of fan li
        if (model.is_hide_fl.integerValue==1) {
            _promotionalView.rebateLabel.text = [NSString stringWithFormat:@"月销%@",model.goods_sales];
        }else{
            if ([model.fcommission floatValue]<=0) {
                _promotionalView.rebateLabel.text = [NSString stringWithFormat:@"月销%@",model.goods_sales];
            }else{
                _promotionalView.rebateLabel.textColor=RED;
                _promotionalView.rebateLabel.text=[NSString stringWithFormat:@" ¥%.2f",[model.fcommission floatValue]];
                [_promotionalView.rebateLabel HttpLabelLeftImage:model.ico label:_promotionalView.rebateLabel imageX:0 imageY:-3 imageH:15 atIndex:0];
            }
        }
    }else{
        if ([[FNBaseSettingModel settingInstance].app_choujiang_onoff integerValue]==1) {
            _promotionalView.rebateLabel.textColor=RED;
            _promotionalView.rebateLabel.text=model.app_fanli_off_str;
            [_promotionalView.rebateLabel HttpLabelLeftImage:model.ico label:_promotionalView.rebateLabel imageX:0 imageY:-3 imageH:15 atIndex:0];
        }else{
            _promotionalView.rebateLabel.text = [NSString stringWithFormat:@"月销%@",model.goods_sales];
        }
    }
   
    [_promotionalView showAnimation];
}

- (void)showAnimation{
    _promotionalView.mainView.hidden = NO;
    [FNKeyWindow addSubview:self];
    CGPoint startPoint = CGPointMake(_promotionalView.center.x, -_promotionalView.mainView.frame.size.height);
    _promotionalView.mainView.layer.position=startPoint;
    
    //damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
    //velocity:弹性复位的速度
    [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        _promotionalView.mainView.layer.position=_promotionalView.center;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = [FNBlackColor colorWithAlphaComponent:0.3];
        }];
    }];
}

- (void)dismissView{
    [UIView animateWithDuration:.3 animations:^{
        self.backgroundColor  = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    if ((point.x>=self.mainView.x && point.x<=CGRectGetMaxX(self.mainView.frame) ) && (point.y>=self.mainView.y && point.y<=CGRectGetMaxY(self.mainView.frame) )) {
        return  [super hitTest:point withEvent:event];
    }else{
        [self dismissView];
        return  [super hitTest:point withEvent:event];
    }
}

@end
