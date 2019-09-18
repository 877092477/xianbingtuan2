//
//  FNUpgradeGoodsNController.m
//  THB
//
//  Created by Jimmy on 2018/9/25.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpgradeGoodsNController.h"

//Controller
#import "firstVersionSearchViewController.h"
#import "FNUpGoodsDetailsNController.h"
#import "FNShareViewController.h"

//model
#import "XYTitleModel.h"

//view
#import "FNUpgradegoodsNCell.h"
#import "QJSlideButtonView.h"
#import "FNUpgradeRecommendNCell.h"
#import "FNUpHeadImgNCell.h"

@interface FNUpgradeGoodsNController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,FNUpgradeRecommendNCellDelegate>
/** 分类 **/
@property(nonatomic,strong)NSMutableArray *categoryNameArray;
@property(nonatomic,strong)NSMutableArray *categoryIdArray;
/** 搜索按钮 **/
@property(nonatomic,strong)UIButton * searchBtn;

/** 数据 **/
@property(nonatomic,strong)NSMutableArray *dataArray;

/** 标题s */
@property (nonatomic,strong) QJSlideButtonView *titleView;

@property (nonatomic,strong)UIView *voryView;
/** 分类id */
@property (nonatomic,strong)NSString *cidString;
/** 关键词 */
@property (nonatomic,strong)NSString *keywordString;

/** 推荐数据 **/
@property(nonatomic,strong)NSDictionary *recommendDic;
@property(nonatomic,strong)NSDictionary *preferentialDic;
//提示
@property (nonatomic, strong)UIView *nodataView;

@end

@implementation FNUpgradeGoodsNController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:YES animated:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self apiRequestProduct];
    //self.title=@"升级";
    [self navigationView];
    [self GoodsTableView];
}

