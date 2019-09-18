//
//  FNlogisticsHeadView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNlogisticsInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNlogisticsHeadView : UICollectionReusableView
@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)UILabel  *orderLB;
@property (nonatomic, strong)UILabel  *stateLB;
@property (nonatomic, strong)UIButton *cyBtn;
@property (nonatomic, strong)UIView   *lineView;

@property (nonatomic, strong)UIImageView *wlImgView;
@property (nonatomic, strong)UILabel  *wlNameLB;
@property (nonatomic, strong)FNlogisticsInfoModel   *model;
@end

NS_ASSUME_NONNULL_END
