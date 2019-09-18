//
//  FNNewConnectionHomeController.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/3.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewConnectionHomeController.h"
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
#import "FNNewConnectionSecondHomeController.h"
//#import "FNNewConnectionSearchController.h"

@interface FNNewConnectionHomeController ()<UITableViewDataSource,UITableViewDelegate, FNNewConnectionSearchHeaderViewDelegate, FNNewConnectionButtonsCellDelegate, FNNewConnectionFriendCellDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIView *rightView;
@property (nonatomic, strong)UIImageView *imageNav;
@property (nonatomic, strong)UIButton* settingBtn;
@property (nonatomic, strong)UIButton* msgBtn;
@property (nonatomic, strong)UIImageView* backBtn;

//@property (nonatomic, strong) FNNewConnectionModel *model;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) FNNewConnectionNavModel *navModel;
//@property (nonatomic, strong) NSArray<FNNewConnectionCate2Model*> *cates;
@property (nonatomic, strong) NSMutableArray<FNNewConnectionMemModel*> *mems;
@property (nonatomic, strong) FNNewConnectionCateModel *cate;
@property (nonatomic, strong) NSMutableDictionary *subCates;

@property (nonatomic, strong) UIView *vHeader;
@property (nonatomic, strong) FNNewConnectionSearchHeaderView *searchView;


@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *screen_type;
//@property (nonatomic, copy) NSString *keyword;

@property (nonatomic, copy) NSString *cateType;//记录分类二级选中项

@end

@implementation FNNewConnectionHomeController

- (BOOL)isFullScreenShow {
    return YES;
}

