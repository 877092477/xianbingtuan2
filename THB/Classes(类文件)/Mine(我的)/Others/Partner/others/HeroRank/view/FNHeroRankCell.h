//
//  FNHeroRankCell.h
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMTableViewCell.h"
extern const CGFloat _hrc_cell_height;

@class FNHeroRankModel;
@interface FNHeroRankCell : JMTableViewCell
@property (nonatomic, strong)UIView* leftview;
@property (nonatomic, strong)UIImageView* rankimgview;
@property (nonatomic, strong)UILabel* rankLabel;



@property (nonatomic, strong)UIImageView* avatarImgview;

@property (nonatomic, strong)UILabel* nameLabel;

@property (nonatomic, strong)UILabel* moneyLabel;

@property (nonatomic, strong)NSIndexPath* indexPath;

@property (nonatomic, strong)FNHeroRankModel* model;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
