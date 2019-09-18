//
//  FNDoubleLabelCell.h
//  SuperMode
//
//  Created by jimmy on 2017/6/10.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNDoubleLabelCell : UITableViewCell
@property (nonatomic, strong)UILabel* leftlabel;
@property (nonatomic, strong) UILabel*  rightLabel;
@property (nonatomic, assign) CGFloat leftwidth;
@property (nonatomic, strong)NSIndexPath* indexPath;
/**
 left margin
 */
@property (nonatomic, strong)NSLayoutConstraint* leftCons;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
