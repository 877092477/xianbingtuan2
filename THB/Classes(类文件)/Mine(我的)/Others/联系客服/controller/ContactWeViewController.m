//
//  ContactWeViewController.m
//  THB
//
//  Created by zhongxueyu on 16/3/31.
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

#import "ContactWeViewController.h"
#import "MyWebViewController.h"
@interface ContactWeViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) UITableView *xy_TableView;
@end

@implementation ContactWeViewController
@synthesize xy_TableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.title?self.title:@"联系客服";
    //初始化表格
    [self initTableView];
}

-(void)initTableView
{
    xy_TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight) style:UITableViewStyleGrouped];
    xy_TableView.dataSource=self;
    xy_TableView.delegate=self;
    //    xy_TableView.separatorStyle=UITableViewCellSeparatorStyleSingleLineEtched;
    [self.view addSubview:xy_TableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identfire=@"Cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
    
    if (!cell) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identfire];
    }
    
    NSArray *imgArray = [NSArray arrayWithObjects:@"zxkf",@"lxdh", nil];
    NSString *phone = [NSString stringWithFormat:@"联系电话: %@",[FNBaseSettingModel settingInstance].ContactPhone];
    NSArray *lableArray = [NSArray arrayWithObjects:@"在线客服",phone, nil];
    cell.imageView.image = IMAGE(imgArray[indexPath.row]);
    cell.textLabel.text = lableArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {

            NSString *urlString = [FNBaseSettingModel settingInstance].ContactUs;
            [self goWebDetailWithWebType:@"0" URL:urlString];
//            MyWebViewController *vc = [[MyWebViewController alloc]init];
//            vc.hidesBottomBarWhenPushed = YES;
//            vc.openUrl = urlString;
//            [self.navigationController pushViewController:vc animated:NO];
        }
        else if (indexPath.row == 1) {
            XYLog(@"12");
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"客服电话"
                                                            message:[NSString stringWithFormat:@"%@\n工作时间内拨打(周一至周六 8:00-18:00)",[FNBaseSettingModel settingInstance].ContactPhone]
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"拨出",nil];
            //设置标题与信息，通常在使用frame初始化AlertView时使用
            [alert show];
        }
    }
    
}

#pragma marks -- UIAlertViewDelegate --
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    XYLog(@"index is %ld",(long)buttonIndex);
    if (buttonIndex == 1) {
        NSString *str = [NSString stringWithFormat:@"tel:%@",[FNBaseSettingModel settingInstance].ContactPhone];
        
        UIWebView *callWebView = [[UIWebView alloc]init];
        
        [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        
        [self.view addSubview:callWebView];//也可以不加到页面上
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
