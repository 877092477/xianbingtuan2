//
//  JMMemberUpgradePayCell.h
//  THB
//
//  Created by jimmy on 2017/4/1.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMMemberUpgradePayCell : UITableViewCell
@property (nonatomic, strong)UIImageView* imgView;
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, strong)UIImageView* seletedImgView;

@property (nonatomic, strong)NSIndexPath* indexPath;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
