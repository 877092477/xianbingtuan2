//
//  FNReckoningSetDeController.m
//  THB
//
//  Created by Jimmy on 2018/12/25.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNReckoningSetDeController.h"

//view
#import "FNCustomeNavigationBar.h"
#import "FNreckDeHeaderView.h"
#import "FNreckSetDeCell.h"
#import "ScreeningView.h"
#import "QJSlideButtonView.h"
#import "FNReckChildDeView.h"
#import "FNcalendarPopDeView.h"
//controller
#import "FNReckDetailsSeController.h"
#import "FNstatisticsDeController.h"
//model
#import "FNreckSetDeModel.h"

@interface FNReckoningSetDeController ()<UICollectionViewDelegate,UICollectionViewDataSource,FNReckChildDeViewDegate,FNreckSetDeCellDegate,UISearchBarDelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *classifyArray;//头部分类
@property(nonatomic,strong)NSMutableArray *screenArray;//筛选部分
@property(nonatomic,strong)FNCustomeNavigationBar *topNaivgationbar;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *searcBtn;
@property(nonatomic,strong)QJSlideButtonView *titleView;
@property(nonatomic,strong)UIView *filtrateViewView;
@property(nonatomic,strong)FNReckChildDeView *childView;
@property(nonatomic,strong)UIButton *screenBtn;
//类型
@property(nonatomic,strong)NSString *typeString;
@property(nonatomic,strong)NSString *typeTwo;
@property(nonatomic,strong)NSString *screen_type;
//开始时间
@property(nonatomic,strong)NSString *start_time;
//结束时间
@property(nonatomic,strong)NSString *end_time;
//keyword
@property(nonatomic,strong)NSString *keyword;
@end

@implementation FNReckoningSetDeController

- (BOOL)isFullScreenShow {
    return YES;
}

