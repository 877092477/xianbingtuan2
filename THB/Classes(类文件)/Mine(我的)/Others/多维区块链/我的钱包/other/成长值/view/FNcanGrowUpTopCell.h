//
//  FNcanGrowUpTopCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNcanGrowUpGradeView.h"
#import "FNcandiesGrowModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNcanGrowUpTopCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView  *headImgView;
@property (nonatomic, strong)UIImageView  *headStateImgView;
@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)UILabel   *valueJoLB;
@property (nonatomic, strong)UILabel   *hintLB;
@property (nonatomic, strong)FNcandiesGrowModel   *model;
@property (nonatomic, strong)FNcanGrowUpGradeView *gradeView;
@end

NS_ASSUME_NONNULL_END
