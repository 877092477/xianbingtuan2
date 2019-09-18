//
//  FNConnectionsHomeController.m
//  THB
//
//  Created by Weller Zhao on 2019/1/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsHomeController.h"
#import "FNConnectionsChatController.h"
#import "FNCustomeNavigationBar.h"
#import "FNConnectionsHomeHeaderView.h"
#import "FNConnectionsHomeCell.h"
#import "FNConnectionsHomeHeaderCell.h"
#import "FNConnectionsGroupsController.h"

#import "FNConnectionsHomeModel.h"
#import "FNConnectionsMemberModel.h"
#import "FNIndexSelectorView.h"

@interface FNConnectionsHomeController () <UITableViewDelegate, UITableViewDataSource, FNIndexSelectorViewDelegate, FNConnectionsHomeHeaderViewDelegate, FNConnectionsHomeHeaderCellDelegate, FNConnectionsChatControllerDelegate>

@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong) FNIndexSelectorView* indexSelector;

@property (nonatomic, strong)UIButton* scanBtn;
@property (nonatomic, strong)UIButton* searchBtn;
@property (nonatomic, strong)UIImageView* backBtn;
@property (nonatomic, strong)UILabel* titleBtn;
@property (nonatomic, strong)UIImageView *imgHeader;

@property (nonatomic, strong) UILabel *lblCount;

@property (nonatomic, strong) FNConnectionsHomeHeaderView *headerView;

@property (nonatomic, strong) FNConnectionsHomeModel* headerModel;

@property (nonatomic, strong) NSMutableArray<NSMutableArray<FNConnectionsMemberModel*>*> *members;
@property (nonatomic, strong) NSMutableArray<NSString*> *memberKeys;

@property (nonatomic, strong) UILabel *lblTip;

@end

@implementation FNConnectionsHomeController

#define HeaderHeight 125
#define HeaderOffset 60

- (FNConnectionsHomeHeaderView*) headerView {
    if (_headerView == nil) {
        _headerView = [[FNConnectionsHomeHeaderView alloc] init];
        _headerView.delegate = self;
        [self.view addSubview:_headerView];
    }
    return _headerView;
}

- (FNIndexSelectorView*)indexSelector {
    if (_indexSelector == nil) {
        _indexSelector = [[FNIndexSelectorView alloc] init];
        [self.view addSubview:_indexSelector];
        
    }
    return _indexSelector;
}

- (UILabel*) lblTip {
    if (_lblTip == nil) {
        _lblTip = [[UILabel alloc] init];
        _lblTip.backgroundColor = RGB(80, 80, 80);
        _lblTip.font = [UIFont boldSystemFontOfSize:24];
        _lblTip.textColor = UIColor.whiteColor;
        _lblTip.cornerRadius = 30;
        _lblTip.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_lblTip];
        [_lblTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(@0);
            make.width.height.mas_equalTo(60);
        }];
        [_lblTip setHidden:YES];
    }
    return _lblTip;
}

- (UILabel*) lblCount {
    if (_lblCount == nil) {
        _lblCount = [[UILabel alloc] init];
        [self.view addSubview:_lblCount];
        
        _lblCount.textColor = RGB(38, 38, 38);
        _lblCount.font = kFONT13;
        _lblCount.textAlignment = NSTextAlignmentCenter;
        
        [_lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.height.mas_equalTo(36);
            make.bottom.equalTo(isIphoneX ? @-20 : @0);
        }];
    }
    return _lblCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [FNNotificationCenter addObserver:self selector:@selector(didGroupCreate) name:@"didChatGroupCreate" object:nil];
    
    self.members = [[NSMutableArray alloc] init];
    self.memberKeys = [[NSMutableArray alloc] init];
}

-(void)dealloc {
    [FNNotificationCenter removeObserver:self];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
    [self requestMain:NO];
    if ([NSString isEmpty:UserAccessToken]) {
        [self warnToLogin];
    }
}


- (FNCustomeNavigationBar *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
        
        UIButton* leftView = [UIButton new];
        self.backBtn = [[UIImageView alloc] init];
        self.backBtn.size = CGSizeMake(6, 12);
        [leftView addSubview:self.backBtn];
        
        self.titleBtn = [[UILabel alloc] init];
//        [self.titleBtn addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.titleBtn.size = CGSizeMake(XYScreenWidth - 120, 20);
//        self.titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [leftView addSubview:self.titleBtn];
        leftView.frame = CGRectMake(0, 0, self.backBtn.width+self.titleBtn.width+15, 20);
        [leftView addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.backBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.backBtn autoSetDimensionsToSize:self.backBtn.size];
        [self.backBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        
        [self.titleBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.titleBtn autoSetDimensionsToSize:self.titleBtn.size];
        [self.titleBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        
        _navigationView.leftButton = leftView;
        
        if ([self isEqual:self.navigationController.viewControllers.firstObject]) {
            _backBtn.hidden = YES;
            leftView.enabled = NO;
            _titleBtn.enabled = NO;
        }
        
    }
    return _navigationView;
}

- (void)jm_setupViews{
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
    
    
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.jm_tableview];
    
    @weakify(self)
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self_weak_.headerView.mas_bottom).offset(0);
        make.bottom.equalTo(self_weak_.lblCount.mas_top);
    }];
    
    [self.jm_tableview registerClass:[FNConnectionsHomeHeaderCell class] forHeaderFooterViewReuseIdentifier:@"FNConnectionsHomeHeaderCell"];
    [self.jm_tableview registerClass:[FNConnectionsHomeCell class] forCellReuseIdentifier:@"FNConnectionsHomeCell"];
