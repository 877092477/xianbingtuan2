//
//  FNwrapPayItemAeCell.h
//  THB
//
//  Created by Jimmy on 2019/2/13.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNRedPackageNaModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNwrapPayItemAeCell : UICollectionViewCell
/** 图片 **/
@property (nonatomic, strong)UIImageView* payImg;
/** 状态图片 **/
@property (nonatomic, strong)UIImageView* stateImg;
/** 名字 **/
@property (nonatomic, strong)UILabel* nameLB;
/** 备注 **/
@property (nonatomic, strong)UILabel* remarkLB;
/** model **/
@property (nonatomic, strong)FNpackagePayNaModel* model;
@end

NS_ASSUME_NONNULL_END
