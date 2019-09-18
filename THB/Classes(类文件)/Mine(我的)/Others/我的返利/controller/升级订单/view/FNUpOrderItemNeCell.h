//
//  FNUpOrderItemNeCell.h
//  THB
//
//  Created by Jimmy on 2018/9/29.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "FNUpgradeOrderitemNModel.h"
#import "FNUpgradeOrderitemNeHModel.h"
@protocol FNUpOrderItemNeCellDelegate <NSObject>
// 复制订单信息
- (void)InUpOrderCopyInfoAction:(NSIndexPath *)indexPath;

@end

@interface FNUpOrderItemNeCell : UITableViewCell
/** 商品BGview **/
@property (nonatomic, strong)UIView *goodsBGview;

/** 商品图片 **/
@property (nonatomic, strong)UIImageView* GoodsImage;

/** 商品标题 **/
@property (nonatomic, strong)UILabel* GoodsTitleLabel;

/** 优品 **/
@property (nonatomic, strong)UILabel* optimizationLB;

/** 其他 **/
@property (nonatomic, strong)UILabel* restsLabel;

/** line **/
@property (nonatomic, strong)UILabel* lineLB;

/** 升级订单 **/
@property (nonatomic, strong)UILabel* OrderTitleLeft;

/** 提交时间 **/
@property (nonatomic, strong)UILabel* timeLB;

/** 物流单号**/
@property (nonatomic, strong)UILabel* logisticsLeft;

@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *amountLabel;


/** 复制按钮 **/
@property (nonatomic, strong)UIButton* copybtn;

/** 状态 **/
@property (nonatomic, strong)UILabel* stateright;

/** 状态 **/
@property (nonatomic, strong)UILabel* stateLeft;

/** other **/
@property (nonatomic, strong)NSIndexPath* indexPath;

/** model **/
@property (nonatomic, strong)FNUpgradeOrderitemNeHModel* model;

/** other **/
@property(nonatomic ,weak) id<FNUpOrderItemNeCellDelegate> delegate;

@end
