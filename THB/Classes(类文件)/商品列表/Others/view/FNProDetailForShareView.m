//
//  FNProDetailForShareView.m
//  THB
//
//  Created by jimmy on 2017/9/21.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNProDetailForShareView.h"
#import "SDCycleScrollView.h"
#import "DiscountLabel.h"
@interface FNProDetailForShareView ()

@property (nonatomic, strong)UIView* topview;
@property (nonatomic, strong)SDCycleScrollView* imgscrollview;
@property (nonatomic, strong)UILabel* desLabel;
@property (nonatomic, strong)UILabel* priceLabel;
@property (nonatomic, strong)DiscountLabel* costLabel;
@property (nonatomic, strong)UILabel* rebateLabel;
@property (nonatomic, strong)UILabel* top_promotionalLabel;

@property (nonatomic, strong)UIView* couponview;
@property (nonatomic, strong)NSLayoutConstraint* couponviewconsh;
@property (nonatomic, strong)UIButton* couponBtn;
@property (nonatomic, strong)UILabel* btm_promotionalLabel;


@end
@implementation FNProDetailForShareView
- (UIView *)topview{
    if (_topview == nil) {
        _topview = [UIView new];
        _topview.backgroundColor = FNWhiteColor;
        [_topview addSubview:self.imgscrollview];
        [self.imgscrollview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
        [self.imgscrollview autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionWidth) ofView:self.imgscrollview];
        
        [_topview addSubview:self.desLabel];
        [self.desLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.imgscrollview  withOffset:5];
        [self.desLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_margin10];
        [self.desLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_margin10];
        
        [_topview addSubview:self.priceLabel];
        [self.priceLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.desLabel withOffset:0];
        [self.priceLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.desLabel withOffset:5];
        
        [_topview addSubview:self.costLabel];
        [self.costLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.priceLabel withOffset:_jm_margin10];
        [self.costLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.priceLabel];
        
        [_topview addSubview:self.rebateLabel];
        [self.rebateLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.priceLabel];
        [self.rebateLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.priceLabel withOffset:5];
        
        [_topview addSubview:self.top_promotionalLabel];
        [self.top_promotionalLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight)  withInset:_jmsize_10];
        [self.top_promotionalLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.priceLabel];
        
    }
    return _topview;
}
- (SDCycleScrollView *)imgscrollview{
    if (_imgscrollview == nil) {
        _imgscrollview = [SDCycleScrollView new];
    }
    return _imgscrollview;
}
- (UILabel *)desLabel{
    if (_desLabel == nil) {
        _desLabel = [UILabel new];
        _desLabel.font = kFONT14;
        _desLabel.numberOfLines = 0;
    }
    return _desLabel;
}
- (UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [UILabel new];
        _priceLabel.font = kFONT12;
        _priceLabel.textColor = FNMainGobalControlsColor;
        
    }
    return _priceLabel;
}
- (DiscountLabel *)costLabel{
    if (_costLabel == nil) {
        _costLabel  = [[DiscountLabel alloc]initWithFrame:(CGRectMake(0, 0, 100, 15))];
        _costLabel.lineColor = FNGlobalTextGrayColor;
        _costLabel.lineWidth = 1;
        _costLabel.textColor = FNGlobalTextGrayColor;
        _costLabel.font = kFONT12;
        
    }
    return _costLabel;
}
- (UILabel *)rebateLabel{
    if (_rebateLabel == nil) {
        _rebateLabel = [UILabel new];
        _rebateLabel.textColor = FNMainGobalControlsColor;
        _rebateLabel.font = kFONT14;
    }
    return _rebateLabel;
}
- (UILabel *)top_promotionalLabel{
    if (_top_promotionalLabel == nil) {
        _top_promotionalLabel = [UILabel new];
        _top_promotionalLabel.textColor = FNMainGobalControlsColor;
        _top_promotionalLabel.hidden = YES;
        _top_promotionalLabel.font = kFONT14;
    }
    return _top_promotionalLabel;
}
- (UILabel *)btm_promotionalLabel{
    if (_btm_promotionalLabel == nil) {
        _btm_promotionalLabel = [UILabel new];
        _btm_promotionalLabel.textColor = FNMainGobalControlsColor;
        _btm_promotionalLabel.hidden = YES;
        _btm_promotionalLabel.font = kFONT14;
    }
    return _btm_promotionalLabel;
}
- (UIView *)couponview{
    if (_couponview == nil) {
        _couponview = [UIView new];
        _couponview.backgroundColor =  FNWhiteColor;
        UIView* bgview = [UIView new];
        
        [_couponview addSubview:bgview];
        [bgview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_margin10];
        [bgview autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        
        
        [bgview autoSetDimension:(ALDimensionWidth) toSize:170];
        

        UIImageView* couponImg = [[UIImageView alloc]init];
        NSString* img = @"quan0";
#if APP_XYJ == 1
        img = @"xyj_quan_left";
        UILabel* tmpLabel = [UILabel new];
        tmpLabel.text = @"领券";
        tmpLabel.font = kFONT10;
        tmpLabel.textColor = FNWhiteColor;
        tmpLabel.textAlignment = NSTextAlignmentCenter;
        [couponImg addSubview:tmpLabel];
        [tmpLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(2, 2, 2, 2))];
        
        [self.couponBtn setBackgroundImage:IMAGE(@"xyj_quan_right") forState:(UIControlStateNormal)];
#endif
        couponImg.image = IMAGE(img);
        [couponImg sizeToFit];
        [bgview addSubview:couponImg];
        
        [bgview autoSetDimension:(ALDimensionHeight) toSize:couponImg.height];

        [bgview addSubview:self.couponBtn];
        
        [couponImg autoSetDimensionsToSize:couponImg.size];
        [couponImg autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [couponImg autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        
        [_couponBtn autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:couponImg];
        [_couponBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [_couponBtn autoSetDimension:(ALDimensionHeight) toSize:couponImg.height];
        [_couponBtn autoSetDimension:(ALDimensionWidth) toSize:(170-couponImg.width) relation:(NSLayoutRelationLessThanOrEqual)];
        
        [_couponview addSubview:self.btm_promotionalLabel];
        [self.btm_promotionalLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight)  withInset:_jmsize_10];
        [self.btm_promotionalLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];

    }
    return _couponview;
}
- (UIButton *)couponBtn{
    if (_couponBtn == nil) {
        _couponBtn  = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _couponBtn.userInteractionEnabled = NO;
        [_couponBtn setBackgroundImage:IMAGE(@"quan2")  forState:UIControlStateNormal];
        _couponBtn.titleLabel.font = kFONT12;
    }
    return _couponBtn;
}
#pragma mark - initializedSubviews

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self jm_setupViews];
    }
    return self;
}
- (void)jm_setupViews
{
    [self addSubview:self.topview];
    [self.topview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
#if APP_XYJ == 1
    self.rebateLabel.hidden = YES;
    [self.topview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.priceLabel withOffset:10];
#else
    [self.topview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.rebateLabel withOffset:10];
#endif
    [self.topview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.rebateLabel withOffset:10];
    
    [self addSubview:self.couponview];
    [self.couponview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.couponview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [self.couponview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.topview withOffset:5];
    self.couponviewconsh = [self.couponview autoSetDimension:(ALDimensionHeight) toSize:44];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.height = CGRectGetMaxY(self.couponview.frame);
}
- (void)setModel:(FNBaseProductModel *)model{
    _model = model;
    if (self.model.goods_img) {
        self.imgscrollview.imageURLStringsGroup = @[self.model.goods_img];
    }
    if ([_model.yhq_url kr_isNotEmpty]) {
        self.priceLabel.text = [NSString stringWithFormat:@"券后价¥ %.2f",[self.model.goods_price floatValue]];
    }else{
        self.priceLabel.text = [NSString stringWithFormat:@" ¥ %.2f",[self.model.goods_price floatValue]];
    }
    
    self.desLabel.text = self.model.goods_title;
    
    self.costLabel.text  =[NSString stringWithFormat:@"¥ %.2lf",self.model.goods_cost_price.floatValue];
    
  
    if ([FNBaseSettingModel settingInstance].app_fanli_onoff.boolValue) {
        self.rebateLabel.text = [NSString stringWithFormat:@" ¥%.2f",[_model.fcommission floatValue]];
        [self.rebateLabel addAttchmentImage:IMAGE(@"fan") andBounds:CGRectMake(0, -3, 15, 15) atIndex:0];
    }else{
        self.rebateLabel.text = _model.app_fanli_off_str;
    }
    
    
    if ([NSString checkIsSuccess:_model.shop_id andElement:@"2"]) {
        NSTextAttachment* attch = [NSTextAttachment new];
        attch.image = IMAGE(@"Tmall");
        attch.bounds = CGRectMake(0, -3, 15*attch.image.size.width/attch.image.size.height, 15);
        NSAttributedString *att = [NSAttributedString attributedStringWithAttachment:attch];
        NSMutableAttributedString* matt = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"  %@",self.desLabel.text]];
        [matt insertAttributedString:att atIndex:0];
        self.desLabel.attributedText = matt;
        
    }else if ([NSString checkIsSuccess:_model.shop_id andElement:@"3"]){
        NSTextAttachment* attch = [NSTextAttachment new];
        attch.image = IMAGE(@"JD");
        attch.bounds = CGRectMake(0, -3, 15*attch.image.size.width/attch.image.size.height, 15);
        NSAttributedString *att = [NSAttributedString attributedStringWithAttachment:attch];
        NSMutableAttributedString* matt = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"  %@",self.desLabel.text]];
        [matt insertAttributedString:att atIndex:0];
        self.desLabel.attributedText = matt;
    }

    [_couponBtn setTitle:[NSString stringWithFormat:@"  %@  ",_model.yhq_span] forState:UIControlStateNormal];
