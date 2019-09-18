//
//  FNPunchCardAeController.m
//  THB
//
//  Created by Jimmy on 2019/2/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNPunchCardAeController.h"
#import "FNCustomeNavigationBar.h"
#import "FNpunchCardAeCell.h"
#import "FNcardRankAeCell.h"
#import "FNpunchHomeAeModel.h"
#import "FNclockInAriseView.h"
#import "FNresultClockInView.h"//打卡结果
#import "FNcardSharePeView.h"
#import "FNclockInZoModel.h"
#import <AlipaySDK/AlipaySDK.h>
//controller
#import "FNDetailPunchPeController.h"
#import "FNCardActivityTeController.h"
#import "HXPhotoTools.h"
#import "WXApi.h"


@interface FNPunchCardAeController ()<UICollectionViewDelegate,UICollectionViewDataSource,FNclockInAriseViewDelegate>
@property (nonatomic,strong)FNCustomeNavigationBar *topNaivgationbar;
@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,strong)UIImageView* bgImg;
@property (nonatomic,strong)FNpunchHomeAeModel *dataModel;

//@property (nonatomic,strong)FNclockInZoModel *typeDataModel;

@property (nonatomic,strong)FNresultClockInView *resultView;

@property (nonatomic,strong)FNcardSharePeView *shareView;


@end

@implementation FNPunchCardAeController

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
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self punchCardCollectionview];
    [self setTopNavBar];
    if (![NSString isEmpty:UserAccessToken]) {
         [self requestPunchCardMsg];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onWxSuccess) name:@"Wx_Resp_Success" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 导航栏view
