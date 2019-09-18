//
//  FNProductDetailHeaderView.m
//  LikeKaGou
//
//  Created by jimmy on 16/10/11.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "FNProductDetailHeaderView.h"
#import "SDCycleScrollView.h"
#import "DiscountLabel.h"
#import "FNProductDetailModel.h"
#define PDHVerticalMargin 15.0
#define PDHHorizontalMargin 10.0
typedef void(^CouponViewOnClickedBlock)(void);
@interface FNProductDetailHeaderSubview : UIView
@property (nonatomic, weak) UILabel* proTitleLabel;

@property (nonatomic, weak) UIView* priceView;
@property (nonatomic, weak) UILabel* priceLabel;
@property (nonatomic, weak) DiscountLabel* orgLabel;
@property (nonatomic, weak) UILabel* payLabel;
@property (nonatomic, weak) UILabel* rebateLabel;
@property (nonatomic, weak) UILabel* soldLabel;
@property (nonatomic, weak) UILabel* areaLabel;

@property (nonatomic, weak) UIView* couponView;
@property (nonatomic, weak) UIImageView* couponImageView;
@property (nonatomic, weak) UILabel* couponTitleLabel;
@property (nonatomic, weak) UIImageView* rightIconImageView;

@property (nonatomic, copy) CouponViewOnClickedBlock block;
@end

