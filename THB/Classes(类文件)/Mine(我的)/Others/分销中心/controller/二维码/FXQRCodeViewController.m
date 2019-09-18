//
//  FXQRCodeViewController.m
//  THB
//
//  Created by zhongxueyu on 16/8/11.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "FXQRCodeViewController.h"
#import "CodeFootCell.h"
#import "CodeMidCell.h"
#import "CodeHeaderCell.h"
#import "FXCodeModel.h"
@interface FXQRCodeViewController ()<UITableViewDataSource,UITableViewDelegate,FXCellClickDelegate>
/** TableView */
@property (nonatomic,strong) UITableView *xy_TableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic,strong) FXCodeModel *model;

@end

@implementation FXQRCodeViewController
@synthesize xy_TableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = self.title?self.title:@"我的二维码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //初始化表格
    [self initTableView];
    if (IOS11) {
        xy_TableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self getFXInfoMethod];
    [self getShareInfoMethod];
}

-(void)getShareInfoMethod{
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:[NSString GetParamDic] url:_api_mine_getShareInfo successBlock:^(id responseBody) {
        
        NSDictionary *dict = responseBody;
        [SVProgressHUD dismiss];
        XYLog(@"getShareInforesponseBody2 is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            NSArray *tempArray = [dict objectForKey:XYData];
            NSString *word;
            if ([[tempArray valueForKey:@"word"]kr_isNotEmpty]) {
                word = [tempArray valueForKey:@"word"];
            }else{
                word = @" ";
            }
            
            NSString *img;
            if ([[tempArray valueForKey:@"img"]kr_isNotEmpty]) {
                img = [tempArray valueForKey:@"img"];
            }else{
                img = @" ";
            }
            
            
            [[NSUserDefaults standardUserDefaults] setValue:img forKey:XYShareImg];
            [[NSUserDefaults standardUserDefaults] setValue:word forKey:XYShareWord];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    } failureBlock:^(NSString *error) {
        [XYNetworkAPI cancelAllRequest];
    }];
    
}


#pragma mark - 网络请求
-(void)getFXInfoMethod{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"token":UserAccessToken}];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_threesale_fxqrcode successBlock:^(id responseBody) {
        [xy_TableView.mj_header endRefreshing];
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody2 is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            
            [self.dataArray removeAllObjects];
            NSArray *tempArray = [dict objectForKey:XYData];
            NSError *error = nil;
            NSData * JSONData = [NSJSONSerialization dataWithJSONObject:tempArray options:kNilOptions error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
            
            XYLog(@"MyjsonData is %@",jsonString);
            
            _model = [FXCodeModel mj_objectWithKeyValues:[dict objectForKey:XYData]];
            [self.dataArray addObject:_model];
            [SVProgressHUD dismiss];
            [self.view addSubview:xy_TableView];
            [xy_TableView reloadData];
            
        }else{
            
            
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        
        
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
        [xy_TableView.mj_footer endRefreshing];
    }];
}

#pragma tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        return 110;
    }else if (indexPath.row == 1){
        return 382;
    }
    else if (indexPath.row == 2){
        return 106;
    }
    return 0;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CodeHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CodeHeaderCell"];
        cell.urlLabel.text = _model.tg_url;
        cell.url = _model.tg_url;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1){
        CodeMidCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CodeMidCell"];
        [cell.codeImg setUrlImg:_model.qrcode_url];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else if (indexPath.row == 2){
        CodeFootCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CodeFootCell"];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    return nil;
    
}

#pragma marl - UI
-(void)initTableView
{
    xy_TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight-64) style:UITableViewStylePlain];
    xy_TableView.dataSource=self;
    xy_TableView.delegate=self;
    xy_TableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets =NO;//高度可以到导航栏
    [xy_TableView registerNib:[UINib nibWithNibName:@"CodeFootCell" bundle:nil] forCellReuseIdentifier:@"CodeFootCell"];
    [xy_TableView registerNib:[UINib nibWithNibName:@"CodeMidCell" bundle:nil] forCellReuseIdentifier:@"CodeMidCell"];
    [xy_TableView registerNib:[UINib nibWithNibName:@"CodeHeaderCell" bundle:nil] forCellReuseIdentifier:@"CodeHeaderCell"];

    
    
    
}

//Delegate
-(void)OnTapFXMenuView:(NSInteger)index{
    

    NSString *shareText = UserShareWord?UserShareWord:[NSString stringWithFormat:@"欢迎成为%@的分销商",[FNBaseSettingModel settingInstance].AppDisplayName];             //分享内嵌文字
    NSString *shareUrl = [NSString encodeToPercentEscapeString:_model.tg_url];


    if (index == 0) { //微信
        [self umengShareWithURL:shareUrl image:UserShareImg shareTitle:nil andInfo:shareText withType:(UMSocialPlatformType_WechatSession)];
    }else if(index == 1){ // 朋友圈
          [self umengShareWithURL:shareUrl image:UserShareImg shareTitle:nil andInfo:shareText withType:(UMSocialPlatformType_WechatTimeLine)];
    }else if(index == 2){ // 新浪微博
        [self umengShareWithURL:shareUrl image:UserShareImg shareTitle:nil andInfo:shareText withType:(UMSocialPlatformType_Sina)];
    }else if(index == 3){ // QQ
          [self umengShareWithURL:shareUrl image:UserShareImg shareTitle:nil andInfo:shareText withType:(UMSocialPlatformType_QQ)];

    }
    


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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