//    [self.jm_tableview registerClass:[FNMineIconsCell class] forCellReuseIdentifier:@"FNMineIconsCell"];
//    [self.jm_tableview registerClass:[FNMineImageCell class] forCellReuseIdentifier:@"FNMineImageCell"];
    
    [self.view addSubview:self.navigationView];
    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:self.navigationView.height];
    
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self_weak_.navigationView.mas_bottom).offset(20);
        make.left.right.equalTo(@0);
    }];
    
    [self.indexSelector mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.width.mas_equalTo(20);
        make.top.bottom.equalTo(self_weak_.jm_tableview);
    }];
    self.indexSelector.delegate = self;
    
    
    [self configHeader];
    
//    [self requestMain: YES];
}

- (void)configHeader {
    _imgHeader = [[UIImageView alloc] init];
    [self.view insertSubview:_imgHeader atIndex:0];
    @weakify(self)
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(self_weak_.headerView.mas_top).offset(HeaderOffset);
    }];
    _imgHeader.contentMode = UIViewContentModeScaleAspectFill;
    _imgHeader.layer.masksToBounds = YES;
}

#pragma mark - request
- (void)requestMain: (BOOL)isCache{
    
    self.jm_page = 1;
    [SVProgressHUD show];
    @weakify(self);
    [FNRequestTool startWithRequests:@[[self requestHeader: isCache], [self requestInviters: YES]] withFinishedBlock:^(NSArray *erros) {
        @strongify(self);
        [SVProgressHUD dismiss];
        
        [self.jm_tableview reloadData];
    }];
}

- (FNRequestTool*) requestHeader: (BOOL)isCache {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection_index&ctrl=index" respondType:(ResponseTypeModel) modelType:@"FNConnectionsHomeModel" success:^(id respondsObject) {
        
        self_weak_.headerModel = respondsObject;
        NSMutableArray *titles = [[NSMutableArray alloc] init];
        NSMutableArray *colors = [[NSMutableArray alloc] init];
        NSMutableArray *imageUrls = [[NSMutableArray alloc] init];
        NSMutableArray *badges = [[NSMutableArray alloc] init];
        for (FNConnectionsHomeTopIconModel *top in self_weak_.headerModel.top.list) {
            [titles addObject:top.title];
            [colors addObject:[UIColor colorWithHexString:top.font_color]];
            [imageUrls addObject:top.img];
            [badges addObject:top.count];
        }
        [self_weak_.headerView setTitles:titles withColors:colors imageUrls:imageUrls badges:badges];
        
        [self_weak_.headerView setBackgroundImageUrl:self_weak_.headerModel.top.list_bgimg];
        [self_weak_.imgHeader sd_setImageWithURL:URL(self_weak_.headerModel.top.bg_img)];
        
        self_weak_.titleBtn.text = self_weak_.headerModel.top.title;
        self_weak_.titleBtn.textColor = [UIColor colorWithHexString:self_weak_.headerModel.top.font_color];
        [self_weak_.backBtn sd_setImageWithURL:URL(self_weak_.headerModel.top.return_img)];
        
        [self_weak_.scanBtn sd_setBackgroundImageWithURL:URL(self_weak_.headerModel.top.scan_img) forState:UIControlStateNormal];
        [self_weak_.searchBtn sd_setBackgroundImageWithURL:URL(self_weak_.headerModel.top.search_img) forState:UIControlStateNormal];
        
        self_weak_.lblCount.text = self_weak_.headerModel.friend_str;
        [self_weak_.indexSelector setTitles:self.headerModel.ABC];
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache:isCache];
}

