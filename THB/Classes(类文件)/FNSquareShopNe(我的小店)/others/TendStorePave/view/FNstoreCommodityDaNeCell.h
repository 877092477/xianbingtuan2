//
//  FNstoreCommodityDaNeCell.h
//  69橙子
//
//  Created by Jimmy on 2018/11/27.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNstorePaveItemModel.h"
@protocol FNstoreCommodityDaNeCellDelegate <NSObject>
// 添加数量
- (void)storeCommodityAttachAmountAction:(NSIndexPath*)indexPath;
// 减数量
- (void)storeCommodityDecrementAction:(NSIndexPath*)indexPath;

@end
@interface FNstoreCommodityDaNeCell : UICollectionViewCell

/** 商品图片 **/
@property (nonatomic, strong)UIImageView* goodsImage;

/** 商品名字 **/
@property (nonatomic, strong)UILabel* goodsName;

/** 商品简介 **/
@property (nonatomic, strong)UILabel* goodsIntro;

/** 经营日期 **/
@property (nonatomic, strong)UILabel* doBusinessDate;

/** 现在的价格 **/
@property (nonatomic, strong)UILabel* priceLB;

/** 原价 **/
@property (nonatomic, strong)UILabel* originalCost;

/** 购买数量 **/
@property (nonatomic, strong)UILabel* amountLB;

/** 减数量 **/
@property (nonatomic, strong)UIButton *minusBtn;

/** 加数量 **/
@property (nonatomic, strong)UIButton *addBtn; 

/** line **/
@property (nonatomic, strong)UILabel* lineLB;

@property (nonatomic, strong)NSDictionary *dicModel;

@property (nonatomic, strong)FNstorePaveItemModel *model;

@property (nonatomic, strong)NSIndexPath *indexPath;

@property(nonatomic ,weak) id<FNstoreCommodityDaNeCellDelegate> delegate;

@end


