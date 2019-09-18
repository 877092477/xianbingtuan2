//
//  FNPromotionalListCCell.m
//  THB
//
//  Created by Jimmy on 2017/12/22.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPromotionalListCCell.h"
@interface FNPromotionalListCCell()
@property (nonatomic, strong)UIImageView* imgview;

@property (nonatomic, strong)UIImageView* rankImgview;
@property (nonatomic, strong)UILabel* rankLabel;

@property (nonatomic, strong)UIImageView* todaySaleImgview;
@property (nonatomic, strong)UILabel* todaySaleLabel;

@property (nonatomic, strong)UIImageView* nimgview;

@property (nonatomic, strong)UIImageView* imgCouponimgview;
@property (nonatomic, strong)NSLayoutConstraint* imgCouponConsW;
@property (nonatomic, assign)CGFloat imgCouponW;
@property (nonatomic, strong)UILabel* imgCouponLabel;

@property (nonatomic, strong)UILabel* desLabel;
@property (nonatomic, strong)UILabel* monthsalesLabel;
@property (nonatomic, strong)UILabel* salesLabel;
@property (nonatomic, strong)UILabel* priceLabel;
@property (nonatomic, strong)NSLayoutConstraint* priceConsw;

@property (nonatomic, strong)UIImageView* couponimview;
@property (nonatomic, strong)UILabel* couponLabel;

