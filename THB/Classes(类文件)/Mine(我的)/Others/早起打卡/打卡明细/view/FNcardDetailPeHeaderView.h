//
//  FNcardDetailPeHeaderView.h
//  THB
//
//  Created by 李显 on 2019/2/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNcardheDayTeView.h"
#import "FNDetailCardZoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNcardDetailPeHeaderView : UICollectionReusableView
/** 背景img **/
@property (nonatomic, strong)UIImageView* bgImg;
/** header **/
@property (nonatomic, strong)UIImageView* headerImg;
/** 标题  **/
@property (nonatomic, strong)UILabel* titleLB;
/** 金额  **/
@property (nonatomic, strong)UILabel* sumLB;
/**    **/
@property (nonatomic, strong)FNcardheDayTeView *dayTeView;

/** 挑战明细  **/
@property (nonatomic, strong)UILabel* hintLB;
/** 左边  **/
@property (nonatomic, strong)UIView* leftLine;
/** 右边  **/
@property (nonatomic, strong)UIView* rightLine;
/** 右边  **/
@property (nonatomic, strong)UIView* baseLine;

/** 右边  **/
@property (nonatomic, strong)FNDetailCardZoModel* model;
@end

NS_ASSUME_NONNULL_END
