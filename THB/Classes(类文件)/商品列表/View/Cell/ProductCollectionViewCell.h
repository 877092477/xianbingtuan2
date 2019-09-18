//
//  ProductCollectionViewCell.h
//  THB
//
//  Created by zhongxueyu on 16/4/1.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有 2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import <UIKit/UIKit.h>
#import "CatZanButton.h"
#import "FNBaseProductModel.h"
@interface ProductCollectionViewCell : UICollectionViewCell

/** 商品图片 */
@property (strong, nonatomic)  UIImageView *imgView;

/** 来自哪个网站 */
@property (strong, nonatomic)  UIImageView *shopImgView;

/** 标题 */
@property (strong, nonatomic)  UILabel *goodsTitle;

/** 发货地 */
@property (strong, nonatomic)  UILabel *city;

/** 店铺名 */
@property (strong, nonatomic)  UILabel *shopName;

/** 价格 */
@property (strong, nonatomic)  UILabel *price;

/** 原价 */
@property (strong, nonatomic)  UILabel *oldPriceLabel;

/** 销量 */
@property (strong, nonatomic)  UILabel *sales;

/** 喜欢按钮 */
@property(nonatomic ,strong)CatZanButton *likeBtn;

@property (nonatomic, strong)UIView* couponview;
@property (nonatomic, strong)UIButton* couponBtn;
@property (nonatomic, strong)UIImageView* couponImg;

@property (nonatomic, strong)NSLayoutConstraint* couponViewH;
@property (nonatomic,strong) FNBaseProductModel *model;
@end
