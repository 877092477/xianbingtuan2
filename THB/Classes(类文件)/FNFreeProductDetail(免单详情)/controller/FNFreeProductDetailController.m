//
//  FNFreeProductDetailController.m
//  THBTests
//
//  Created by Weller on 2018/12/19.
//  Copyright © 2018年 方诺科技. All rights reserved.
// 后续商品详情

#import "FNFreeProductDetailController.h"
#import "FNFreeProductDetailHeaderView.h"
#import "FNFreeProductDetailRuleCell.h"
#import "FNFreeProductDetailModel.h"
#import "FNCustomeNavigationBar.h"
#import "FNFreeProductDetailAlertView.h"
#import "FNshareMakeDeView.h"
#import "FNBaseSettingModel.h"
#import <SDCycleScrollView.h>
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface FNFreeProductDetailController () <UITableViewDelegate, UITableViewDataSource, FNFreeProductDetailRuleCellDelegate, FNFreeProductDetailAlertViewDelegate, FNshareMakeDeViewDelegate,SDCycleScrollViewDelegate>

@property (nonatomic, strong) FNFreeProductDetailHeaderView *headerView;

@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) FNCustomeNavigationBar *navigationView;

@property (nonatomic, strong) FNFreeProductDetailModel* model;

@property (nonatomic, strong) FNFreeProductDetailAlertView *alertView;

@end

@implementation FNFreeProductDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self configAlert];
    
    if (_fnuo_id) {
        [self apiRequestDetail: _fnuo_id];
    } else {
        NSLog(@"请先传入fnuoid");
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
    
- (void)dealloc {
    
    [_headerView invalidate];
}

- (void)configUI {
    
    [self configBottomView];
    
    NSLog(@"wujianliang32323");
    
    self.headerView = [[FNFreeProductDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenWidth + 92)];

    self.jm_tableview = [[UITableView alloc] init];
    [self.view addSubview:self.jm_tableview];
    self.jm_tableview.backgroundColor = FNHomeBackgroundColor;
    self.jm_tableview.tableHeaderView = self.headerView;
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jm_tableview.delegate = self;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.rowHeight = UITableViewAutomaticDimension;
    self.jm_tableview.estimatedRowHeight = 800;
    self.jm_tableview.estimatedSectionFooterHeight = 0;
    self.jm_tableview.estimatedSectionHeaderHeight = 0;
    [self.jm_tableview registerClass:[FNFreeProductDetailRuleCell class] forCellReuseIdentifier:@"FNFreeProductDetailRuleCell"];
    
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.bottom.equalTo(_footerView.mas_top);
    }];
    
    [self.view addSubview:self.navigationView];
    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:self.navigationView.height];
    
}

#pragma mark--图片点击代理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    XYLog(@"++++++++%@",self.model.imgArr);
    
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
    // 弹出相册时显示的第一张图片是点击的图片
    browser.currentPhotoIndex = index;
    NSMutableArray *photos = [NSMutableArray array];
    NSArray *imgs = self.model.imgArr;
    [imgs enumerateObjectsUsingBlock:^(id  _Nonnull sobj, NSUInteger idx, BOOL * _Nonnull stop) {
        MJPhoto *mjPhoto = [[MJPhoto alloc] init];
        
        mjPhoto.url = [NSURL URLWithString:sobj];
        
//        mjPhoto.srcImageView = imageview;
        
        [photos addObject:mjPhoto];
    }];
    
    // 设置所有的图片。photos是一个包含所有图片的数组。
    browser.photos = photos;
    [browser show];
    
}

