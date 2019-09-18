//
//  FNMCAOrderDetailCell.h
//  THB
//
//  Created by jimmy on 2017/7/27.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNSuperTableViewCell.h"
extern const CGFloat _aodc_cell_height;
@class FNMCAOrderDetailModel;
@interface FNMCAOrderDetailCell : FNSuperTableViewCell
@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, strong)FNMCAOrderDetailModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
