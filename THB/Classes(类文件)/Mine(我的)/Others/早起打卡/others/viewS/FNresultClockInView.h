//
//  FNresultClockInView.h
//  THB
//
//  Created by Jimmy on 2019/2/27.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNclockInZoModel.h"
NS_ASSUME_NONNULL_BEGIN
 
@interface FNresultClockInView : UIView
/** bgView **/
@property (nonatomic, strong)UIView* bgView;

/** whiteView **/
@property (nonatomic, strong)UIView* whiteView;
/** 标题  **/
@property (nonatomic, strong)UILabel* titleLB;
/** 其他信息  **/
@property (nonatomic, strong)UILabel* restLB;

/** 累计打卡  **/
@property (nonatomic, strong)UILabel* grandLB;

/** leftLine  **/
@property (nonatomic, strong)UIView* leftLine;
/** rightLine  **/
@property (nonatomic, strong)UIView* rightLine;
/** 取消 **/
@property (nonatomic, strong)UIButton* cancelBtn;
/** 继续挑战 **/
@property (nonatomic, strong)UIButton* continueBtn;

/** 状态img **/
@property (nonatomic, strong)UIImageView* stateImg;

/** model **/
@property (nonatomic, strong)FNclockDKDoingModel *model;

- (void)dismissAlert;

@end

NS_ASSUME_NONNULL_END
