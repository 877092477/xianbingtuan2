//
//  FNPromotionalListTCell.h
//  THB
//
//  Created by Jimmy on 2017/12/22.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMTableViewCell.h"
extern const CGFloat _plt_cell_height;
@interface FNPromotionalListTCell : JMTableViewCell
@property (nonatomic, copy)NSString* status;
@property (nonatomic, strong)FNBaseProductModel* model;
@property (nonatomic, strong)NSIndexPath* indexPath;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@end
