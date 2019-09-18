//
//  FNclockInTeCell.h
//  THB
//
//  Created by Jimmy on 2019/2/27.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNclockInZoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNclockInTeCell : UICollectionViewCell
/** 背景img **/
@property (nonatomic, strong)UIImageView* bgImg;
/** 标题  **/
@property (nonatomic, strong)UILabel* titleLB;
/** 份数  **/
@property (nonatomic, strong)UILabel* countLB;
/** 份数  **/
@property (nonatomic, strong)FNclockInpayItemModel *model;

/** 份数  **/
@property (nonatomic, strong)CAGradientLayer *orGl;

@end

NS_ASSUME_NONNULL_END
