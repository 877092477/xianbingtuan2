//
//  FNNewConnectionSecondHomeController.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/13.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewConnectionSecondHomeController.h"
#import "FNCustomeNavigationBar.h"

#import "FNNewConnectionDetailCell.h"
#import "FNNewConnectionDataCell.h"
#import "FNNewConnectionButtonsCell.h"
#import "FNNewConnectionSearchHeaderView.h"
#import "FNNewConnectionFriendCell.h"
#import "FNNewConnectionModel.h"
#import "FNNewConnectionMemModel.h"
#import "FNNewConnenctionCateAlertView.h"
#import "FNArrangesingleAeController.h"
#import "FNConnectionsMessageController.h"
#import "FNConnectionsChatController.h"
#import "FNNewConnectionEmptyView.h"
#import "FNNewConnectionContactController.h"
#import "FNNewConnectionSecondModel.h"

@interface FNNewConnectionSecondHomeController ()<UITableViewDataSource,UITableViewDelegate, FNNewConnectionSearchHeaderViewDelegate, FNNewConnectionButtonsCellDelegate, FNNewConnectionFriendCellDelegate>
//@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIImageView *imageNav;
@property (nonatomic, strong)UIButton* settingBtn;
@property (nonatomic, strong)UIButton* msgBtn;
@property (nonatomic, strong)UIImageView* backBtn;

@property (nonatomic, strong) FNNewConnectionSecondModel *model;
@property (nonatomic, strong) NSArray<FNNewConnectionCate2Model*> *cates;
@property (nonatomic, strong) NSMutableArray<FNNewConnectionMemModel*> *mems;

@property (nonatomic, strong) UIView *vHeader;
@property (nonatomic, strong) FNNewConnectionSearchHeaderView *searchView;
@property (nonatomic, strong) UIImageView *headerView;

@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *screen_type;

//@property (nonatomic, copy) NSString *keyword;

@property (nonatomic, copy) NSString *cateType;//记录分类二级选中项

@end

@implementation FNNewConnectionSecondHomeController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:animated];
}

- (void)jm_setupViews{
    
    _mems = [[NSMutableArray alloc] init];
    
    _headerView = [[UIImageView alloc] init];
    [self.view addSubview: _headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
//        make.top.equalTo(@0);
        make.height.mas_equalTo(0);
    }];
    
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
    
    [self.jm_tableview registerClass:[FNNewConnectionDetailCell class] forCellReuseIdentifier:@"FNNewConnectionDetailCell"];
    [self.jm_tableview registerClass:[FNNewConnectionDataCell class] forCellReuseIdentifier:@"FNNewConnectionDataCell"];
    [self.jm_tableview registerClass:[FNNewConnectionButtonsCell class] forCellReuseIdentifier:@"FNNewConnectionButtonsCell"];
    [self.jm_tableview registerClass:[FNNewConnectionSearchHeaderView class] forHeaderFooterViewReuseIdentifier:@"FNNewConnectionSearchHeaderView"];
    [self.jm_tableview registerClass:[FNNewConnectionFriendCell class] forCellReuseIdentifier:@"FNNewConnectionFriendCell"];
    
//    [self.view addSubview:self.navigationView];
//    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
//    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:self.navigationView.height];
    
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@0);
    }];
    
    
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _searchView = [self.jm_tableview dequeueReusableHeaderFooterViewWithIdentifier:@"FNNewConnectionSearchHeaderView"];
    
    [self requestMain];
    self.jm_page = 1;
    [self requestContact];
}

- (void)settingBtnAction {
    FNConnectionsMessageController *msgVC = [FNConnectionsMessageController new];
    [self.navigationController pushViewController:msgVC animated:YES];
}

