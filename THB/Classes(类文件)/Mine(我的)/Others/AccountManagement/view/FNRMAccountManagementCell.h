//
//  FNRMAccountManagementCell.h
//  嗨如意
//
//  Created by Jimmy on 2018/1/16.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "JMTableViewCell.h"
@class FNRMAccountManagementModel;
@interface FNRMAccountManagementCell : JMTableViewCell
@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, strong)FNRMAccountManagementModel* model;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@end
