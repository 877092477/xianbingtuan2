//
//  FNPSBalanceCell.h
//  SuperMode
//
//  Created by jimmy on 2017/10/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMTableViewCell.h"

@class FNCmbDoubleTextButton;
@interface FNPSBalanceCell : JMTableViewCell
@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, strong)UILabel*   titleLabel;
@property (nonatomic, strong)UIButton* withdrawBtn;

@property (nonatomic, strong)FNCmbDoubleTextButton* leftBtn;
@property (nonatomic, strong)FNCmbDoubleTextButton* rightBtn;

@property (nonatomic, copy)void (^withdrawBlock)(void);
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
