//
//  FNhistoryItemDeCell.h
//  THB
//
//  Created by Jimmy on 2018/12/21.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNhistoryItemModel.h"

@interface FNhistoryItemDeCell : UICollectionViewCell
/** 时间 **/
@property (nonatomic, strong)UILabel* timeLB;
/** 白色背景 **/
@property (nonatomic, strong)UIView* bgView;
/** 标题 **/
@property (nonatomic, strong)UILabel* textLB;
/** line **/
@property (nonatomic, strong)UIView* line;
/** 内容 **/
@property (nonatomic, strong)UILabel* contentLB;
/** 内容 **/
@property (nonatomic, strong)FNhistoryItemModel* model;

@end


