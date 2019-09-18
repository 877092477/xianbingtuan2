//
//  FNBrandShopHeaderView.m
//  THB
//
//  Created by jimmy on 2017/5/19.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNBrandShopHeaderView.h"
#import "FNBrandShopModel.h"

static const CGFloat _header_logo_h = 60;

@interface FNBrandShopCouponView : UIView
@property (nonatomic, weak) UIImageView* bgImgView;
@property (nonatomic, weak) UILabel* priceLabel;
@property (nonatomic, weak) UILabel* desLabel;
@end
@implementation FNBrandShopCouponView
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
    UIImageView* bgImgView = [UIImageView new];
    bgImgView.image = IMAGE(@"brand_quan");
    [self addSubview:bgImgView];
    _bgImgView = bgImgView;
    
//    UILabel*  priceLabel  =[UILabel new];
//    priceLabel.font = kFONT12;
//    priceLabel.textAlignment = NSTextAlignmentCenter;
//    priceLabel.textColor = FNWhiteColor;
//    priceLabel.adjustsFontSizeToFitWidth = YES;
//    [self addSubview:priceLabel];
//    _priceLabel = priceLabel;
    
    UILabel*  desLabel  =[UILabel new];
    desLabel.font = kFONT12;
    desLabel.textAlignment = NSTextAlignmentCenter;
    desLabel.textColor = FNWhiteColor;
    desLabel.numberOfLines = 2;
    desLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:desLabel];
    _desLabel = desLabel;
    
    
    [_bgImgView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
//    [_priceLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_bgImgView withMultiplier:0.4];
//    [_priceLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:5];
//    [_priceLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
//    [_desLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_bgImgView withMultiplier:0.4];
    [_desLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:5];
    [_desLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:5];
    [_desLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
}

@end
@interface FNBrandShopHeaderView ()
@property (nonatomic, strong) UIImageView*  posterImgView;

@property (nonatomic, strong) UIView* infoView;
@property (nonatomic, strong) UIImageView* logoImgView;
@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UILabel* desLabel;
@property (nonatomic, strong) NSLayoutConstraint* logoConsW;

@property (nonatomic, strong) UIView* couponView;
@property (nonatomic, strong) NSLayoutConstraint* couponConsH;
@end
@implementation FNBrandShopHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self autoSetDimension:(ALDimensionWidth) toSize:FNDeviceWidth];
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    _posterImgView = [UIImageView new];
    _posterImgView.backgroundColor = FNHomeBackgroundColor;
    [self addSubview:_posterImgView];
    
    _infoView = [UIView new];
    [self addSubview:_infoView];
    
    _logoImgView = [UIImageView new];
    _logoImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.infoView addSubview:_logoImgView];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = kFONT14;
    [self.infoView addSubview:_nameLabel];
    
    _desLabel = [UILabel new];
    _desLabel.font = kFONT14;
    [self.infoView addSubview:_desLabel];
    
    
    _couponView = [UIView new];
    [self addSubview:_couponView];
    
    //layout
    [_posterImgView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [_posterImgView autoSetDimension:(ALDimensionHeight) toSize:0.35*FNDeviceWidth];
    
    [_infoView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_posterImgView];
    [_infoView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [_infoView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    
    [_logoImgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_leftMargin];
    [_logoImgView autoSetDimension:(ALDimensionHeight) toSize:_header_logo_h];
    [_logoImgView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:5];
    self.logoConsW = [_logoImgView autoSetDimension:(ALDimensionWidth) toSize:0];
 
    [_nameLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeTop) ofView:_logoImgView];
    [_nameLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_logoImgView withOffset:_jm_margin10];
    [_nameLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_leftMargin];

    [_desLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_leftMargin];
    [_desLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_nameLabel];
    [_desLabel autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_logoImgView];
    
    [_infoView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_logoImgView withOffset:_jm_margin10*0.5];
    
    
    [_couponView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:10];
    [_couponView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:10];
    self.couponConsH = [_couponView autoSetDimension:(ALDimensionHeight) toSize:0];
    [_couponView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_infoView];
    
    [self autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_couponView];
}
- (void)setUpCouponView{
    CGFloat margin = 20;
    CGFloat width  = (FNDeviceWidth-margin*3)/2;
    CGFloat height = 40;
    if (self.couponView.subviews) {
        [self.couponView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    [self.model.shop_yhq enumerateObjectsUsingBlock:^(JMShop_yhq * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FNBrandShopCouponView* coupon = [[FNBrandShopCouponView alloc] initWithFrame:(CGRectMake(0, 5, width*idx+(idx+1)*margin, height))];
        coupon.priceLabel.text = [NSString stringWithFormat:@"¥ %@" ,obj.yhq_price];
        coupon.desLabel.text = obj.yhq_span;
        [self.couponView addSubview:coupon];
        [coupon autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:5];
        [coupon autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:5];
        [coupon autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:width*idx+(idx+1)*margin];
        [coupon autoSetDimension:(ALDimensionWidth) toSize:width];
    }];
}
- (void)setModel:(FNBrandShopModel *)model{
    _model =model;
    if (_model) {
        
        self.desLabel.text = _model.info;
        NSString *tmp = @"全场满减";
        if (_model.is_yhq.boolValue) {
            _couponConsH.constant = 50;
            _couponView.hidden = NO;
            [self setUpCouponView];
        }else{
            tmp = [NSString stringWithFormat:@"最高返利%@%%",_model.returnbili];
            _couponConsH.constant = 0;
            _couponView.hidden = YES;
        }
        self.nameLabel.text =[NSString stringWithFormat:@"%@ %@", _model.name,tmp];
        [self.nameLabel addSingleAttributed:@{NSForegroundColorAttributeName:FNMainGobalControlsColor} ofRange:[self.nameLabel.text rangeOfString:tmp]];
        
        [_posterImgView setUrlImg:_model.banner];
        @WeakObj(self);
        [_logoImgView sd_setImageWithURL:[NSURL URLWithString:_model.logo] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                selfWeak.logoConsW.constant = image.size.width*_header_logo_h/image.size.height;
                [selfWeak.logoImgView layoutIfNeeded];
            }
        }];
        [self layoutIfNeeded];
        
    }
}
@end
