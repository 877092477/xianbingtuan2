//
//  FNmeActivitToolItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmeActivitToolModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmeActivitToolItemCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *bgImgView;
@property (nonatomic, strong)UIImageView   *imgView;
@property (nonatomic, strong)UIImageView   *rightImgView;
@property (nonatomic, strong)UIImageView   *redImgView;
@property (nonatomic, strong)UIImageView   *blueImgView;

@property (nonatomic, strong)UILabel       *nameLB;
@property (nonatomic, strong)UILabel       *hintLB;
@property (nonatomic, strong)UILabel       *marchLB;
@property (nonatomic, strong)UILabel       *notBegunLB;
@property (nonatomic, strong)UIView        *lineView;

@property (nonatomic, strong)FNmeActivitToolModel *model;
@end

NS_ASSUME_NONNULL_END
