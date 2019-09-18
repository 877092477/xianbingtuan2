//
//  JMCellTool.h
//  THB
//
//  Created by Jimmy on 2017/12/28.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMCellTool : NSObject
+ (UITableViewCell *)tableView:(UITableView *)tableview atIndexPath:(NSIndexPath *)indexPath superVC:(SuperViewController*)vc andModel:(id)model;
+ (CGFloat)cellHeightTableview:(UITableView *)tableview atIndexPath:(NSIndexPath*)indexPath andModel:(id)model;
@end
