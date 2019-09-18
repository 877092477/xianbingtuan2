//
//  FNstatiPlanItemDeCell.h
//  THB
//
//  Created by Jimmy on 2018/12/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNstatisticsDeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNstatiPlanItemDeCell : UICollectionViewCell
/** 上月预估收入 **/
@property (nonatomic, strong)UILabel* titleLB;
/** 金额 **/
@property (nonatomic, strong)UILabel* sumLB;
/** 状态 **/
@property (nonatomic, strong)UILabel* stateLB;

@property (nonatomic, strong)NSIndexPath *indexPath;
/** model **/
@property (nonatomic, strong)FNstatisticsCommissionModel* model;
@end

NS_ASSUME_NONNULL_END