- (BOOL) needLogin {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO]; 
    if ([NSString isEmpty:UserAccessToken]) {
        [self warnToLogin];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTopNavBar];
    //[self filtrateViewPart];
    [self reckoningSetCollectionview];
    //[self childViewPortion];
    
    if([UserAccessToken kr_isNotEmpty]){
        //头部分类
        [self apiRequestHeaderClassify];
        //筛选1  收入 支出
        [self apiRequestScreenOne];
        //列表
        [self apiRequestReakList];
    }
    
}
#pragma mark - 导航栏view
-(void)setTopNavBar{
    _topNaivgationbar = [FNCustomeNavigationBar customeNavigationBarWithSearchBarFrame:(CGRectMake(80, 27, FNDeviceWidth-80*2, 30)) andPlaceholder:@"搜索您想要的订单"];
    _topNaivgationbar.searchBar.cornerRadius=30/2;
    _topNaivgationbar.searchBar.delegate=self;
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftBtn setTitle:@"账单明细" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font=kFONT14;
    [self.leftBtn sizeToFit];
    self.leftBtn.size = CGSizeMake(self.leftBtn.width+10, self.leftBtn.height+10);
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.leftBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10.0f];
    
    _topNaivgationbar.leftButton = self.leftBtn;
    _topNaivgationbar.searchBar.sd_layout
    .leftSpaceToView(_topNaivgationbar.leftButton, 15).rightSpaceToView(_topNaivgationbar, 15).heightIs(30).centerYEqualToView(_topNaivgationbar.leftButton);
   
    [self.view addSubview:_topNaivgationbar];
    _topNaivgationbar.backgroundColor =[UIColor clearColor];
    [_topNaivgationbar.searchBar setBackgroundColor:RGBA(246, 245, 245,1)];
    _topNaivgationbar.searchBar.backgroundImage = [UIImage createImageWithColor:RGBA(246, 245, 245,1)];
    UITextField *searchField = [_topNaivgationbar.searchBar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor clearColor]];
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:_topNaivgationbar.searchBar.placeholder attributes:
                                          @{NSForegroundColorAttributeName:RGB(200, 200, 200),
                                            NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        searchField.attributedPlaceholder = attrString;
        searchField.clearButtonMode = UITextFieldViewModeNever;
    }
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSFontAttributeName: kFONT12}];
    [_topNaivgationbar.searchBar setImage:IMAGE(@"FJ_slices_img") forSearchBarIcon:UISearchBarIconSearch  state:UIControlStateNormal];
    _topNaivgationbar.searchBar.showsCancelButton=NO;
    self.searcBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.searcBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searcBtn setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
    self.searcBtn.titleLabel.font=kFONT12;
    [self.searcBtn sizeToFit];
    [self.searcBtn addTarget:self action:@selector(searcBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_topNaivgationbar addSubview:self.searcBtn];
    
    self.searcBtn.sd_layout
    .rightSpaceToView(_topNaivgationbar, 30).centerYEqualToView(_topNaivgationbar.searchBar).heightIs(20);
    [self.searcBtn setupAutoSizeWithHorizontalPadding:0 buttonHeight:20];
  
}
#pragma mark -//搜索
-(void)searcBtnAction{
    self.keyword=_topNaivgationbar.searchBar.text;
    if([self.keyword kr_isNotEmpty]){
        self.jm_page = 1;
        [self apiRequestReakList];
        if (self.childView.hidden==NO) {
            self.childView.hidden=YES;
        }
        if (self.screenBtn.selected==YES) {
            self.screenBtn.selected=NO;
        }
    }

    [_topNaivgationbar.searchBar resignFirstResponder];
    //FNstatisticsDeController *vc=[[FNstatisticsDeController alloc]init];
    //vc.understand=YES;
    //[self.navigationController pushViewController:vc animated:YES];

}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.keyword=searchBar.text;
    self.jm_page = 1;
    [self apiRequestReakList];
    [_topNaivgationbar.searchBar resignFirstResponder];
    
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 筛选部分
-(void)filtrateViewPart{
    UIView *filtrateViewView=[[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, 40)];
    filtrateViewView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:filtrateViewView];
    self.filtrateViewView=filtrateViewView;
    
    //NSArray *name=@[@"全部",@"淘宝",@"京东",@"拼多多",@"商城"];
    //NSArray *type=@[@"1",@"2",@"3",@"4",@"5"];
    NSMutableArray *nameArr=[NSMutableArray arrayWithCapacity:0];
    NSMutableArray *typeArr=[NSMutableArray arrayWithCapacity:0];
    if(self.classifyArray.count>0){
        for (FNreckSetCateDeModel *model in self.classifyArray) {
            [nameArr addObject:model.name];
            [typeArr addObject:model.type];
        }
        [self setUpTitle:nameArr idArray:typeArr];
        [filtrateViewView addSubview:_titleView];
    }
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 13, 1, 14)];
    line.backgroundColor=RGB(246, 246, 246);
    [self.filtrateViewView addSubview:line];
    
    UIButton *screenBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    screenBtn.selected=NO;
    [screenBtn setImage:IMAGE(@"FJ_norsj_img") forState:UIControlStateNormal];
    [screenBtn setImage:IMAGE(@"FJ_orsj_img") forState:UIControlStateSelected];
    [screenBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [screenBtn setTitle:@"筛选" forState:UIControlStateSelected];
    [screenBtn setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
    [screenBtn setTitleColor:RGB(255, 90, 0) forState:UIControlStateSelected];
    screenBtn.titleLabel.font=kFONT13;
    
    [screenBtn addTarget:self action:@selector(screenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.filtrateViewView addSubview:screenBtn];
    
    screenBtn.sd_layout
    .centerYEqualToView(self.filtrateViewView).heightIs(30).rightSpaceToView(self.filtrateViewView, 0).widthIs(75);
    [screenBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    self.screenBtn=screenBtn;
    line.sd_layout
    .widthIs(1).heightIs(14).centerYEqualToView(self.filtrateViewView).rightSpaceToView(screenBtn, 0);
    
    [self childViewPortion];
    
    
    
}
-(void)setUpTitle:(NSMutableArray *)array idArray:(NSMutableArray *)idArray
{
    _titleView = [[QJSlideButtonView alloc] initWithcontroller:self TitleArr:array withRoll:1 withTextColor:RGB(255, 90, 0)];
    @WeakObj(self);
    _titleView.sbBlock = ^(NSInteger index){
        //XYLog(@"index is %ld",(long)index);
        //[SVProgressHUD show];
        selfWeak.jm_page = 1;
        FNreckSetCateDeModel *model=selfWeak.classifyArray[index];
        selfWeak.typeString=model.type;
        [selfWeak apiRequestReakList];
        selfWeak.childView.hidden=!selfWeak.childView.hidden;
        if (selfWeak.childView.hidden==NO) {
            selfWeak.childView.hidden=YES;
        }
        if (selfWeak.screenBtn.selected==YES) {
            selfWeak.screenBtn.selected=NO;
        }
    };
    _titleView.sd_layout
    .leftSpaceToView(self.filtrateViewView, 10).widthIs(FNDeviceWidth-76).heightIs(35).bottomSpaceToView(self.filtrateViewView, 0);
}
-(void)screenBtnClick:(UIButton *)btn{
    btn.selected=!btn.selected;
    if (btn.selected==YES) {
        self.childView.hidden=NO;
        [self.childView showOneView];
    }else{
        [self.childView hideViewAction];
    }
}
#pragma mark - FNReckChildDeViewDegate 筛选
// 确定条件
- (void)inConditionConfirmClick:(NSArray*)arr withStart:(NSString*)startdate withOver:(NSString*)overdate{
    self.screenBtn.selected=NO;
    NSMutableArray *joiArr=[NSMutableArray arrayWithCapacity:0];
    for (FNreckSetScreenDeModel *model in arr) {
        [model.list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNreckScreenItemModel *model=[FNreckScreenItemModel mj_objectWithKeyValues:obj];
            if(model.state==1){
                [joiArr addObject:model.screen_type];
            }
        }];
    }
    if(joiArr.count>0){
        [self.screenBtn setImage:IMAGE(@"FJ_XSOG_img") forState:UIControlStateNormal];
        [self.screenBtn setTitleColor:RGB(255, 90, 0) forState:UIControlStateNormal];
    }else{
        [self.screenBtn setImage:IMAGE(@"FJ_norsj_img") forState:UIControlStateNormal];
        [self.screenBtn setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
    }
   
    if(joiArr.count==0 &&![startdate kr_isNotEmpty] &&![overdate kr_isNotEmpty] ){
        return;
    }
    XYLog(@"开始=:%@结束=:%@",startdate,overdate);
    self.start_time=startdate;
    self.end_time=overdate;
    XYLog(@"joiArr=:%@",joiArr);
    if(joiArr.count>0){
        self.screen_type= [joiArr componentsJoinedByString:@","];
    }
    self.jm_page = 1;
    [self apiRequestReakList];
}
//刷新类型
-(void)inChildTypeRefresh:(NSString*)type{
    if ([type kr_isNotEmpty]) {
        XYLog(@"刷新类型=:%@",type);
        if(![type isEqualToString:self.typeTwo]){
            self.typeTwo=type;
           [self apiRequestScreenTwo];
        }
    }
    else{
        self.typeTwo=@"";
    }
}
#pragma mark - 筛选
-(void)childViewPortion{
    self.childView=[[FNReckChildDeView alloc]init];
    self.childView.hidden=YES;
    self.childView.OneSingSeleted=YES;
    self.childView.delegate=self;
    [self.view addSubview:self.childView];
    self.childView.sd_layout
    .topSpaceToView(self.view, SafeAreaTopHeight+40).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0);
}
#pragma mark - 主视图
-(void)reckoningSetCollectionview{
    CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight-40;
    CGFloat topInterval=SafeAreaTopHeight+45;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 10;
    flowlayout.minimumInteritemSpacing = 10;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, topInterval, FNDeviceWidth, tableHeight) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.hidden=YES;
    [self.view addSubview:self.jm_collectionview];
    
    [self.jm_collectionview registerClass:[FNreckSetDeCell class] forCellWithReuseIdentifier:@"FNreckSetDeCellId"];
    [self.jm_collectionview registerClass:[FNreckDeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNreckDeHeaderViewID"];
    self.jm_collectionview.backgroundColor=RGB(246, 245, 245);
    @WeakObj(self);
    self.jm_collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.jm_page = 1;
        [self apiRequestReakList];
    }];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    FNreckSetDeModel *model=self.dataArray[section];
    return model.list.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNreckSetDeModel *model=self.dataArray[indexPath.section];
    FNreckSetItemModel *itemModel=[FNreckSetItemModel mj_objectWithKeyValues:model.list[indexPath.row]];
    FNreckSetDeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNreckSetDeCellId" forIndexPath:indexPath];
    cell.backgroundColor =RGB(246, 245, 245);
    cell.model=itemModel;
    cell.delegate=self;
    cell.indexPath=indexPath;
    return cell;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=FNDeviceWidth;
    CGSize size = CGSizeMake(with, 90);
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNreckSetDeModel *model=self.dataArray[indexPath.section];
    FNreckSetItemModel *itemModel=[FNreckSetItemModel mj_objectWithKeyValues:model.list[indexPath.row]];
    FNReckDetailsSeController *vc=[[FNReckDetailsSeController alloc]init];
    vc.Oid=itemModel.id;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FNreckDeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNreckDeHeaderViewID" forIndexPath:indexPath];
    FNreckSetDeModel *model=self.dataArray[indexPath.section];
    headerView.backgroundColor=RGB(245, 245, 245);
    headerView.model=model;
    return headerView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    return CGSizeMake(with,45);
}
#pragma mark -  FNreckSetDeCellDegate // 复制
- (void)inOrderDupAction:(NSIndexPath*)index{
    FNreckSetDeModel *model=self.dataArray[index.section];
    FNreckSetItemModel *itemModel=[FNreckSetItemModel mj_objectWithKeyValues:model.list[index.row]];
    XYLog(@"复制=:%@",itemModel.oid);
    [[UIPasteboard generalPasteboard] setString:itemModel.oid?:@""];
    [FNTipsView showTips:@"已复制"];
}
#pragma mark - //账单头部分类
- (FNRequestTool *)apiRequestHeaderClassify{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=account_list&ctrl=cate" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //XYLog(@"账单头部分类:%@",respondsObject);
        //FNreckSetCateDeModel
        NSArray* arr = respondsObject[DataKey];
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dictry in arr) {
            [arrM addObject:[FNreckSetCateDeModel mj_objectWithKeyValues:dictry]];
        }
        selfWeak.classifyArray=arrM;
        [self filtrateViewPart];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark - //筛选类型 1(只有收入支出)
- (FNRequestTool *)apiRequestScreenOne{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=account_list&ctrl=screen" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //XYLog(@"收入支出筛选:%@",respondsObject);
        //FNreckSetScreenDeModel  FNreckScreenItemModel
        NSArray* arr = respondsObject[DataKey];
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dictry in arr) {
            FNreckSetScreenDeModel *zonModel=[FNreckSetScreenDeModel mj_objectWithKeyValues:dictry];
            NSMutableArray *itemArr=[NSMutableArray arrayWithCapacity:0];
            [zonModel.list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNreckScreenItemModel *model=[FNreckScreenItemModel mj_objectWithKeyValues:obj];
                model.stateID=100+idx;
                if(idx==0){
                    model.state=1;
                }
                [itemArr addObject:model];
            }];
            zonModel.list=itemArr;
            [arrM addObject:zonModel];
        }
        FNreckSetScreenDeModel *model=[FNreckSetScreenDeModel mj_objectWithKeyValues:arr[0]];
        FNreckScreenItemModel *oneItem=[FNreckScreenItemModel mj_objectWithKeyValues:model.list[0]];
        selfWeak.typeTwo=oneItem.screen_type;
        selfWeak.screenArray=arrM;
        [self apiRequestScreenTwo];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark - //筛选类型 2(选择收入支出后调用)
