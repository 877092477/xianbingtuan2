//
//  FNWelfareFlowDeCell.h
//  THB
//
//  Created by Jimmy on 2018/12/18.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNFunctionView.h"
#import "FNwelfDeModel.h"

@interface FNWelfareFlowDeCell : UICollectionViewCell

/** 白色背景 **/
@property (nonatomic, strong)UIView* bgView;
/** 名单流程 **/
@property (nonatomic, strong)UILabel* mendLB;
//圆形按钮模块
@property (nonatomic, strong)FNFunctionView* functionview;
/** 底部img **/
@property (nonatomic, strong)UIImageView* baseImageView;
/** 底部LB **/
@property (nonatomic, strong)UILabel* baseLB;
//listArr
@property (nonatomic, strong)NSArray *listArr;

@property (nonatomic, strong)FNwelfDeModel *model;

/** 虚线 **/
@property (nonatomic, strong)UILabel* leftline;
@property (nonatomic, strong)UILabel* centreline;
@property (nonatomic, strong)UILabel* rightline;

@end


