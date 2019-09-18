//
//  JMShopRebateCell.h
//  THB
//
//  Created by jimmy on 2017/4/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "XYSuperTableViewCell.h"
@class ShopListModel;
@interface JMShopRebateCell : XYSuperTableViewCell
@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, strong)ShopListModel* model;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
