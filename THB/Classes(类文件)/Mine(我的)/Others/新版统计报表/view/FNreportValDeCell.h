//
//  FNreportValDeCell.h
//  THB
//
//  Created by Jimmy on 2018/12/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNstatisticsDeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNreportValDeCell : UICollectionViewCell
/** 上月预估收入(笔) **/
@property (nonatomic, strong)UILabel* titleLB;
/** 金额 **/
@property (nonatomic, strong)UILabel* sumLB;

/** 预估 **/
@property (nonatomic, strong)UILabel* estimateLB;
/** 预估金额 **/
@property (nonatomic, strong)UILabel* estimateSumLB;

/** 颜色view **/
@property (nonatomic, strong)UIView* colorView;

@property (nonatomic, strong)NSIndexPath *indexPath;

/** model **/
@property (nonatomic, strong)FNstatisticsReportItemModel* model;

@end

NS_ASSUME_NONNULL_END
