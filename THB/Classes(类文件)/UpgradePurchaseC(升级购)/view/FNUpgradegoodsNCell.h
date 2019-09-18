//
//  FNUpgradegoodsNCell.h
//  THB
//
//  Created by Jimmy on 2018/9/25.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNUpgradeNMode.h"

@class FNUpgradegoodsNCell;
@protocol FNUpgradegoodsNCellDelegate <NSObject>

- (void)cellDidShareClick: (FNUpgradegoodsNCell*)cell;

@end

@interface FNUpgradegoodsNCell : UITableViewCell

@property(nonatomic, weak) id<FNUpgradegoodsNCellDelegate> delegate;

@property(nonatomic, strong)FNRecommendNMode* model;
/** 商品图片 **/
@property (nonatomic, strong)UIImageView* GoodsImage;

/** 商品标题 **/
@property (nonatomic, strong)UILabel* GoodsTitleLabel;

/** 原价 **/
@property (nonatomic, strong)UILabel* originPriceLabel;

/** 月销量 **/
@property (nonatomic, strong)UILabel* countLabel;

/** 新品或其他 **/
//@property (nonatomic, strong)UILabel* restsLabel;

/** 邮费 **/
@property (nonatomic, strong)UILabel* freightLabel;

/** 优惠之类 **/
@property (nonatomic, strong)UILabel* discountsLabel;

/** 优选 **/
@property (nonatomic, strong)UILabel* optimizationLB;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
