//
//  FNADViewCell.h
//  THB
//
//  Created by zhongxueyu on 2018/8/20.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNComponentBaseCell.h"
#import "FNAdView.h"
#import "Index_threemodel_01Model.h"
#import "MenuModel.h"

@interface FNADViewCell : FNComponentBaseCell

@property (nonatomic, strong)FNAdView* adView;

//首页第三模块广告位(index_threemodel_01)
@property (nonatomic, strong)NSArray *index_threemodel_01List;

@property (nonatomic, copy)void (^QuickClickedBlock)(MenuModel* model);


@end
