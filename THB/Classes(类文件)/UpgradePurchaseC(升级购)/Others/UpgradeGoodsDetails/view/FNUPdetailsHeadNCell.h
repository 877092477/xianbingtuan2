//
//  FNUPdetailsHeadNCell.h
//  THB
//
//  Created by Jimmy on 2018/9/26.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "FNUpDetailsNModel.h"
@interface FNUPdetailsHeadNCell : UITableViewCell<SDCycleScrollViewDelegate>

@property (nonatomic, copy)void (^upgradeClicked) (void);

@property (nonatomic, copy)void (^shareClicked) (void);

/** 幻灯片 **/
@property (nonatomic, strong)SDCycleScrollView* bannerView;

/** 商品标题 **/
@property (nonatomic, strong)UILabel* GoodsTitleLabel;

/** 原价 **/
@property (nonatomic, strong)UILabel* originPriceLabel;

/** 月销量 **/
@property (nonatomic, strong)UILabel* countLabel;

/** 优选 **/
@property (nonatomic, strong)UILabel* optimizationLB;

/** Line **/
@property (nonatomic, strong)UILabel* lineLB;

@property (nonatomic,strong)NSDictionary* dataDic;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
