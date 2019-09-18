//
//  FNNewConnectionContactListController.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/13.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewConnectionContactListController.h"
#import "FNNewConnectionGroupCell.h"
#import "FNCustomeNavigationBar.h"
#import "FNNewConnectionModel.h"
#import "FNConnectionsChatController.h"

@interface FNNewConnectionContactListController()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UIImageView* backBtn;
@property (nonatomic, strong)UIButton* settingBtn;
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)NSMutableArray<FNNewConnectionDataFriendModel*> *friends;


@end

@implementation FNNewConnectionContactListController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
}

//- (FNCustomeNavigationBar *)navigationView{
//    if (_navigationView == nil) {
//        _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
//
////        _imageNav = [[UIImageView alloc] init];
////        [_navigationView addSubview:_imageNav];
////        [_imageNav mas_makeConstraints:^(MASConstraintMaker *make) {
////            make.edges.equalTo(@0);
////        }];
////        _imageNav.contentMode = UIViewContentModeScaleAspectFill;
////        _imageNav.layer.masksToBounds = YES;
//
//        UIButton* leftView = [UIButton new];
//        self.backBtn = [[UIImageView alloc] init];
//        self.backBtn.size = CGSizeMake(9, 15);
//        [leftView addSubview:self.backBtn];
//        leftView.frame = CGRectMake(0, 0, 20, 20);
//        [leftView addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
//
//        UIView* rightView = [UIView new];
//        self.settingBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        [self.settingBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
//        [self.settingBtn addTarget:self action:@selector(settingBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
//        self.settingBtn.size = CGSizeMake(20, 20);
//        [rightView addSubview:self.settingBtn];
//
////        self.msgBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
////        [self.msgBtn addTarget:self action:@selector(messageBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
////        self.msgBtn.size = CGSizeMake(20, 20);
////        [rightView addSubview:self.msgBtn];
//
////        rightView.frame = CGRectMake(0, 0, self.settingBtn.width+self.msgBtn.width+15, self.settingBtn.height);
//
////        [self.msgBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
////        [self.msgBtn autoSetDimensionsToSize:self.msgBtn.size];
////        [self.msgBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
//
//        [self.settingBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
//        [self.settingBtn autoSetDimensionsToSize:self.settingBtn.size];
//        [self.settingBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
//
//        _navigationView.rightButton = rightView;
//        _navigationView.leftButton = leftView;
//
//    }
//    return _navigationView;
//}


- (void)configUI {
    self.view.backgroundColor = RGB(250, 250, 250);
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.jm_tableview.emptyDataSetSource = nil;
    self.jm_tableview.emptyDataSetDelegate = nil;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.alpha = 1;
    self.jm_tableview.backgroundColor = [UIColor clearColor];
    self.jm_tableview.estimatedRowHeight = 200;
    self.jm_tableview.rowHeight = UITableViewAutomaticDimension;
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.jm_tableview];
    
    [self.jm_tableview registerClass:[FNNewConnectionGroupCell class] forCellReuseIdentifier:@"FNNewConnectionGroupCell"];
    
    [self.view addSubview:self.navigationView];
    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:self.navigationView.height];
    
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
//        make.top.equalTo(self.navigationView.mas_bottom);
        make.top.equalTo(@0);
        make.bottom.equalTo(@-64);
    }];
    
    
    self.friends = [[NSMutableArray alloc] init];
    self.jm_page = 1;
    [self requestContacts];
}

- (void)requestContacts{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"type": _type, @"p": @(self.jm_page)}];
    [SVProgressHUD show];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection02&ctrl=lt_list" respondType:(ResponseTypeArray) modelType:@"FNNewConnectionDataFriendModel" success:^(id respondsObject) {
        
        @strongify(self)
//        self.friends = respondsObject;
        NSArray *array = respondsObject;
        
        if (self.jm_page == 1) {
            [self.friends removeAllObjects];
        }
        [self.friends addObjectsFromArray:array];
        self.jm_page ++;
        
        if (array.count > 0) {
//            self.jm_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//                [self requestContacts];
//            }];
            self.jm_tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestContacts)];
        } else {
            self.jm_tableview.mj_footer = nil;
        }
        
        [self.jm_tableview.mj_footer endRefreshing];
        [self.jm_tableview reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        [XYNetworkAPI cancelAllRequest];
        [SVProgressHUD dismiss];
        [self.jm_collectionview.mj_footer endRefreshing];
    } isHideTips:YES];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.friends.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    FNNewConnectionGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNNewConnectionGroupCell"];
    FNNewConnectionDataFriendModel *friend = self.friends[indexPath.row];
    
    [cell.imgHeader sd_setImageWithURL:URL(friend.head_img)];;
    cell.lblTitle.text = friend.name;
    cell.lblDesc.text = friend.msg_str;
    cell.lblTime.text = friend.time;
    [cell setCount: friend.unread];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FNNewConnectionDataFriendModel *friend = self.friends[indexPath.row];

    FNConnectionsChatController *vc = [[FNConnectionsChatController alloc] init];
    vc.uid = friend.sendee_uid;
    vc.room = friend.room;
    vc.target = friend.target;
    vc.nickname = friend.name;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

@end
