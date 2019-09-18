//
//  FNclockInPayCell.h
//  THB
//
//  Created by Jimmy on 2019/2/27.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNclockInZoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNclockInPayCell : UICollectionViewCell
/** 图片 **/
@property (nonatomic, strong)UIImageView* payImg;
/** 状态图片 **/
@property (nonatomic, strong)UIImageView* stateImg;
/** 名字 **/
@property (nonatomic, strong)UILabel* nameLB;
/** line **/
@property (nonatomic, strong)UIView* lineView;

/** 份数  **/
@property (nonatomic, strong)FNclockInTypeItemModel *model;
@end

NS_ASSUME_NONNULL_END
