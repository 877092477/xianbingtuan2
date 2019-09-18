//
//  FNteamPullNewController.m
//  嗨如意
//
//  Created by Fnuo-iOS on 2018/5/10.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNteamPullNewController.h"

@interface FNteamPullNewController ()

@end

@implementation FNteamPullNewController

-(FNteamPullNewHeaderView *)header{
    if (_header==nil) {
        _header=[[FNteamPullNewHeaderView alloc]initWithFrame:CGRectMake(0, 0, JMScreenWidth, 200)];
        _header.backgroundColor=FNMainGobalControlsColor;
    }
    return _header;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的团队";
    
    [self InitTableView];
    
    [SVProgressHUD show];
    [self apiRequestPage];
}

#pragma mark - 加载Table
-(void)InitTableView{
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.jm_tableview.hidden=YES;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.backgroundColor=FNHomeBackgroundColor;
    self.jm_tableview.separatorColor=RGB(197, 197, 197);
    self.jm_tableview.showsVerticalScrollIndicator = NO;
    [self.jm_tableview removeEmptyCellRows];
    self.jm_tableview.tableHeaderView=self.header;
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(@0);
    }];
    
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.list.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNteamPullNewCell *cell=[FNteamPullNewCell cellWithTableView:tableView];
    [cell.NumBtn setImage:IMAGE(@"") forState:UIControlStateNormal];
    [cell.NumBtn setTitle:@"" forState:UIControlStateNormal];
    if (indexPath.row==0) {
        [cell.NumBtn setImage:IMAGE(@"team_1") forState:UIControlStateNormal];
    }else if (indexPath.row==1) {
        [cell.NumBtn setImage:IMAGE(@"team_2") forState:UIControlStateNormal];
    }else if (indexPath.row==2) {
        [cell.NumBtn setImage:IMAGE(@"team_3") forState:UIControlStateNormal];
    }else{
        [cell.NumBtn setTitle:[NSString stringWithFormat:@"%ld",indexPath.row+1] forState:UIControlStateNormal];
    }
    cell.model=self.model.list[indexPath.row];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([self.model.sum_peo integerValue]>0) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, JMScreenWidth, 60)];
        UIView *ziview=[[UIView alloc]initWithFrame:CGRectMake(0, 10, JMScreenWidth, 50)];
        ziview.backgroundColor=FNWhiteColor;
        [view addSubview:ziview];
        UIView *line1=[UIView new];
        line1.backgroundColor=RGB(197, 197, 197);
        [ziview addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(@0);
            make.height.equalTo(@0.5);
        }];
        UIView *line2=[UIView new];
        line2.backgroundColor=RGB(197, 197, 197);
        [ziview addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(@0);
            make.height.equalTo(@0.5);
        }];
        
        UIImageView *imageView=[[UIImageView alloc]initWithImage:IMAGE(@"team_ten")];
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        [ziview addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.left.equalTo(@30);
            make.right.equalTo(@-30);
        }];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, JMScreenWidth, 40)];
        label.textColor=RGB(95, 56, 15);
        label.font=kFONT16;
        label.text=[NSString stringWithFormat:@"团队排名(前%@名)",self.model.sum_peo];
        [ziview addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(ziview.mas_centerX);
            make.centerY.equalTo(ziview.mas_centerY);
        }];
        return view;
    }else{
        return [UIView new];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.model.list.count>0) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, JMScreenWidth, 40)];
        label.textColor=FNGlobalTextGrayColor;
        label.font=kFONT13;
        label.textAlignment=NSTextAlignmentCenter;
        label.text=@"到底了哦~";
        return label;
    }else{
        return [UIView new];
    }
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}

#pragma mark - 网络请求
//获取页面数据
- (FNRequestTool *)apiRequestPage{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"img_size":@"2"}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=tbkNewApi&ctrl=getNewUserNum" respondType:(ResponseTypeModel) modelType:@"teamPullNewModel" success:^(id respondsObject) {
        //
        [SVProgressHUD dismiss];
        self.jm_tableview.hidden=NO;
        self.model=respondsObject;
        self.header.model=self.model;
        [self.jm_tableview reloadData];
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}

@end
