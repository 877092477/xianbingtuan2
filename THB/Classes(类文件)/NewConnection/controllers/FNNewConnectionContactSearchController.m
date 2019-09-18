//
//  FNNewConnectionContactSearchController.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/13.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewConnectionContactSearchController.h"
#import "FNNewConnectionGroupCell.h"
#import "FNNewConnectionModel.h"
#import "FNConnectionsChatController.h"

@interface FNNewConnectionContactSearchController()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UITextField *txfSearch;

@property (nonatomic, strong)NSMutableArray<FNNewConnectionDataFriendModel*> *friends;

@end

@implementation FNNewConnectionContactSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    
}


- (void)configNav{
    UIView *leftView = [[UIView alloc] init];
    leftView.frame = CGRectMake(0, 0, 25, 25);
    
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.searchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.searchBtn.frame=CGRectMake(0, 0, 54, 32);
    //    [self.searchBtn setBackgroundImage:IMAGE(@"live_coupone_button_search") forState:(UIControlStateNormal)];
    [self.searchBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [self.searchBtn setTitleColor: RGB(102, 102, 102) forState:(UIControlStateNormal)];
    self.searchBtn.titleLabel.font = kFONT14;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBtn];
    
    _txfSearch = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, XYScreenWidth - 100, 30)];
    _txfSearch.backgroundColor = RGB(248, 248, 248);
    _txfSearch.cornerRadius = 15;
    
    UIImageView *imgSearch = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    imgSearch.image = IMAGE(@"live_coupone_nav_button_search");
    imgSearch.contentMode = UIViewContentModeCenter;
    _txfSearch.leftView = imgSearch;
    _txfSearch.leftViewMode = UITextFieldViewModeAlways;
    _txfSearch.font = kFONT14;
    _txfSearch.returnKeyType = UIReturnKeySearch;
    _txfSearch.placeholder = @"请输入你的群名";
    _txfSearch.delegate = self;
    //    _txfSearch.placeholder = @"商家";
    
    self.navigationItem.titleView = _txfSearch;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    
}

- (void) searchBtnAction {
    [self.navigationController popViewControllerAnimated: YES];
}


- (void)requestContacts{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"type": @"qun", @"p": @(self.jm_page)}];
    if ([_txfSearch.text kr_isNotEmpty]) {
        params[@"keyword"] = _txfSearch.text;
    }
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
        
        [self.jm_tableview reloadData];
        
        [self.jm_tableview.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        [XYNetworkAPI cancelAllRequest];
        [SVProgressHUD dismiss];
        [self.jm_collectionview.mj_footer endRefreshing];
    } isHideTips:YES];
    
}


- (void)configUI {
    
    [self configNav];
    
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
    
//    [self.view addSubview:self.navigationView];
//    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
//    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:self.navigationView.height];
    
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        //        make.top.equalTo(self.navigationView.mas_bottom);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    
    self.friends = [[NSMutableArray alloc] init];
    self.jm_page = 1;
    [self requestContacts];
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

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.jm_page = 1;
    [self requestContacts];
    return YES;
}

@end
