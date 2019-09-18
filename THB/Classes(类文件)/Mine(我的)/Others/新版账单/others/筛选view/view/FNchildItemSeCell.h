//
//  FNchildItemSeCell.h
//  THB
//
//  Created by Jimmy on 2018/12/26.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNreckSetDeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNchildItemSeCell : UICollectionViewCell
/** 标题 **/
@property (nonatomic, strong)UILabel* titleLB;
/** model **/
@property (nonatomic, strong)FNreckScreenItemModel* model;
@end

NS_ASSUME_NONNULL_END
