//
//  FNdefineCommodityCell.h
//  THB
//
//  Created by Jimmy on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNDefiniteStoreNeModel.h"
NS_ASSUME_NONNULL_BEGIN

@class FNdefineCommodityCell;
@protocol FNdefineCommodityCellDelegate <NSObject>

- (void)onShareClick: (FNdefineCommodityCell*)cell;

@end

@interface FNdefineCommodityCell : UICollectionViewCell

@property (nonatomic, weak) id<FNdefineCommodityCellDelegate> delegate;

/** 商品img **/
@property (nonatomic, strong)UIImageView* goodsImageView;
/** 名字 **/
@property (nonatomic, strong)UILabel* nameLB;
/** 品质保障 **/
@property (nonatomic, strong)UILabel* tallyLB;
/** 积分加价格 **/
@property (nonatomic, strong)UILabel* priceLB;
/** 原价 **/
@property (nonatomic, strong)UILabel* rawLB;
/** 多少人 **/
@property (nonatomic, strong)UILabel* amountLB;
/** 我要兑换 **/
@property (nonatomic, strong)UIButton* grabBtn;
/** line **/
//@property (nonatomic, strong)UIView* line;
/** model **/
@property (nonatomic, strong)FNDefiniteProductModel* model;
@end

NS_ASSUME_NONNULL_END
