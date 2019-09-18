//
//  FNUpAddressNeController.m
//  THB
//
//  Created by Jimmy on 2018/9/28.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpAddressNeController.h"

//controller
#import "FNAddLocationNeController.h"

//view
#import "FNUpAddressItemNeCell.h"
#import "FNCustomeNavigationBar.h"

//model
#import "FNUpAddressNeModel.h"


@interface FNUpAddressNeController ()<UITableViewDelegate,UITableViewDataSource,FNUpAddressItemNeCellDelegate,FNAddLocationNeControllerDelegate>

@property (nonatomic, strong)UIButton *addButton;

@property (nonatomic, strong)NSMutableArray *dataArr;

@property (nonatomic,strong)FNCustomeNavigationBar *cuNaivgationbar;

@end

@implementation FNUpAddressNeController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
 
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO]; 
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"收货地址";
    //[self navRightButton];
    [self setUpCustomizedNaviBar];
    [self AddressMessageTableView];
    [self apiRequestSiteList];
}
-(void)navRightButton{
    self.addButton= [UIButton buttonWithType:UIButtonTypeCustom];
    self.addButton.titleLabel.font=kFONT12;
    [self.addButton sizeToFit];
    [self.addButton setTitle:@"添加新地址" forState:UIControlStateNormal];
    [self.addButton setTitleColor:[UIColor blackColor] forState:0];
    [self.addButton addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:self.addButton];
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.addButton];
}
#pragma mark - NavBar 导航栏
- (void)setUpCustomizedNaviBar{
    
    _cuNaivgationbar = [FNCustomeNavigationBar customeNavigationBarWithTitle:@"收货地址"];
    _cuNaivgationbar.titleLabel.textColor=[UIColor blackColor];
    _cuNaivgationbar.backgroundColor = [UIColor whiteColor];
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [backBtn sizeToFit];
    backBtn.size = CGSizeMake(backBtn.width+10, backBtn.height+10);
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    _cuNaivgationbar.leftButton = backBtn;
    self.addButton= [UIButton buttonWithType:UIButtonTypeCustom];
    self.addButton.titleLabel.font=kFONT12;
    [self.addButton sizeToFit];
    self.addButton.size = CGSizeMake(80, 30);
    [self.addButton setTitle:@"添加新地址" forState:UIControlStateNormal];
    [self.addButton setTitleColor:[UIColor blackColor] forState:0];
    [self.addButton addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    _cuNaivgationbar.rightButton = self.addButton;
    [self.view addSubview:_cuNaivgationbar];
    
}
-(void)backBtnAction{
    if(self.notchoice==1){
        if ([self.delegate respondsToSelector:@selector(selectChoiceofLocationAction:)] ) {
            [self.delegate selectChoiceofLocationAction:nil];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)addButtonAction{
    FNAddLocationNeController *vc=[[FNAddLocationNeController alloc]init];
    vc.editBo=2;
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 单元
-(void)AddressMessageTableView{
     CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight-1;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.jm_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+1, FNDeviceWidth, tableHeight) style:UITableViewStylePlain];
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.rowHeight=115;
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.estimatedRowHeight = 0;
        self.jm_tableview.estimatedSectionFooterHeight = 0;
        self.jm_tableview.estimatedSectionHeaderHeight= 0;
        self.jm_tableview.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:self.jm_tableview];
    self.jm_tableview.backgroundColor=FNColor(240,240,240);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FNUpAddressItemNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MessageNeCell"];
    if (cell == nil) {
        cell = [[FNUpAddressItemNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageNeCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model=[FNUpAddressNeModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
    cell.delegate=self;
    cell.indexPath=indexPath;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.notchoice==1){
        if ([self.delegate respondsToSelector:@selector(selectChoiceofLocationAction:)] ) {
            [self.delegate selectChoiceofLocationAction:self.dataArr[indexPath.row]];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        FNAddLocationNeController *vc=[[FNAddLocationNeController alloc]init];
        vc.delegate=self;
        vc.editBo=1;
        vc.editModel=[FNUpAddressNeModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark -  FNUpAddressItemNeCellDelegate   编辑 
- (void)InAddressItemCopyreaderAction:(NSIndexPath *)indexPath{
    FNAddLocationNeController *vc=[[FNAddLocationNeController alloc]init];
    vc.delegate=self;
    vc.editBo=1;
    vc.editModel=[FNUpAddressNeModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -  FNAddLocationNeControllerDelegate 保存或者新建
-(void)selectPreserveMaybeNewAction{
    [self.dataArr removeAllObjects];
    [self apiRequestSiteList];
    [UIView animateWithDuration:0.2 animations:^{
        [self.jm_tableview reloadData];
    }];
}
#pragma mark - //获取地址列表
- (FNRequestTool *)apiRequestSiteList{
    //[self.jm_tableview.mj_header endRefreshing];
    //[self.jm_tableview.mj_footer endRefreshing];
    @WeakObj(self);
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=update_goods&ctrl=address" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"收货地址:%@",respondsObject);
        NSArray *siteArr =  respondsObject [DataKey];
        NSMutableArray *arrM =[NSMutableArray array];
        for (NSDictionary *dic in siteArr) {
            //[arrM addObject:[FNUpAddressNeModel mj_objectWithKeyValues:dic]];
            [arrM addObject:dic];
        }
        selfWeak.dataArr=arrM;
        [selfWeak.jm_tableview reloadData];
        [UIView animateWithDuration:0.2 animations:^{
            [SVProgressHUD dismiss];
        }];
       
    } failure:^(NSString *error) {
        [self apiRequestSiteList];
    } isHideTips:NO];
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
