//
//  FNcanGrowUpDetailItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNcandiesGrowModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNcanGrowUpDetailItemCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView  *imgView;
@property (nonatomic, strong)UIView   *lineView;
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UILabel   *valueJoLB;
@property (nonatomic, strong)UILabel   *dateLB;
@property (nonatomic, strong)FNcandiesGrowGardeDetailModel   *model;
@end

NS_ASSUME_NONNULL_END
