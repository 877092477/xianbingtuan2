//
//  FNMineOrderCell.h
//  THB
//
//  Created by Jimmy on 2018/1/16.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "JMTableViewCell.h"
@class MenuModel;
@interface FNMineOrderCell : JMTableViewCell
@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, strong)NSArray<MenuModel *>* datas;
@property (nonatomic, copy)void (^btnClicked)(NSInteger index,id model,NSIndexPath* ind);
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;


@end
