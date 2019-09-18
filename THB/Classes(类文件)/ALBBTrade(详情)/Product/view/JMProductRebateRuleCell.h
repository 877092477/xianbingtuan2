//
//  JMProductRebateRuleCell.h
//  THB
//
//  Created by jimmy on 2017/4/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMProductRebateRuleCell : UITableViewCell
@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, strong) UIImageView* questionIcon;
@property (nonatomic, strong) UILabel* questionLabel;
@property (nonatomic, strong) UILabel* answerLabel;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
