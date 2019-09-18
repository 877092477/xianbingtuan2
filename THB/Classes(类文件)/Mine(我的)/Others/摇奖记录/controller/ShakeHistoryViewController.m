//
//  ShakeHistoryViewController.m
//  THB
//
//  Created by zhongxueyu on 16/5/7.
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

#import "ShakeHistoryViewController.h"
#import "ShakeHistoryCell.h"
#import "ShakehistoryModel.h"
@interface ShakeHistoryViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *xy_TableView;

/** 列表数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ShakeHistoryViewController
@synthesize xy_TableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    if ([UserisShake kr_isNotEmpty]) {
    self.title = self.title?self.title:@"摇奖记录";
//    }else{
//        self.title = @"签到记录";
//    }
    [self loadProductListMethod];
}
#pragma 获取数据
-(void)loadProductListMethod
{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"token":UserAccessToken                          }];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_home_shakerecord successBlock:^(id responseBody) {
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
            if (tempArray.count>0) {
                for (int i = 0; i < tempArray.count; i ++) {
                    ShakehistoryModel *model = [ShakehistoryModel mj_objectWithKeyValues:tempArray[i]];
                    [self.dataArray addObject:model];
                    
                }
                [SVProgressHUD dismiss];
            }else{
                [FNTipsView showTips:@"请先去摇一摇才会有记录哦~"];
                
            }
            [self initTableView];
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

-(void)initTableView
{
    xy_TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight-XYNavBarHeigth) style:UITableViewStylePlain];
    xy_TableView.dataSource=self;
    xy_TableView.delegate=self;
    xy_TableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:xy_TableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray.count>0) {
        return self.dataArray.count;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identfire=@"Cell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([ShakeHistoryCell class]) bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identfire];
        nibsRegistered = YES;
    }
    ShakeHistoryCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
    
    cell.leftLable.textColor = RED;

    if (self.dataArray>0) {
        ShakehistoryModel *model = self.dataArray[indexPath.row];
        cell.leftLable.text = model.info;
        cell.rightLable.text = model.time;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