- (FNRequestTool *)apiRequestScreenTwo{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,@"type":@""}];
    if([self.typeTwo kr_isNotEmpty]){
        params[@"type"]=self.typeTwo;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=account_list&ctrl=screen_2" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //XYLog(@"收入支出下面筛选条件:%@",respondsObject);
        //FNreckSetScreenDeModel  FNreckScreenItemModel
        NSArray* arr = respondsObject[DataKey];
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dictry in arr) {
            //[arrM addObject:[FNreckSetScreenDeModel mj_objectWithKeyValues:dictry]];
            NSMutableArray *itemArr=[NSMutableArray arrayWithCapacity:0];
            FNreckSetScreenDeModel *zonModel=[FNreckSetScreenDeModel mj_objectWithKeyValues:dictry];
            [zonModel.list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNreckScreenItemModel *model=[FNreckScreenItemModel mj_objectWithKeyValues:obj];
                model.stateID=200+idx;
                [itemArr addObject:model];
            }];
            zonModel.list=itemArr;
            [arrM addObject:zonModel];
        }
        if(selfWeak.screenArray.count>1){
            FNreckScreenItemModel *oneModel=selfWeak.screenArray[0];
            [selfWeak.screenArray removeAllObjects];
            [selfWeak.screenArray addObject:oneModel];
            [selfWeak.screenArray addObjectsFromArray:arrM];
        }else{
            [selfWeak.screenArray addObjectsFromArray:arrM];
        }
        selfWeak.childView.typeDataArr=selfWeak.screenArray;
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark - //账单列表
- (FNRequestTool *)apiRequestReakList{
    [SVProgressHUD show];
    @WeakObj(self);
    [selfWeak.jm_collectionview.mj_footer endRefreshing];
    [selfWeak.jm_collectionview.mj_header endRefreshing];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,PageNumber:@(self.jm_page), PageSize:@(_jm_pro_pagesize),@"type":@"",@"start_time":@"",@"end_time":@"",@"screen_type":@""}];
    NSString *apiUrlString=@"mod=appapi&act=account_list&ctrl=index";
    if([self.typeString kr_isNotEmpty]){
        params[@"type"] = self.typeString;
    }
    if([self.screen_type kr_isNotEmpty]){
        params[@"screen_type"] = self.screen_type;
    }
    if([self.start_time kr_isNotEmpty]){
        params[@"start_time"] = self.start_time;
    }
    if([self.end_time kr_isNotEmpty]){
        params[@"end_time"] = self.end_time;
    }
    if([self.keyword kr_isNotEmpty]){
        params[@"keyword"] = self.keyword;
    }
    return [FNRequestTool requestWithParams:params api:apiUrlString respondType:(ResponseTypeArray) modelType:@"FNreckSetDeModel" success:^(id respondsObject) {
        NSArray* array = respondsObject;
        [SVProgressHUD dismiss];
        if (selfWeak.jm_page == 1) {
            if (array.count == 0) {
                [selfWeak.jm_collectionview reloadData];
                //return ;
            }
            [selfWeak.dataArray removeAllObjects];
            [selfWeak.dataArray addObjectsFromArray:respondsObject];
            if (array.count >= 1) {
                selfWeak.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.jm_page ++;
                    [selfWeak apiRequestReakList];
                }];
            }else{
                selfWeak.jm_collectionview.mj_footer = nil;
            }
        } else {
            [selfWeak.dataArray addObjectsFromArray:respondsObject];
            if (array.count >= 1) {
                [selfWeak.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [selfWeak.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        selfWeak.jm_collectionview.hidden = NO;
        [selfWeak.jm_collectionview reloadData];
        [UIView animateWithDuration:0.25 animations:^{            
            [SVProgressHUD dismiss];
        } completion:^(BOOL finished) {
        }];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark - //数组
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)classifyArray{
    if (!_classifyArray) {
        _classifyArray = [NSMutableArray array];
    }
    return _classifyArray;
}
-(NSMutableArray *)screenArray{
    if (!_screenArray) {
        _screenArray = [NSMutableArray array];
    }
    return _screenArray;
}

@end
