//
//  FNPromotionalListTCell.m
//  THB
//
//  Created by Jimmy on 2017/12/22.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPromotionalListTCell.h"
#import "JMProgressView.h"
const CGFloat _plt_cell_height = 120;
@interface FNPromotionalListTCell()
@property (nonatomic, strong)UIImageView* imgview;
@property (nonatomic, strong) UIView* emptyView;
@property (nonatomic, strong) UIImageView* emptyImageView;

@property (nonatomic, strong)UILabel* desLabel;
@property (nonatomic, strong)UILabel* subLabel;
@property (nonatomic, strong)JMProgressView* progressview;
@property (nonatomic, strong)UIImageView* progressimgview;
@property (nonatomic, strong)UILabel* salesLabel;
@property (nonatomic, strong)UILabel* priceLabel;
@property (nonatomic, strong)UIImageView* couponimview;
@property (nonatomic, strong)UILabel* couponLabel;
@property (nonatomic, strong)UIImageView* operationview;

@end
@implementation FNPromotionalListTCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - setter and getter
- (UIImageView *)imgview{
    if (_imgview == nil) {
        _imgview = [UIImageView new];
        _imgview.contentMode = UIViewContentModeScaleAspectFit;
        [_imgview addSubview:self.emptyView];
        //empty view
        [self.emptyView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    }
    return _imgview;
}

/**
 about sold out
 */
- (UIView *)emptyView{
    if (_emptyView == nil) {
        _emptyView = [UIView new];
        _emptyView.backgroundColor = [FNBlackColor colorWithAlphaComponent:0.2];
    
        [_emptyView addSubview:self.emptyImageView];
        [self.emptyImageView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    }
    return _emptyView;
}
- (UIImageView *)emptyImageView{
    if (_emptyImageView == nil) {
        _emptyImageView = [[UIImageView alloc]init];
        _emptyImageView.image = IMAGE(@"home_soldout");
        _emptyImageView.contentMode = UIViewContentModeCenter;
    }
    return _emptyImageView;
}

-(UILabel *)desLabel{
    if (_desLabel == nil) {
        _desLabel = [UILabel new];
        _desLabel.font = kFONT14;
    }
    return _desLabel;
}

-(UILabel *)subLabel{
    if (_subLabel == nil) {
        _subLabel = [UILabel new];
        _subLabel.font = kFONT12;
        _subLabel.textColor = FNGlobalTextGrayColor;
    }
    return _subLabel;
}
- (UIImageView *)progressimgview{
    if (_progressimgview == nil) {
        _progressimgview = [[UIImageView alloc]initWithImage:IMAGE(@"rob_hot")];
    }
    return _progressimgview;
}
- (UILabel *)salesLabel{
    if (_salesLabel == nil) {
        _salesLabel = [UILabel new];
        _salesLabel.font = [UIFont systemFontOfSize:10];
        _salesLabel.textColor = FNWhiteColor;
        _salesLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _salesLabel;
}
- (JMProgressView *)progressview{
    if (_progressview == nil) {
        _progressview = [[JMProgressView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth*0.33, 12))];
        _progressview.bgColor = FNColor(250, 197, 216);
        _progressview.highlightedColor = FNColor(250, 32, 39);
        _progressview.maxNum = 100;
//        _progressview.isGradient = YES;
        UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:_progressview.bounds byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight) cornerRadii:(CGSizeMake(_progressview.height, _progressview.height))];
        CAShapeLayer* layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        _progressview.layer.mask = layer;
  
    }
    return _progressview;
}

