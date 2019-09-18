//
//  FNConnectionsSettingController.m
//  THB
//
//  Created by Weller Zhao on 2019/3/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsSettingController.h"
#import "FNCustomeNavigationBar.h"
#import "FNConnectionsSettingModel.h"
#import "FNConnectionsSettingMembersCell.h"
#import "FNConnectionsCreateGroupsController.h"
#import "ProfileCell.h"
#import "FNConnectionSettingExitCell.h"
#import "FNConnectionsNoticeController.h"
#import "FNConnectionRemarkController.h"
#import "FNConnectionsRemoveMembersController.h"
#import "FNConnectionsSwitchCell.h"

@interface FNConnectionsSettingController () <UITableViewDelegate, UITableViewDataSource, FNConnectionsSettingMembersCellDelegate, FNConnectionsSwitchCellDelegate>

@property(nonatomic,strong)FNCustomeNavigationBar *topNaivgationbar;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)FNConnectionsSettingModel *model;
@property(nonatomic,strong)UITableView *tbvSetting;

@end

@implementation FNConnectionsSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopNavBar];
    [self configUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self requestSetting];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

#pragma mark - 导航栏view
-(void)setTopNavBar{
    
    UIView *topView=[[UIView alloc]init];
    topView.frame=CGRectMake(0, 0, FNDeviceWidth, SafeAreaTopHeight);
    //self.topImg=[[UIImageView alloc]init];
    //[topView addSubview:self.topImg];
    self.topNaivgationbar = [FNCustomeNavigationBar customeNavigationBarWithCustomeView:topView];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,FNDeviceWidth,SafeAreaTopHeight);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:177/255.0 green:101/255.0 blue:251/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:255/255.0 green:59/255.0 blue:153/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0)];
    
    [self.topNaivgationbar.layer addSublayer:gl];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn setImage:[UIImage imageNamed:@"return-white"] forState:UIControlStateNormal];
    [self.leftBtn setTitle:self.nickname forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font=kFONT17;
    [self.leftBtn sizeToFit];
    self.leftBtn.size = CGSizeMake(self.leftBtn.width+10, 30);
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.leftBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10.0f];
    
    self.topNaivgationbar.leftButton = self.leftBtn;
    
    [self.view addSubview:_topNaivgationbar];
    self.topNaivgationbar.backgroundColor =[UIColor whiteColor];
    
}

- (void)configUI {
    self.tbvSetting = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tbvSetting];
    
    self.tbvSetting.delegate = self;
    self.tbvSetting.dataSource = self;
    self.tbvSetting.rowHeight = UITableViewAutomaticDimension;
    self.tbvSetting.estimatedRowHeight = 200;
    self.tbvSetting.estimatedSectionFooterHeight = 0;
    self.tbvSetting.estimatedSectionHeaderHeight = 10;
    self.tbvSetting.backgroundColor = FNHomeBackgroundColor;
    self.tbvSetting.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tbvSetting registerClass:[FNConnectionsSettingMembersCell class] forCellReuseIdentifier:@"FNConnectionsSettingMembersCell"];
    [self.tbvSetting registerClass:[FNConnectionSettingExitCell class] forCellReuseIdentifier:@"FNConnectionSettingExitCell"];
    [self.tbvSetting registerClass:[FNConnectionsSwitchCell class] forCellReuseIdentifier:@"FNConnectionsSwitchCell"];
    
    if (@available(iOS 11.0, *)) {
        self.tbvSetting.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.tbvSetting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topNaivgationbar.mas_bottom);
        make.right.left.bottom.equalTo(@0);
    }];
}

#pragma mark - Networking
- (void) requestSetting {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    if ([_target isEqualToString:@"qun"]) {
        params[@"qid"] = _uid;
    }
    [SVProgressHUD show];
    @weakify(self);
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection_set&ctrl=set_index" respondType:(ResponseTypeModel) modelType:@"FNConnectionsSettingModel" success:^(id respondsObject) {
        @strongify(self);
        self.model = respondsObject;
        [self.leftBtn setTitle:self.model.name forState:UIControlStateNormal];
        [self.leftBtn sizeToFit];
        self.leftBtn.size = CGSizeMake(self.leftBtn.width+10, 30);
        [self.tbvSetting reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:YES isCache:NO];
}

- (void)requestDeleteQun {
    if ([_target isEqualToString:@"qun"]) {
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"qid": _uid}];
        @weakify(self);
        [SVProgressHUD show];
        [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection_set&ctrl=del_qun" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
            @strongify(self);
            [NSNotificationCenter.defaultCenter postNotificationName:@"didChatDelete" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
            [SVProgressHUD dismiss];
        } failure:^(NSString *error) {
            [SVProgressHUD dismiss];
        } isHideTips:NO isCache:NO];
    }
}


