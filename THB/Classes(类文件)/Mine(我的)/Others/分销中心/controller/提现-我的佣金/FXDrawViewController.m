//
//  FXDrawViewController.m
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

#import "FXDrawViewController.h"
#import "SizeMacros.h"
#import "TXMyCommisionCell.h"
#import "CommissionOModel.h"

@interface FXDrawViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>

/** TableView */
@property (nonatomic,strong) UITableView *xy_TableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic,strong) CommissionOModel *model;

/** 上方佣金来源按钮 */
@property (nonatomic,strong) UIButton *phoneBtn;

/** 上方提现记录按钮 */
@property (nonatomic,strong) UIButton *emailBtn;

/** 头部视图 **/
@property (nonatomic,strong) UIView *headBg;

/** 下划线 **/
@property (nonatomic,strong) UIView *line;

@property (nonatomic,strong) UIWebView *webView;

/** 页数 */
@property (nonatomic, assign) int page;


@end

@implementation FXDrawViewController
@synthesize xy_TableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的佣金";
    self.view.backgroundColor = [UIColor whiteColor];
    self.page = 1;
    [self initHeadView];

    //初始化表格
    [self initTableView];
    if (IOS11) {
        xy_TableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self getFXInfoMethod];
    __weak __typeof(self)weakSelf = self;
    xy_TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        weakSelf.page = 1;
        [weakSelf getFXInfoMethod];
    }];

    //WebView
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headBg.frame), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    self.webView.backgroundColor = [UIColor clearColor];

    NSString *urlString = [NSString stringWithFormat:@"%@%@%@",IP,_api_mine_DrawHistory,UserAccessToken];

    NSURL *webUrl = [NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:webUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    __unsafe_unretained UIWebView *webView = self.webView;
    webView.delegate = self;
    
    [webView loadRequest:request];
    __unsafe_unretained UIScrollView *scrollView = self.webView.scrollView;
    [self.view addSubview:self.webView];
    self.webView.hidden = YES;
    scrollView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [webView reload];
    }];
    

}


#pragma mark - 网络请求
-(void)getFXInfoMethod{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"token":UserAccessToken}];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_threesale_yjly successBlock:^(id responseBody) {
        [xy_TableView.mj_header endRefreshing];
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody2 is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            NSArray *tempArray = [dict objectForKey:XYData];
            
            if (tempArray.count>0) {
                for (int i = 0; i < tempArray.count; i ++) {
                    CommissionOModel *model = [CommissionOModel mj_objectWithKeyValues:tempArray[i]];
                    [self.dataArray addObject:model];
                    
                }
                if (tempArray.count <10) {
                    xy_TableView.mj_footer = nil;
                }else {
                    if (!xy_TableView.mj_footer) {
                        __weak __typeof(self)weakSelf = self;
                        xy_TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                            // 进入刷新状态后会自动调用这个block
                            weakSelf.page += 1;
                            [weakSelf getFXInfoMethod];
                        }];
                        
                    }
                }
                [self.view addSubview:xy_TableView];
                
                [xy_TableView reloadData];
                [SVProgressHUD dismiss];
            }else{
                
                if(self.page >1 ){
                    [FNTipsView showTips:XYMsg];
                    [xy_TableView.mj_footer endRefreshingWithNoMoreData];
                }else if ( self.page == 1){
                    [FNTipsView showTips:@"暂时还没有佣金明细"];
                }
            }
            
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
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.dataArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 60;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    TXMyCommisionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TXMyCommisionCell"];
    cell.model = self.dataArray[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    return cell;
}


#pragma marl - UI
-(void)initTableView
{
    xy_TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headBg.frame), XYScreenWidth, XYScreenHeight-CGRectGetHeight(_headBg.frame)-64) style:UITableViewStyleGrouped];
    xy_TableView.dataSource=self;
    xy_TableView.delegate=self;
    xy_TableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets =NO;//高度可以到导航栏
    //    xy_TableView.backgroundView = [[UIImageView alloc] initWithImage:IMAGE(@"me_bg1")];
    [xy_TableView registerNib:[UINib nibWithNibName:@"TXMyCommisionCell" bundle:nil] forCellReuseIdentifier:@"TXMyCommisionCell"];
    
    
    
}

