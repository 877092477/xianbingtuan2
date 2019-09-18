//
//  FNPromotionalTeamCell.h
//  SuperMode
//
//  Created by jimmy on 2017/10/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMTableViewCell.h"
extern const CGFloat _ptc_cell_height ;

@class PTMfan;
@interface FNPromotionalTeamCell : JMTableViewCell
@property (nonatomic, strong)UIImageView* avatarImgview;
@property (nonatomic, strong)UILabel* nameLabel;
@property (nonatomic, strong)UILabel* dateLabel;
@property (nonatomic, strong)UILabel* valueLabel;
@property (nonatomic, strong)UILabel* peopleNumLabel;
@property (nonatomic, weak)UIImageView *starImg;

@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, strong)PTMfan* model;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
