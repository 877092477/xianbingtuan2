//
//  FNcandiesGradeItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNcandiesGrowModel.h"
#import "UIView+AZGradient.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNcandiesGradeItemCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView  *dotLeftImgView;
@property (nonatomic, strong)UIImageView  *dotRightImgView;
@property (nonatomic, strong)UIImageView  *gradeLeftImgView;
@property (nonatomic, strong)UIImageView  *gradeRightImgView;
@property (nonatomic, strong)UIView   *planView;
@property (nonatomic, strong)UILabel *gradeLeftLB;
@property (nonatomic, strong)UILabel *gradeRightLB;
@property (nonatomic, strong)FNcandiesGrowGardeItemModel *model;
@end

NS_ASSUME_NONNULL_END