- (FNRequestTool*) requestInviters: (BOOL) isCache {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection_index&ctrl=extend_list" respondType:(ResponseTypeModel) modelType:@"FNConnectionsMemberGroupModel" success:^(id respondsObject) {
        @strongify(self);
        
        [self.members removeAllObjects];
        [self.memberKeys removeAllObjects];
        
        FNConnectionsMemberGroupModel *model = respondsObject;
        if ([model.is_show isEqualToString:@"1"]) {
            [self.memberKeys addObject:model.str];
            [self.members addObject:[[NSMutableArray alloc] init]];
            [self.members.lastObject addObjectsFromArray:model.list];
        }
        
        [self requestConnections: isCache];
        [self.jm_tableview.mj_footer endRefreshing];
        [self.jm_tableview.mj_header endRefreshing];
        [self.jm_tableview reloadData];
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache:isCache];
}

- (FNRequestTool*) requestConnections: (BOOL)isCache {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"p": @(self.jm_page)}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection_index&ctrl=team_list" respondType:(ResponseTypeArray) modelType:@"FNConnectionsMemberGroupModel" success:^(id respondsObject) {
        @strongify(self);
//        if (self.jm_page == 1) {
//            [self.members removeAllObjects];
//            [self.memberKeys removeAllObjects];
//        }
        
        NSArray *array = respondsObject;
        if (array.count > 0) {
            self.jm_page ++;
            self.jm_tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        } else {
            self.jm_tableview.mj_footer = nil;
        }
        
        for (FNConnectionsMemberGroupModel *group in array) {
            if (self.memberKeys.count == 0 || ![group.str isEqualToString:self.memberKeys.lastObject]) {
                [self.memberKeys addObject:group.str];
                [self.members addObject:[[NSMutableArray alloc] init]];
            }
            
            [self.members.lastObject addObjectsFromArray:group.list];
        }
        
        [self.jm_tableview.mj_footer endRefreshing];
        [self.jm_tableview.mj_header endRefreshing];
        [self.jm_tableview reloadData];
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache:isCache];
}

#pragma mark - action
- (void)scanBtnAction{
    
}
- (void)messageBtnAction{
}

- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadMoreData {
    [self requestConnections: NO];
}

- (void) didGroupCreate{
    self.jm_page = 1;
    [self requestMain:NO];
}


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    int count = 0;
    if (self.headerModel && [self.headerModel.custom_service.is_show isEqualToString:@"1"]) {
        count++;
    }
    if (self.headerModel && [self.headerModel.group.is_show isEqualToString:@"1"]) {
        count++;
    }
    return count + self.members.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int count = 0;
    if (self.headerModel && [self.headerModel.custom_service.is_show isEqualToString:@"1"]) {
        if (section - count == 0) {
            return self.headerModel.custom_service.list.count;
        }
        count++;
    }
    if (self.headerModel && [self.headerModel.group.is_show isEqualToString:@"1"]) {
        if (section - count == 0) {
            return self.headerModel.group.list.count;
        }
        count++;
    }
    return self.members[section - count].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [[UITableViewCell alloc] init];
    FNConnectionsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNConnectionsHomeCell"];
    
    int count = 0;
    if (self.headerModel && [self.headerModel.custom_service.is_show isEqualToString:@"1"]) {
        if (indexPath.section - count == 0) {
            
            FNConnectionsHomeServiceItemModel *item = self.headerModel.custom_service.list[indexPath.row];
            cell.lblTitle.text = item.nickname;
            [cell.imgHeader sd_setImageWithURL:URL(item.head_img)];
            cell.lblDesc.text = item.content;
            cell.lblPhone.text = @"";
            cell.lblType.text = @"";
            return cell;
        }
        count++;
    }
    if (self.headerModel && [self.headerModel.group.is_show isEqualToString:@"1"]) {
        if (indexPath.section - count == 0) {
            FNConnectionsGroupModel *item = self.headerModel.group.list[indexPath.row];
            cell.lblTitle.text = item.nickname;
            [cell.imgHeader sd_setImageWithURL:URL(item.head_img)];
            cell.lblDesc.text = item.content;
            cell.lblPhone.text = @"";
            cell.lblType.text = @"";
            return cell;
        }
        count++;
    }
    FNConnectionsMemberModel *model = self.members[indexPath.section - count][indexPath.row];
    [cell.imgHeader sd_setImageWithURL:URL(model.head_img)];
