//
//  FNSeckillCell.m
//  THB
//
//  Created by jimmy on 2017/5/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNSeckillCell.h"
#import "POPPressButton.h"
#import "FNHSecKillProudctModel.h"
const CGFloat _seckill_img_h = 100;
@interface FNSeckillCell ()
@property (nonatomic, strong) UIImageView* imgView;
@property (nonatomic, strong) UILabel* desLabel;

@property (nonatomic, strong) UIView* couponView;
@property (nonatomic, strong) UIButton* couponButton;
@property (nonatomic, strong)  UILabel* cPriceLabel;
@property (nonatomic, strong) UILabel* couponLabel;

@property (nonatomic, strong) UIView* rebateView;
@property (nonatomic, strong) UILabel* costLabel;
@property (nonatomic, strong) UILabel* rebateLabel;
@property (nonatomic, strong) UILabel* priceLabel;
@property (nonatomic, strong) UIImageView* couponTitle;
@end
@implementation FNSeckillCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    _imgView = [UIImageView new];
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imgView];
    [_imgView autoSetDimensionsToSize:(CGSizeMake(_seckill_img_h, _seckill_img_h))];
    [_imgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_margin10];
    [_imgView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    _desLabel = [UILabel new];
    _desLabel.font = kFONT14;
    _desLabel.numberOfLines = 2;
    [self.contentView addSubview:_desLabel];
    [_desLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_margin10];
    [_desLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeTop) ofView:_imgView];
    [_desLabel autoSetDimension:(ALDimensionHeight) toSize:30];
    [_desLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_imgView withOffset:_jm_margin10];
    
    POPPressButton *button = [[POPPressButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    button.selected            = YES;
    button.target              = self;
    button.backgroundColor = FNWhiteColor;
    button.animationDuration   = 0.35f;
    button.title               = @"抢";
    button.labelColor = FNMainGobalControlsColor;
    button.bgColor = FNWhiteColor;
    button.selector            = @selector(buttonsEvent:);
    button.layer.cornerRadius = 20;
    button.borderColor = FNMainGobalControlsColor;
    [self.contentView addSubview:button];
    [button autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_margin10];
    [button autoSetDimensionsToSize:button.size];
    [button autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_imgView];
    
    
    
    
    [self setUpCouponView];
    [_couponView autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_desLabel];
    [_couponView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_desLabel withOffset:_jm_margin10];
    [_couponView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_imgView withOffset:0];
    [_couponView autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:button withOffset:-10];
    
    [self setUpRebateView];
    [_rebateView autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_desLabel];
    [_rebateView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_desLabel withOffset:_jm_margin10];
    [_rebateView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_imgView withOffset:0];
    [_rebateView autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:button withOffset:-10];
    
    
    UIView* line = [UIView new];
    line.backgroundColor = FNHomeBackgroundColor;
    [self addSubview:line];
    [line autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [line autoSetDimension:(ALDimensionHeight) toSize:1.0];
    
}
- (void)buttonsEvent:(id)sender{
    if (self.rodClicked) {
        self.rodClicked(self.model);
    }
}
- (void)setUpCouponView{
    _couponView = [UIView new];
    [self.contentView addSubview:_couponView];
    
    UIImageView* couponTitle = [UIImageView new];
    couponTitle.image = IMAGE(@"quan0");
    [couponTitle sizeToFit];
    [_couponView addSubview:couponTitle];
    
    
    _couponButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_couponButton setBackgroundImage:IMAGE(@"quan2") forState:UIControlStateNormal];
    [_couponButton sizeToFit];
    _couponButton.titleLabel.font = kFONT12;
    [_couponView addSubview:_couponButton];
    
    
    _cPriceLabel = [UILabel new];
    _cPriceLabel.font = kFONT10;
    _cPriceLabel.adjustsFontSizeToFitWidth = YES;
    [_couponView addSubview:_cPriceLabel];
    
    _couponLabel = [UILabel new];
    _couponLabel.font = kFONT12;
    _couponLabel.adjustsFontSizeToFitWidth = YES;
    _couponLabel.textColor = FNMainGobalControlsColor;
    [_couponView addSubview:_couponLabel];
    
    [couponTitle autoSetDimensionsToSize:couponTitle.size];
    [couponTitle autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [couponTitle autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
    self.couponTitle=couponTitle;
    
    [_couponButton autoSetDimension:(ALDimensionHeight) toSize:self.couponTitle.height];
    [_couponButton autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.couponTitle];
    [_couponButton autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_couponView withOffset:-self.couponTitle.width relation:(NSLayoutRelationLessThanOrEqual)];
    [_couponButton autoAlignAxis:(ALAxisBaseline) toSameAxisOfView:self.couponTitle];
    
    [_cPriceLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [_cPriceLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_cPriceLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    
    [_couponLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, 0, 0, 0)) excludingEdge:(ALEdgeTop)];
    
    
    
}
- (void)setUpRebateView{
    _rebateView = [UIView new];
    [self.contentView addSubview:_rebateView];
    
    _costLabel = [UILabel new];
    _costLabel.font = kFONT12;
    _costLabel.adjustsFontSizeToFitWidth = YES;
    [_rebateView addSubview:_costLabel];
    
    _rebateLabel = [UILabel new];
    _rebateLabel.font = kFONT14;
    _rebateLabel.adjustsFontSizeToFitWidth = YES;
    _rebateLabel.textColor = FNMainGobalControlsColor;
    [_rebateView addSubview:_rebateLabel];
    
    _priceLabel = [UILabel new];
    _priceLabel.font = kFONT10;
    _priceLabel.adjustsFontSizeToFitWidth = YES;
    _priceLabel.textColor = FNMainGobalControlsColor;
    [_rebateView addSubview:_priceLabel];
    
    //layout
    [_costLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    
    [_rebateLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_rebateLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [_rebateLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    
    [_priceLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];

}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNSeckillCell";
    FNSeckillCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNSeckillCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}
- (void)setModel:(FNHSecKillProudctModel *)model
{
    _model = model;
    
    //set datas
    if (_model) {
        [self.imgView setUrlImg:_model.goods_img];
        
        self.desLabel.text = _model.goods_title;
        
        self.cPriceLabel.text =[NSString stringWithFormat:@"¥%@",_model.goods_price];
        
        self.costLabel.text = [NSString stringWithFormat:@"¥%@",_model.goods_cost_price];
        [self.couponButton setTitle:_model.yhq_span forState:UIControlStateNormal];
        
        self.couponButton.sd_layout
        .topEqualToView(_couponView).widthIs(self.couponButton.width).heightIs(self.couponButton.height).leftSpaceToView(self.couponTitle, 0);
        
        NSString* coupon =  [NSString stringWithFormat:@"¥ %@",_model.yhq_price];
        self.couponLabel.text = [NSString stringWithFormat:@"券后价 %@",_model.qh_money];
        [self.couponLabel addSingleAttributed:@{NSFontAttributeName:kFONT16} ofRange:[self.couponLabel.text rangeOfString:coupon]];
        
        
        self.rebateLabel.text =[NSString stringWithFormat:@"  %@元",_model.fcommission];
        [self.rebateLabel addAttchmentImage:IMAGE(@"fan") andBounds:(CGRectMake(0, -3, 15, 15)) atIndex:0];

        
        NSString* price =  [NSString stringWithFormat:@"¥ %@",_model.ds_price];
        self.priceLabel.text = [NSString stringWithFormat:@"到手价 %@",price];
        [self.priceLabel addSingleAttributed:@{NSFontAttributeName:kFONT16} ofRange:[self.priceLabel.text rangeOfString:price]];
        
        if (_model.yhq_price && _model.yhq_price.floatValue > 0) {
            self.couponView.hidden = NO;
            self.rebateView.hidden = YES;
        }else{
            self.couponView.hidden = YES;
            self.rebateView.hidden = NO;
        }
        

        
        
    }
}
@end
