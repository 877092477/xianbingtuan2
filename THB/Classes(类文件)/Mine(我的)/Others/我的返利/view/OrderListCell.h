//
//  OrderListCell.h
//  THB
//
//  Created by zhongxueyu on 16/4/6.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface OrderListCell : UITableViewCell

/** 来自哪个网站 */
@property (weak, nonatomic) IBOutlet UILabel *shopName;

/** 订单时间 */
@property (weak, nonatomic) IBOutlet UILabel *detailDate;

/** 产品图片 */
@property (weak, nonatomic) IBOutlet UIImageView *productImg;

/** 返利金额（F币) */
@property (weak, nonatomic) IBOutlet UILabel *rebates;

/** 返利状态 */
@property (weak, nonatomic) IBOutlet UIImageView *status;

/** 商品标题 */
@property (weak, nonatomic) IBOutlet UILabel *title;

/** 订单号码 */
@property (weak, nonatomic) IBOutlet UILabel *orderNum;

@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *followLabel;

@property (strong, nonatomic) UIButton *daozhangInfo;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImgView;

@property (strong, nonatomic) UIView *awardView;
@property (strong, nonatomic) UIImageView *tbdImgView;
@property (strong, nonatomic) UIImageView *doneImgView;
@property (strong, nonatomic) UIImageView *awardImgView;

@property (strong, nonatomic) UILabel *imgLabel;

@property (strong, nonatomic) OrderModel *Model;

/** 返 */
@property (strong, nonatomic) UILabel *returnLB;

@end
