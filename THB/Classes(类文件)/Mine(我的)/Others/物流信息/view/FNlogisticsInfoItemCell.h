//
//  FNlogisticsInfoItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNlogisticsInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNlogisticsInfoItemCell : UICollectionViewCell
@property (nonatomic, strong)UILabel     *titleLB;
@property (nonatomic, strong)UILabel     *dateLB;
@property (nonatomic, strong)UIImageView *stateImgView;
@property (nonatomic, strong)FNlogisticsInfoItemModel *model;

@end

NS_ASSUME_NONNULL_END