- (void)configBottomView {
    self.footerView = [[UIView alloc] init];
    self.leftButton = [[UIButton alloc] init];
    self.rightButton = [[UIButton alloc] init];
    
    [self.view addSubview:self.footerView];
    [self.footerView addSubview:self.leftButton];
    [self.footerView addSubview:self.rightButton];
    
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.mas_equalTo(isIphoneX ? 66 : 46);
    }];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(@0);
        make.width.equalTo(self.footerView).multipliedBy(0.66);
    }];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(@0);
        make.left.equalTo(self.leftButton.mas_right);
    }];
    
    self.leftButton.backgroundColor = RGB(227, 176, 100);
    self.rightButton.backgroundColor = RED;
    
    [self.leftButton setTitleColor:FNWhiteColor forState:UIControlStateNormal];
    self.leftButton.titleLabel.font = kFONT12;
    [self.rightButton setTitleColor:FNWhiteColor forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = kFONT12;
    [self.rightButton addTarget:self action:@selector(rightButtonAction)];
}

- (void)configAlert {
    _alertView = [[FNFreeProductDetailAlertView alloc] init];
    [self.view addSubview:_alertView];
    [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    _alertView.delegate = self;
}

- (FNCustomeNavigationBar *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
        
        UIButton* backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backButton setImage:IMAGE(@"return") forState:(UIControlStateNormal)];
        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
        backButton.size = CGSizeMake(backButton.width+_jmsize_10, backButton.height+10);
        
        _navigationView.leftButton = backButton;
    }
    return _navigationView;
}


#pragma UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FNFreeProductDetailRuleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNFreeProductDetailRuleCell"];
    if (self.model) {
        [cell setInviteText:self.model.invite_str Title:self.model.act_str];
        NSMutableArray *titles = [[NSMutableArray alloc] init];
        NSMutableArray *rules = [[NSMutableArray alloc] init];
        for (FNFreeProductDetailRuleModel *rule in self.model.act_rule) {
            [titles addObject:rule.title];
            [rules addObject:rule.content];
        }
        [cell setTitles:titles rules:rules];
        cell.delegate = self;
    }
    return cell;
}

#pragma mark - Action
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonAction {
    if (self.model) {
        [_alertView show:self.model.tip_str backgroundClosable:NO];
    }
}

#pragma mark - FNFreeProductDetailRuleCellDelegate
- (void)didInviteButtonClick: (FNFreeProductDetailRuleCell*)cell {
    if (self.model) {
        FNshareMakeDeView *alertView =[FNshareMakeDeView popoverView];
        alertView.itemWidth=80;
        alertView.currentH=185;
        alertView.backgroundColor=[UIColor clearColor];
        alertView.delegate=self;
        alertView.showShade = YES; // 显示阴影背景
        [alertView showWithActions];
    }
}

#pragma mark - FNFreeProductDetailAlertViewDelegate
- (void)didAcceptClick:(FNFreeProductDetailAlertView *)view {
    if ([NSString isEmpty:UserAccessToken]) {
        [self gologin];
        return;
    }
    if (self.model) {
        [self apiRequestAccept:self.model.fnuo_id];
    }
}

- (void)didLeaveClick:(FNFreeProductDetailAlertView *)view {
    [view dismiss];
}

#pragma mark - Network

- (FNRequestTool *)apiRequestDetail: (NSString*)ID{
    @weakify(self);
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey: UserAccessToken, @"fnuo_id": ID}];
    if ([self.act_type kr_isNotEmpty]) {
        params[@"act_type"] = self.act_type;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appMiandan&ctrl=goods_detail" respondType:(ResponseTypeModel) modelType:@"FNFreeProductDetailModel" success:^(id respondsObject) {
        @strongify(self);
        self.model = respondsObject;
        [self.jm_tableview reloadData];
        
        [self.headerView setImages:self.model.imgArr];
        /**后续加上**/
        self.headerView.cycleScrollView.delegate = self;

        self.headerView.lblCount.text = self.model.stock;
        
        self.headerView.lblPrice.text = [NSString stringWithFormat:@"¥%@", self.model.goods_price];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@", self.model.goods_cost_price] attributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
        self.headerView.lblOriginalPrice.attributedText = string;
        self.headerView.lblDesc.text = self.model.str;
        self.headerView.lblTitle.text = self.model.goods_title;
        [self.headerView setTime:[NSDate dateWithTimeIntervalSince1970:self.model.end_time.doubleValue]];
        
        self.leftButton.backgroundColor = [UIColor colorWithHexString:self.model.btn_left_str];
        [self.leftButton setTitle:self.model.btn_str forState:UIControlStateNormal];
        
        if (!self.model.is_rob.boolValue) {
            [self.rightButton setTitle:@"尚未开抢" forState:UIControlStateNormal];
            [self.rightButton setEnabled:NO];
        } else if (self.model.end_time.doubleValue < [NSDate dateWithTimeIntervalSinceNow:0].timeIntervalSince1970) {
            [self.leftButton setTitle:@"活动已结束" forState:UIControlStateNormal];
            [self.rightButton setEnabled:NO];
        } else {
            [self.leftButton setTitle:self.model.btn_str forState:UIControlStateNormal];
            [self.rightButton setEnabled:YES];
        }
        
        self.rightButton.backgroundColor = [UIColor colorWithHexString:self.model.btn_right_str];
        [self.rightButton setTitle:self.model.btn_str1 forState:UIControlStateNormal];
        
    } failure:^(NSString *error) {
        @strongify(self);
        [self apiRequestDetail:ID];
    } isHideTips:NO];
}

