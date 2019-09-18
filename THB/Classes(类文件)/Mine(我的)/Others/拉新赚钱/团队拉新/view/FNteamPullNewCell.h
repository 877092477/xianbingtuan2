//
//  FNteamPullNewCell.h
//  嗨如意
//
//  Created by Fnuo-iOS on 2018/5/10.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "teamPullNewListModel.h"

@interface FNteamPullNewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)teamPullNewListModel *model;

@property (nonatomic,weak)UIButton *NumBtn;

@property (nonatomic,weak)UIImageView *Headportrait;

@property (nonatomic,weak)UILabel *Name;

@property (nonatomic,weak)UILabel *popNum;

@end