#if APP_XYJ == 1
    self.top_promotionalLabel.text = self.model.tgfl;
    self.btm_promotionalLabel.text = self.model.tgfl;
    if (![NSString checkIsSuccess:_model.yhq andElement:@"1"]) {
        self.couponview.hidden = YES;
        self.couponviewconsh.constant = 0;
        self.priceLabel.text = [NSString stringWithFormat:@"折后价¥ %.2f",[self.model.goods_price floatValue]];
        self.top_promotionalLabel.hidden = NO;
        self.btm_promotionalLabel.hidden = YES;
    }else{
        self.couponview.hidden = NO;
        self.couponviewconsh.constant = 44;
        self.priceLabel.text = [NSString stringWithFormat:@"券后价¥ %.2f",[self.model.goods_price floatValue]];
        
        self.top_promotionalLabel.hidden = YES;
        self.btm_promotionalLabel.hidden = NO;
    }
#else
    if (![NSString checkIsSuccess:_model.yhq andElement:@"1"]) {
        self.couponview.hidden = YES;
        self.couponviewconsh.constant = 0;
    }else{
        self.couponview.hidden = NO;
        self.couponviewconsh.constant = 44;
    }
#endif
    [self.priceLabel addSingleAttributed:@{NSFontAttributeName:kFONT17} ofRange:[self.priceLabel.text rangeOfString:[NSString stringWithFormat:@"%.2f",[self.model.goods_price floatValue]]]];
    [self layoutIfNeeded];
}
@end