- (BOOL) needLogin {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
    [self requestMain];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

- (FNCustomeNavigationBar *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@"我的人脉"];
        
        _imageNav = [[UIImageView alloc] init];
//        [_navigationView addSubview:_imageNav];
        [_navigationView insertSubview:_imageNav atIndex:0];
        [_imageNav mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        _imageNav.contentMode = UIViewContentModeScaleAspectFill;
        _imageNav.layer.masksToBounds = YES;
        
//        self.backBtn = [[UIButton alloc] init];
//        self.backBtn.size = CGSizeMake(9, 15);
//        [self.backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
//        self.backBtn.hidden = !self.isNotHome;
        
        UIButton* leftView = [UIButton new];
        self.backBtn = [[UIImageView alloc] init];
        self.backBtn.size = CGSizeMake(9, 15);
        [leftView addSubview:self.backBtn];
        leftView.frame = CGRectMake(0, 0, 20, 20);
        [leftView addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        
        self.rightView = [UIView new];
        self.settingBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.settingBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [self.settingBtn addTarget:self action:@selector(settingBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.settingBtn.size = CGSizeMake(20, 20);
        [self.rightView addSubview:self.settingBtn];
        
        self.msgBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.msgBtn addTarget:self action:@selector(messageBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.msgBtn.size = CGSizeMake(20, 20);
        
        self.msgBtn.hidden = [FNCurrentVersion isEqualToString:Setting_checkVersion];
        [self.rightView addSubview:self.msgBtn];
        
        self.rightView.frame = CGRectMake(0, 0, self.settingBtn.width+self.msgBtn.width+15, self.settingBtn.height);
        
        [self.msgBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.msgBtn autoSetDimensionsToSize:self.msgBtn.size];
        [self.msgBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        
        [self.settingBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.settingBtn autoSetDimensionsToSize:self.settingBtn.size];
        [self.settingBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        
        _navigationView.rightButton = self.rightView;
        _navigationView.leftButton = leftView;
        
        _navigationView.titleLabel = [[UILabel alloc] init];
        _navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
        _navigationView.titleLabel.sd_layout
        .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
        [_navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
        _navigationView.titleLabel.textColor=[UIColor whiteColor];
        _navigationView.titleLabel.text = @"我的人脉";
        
    }
    return _navigationView;
}

- (void)jm_setupViews{
    
    _datas = [[NSMutableArray alloc] init];
    _mems = [[NSMutableArray alloc] init];
    _subCates = [[NSMutableDictionary alloc] init];
    
    self.view.backgroundColor = RGB(250, 250, 250);
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.jm_tableview.emptyDataSetSource = nil;
    self.jm_tableview.emptyDataSetDelegate = nil;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.alpha = 1;
    self.jm_tableview.backgroundColor = [UIColor clearColor];
//    self.jm_tableview.estimatedRowHeight = 200;
//    self.jm_tableview.rowHeight = UITableViewAutomaticDimension;
    
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.jm_tableview];
    
    [self.jm_tableview registerClass:[FNNewConnectionDetailCell class] forCellReuseIdentifier:@"FNNewConnectionDetailCell"];
    [self.jm_tableview registerClass:[FNNewConnectionDataCell class] forCellReuseIdentifier:@"FNNewConnectionDataCell"];
    [self.jm_tableview registerClass:[FNNewConnectionButtonsCell class] forCellReuseIdentifier:@"FNNewConnectionButtonsCell"];
    [self.jm_tableview registerClass:[FNNewConnectionSearchHeaderView class] forHeaderFooterViewReuseIdentifier:@"FNNewConnectionSearchHeaderView"];
    [self.jm_tableview registerClass:[FNNewConnectionFriendCell class] forCellReuseIdentifier:@"FNNewConnectionFriendCell"];
    
    [self.view addSubview:self.navigationView];
    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:self.navigationView.height];
    
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.navigationView.mas_bottom);
        make.bottom.equalTo(isIphoneX ? @-34 : @0);
    }];
    
    
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _searchView = [self.jm_tableview dequeueReusableHeaderFooterViewWithIdentifier:@"FNNewConnectionSearchHeaderView"];
    
//    [self requestMain];
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
        return _datas.count;
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
        id model = self.datas[indexPath.row];
        NSString *type = [model valueForKey: @"type"];
        if ([type isEqualToString:@"connection_extend_01"]) {
            return 120;
        } else if ([type isEqualToString:@"connection_teamstatistics_01"]) {
            return 160;
        } else if ([type isEqualToString:@"connection_recentcontacts_01"]) {
            return 160;
        } else if ([type isEqualToString:@"connection_groupchat_01"]) {
            return 160;
        }
        
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
        id model = self.datas[indexPath.row];
        NSString *type = [model valueForKey: @"type"];
        if ([type isEqualToString:@"connection_extend_01"]) {
            FNNewConnectionDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNNewConnectionDetailCell"];
            FNNewConnectionDataModel *data = model;
            if (data) {
                [cell setPadding:data.jiange.doubleValue];
                if (data.list.count > 0) {
                    FNNewConnectionDataFriendModel *friend = data.list[0];
                    cell.lblName.text = friend.nickname;
                    [cell.imgHeader sd_setImageWithURL:URL(friend.head_img)];
                    cell.lblPhone.text = friend.phone_str;
                    cell.lblCode.text = friend.tg_str;
                    cell.lblWechat.text = friend.wechat;
                    [cell.imgLevel sd_setImageWithURL:URL(friend.vip_logo)];
                    cell.lblLevel.textColor = [UIColor colorWithHexString:friend.Vname_color];
                    cell.lblLevel.text = friend.Vname;
                    
                    cell.lblName.textColor = [UIColor colorWithHexString:friend.color];
                    cell.lblPhone.textColor = [UIColor colorWithHexString:friend.color];
                    cell.lblCode.textColor = [UIColor colorWithHexString:friend.color];
                    cell.lblWechat.textColor = [UIColor colorWithHexString:friend.color];
                    
                }
                [cell.imgBackground sd_setImageWithURL:URL(data.bj_img)];
                [cell.btnChat setTitle:data.right_str forState:UIControlStateNormal];
                [cell.btnChat setTitleColor:[UIColor colorWithHexString:data.right_str_color] forState:UIControlStateNormal];
                //            [cell.btnChat sd_setImageWithURL:URL(data.img) forState:UIControlStateNormal];
                [cell.btnChat sd_setImageWithURL:URL(data.img) forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [cell.btnChat layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyleLeft) imageTitleSpace:4];
                }];
                
                cell.lblTitle.text = data.str;
                cell.lblTitle.textColor = [UIColor colorWithHexString:data.str_color];
                [cell updateHeight];
            }
            return cell;
        } else if ([type isEqualToString:@"connection_teamstatistics_01"]) {
            FNNewConnectionDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNNewConnectionDataCell"];
            FNNewConnectionStatisModel *data = model;
            if (data) {
                [cell.imgBackground sd_setImageWithURL:URL(data.bj_img)];
                [cell setPadding:data.jiange.doubleValue];
                if (data.list.count > 0) {
                    FNNewConnectionStatisDataModel *statics = data.list[0];
                    
                    FNNewConnectionStatisDetailModel *topLeftModel = statics.teamcount[0];
                    cell.lblLeftTopTitle.text = topLeftModel.name;
                    [cell.imgLeftTopTitle sd_setImageWithURL:URL(topLeftModel.img)];
                    cell.lblLeftTopValue.text = topLeftModel.count;
                    [cell.imgLeftTopValue sd_setImageWithURL:URL(topLeftModel.up_img)];
                    
                    FNNewConnectionStatisDetailModel *topRightModel = statics.teamcount[1];
                    cell.lblRightTopTitle.text = topRightModel.name;
                    [cell.imgRightTopTitle sd_setImageWithURL:URL(topRightModel.img)];
                    cell.lblRightTopValue.text = topRightModel.count;
                    [cell.imgRightTopValue sd_setImageWithURL:URL(topRightModel.up_img)];
                    
                    FNNewConnectionStatisDetailModel *bottomLeftModel = statics.daycount[0];
                    cell.lblLeftBottomTitle.text = bottomLeftModel.name;
                    cell.lblLeftBottomValue.text = bottomLeftModel.count;
                    
                    FNNewConnectionStatisDetailModel *bottomCenterModel = statics.daycount[1];
                    cell.lblCenterBottomTitle.text = bottomCenterModel.name;
                    cell.lblCenterBottomValue.text = bottomCenterModel.count;
                    
                    FNNewConnectionStatisDetailModel *bottomRightModel = statics.daycount[2];
                    cell.lblRightBottomTitle.text = bottomRightModel.name;
                    cell.lblRightBottomValue.text = bottomRightModel.count;
                    cell.delegate = self;
                    
                }
            }
            
            return cell;
        } else if ([type isEqualToString:@"connection_recentcontacts_01"]) {
            FNNewConnectionButtonsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNNewConnectionButtonsCell"];
            cell.delegate = self;
            FNNewConnectionContaceModel *contact = model;
            if (contact) {
                [cell setPadding:contact.jiange.doubleValue];
                [cell.imgBackground sd_setImageWithURL:URL(contact.bj_img)];
                cell.lblTitle.text = contact.str;
                cell.lblTitle.textColor = [UIColor colorWithHexString:contact.str_color];
                [cell.btnChat setTitle:contact.right_str forState:UIControlStateNormal];
                [cell.btnChat setTitleColor:[UIColor colorWithHexString:contact.right_str_color] forState:UIControlStateNormal];
                
                NSMutableArray *images = [[NSMutableArray alloc] init];
                NSMutableArray *titles = [[NSMutableArray alloc] init];
                NSMutableArray *colors = [[NSMutableArray alloc] init];
                NSMutableArray *counts = [[NSMutableArray alloc] init];
                for (FNNewConnectionDataFriendModel *friend in contact.list) {
                    if ([FNCurrentVersion isEqualToString:Setting_checkVersion]) {
                        if ([friend.target isEqualToString: @"jump"]) {
                            continue;
                        }
                    }
                    [images addObject:friend.head_img];
                    [titles addObject:friend.name];
                    [colors addObject:[UIColor colorWithHexString:@"#666666"]];
                    [counts addObject:friend.unread];
                }
                
                [cell showWithImages:images
                           andTitles:titles
                           andColors:colors
                              counts: counts clickBlock:^(NSInteger index) {
                                  
                              }];
            }
            return cell;
        } else if ([type isEqualToString:@"connection_groupchat_01"]) {
            FNNewConnectionButtonsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNNewConnectionButtonsCell"];
            cell.delegate = self;
            FNNewConnectionContaceModel *group = model;
            if (group) {
                [cell setPadding:group.jiange.doubleValue];
                [cell.imgBackground sd_setImageWithURL:URL(group.bj_img)];
                cell.lblTitle.text = group.str;
                cell.lblTitle.textColor = [UIColor colorWithHexString:group.str_color];
                [cell.btnChat setTitle:group.right_str forState:UIControlStateNormal];
                [cell.btnChat setTitleColor:[UIColor colorWithHexString:group.right_str_color] forState:UIControlStateNormal];
                
                NSMutableArray *images = [[NSMutableArray alloc] init];
                NSMutableArray *titles = [[NSMutableArray alloc] init];
                NSMutableArray *colors = [[NSMutableArray alloc] init];
                NSMutableArray *counts = [[NSMutableArray alloc] init];
                for (FNNewConnectionDataFriendModel *friend in group.list) {
                    [images addObject:friend.head_img];
                    [titles addObject:friend.name];
                    [colors addObject:[UIColor colorWithHexString:@"#666666"]];
                    [counts addObject:friend.unread];
                }
                
                [cell showWithImages:images
                           andTitles:titles
                           andColors:colors
                              counts: counts clickBlock:^(NSInteger index) {
                                  
                              }];
            }
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

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        id model = self.datas[indexPath.row];
//        NSString *type = [model valueForKey: @"type"];
//        if ([type isEqualToString:@"connection_extend_01"]) {
//            FNNewConnectionDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNNewConnectionDetailCell"];
//            FNNewConnectionDataModel *data = model;
//            return 116 + data.jiange.doubleValue;
//        } else if ([type isEqualToString:@"connection_teamstatistics_01"]) {
//            FNNewConnectionDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNNewConnectionDataCell"];
//            FNNewConnectionStatisModel *data = model;
//            return 151 + data.jiange.doubleValue;
//        } else if ([type isEqualToString:@"connection_recentcontacts_01"]) {
//            FNNewConnectionButtonsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNNewConnectionButtonsCell"];
//            cell.delegate = self;
//            FNNewConnectionContaceModel *contact = model;
//            return 136 + contact.jiange.doubleValue;
//        } else if ([type isEqualToString:@"connection_groupchat_01"]) {
//            FNNewConnectionButtonsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNNewConnectionButtonsCell"];
//            cell.delegate = self;
//            FNNewConnectionContaceModel *group = model;
//            return 136 + group.jiange.doubleValue;
//        }
//
//    } else {
//        return 162 + 10;
//
//    }
//
//    return 0;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 114;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [[UIView alloc] init];
    }
    FNNewConnectionSearchHeaderView *header = _searchView;
    return header;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        id model = self.datas[indexPath.row];
        NSString *type = [model valueForKey: @"type"];
        if ([type isEqualToString:@"connection_extend_01"]) {
            FNNewConnectionDataModel *data = model;
            if (data) {
                if (data.list.count > 0) {
                    FNNewConnectionDataFriendModel *friend = data.list[0];
                    FNConnectionsChatController *vc = [[FNConnectionsChatController alloc] init];
                    vc.uid = friend.sendee_uid;
                    vc.room = friend.room;
                    vc.target = friend.target;
                    vc.nickname = friend.nickname;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
            }
        } else if ([type isEqualToString:@"connection_teamstatistics_01"]) {
            
        }
    } else if (indexPath.section == 1 && self.mems.count > 0) {
        
        FNNewConnectionMemModel *mem = self.mems[indexPath.row];
        if ([mem.is_jump isEqualToString:@"0"]) {
            [FNTipsView showTips:mem.tip_str];
        } else {
            FNNewConnectionSecondHomeController *vc = [[FNNewConnectionSecondHomeController alloc] init];
            vc.next_uid = mem.next_uid;
            vc.tg_lv = 1;
            vc.title = mem.nickname;
            [self.navigationController pushViewController:vc animated:YES];
        }
    
    }
}

