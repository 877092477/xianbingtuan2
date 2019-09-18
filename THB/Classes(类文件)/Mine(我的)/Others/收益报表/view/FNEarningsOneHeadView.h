//
//  FNEarningsOneHeadView.h
//  THB
//
//  Created by 李显 on 2018/9/11.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNEarnigsNModel.h"
@interface FNEarningsOneHeadView : UITableViewHeaderFooterView

/** BgImageView **/
@property (nonatomic, strong)UIImageView *  BgImageView;
/** headerTitle **/
@property (nonatomic, strong)UILabel *headTitle;
/** 金额1 **/
@property (nonatomic, strong)UILabel *amountOneLB;
/** 账户余额 **/
@property (nonatomic, strong)UILabel *balanceLB;
/** 累计收益 **/
@property (nonatomic, strong)UILabel *grandLB;
/** 金额2 **/
@property (nonatomic, strong)UILabel *amountTwoLB;
/** 立即提现 **/
@property (nonatomic, strong)UIButton *extractBtn;
/** 1Image **/
@property (nonatomic, strong)UIImageView *  ImageOneView;
/** 2Image **/
@property (nonatomic, strong)UIImageView *  ImagetwoView;

@property (nonatomic, strong)FNEarnigsNModel* model;

@property (nonatomic, strong)UIImageView *  depositiImg;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end