- (FNRequestTool *)apiRequestAccept: (NSString*)ID{
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey: UserAccessToken, @"fnuo_id": ID}];
    if ([self.act_type kr_isNotEmpty]) {
        params[@"act_type"] = self.act_type;
    }
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appMiandan&ctrl=insertGoods" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        [self.alertView dismiss];
        
        NSDictionary *dict = [respondsObject objectForKey:DataKey];
        
        if ([self.model.SkipUIIdentifier isEqualToString:@"buy_taobao"]) {
            
            NSString *tb_pid = [dict objectForKey:@"tb_pid"];
            NSString *APP_adzoneId = [dict objectForKey:@"APP_adzoneId"];
            NSString *APP_alliance_appkey = [dict objectForKey:@"APP_alliance_appkey"];
            [self openDetailWithID:self.model.fnuo_id withPid:tb_pid adzoneId:APP_adzoneId APP_alliance_appkey:APP_alliance_appkey];
        } else if ([self.model.SkipUIIdentifier isEqualToString:@"buy_jingdong"]) {
            [self goToJDProductDetailsWithModel: self.model];
        } else if ([self.model.SkipUIIdentifier isEqualToString:@"buy_pinduoduo"]) {
            [self goWebDetailWithWebType:@"0" URL:self.model.yhq_url];
        } else if ([self.model.SkipUIIdentifier isEqualToString:@"pub_wph_goods"]) {
            if ([self.model.yhq_url hasPrefix:@"vipshop://"]) {
                BOOL wphCheck=[[UIApplication sharedApplication] canOpenURL:URL(self.model.yhq_url)];
                if (wphCheck) {
                    [[UIApplication sharedApplication] openURL:URL(self.model.yhq_url)];
                } else {
                    [self goWebDetailWithWebType:@"0" URL:self.model.h5_url];
                }
            } else {
                [self goWebDetailWithWebType:@"0" URL:self.model.yhq_url];
            }
        }
        
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:NO];
}
    
#pragma mark - FNshareMakeDeViewDelegate
-(void)shareBtnClick:(NSInteger)sender{
    if (self.model) {
        NSString *shareText = self.model.share_title;             //分享内嵌文字
        NSString *shareUrl = [NSString encodeToPercentEscapeString:self.model.share_url];
        UMSocialPlatformType type=UMSocialPlatformType_WechatSession;
        if (sender==0) {
            type=UMSocialPlatformType_WechatSession;
        }else if (sender==1) {
            type=UMSocialPlatformType_WechatTimeLine;
        }else if (sender==2) {
            type=UMSocialPlatformType_QQ;
        }
        else if (sender==3) {
            type=UMSocialPlatformType_Sina;
        }
        else if (sender==4) {
            type=UMSocialPlatformType_Qzone;
        }
        [self umengShareWithURL:shareUrl image:self.model.share_img shareTitle:shareText andInfo:self.model.share_content withType:type];
    }
}


@end
