//
//  FNHomeSpecialCCell.m
//  THB
//
//  Created by Jimmy on 2017/12/16.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNHomeSpecialCCell.h"
extern const CGFloat _hscc_btm_h = 50;
@interface FNHomeSpecialCCell()
@property (nonatomic, strong) UIImageView* imgView;
@property (nonatomic, strong) UILabel* titleLabel;

@property (nonatomic, strong) UIView* bottomView;
@property (nonatomic, strong) UIImageView* priceImgview;
@property (nonatomic, strong) UILabel* priceLabel;
@property (nonatomic, strong) UILabel* toppriceLabel;


@property (nonatomic, strong) UILabel* salesLabel;
@property (nonatomic, strong) UIImageView* couponImgView;
@property (nonatomic, strong) UILabel* couponLabel;
@end
@implementation FNHomeSpecialCCell

-(UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [UIImageView new];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = kFONT13;
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}
- (UIImageView *)priceImgview{
    if (_priceImgview == nil) {
        _priceImgview = [[UIImageView alloc]initWithImage:IMAGE(@"list_after_quan")];
        
    }
    return _priceImgview;
}
- (UILabel *)toppriceLabel{
    if (_toppriceLabel == nil) {
        _toppriceLabel = [UILabel new];
        _toppriceLabel.font = kFONT11;
        _toppriceLabel.textColor = FNGlobalTextGrayColor;
        _toppriceLabel.textAlignment = NSTextAlignmentLeft;
        _toppriceLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _toppriceLabel;
}
- (UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [UILabel new];
        _priceLabel.font = [UIFont boldSystemFontOfSize:16];
        _priceLabel.textColor = FNMainGobalTextColor;
        _priceLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _priceLabel;
}

- (UILabel *)salesLabel{
    if (_salesLabel == nil) {
        _salesLabel = [UILabel new];
        _salesLabel.font = kFONT11;
        _salesLabel.textColor = FNGlobalTextGrayColor;
        _salesLabel.textAlignment = NSTextAlignmentCenter;
        _salesLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _salesLabel;
}
- (UIImageView *)couponImgView{
    if (_couponImgView == nil) {
        _couponImgView = [[UIImageView alloc]initWithImage:IMAGE(@"quan_bj")];
        
        [_couponImgView addSubview:self.couponLabel];
        [self.couponLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    }
    return _couponImgView;
}
- (UILabel *)couponLabel{
    if (_couponLabel == nil) {
        _couponLabel = [UILabel new];
        _couponLabel.font = kFONT11;
        _couponLabel.textColor = FNWhiteColor;
        _couponLabel.adjustsFontSizeToFitWidth = YES;
        _couponLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _couponLabel;
}

- (UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [UIView new];
        
        [_bottomView addSubview:self.couponImgView];
        [self.couponImgView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        [self.couponImgView autoSetDimensionsToSize:CGSizeMake(self.couponImgView.width+20, self.couponImgView.height)];
        [self.couponImgView autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];
        
        [_bottomView addSubview:self.salesLabel];
        [self.salesLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self.couponImgView];
        [self.salesLabel autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:self.couponImgView withOffset:-5];
        
        [_bottomView addSubview:self.toppriceLabel];
        [self.toppriceLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [self.toppriceLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.salesLabel];
        [self.toppriceLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_bottomView withMultiplier:0.4];
        
        [_bottomView addSubview:self.priceImgview];
        [self.priceImgview autoSetDimensionsToSize:self.priceImgview.size];
        [self.priceImgview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [self.priceImgview autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.couponImgView];
        
        [_bottomView addSubview:self.priceLabel];
        [self.priceLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.priceImgview withOffset:5];
        [self.priceLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.couponImgView];
        [self.priceLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_bottomView withMultiplier:0.28];
        
    }
    return _bottomView;
}


#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.backgroundColor = FNWhiteColor;
    [self.contentView addSubview:self.imgView];
    [self.imgView                 autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, 0, 0, 0)) excludingEdge:(ALEdgeBottom)];
    [self.imgView autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionWidth) ofView:self.imgView];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.imgView withOffset:_jmsize_10];
    [self.titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
    [self.titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
    
    [self.contentView addSubview:self.bottomView];
    [self.bottomView autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.titleLabel];
    [self.bottomView autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self.titleLabel];
    [self.bottomView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.titleLabel withOffset:5];
    [self.bottomView autoSetDimension:(ALDimensionHeight) toSize:_hscc_btm_h];
   
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"FNHomeSpecialCCell";
    FNHomeSpecialCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    return cell;
}
- (void)setModel:(FNBaseProductModel *)model{
    _model = model;
    if (_model) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [_imgView setUrlImg:_model.goods_img];
        });
        self.titleLabel.text = [NSString stringWithFormat:@" %@",_model.goods_title];
        [_titleLabel HttpLabelLeftImage:_model.shop_img label:_titleLabel imageX:0 imageY:-1.5 imageH:13 atIndex:0];
        self.toppriceLabel.text = [NSString stringWithFormat:@"%@ ¥%.2f",_model.shop_type,[_model.goods_cost_price floatValue]];
        self.salesLabel.text = [NSString stringWithFormat:@" 月销 %ld",_model.goods_sales.integerValue];
        self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[_model.goods_price floatValue]];
        self.couponLabel.text =_model.yhq.boolValue ? _model.yhq_span:_model.zhe;
        [self.couponImgView setUrlImg:_model.quan_bjimg];
        [self.priceImgview sd_setImageWithURL:[NSURL URLWithString:_model.goods_ico_one] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image!=nil) {
                [self.priceImgview autoSetDimensionsToSize:self.priceImgview.size];
                if (cacheType == SDImageCacheTypeNone || cacheType == SDImageCacheTypeDisk) {
                    self.priceImgview.image = image;
                    self.alpha = 0;
                    [UIView animateWithDuration:1 animations:^{
                        self.alpha = 1.f;
                    }];
                } else {
                    self.priceImgview.image = image;
                    self.alpha = 1.f;
                }
            }else{
                [self.priceImgview autoSetDimensionsToSize:CGSizeMake(0, 0)];
            }
        }];
    }
}

@end