- (void)messageBtnAction {
    
    //人脉排行榜
    FNArrangesingleAeController *vc = [FNArrangesingleAeController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)backBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0)
        return self.model.list.count;
    else if (section == 1) {
        if (self.mems.count == 0) {
            return 1;
        }
        return self.mems.count;
    } else
        return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 170;
        
    } else {
        
        if (self.mems.count == 0) {
            return 340;
        } else {
            return 170;
        }
    }
    return 0;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            FNNewConnectionFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNNewConnectionFriendCell"];
            FNNewConnectionMemModel *mem = self.model.list[indexPath.row];
            [cell setPadding:10];
            cell.lblTitle.text = mem.team_str;
            [cell.btnChat setTitle:mem.font forState:UIControlStateNormal];
            [cell.btnChat sd_setImageWithURL:URL(mem.lt_ico) forState:(UIControlStateNormal) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [cell.btnChat layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyleLeft) imageTitleSpace:4];
            }];
            cell.lblOrder.text = mem.ordercount_str;
            cell.lblTeam.text = mem.teamcount_str;
            [cell.imgLevel sd_setImageWithURL:URL(mem.vip_logo)];
            cell.lblLevel.text = mem.Vname;
            cell.lblLevel.textColor = [UIColor colorWithHexString:mem.Vname_color];
            
            [cell.imgHeader sd_setImageWithURL:URL(mem.head_img)];
            cell.lblName.text = mem.nickname;
            cell.lblPhone.text = mem.phone_str;
            cell.lblTime.text = mem.reg_str;
            [cell.imgBackground sd_setImageWithURL:URL(mem.bj_img)];
            if (mem.commission_arr.count > 0) {
                cell.lblTitle1.text = mem.commission_arr[0].name;
                cell.lblValue1.text = mem.commission_arr[0].val;
            }
            if (mem.commission_arr.count > 1) {
                cell.lblTitle2.text = mem.commission_arr[1].name;
                cell.lblValue2.text = mem.commission_arr[1].val;
            }
            if (mem.commission_arr.count > 2) {
                cell.lblTitle3.text = mem.commission_arr[2].name;
                cell.lblValue3.text = mem.commission_arr[2].val;
            }
            if (mem.commission_arr.count > 3) {
                cell.lblTitle4.text = mem.commission_arr[3].name;
                cell.lblValue4.text = mem.commission_arr[3].val;
            }
            cell.delegate = self;
            
            return cell;
        }
    } else {
        
        if (self.mems.count == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            FNNewConnectionEmptyView *view = [[FNNewConnectionEmptyView alloc] init];
            [cell.contentView addSubview: view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(@0);
                make.height.mas_equalTo(340);
            }];
            cell.backgroundColor = UIColor.clearColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            view.lblTitle.text = @"暂时木有此好友呀~";
            return cell;
        } else {
            FNNewConnectionFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNNewConnectionFriendCell"];
            FNNewConnectionMemModel *mem = self.mems[indexPath.row];
            [cell setPadding:10];
            cell.lblTitle.text = mem.team_str;
            [cell.btnChat setTitle:mem.font forState:UIControlStateNormal];
            [cell.btnChat sd_setImageWithURL:URL(mem.lt_ico) forState:(UIControlStateNormal) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [cell.btnChat layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyleLeft) imageTitleSpace:4];
            }];
            cell.lblOrder.text = mem.ordercount_str;
            cell.lblTeam.text = mem.teamcount_str;
            [cell.imgLevel sd_setImageWithURL:URL(mem.vip_logo)];
            cell.lblLevel.text = mem.Vname;
            cell.lblLevel.textColor = [UIColor colorWithHexString:mem.Vname_color];
            
            [cell.imgHeader sd_setImageWithURL:URL(mem.head_img)];
            cell.lblName.text = mem.nickname;
            cell.lblPhone.text = mem.phone_str;
            cell.lblTime.text = mem.reg_str;
            [cell.imgBackground sd_setImageWithURL:URL(mem.bj_img)];
            if (mem.commission_arr.count > 0) {
                cell.lblTitle1.text = mem.commission_arr[0].name;
                cell.lblValue1.text = mem.commission_arr[0].val;
            }
            if (mem.commission_arr.count > 1) {
                cell.lblTitle2.text = mem.commission_arr[1].name;
                cell.lblValue2.text = mem.commission_arr[1].val;
            }
            if (mem.commission_arr.count > 2) {
                cell.lblTitle3.text = mem.commission_arr[2].name;
                cell.lblValue3.text = mem.commission_arr[2].val;
            }
            if (mem.commission_arr.count > 3) {
                cell.lblTitle4.text = mem.commission_arr[3].name;
                cell.lblValue4.text = mem.commission_arr[3].val;
            }
            cell.delegate = self;
            return cell;
        }
    }
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 114;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [[UIView alloc] init];
    }
    FNNewConnectionSearchHeaderView *header = _searchView;

