//
//  FNneckResultItemCeCell.h
//  THB
//
//  Created by Jimmy on 2019/2/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNopenRedPacketDeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNneckResultItemCeCell : UICollectionViewCell
/** 头像 **/
@property (nonatomic, strong)UIImageView* headImg;
/** 状态 **/
@property (nonatomic, strong)UIImageView* pinImg;
/** 名字  **/
@property (nonatomic, strong)UILabel* nameLB;
/** 金额  **/
@property (nonatomic, strong)UILabel* sumLB;
/** 时间  **/
@property (nonatomic, strong)UILabel* dateLB;
/** 备注  **/
@property (nonatomic, strong)UILabel* remarkLB; 
/** line  **/
@property (nonatomic, strong)UIView* lineView;
/** model  **/
@property (nonatomic, strong)FNopenRedPacketRecordModel* model;
@end

NS_ASSUME_NONNULL_END
