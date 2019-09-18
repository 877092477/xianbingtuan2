//
//  FNPullNewDetailController.h
//  THB
//
//  Created by Fnuo-iOS on 2018/5/10.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import "FDSlideBar.h"
#import "FNPullNewDetailCell.h"
#import "PullNewDetailTopModel.h"
#import "PullNewDetailListModel.h"

@interface FNPullNewDetailController : SuperViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray<PullNewDetailTopModel *>* topModel;

@property(nonatomic,strong)NSArray<PullNewDetailListModel *>* listModel;

@property(nonatomic,weak)UIView *mainView;

@property (nonatomic, strong)FDSlideBar *slideBar;

@end
