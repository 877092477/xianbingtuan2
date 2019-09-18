//
//  FNreckSetDeCell.h
//  THB
//
//  Created by Jimmy on 2018/12/25.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNreckSetDeModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FNreckSetDeCellDegate <NSObject>
// 复制
- (void)inOrderDupAction:(NSIndexPath*)index;

@end
@interface FNreckSetDeCell : UICollectionViewCell

@property (nonatomic, strong)UIView* bgView;
/** 标题 **/
@property (nonatomic, strong)UILabel* titleLB;
/** 时间 **/
@property (nonatomic, strong)UILabel* timeLB;
/** 商品名字 **/
@property (nonatomic, strong)UILabel* nameLB;
/** 金额 **/
@property (nonatomic, strong)UILabel* priceLB;
/** 类型 **/
@property (nonatomic, strong)UIButton* typeBtn;
/** 订单号 **/
@property (nonatomic, strong)UILabel* orderLB;
/** 订单号复制 **/
@property (nonatomic, strong)UIButton* orderDuplicateBtn; 
/** model **/
@property (nonatomic, strong)FNreckSetItemModel* model;
/** delegate **/
@property(nonatomic ,weak) id<FNreckSetDeCellDegate> delegate;
/** indexPath **/
@property (nonatomic, strong)NSIndexPath* indexPath;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
