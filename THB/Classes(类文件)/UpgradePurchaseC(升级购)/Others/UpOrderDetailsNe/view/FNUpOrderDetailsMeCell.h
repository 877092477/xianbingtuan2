//
//  FNUpOrderDetailsMeCell.h
//  THB
//
//  Created by Jimmy on 2018/9/30.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "FNUpOrderdetailitemNewModel.h"
#import "FNUpOrderdetailitemNeHModel.h"
@interface FNUpOrderDetailsMeCell : UITableViewCell

@property (nonatomic,strong)UILabel *OrdertitleLB;
@property (nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *goodsImageView;
@property (nonatomic,strong)UILabel *nameLB;
@property (nonatomic,strong)UILabel *statusLabel;
@property (nonatomic,strong)UILabel *restsLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *amountLabel;
@property (nonatomic,strong)UILabel *totalpricesLeft;
@property (nonatomic,strong)UILabel *totalpricesRight;
@property (nonatomic,strong)UILabel *freightLeft;
@property (nonatomic,strong)UILabel *freightRight;
@property (nonatomic,strong)UILabel *saleLeft;
@property (nonatomic,strong)UILabel *saleRight;
@property (nonatomic,strong)UILabel *actualLeft;
@property (nonatomic,strong)UILabel *actualRight;
@property (nonatomic,strong)UILabel *stateRight;
@property (nonatomic,strong)FNUpOrderdetailitemNeHModel *model;
@end
