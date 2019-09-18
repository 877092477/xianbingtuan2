//
//  FNpunchCardAeCell.h
//  THB
//
//  Created by Jimmy on 2019/2/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStepItemAeView.h"
#import "FNCardItemAeView.h"
#import "FNpunchHomeAeModel.h"
#import "ZQCountdownTime.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNpunchCardAeCell : UICollectionViewCell
/** 箭头步骤1img **/
@property (nonatomic, strong)UIImageView* boultOneImg;
/** 箭头步骤2img **/
@property (nonatomic, strong)UIImageView* boultTwoImg;
/** 背景img **/
@property (nonatomic, strong)UIImageView* bgImg;
/** 标题  **/
@property (nonatomic, strong)UILabel* titleLB;
/** 金额  **/
@property (nonatomic, strong)UILabel* sumLB;
/** ...  **/
@property (nonatomic, strong)UILabel* omitLB;
/** 报名人数  **/
@property (nonatomic, strong)UILabel* amountLB;
/** 挑战明细  **/
@property (nonatomic, strong)UIButton *detailBtn;
/** 活动规则  **/
@property (nonatomic, strong)UIButton *ruleBtn;
/** 立即参与  **/
@property (nonatomic, strong)UIButton *participationBtn;

/** 演示背景img **/
@property (nonatomic, strong)UIImageView* demonstrationBgImg;
/** 演示img **/
@property (nonatomic, strong)UIImageView* demonstrationimg;
/** 按钮旁的硬币图标 **/
@property (nonatomic, strong)UIButton* moneyicoBtn;
/** 早起打卡三步骤  **/
@property (nonatomic, strong)UILabel* stepLB;
/** 1步骤  **/
@property (nonatomic, strong)UILabel* stepOneLB;
/** 2步骤  **/
@property (nonatomic, strong)UILabel* stepTwoLB;
/** 3步骤  **/
@property (nonatomic, strong)UILabel* stepThreeLB;

@property (nonatomic, strong)FNStepItemAeView *itemOneView;
@property (nonatomic, strong)FNStepItemAeView *itemTwoView;
@property (nonatomic, strong)FNStepItemAeView *itemThreeView;


@property (nonatomic, strong)UIView *baseWhiteView;

/** 今日状况  **/
@property (nonatomic, strong)UIButton *todayBtn;
/** 邀请  **/
@property (nonatomic, strong)UIButton *inviteBtn;
/** 邀请  **/
@property (nonatomic, strong)FNCardItemAeView *bestView;
/** 邀请  **/
@property (nonatomic, strong)FNCardItemAeView *firstView;
/** 邀请  **/
@property (nonatomic, strong)FNCardItemAeView *longestView;
/** model  **/
@property (nonatomic, strong)FNpunchHomeAeModel *model;

@property (nonatomic, strong)NSMutableArray* btns;

@end

NS_ASSUME_NONNULL_END
