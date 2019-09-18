//
//  FNheatProductNCell.h
//  THB
//
//  Created by 李显 on 2018/9/10.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FNBaseProductModel;
@interface FNheatProductNCell : UICollectionViewCell



/** 商品图片 **/
@property (nonatomic, strong)UIImageView* GoodsImage;

/** 商品标题 **/
@property (nonatomic, strong)UILabel* GoodsTitleLabel;

/** 优惠BgView **/
@property (nonatomic, strong)UIView* discountsBgView;

/** 优惠Bg **/
@property (nonatomic, strong)UIImageView* discountsView;

/** 券 **/
@property (nonatomic, strong)UIImageView* ticketImg;

/** 券 面值 **/
@property (nonatomic, strong)UILabel* ticketPriceLable;

/** 下单 **/
@property (nonatomic, strong)UIImageView* placeAnorderView;

/** 下单标题 **/
@property (nonatomic, strong)UILabel* placeAnOrderLable;

/** 原价 **/
@property (nonatomic, strong)UILabel* originPriceLabel;

#pragma mark - Model
@property (nonatomic, strong)FNBaseProductModel* model;

#pragma mark - Other
@property (nonatomic, strong)NSIndexPath* indexPath;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end
