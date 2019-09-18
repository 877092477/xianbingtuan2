//
//  FNreckDetailsItemSeCell.h
//  THB
//
//  Created by Jimmy on 2018/12/26.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNreckDetailsSeModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol FNreckDetailsItemSeCellDegate <NSObject>
// 复制
- (void)inDuplicateOrderIDClick:(NSIndexPath*)index;

@end
@interface FNreckDetailsItemSeCell : UICollectionViewCell
/** 标题 **/
@property (nonatomic, strong)UILabel* titleLB;
/** 内容 **/
@property (nonatomic, strong)UILabel* contentLB;
/** 订单号复制 **/
@property (nonatomic, strong)UIButton* orderDuplicateBtn; 
/** model **/
@property (nonatomic, strong)FNreckDetailsItemModel* model;
/** delegate **/
@property(nonatomic ,weak) id<FNreckDetailsItemSeCellDegate> delegate;
/** indexPath **/
@property (nonatomic, strong)NSIndexPath* indexPath;
@end

NS_ASSUME_NONNULL_END
