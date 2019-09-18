//
//  FNConnectionsGroupsController.m
//  THB
//
//  Created by Weller Zhao on 2019/2/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsGroupsController.h"
#import "FNConnectionsChatController.h"
#import "FNCustomeNavigationBar.h"
#import "FNConnectionsHomeHeaderView.h"
#import "FNConnectionsHomeCell.h"
#import "FNConnectionsHomeHeaderCell.h"
#import "FNConnectionsSearchView.h"

#import "FNConnectionsHomeModel.h"
#import "FNConnectionsMemberModel.h"
#import "FNIndexSelectorView.h"
#import "FNConnectionsGroupModel.h"
#import "FNConnectionsChatController.h"

@interface FNConnectionsGroupsController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;

@property (nonatomic, strong)UIButton* backBtn;
@property (nonatomic, strong)UIButton* titleBtn;
@property (nonatomic, strong)UIImageView *imgHeader;

@property (nonatomic, strong) NSMutableArray<FNConnectionsGroupModel*> *groups;

@end

@implementation FNConnectionsGroupsController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.groups = [[NSMutableArray alloc] init];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
}


- (FNCustomeNavigationBar *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
        
        _navigationView.backgroundColor = RED;
        
        UIView* leftView = [UIView new];
        self.backBtn = [[UIButton alloc] init];
        [self.backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.backBtn.size = CGSizeMake(6, 12);
        [self.backBtn setImage:IMAGE(@"connection_button_back") forState:UIControlStateNormal];
        [leftView addSubview:self.backBtn];
        
        self.titleBtn = [[UIButton alloc] init];
        [self.titleBtn addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self.titleBtn setTitle:@"群列表" forState:UIControlStateNormal];
        self.titleBtn.size = CGSizeMake(XYScreenWidth - 120, 20);
        self.titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [leftView addSubview:self.titleBtn];
        leftView.frame = CGRectMake(0, 0, self.backBtn.width+self.titleBtn.width+15, 20);
        
        [self.backBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.backBtn autoSetDimensionsToSize:self.backBtn.size];
        [self.backBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        
        [self.titleBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.titleBtn autoSetDimensionsToSize:self.titleBtn.size];
        [self.titleBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        
        _navigationView.leftButton = leftView;
        
    }
    return _navigationView;
}

- (void)jm_setupViews{
    
    self.view.backgroundColor = FNHomeBackgroundColor;
    
    @weakify(self)
    [self.view addSubview:self.navigationView];
    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:self.navigationView.height];
    
    self.view.backgroundColor = FNHomeBackgroundColor;
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.jm_tableview.emptyDataSetSource = nil;
    self.jm_tableview.emptyDataSetDelegate = nil;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.alpha = 1;
    self.jm_tableview.backgroundColor = [UIColor clearColor];
    self.jm_tableview.estimatedRowHeight = 200;
    self.jm_tableview.rowHeight = UITableViewAutomaticDimension;
    self.jm_tableview.showsVerticalScrollIndicator = NO;
//    self.jm_tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.jm_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        self.jm_page = 1;
        [self loadMoreData];
    }];
    
    
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self_weak_.navigationView.mas_bottom);
        make.bottom.equalTo(@0);
    }];
    
    [self.jm_tableview registerClass:[FNConnectionsHomeHeaderCell class] forHeaderFooterViewReuseIdentifier:@"FNConnectionsHomeHeaderCell"];
    [self.jm_tableview registerClass:[FNConnectionsHomeCell class] forCellReuseIdentifier:@"FNConnectionsHomeCell"];
    //    [self.jm_tableview registerClass:[FNMineIconsCell class] forCellReuseIdentifier:@"FNMineIconsCell"];
    //    [self.jm_tableview registerClass:[FNMineImageCell class] forCellReuseIdentifier:@"FNMineImageCell"];
    
    
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    [self configHeader];
    
    [self.jm_tableview.mj_header beginRefreshing];
}

- (void)configHeader {
    _imgHeader = [[UIImageView alloc] init];
    [self.view insertSubview:_imgHeader atIndex:0];
    @weakify(self)
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.right.equalTo(@0);
        //        make.bottom.equalTo(self_weak_.headerView.mas_top).offset(HeaderOffset);
        make.bottom.equalTo(self_weak_.navigationView);
    }];
    _imgHeader.contentMode = UIViewContentModeScaleAspectFill;
    _imgHeader.layer.masksToBounds = YES;
}

#pragma mark - request

- (FNRequestTool*) requestGroups {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"p": @(self.jm_page)}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection_index&ctrl=group" respondType:(ResponseTypeArray) modelType:@"FNConnectionsGroupModel" success:^(id respondsObject) {
        @strongify(self);
        
        NSArray *array = respondsObject;
        if (self.jm_page == 1) {
            [self.groups removeAllObjects];
        }
        
        if (array.count > 0) {
            self.jm_page ++;
            self.jm_tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        } else {
            self.jm_tableview.mj_footer = nil;
        }
        
        [self.groups addObjectsFromArray:respondsObject];
        [self.jm_tableview.mj_footer endRefreshing];
        [self.jm_tableview.mj_header endRefreshing];
        [self.jm_tableview reloadData];
        
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache:NO];
}

#pragma mark - action

- (void)loadMoreData {
    [self requestGroups];
}

- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    return [[UITableViewCell alloc] init];
    FNConnectionsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNConnectionsHomeCell"];
    
    FNConnectionsGroupModel *model = self.groups[indexPath.row];
    [cell.imgHeader sd_setImageWithURL:URL(model.head_img)];
    cell.lblTitle.text = model.nickname;
    cell.lblDesc.text = @"";
    cell.lblPhone.text = @"";
    cell.lblType.text = @"";
    [cell setIsShowCheck:NO];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FNConnectionsGroupModel *model = self.groups[indexPath.row];
    FNConnectionsChatController *vc = [[FNConnectionsChatController alloc] init];
    vc.uid = model.qid;
    vc.room = model.room;
    vc.target = model.target;
    vc.nickname = model.nickname;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
