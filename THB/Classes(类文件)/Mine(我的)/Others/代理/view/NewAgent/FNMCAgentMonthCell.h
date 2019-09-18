//
//  FNMCAgentMonthCell.h
//  THB
//
//  Created by jimmy on 2017/7/27.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNSuperTableViewCell.h"
extern const CGFloat _amc_cell_h;
@interface FNMCAgentMonthCell : FNSuperTableViewCell
@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, strong)void (^widthdrawAction)(void);
@property (nonatomic, copy)NSString* thisMonth;
@property (nonatomic, copy)NSString* lastMonth;
@property (nonatomic, copy)NSString* balance;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
