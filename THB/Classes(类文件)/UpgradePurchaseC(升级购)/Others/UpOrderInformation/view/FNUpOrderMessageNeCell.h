//
//  FNUpOrderMessageNeCell.h
//  THB
//
//  Created by Jimmy on 2018/9/28.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNUpOrderinformationNModel.h"

@protocol FNUpOrderMessageNeCellDelegate <NSObject>

/** 选择支付方式 **/
-(void)selectPatternofpaymentAction:(NSIndexPath *)indexPath;

@end

@interface FNUpOrderMessageNeCell : UITableViewCell


/** 商品BGview **/
@property (nonatomic, strong)UIView *goodsBGview;

/** 商品图片 **/
@property (nonatomic, strong)UIImageView* GoodsImage;

/** 商品标题 **/
@property (nonatomic, strong)UILabel* GoodsTitleLabel;

/** 优品 **/
@property (nonatomic, strong)UILabel* optimizationLB;

/** 原价 **/
@property (nonatomic, strong)UILabel* originPriceLabel;

/** 数量 **/
@property (nonatomic, strong)UILabel* countLabel;

/** 其他 **/
@property (nonatomic, strong)UILabel* restsLabel;

/** 支付方式 **/
@property (nonatomic, strong)UILabel* mannerLeft;

/** 支付 **/
@property (nonatomic, strong)UILabel* mannerLB;

/** 方向 **/
@property (nonatomic, strong)UIImageView* directionImage;

/** line **/
@property (nonatomic, strong)UILabel* lineLB;

/** 提交时间 **/
@property (nonatomic, strong)UILabel* timeLeft;

/** 提交时间 **/
@property (nonatomic, strong)UILabel* timeLB;

/** 订单金额 **/
@property (nonatomic, strong)UILabel* sumLeft;

/** 订单金额 **/
@property (nonatomic, strong)UILabel* sumLB;

/** 配送方式 **/
@property (nonatomic, strong)UILabel* carriageLeft;

/** 配送方式 **/
@property (nonatomic, strong)UILabel* carriageLB;

/** other **/
@property (nonatomic, strong)NSIndexPath* indexPath;

/** model **/
@property (nonatomic, strong)FNUpOrderinformationNModel* model;

@property(nonatomic ,weak) id<FNUpOrderMessageNeCellDelegate> delegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


@end
