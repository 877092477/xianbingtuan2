//
//  FNneckBagChiefCeCell.h
//  THB
//
//  Created by Jimmy on 2019/2/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNopenRedPacketDeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNneckBagChiefCeCell : UICollectionViewCell
/** 背景图片 **/
@property (nonatomic, strong)UIImageView* bgImg;
/** 头像 **/
@property (nonatomic, strong)UIImageView* headImg;
/** 状态 **/
@property (nonatomic, strong)UIImageView* pinImg;
/** 名字  **/
@property (nonatomic, strong)UILabel* nameLB;
/** 备注  **/
@property (nonatomic, strong)UILabel* remarkLB;
/** 金额  **/
@property (nonatomic, strong)UILabel* sumLB;
/** 提示  **/
@property (nonatomic, strong)UILabel* hintLB;
/** 提示2  **/
@property (nonatomic, strong)UILabel* reminderLB;

/** 状态  **/
@property (nonatomic, assign)NSInteger neckState; 


/** line  **/
@property (nonatomic, strong)UIView* line;

/** model  **/
@property (nonatomic, strong)FNopenRedPacketDeModel* model;
@end

NS_ASSUME_NONNULL_END
