//
//  FNcandiesIncomeController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcandiesIncomeController.h"
#import "FNdistrictConvertfeController.h" 
#import "FNCustomeNavigationBar.h"
#import "FNcanIncomeTopCell.h"
#import "FNcanIncomeDanCell.h"
#import "FNcandiesIncomeItemCell.h"
#import "FNcandiesIncomeModel.h"
#import "FNcalendarPopDeView.h"
#import "NSDate+HXExtension.h"
#import "FNCandiesConversionController.h"
@interface FNcandiesIncomeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNcalendarPopDeViewDegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn; 
@property (nonatomic, strong)FNcandiesIncomeModel *dataModel;
@property (nonatomic, strong)UIImageView *imgHeader;
@property (nonatomic, strong)NSString* seletedDate;
@property (nonatomic, strong)NSMutableArray *dataArr;


@end

@implementation FNcandiesIncomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
}
#pragma mark - set up views
- (void)jm_setupViews{
    CGFloat baseGap=0;
    if(self.understand==YES){
        baseGap=XYTabBarHeight;
    }
    [self configHeader];
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    self.jm_collectionview.alpha = 1;
    self.jm_collectionview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
    [self.jm_collectionview registerClass:[FNcanIncomeTopCell class] forCellWithReuseIdentifier:@"FNcanIncomeTopCellID"];
    [self.jm_collectionview registerClass:[FNcanIncomeDanCell class] forCellWithReuseIdentifier:@"FNcanIncomeDanCellID"];
    [self.jm_collectionview registerClass:[FNcandiesIncomeItemCell class] forCellWithReuseIdentifier:@"FNcandiesIncomeItemCellID"];
    
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.view addSubview:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 10).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150]; 
    
    if(self.understand==YES){
        self.leftBtn.hidden=YES;
    }
    
    self.view.backgroundColor = RGB(250, 250, 250);
    self.navigationView.titleLabel.text=@"收支明细";
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor clearColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    
    if([UserAccessToken kr_isNotEmpty]){
       [self requestBendi];
    }
    
}
- (void)configHeader{
    CGFloat imgH=218;
    self.imgHeader = [[UIImageView alloc] init];
    [self.view insertSubview:_imgHeader atIndex:0];
    [self.imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(imgH);
    }];
    self.imgHeader.contentMode = UIViewContentModeScaleAspectFill;
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){
       return 1;
    }
    else if(section==1){
       return 2;
    }else{
       
       return self.dataArr.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        FNcanIncomeTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNcanIncomeTopCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        cell.model=self.dataModel;
        [cell.incomeBtn addTarget:self action:@selector(incomeBtnClick)];
        [cell.baseBtn addTarget:self action:@selector(baseBtnDateClick)];
        if([self.seletedDate kr_isNotEmpty]){
           [cell.baseBtn setTitle:self.seletedDate forState:UIControlStateNormal];
        }
        return cell;
    }else if(indexPath.section==1){
        FNcanIncomeDanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNcanIncomeDanCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        if(indexPath.row==0){
            [cell.bgImgView setUrlImg:self.dataModel.shouru_bg];
            cell.priceLB.text=self.dataModel.shouru;
        }
        else if(indexPath.row==1){
            [cell.bgImgView setUrlImg:self.dataModel.zhichu_bg];
            cell.priceLB.text=self.dataModel.zhichu;
        }
        return cell;
    }else{
        FNcandiesIncomeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNcandiesIncomeItemCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        FNcandiesIncomeItemModel *model=[FNcandiesIncomeItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
        cell.model=model;
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=250;
    CGFloat itemWith=FNDeviceWidth;
    if(indexPath.section==0){
         itemHeight=250;
         itemWith=FNDeviceWidth;
    }
    else if(indexPath.section==1){
        itemHeight=98;
        itemWith=(FNDeviceWidth-35)/2;
    }
    else if(indexPath.section==2){
        itemHeight=80;
        itemWith=FNDeviceWidth;
    }
    CGSize  size = CGSizeMake(itemWith, itemHeight);
    return  size;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if(section==1){
      return 15;
    }
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=0;
    CGFloat bottomGap=10;
    CGFloat rightGap=0;
    if(section==1){
       leftGap=10;
       rightGap=10;
    }
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - 点击
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//兑换
-(void)incomeBtnClick{
    //FNdistrictConvertfeController *vc=[[FNdistrictConvertfeController alloc]init];
    //vc.understand=NO;
    //vc.seletedInt=0;
    //vc.type=@"duihuan";
    FNCandiesConversionController *vc=[[FNCandiesConversionController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//选择日期
-(void)baseBtnDateClick{
    FNcalendarPopDeView *calendarView = [[FNcalendarPopDeView alloc]init];
    calendarView.delegate=self;
    [[UIApplication sharedApplication].delegate.window addSubview:calendarView];
}
#pragma mark - FNcalendarPopDeViewDegate // 选择日期
- (void)popSeletedDateClick:(NSString *)date{
    
    XYLog(@"选择日期=:%@",date);
}
- (void)popSeletedDateStyleClick:(NSDate *)date{
    self.seletedDate=[date dateStringWithFormat:@"yyyy-MM-dd"];
    NSIndexPath *indexReload = [NSIndexPath indexPathForRow:0 inSection:0];
    FNcanIncomeTopCell *itemCell=(FNcanIncomeTopCell *)[self.jm_collectionview cellForItemAtIndexPath:indexReload];
    [itemCell.baseBtn setTitle:self.seletedDate forState:UIControlStateNormal];
    
    if([self.seletedDate kr_isNotEmpty]){
        self.jm_page=0;
       [self requestBendi];
    }
}
#pragma mark - request
//多维区块链首页接口
-(FNRequestTool*)requestPayment{
    @weakify(self);
    [SVProgressHUD show];
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
    if([self.seletedDate kr_isNotEmpty]){
        params[@"date"]=self.seletedDate;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dwqkb&ctrl=payment_detail" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        @strongify(self);
        NSDictionary *dictry = respondsObject[DataKey];
        self.dataModel=[FNcandiesIncomeModel mj_objectWithKeyValues:dictry];
        self.navigationView.titleLabel.text=self.dataModel.title;
        [self.leftBtn sd_setImageWithURL:URL(self.dataModel.return_btn) forState:UIControlStateNormal];
        self.navigationView.titleLabel.textColor=[UIColor colorWithHexString:self.dataModel.top_color];
        [self.imgHeader setUrlImg:self.dataModel.top_bg];
        NSArray *array =self.dataModel.list;
        if (self.jm_page == 1) {
            if (array.count == 0) {
                [self.dataArr removeAllObjects];
                [self.jm_collectionview reloadData];
                return ;
            }
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.jm_page ++;
                    [self requestBendi];
                }];
            }
        } else {
            [self.dataArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                [self.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [self.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [UIView performWithoutAnimation:^{
            [self.jm_collectionview reloadData];
        }];
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:NO isCache:NO];
}

-(void)requestBendi{
    [SVProgressHUD show];
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
    if([self.seletedDate kr_isNotEmpty]){
        params[@"date"]=self.seletedDate;
    }
    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:@"mod=appapi&act=dwqkb&ctrl=payment_detail" successBlock:^(id responseBody) {
        [SVProgressHUD dismiss];
        @strongify(self); 
        NSDictionary *dictry = responseBody[DataKey];
        self.dataModel=[FNcandiesIncomeModel mj_objectWithKeyValues:dictry];
        self.navigationView.titleLabel.text=self.dataModel.title;
        [self.leftBtn sd_setImageWithURL:URL(self.dataModel.return_btn) forState:UIControlStateNormal];
        self.navigationView.titleLabel.textColor=[UIColor colorWithHexString:self.dataModel.top_color];
        [self.imgHeader setUrlImg:self.dataModel.top_bg];
        NSArray *array =self.dataModel.list;
        if (self.jm_page == 1) {
            if (array.count == 0) {
                [self.dataArr removeAllObjects];
                [self.jm_collectionview reloadData];
                return ;
            }
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.jm_page ++;
                    [self requestBendi];
                }];
            }
        } else {
            [self.dataArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                [self.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [self.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [UIView performWithoutAnimation:^{
            [self.jm_collectionview reloadData];
        }];
    } failureBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
    }];
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    CGFloat imgH=218;
    if (conY<0) {
        [_imgHeader mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
            make.height.mas_equalTo(imgH - conY);
        }];
    }else{
        [_imgHeader mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(-conY);
            make.height.mas_equalTo(imgH);
        }];
    }
    if (conY>0 && conY<=JMNavBarHeigth) {
        //滚动中
        self.navigationView.backgroundColor = [RGB(138, 108, 251) colorWithAlphaComponent:conY/JMNavBarHeigth];
    }else if (conY > JMNavBarHeigth){
        self.navigationView.backgroundColor = RGB(138, 108, 251);
    }else{
        self.navigationView.backgroundColor = [UIColor clearColor];
    }
}
@end
