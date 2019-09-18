//
//  FNitemMakeDeCell.h
//  THB
//
//  Created by Jimmy on 2018/12/19.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNitemMakeDeModel.h"

@protocol FNitemMakeDeCellDegate <NSObject>

// 补充单号
- (void)replenishCodeClick:(FNitemMakeDeModel*)model;

@end

@interface FNitemMakeDeCell : UICollectionViewCell
/** 白色背景 **/
@property (nonatomic, strong)UIView* bgView;
/** 标题 **/
@property (nonatomic, strong)UILabel* textLB;
/** 标题右边 **/
@property (nonatomic, strong)UILabel* rightTextLB;
/** 商品img **/
@property (nonatomic, strong)UIImageView* goodsImageView;
/** 名字 **/
@property (nonatomic, strong)UILabel* nameLB;
/** 现在金额 **/
@property (nonatomic, strong)UILabel* priceLB;
/** 补贴 **/
@property (nonatomic, strong)UILabel* subsidyLB;

/** 订单号 或 领取时间 **/
@property (nonatomic, strong)UILabel* orderCodeLB;

@property (nonatomic, strong)FNitemMakeDeModel* model;

@property(nonatomic ,weak) id<FNitemMakeDeCellDegate> delegate;
@end


