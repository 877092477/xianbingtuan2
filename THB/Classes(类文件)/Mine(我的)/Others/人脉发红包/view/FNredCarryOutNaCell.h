//
//  FNredCarryOutNaCell.h
//  THB
//
//  Created by Jimmy on 2019/2/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNRedPackageNaModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNredCarryOutNaCell : UICollectionViewCell
/** 名字标题 **/
@property (nonatomic, strong)UILabel* sumLB;
/** 单位 **/
@property (nonatomic, strong)UILabel* remarkLB;
/** carryOut **/
@property (nonatomic, strong)UIButton* carryOutBtn;
/** model **/
@property (nonatomic, strong)FNRedPackageNaModel* model;
@end

NS_ASSUME_NONNULL_END
