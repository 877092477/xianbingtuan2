//
//  FNdefinMsgDeCell.h
//  THB
//
//  Created by Jimmy on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNDefiniteStoreNeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNdefinMsgDeCell : UICollectionViewCell
/** 我的余额 及 我的积分 **/
@property (nonatomic, strong)UILabel  *leftLB;
/** 积分明细 **/
@property (nonatomic, strong)UIButton *rightBtn;
/** modelArr **/
@property (nonatomic, strong)NSArray  *modelArr;
@end

NS_ASSUME_NONNULL_END
