//
//  FNMineWalletCell.h
//  THB
//
//  Created by Jimmy on 2018/1/16.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "JMTableViewCell.h"
@class MenuModel;
@interface FNMineWalletCell : JMTableViewCell
@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, strong)NSArray<MenuModel *>* datas;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@end
