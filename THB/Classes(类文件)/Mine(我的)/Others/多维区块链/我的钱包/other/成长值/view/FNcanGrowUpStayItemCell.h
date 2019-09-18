//
//  FNcanGrowUpStayItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNcandiesGrowModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNcanGrowUpStayItemCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView  *bgImgView;
@property (nonatomic, strong)UIImageView  *stateImgView;
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UILabel   *valueJoLB;
@property (nonatomic, strong)FNcandiesGrowModel   *model;
@end

NS_ASSUME_NONNULL_END