@implementation FNProductDetailHeaderSubview
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.borderWidth = 1.0;
        self.borderColor = FNHomeBackgroundColor;
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    UILabel *proTitleLabel = [UILabel new];
    proTitleLabel.font = FNFontDefault(FNGlobalFontNormalSize+2);
    proTitleLabel.numberOfLines = 0;
    [self addSubview:proTitleLabel];
    _proTitleLabel = proTitleLabel;
    
    [self setUpPriceView];
    [self setUpCouponView];
    
    [self layoutAllViews];
}
- (void)setUpPriceView{
    UIView *priceView = [UIView new];
    priceView.borderColor = FNHomeBackgroundColor;
    priceView.borderWidth = 1.0f;
    [self addSubview:priceView];
    _priceView = priceView;
    
    
    UILabel *priceLabel = [UILabel new];
    priceLabel.font = FNFontDefault(FNGlobalFontNormalSize);
    priceLabel.text = @"￥0.00";
    priceLabel.textColor = FNMainGobalTextColor;
    priceLabel.textAlignment = NSTextAlignmentRight;
    [_priceView addSubview:priceLabel];
    _priceLabel = priceLabel;
    
    DiscountLabel *orgLabel = [[DiscountLabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    orgLabel.font = FNFontDefault(FNGlobalFontNormalSize-2);
    orgLabel.text = @"￥0.00";
    orgLabel.textAlignment = NSTextAlignmentLeft;
    orgLabel.textColor = FNGlobalTextGrayColor;
    [_priceView addSubview:orgLabel];
    _orgLabel = orgLabel;
    
    UILabel *payLabel = [UILabel new];
    payLabel.font = FNFontDefault(FNGlobalFontNormalSize);
    payLabel.text = @"支付0元";
    payLabel.textAlignment = NSTextAlignmentRight;
    payLabel.textColor = FNGlobalTextGrayColor;
    [_priceView addSubview:payLabel];
    _payLabel = payLabel;
    
    UILabel *rebateLabel = [UILabel new];
    rebateLabel.font = FNFontDefault(FNGlobalFontNormalSize);
    rebateLabel.text = @"券抵0元";
    rebateLabel.textAlignment = NSTextAlignmentLeft;
    rebateLabel.textColor = FNMainGobalTextColor;
    [_priceView addSubview:rebateLabel];
    _rebateLabel = rebateLabel;
    
    UILabel *soldLabel = [UILabel new];
    soldLabel.font = FNFontDefault(FNGlobalFontNormalSize);
    soldLabel.textColor = FNGlobalTextGrayColor;
    soldLabel.text = @"已抢0件";
    [_priceView addSubview:soldLabel];
    _soldLabel = soldLabel;
    
    UILabel *areaLabel = [UILabel new];
    areaLabel.font = FNFontDefault(FNGlobalFontNormalSize);
    areaLabel.textColor = FNGlobalTextGrayColor;
    
    [_priceView addSubview:areaLabel];
    _areaLabel = areaLabel;
}
- (void)setUpCouponView{
    @WeakObj(self);
    UIView *couponView = [[UIView alloc]init];
    [couponView addJXTouch:^{
        if (selfWeak.block) {
            selfWeak.block();
        }
    }];
    [self addSubview:couponView];
    _couponView = couponView;
    
    UIImageView *couponImage = [[UIImageView alloc]init];
    couponImage.image = [UIImage imageNamed:@"productdetail_coupon"];
    [couponImage sizeToFit];
    [_couponView addSubview:couponImage];
    _couponImageView = couponImage;
    
    UILabel *couponTitleLabel = [UILabel new];
    couponTitleLabel.font = FNFontDefault(FNGlobalFontNormalSize);
    couponTitleLabel.text = @"暂无优惠券";
    [_couponView addSubview:couponTitleLabel];
    _couponTitleLabel = couponTitleLabel;
    
    UIImageView *right = [UIImageView new];
    right.image = [UIImage imageNamed:@"productdetail_right"];
    [right sizeToFit];
    [_couponView addSubview:right];
    _rightIconImageView = right;
    
    
}
- (void)layoutAllViews{
    
    [_proTitleLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(PDHVerticalMargin, PDHHorizontalMargin, 0, PDHHorizontalMargin)) excludingEdge:(ALEdgeBottom)];
    
    [_priceView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [_priceView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [_priceView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_proTitleLabel withOffset:PDHVerticalMargin];
    [_priceView autoSetDimension:(ALDimensionHeight) toSize:FNDeviceHeight * 0.15];
    
    [self layoutPriceView];
    
    [_couponView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_priceView];
    [_couponView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [_couponView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [_couponView autoSetDimension:(ALDimensionHeight) toSize:XYTabBarHeight];
    
    [self layoutCouponView];
    
    [self layoutIfNeeded];
    
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.height = CGRectGetMaxY(_couponView.frame);
}
- (void)layoutPriceView{
    CGFloat labelW = (FNDeviceWidth - 3*PDHHorizontalMargin) *0.5;
    
    [_priceLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:PDHHorizontalMargin];
    [_priceLabel autoSetDimension:(ALDimensionWidth) toSize:labelW];
    [_priceLabel autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:PDHHorizontalMargin];
    
    [_orgLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:PDHHorizontalMargin];
    [_orgLabel autoSetDimension:(ALDimensionWidth) toSize:labelW];
    [_orgLabel autoAlignAxis:(ALAxisBaseline) toSameAxisOfView:_priceLabel];
    
    
    [_payLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:PDHHorizontalMargin];
    [_payLabel autoSetDimension:(ALDimensionWidth) toSize:labelW];
    [_payLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_priceLabel withOffset:PDHHorizontalMargin];
    
    [_rebateLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:PDHHorizontalMargin];
    [_rebateLabel autoSetDimension:(ALDimensionWidth) toSize:labelW];
    [_rebateLabel autoAlignAxis:(ALAxisBaseline) toSameAxisOfView:_payLabel];
    
    [_soldLabel autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:PDHHorizontalMargin];
    [_soldLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:PDHHorizontalMargin];
    
    [_areaLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:PDHHorizontalMargin];
    [_areaLabel autoAlignAxis:(ALAxisBaseline) toSameAxisOfView:_soldLabel];
}
- (void)layoutCouponView{
    [_couponImageView autoSetDimensionsToSize:_couponImageView.size];
    [_couponImageView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_couponImageView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:PDHHorizontalMargin];
    
    [_couponTitleLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_couponImageView withOffset:PDHHorizontalMargin];
    [_couponTitleLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [_rightIconImageView autoSetDimensionsToSize:_rightIconImageView.size];
    [_rightIconImageView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_rightIconImageView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:PDHHorizontalMargin];
    
    
}
@end

@interface FNProductDetailHeaderView ()
@property (nonatomic, weak) SDCycleScrollView *cycleView;
@property (nonatomic, weak) FNProductDetailHeaderSubview* headerSubview;
@end
@implementation FNProductDetailHeaderView
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
    CGFloat scrollH = FNDeviceHeight * 0.6;
    SDCycleScrollView *scrollView = [SDCycleScrollView new];
    scrollView.frame = CGRectMake(0, 0, FNDeviceWidth, scrollH);
    scrollView.backgroundColor = FNHomeBackgroundColor;
    scrollView.autoScroll = NO;
    scrollView.pageDotColor = FNHomeBackgroundColor;
    scrollView.currentPageDotColor = FNMainGobalControlsColor;
    scrollView.pageControlAliment =SDCycleScrollViewPageContolAlimentCenter;
    [self addSubview:scrollView];
    _cycleView = scrollView;
    
    FNProductDetailHeaderSubview *headerSubview = [[FNProductDetailHeaderSubview alloc]initWithFrame:CGRectMake(0, scrollH, FNDeviceWidth, 0)];
    headerSubview.block = ^{
        if ([self.delegate respondsToSelector:@selector(couponViewOnClicked)]) {
            [self.delegate couponViewOnClicked];
        }
    };
    [self addSubview:headerSubview];
    _headerSubview = headerSubview;
    
}
- (void)setModel:(FNProductDetailModel *)model{
    _model = model;
    if (_model) {
        _headerSubview.proTitleLabel.text = _model.goods_title;
        _headerSubview.priceLabel.text = [NSString stringWithFormat:@"￥%@",_model.goods_price];
        NSString *textStr = [NSString stringWithFormat:@"￥%@",_model.goods_cost_price];
        //中划线
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
        _headerSubview.orgLabel.attributedText = attribtStr;
        
        _headerSubview.payLabel.text = [NSString stringWithFormat:@"支付%@元",_model.goods_price];
        _headerSubview.rebateLabel.text = [NSString stringWithFormat:@"券抵%@元",_model.yhq_price];
        _headerSubview.soldLabel.text = [NSString stringWithFormat:@"已抢%@件",_model.goods_sales];
        _headerSubview.areaLabel.text = _model.area;
        
        _cycleView.imageURLStringsGroup = _model.images;
        
        [self layoutIfNeeded];
        self.height = CGRectGetMaxY(_headerSubview.frame);
    }
}
- (void)setCouponDes:(NSString *)des{
    _headerSubview.couponTitleLabel.text = des.length>0 ? des:@"暂无优惠券";
}
@end
