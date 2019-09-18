//
//  FNEarningsDayNCell.h
//  THB
//
//  Created by 李显 on 2018/9/10.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNEarnigsNModel.h"

@interface FNEarningsDayNCell : UITableViewCell

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



@property (nonatomic, strong)NSIndexPath* indexPath;

@property (nonatomic, strong)NSMutableArray* modelArr;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
