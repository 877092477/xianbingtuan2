//
//  FNgatherHeadNCell.h
//  THB
//
//  Created by 李显 on 2018/9/11.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNEarnigsNModel.h"

@interface FNgatherHeadNCell : UITableViewCell
/** ImageOne **/
@property (nonatomic, strong)UIImageView *symbolOneImage;
/** ImageTwo **/
@property (nonatomic, strong)UIImageView *symbolTwoImage;
/** 币Image **/
@property (nonatomic, strong)UIImageView *coinImage;
/** 付款笔数 **/
@property (nonatomic, strong)UILabel* paymentTitleLB;
/** 预估佣金 **/
@property (nonatomic, strong)UILabel* commissionTitleLB;
/** 分享赚(预估) **/
@property (nonatomic, strong)UILabel* shareTitleLB;
/** 付款笔数Number **/
@property (nonatomic, strong)UILabel* paymentNuLB;
/** 预估佣金Number **/
@property (nonatomic, strong)UILabel* commissionNuLB;
/** 分享赚(预估)number **/
@property (nonatomic, strong)UILabel* shareNuLB;
/** oneline **/
@property (nonatomic, strong)UILabel* oneline;
/** twoline **/
@property (nonatomic, strong)UILabel* twoline;


/** 本月预估 **/
@property (nonatomic, strong)UILabel* monthLB;
/** 结算收入 **/
@property (nonatomic, strong)UILabel* accountLB;
/** 上月预估 **/
@property (nonatomic, strong)UILabel* lastMonthLB;

/** 本月预估Image **/
@property (nonatomic, strong)UIImageView *monthImage;
/** 结算Image **/
@property (nonatomic, strong)UIImageView *accountImage;
/** 上月预估Image **/
@property (nonatomic, strong)UIImageView *lastMonthImage;

/** 本月佣金Image **/
@property (nonatomic, strong)UIImageView *brokeragemage;
/**  上月预估Image **/
@property (nonatomic, strong)UIImageView *lastbrokerageImage;


@property (nonatomic, strong)NSMutableArray* modelArr;


@property (nonatomic, strong)NSIndexPath* indexPath;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
