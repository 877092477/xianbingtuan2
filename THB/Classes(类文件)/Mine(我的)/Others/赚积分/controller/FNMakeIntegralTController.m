//
//  FNMakeIntegralTController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNMakeIntegralTController.h"
#import "FNmakeInPrintscreenController.h"
#import "FNCustomeNavigationBar.h"
#import "FNMakeHeadTView.h"
#import "FNMakeTaskTCell.h"
#import "FNMakeHotTCell.h"
#import "FNMakeTmodel.h"
#import "JMAlertView.h"
@interface FNMakeIntegralTController ()<UICollectionViewDelegate,UICollectionViewDataSource,FNmakeTakeListViewDegate,FNmakeHotListViewDegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIImageView* imgHeader;
@property (nonatomic, strong)FNMakeTmodel *dataModel;
@property (nonatomic, strong)NSString *receiveType;
@property (nonatomic, strong)NSString *taskId;
@end

@implementation FNMakeIntegralTController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if([UserAccessToken kr_isNotEmpty]){
       [self apiRequestMake:NO];
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([NSString isEmpty:UserAccessToken]) {
        [self warnToLogin];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
#pragma mark - set up views
- (void)jm_setupViews{
   
    self.view.backgroundColor =[UIColor whiteColor];// RGB(245, 244, 245);
    CGFloat baseGap=0;
    if(self.understand==YES){
        baseGap=XYTabBarHeight;
    }
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
    [self.jm_collectionview registerClass:[FNMakeTaskTCell class] forCellWithReuseIdentifier:@"FNMakeTaskTCellID"];
    [self.jm_collectionview registerClass:[FNMakeHotTCell class] forCellWithReuseIdentifier:@"FNMakeHotTCellID"];
    [self.jm_collectionview registerClass:[FNMakeHeadTView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNMakeHeadTViewID"];
    
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
    .leftSpaceToView(self.leftBtn, 18).centerYEqualToView(self.leftBtn).widthIs(11).heightIs(18);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    [self configHeader];
    if(self.understand==YES){
        self.leftBtn.hidden=YES;
    }
    if ([NSString isEmpty:UserAccessToken]) {
        self.navigationView.titleLabel.text=@"赚积分";
        [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
        self.navigationView.backgroundColor=[UIColor whiteColor];
        self.navigationView.titleLabel.textColor=[UIColor blackColor];
    }
    //[self apiRequestMake:NO];
    //[self requestBendi];
}
- (void)configHeader{
    CGFloat imgH=220+SafeAreaTopHeight;
    self.imgHeader = [[UIImageView alloc] init];
    self.imgHeader.backgroundColor=[UIColor whiteColor];
    [self.view insertSubview:_imgHeader atIndex:0];
    [self.imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(imgH);
    }];
    self.imgHeader.contentMode = UIViewContentModeScaleAspectFill;
}

-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *arr=self.dataModel.all_task;
    if(arr.count>0){
       return arr.count;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arrM=self.dataModel.all_task;
    FNMakeTaskTmodel *itemModel=[FNMakeTaskTmodel mj_objectWithKeyValues:arrM[indexPath.row]];
    NSString *type=itemModel.type;
    if([type isEqualToString:@"0"] || [type isEqualToString:@"2"]){
        FNMakeTaskTCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNMakeTaskTCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        cell.listView.delegate=self;
        cell.model=itemModel;
        return cell;
    }else if([type isEqualToString:@"1"]){
        FNMakeHotTCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNMakeHotTCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        cell.model=itemModel;
        cell.listView.delegate=self;
        return cell;
    }else{
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arrM=self.dataModel.all_task;
    FNMakeTaskTmodel *itemModel=[FNMakeTaskTmodel mj_objectWithKeyValues:arrM[indexPath.row]];
    NSString *type=itemModel.type;
    NSInteger listCount=0;
    if(itemModel.tasks.count>0){
       listCount=itemModel.tasks.count;
    }
    CGFloat rowH=0;
    CGFloat height=0;
    if([type isEqualToString:@"0"] || [type isEqualToString:@"2"]){
        rowH=105;
        height=rowH*listCount+47+20;
    }else if([type isEqualToString:@"1"]){
        rowH=213;
        height=rowH*listCount+51+7;
    }
    CGFloat with=FNDeviceWidth; 
    CGSize size = CGSizeMake(with, height);
    return size;
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
    FNMakeHeadTView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNMakeHeadTViewID" forIndexPath:indexPath];
    headerView.backgroundColor=[UIColor clearColor];
    headerView.model=self.dataModel;
    [headerView.centreBtn addTarget:self action:@selector(centreBtnAction)];
    [headerView.rightBtn addTarget:self action:@selector(rightBtnAction)];
    //headerView.itemView.delegate=self;
//    [headerView.gifImageView addTarget:self action:@selector(gifImageViewAction)];
    return headerView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=180+SafeAreaTopHeight;
    return CGSizeMake(with,hight);
}
-(void)centreBtnAction{
    NSDictionary *dictry=self.dataModel.skip;
    [self loadOtherVCWithModel:dictry andInfo:nil outBlock:nil];
    
}
-(void)rightBtnAction{
    NSString* url = self.dataModel.jf_explain;
    [self goWebDetailWithWebType:@"0" URL:url];
}
#pragma mark - Table view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    CGFloat imgH=220+SafeAreaTopHeight;
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
        float percent = conY/JMNavBarHeigth;
        self.navigationView.backgroundColor = [RGB(250, 89, 54) colorWithAlphaComponent:conY/JMNavBarHeigth];
    }else if (conY > JMNavBarHeigth){
        self.navigationView.backgroundColor = RGB(250, 89, 54);
        
    }else{
        self.navigationView.backgroundColor = [UIColor clearColor];
        
    }
}

#pragma mark - // 推荐或主线点击
- (void)inMakeTakeListAction:(id)model{
    FNMakeTaskItemTmodel *itemModel=model;
    NSDictionary *dictry=itemModel.skip;
    NSInteger state=[itemModel.btn_status integerValue];
    
    if (state==1) {
        [FNTipsView showTips:@"已完成"];
    }else if(state==2){
        if([itemModel.type isEqualToString:@"custom"]){
            //XYLog(@"去截图审核");
            FNmakeInPrintscreenController *vc=[[FNmakeInPrintscreenController alloc]init];
            vc.Cid=itemModel.id;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
           [self loadOtherVCWithModel:dictry andInfo:nil outBlock:nil];
        }
    }
    else if(state==3){
        self.receiveType=itemModel.tag;
        self.taskId=itemModel.id;
        [self apiRequestReceive];
    }
    else if(state==4){
        
    }
    else if(state==5){
        if([itemModel.type isEqualToString:@"custom"]){
            //XYLog(@"重新去审核");
            FNmakeInPrintscreenController *vc=[[FNmakeInPrintscreenController alloc]init];
            vc.Cid=itemModel.id;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
// 点击任务详情
- (void)inMakeTakeListDetailsAction:(id)model{
    FNMakeTaskItemTmodel *itemModel=model;
    if([itemModel.task_explain kr_isNotEmpty]){
       [self goWebWithUrl:itemModel.task_explain];
    }
}
// 点击失败原因
- (void)inMakeTakeSeletedCauseOfFailureAction:(id)model{
    FNMakeTaskItemTmodel *itemModel=model;
    XYLog(@"失败原因:%@",itemModel.failMsg);
    if([itemModel.failMsg kr_isNotEmpty]){
        JMAlertView* alert = [JMAlertView alertWithTitle:@"" content:itemModel.failMsg firstTitle:@"取消" andSecondTitle:@"确定" alertType:(AlertTypeAlert) clickBlock:^(NSInteger index) {
        }];
        [alert showAlert];
    } 
}
#pragma mark - FNmakeHotListViewDegate    热门点击
- (void)inMakeHotListViewAction:(id)model{
    FNMakeTaskItemTmodel *itemModel=model;
    NSDictionary *dictry=itemModel.skip;
    NSInteger state=[itemModel.btn_status integerValue];
    if (state==1) {
        [FNTipsView showTips:@"已完成"];
    }else if(state==2){
        [self loadOtherVCWithModel:dictry andInfo:nil outBlock:nil];
    }
    else if(state==3){
        self.receiveType=itemModel.tag;
        self.taskId=itemModel.id;
        [self apiRequestReceive];
    }
}
#pragma mark - // 赚积分页面
- (FNRequestTool *)apiRequestMake:(BOOL)isCache{
    [SVProgressHUD show];
    //@WeakObj(self);
    @weakify(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=task&ctrl=index" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dictry = respondsObject[DataKey];
        XYLog(@"respondsObject=%@",respondsObject);
        @strongify(self);
        self.dataModel=[FNMakeTmodel mj_objectWithKeyValues:dictry];
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache:isCache];
}
#pragma mark - // 领取积分
- (FNRequestTool *)apiRequestReceive{
    [SVProgressHUD show];
    //@WeakObj(self);
    @weakify(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    if([self.receiveType kr_isNotEmpty]){
        params[@"type"]=self.receiveType;
        if([self.receiveType isEqualToString:@"custom"]){
            if([self.taskId kr_isNotEmpty]){
               params[@"task_id"]=self.taskId;
            }
        }
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=task&ctrl=lingqu" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        //NSDictionary *dictry = respondsObject[DataKey];
        XYLog(@"respondsObject=%@",respondsObject);
        @strongify(self);
        NSInteger state=[respondsObject[SuccessKey] integerValue];
        NSString *msgState=respondsObject[MsgKey];
        if(state==1){
           [self apiRequestMake:NO];
        }else{
           [FNTipsView showTips:msgState];
        }
    } failure:^(NSString *error) {
        
    } isHideTips:NO];
}
-(void)setDataModel:(FNMakeTmodel *)dataModel{
    _dataModel=dataModel;
    if(dataModel){
        [self.imgHeader setUrlImg:dataModel.task_bg];
        self.navigationView.titleLabel.text=self.dataModel.task_title;
        self.navigationView.titleLabel.textColor=[UIColor colorWithHexString:self.dataModel.task_font_color];
        [self.leftBtn sd_setImageWithURL:URL(self.dataModel.task_back_img) forState:UIControlStateNormal];
    }
}
//-(void)requestBendi{
//    [SVProgressHUD show];
//    @weakify(self);
//    [self apiRequesMod:@"http://192.168.0.130/newVersion/fnuoos_dgapp/?mod=appapi&act=task&ctrl=index" withUrl:@"" withParameter:nil successBlock:^(id responseBody) {
//        XYLog(@"responseBody=%@",responseBody);
//        NSDictionary *dictry = responseBody[DataKey];
//        @strongify(self);
//        self.dataModel=[FNMakeTmodel mj_objectWithKeyValues:dictry];
//        [self.jm_collectionview reloadData];
//    } failureBlock:^(NSString *error) {
//        XYLog(@"error=%@",error);
//    }];
//}
//-(void)apiRequesMod:(NSString*)ip withUrl:(NSString*)url withParameter:(NSMutableDictionary*)parameter successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
//
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager.requestSerializer setTimeoutInterval:20];
//
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html",@"application/javascript",@"application/json", nil];
//    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//
//    urlStr = [[NSMutableString stringWithString:ip] stringByAppendingFormat:@"%@",url];
//
//
//    [manager GET:urlStr parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        successBlock(responseObject);
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
//        if ([errorStr kr_isNotEmpty]) {
//            failureBlock(errorStr);
//        }
//        XYLog(@"errorStr is %@",errorStr);
//        [SVProgressHUD dismiss];
//    }];
//}
@end