//    if (self.model.search_data.count > 0) {
//        FNNewConnectionCateListModel *item = self.model.search_data[0];
//        [header.btnSearch sd_setBackgroundImageWithURL:URL(item.btn_img) forState:UIControlStateNormal];
//        UIImageView *imgSearch = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
//        [imgSearch sd_setImageWithURL:URL(item.search_img)];
//        imgSearch.contentMode = UIViewContentModeScaleAspectFit;
//        header.txfSearch.leftView = imgSearch;
//        header.txfSearch.leftViewMode = UITextFieldViewModeAlways;
//        header.txfSearch.placeholder = item.search_str;
//        [header configCate:item.sort];
//        header.delegate = self;
//    }
    return header;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FNNewConnectionMemModel *mem = self.model.list[indexPath.row];
        if ([mem.is_jump isEqualToString:@"0"]) {
            [FNTipsView showTips:mem.tip_str];
        } else {
            FNNewConnectionSecondHomeController *vc = [[FNNewConnectionSecondHomeController alloc] init];
            vc.next_uid = mem.next_uid;
            vc.tg_lv = self.tg_lv + 1;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else if (indexPath.section == 1 && self.mems.count > 0) {
        
        FNNewConnectionMemModel *mem = self.mems[indexPath.row];
        if ([mem.is_jump isEqualToString:@"0"]) {
            [FNTipsView showTips:mem.tip_str];
        } else {
            FNNewConnectionSecondHomeController *vc = [[FNNewConnectionSecondHomeController alloc] init];
            vc.next_uid = mem.next_uid;
            vc.tg_lv = self.tg_lv + 1;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - Networking

- (FNRequestTool*) requestMain{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    if ([_next_uid kr_isNotEmpty]) {
        params[@"next_uid"] = _next_uid;
    }
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection02&ctrl=team_next_index" respondType:(ResponseTypeModel) modelType:@"FNNewConnectionSecondModel" success:^(id respondsObject) {
        @strongify(self);
        
        self.model = respondsObject;
        
//        [self.headerView sd_setImageWithURL: URL(self.model.bj_img) completed]
        [self.headerView sd_setImageWithURL:[NSURL URLWithString:self.model.bj_img] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                [_headerView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(XYScreenWidth * image.size.height / image.size.width);
                }];
            }
        }];
        
        if (self.model.search_data.count > 0) {
            FNNewConnectionCateListModel *item = self.model.search_data[0];
            [_searchView.btnSearch sd_setBackgroundImageWithURL:URL(item.btn_img) forState:UIControlStateNormal];
            UIImageView *imgSearch = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
            [imgSearch sd_setImageWithURL:URL(item.search_img)];
            imgSearch.contentMode = UIViewContentModeScaleAspectFit;
            _searchView.txfSearch.leftView = imgSearch;
            _searchView.txfSearch.leftViewMode = UITextFieldViewModeAlways;
            _searchView.txfSearch.placeholder = item.search_str;
            _searchView.lblTips.text = item.tip_str;
            [_searchView configCate:item.sort];
            _searchView.delegate = self;
        }
        
        [self.jm_tableview reloadData];
        
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}

- (FNRequestTool*) requestCate: (NSString*) type{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"type": type}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection02&ctrl=second_cate" respondType:(ResponseTypeArray) modelType:@"FNNewConnectionCate2Model" success:^(id respondsObject) {
        @strongify(self);
        self.cates = respondsObject;
        
        NSMutableArray *titles = [[NSMutableArray alloc] init];
        [[FNNewConnenctionCateAlertView sharedInstance] setSelectedIndex: -1];
        for (NSInteger index = 0; index < self.cates.count; index++) {
            FNNewConnectionCate2Model* cate = self.cates[index];
            [titles addObject: cate.name];
            if ([cate.type isEqualToString:self.cateType]) {
                [[FNNewConnenctionCateAlertView sharedInstance] setSelectedIndex: index];
            }
        }
        
        @weakify(self);
        [[FNNewConnenctionCateAlertView sharedInstance] showBelow: _vHeader titles: titles block: ^(NSInteger index){
            @strongify(self);
            //            self.cate2 = self.cates[index];
            
            if ([self.cates[index].list_cate isEqualToString:@"down"]) {
                self.sort = self.cates[index].type;
                self.cateType = self.cates[index].type;
                self.type = @"";
                self.screen_type = @"";
            } else {
                self.sort = @"";
                self.cateType = self.cates[index].type;
                self.type = self.cates[index].type;
                self.screen_type = type;
            }
            
            self.jm_page = 1;
            [self requestContact];
        } closeBlock: ^() {
            [self.searchView resetStatus];
        }];
        
        
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}

