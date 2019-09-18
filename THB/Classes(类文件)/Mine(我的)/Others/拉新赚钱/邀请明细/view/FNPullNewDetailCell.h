//
//  FNPullNewDetailCell.h
//  THB
//
//  Created by Fnuo-iOS on 2018/5/10.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullNewDetailListModel.h"
#import "FNPullNewDetailMidView.h"

@interface FNPullNewDetailCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)PullNewDetailListModel* model;

@property(nonatomic,strong)FNPullNewDetailMidView* midView;

@property(nonatomic,weak)UIImageView* firstPurchase;

@property(nonatomic,weak)UIButton* phoneBtn;

@property(nonatomic,weak)UILabel* union_id;

@property(nonatomic,weak)UILabel* member_id;

@end
