//
//  FNpredictTimesCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNpredictDeliveryTimeModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNpredictTimesCellDelegate <NSObject>
// 选择时长
- (void)didpredictTimesItemAction:(NSIndexPath*)index;
@end
@interface FNpredictTimesCell : UICollectionViewCell
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UILabel   *titleDateLB;
@property (nonatomic, strong)UILabel   *hintLB;
@property (nonatomic, strong)UIButton  *rightBtn;
@property (nonatomic, strong)UIView  *lineView;
@property (nonatomic, strong)FNpredictDeliveryTimeModel *model;
@property (nonatomic, strong)NSIndexPath  *index;
@property (nonatomic, weak)id<FNpredictTimesCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
