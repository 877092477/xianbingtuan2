//
//  OrderListViewController.m
//  THB
//
//  Created by zhongxueyu on 16/4/6.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有 2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "OrderListViewController.h"
#import "OrderListCell.h"
#import "OrderModel.h"
#import "FNUpOrderItemNeCell.h"
#import "FNUpOrderDetailsNeController.h"
//#import "FNUpgradeOrderitemNModel.h"
@interface OrderListViewController ()<UITableViewDataSource,UITableViewDelegate,FNUpOrderItemNeCellDelegate>
{
}
/** TableView */
@property (nonatomic,strong) UITableView *xy_TableView;
/** 列表数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 页数 */
@property (nonatomic, assign) int page;

@end
@implementation OrderListViewController
@synthesize xy_TableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *tmp = [FNBaseSettingModel settingInstance].appopentaobao_onoff?:@"0";
    NSString *IsForceH5 = [NSString stringWithFormat:@"%@",tmp];
    
    if (IsForceH5) {
        [self initBaiChuanSDKMethod];
    }
    
    self.page = 1;
    [self initTableView];
    [self loadDateMethod];
    
    if (self.type.integerValue==1) {
        self.updateOrderStatus = YES;
        [self initWebViewMethod];
    }

    //添加下拉刷新
    __weak __typeof(self)weakSelf = self;
    xy_TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        //获取Banner数据
        if (self.type.integerValue==1) {
            self.updateOrderStatus = YES;
            [self initWebViewMethod];
        }
        weakSelf.page = 1;
        [weakSelf loadDateMethod];
        
    }];
    if (self.navigationController) {
        // 导航条上面高度
        //        CGFloat navBarH = 64;
        
        // 查看自己标题滚动视图设置的高度，我这里设置为3
//                CGFloat titleScrollViewH = 35;
        
        xy_TableView.contentInset = UIEdgeInsetsMake( 0, 0, XYNavBarHeigth, 0);
    }
}
-(void)initBaiChuanSDKMethod{
    NSString* pid= nil;
    //    if ([ProfileModel profileInstance].is_sqdl.boolValue) {
    //        pid = [ProfileModel profileInstance].tg_pid;
    //    }else{
    pid = [FNBaseSettingModel settingInstance].TaoKePid;
    //    }
    // 外部使用只能用Release环境
    [[AlibcTradeSDK sharedInstance] setEnv:AlibcEnvironmentRelease];
    
    // 百川平台基础SDK初始化，加载并初始化各个业务能力插件
    //    NSString *appKey = @"23082328";
    
    [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
        
    } failure:^(NSError *error) {
        
    }];
    
    // 开发阶段打开日志开关，方便排查错误信息
    [[AlibcTradeSDK sharedInstance] setDebugLogOpen:NO];
#warning 测试跟单

    // 配置全局的淘客参数
    AlibcTradeTaokeParams *taokeParams = [[AlibcTradeTaokeParams alloc] init];