- (FNRequestTool*) requestContact{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"p": @(self.jm_page)}];
    if ([self.searchView.txfSearch.text kr_isNotEmpty]) {
        params[@"keyword"] = self.searchView.txfSearch.text;
    }
    if (self.sort) {
        params[@"sort"] = self.sort;
    }
    if (self.type) {
        params[@"type"] = self.type;
    }
    if (self.screen_type) {
        params[@"screen_type"] = self.screen_type;
    }
    if (self.tg_lv > 0) {
        params[@"tg_lv"] = @(self.tg_lv);
    }
    if (self.next_uid) {
        params[@"next_uid"] = self.next_uid;
    }
    if (self.data_type) {
        params[@"data_type"] = self.data_type;
    }
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection02&ctrl=mem_list" respondType:(ResponseTypeArray) modelType:@"FNNewConnectionMemModel" success:^(id respondsObject) {
        NSArray *array = respondsObject;
        @strongify(self);
        if (self.jm_page == 1) {
            [self.mems removeAllObjects];
        }
        self.jm_page ++;
        [self.mems addObjectsFromArray:array];
        [self.jm_tableview reloadData];
        
        if (array.count > 0) {
            self.jm_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [self requestContact];
            }];
            
        } else {
            self.jm_tableview.mj_footer = nil;
        }
        [self.jm_tableview.mj_footer endRefreshing];
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}

#pragma mark - FNNewConnectionSearchHeaderViewDelegate

- (void)searchView: (FNNewConnectionSearchHeaderView*)view didCateClick: (NSInteger)index button: (FNNewConnectionSearchSortButton*)button {
    //    [[FNNewConnenctionCateAlertView sharedInstance] showBelow: view titles: @[@"123", @"456", @"789", @"abc"]];
    _vHeader = view;
    if (self.model.search_data.count > 0) {
        FNNewConnectionCateListModel *item = self.model.search_data[0];
        FNNewConnectionCateSortModel *sort = item.sort[index];
        
        if ([sort.list_cate isEqualToString:@"second_list"]) {
            [self requestCate:sort.type];
        } else if ([sort.list_cate isEqualToString:@"up_down"]) {
            self.sort = button.state == 1 ? sort.up_type : sort.type;
            self.type = @"";
            self.screen_type = @"";
            self.jm_page = 1;
            [self requestContact];
        }
    }
}

- (void)searchView: (FNNewConnectionSearchHeaderView*)view didSearchClick: (NSString*) keyword {
    NSLog(@"%@", keyword);
    self.jm_page = 1;
    [self requestContact];
    [self.searchView.txfSearch resignFirstResponder];
}

- (void)cell: (FNNewConnectionButtonsCell*)cell didButtonClickAt: (NSInteger)index {
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    NSLog(@"%ld %@", index, indexPath);
//    if (indexPath.row == 2) {
//        FNNewConnectionContaceModel *contact = self.model.contact;
//        if (contact) {
//            FNNewConnectionDataFriendModel *friend = contact.list[index];
//            if ([friend.target isEqualToString: @"jump"]) {
//                [self loadOtherVCWithModel:friend andInfo:nil outBlock:nil];
//            } else {
//                FNConnectionsChatController *vc = [[FNConnectionsChatController alloc] init];
//                vc.uid = friend.sendee_uid;
//                vc.room = friend.room;
//                vc.target = friend.target;
//                vc.nickname = friend.name;
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//        }
//    } else if (indexPath.row == 3) {
//        FNNewConnectionContaceModel *group = self.model.group;
//        if (group) {
//            FNNewConnectionDataFriendModel *friend = group.list[index];
//            if ([friend.target isEqualToString: @"jump"]) {
//                [self loadOtherVCWithModel:friend andInfo:nil outBlock:nil];
//            } else {
//                FNConnectionsChatController *vc = [[FNConnectionsChatController alloc] init];
//                vc.uid = friend.qid;
//                vc.room = friend.room;
//                vc.target = friend.target;
//                vc.nickname = friend.nickname;
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//        }
//    }
}

- (void)cellDidMoreClick: (FNNewConnectionButtonsCell*)cell {
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    
    FNNewConnectionContactController *vc = [[FNNewConnectionContactController alloc] init];
    
    if (indexPath.row == 2) {
        vc.type = @"ren";
    } else if (indexPath.row == 3) {
        vc.type = @"qun";
    }
    
    [self.navigationController pushViewController: vc animated: YES];
}

#pragma mark - FNNewConnectionFriendCellDelegate

- (void)cellDidChatClick: (FNNewConnectionFriendCell*)cell {
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    
    if (indexPath.section == 0) {
        FNNewConnectionMemModel *mem = self.model.list[indexPath.row];
        FNConnectionsChatController *vc = [[FNConnectionsChatController alloc] init];
        vc.uid = mem.sendee_uid;
        vc.room = mem.room;
        vc.target = mem.target;
        vc.nickname = mem.nickname;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 1) {
        FNNewConnectionMemModel *mem = self.mems[indexPath.row];
        FNConnectionsChatController *vc = [[FNConnectionsChatController alloc] init];
        vc.uid = mem.sendee_uid;
        vc.room = mem.room;
        vc.target = mem.target;
        vc.nickname = mem.nickname;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