- (UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [UILabel new];
        _priceLabel.font = kFONT14;
        _priceLabel.textColor = RED;
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
        _couponLabel.textAlignment = NSTextAlignmentCenter;
        _couponLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _couponLabel;
}
- (UIImageView *)couponimview{
    if (_couponimview == nil) {
        _couponimview = [[UIImageView alloc]initWithImage:IMAGE(@"rob_quan_bj")];
        
        [_couponimview addSubview:self.couponLabel];
        [self.couponLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
        [self.couponLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:3];
        [self.couponLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    }
    return _couponimview;
}

/**
 About operation
 */

- (UIImageView *)operationview{
    if (_operationview == nil) {
        _operationview = [UIImageView new];
        
    }
    return _operationview;
}

- (void)setModel:(FNBaseProductModel *)model{
    _model = model;
    if (_model) {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self.imgview setUrlImg:_model.goods_img];
//        });
        
        [self.operationview setUrlImg:self.model.str_img];
        self.desLabel.text = _model.goods_title;
        self.subLabel.text = _model.str_tg;
        
        _emptyView.hidden = !_model.is_qiangguang.boolValue;
        NSString* price = [NSString stringWithFormat:@"¥%.2lf",self.model.goods_price.floatValue];
        if ([NSString checkIsSuccess:_model.yhq andElement:@"1"]) {
            self.priceLabel.text = [NSString stringWithFormat:@"券后价%@",price];
            self.couponLabel.text = _model.yhq_span;
        }else{
            self.priceLabel.text = [NSString stringWithFormat:@"折后价%@",price];
            self.couponLabel.text = _model.zhe;
        }
        if ([self.priceLabel.text containsString:price]) {
            [self.priceLabel addSingleAttributed:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} ofRange:[self.priceLabel.text rangeOfString:price]];
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
        
        [self.progressview setPersentNum:self.model.jindu.integerValue];
        
        self.salesLabel.text = [NSString stringWithFormat:@"已售%ld",self.model.goods_sales.integerValue];
    }
}

#pragma mark - set up view
- (void)jm_setupViews{
    
    [self.contentView addSubview:self.imgview];
    [self.imgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeRight)];
    [self.imgview autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionHeight) ofView:self.imgview];
    
    [self.contentView addSubview:self.desLabel];
    [self.desLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.imgview withOffset:_jmsize_10];
    [self.desLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeTop) ofView:self.imgview withOffset:_jmsize_10];
    [self.desLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
    
    [self.contentView addSubview:self.subLabel];
    [self.subLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.desLabel withOffset:0];
    [self.subLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.desLabel withOffset:5];
    [self.desLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
    
    [self.contentView addSubview:self.couponimview];
    [self.couponimview autoSetDimensionsToSize:self.couponimview.size];
    [self.couponimview autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:_jmsize_10
     ];
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.couponimview];
    [self.priceLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.desLabel withOffset:0];
    [self.priceLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:self.contentView withMultiplier:0.3 relation:(NSLayoutRelationLessThanOrEqual)];
    
    [self.couponimview autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.priceLabel withOffset:5];
    
    [self.contentView addSubview:self.operationview];
    [self.operationview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.couponimview withOffset:-5];
    [self.operationview autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionHeight) ofView:self.contentView withMultiplier:0.42];
    [self.operationview autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionWidth) ofView:self.operationview];
    [self.operationview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
    
    
    [self.contentView addSubview:self.progressview];
    
    [self.progressview autoSetDimension:(ALDimensionWidth) toSize:self.progressview.width];
    [self.progressview autoSetDimension:(ALDimensionHeight) toSize:self.progressview.height];
    [self.progressview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:self.couponimview withOffset:-10];
    
    [self.contentView addSubview:self.progressimgview];
    [self.progressimgview autoSetDimensionsToSize:self.progressimgview.size];
    [self.progressimgview autoAlignAxis:(ALAxisBaseline) toSameAxisOfView:self.progressview withOffset:0.5];
    [self.progressimgview autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.desLabel];
    [self.progressview autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.progressimgview withOffset:-5];
    
    [self.contentView addSubview:self.salesLabel];
    [self.salesLabel autoSetDimensionsToSize:(CGSizeMake(self.progressview.width-15, self.progressview.height-4))];
    [self.salesLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.progressview];
    [self.salesLabel autoAlignAxis:(ALAxisVertical) toSameAxisOfView:self.progressview];
    
    [self.contentView addLineOnDirection:(LineDirectionBottom) withLineSzie:(CGSizeMake(JMScreenWidth, 1))];
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    static NSString *reuseIdentifier = @"FNPromotionalListTCell";
    FNPromotionalListTCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNPromotionalListTCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}
@end
