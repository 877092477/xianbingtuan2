//
//  FNteamPullNewController.h
//  嗨如意
//
//  Created by Fnuo-iOS on 2018/5/10.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import "FNteamPullNewHeaderView.h"
#import "FNteamPullNewCell.h"
#import "teamPullNewModel.h"

@interface FNteamPullNewController : SuperViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)FNteamPullNewHeaderView *header;

@property (nonatomic,strong)teamPullNewModel *model;

@end
