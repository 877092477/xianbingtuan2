//
//  FNcardDayItemTeCell.h
//  THB
//
//  Created by 李显 on 2019/2/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNDetailCardZoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNcardDayItemTeCell : UICollectionViewCell
/** 标题  **/
@property (nonatomic, strong)UILabel* titleLB;
/** 金额  **/
@property (nonatomic, strong)UILabel* sumLB;

/** model  **/
@property (nonatomic, strong)FNDayCardZoModel* model;
 
@end

NS_ASSUME_NONNULL_END
