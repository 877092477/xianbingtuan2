//
//  FNTrplayCWItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/24.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNtradeHomeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNTrplayCWItemCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *headImgView;
@property (nonatomic, strong)UIImageView   *playImgView;
@property (nonatomic, strong)UIImageView   *dateImgView;
@property (nonatomic, strong)UIImageView   *hotImgView;
@property (nonatomic, strong)UIImageView   *shoImgView;
@property (nonatomic, strong)UIImageView   *stateImgView;
@property (nonatomic, strong)UILabel   *shoLB;
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UILabel   *dateLB;
@property (nonatomic, strong)UILabel   *countLB;
@property (nonatomic, strong)FNtradeHomeRecommendItemModel  *model;
@end

NS_ASSUME_NONNULL_END
