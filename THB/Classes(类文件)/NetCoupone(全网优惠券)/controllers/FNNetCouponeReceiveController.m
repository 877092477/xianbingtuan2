//
//  FNNetCouponeReceiveController.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/10.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNetCouponeReceiveController.h"
#import "FNNetCouponeExchangeModel.h"
#import "FNNetCouponeHeaderView.h"
#import "FNNetCouponeReceiveCell.h"
#import "FNNetCouponeReceiveModel.h"
#import "FNNetCouponeAlertModel.h"
#import "FNNetCouponeReceiveAlertView.h"
#import "FNMyNetCouponeController.h"
#import "FNMyNetCouponeRechargeController.h"

@interface FNNetCouponeReceiveController()<UITableViewDelegate, UITableViewDataSource, FNNetCouponeReceiveCellDelegate>

@property (nonatomic, strong) UIButton *rightbutton;
@property (nonatomic, strong) FNNetCouponeHeaderView *headerView;

@property (nonatomic, strong) UIImageView *imgBg;

@property (nonatomic, strong) FNNetCouponeExchangeModel *model;
@property (nonatomic, strong) NSMutableArray<FNNetCouponeReceiveModel*> *coupones;

@property (nonatomic, strong) FNNetCouponeReceiveAlertView *alertView;

@end

@implementation FNNetCouponeReceiveController

- (FNNetCouponeReceiveAlertView*) alertView {
    if (_alertView == nil) {
        _alertView = [[FNNetCouponeReceiveAlertView alloc] init];
        _alertView.hidden = YES;
        [self.view addSubview: _alertView];
        [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    return _alertView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _coupones = [[NSMutableArray alloc] init];
    [self setupNav];
    [self configUI];
    [self requestMain];
    self.jm_page = 1;
    [self requestCoupons];
}
-(void)setupNav{
    _rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    //    [rightbutton setTitle:@"搜索" forState:UIControlStateNormal];
    //    [rightbutton setImage:IMAGE(@"live_coupone_nav_button_search") forState:(UIControlStateNormal)];
    _rightbutton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [_rightbutton setTitleColor:RGB(27, 27, 27) forState:UIControlStateNormal];
    [_rightbutton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_rightbutton];
    
}

- (BOOL)needLogin {
    return YES;
}

- (void)configUI {
    _headerView = [[FNNetCouponeHeaderView alloc] initWithFrame: CGRectMake(0, 0, XYScreenWidth, 380)];
    [_headerView.btnExcharge addTarget:self action:@selector(onExchargeClick) forControlEvents:UIControlEventTouchUpInside];
    
    _imgBg = [[UIImageView alloc] init];
    [self.view addSubview:_imgBg];
    [_imgBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(self.view.frame.size.height);
    }];
    
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.backgroundColor=UIColor.clearColor;
    self.jm_tableview.showsVerticalScrollIndicator = NO;
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jm_tableview.tableHeaderView = _headerView;
    
    [self.jm_tableview registerClass:[FNNetCouponeReceiveCell class] forCellReuseIdentifier:@"FNNetCouponeReceiveCell"];
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.right.bottom.equalTo(@0);
    }];
    
//    if (@available(iOS 11.0, *)) {
//        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
}

- (void)updateView {
    self.title = self.model.top_title;
    [self.rightbutton setTitle: self.model.top_right_btn forState: UIControlStateNormal];
    [self.rightbutton sizeToFit];
    
    self.view.backgroundColor = [UIColor colorWithHexString: self.model.bjcolor];
    [self.imgBg sd_setImageWithURL: URL(self.model.bjimg)];
    [self.headerView.imgCoupone sd_setImageWithURL: URL(self.model.coupon_bjimg)];
    @weakify(self)
    [self.headerView.btnRule sd_setBackgroundImageWithURL:URL(self.model.rule_img) forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (image) {
            [self.headerView.btnRule mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(22 * image.size.width / image.size.height);
            }];
        }
    }];
    
    [self.headerView.btnExcharge sd_setBackgroundImageWithURL:URL(self.model.btn_img) forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (image) {
            [self.headerView.btnExcharge mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(35 * image.size.width / image.size.height);
            }];
        }
    }];
    
    self.headerView.lblCoupone.text = self.model.str;
    self.headerView.lblCoupone.textColor = [UIColor colorWithHexString:self.model.str_color];
    
    self.headerView.lblMoney.text = self.model.coupon_money;
    self.headerView.lblMoney.textColor = [UIColor colorWithHexString:self.model.coupon_money_color];
    
    self.headerView.lblCouponeDesc.text = self.model.lj_str;
    self.headerView.lblCouponeDesc.textColor = [UIColor colorWithHexString:self.model.lj_str_color];
    
    [self.headerView.imgInfo sd_setImageWithURL: URL(self.model.info_img) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (image) {
            [self.headerView.imgInfo mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(15 * image.size.width / image.size.height);
            }];
        }
    }];
    
    self.headerView.lblInfo.text = self.model.info_str;
    self.headerView.lblInfo.textColor = [UIColor colorWithHexString:self.model.info_color];
    self.headerView.vInfo.backgroundColor = [UIColor colorWithHexString:self.model.info_bjcolor];
}


- (void)rightBtnAction {
    FNMyNetCouponeController *vc = [[FNMyNetCouponeController alloc] init];
    [self.navigationController pushViewController:vc animated: YES];
}