@end
@implementation FNPromotionalListCCell
#pragma mark - setter and getter
- (UIImageView *)imgview{
    if (_imgview == nil) {
        _imgview = [UIImageView new];
        _imgview.contentMode = UIViewContentModeScaleAspectFit;
        
        [_imgview addSubview:self.rankImgview];
        [self.rankImgview autoSetDimensionsToSize:self.rankImgview.size];
        [self.rankImgview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:5];
        [self.rankImgview autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
        
        [_imgview addSubview:self.todaySaleImgview];
        [self.todaySaleImgview autoSetDimensionsToSize:self.todaySaleImgview.size];
        [self.todaySaleImgview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [self.todaySaleImgview autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:_jmsize_10];
        
        [_imgview addSubview:self.imgCouponimgview];
        self.imgCouponConsW = [self.imgCouponimgview autoSetDimension:(ALDimensionWidth) toSize:self.imgCouponimgview.width];
        [self.imgCouponimgview autoSetDimension:(ALDimensionHeight) toSize:self.imgCouponimgview.height];
        [self.imgCouponimgview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        [self.imgCouponimgview autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];
        
        [_imgview addSubview:self.nimgview];
        [self.nimgview autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:self.imgCouponimgview];
        [self.nimgview autoSetDimensionsToSize:(CGSizeMake(self.nimgview.width, self.imgCouponimgview.height))];
        [self.nimgview autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];
    }
    return _imgview;
}

- (UILabel *)rankLabel{
    if (_rankLabel == nil) {
        _rankLabel = [UILabel new];
        _rankLabel.font = kFONT12;
        _rankLabel.textColor = FNWhiteColor;
        _rankLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _rankLabel;
}
- (UIImageView *)rankImgview{
    if (_rankImgview == nil) {
        _rankImgview = [[UIImageView alloc]initWithImage:IMAGE(@"ranking_bj")];
        
        [_rankImgview addSubview:self.rankLabel];
        [self.rankLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:3];
        [self.rankLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:3];
        [self.rankLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    }
    return _rankImgview;
}


/**
 About today sales
 */
- (UILabel *)todaySaleLabel{
    if (_todaySaleLabel == nil) {
        _todaySaleLabel = [UILabel new];
        _todaySaleLabel.font = kFONT10;
        _todaySaleLabel.textColor = FNGlobalTextGrayColor;
        
        _todaySaleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _todaySaleLabel;
}
- (UIImageView *)todaySaleImgview{
    if (_todaySaleImgview == nil) {
        _todaySaleImgview = [[UIImageView alloc]initWithImage:IMAGE(@"generalize_bj") ];
        _todaySaleImgview.size = CGSizeMake(_todaySaleImgview.width+30, _todaySaleImgview.height+5);
        [_todaySaleImgview addSubview:self.todaySaleLabel];
        [self.todaySaleLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(3, 15, 3, 3))];
        
    }
    return _todaySaleImgview;
}


/**
 About coupon on image
 */
- (UILabel *)imgCouponLabel{
    if (_imgCouponLabel == nil) {
        _imgCouponLabel = [UILabel new];
        _imgCouponLabel.textColor = FNWhiteColor;
        _imgCouponLabel.font = kFONT12;
        _imgCouponLabel.textAlignment =NSTextAlignmentCenter;
        _imgCouponLabel.adjustsFontSizeToFitWidth = YES;
        
    }
    return _imgCouponLabel;
}
- (UIImageView *)imgCouponimgview{
    if (_imgCouponimgview == nil) {
        _imgCouponimgview = [[UIImageView alloc]initWithImage:IMAGE(@"tao_quan_bj")];
        _imgCouponimgview.size = CGSizeMake(_imgCouponimgview.width+10, _imgCouponimgview.height);
        self.imgCouponW = _imgCouponimgview.width;
        [_imgCouponimgview addSubview:self.imgCouponLabel];
        [self.imgCouponLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(3, 3, 3, 3))];
    }
    return _imgCouponimgview;
}

- (UIImageView *)nimgview{
    if (_nimgview == nil) {
        _nimgview = [[UIImageView alloc]initWithImage:IMAGE(@"list_new")];
    }
    return _nimgview;
}
-(UILabel *)desLabel{
    if (_desLabel == nil) {
        _desLabel = [UILabel new];
        _desLabel.font = kFONT14;
    }
    return _desLabel;
}

-(UILabel *)monthsalesLabel{
    if (_monthsalesLabel == nil) {
        _monthsalesLabel = [UILabel new];
        _monthsalesLabel.font = kFONT10;
        _monthsalesLabel.textColor = FNGlobalTextGrayColor;
        _monthsalesLabel.adjustsFontSizeToFitWidth = YES;
        _monthsalesLabel.textAlignment = NSTextAlignmentRight;
    }
    return _monthsalesLabel;
}

- (UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [UILabel new];
        _priceLabel.font = kFONT14;
        _priceLabel.textColor= RED;
        _priceLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _priceLabel;
}

/**
 About coupon
 */
- (UILabel *)couponLabel{
    if (_couponLabel == nil) {
        _couponLabel = [UILabel new];
        _couponLabel.textColor = FNWhiteColor;
        _couponLabel.font = kFONT10;
        _couponLabel.textAlignment =NSTextAlignmentCenter;
        _couponLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _couponLabel;
}
- (UIImageView *)couponimview{
    if (_couponimview == nil) {
        _couponimview = [[UIImageView alloc]initWithImage:IMAGE(@"quan_bj")];
        _couponimview.size = CGSizeMake(_couponimview.width, _couponimview.height);
        [_couponimview addSubview:self.couponLabel];
        [self.couponLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(3, 3, 3, 3))];
    }
    return _couponimview;
}

- (UILabel *)salesLabel{
    if (_salesLabel == nil) {
        _salesLabel = [UILabel new];
        _salesLabel.textColor = FNGlobalTextGrayColor;
        _salesLabel.font = kFONT10;
        _salesLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _salesLabel;
}


- (void)setModel:(FNBaseProductModel *)model{
    _model = model;
    if (_model) {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self.imgview setUrlImg:_model.goods_img];
//        });
        if (![NSString isEmpty:self.model.n_icon]) {
            [self.nimgview setUrlImg:self.model.n_icon];
            self.nimgview.hidden = NO;
        }else{
            self.nimgview.hidden = YES;
        }
        if (![NSString isEmpty:self.model.px_id]) {
            self.rankLabel.text = self.model.px_id;
            self.rankImgview.hidden = NO;
        }else{
            self.rankImgview.hidden = YES;
        }
        self.desLabel.text = _model.goods_title;
        _priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[_model.goods_price floatValue]];
        self.todaySaleLabel.text = _model.str_tg;
        self.todaySaleImgview.hidden = [NSString isEmpty:_model.str_tg];
        self.monthsalesLabel.text = [NSString stringWithFormat:@"%@",self.model.goods_sales];
        self.salesLabel.text = [NSString stringWithFormat:@" %@",self.model.goods_sales];
        NSString* price = [NSString stringWithFormat:@"¥%.2lf",self.model.goods_price.floatValue];
        if ([NSString checkIsSuccess:_model.yhq andElement:@"1"]) {
            self.priceLabel.text = [NSString stringWithFormat:@"券后价%@",price];
            self.couponLabel.text = _model.yhq_span;
            self.imgCouponLabel.text = _model.yhq_span;
        }else{
            self.priceLabel.text = [NSString stringWithFormat:@"折后价%@",price];
            self.couponLabel.text = _model.zhe;
            self.imgCouponLabel.text = _model.zhe;
        }
        if ([self.priceLabel.text containsString:price]) {
            [self.priceLabel addSingleAttributed:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} ofRange:[self.priceLabel.text rangeOfString:price]];
        }
        
        if ([NSString checkIsSuccess:self.view_type andElement:@"1"] ) {
            //
            self.priceConsw.constant = (JMScreenWidth-15)*0.5*0.33;
            self.salesLabel.hidden = NO;
            self.imgCouponimgview.hidden = YES;
            self.couponimview.hidden = NO;
            self.monthsalesLabel.hidden = YES;
            self.imgCouponConsW.constant = 0;
            
        }else{
            self.priceConsw.constant = (JMScreenWidth-15)*0.5*0.5;
            self.salesLabel.hidden = YES;
            self.imgCouponimgview.hidden = NO;
            self.couponimview.hidden = YES;
            self.monthsalesLabel.hidden = NO;
            self.imgCouponConsW.constant = self.imgCouponW;
        }
        NSTextAttachment* attch = [NSTextAttachment new];
        attch.image = IMAGE(@"Tmall");
        
        CGRect titleRect = CGRectMake(0, -1.5, 13*attch.image.size.width/attch.image.size.height, 13);
        NSMutableAttributedString* matt = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@",self.desLabel.text]];
        
        if ([NSString checkIsSuccess:_model.shop_id andElement:@"2"]) {
            attch.image = IMAGE(@"Tmall");
            
            
        }else if ([NSString checkIsSuccess:_model.shop_id andElement:@"3"]){
            attch.image = IMAGE(@"JD");
            
        }else{
            attch.image = IMAGE(@"Taobao");
            
        }
        attch.bounds = titleRect;
        NSAttributedString *att = [NSAttributedString attributedStringWithAttachment:attch];
        [matt insertAttributedString:att atIndex:0];
        self.desLabel.attributedText = matt;
    }
}
- (void)jm_setupViews{
    [self.contentView addSubview:self.imgview];
    [self.imgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.imgview autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionWidth) ofView:self.imgview];
    
    [self.contentView addSubview:self.desLabel];
    [self.desLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
    [self.desLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
    [self.desLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.imgview withOffset:_jmsize_10];
    
    [self.contentView addSubview:self.couponimview];
    [self.couponimview autoSetDimensionsToSize:self.couponimview.size];
    [self.couponimview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
    [self.couponimview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.desLabel withOffset:5];
    
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.desLabel];
    self.priceConsw = [self.priceLabel autoSetDimension:(ALDimensionWidth) toSize:(JMScreenWidth-15)*0.5];
    [self.priceLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.couponimview];
    
    [self.contentView addSubview:self.salesLabel];
    [self.salesLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.priceLabel];
    [self.salesLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:self.couponimview withOffset:-5];
    [self.salesLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.priceLabel withOffset:5];
    
    [self.contentView addSubview:self.monthsalesLabel];
    [self.monthsalesLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self.desLabel];
    [self.monthsalesLabel autoSetDimension:(ALDimensionWidth) toSize:(JMScreenWidth-15)*0.5*0.38];
    [self.monthsalesLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.couponimview];
    
}
//class method: get cell instance
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNPromotionalListCCell";
    FNPromotionalListCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    return cell;
}
@end
