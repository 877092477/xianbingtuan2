//
//  JMHomeProductCell.h
//  THB
//
//  Created by jimmy on 2017/4/8.
//  Copyright © 2017年 方诺科技. All rights reserved.
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
#import "XYSuperTableViewCell.h"
#define JMHPCellImgHeight 110
@class FNBaseProductModel;
@interface JMHomeProductCell : UITableViewCell
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
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
