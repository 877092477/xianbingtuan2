//
//  FNPullNewDetailController.m
//  THB
//
//  Created by Fnuo-iOS on 2018/5/10.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNPullNewDetailController.h"

@interface FNPullNewDetailController ()

@end

@implementation FNPullNewDetailController{
    NSString *month;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitializeView];
    
    [SVProgressHUD show];
    [FNRequestTool startWithRequests:@[[self apiRequestTop]] withFinishedBlock:^(NSArray *erros) {
        if (self.topModel.count>0) {
            month=self.topModel[0].month;
            NSMutableArray *title=[NSMutableArray new];
            [self.topModel enumerateObjectsUsingBlock:^(PullNewDetailTopModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [title addObject:obj.detail];
            }];
            _slideBar.itemsTitle = title;
            _slideBar.itemColor = FNGlobalTextGrayColor;
            _slideBar.itemSelectedColor = FNMainGobalTextColor;
            _slideBar.sliderColor = FNMainGobalTextColor;
            _slideBar.fontSize=13;
            _slideBar.SelectedfontSize=14;
            
            [self apiRequestList];
        }
    }];
}

-(void)InitializeView{
    UIView *mainView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, JMScreenWidth, JMScreenHeight)];
    mainView.hidden=YES;
    mainView.backgroundColor=FNWhiteColor;
    [self.view addSubview:mainView];
    self.mainView=mainView;
    
    _slideBar = [[FDSlideBar alloc] initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 40)];
    _slideBar.backgroundColor = FNWhiteColor;
    _slideBar.is_middle=NO;
    [self slideBarItemSelected];
    [mainView addSubview:_slideBar];
    
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.backgroundColor=FNHomeBackgroundColor;
    self.jm_tableview.separatorColor=RGB(197, 197, 197);
    self.jm_tableview.showsVerticalScrollIndicator = NO;
    [self.jm_tableview removeEmptyCellRows];
    [mainView addSubview:self.jm_tableview];
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_slideBar.mas_bottom).offset(0);
        make.left.right.bottom.equalTo(@0);
    }];
    
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listModel.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNPullNewDetailCell *cell=[FNPullNewDetailCell cellWithTableView:tableView];
    cell.model=self.listModel[indexPath.section];
    return cell;
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

-(void)slideBarItemSelected{
    [_slideBar slideBarItemSelectedCallback:^(NSUInteger index) {
        month=self.topModel[index].month;
        [self apiRequestList];
    }];
}

#pragma mark - 网络请求
//获取头部
- (FNRequestTool *)apiRequestTop{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=tbkNewApi&ctrl=listHead" respondType:(ResponseTypeArray) modelType:@"PullNewDetailTopModel" success:^(id respondsObject) {
        //
        self.topModel=respondsObject;
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
//获取列表
- (FNRequestTool *)apiRequestList{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"month":month}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=tbkNewApi&ctrl=getOrderDetail" respondType:(ResponseTypeArray) modelType:@"PullNewDetailListModel" success:^(id respondsObject) {
        //
        [SVProgressHUD dismiss];
        self.listModel=respondsObject;
        self.mainView.hidden=NO;
        [self.jm_tableview reloadData];
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}

@end
