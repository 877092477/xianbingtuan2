//
//  FNclockInPayHeaderView.h
//  THB
//
//  Created by Jimmy on 2019/2/27.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNclockInZoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNclockInPayHeaderView : UICollectionReusableView
/** 标题  **/
@property (nonatomic, strong)UILabel* titleLB;
/** 时间  **/
@property (nonatomic, strong)UILabel* hintLB;
/** model  **/
@property (nonatomic, strong)FNclockInZoModel* model;
@end

NS_ASSUME_NONNULL_END