//头部
-(void)initHeadView{
    _headBg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, HEADH)];
    [self.view addSubview:_headBg];
    //手机注册按钮
    _phoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth/2, HEADH-3)];
    [_phoneBtn.layer setMasksToBounds:YES];
    [_phoneBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
    [_phoneBtn setBackgroundImage:IMAGE(@"logon_btn1") forState:UIControlStateNormal];
    _phoneBtn.titleLabel.font = kFONT13;
    _phoneBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_phoneBtn setBackgroundColor:[UIColor whiteColor]];
    [_phoneBtn setTitle:@"佣金来源" forState:UIControlStateNormal];
    _phoneBtn.tag = 1;
    [_phoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_phoneBtn setTitleColor:RED forState:UIControlStateSelected];
    [_phoneBtn addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    _phoneBtn.selected = YES;
    //邮箱注册按钮
    _emailBtn = [[UIButton alloc]initWithFrame:CGRectMake(XYScreenWidth/2, 0, XYScreenWidth/2, HEADH-3)];
    [_emailBtn.layer setMasksToBounds:YES];
    [_emailBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
    _emailBtn.titleLabel.font = kFONT13;
    [_emailBtn setBackgroundColor:[UIColor whiteColor]];
    [_emailBtn setBackgroundImage:IMAGE(@"logon_btn1") forState:UIControlStateNormal];
    [_emailBtn setTitle:@"提现记录" forState:UIControlStateNormal];
    _emailBtn.tag = 2;
    [_emailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_emailBtn setTitleColor:RED forState:UIControlStateSelected];
    [_emailBtn addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    _line = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_phoneBtn.frame), CGRectGetWidth(_phoneBtn.frame), 3)];
    _line.backgroundColor = RED;
    [_headBg addSubview:_line];
    [_headBg addSubview:_phoneBtn];
    [_headBg addSubview:_emailBtn];
    
}

-(void)clickBtnMethod:(UIButton *)sender
{
    
    NSInteger tag = sender.tag;
    if (tag == 1)
    {
        
        
        // 执行动画
        if (!_phoneBtn.selected) {
            xy_TableView.alpha = 0.f;
            [UIView animateWithDuration:IMGDuration animations:^{
                _line.frame = CGRectMake(0,CGRectGetMaxY(_phoneBtn.frame), CGRectGetWidth(_phoneBtn.frame), 3);
                xy_TableView.alpha = 1.f;
                xy_TableView.hidden = NO;
                self.webView.hidden = YES;
                _phoneBtn.selected = YES;
                _emailBtn.selected = NO;
            }];
        }
        
    }else if (tag == 2)
    {
        
        
        // 执行动画
        if (!_emailBtn.selected) {
            self.webView.alpha = 0.f;
            [UIView animateWithDuration:IMGDuration animations:^{
                _line.frame = CGRectMake(XYScreenWidth/2,CGRectGetMaxY(_phoneBtn.frame), CGRectGetWidth(_phoneBtn.frame), 3);
                self.webView.alpha = 1.f;
                xy_TableView.hidden = YES;
                self.webView.hidden = NO;
                _phoneBtn.selected = NO;
                _emailBtn.selected = YES;
            }];
        }
        
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


#pragma WebView
-(void)webViewDidStartLoad:(UIWebView *)webView{
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [SVProgressHUD show];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.webView.scrollView.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    //    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    //    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    hud.mode = MBProgressHUDModeIndeterminate;
    //    hud.labelText = @"加载失败，请重新刷新页面";
    //    [hud hide:YES afterDelay:2];
    //    [self.view addSubview:hud];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webViewDidFinishLoad is %@",webView);
    [self.webView.scrollView.mj_header endRefreshing];
    //获取标题
//    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [SVProgressHUD dismiss];
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