-(void)setTopNavBar{
    self.topNaivgationbar = [FNCustomeNavigationBar customeNavigationBarWithTitle:@"早起打卡"];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn setImage:[UIImage imageNamed:@"return_w"] forState:UIControlStateNormal];
    [self.leftBtn sizeToFit];
    self.leftBtn.size = CGSizeMake(30, 30);
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.topNaivgationbar.leftButton = self.leftBtn;
    [self.view addSubview:self.topNaivgationbar];
    self.topNaivgationbar.backgroundColor =[UIColor clearColor];
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 打卡UI
-(void)punchCardCollectionview{
    
    CGFloat tableHeight=FNDeviceHeight;
    if(self.understand==YES){
        tableHeight=FNDeviceHeight-XYTabBarHeight;
    }
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, tableHeight) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    //self.jm_collectionview.hidden=YES;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNpunchCardAeCell class] forCellWithReuseIdentifier:@"FNpunchCardAeCellID"];
    
   
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     
    FNpunchCardAeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNpunchCardAeCellID" forIndexPath:indexPath];
    cell.model=self.dataModel;
    [cell.detailBtn addTarget:self action:@selector(detailBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [cell.participationBtn addTarget:self action:@selector(participationBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [cell.ruleBtn addTarget:self action:@selector(ruleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [cell.inviteBtn addTarget:self action:@selector(inviteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=FNDeviceWidth;
    CGFloat height=SafeAreaTopHeight+673;
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
#pragma mark - //早起打卡首页
-(void)requestPunchCardMsg{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appClock&ctrl=index" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) { 
       XYLog(@"早起打卡首页:%@",respondsObject);
       NSDictionary *dataDic=respondsObject[DataKey];
       selfWeak.dataModel=[FNpunchHomeAeModel mj_objectWithKeyValues:dataDic];
       [selfWeak.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        XYLog(@"Error:%@",error);
        [FNTipsView showTips:error];
        
    } isHideTips:NO isCache:NO];
}
#pragma mark - //打卡数量列表
- (FNRequestTool *)apiRequestpayType: (void(^)(FNclockInZoModel*)) block{
   
//    @WeakObj(self);
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appClock&ctrl=pay_type" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSDictionary *dictry = respondsObject[DataKey];
//        selfWeak.typeDataModel=[FNclockInZoModel mj_objectWithKeyValues:dictry];
        block([FNclockInZoModel mj_objectWithKeyValues:dictry]);
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        
        [SVProgressHUD dismiss];
    } isHideTips:YES isCache:NO];
}
#pragma mark - //打卡付款
- (void)apiRequestPaydoing:(NSString *)countID with:(NSString *)payType{
    [SVProgressHUD show];
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    if([countID kr_isNotEmpty]){
        params[@"id"]=countID;
    }
    if([countID kr_isNotEmpty]){
        params[@"type"]=payType;
    }
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appClock&ctrl=pay_doing" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSDictionary* dic = respondsObject[DataKey];
        XYLog(@"yueDic:%@",dic);
        if([payType isEqualToString:@"yue"]){
           [selfWeak requestPunchCardMsg];
        }
        if([payType isEqualToString:@"zfb"]){
            NSString *code=dic[@"code"];
            if([code kr_isNotEmpty]){
               [self startBesidesPayment:code];
            }
        }
        if ([payType isEqualToString:@"wx"]) {
            [self startWxPayment: dic];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:NO];
}


// 微信支付
- (void)startWxPayment:(NSDictionary*) dataDic {
    NSString *partnerid = dataDic[@"partnerid"];
    NSString *nonce_str = dataDic[@"noncestr"];
    NSString *prepay_id = dataDic[@"prepayid"];
    NSString *sign = dataDic[@"sign"];
    NSString *timeStamp = dataDic[@"timestamp"];
    
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = partnerid;
    request.prepayId= prepay_id;
    request.package = @"Sign=WXPay";
    request.nonceStr= nonce_str;
    request.timeStamp= timeStamp.intValue;
    
    request.sign= sign;
    [WXApi sendReq: request];
}

- (void)onWxSuccess {
    
    [self requestPunchCardMsg];
}

#pragma mark - //打卡操作
- (FNRequestTool *)apiRequestDKDoing{
    
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appClock&ctrl=dk_doing" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSDictionary *dictry = respondsObject[DataKey];
        FNclockDKDoingModel *model=[FNclockDKDoingModel mj_objectWithKeyValues:dictry];
        [selfWeak showDKresult:model];
        [selfWeak requestPunchCardMsg];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark - //打卡明细
-(void)detailBtnAction{
    FNDetailPunchPeController *vc = [[FNDetailPunchPeController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - //活动规则
-(void)ruleBtnAction{
    FNCardActivityTeController *vc = [[FNCardActivityTeController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - //主要点击
-(void)participationBtnAction{
    if([self.dataModel.type isEqualToString:@"buy"]){
        //等待购买
        @weakify(self)
        [self apiRequestpayType:^(FNclockInZoModel *model) {
            @strongify(self)
            FNclockInAriseView *ariseView=[[FNclockInAriseView alloc]init];
            ariseView.dataModel=model;
            ariseView.delegate=self;
            [self.view addSubview:ariseView];
            [ariseView showView];
        }];
    }else if([self.dataModel.type isEqualToString:@"wait_sign"]){
        //等待打卡
       
    }else if([self.dataModel.type isEqualToString:@"start_sign"]){
        //开始打卡
        [self apiRequestDKDoing]; 
    }
    
}
#pragma mark - //分享
-(void)inviteBtnAction{
    self.shareView=[[FNcardSharePeView alloc]init];
    [self.shareView.imageView setUrlImg:self.dataModel.img_code];
    [self.shareView.oneBtn addTarget:self action:@selector(preserveBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.shareView.twoBtn addTarget:self action:@selector(wxBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.shareView.threeBtn addTarget:self action:@selector(friendsBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].delegate.window addSubview:self.shareView];
}
-(void)preserveBtnAction{
    if([self.dataModel.img_code kr_isNotEmpty]){
        [SVProgressHUD show];
        [[SDWebImageManager sharedManager] downloadImageWithURL:URL(self.dataModel.img_code) options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (finished) {
                NSString *name = [NSString stringWithFormat:@"%lf", [NSDate dateWithTimeIntervalSinceNow:0].timeIntervalSince1970];
                [HXPhotoTools savePhotoToCustomAlbumWithName:name photo: image];
                [SVProgressHUD dismiss];
                [self.shareView dismissAlert];
                [FNTipsView showTips:@"保存成功～"];
            }
        }];
    } 
}
-(void)wxBtnAction{
    [self.shareView dismissAlert];
    UMSocialPlatformType type=UMSocialPlatformType_WechatSession;
    NSString *imgurl=self.dataModel.img_code;
    if([imgurl kr_isNotEmpty]){
      [self umengShareWithURL:nil image:imgurl shareTitle:[NSString stringWithFormat:@"来自%@App",[FNBaseSettingModel settingInstance].AppDisplayName] andInfo:nil withType:type];
    } 
}
-(void)friendsBtnAction{
    [self.shareView dismissAlert];
    UMSocialPlatformType type=UMSocialPlatformType_WechatTimeLine;
    NSString *imgurl=self.dataModel.img_code;
    if([imgurl kr_isNotEmpty]){
       [self umengShareWithURL:nil image:imgurl shareTitle:[NSString stringWithFormat:@"来自%@App",[FNBaseSettingModel settingInstance].AppDisplayName] andInfo:nil withType:type];
    }
}
#pragma mark - FNclockInAriseViewDelegate
- (void)ariseClockInChoiceCount:(NSString*)countID withType:(NSString*)payType{
    //payType : 余额=->yue 支付宝=>zfb
    [self apiRequestPaydoing:countID with:payType];
    
}
//支付宝支付
-(void)startBesidesPayment:(NSString*)codeString{
    XYLog(@"BalanceoidString:%@",codeString);
    [[AlipaySDK defaultService] payOrder:codeString fromScheme:AlisdkSchemes callback:^(NSDictionary *resultDic) {
        XYLog(@"支付:%@",resultDic);
        if ([NSString checkIsSuccess:resultDic[@"resultStatus"] andElement:@"9000"] ) {
            [FNTipsView showTips:ResultStatusDict[@"9000"]];
            [self requestPunchCardMsg];
        }else{
            [SVProgressHUD dismiss];
            [FNTipsView showTips:ResultStatusDict[resultDic[@"resultStatus"] ] withDuration:2.0];
        }
    }];
}
//显示打卡结果
-(void)showDKresult:(FNclockDKDoingModel *)model{
    self.resultView=[[FNresultClockInView alloc]init];
    self.resultView.model=model;
    [self.resultView.continueBtn addTarget:self action:@selector(continueBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].delegate.window addSubview:self.resultView];
}
//继续挑战
-(void)continueBtnAction{
    [self.resultView  dismissAlert];
    @weakify(self)
    [self apiRequestpayType:^(FNclockInZoModel *model) {
        @strongify(self)
        FNclockInAriseView *ariseView=[[FNclockInAriseView alloc]init];
        ariseView.dataModel=model;
        ariseView.delegate=self;
        [self.view addSubview:ariseView];
        [ariseView showView];
    }];
}
#pragma mark - Table view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    CGFloat topY=0;
    if (conY <= topY) {
        self.jm_collectionview.bounces = NO;
    }else if (conY > topY){
        self.jm_collectionview.bounces = YES;
    }
}
@end
