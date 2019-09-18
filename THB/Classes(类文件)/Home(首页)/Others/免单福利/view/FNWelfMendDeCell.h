//
//  FNWelfMendDeCell.h
//  THB
//
//  Created by Jimmy on 2018/12/18.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNwelfDeModel.h"

@interface FNWelfMendDeCell : UICollectionViewCell
/** 白色背景 **/
@property (nonatomic, strong)UIView* bgView;
/** 标题 **/
@property (nonatomic, strong)UILabel* textLB;
/** lineView **/
@property (nonatomic, strong)UIView* lineView;
/** 商品img **/
@property (nonatomic, strong)UIImageView* goodsImageView;
/** 名字 **/
@property (nonatomic, strong)UILabel* nameLB;
/** 平台补贴图片 **/
@property (nonatomic, strong)UIImageView* mendImage;
/** 平台补贴 **/
@property (nonatomic, strong)UILabel* mendLB;
/** 平台补贴金额 **/
@property (nonatomic, strong)UILabel* mendPriceLB;

/** 现在金额 **/
@property (nonatomic, strong)UILabel* priceLB;
/** 原价 **/
@property (nonatomic, strong)UILabel* rawLB;

@property (nonatomic, strong)FNwelfDeListItemModel *model;

/** baseLine **/
@property (nonatomic, strong)UIView* lineBase;


/** 已售数量 **/
@property (nonatomic, strong)UILabel* rightSellLB;
//进度
@property (nonatomic, strong)UILabel* planLB;
/** 销售百分比 **/
@property (nonatomic, strong)UILabel* leftSellLB;
/** 销售条 **/
@property (nonatomic, strong)UIImageView* sellImageView;


@end


