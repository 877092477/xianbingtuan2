//
//  FNPSDateCell.h
//  SuperMode
//
//  Created by jimmy on 2017/10/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMTableViewCell.h"
extern const CGFloat _psdc_cell_height;
@class FNCmbDoubleTextButton,PStoday_yes;
@interface FNPSDateCell : JMTableViewCell
@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, strong)NSArray<PStoday_yes *> *datas;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
