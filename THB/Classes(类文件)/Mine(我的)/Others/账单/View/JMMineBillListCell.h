//
//  JMMineBillListCell.h
//  THB
//
//  Created by jimmy on 2017/3/30.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMMineBillModel;
@interface JMMineBillListCell : UITableViewCell
@property (nonatomic, strong)JMMineBillModel* model;
@property (nonatomic, strong)NSIndexPath* indexPath;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