- (void)requestSetTop: (BOOL)isTop {
    if ([_target isEqualToString:@"qun"]) {
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"qid": _uid, @"is_settop": @(isTop)}];
        @weakify(self);
        [SVProgressHUD show];
        [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection_set&ctrl=set_totop" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
            @strongify(self);
            
            self.model.is_settop = isTop ? @"1" : @"0";
            
            [SVProgressHUD dismiss];
        } failure:^(NSString *error) {
            [SVProgressHUD dismiss];
        } isHideTips:NO isCache:NO];
    }
}

#pragma mark - Action
- (void)leftBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FNConnectionsSettingMembersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNConnectionsSettingMembersCell"];
        NSMutableArray *images = [[NSMutableArray alloc] init];
        NSMutableArray *titles = [[NSMutableArray alloc] init];
        for (FNConnectionsGroupModel *model in self.model.list) {
            [images addObject:model.head_img];
            [titles addObject:model.nickname];
        }
        cell.delegate = self;
        [cell setImages:images withTitles:titles isGrouper:[self.model.is_grouper isEqual:@"1"]];
        return cell;
    } else if (indexPath.section == 1) {
        static NSString *ID = @"ProfileCell";
        ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ProfileCell" owner:self options:nil] lastObject];
        }
        if (indexPath.row == 0) {
            cell.leftLbl.text = @"群组名称";
            cell.rightLbl.text = self.model.name;
        } else if (indexPath.row == 1) {
            cell.leftLbl.text = @"群组公告";
            cell.rightLbl.text = self.model.affiche;
        }
        cell.leftLbl.textColor = UIColor.grayColor;
        cell.leftLbl.font = kFONT14;
        cell.rightLbl.textColor = UIColor.grayColor;
        cell.rightLbl.font = kFONT14;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 2) {
        FNConnectionsSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNConnectionsSwitchCell"];
        cell.lblTitle.text = @"置顶群聊";
        [cell.swt setOn:[self.model.is_settop isEqualToString:@"1"]];
        cell.delegate = self;
        return cell;
    } else if (indexPath.section == 3) {
        FNConnectionSettingExitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNConnectionSettingExitCell"];
        if ([self.model.is_grouper isEqualToString:@"1"]) {
            cell.lblTitle.text = @"解散该群";
        } else {
            cell.lblTitle.text = @"删除并退出";
        }
        return cell;
    }
    return [[UITableViewCell alloc] init];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.model == nil)
        return 0;
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1)
        return 2;
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            FNConnectionRemarkController *vc = [[FNConnectionRemarkController alloc] init];
            vc.nickname = _nickname;
            vc.uid = _uid;
            vc.target = _target;
            vc.room = _room;
            
            
            
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 1) {
            FNConnectionsNoticeController *vc = [[FNConnectionsNoticeController alloc] init];
            vc.nickname = _nickname;
            vc.uid = _uid;
            vc.target = _target;
            vc.room = _room;
            vc.notice = self.model.affiche;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else if (indexPath.section == 3) {
        if ([self.model.is_grouper isEqualToString:@"1"]) {
            [self delete];
        } else {
            [self exit];
        }
    }
}

#pragma mark - FNConnectionsSettingMembersCellDelegate
- (void)didMembersClickAt:(NSInteger)index {
    
}
- (void)didAddClick {
    if ([_target isEqualToString:@"qun"]) {
        FNConnectionsCreateGroupsController *vc = [[FNConnectionsCreateGroupsController alloc] init];
        vc.qid = _uid;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)didRemoveClick {
    if ([_target isEqualToString:@"qun"]) {
        FNConnectionsRemoveMembersController *vc = [[FNConnectionsRemoveMembersController alloc] init];
        vc.qid = _uid;
        [self.navigationController pushViewController:vc animated:YES];
    }
        
}

#pragma mark -

/**
 退出并删除
 */
- (void)exit {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:@"删除并退出后将不再接收此群聊信息"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    @weakify(self);
    UIAlertAction* okAction =
    [UIAlertAction actionWithTitle:@"确定"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               @strongify(self);
                               [self requestDeleteQun];
                           }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                         }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}


/**
 解散
 */
- (void)delete {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:@"解散群之后无法恢复，是否确定继续解散群？"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    @weakify(self);
    UIAlertAction* okAction =
    [UIAlertAction actionWithTitle:@"确定"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               @strongify(self);
                               [self requestDeleteQun];
                           }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                         }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - FNConnectionsSwitchCellDelegate
- (void)switchCell:(id)cell didChange:(BOOL)isOn {
    [self requestSetTop:isOn];
}

@end