#pragma mark - Networking

- (FNRequestTool*) requestMain{
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection02&ctrl=index" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        
        [self.datas removeAllObjects];
        
        for (NSDictionary *dict in respondsObject) {
            NSString *type = dict[@"type"];
            if ([type isEqualToString:@"connection_topnav_01"]) {
                self.navModel = [FNNewConnectionNavModel mj_objectWithKeyValues:dict];
                
                if (self.navModel.list.count > 0) {
                    FNNewConnectionNavDataModel * nav = self.navModel.list[0];
                    [self.imageNav sd_setImageWithURL:URL(nav.bj_img)];
                    
                    [self.msgBtn sd_setBackgroundImageWithURL:URL(nav.phb_img) forState:UIControlStateNormal];
                    [self.settingBtn sd_setBackgroundImageWithURL:URL(nav.msg_img) forState:UIControlStateNormal];
                    self.msgBtn.hidden = [nav.is_show_phb isEqualToString:@"0"];
                    self.settingBtn.hidden = [nav.is_show_msg isEqualToString:@"0"];
                    
                    
                    if (self.settingBtn.hidden) {
                        self.rightView.bounds = CGRectMake(0, 0, self.msgBtn.width, self.msgBtn.height);
                    }
                    
                    [self.backBtn sd_setImageWithURL:URL(nav.return_img)];
                }
            } else if ([type isEqualToString:@"connection_extend_01"]) {
                [self.datas addObject:[FNNewConnectionDataModel mj_objectWithKeyValues:dict]];
            } else if ([type isEqualToString:@"connection_teamstatistics_01"]) {
                [self.datas addObject:[FNNewConnectionStatisModel mj_objectWithKeyValues:dict]];
            } else if ([type isEqualToString:@"connection_recentcontacts_01"]) {
                [self.datas addObject:[FNNewConnectionContaceModel mj_objectWithKeyValues:dict]];
            } else if ([type isEqualToString:@"connection_groupchat_01"]) {
                [self.datas addObject:[FNNewConnectionContaceModel mj_objectWithKeyValues:dict]];
            } else if ([type isEqualToString:@"connection_teammsg_01"]) {
                
                self.cate = [FNNewConnectionCateModel mj_objectWithKeyValues:dict];
                if (self.cate) {
                    if (self.cate.list.count > 0) {
                        FNNewConnectionCateListModel *item = self.cate.list[0];
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
                        [self.subCates removeAllObjects];
                        for (FNNewConnectionCateSortModel *sort in item.sort) {
                            if ([sort.list_cate isEqualToString:@"second_list"])
                                [self requestCate: sort.type];
                        }
                    }
                }
            }
        }
        
        [self.jm_tableview reloadData];
        
    } failure:^(NSString *error) {
        //
    } isHideTips:NO isCache: NO];
}

