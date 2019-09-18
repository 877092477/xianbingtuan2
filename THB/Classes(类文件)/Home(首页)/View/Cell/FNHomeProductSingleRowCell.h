//
//  FNHomeProductSingleRowCell.h
//  THB
//
//  Created by 李显 on 2018/8/24.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FNBaseProductModel;
@interface FNHomeProductSingleRowCell : UICollectionViewCell

#pragma mark - Views
/** 商品图片 **/
@property (nonatomic, strong)UIImageView* GoodsImage;

/** 商品类型:淘宝,京东... **/
@property (nonatomic, strong)UIImageView* GoodsTypeImage;

/** 商品标题 **/
@property (nonatomic, strong)UILabel* GoodsTitleLabel;

/** 优惠Bg **/
@property (nonatomic, strong)UIView* discountsBgView;

/** 优惠券logo **/
@property (nonatomic, strong)UIImageView* ticketImg;

/** 样式3优惠Bg **/
@property (nonatomic, strong)UIImageView* discountsBg2;

/** 券 **/
@property (nonatomic, strong)UIImageView* discountsView;

/** 券 面值 **/
@property (nonatomic, strong)UILabel* ticketPriceLable;

/** 下单 **/
@property (nonatomic, strong)UIButton* placeAnorderButton;
/** 下单 **/
@property (nonatomic, strong)UIImageView* placeAnorderView;

/** 下单标题 **/
@property (nonatomic, strong)UILabel* placeAnOrderLable;

/** 原价 **/
@property (nonatomic, strong)UILabel* originPriceLabel;

/** 返利金额 **/
@property (nonatomic, strong)UILabel* returnMoneyLabel;

/** 券后价 **/
@property (nonatomic, strong)UILabel* qhPriceLabel;

/** 券后价标题 **/
@property (nonatomic, strong)UILabel* qhPriceTitleLabel;

/** 地区 **/
@property (nonatomic, strong)UILabel* cityLabel;


/** 销量 **/
@property (nonatomic, strong)UIImageView* countIconImg;

/** 月销量 **/
@property (nonatomic, strong)UILabel* countLabel;

/** 店铺图标 **/
@property (nonatomic, strong)UIImageView* shopIconImg;

/** 店铺名 **/
@property (nonatomic, strong)UILabel* shopNameLabel;

/** 店铺图标 **/
@property (nonatomic, strong)UIImageView* shareIconImg;

/** 分享 **/
@property (nonatomic, strong)UIButton* shareBtn;


#pragma mark - Model
@property (nonatomic, strong)FNBaseProductModel* model;

@property (nonatomic, strong)NSIndexPath* indexPath;

@property (nonatomic, copy)void (^sharerightNow)(FNBaseProductModel * model);

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end
