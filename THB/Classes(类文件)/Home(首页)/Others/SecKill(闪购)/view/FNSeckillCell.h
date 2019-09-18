//
//  FNSeckillCell.h
//  THB
//
//  Created by jimmy on 2017/5/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "XYSuperTableViewCell.h"
@class FNHSecKillProudctModel;
extern const CGFloat _seckill_img_h ;
@interface FNSeckillCell : XYSuperTableViewCell
@property (nonatomic, strong)FNHSecKillProudctModel* model;
@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, copy)void (^rodClicked)(FNHSecKillProudctModel *model);
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