//    cell.lblTitle.text = [NSString stringWithFormat:@"%@  %@ %@", model.Vname, model.nickname, model.tg_str];
    NSString *strTitle = [NSString stringWithFormat:@"%@  %@ %@", model.Vname, model.nickname, model.tg_str];
    NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:strTitle];
    [attrTitle addAttributes:@{NSFontAttributeName: kFONT10, NSForegroundColorAttributeName: RGB(244, 62, 121)} range:NSMakeRange(model.Vname.length + model.nickname.length + 3, model.tg_str.length)];
    cell.lblTitle.attributedText = attrTitle;
    if ([model.commision_str kr_isNotEmpty] &&
        [model.commission kr_isNotEmpty] &&
        [model.commision_unit kr_isNotEmpty]) {
        NSString *strDesc = [NSString stringWithFormat:@"%@%@%@   %@%d%@", model.commision_str, model.commission, model.commision_unit, model.team_str, model.count, model.team_unit];
        NSMutableAttributedString *attrDesc = [[NSMutableAttributedString alloc] initWithString:strDesc];
        [attrDesc addAttributes:@{NSForegroundColorAttributeName: RGB(90, 90, 90)} range:NSMakeRange(model.commision_str.length, model.commission.length + model.commision_unit.length)];
        NSUInteger pos = model.commision_str.length + model.commission.length + model.commision_unit.length + model.team_str.length + 3;
        [attrDesc addAttributes:@{NSForegroundColorAttributeName: RGB(90, 90, 90)} range:NSMakeRange(pos, strDesc.length - pos)];
        cell.lblDesc.attributedText = attrDesc;
    } else {
        cell.lblDesc.attributedText = [[NSAttributedString alloc] initWithString:@""];
    }
    cell.lblPhone.text = model.phone_str;
    cell.lblType.text = model.online_str;
    cell.lblType.textColor = [UIColor colorWithHexString:model.online_color];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FNConnectionsHomeHeaderCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FNConnectionsHomeHeaderCell"];
    cell.delegate = self;
    
    int count = 0;
    if (self.headerModel && [self.headerModel.custom_service.is_show isEqualToString:@"1"]) {
        if (section - count == 0) {
            return [[UIView alloc] init];
        }
        count++;
    }
    if (self.headerModel && [self.headerModel.group.is_show isEqualToString:@"1"]) {
        if (section - count == 0) {
            [cell setTitle:self.headerModel.group.name withMore: self.headerModel.group.str];
            return cell;
        }
        count++;
    }
    NSString *title = self.memberKeys[section - count];
    [cell setTitle:title withMore: @""];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.headerModel && [self.headerModel.custom_service.is_show isEqualToString:@"1"]) {
        if (section == 0) {
            return 0;
        }
    }
    return 26;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int count = 0;
    if (self.headerModel && [self.headerModel.custom_service.is_show isEqualToString:@"1"]) {
        if (indexPath.section - count == 0) {
            return ;
        }
        count++;
    }
    if (self.headerModel && [self.headerModel.group.is_show isEqualToString:@"1"]) {
        if (indexPath.section - count == 0) {
            FNConnectionsGroupModel *item = self.headerModel.group.list[indexPath.row];
            FNConnectionsChatController *vc = [[FNConnectionsChatController alloc] init];
            vc.uid = item.qid;
            vc.target = item.target;
            vc.room=item.room;
            vc.nickname=item.nickname;
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
            return ;
        }
        count++;
    }
    FNConnectionsMemberModel *model = self.members[indexPath.section - count][indexPath.row];
    FNConnectionsChatController *vc = [[FNConnectionsChatController alloc] init];
    vc.uid = model.uid;

    vc.room=model.room;

    vc.target = model.target;
    
    vc.nickname=model.nickname;

    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - FNIndexSelectorViewDelegate

- (void)selectorView:(FNIndexSelectorView *)selector didSelectedAt:(NSInteger)index {
    int count = 0;
    if (self.headerModel && [self.headerModel.custom_service.is_show isEqualToString:@"1"]) {
        count++;
    }
    if (self.headerModel && [self.headerModel.group.is_show isEqualToString:@"1"]) {
        count++;
    }
    self.lblTip.text = self.headerModel.ABC[index];
    [self.view bringSubviewToFront:self.lblTip];
    [self.lblTip setHidden:NO];
    for (NSInteger i = 0; i < self.memberKeys.count; i++) {
        NSComparisonResult result = [self.memberKeys[i] compare:self.headerModel.ABC[index]];
        if (result == NSOrderedSame || result == NSOrderedDescending) {
            [self.jm_tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i + count] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            break;
        }
    }
}

- (void)selectorViewDidCancle: (FNIndexSelectorView*)selector {
    [self.lblTip setHidden:YES];
}

#pragma mark - FNConnectionsHomeHeaderViewDelegate

- (void) headerView:(FNConnectionsHomeHeaderView *)headerView didSelectedAt:(NSInteger)index {
    FNConnectionsHomeTopIconModel *model = self.headerModel.top.list[index];
    [self loadOtherVCWithModel:model andInfo:nil outBlock:nil];
}

#pragma mark - FNConnectionsHomeHeaderCellDelegate
- (void)headerCelldidMoreSelected:(FNConnectionsHomeHeaderCell *)cell {
//    FNConnectionsHomeHeaderCell *cell = self.jm_collectionview
    FNConnectionsGroupsController *vc = [[FNConnectionsGroupsController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - FNConnectionsChatControllerDelegate
- (void)didChatUpdate {
//    [self requestInviters:NO];
    [self requestMain: NO];
}

@end
