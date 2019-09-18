//
//  FNHomeProductCell.h
//  嗨如意
//
//  Created by zhongxueyu on 2018/8/16.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FNBaseProductModel;
@interface FNHomeProductCell : UICollectionViewCell

#pragma mark - Views

/** 上分割线 **/
@property (nonatomic, strong)UILabel* line_Top;

/** 右分割线 **/
@property (nonatomic, strong)UILabel* line_Right;

/** 商品图片 **/
@property (nonatomic, strong)UIImageView* GoodsImage;

/** 分享 **/
@property (nonatomic, strong)UIButton* shareButton;

/** 商品类型:淘宝,京东... **/
@property (nonatomic, strong)UIImageView* GoodsTypeImage;

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

#pragma mark - Model
@property (nonatomic, strong)FNBaseProductModel* model;

#pragma mark - Other
@property (nonatomic, strong)NSIndexPath* indexPath;


@property (nonatomic, copy)void (^sharerightNow)(FNBaseProductModel * model);

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

- (void)setIsLeft: (BOOL)isLeft;

@end
