//
//  FNcandiesCountCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNCandiesMyModel.h"
#import "ZCCCircleProgressView.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNcandiesCountCell : UICollectionViewCell
@property (nonatomic, strong)UIButton  *bottomBtn;
@property (nonatomic, strong)UIButton  *imgTextBtn;
@property (nonatomic, strong)FNCandiesMyModel  *model;
@property (nonatomic, strong)ZCCCircleProgressView  *circleProgress;
@property (nonatomic, strong)ZCCCircleProgressView  *lineProgress;

@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UILabel   *produceLB;
@property (nonatomic, strong)UILabel   *residueLB;

@property (nonatomic, strong)UILabel   *produceBiliLB;
@property (nonatomic, strong)UILabel   *residueBiliLB;
@end

NS_ASSUME_NONNULL_END
