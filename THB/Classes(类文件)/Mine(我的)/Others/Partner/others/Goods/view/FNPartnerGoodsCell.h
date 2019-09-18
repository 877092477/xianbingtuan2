//
//  FNPartnerGoodsCell.h
//  SuperMode
//
//  Created by jimmy on 2017/10/19.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMPProductTVCell.h"
#import "FNPartnerGoodsModel.h"
extern const CGFloat _pgc_cell_height;
@interface FNPartnerGoodsCell : JMPProductTVCell

@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, strong)FNPartnerGoodsModel* model;
@property (nonatomic, copy)void (^sharerightNow)(FNBaseProductModel * model);
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@property(nonatomic,assign)BOOL OnlyChangeStyle;

//选中
@property (nonatomic, weak)UIButton* chooseBtn;




@end