#pragma mark - navigationView
-(void)navigationView{
    NSString *nameString=@"升级"; 
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [backBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    [backBtn setTitleColor:FNBlackColor forState:UIControlStateNormal];
    [backBtn setTitle:[NSString stringWithFormat:@"  %@",nameString] forState:UIControlStateNormal];
    backBtn.titleLabel.font = kFONT14;
    [backBtn sizeToFit];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    _searchBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn.backgroundColor=RGB(241, 241, 241);
    [_searchBtn sizeToFit];
    _searchBtn.titleLabel.font = kFONT11;
    
    [_searchBtn setImage:IMAGE(@"partner_search") forState:UIControlStateNormal];
    [_searchBtn setTitleColor:FNGlobalTextGrayColor forState:UIControlStateNormal];
    [_searchBtn setTitle:@"粘贴宝贝标题搜索" forState:UIControlStateNormal];
    [_searchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView =_searchBtn;
    _searchBtn.sd_layout
    .heightIs(self.navigationItem.titleView.height).leftSpaceToView(backBtn, 20).widthIs(JMScreenWidth-backBtn.size.width*2);
    _searchBtn.imageView.sd_layout
    .rightSpaceToView(_searchBtn.titleLabel, 10).heightIs(_searchBtn.imageView.height).widthIs(_searchBtn.imageView.width);
    _searchBtn.cornerRadius=self.navigationItem.titleView.height/2;
    
}
#pragma mark - 返回
-(void)backBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)searchBtnAction{
    firstVersionSearchViewController *vc = [[firstVersionSearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 单元
-(void)GoodsTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight;
    self.jm_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, tableHeight) style:UITableViewStylePlain];
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.alpha=0;
    [self.view addSubview:self.jm_tableview];
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.estimatedRowHeight = 0;
        self.jm_tableview.estimatedSectionFooterHeight = 0;
        self.jm_tableview.estimatedSectionHeaderHeight= 0;
        self.jm_tableview.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }
    @WeakObj(self);
    self.jm_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.jm_page = 1;
        [selfWeak apiRequestCommodity];
    }];
    self.jm_tableview.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        selfWeak.jm_page += 1;
        [selfWeak apiRequestCommodity];
    }];
    _voryView=[[UIView alloc]init];
    _voryView.frame=CGRectMake(0, 0, FNDeviceWidth, 40);
    self.nodataView=[UIView new];
    self.nodataView.hidden=YES;
    self.nodataView.frame=CGRectMake(FNDeviceWidth/2-50, FNDeviceHeight/2+80, 100, 100);
    [self.jm_tableview addSubview:self.nodataView];
    UIImageView *dataimage=[UIImageView new];
    dataimage.frame=CGRectMake(4, 0, 92, 60);
    dataimage.image=IMAGE(@"order_nodata");
    [self.nodataView addSubview:dataimage];
    UILabel *datalable=[UILabel new];
    datalable.frame=CGRectMake(0, 70, 100, 20);
    datalable.textColor=[UIColor grayColor];
    datalable.textAlignment=NSTextAlignmentCenter;
    datalable.text=@"暂无数据";
    datalable.font=[UIFont fontWithDevice:12];
    [self.nodataView addSubview:datalable];
}
#pragma mark - UITableViewDataSource delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==2){
        return self.dataArray.count;
    }
    else if(section==0){
        FNrecommendNMode *model=[FNrecommendNMode mj_objectWithKeyValues:self.recommendDic];
        if(model.goods.count==0){
            return 0;
        }else{
            return 1;
        }
    }
    else{
         return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==2){
        return 40;
    }else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        FNrecommendNMode *model=[FNrecommendNMode mj_objectWithKeyValues:self.recommendDic];
        if(model.goods.count==0){
          return 0;
        }else{
         return 260;
        }
    } if(indexPath.section==1){
        return 50;
    }
    else{
        return 120;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        FNUpgradeRecommendNCell* cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendNCell"];
        if (cell == nil) {
            cell = [[FNUpgradeRecommendNCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecommendNCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.recommend=self.recommendDic;
        cell.delegate=self;
        return cell;
    }
    if(indexPath.section==1){
        FNUpHeadImgNCell* cell = [tableView dequeueReusableCellWithIdentifier:@"HeadImgCell"];
        if (cell == nil) {
            cell = [[FNUpHeadImgNCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HeadImgCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.preferential=self.preferentialDic;
        return cell;
    }else{
        FNUpgradegoodsNCell* cell = [tableView dequeueReusableCellWithIdentifier:@"goodscell"];
        if (cell == nil) {
            cell = [[FNUpgradegoodsNCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"goodscell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model=self.dataArray[indexPath.row];
        cell.delegate = self;
        return cell;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(section==2){
        return _voryView;
    }
    else{
        return [UIView new];
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==2){
        FNRecommendNMode* model=self.dataArray[indexPath.row];
        FNUpGoodsDetailsNController *detailsVC=[[FNUpGoodsDetailsNController alloc]init];
        detailsVC.DetailsID=model.id;
        [self.navigationController pushViewController:detailsVC animated:YES];
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    if (conY>= 265 ) {
        [self.titleView removeFromSuperview];
        [self.view addSubview:self.titleView];
        [self.view bringSubviewToFront:self.titleView];
    }else{
        if (![self.voryView.subviews containsObject:self.titleView]) {
            [self.voryView addSubview:self.titleView];
        }
    }
}
#pragma mark - FNUpgradeRecommendNCellDelegate  选择商品

-(void)selectRecommendNAction:(id)model{
    FNRecommendNMode* itemmodel=[FNRecommendNMode mj_objectWithKeyValues:model];
    FNUpGoodsDetailsNController *detailsVC=[[FNUpGoodsDetailsNController alloc]init];
    detailsVC.DetailsID=itemmodel.id;
    [self.navigationController pushViewController:detailsVC animated:YES];
}
#pragma mark - //升级界面其他数据
- (FNRequestTool *)apiRequestProduct{
    
    [SVProgressHUD show];
    @WeakObj(self);
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=update_goods&ctrl=index" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"升级购list:%@",respondsObject);
        NSDictionary *commitsList =  respondsObject [DataKey];
        NSString *searchString=commitsList[@"search_str"];
        NSString *topleftString=commitsList[@"topleft_str"];
        [selfWeak.searchBtn setTitle:searchString forState:UIControlStateNormal];
        self.title=topleftString;
        NSDictionary *Typedic =  commitsList [@"preferential"];
        NSArray *TypeArr = Typedic[@"cate"];
        selfWeak.recommendDic=commitsList[@"recommend"];
        selfWeak.preferentialDic=commitsList[@"preferential"];
        NSMutableArray *titles = [NSMutableArray array];
        for( NSDictionary *dic in TypeArr){
            [selfWeak.categoryNameArray  addObject:dic[@"catename"]];
            [selfWeak.categoryIdArray  addObject:dic[@"id"]];
            [titles addObject:[XYTitleModel mj_objectWithKeyValues:dic]];
        }
        if (titles.count > 0) {
            selfWeak.titleView = [[QJSlideButtonView alloc] initWithcontroller:self TitleArr:_categoryNameArray];
            @WeakObj(self);
            selfWeak.titleView.sbBlock = ^(NSInteger index){
                XYLog(@"index is %ld",(long)index);
                [SVProgressHUD show];
                self.jm_page= 1;
                selfWeak.cidString=selfWeak.categoryIdArray[index];
                //selfWeak.keywordString=selfWeak.categoryNameArray[index];
                [selfWeak apiRequestCommodity];
            };
            [selfWeak.voryView addSubview:selfWeak.titleView];
        }
        selfWeak.cidString=TypeArr[0][@"id"];
        //selfWeak.keywordString=TypeArr[0][@"catename"];
        [selfWeak apiRequestCommodity];
        [selfWeak.jm_tableview reloadData];
        [UIView animateWithDuration:0.2 animations:^{
            [SVProgressHUD dismiss];
        }];
    } failure:^(NSString *error) {
        [self apiRequestProduct]; 
    } isHideTips:NO];
}

#pragma mark - //获取商品列表
- (FNRequestTool *)apiRequestCommodity{
    [self.jm_tableview.mj_header endRefreshing];
    [self.jm_tableview.mj_footer endRefreshing];
    @WeakObj(self);
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token,@"cid":selfWeak.cidString,@"keyword":@"",@"p":@(self.jm_page)}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=update_goods&ctrl=goods_list" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"商品list:%@",respondsObject);
        NSArray *commitsList =  respondsObject [DataKey];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dictDict in commitsList) {
            [arrM addObject:[FNRecommendNMode mj_objectWithKeyValues:dictDict]];
        }
        if (arrM.count == 0) {
            [selfWeak.jm_tableview.mj_footer endRefreshingWithNoMoreData];
        }
        if (self.jm_page == 1) {
            if (arrM.count == 0) {
                [selfWeak.dataArray removeAllObjects];
                [FNTipsView showTips:@"没有数据"];
                selfWeak.nodataView.hidden=NO;
            }else{
                selfWeak.nodataView.hidden=YES;
            }
            [selfWeak.dataArray removeAllObjects];
            selfWeak.dataArray = arrM;
            
        } else {
            [selfWeak.dataArray addObjectsFromArray:arrM];
        }
        [selfWeak.jm_tableview reloadData];
        [UIView animateWithDuration:0.2 animations:^{
            self.jm_tableview.alpha=1.0;
            [SVProgressHUD dismiss];
        }];
    } failure:^(NSString *error) {
        if(selfWeak.dataArray.count==0){
            [self apiRequestCommodity];
        }
        
    } isHideTips:NO];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)categoryIdArray {
    if (!_categoryIdArray) {
        _categoryIdArray = [NSMutableArray array];
    }
    return _categoryIdArray;
}

- (NSMutableArray *)categoryNameArray {
    if (!_categoryNameArray) {
        _categoryNameArray = [NSMutableArray array];
    }
    return _categoryNameArray;
}

#pragma mark - FNUpgradegoodsNCellDelegate

- (void)cellDidShareClick: (FNUpgradegoodsNCell*)cell {
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    FNRecommendNMode* model=self.dataArray[indexPath.row];
    
    FNShareViewController *share = [[FNShareViewController alloc] init];
    share.SkipUIIdentifier = model.SkipUIIdentifier;
    share.fnuo_id = model.id;
    [self.navigationController pushViewController:share animated:YES];
}

@end
