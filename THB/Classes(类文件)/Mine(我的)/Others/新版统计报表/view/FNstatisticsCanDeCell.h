//
//  FNstatisticsCanDeCell.h
//  THB
//
//  Created by Jimmy on 2018/12/27.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNstatisticsDeModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNstatisticsCanDeCellDegate <NSObject>
// 立即提现
- (void)inStatisticsCanwithdraw; 
@end
@interface FNstatisticsCanDeCell : UICollectionViewCell
/** 背景img **/
@property (nonatomic, strong)UIImageView* bgImage;
/** 可提现文字 **/
@property (nonatomic, strong)UILabel* titleLB;
/** 可提现金额 **/
@property (nonatomic, strong)UILabel* sumLB;
/** 收入明细 **/
@property (nonatomic, strong)UIButton* detailBtn;
/** 提现 **/
@property (nonatomic, strong)UIButton* carryBtn;
/** model **/
@property (nonatomic, strong)FNstatisticsTXModel* model;
/** delegate **/
@property(nonatomic ,weak) id<FNstatisticsCanDeCellDegate> delegate;
@end

NS_ASSUME_NONNULL_END
