//
//  FNProfitStatisticsCell.h
//  SuperMode
//
//  Created by jimmy on 2017/10/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMTableViewCell.h"
#import "FNCmbDoubleTextButton.h"
extern const CGFloat _psc_cell_height;
@interface FNProfitStatisticsCell : JMTableViewCell
@property (nonatomic, strong)NSIndexPath* indexPath;

@property (nonatomic, strong)UILabel*   titleLabel;

@property (nonatomic, strong)FNCmbDoubleTextButton* leftBtn;
@property (nonatomic, strong)FNCmbDoubleTextButton* rightBtn;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@end
