//
//  FNPromotePublicCell.h
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMTableViewCell.h"
 extern const CGFloat _ppc_cell_height;

@class PPMorder;
@interface FNPromotePublicCell : JMTableViewCell
@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, strong)PPMorder* model;
/**
 *  is mine
 */
@property (nonatomic, assign)BOOL isMine;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
