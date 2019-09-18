//
//  FNDistrictCoinController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNDistrictCoinController.h"
#import "FNdistrictConvertfeController.h"
#import "FNdistrictTurnController.h"
#import "FNdistrictExchangeController.h"
#import "FNdisExDetailListController.h"
#import "FNdisExTopUpController.h" 
#import "FNCustomeNavigationBar.h"
#import "FNDistrictCoinModel.h" 
#import "FNDistrictCoinHeadCell.h"
#import "FNDistrictWealthItemCell.h"
#import "FNDistrictWorthItemCell.h"
#import "FNDistrictChartItemCell.h"
#import "FNDistrictTextItemCell.h"
@interface FNDistrictCoinController ()<UICollectionViewDelegate,UICollectionViewDataSource,FNDistrictCrosswiseViewDelegate,FNDistrictWealthItemCellDelegate,FNdisExTopUpControllerDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)FNDistrictCoinModel  *dataModel;
@end

@implementation FNDistrictCoinController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if([UserAccessToken kr_isNotEmpty]){
        [self requestQuKuaiBi:NO];
        //XYLog(@"flai");
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([NSString isEmpty:UserAccessToken]) {
        [self warnToLogin];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - set top views
- (void)setTopViews{
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.navigationView.leftButton = self.leftBtn;
    
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.rightBtn setTitle:@"规则" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.rightBtn sizeToFit];
    self.rightBtn.size = CGSizeMake(self.rightBtn.width+10, self.rightBtn.height+10);
    self.navigationView.rightButton = self.rightBtn;
    [self.view addSubview:self.navigationView];
    [self.view bringSubviewToFront:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 18);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    self.navigationView.titleLabel.text=self.keyWord?self.keyWord:@"我的区块币";
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.leftBtn.imageView.sd_layout
    .centerYEqualToView(self.leftBtn).widthIs(8).heightIs(16).leftSpaceToView(self.leftBtn, 10);
    if(self.understand==YES){
        self.leftBtn.hidden=YES;
    } 
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightButtonAction{
    NSString *urljoint=self.dataModel.explain_url;
    if([urljoint kr_isNotEmpty]){
       [self goWebWithUrl:urljoint];
    } 
}
#pragma mark - set up views
- (void)jm_setupViews{
    
    CGFloat baseGap=0;
    if(self.understand==YES){
        baseGap=XYTabBarHeight;
    }
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    //flowlayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, FNDeviceHeight-baseGap-SafeAreaTopHeight) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=RGB(250, 250, 250);
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.alpha = 1;
    self.jm_collectionview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNDistrictCoinHeadCell class] forCellWithReuseIdentifier:@"FNDistrictCoinHeadCellID"];
    [self.jm_collectionview registerClass:[FNDistrictWealthItemCell class] forCellWithReuseIdentifier:@"FNDistrictWealthItemCellID"];
    [self.jm_collectionview registerClass:[FNDistrictWorthItemCell class] forCellWithReuseIdentifier:@"FNDistrictWorthItemCellID"];
    [self.jm_collectionview registerClass:[FNDistrictChartItemCell class] forCellWithReuseIdentifier:@"FNDistrictChartItemCellID"];
    [self.jm_collectionview registerClass:[FNDistrictTextItemCell class] forCellWithReuseIdentifier:@"FNDistrictTextItemCellID"];
   
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView1"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView2"];
    [self setTopViews];
    
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }else if(section==1){
        NSArray *arrwealth=self.dataModel.wealth_list;
        return arrwealth.count;
    }else if(section==2){
        return 1;
    }else if(section==3){
        return 1;
    }
    else{
        return 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){
        FNDistrictCoinHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNDistrictCoinHeadCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.typeView.delegate=self;
        cell.model=self.dataModel;
        return cell;
    }else if(indexPath.section==1){
        NSArray *arrwealth=self.dataModel.wealth_list;
        FNDistrictCoinWealthItemModel *itemModel=[FNDistrictCoinWealthItemModel mj_objectWithKeyValues:arrwealth[indexPath.row]];
        FNDistrictWealthItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNDistrictWealthItemCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=self.dataModel;
        cell.itemModel=itemModel;
        cell.delegate=self;
        cell.indexS=indexPath;
        NSString *numStr=itemModel.counts;
        cell.titleLB.text=itemModel.tip_words;
        //cell.titleLB.textColor=[UIColor colorWithHexString:self.dataModel.qkb_bz_color];
        if([numStr kr_isNotEmpty]){
            [cell.titleLB fn_changeFontWithTextFont:[UIFont systemFontOfSize:18] changeText:numStr];
            [cell.titleLB  fn_changeColorWithTextColor:[UIColor colorWithHexString:self.dataModel.qkb_bt_color] changeText:numStr];
        }
        return cell;
    }else if(indexPath.section==2){
        FNDistrictWorthItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNDistrictWorthItemCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=self.dataModel;
        return cell;
    }else if(indexPath.section==3){
        FNDistrictChartItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNDistrictChartItemCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=self.dataModel;
        return cell;
    }
    else{
        FNDistrictTextItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNDistrictTextItemCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=self.dataModel;
        return cell;
    }
    
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height=175;
    CGFloat with= FNDeviceWidth; 
    if(indexPath.section==0){
        height=165;
    }else if(indexPath.section==1){
        height=65;
    }else if(indexPath.section==2){
      height=100;
    }else if(indexPath.section==3){
        height=198;
    }
    else{
       height=54;
    }
    CGSize  size= CGSizeMake(with, height);
    return  size;
    
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==3 ||indexPath.section==4 ){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView1" forIndexPath:indexPath];
        headerView.backgroundColor=RGB(250, 250, 250);
        return headerView;
        
    }else{
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView2" forIndexPath:indexPath];
        return headerView;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=45;
    if(section==3||section==4){
        hight=15;
    }else{
        hight=0;
    }
    return CGSizeMake(with,hight);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==4){
        FNdisExDetailListController *vc=[[FNdisExDetailListController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    } 
}
#pragma mark - FNDistrictCrosswiseViewDelegate // 点击 类型 转出 交易 转账
- (void)didDistrictCrosswiseItemAction:(NSString*)type{
    //XYLog(@"type is %@",type);
    if([type kr_isNotEmpty]){
        if([type isEqualToString:@"zhuanchu"]){
            FNdistrictConvertfeController *vc=[[FNdistrictConvertfeController alloc]init];
            vc.understand=NO;
            vc.type=type;
            vc.seletedInt=0;
            //vc.msgType=@"jf_zhuanchu";
            [self.navigationController pushViewController:vc animated:YES];
        }
        if([type isEqualToString:@"zhuanzhang"]){
            FNdistrictTurnController *vc=[[FNdistrictTurnController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if([type isEqualToString:@"jiaoyi"]){
            FNdistrictExchangeController *vc=[[FNdistrictExchangeController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        } 
    }
}
#pragma mark - FNDistrictWealthItemCellDelegate
// 点击  兑换
- (void)didDistrictWealthItemAddAction:(NSIndexPath*)index{
    XYLog(@"兑换 is %ld",(long)index.row);
//    NSString *msgType=@"";
//    if(index.row==0){
//        msgType=@"jf_duihuan";
//    }
//    if(index.row==1){
//        msgType=@"yue_duihuan";
//    }
    FNdistrictConvertfeController *vc=[[FNdistrictConvertfeController alloc]init];
    vc.understand=NO;
    vc.type=@"duihuan";
    vc.seletedInt=index.row;
    //vc.msgType=msgType;
    [self.navigationController pushViewController:vc animated:YES];
}
// 点击  充值
- (void)didDistrictWealthItemFullAction:(NSIndexPath*)index{
    XYLog(@"充值 is %ld",(long)index.row);
    NSArray *arrwealth=self.dataModel.wealth_list;
    FNDistrictCoinWealthItemModel *itemModel=[FNDistrictCoinWealthItemModel mj_objectWithKeyValues:arrwealth[index.row]];
    if([itemModel.recharge_btn kr_isNotEmpty]){
        FNdisExTopUpController *vc=[[FNdisExTopUpController alloc]init];
        vc.delegate=self;
        [self.navigationController pushViewController:vc animated:YES];
    }  
}
#pragma mark - FNdisExTopUpControllerDelegate //充值完成
- (void)didDisExTopUpStateAction{
    [self requestQuKuaiBi:NO];
}
#pragma mark - //区块币首页
-(FNRequestTool*)requestQuKuaiBi:(BOOL)isCache{
    [SVProgressHUD show];
    @WeakObj(self);
    //@weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=qkb&ctrl=index" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dictry = respondsObject[DataKey];
        //@strongify(self);
        selfWeak.dataModel=[FNDistrictCoinModel mj_objectWithKeyValues:dictry];
        selfWeak.navigationView.titleLabel.text=selfWeak.dataModel.qkb_title;
        selfWeak.navigationView.titleLabel.textColor=[UIColor colorWithHexString:selfWeak.dataModel.qkb_title_color];
        [selfWeak.rightBtn setTitle:selfWeak.dataModel.qkb_detail_btn forState:UIControlStateNormal];
        [selfWeak.jm_collectionview reloadData];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache:isCache];
}
//
-(void)requestBendi{
    [SVProgressHUD show];
    @weakify(self);
    [self apiRequesMod:@"http://192.168.0.130/fnuoos_qkb/?mod=appapi&act=qkb&ctrl=index" withUrl:@"" withParameter:nil successBlock:^(id responseBody) {
        XYLog(@"responseBody=%@",responseBody);
        NSDictionary *dictry = responseBody[DataKey];
        @strongify(self);
        self.dataModel=[FNDistrictCoinModel mj_objectWithKeyValues:dictry];
        self.navigationView.titleLabel.text=self.dataModel.qkb_name;
        self.navigationView.titleLabel.textColor=[UIColor colorWithHexString:self.dataModel.qkb_title_color];
        [self.rightBtn setTitle:self.dataModel.qkb_detail_btn forState:UIControlStateNormal];
        [self.jm_collectionview reloadData];
        [SVProgressHUD dismiss];
    } failureBlock:^(NSString *error) {
        XYLog(@"error=%@",error);
    }];
}
-(void)apiRequesMod:(NSString*)ip withUrl:(NSString*)url withParameter:(NSMutableDictionary*)parameter successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:20];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html",@"application/javascript",@"application/json", nil];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    urlStr = [[NSMutableString stringWithString:ip] stringByAppendingFormat:@"%@",url];
    
    
    [manager GET:urlStr parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        if ([errorStr kr_isNotEmpty]) {
            failureBlock(errorStr);
        }
        XYLog(@"errorStr is %@",errorStr);
        [SVProgressHUD dismiss];
    }];
}
@end
