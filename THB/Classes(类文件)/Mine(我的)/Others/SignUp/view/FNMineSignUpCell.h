//
//  FNMineSignUpCell.h
//  THB
//
//  Created by Jimmy on 2018/1/17.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "JMTableViewCell.h"
@class FNMineSignUpRecordModel;
@interface FNMineSignUpCell : JMTableViewCell
@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, strong)FNMineSignUpRecordModel* model;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@end