- (FNRequestTool*) requestCate: (NSString*) type{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"type": type}];
    @weakify(self);
//    [SVProgressHUD show];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection02&ctrl=second_cate" respondType:(ResponseTypeArray) modelType:@"FNNewConnectionCate2Model" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        @strongify(self);
        
        self.subCates[type] = respondsObject;
        
        
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
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
    if (self.cate) {
        if (self.cate.list.count > 0) {
            FNNewConnectionCateListModel *item = self.cate.list[0];
            FNNewConnectionCateSortModel *sort = item.sort[index];

            if ([sort.list_cate isEqualToString:@"second_list"] && [[self.subCates allKeys] containsObject:sort.type]) {

                NSArray<FNNewConnectionCate2Model*> * cates = self.subCates[sort.type];
                NSMutableArray *titles = [[NSMutableArray alloc] init];
                [[FNNewConnenctionCateAlertView sharedInstance] setSelectedIndex: -1];
                for (NSInteger index = 0; index < cates.count; index++) {
                    FNNewConnectionCate2Model* cate = cates[index];
                    [titles addObject: cate.name];
                    if ([cate.type isEqualToString:self.cateType]) {
                        [[FNNewConnenctionCateAlertView sharedInstance] setSelectedIndex: index];
                    }
                }
                @weakify(self);
                [[FNNewConnenctionCateAlertView sharedInstance] showBelow: _vHeader titles: titles block: ^(NSInteger index){
                    @strongify(self);
                    //            self.cate2 = self.cates[index];
                    
                    if ([cates[index].list_cate isEqualToString:@"down"]) {
                        self.sort = cates[index].type;
                        self.cateType = cates[index].type;
                        self.type = @"";
                        self.screen_type = @"";
                    } else {
                        self.sort = @"";
                        self.cateType = cates[index].type;
                        self.type = cates[index].type;
                        self.screen_type = sort.type;
                    }
                    
                    self.jm_page = 1;
                    [self requestContact];
                } closeBlock: ^() {
                    [self.searchView resetStatus];
                }];
                
            } else if ([sort.list_cate isEqualToString:@"up_down"]) {
                self.sort = button.state == 1 ? sort.up_type : sort.type;
                self.type = @"";
                self.screen_type = @"";
                self.jm_page = 1;
                [self requestContact];
            }
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
    id model = _datas[indexPath.row];
    NSString *type = [model valueForKey: @"type"];
    if ([type isEqualToString:@"connection_recentcontacts_01"]) {
        FNNewConnectionContaceModel *contact = model;
        if (contact) {
            FNNewConnectionDataFriendModel *friend = contact.list[index];
            if ([friend.target isEqualToString: @"jump"]) {
                [self loadOtherVCWithModel:friend andInfo:nil outBlock:nil];
            } else {
                FNConnectionsChatController *vc = [[FNConnectionsChatController alloc] init];
                vc.uid = friend.sendee_uid;
                vc.room = friend.room;
                vc.target = friend.target;
                vc.nickname = friend.name;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    } else if ([type isEqualToString:@"connection_groupchat_01"]) {
        FNNewConnectionContaceModel *group = model;
        if (group) {
            FNNewConnectionDataFriendModel *friend = group.list[index];
            if ([friend.target isEqualToString: @"jump"]) {
                [self loadOtherVCWithModel:friend andInfo:nil outBlock:nil];
            } else {
                FNConnectionsChatController *vc = [[FNConnectionsChatController alloc] init];
                vc.uid = friend.qid;
                vc.room = friend.room;
                vc.target = friend.target;
                vc.nickname = friend.nickname;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
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
    id model = _mems[indexPath.row];
    NSString *type = [model valueForKey: @"type"];
    
    if (indexPath.section == 0 && [type isEqualToString:@"connection_extend_01"]) {
        
        FNNewConnectionDataModel *data = model;
        if (data) {
            if (data.list.count > 0) {
                FNNewConnectionDataFriendModel *friend = data.list[0];
                FNConnectionsChatController *vc = [[FNConnectionsChatController alloc] init];
                vc.uid = friend.sendee_uid;
                vc.room = friend.room;
                vc.target = friend.target;
                vc.nickname = friend.nickname;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
        }
    } else if (indexPath.section == 1 && self.mems.count > 0) {
        FNNewConnectionMemModel *mem = self.mems[indexPath.row];
        FNConnectionsChatController *vc = [[FNConnectionsChatController alloc] init];
        vc.uid = mem.sendee_uid;
        vc.room = mem.room;
        vc.target = mem.target;
        vc.nickname = mem.nickname;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -

- (void) onLeftTopClick: (FNNewConnectionDataCell*)cell{
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    FNNewConnectionStatisModel *data = self.datas[indexPath.row];
    if (data.list == nil || data.list.count <= 0)
        return;
    FNNewConnectionStatisDataModel *model = data.list[0];
    NSArray<FNNewConnectionStatisDetailModel*> *details = model.teamcount;
    if (details.count >= 1) {
        FNNewConnectionStatisDetailModel *detail = details[0];
        FNNewConnectionSecondHomeController *vc = [[FNNewConnectionSecondHomeController alloc] init];
        vc.data_type = detail.data_type;
        vc.title = detail.name;
        [self.navigationController pushViewController: vc animated: YES];
    }
}
- (void) onRightTopClick: (FNNewConnectionDataCell*)cell{
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    FNNewConnectionStatisModel *data = self.datas[indexPath.row];
    if (data.list == nil || data.list.count <= 0)
        return;
    FNNewConnectionStatisDataModel *model = data.list[0];
    NSArray<FNNewConnectionStatisDetailModel*> *details = model.teamcount;
    if (details.count >= 2) {
        FNNewConnectionStatisDetailModel *detail = details[1];
        FNNewConnectionSecondHomeController *vc = [[FNNewConnectionSecondHomeController alloc] init];
        vc.data_type = detail.data_type;
        vc.title = detail.name;
        [self.navigationController pushViewController: vc animated: YES];
    }
}
- (void) onLeftBottomClick: (FNNewConnectionDataCell*)cell{
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    FNNewConnectionStatisModel *data = self.datas[indexPath.row];
    if (data.list == nil || data.list.count <= 0)
        return;
    FNNewConnectionStatisDataModel *model = data.list[0];
    NSArray<FNNewConnectionStatisDetailModel*> *details = model.daycount;
    if (details.count >= 1) {
        FNNewConnectionStatisDetailModel *detail = details[0];
        FNNewConnectionSecondHomeController *vc = [[FNNewConnectionSecondHomeController alloc] init];
        vc.data_type = detail.data_type;
        vc.title = detail.name;
        [self.navigationController pushViewController: vc animated: YES];
    }
}
- (void) onCenterBottomClick: (FNNewConnectionDataCell*)cell{
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    FNNewConnectionStatisModel *data = self.datas[indexPath.row];
    if (data.list == nil || data.list.count <= 0)
        return;
    FNNewConnectionStatisDataModel *model = data.list[0];
    NSArray<FNNewConnectionStatisDetailModel*> *details = model.daycount;
    if (details.count >= 2) {
        FNNewConnectionStatisDetailModel *detail = details[1];
        FNNewConnectionSecondHomeController *vc = [[FNNewConnectionSecondHomeController alloc] init];
        vc.data_type = detail.data_type;
        vc.title = detail.name;
        [self.navigationController pushViewController: vc animated: YES];
    }
}
- (void) onRightBottomClick: (FNNewConnectionDataCell*)cell{
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    FNNewConnectionStatisModel *data = self.datas[indexPath.row];
    if (data.list == nil || data.list.count <= 0)
        return;
    FNNewConnectionStatisDataModel *model = data.list[0];
    NSArray<FNNewConnectionStatisDetailModel*> *details = model.daycount;
    if (details.count >= 3) {
        FNNewConnectionStatisDetailModel *detail = details[2];
        FNNewConnectionSecondHomeController *vc = [[FNNewConnectionSecondHomeController alloc] init];
        vc.data_type = detail.data_type;
        vc.title = detail.name;
        [self.navigationController pushViewController: vc animated: YES];
    }
}

@end
