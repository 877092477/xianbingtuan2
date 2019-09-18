//
//  FNMCAgentDayCell.h
//  THB
//
//  Created by jimmy on 2017/7/27.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNSuperTableViewCell.h"

extern const CGFloat _adc_cell_height;
@interface FNMCAgentDayCell : FNSuperTableViewCell
@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, copy)NSString* today;
@property (nonatomic, copy)NSString* yesterday;
@property (nonatomic, copy)NSString* money;
@property (nonatomic, weak)UIButton* todaybtn;
@property (nonatomic, weak)UIButton* yesterdaybtn;
@property (nonatomic, copy)void (^changeDateBlock)(BOOL flag);
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