- (void)onExchargeClick {
    FNMyNetCouponeRechargeController *vc = [[FNMyNetCouponeRechargeController alloc] init];
    [self.navigationController pushViewController:vc animated: YES];
}

#pragma mark - Networking
- (void)requestMain{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=coupon_exchange&ctrl=rob_index" respondType:(ResponseTypeModel) modelType:@"FNNetCouponeExchangeModel" success:^(id respondsObject) {
        @strongify(self)
        self.model = respondsObject;
        [self updateView];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:YES];
    
}

- (void)requestCoupons{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"p": @(self.jm_page)}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=coupon_exchange&ctrl=coupon_index" respondType:(ResponseTypeArray) modelType:@"FNNetCouponeReceiveModel" success:^(id respondsObject) {
        @strongify(self)
        
        NSArray *array = respondsObject;
        if (self.jm_page == 1) {
            [self.coupones removeAllObjects];
        }
        self.jm_page ++;
        [self.coupones addObjectsFromArray: array];
        for (FNNetCouponeReceiveModel *model in array) {
            model.time = [NSDate dateWithTimeIntervalSinceNow:-model.djs.doubleValue];
        }
        if (array.count == 0) {
            self.jm_tableview.mj_footer = nil;
        } else {
            self.jm_tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestCoupons)];
        }
        
        [self.jm_tableview reloadData];
        [self.jm_tableview.mj_footer endRefreshing];
        
    } failure:^(NSString *error) {
        
        [self.jm_tableview.mj_footer endRefreshing];
    } isHideTips:YES];
    
}

- (void)requestReceive: (NSString*)ID{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"id": ID}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=coupon_exchange&ctrl=receive_doing" respondType:(ResponseTypeModel) modelType:@"FNNetCouponeAlertModel" success:^(id respondsObject) {
        @strongify(self)
        
        [self.alertView show: respondsObject];
        @weakify(self);
        self.alertView.btnClickedAction = ^{
            @strongify(self)
            UIPasteboard *pab = [UIPasteboard generalPasteboard];
            [pab setString:((FNNetCouponeAlertModel*)respondsObject).code];
            if (pab == nil) {
                [FNTipsView showTips:@"复制失败"];
            }else{
                [FNTipsView showTips:@"复制成功"];
            }
        };
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO];
    
}

- (void)requestRemind: (FNNetCouponeReceiveModel*)model{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"id": model.id}];
    [SVProgressHUD show];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=coupon_exchange&ctrl=add_remind" respondType:(ResponseTypeModel) modelType:@"FNNetCouponeAlertModel" success:^(id respondsObject) {
        @strongify(self)
        [SVProgressHUD dismiss];
        
        model.is_set_remind = @"1";
        [self.jm_tableview reloadData];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO];
    
}

- (void)requestCancleRemind: (FNNetCouponeReceiveModel*)model{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"id": model.id}];
    [SVProgressHUD show];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=coupon_exchange&ctrl=cancel_remind" respondType:(ResponseTypeModel) modelType:@"FNNetCouponeAlertModel" success:^(id respondsObject) {
        @strongify(self)
        [SVProgressHUD dismiss];
        model.is_set_remind = @"0";
        
        [self.jm_tableview reloadData];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.coupones.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNNetCouponeReceiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNNetCouponeReceiveCell"];
    FNNetCouponeReceiveModel *model = _coupones[indexPath.row];

    cell.lblPrice.text = model.price;
    cell.lblTitle.text = model.title;
    cell.lblDesc.text = model.info;
    
    [cell.prgCount setProgress:model.jindu.doubleValue / 100 animated:NO];;
    cell.lblCount.text = [NSString stringWithFormat: @"%@%%", model.jindu];
    
    [cell.imgRight sd_setImageWithURL:URL(model.bjimg)];
    cell.lblRightTitle.text = @"距开抢还有";
    
    cell.lblReceive.text = model.str;
    cell.lblReceive.textColor = [UIColor colorWithHexString:model.str_color];
    cell.delegate = self;
    
    NSString *remindImg = [model.is_set_remind isEqualToString:@"1"] ? model.remind_img1 : model.remind_img;
    @weakify(cell)
    [cell.btnRemind sd_setBackgroundImageWithURL:URL(remindImg) forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(cell)
        if (image) {
            [cell.btnRemind mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(20 * image.size.width / image.size.height);
            }];
        }
    }];
    
    NSDate *startTime = [NSDate dateWithTimeIntervalSince1970:model.start_time.doubleValue];
    [cell setTime: startTime];
    
    return cell;
    
    
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FNNetCouponeReceiveModel *model = _coupones[indexPath.row];
    if ([model.SkipUIIdentifier isEqualToString: @"tobuy"]) {
        [self requestReceive: model.id];
    } else if ([model.SkipUIIdentifier isEqualToString: @"tobuy"]) {
        
    }
}
#pragma mark - ScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_imgBg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(-scrollView.contentOffset.y));
    }];
}

#pragma mark - FNNetCouponeReceiveCellDelegate
- (void)didRemindClick: (FNNetCouponeReceiveCell*) cell {
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    FNNetCouponeReceiveModel *model = _coupones[indexPath.row];
    
    
    if ([model.is_set_remind isEqualToString:@"0"]) {
        [self requestRemind: model];
    } else {
        [self requestCancleRemind: model];
    }
}
@end
