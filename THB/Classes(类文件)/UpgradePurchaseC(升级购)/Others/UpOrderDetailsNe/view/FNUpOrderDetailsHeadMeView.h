//
//  FNUpOrderDetailsHeadMeView.h
//  THB
//
//  Created by Jimmy on 2018/9/30.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "FNUpOrderdetailitemNewModel.h"
#import "FNUpOrderdetailitemNeHModel.h"

@protocol FNUpOrderDetailsHeadMeViewDelegate <NSObject>
// 复制
- (void)HeadMeViewDuplicateOdd;

@end
@interface FNUpOrderDetailsHeadMeView : UITableViewHeaderFooterView

/** bgImageView **/
@property(nonatomic,strong)UIImageView *bgImageView;
/** 物流名字 **/
@property(nonatomic,strong)UILabel *logisticsLB;
/** 物流单号 **/
@property(nonatomic,strong)UILabel *logisticsNumberLB;
/** 复制 **/
@property(nonatomic,strong)UIButton *duplicateButton;
/** 状态图片 **/
@property(nonatomic,strong)UIImageView *stateImageView;
/** model **/
@property (nonatomic,strong)FNUpOrderdetailitemNeHModel *model;

@property(nonatomic ,weak) id<FNUpOrderDetailsHeadMeViewDelegate> delegate;

@end