taokeParams.pid = [FNBaseSettingModel settingInstance].TaoKePid;
    taokeParams.adzoneId =  [FNBaseSettingModel settingInstance].APP_adzoneId;
    taokeParams.extParams = @{@"taokeAppkey": [FNBaseSettingModel settingInstance].APP_alliance_appkey?:@""};
    taokeParams.unionId = nil;
    taokeParams.subPid = nil;
    [[AlibcTradeSDK sharedInstance] setTaokeParams:taokeParams];
    
    // 设置全局配置，是否强制使用h5
    [[AlibcTradeSDK sharedInstance] setIsForceH5:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    NSString *tmp = [FNBaseSettingModel settingInstance].appopentaobao_onoff?:@"0";
    NSString *IsForceH5 = [NSString stringWithFormat:@"%@",tmp];
    
    if (IsForceH5) {
        [self initBaiChuanSDKMethod];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    NSString *tmp = [FNBaseSettingModel settingInstance].appopentaobao_onoff?:@"0";
    NSString *IsForceH5 = [NSString stringWithFormat:@"%@",tmp];
    
    if (IsForceH5) {
        [self initBaiChuanSDKMethod:NO];

    }

}
-(void)postFootPrintMethpd:(NSString *)goodsId{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"goodsid":goodsId,
                                                                                 @"token":UserAccessToken}];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_mine_addfootmark successBlock:^(id responseBody) {
        
        
        
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
    }];
}
#pragma - mark 获取数据
-(void)loadDateMethod{
    NSString *APIUrl;
    NSMutableDictionary *params= [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                  @"token":UserAccessToken,
                                      @"p":[NSNumber numberWithInt:self.page],
                                  @"statu":self.statu
                                   }];
    if (self.type.integerValue==3) {
        APIUrl=@"mod=appapi&act=appOrder03&ctrl=getJdFloOrder";
    }else if (self.type.integerValue==4) {
        APIUrl=@"mod=appapi&act=appOrder02&ctrl=getpddOrder";
    }else if (self.type.integerValue==5) {
        APIUrl=@"mod=appapi&act=update_order&ctrl=order_list";
    }else{
        APIUrl=_api_mine_getOrder;
        params[@"o_type"] = self.type;
    }
    params[SignKey] = [NSString getSignStringWithDictionary:params];
    [[XYNetworkAPI sharedManager] postResultWithParameter:params url:APIUrl successBlock:^(id responseBody) {
        [xy_TableView.mj_header endRefreshing];
        [xy_TableView.mj_footer endRefreshing];
        NSDictionary *dict = responseBody;
        [SVProgressHUD dismiss];
        XYLog(@"responseBody2 is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            NSArray *tempArray = [dict objectForKey:XYData];
            XYLog(@"tempArray.count is %lu",(unsigned long)tempArray.count);
            if (tempArray.count>0) {
                if(self.type.integerValue==5){
                    for (int i = 0; i < tempArray.count; i ++) {
                        FNUpgradeOrderitemNeHModel *model = [FNUpgradeOrderitemNeHModel mj_objectWithKeyValues:tempArray[i]];
                        [self.dataArray addObject:model];
                    }
                }else{
                    for (int i = 0; i < tempArray.count; i ++) {
                        OrderModel *model = [OrderModel mj_objectWithKeyValues:tempArray[i]];
                        [self.dataArray addObject:model];
                    }
                }
                
                if (tempArray.count <10 ) {
                    self.xy_TableView.mj_footer = nil;
                }else {
                    if (!self.xy_TableView.mj_footer) {
                        __weak __typeof(self)weakSelf = self;
                        self.xy_TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                            // 进入刷新状态后会自动调用这个block
                            weakSelf.page += 1;
                            [weakSelf loadDateMethod];
                        }];                        
                    }
                }
            }else{
                if(self.page >1 ){
                    [self.xy_TableView.mj_footer endRefreshingWithNoMoreData];
                }
                if (self.page == 1) {
                    xy_TableView.emptyDataSetSource = self;
                    xy_TableView.emptyDataSetDelegate = self;
                }
            }
        }else{
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        xy_TableView.alpha = 1;
        [xy_TableView reloadData];
    } failureBlock:^(NSString *error) {
        xy_TableView.alpha = 1;
        [xy_TableView reloadData];
        [XYNetworkAPI cancelAllRequest];
        [xy_TableView.mj_header endRefreshing];
    }];
    
}
#pragma - mark TableView
-(void)initTableView
{
    xy_TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight-XYNavBarHeigth-35) style:UITableViewStyleGrouped];
    xy_TableView.dataSource=self;
    xy_TableView.delegate=self;
    xy_TableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    xy_TableView.showsHorizontalScrollIndicator = NO;
    xy_TableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:xy_TableView];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    /*if(self.type.integerValue==5){
        return 5;
    }else{
        if (self.dataArray.count>0) {
            return self.dataArray.count;
        }
        return 0;
    }*/
    if (self.dataArray.count>0) {
        return self.dataArray.count;
    }
    return 0;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 165;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.type.integerValue==5){
        FNUpOrderItemNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UpOrderItemNeCell"];
        if (cell == nil) {
            cell = [[FNUpOrderItemNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UpOrderItemNeCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.indexPath=indexPath;
        cell.delegate=self;
        cell.model=self.dataArray[indexPath.section];
        return cell;
    }else{
        static NSString *identfire=@"Cell";
        BOOL nibsRegistered = NO;
        if (!nibsRegistered) {
            UINib *nib = [UINib nibWithNibName:NSStringFromClass([OrderListCell class]) bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:identfire];
            nibsRegistered = YES;
        }
        OrderListCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
        cell.Model=self.dataArray[indexPath.section];
        
        if(self.dataArray.count>0){
            OrderModel *model=self.dataArray[indexPath.section];
            NSInteger status = model.choujiang_status.integerValue;
            if (status == 1) {
                cell.tbdImgView.hidden = NO;
                cell.doneImgView.hidden = YES;
                cell.awardImgView.hidden = YES;
                [cell.tbdImgView addSubview:cell.imgLabel];
                cell.imgLabel.numberOfLines = 2;
                cell.imgLabel.textAlignment = NSTextAlignmentCenter;
                [cell.imgLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(5, 5, 5, 5)) excludingEdge:(ALEdgeLeft)];
                [cell.imgLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:cell.tbdImgView withMultiplier:0.7];
            }else if(status == 2){
                cell.tbdImgView.hidden = YES;
                cell.doneImgView.hidden = NO;
                cell.doneImgView.tag = indexPath.section+100;
                cell.awardImgView.hidden = YES;
                [cell.doneImgView addSubview:cell.imgLabel];
                cell.imgLabel.numberOfLines = 1;
                cell.imgLabel.textAlignment = NSTextAlignmentRight;
                [cell.imgLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(5, 5, 5, 5)) excludingEdge:(ALEdgeLeft)];
                [cell.imgLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:cell.doneImgView withMultiplier:0.7];
                @weakify(self);
                [cell.doneImgView addJXTouchWithObject:^(UIImageView* obj) {
                    NSInteger tag = obj.tag-100;
                    @  strongify(self);
                    OrderModel *model2 = self.dataArray[tag];
                    [self goWebDetailWithWebType:@"1" URL:model2.hongbao_url];
                }];
            }else if(status == 3){
                cell.tbdImgView.hidden = YES;
                cell.doneImgView.hidden = YES;
                cell.awardImgView.hidden = NO;
                [cell.awardImgView addSubview:cell.imgLabel];
                cell.imgLabel.numberOfLines = 1;
                cell.imgLabel.textAlignment = NSTextAlignmentRight;
                [cell.imgLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(5, 5, 5, 5)) excludingEdge:(ALEdgeLeft)];
                [cell.imgLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:cell.awardImgView withMultiplier:0.7];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    /*static NSString *identfire=@"Cell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([OrderListCell class]) bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identfire];
        nibsRegistered = YES;
    }
    OrderListCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
    cell.Model=self.dataArray[indexPath.section];
    
    if(self.dataArray.count>0){
        OrderModel *model=self.dataArray[indexPath.section];
        NSInteger status = model.choujiang_status.integerValue;
        if (status == 1) {
            cell.tbdImgView.hidden = NO;
            cell.doneImgView.hidden = YES;
            cell.awardImgView.hidden = YES;
            [cell.tbdImgView addSubview:cell.imgLabel];
            cell.imgLabel.numberOfLines = 2;
            cell.imgLabel.textAlignment = NSTextAlignmentCenter;
            [cell.imgLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(5, 5, 5, 5)) excludingEdge:(ALEdgeLeft)];
            [cell.imgLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:cell.tbdImgView withMultiplier:0.7];
        }else if(status == 2){
            cell.tbdImgView.hidden = YES;
            cell.doneImgView.hidden = NO;
            cell.doneImgView.tag = indexPath.section+100;
            cell.awardImgView.hidden = YES;
            [cell.doneImgView addSubview:cell.imgLabel];
            cell.imgLabel.numberOfLines = 1;
            cell.imgLabel.textAlignment = NSTextAlignmentRight;
            [cell.imgLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(5, 5, 5, 5)) excludingEdge:(ALEdgeLeft)];
            [cell.imgLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:cell.doneImgView withMultiplier:0.7];
            @weakify(self);
            [cell.doneImgView addJXTouchWithObject:^(UIImageView* obj) {
                NSInteger tag = obj.tag-100;
                @  strongify(self);
                OrderModel *model2 = self.dataArray[tag];
                [self goWebDetailWithWebType:@"1" URL:model2.hongbao_url];
            }];
        }else if(status == 3){
            cell.tbdImgView.hidden = YES;
            cell.doneImgView.hidden = YES;
            cell.awardImgView.hidden = NO;
            [cell.awardImgView addSubview:cell.imgLabel];
            cell.imgLabel.numberOfLines = 1;
            cell.imgLabel.textAlignment = NSTextAlignmentRight;
            [cell.imgLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(5, 5, 5, 5)) excludingEdge:(ALEdgeLeft)];
            [cell.imgLabel autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:cell.awardImgView withMultiplier:0.7];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;*/
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XYLog(@"index is %ld",(long)indexPath.section);
    if(self.type.integerValue==5){
        FNUpgradeOrderitemNeHModel *model=self.dataArray[indexPath.section];
        FNUpOrderDetailsNeController*vc=[[FNUpOrderDetailsNeController alloc]init];
        vc.orderID=model.oid;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if (self.dataArray.count>0) {
            OrderModel *model = self.dataArray[indexPath.section];
            //            if(![model.gid isEqualToString:@""]&& model.gid !=nil){
            model.shop_id = @"2";
            model.ID = model.gid;
            if (model.is_qiangguang.boolValue) {
                [FNTipsView showTips:@"商品太火爆了，已被抢光，赶紧看一下其他商品吧〜"];
            }else{
                [self goProductVCWithModel:model];
            }
            
        }
    }
    /*if (self.dataArray.count>0) {
        OrderModel *model = self.dataArray[indexPath.section];
        //            if(![model.gid isEqualToString:@""]&& model.gid !=nil){
        model.shop_id = @"2";
        model.ID = model.gid;
        if (model.is_qiangguang.boolValue) {
            [FNTipsView showTips:@"商品太火爆了，已被抢光，赶紧看一下其他商品吧〜"];
        }else{
            [self goProductVCWithModel:model];
        }
        
    }*/
    
}

#pragma mark - FNUpOrderItemNeCellDelegate  复制订单信息

- (void)InUpOrderCopyInfoAction:(NSIndexPath *)indexPath{
    FNUpgradeOrderitemNeHModel *model=self.dataArray[indexPath.section];
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    NSString *string = model.wl_id;
    [pab setString:string];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -Getter
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
