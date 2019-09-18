//
//  FNBrandShopCell.h
//  THB
//
//  Created by jimmy on 2017/5/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "XYSuperTableViewCell.h"
@class FNBrandShopModel;
@interface FNBrandShopCell : XYSuperTableViewCell
@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, strong)FNBrandShopModel* model;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
