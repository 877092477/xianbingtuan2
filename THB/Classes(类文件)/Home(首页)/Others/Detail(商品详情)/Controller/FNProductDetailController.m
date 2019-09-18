//
//  FNProductDetailController.m
//  LikeKaGou
//
//  Created by jimmy on 16/10/11.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "FNProductDetailController.h"
#import "MyWebViewController.h"
#import "ALBBDetailsViewController.h"
#import "FNProductDetailHeaderView.h"
#import "FNMineButton.h"


#import "FNAPIProductsTool.h"
#import "FNProductDetailModel.h"
@interface FNProductDetailController ()<UITableViewDelegate,UITableViewDataSource,FNProductDetailHeaderViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) UITableView* tabelView;
@property (nonatomic, strong) UIView* toolView;
@property (nonatomic, strong) FNProductDetailHeaderView* headerView;
@property (nonatomic, strong)FNProductDetailModel* model;


@end

@implementation FNProductDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self apiRequestDetailWithGoodId:self.gid];
    [SVProgressHUD show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - api request
- (void)apiRequestDetailWithGoodId:(NSString *)gid{
    @WeakObj(self);
    [SVProgressHUD show];

    [FNAPIProductsTool apiProductsRequestProdetailWithGoodsId:gid success:^(id respondObject) {
        if (respondObject && [respondObject isKindOfClass:[FNProductDetailModel class]]) {

            selfWeak.model = respondObject;
            
            [self initializedSubviews];

            selfWeak.headerView.model = selfWeak.model;
            
            [selfWeak.headerView setCouponDes:selfWeak.model.yhq_span];
            
            selfWeak.tabelView.tableHeaderView = selfWeak.headerView;

            [selfWeak.tabelView reloadData];
            
        }else {
            [FNTipsView showTips:respondObject];
            
        }
        
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
          [FNTipsView showTips:FNFailureRequest];
    }];
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.title = @"商品详情";
    
    _headerView  = [[FNProductDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 0)];
    _headerView.model = self.model;
    _headerView.delegate = self;
    UITableView* table = [[UITableView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight-XYTabBarHeight-60)) style:(UITableViewStylePlain)];
    table.delegate = self;
    table.dataSource = self;
    table.tableHeaderView = _headerView;
    [table removeEmptyCellRows];
    [self.view addSubview:table];
    _tabelView = table;
    
//    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"productdetail_share"] style:(UIBarButtonItemStylePlain) target:self action:@selector(shareItemOnclicked)];
//    self.navigationItem.rightBarButtonItem = shareItem;
    
    [self setUpToolView];
}
- (void)setUpToolView{
    CGFloat btnH = 44;
    UIView *toolView = [[UIView alloc]initWithFrame:(CGRectMake(0,XYScreenHeight-44, XYScreenWidth, btnH))];
//    _toolView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:toolView];
//    [self.view bringSubviewToFront:toolView];
    _toolView = toolView;

    [[[ UIApplication  sharedApplication ]keyWindow] addSubview : _toolView ] ;

    
    FNMineButton *serviceBtn = [[FNMineButton alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth*0.4, btnH) image:[UIImage imageNamed:@"productdetail_service"] andTitle:@"客服"];
    serviceBtn.buttonClicked = ^(UIView *view){
//        [FNTipsView showTips:@"客服正忙"];
        MyWebViewController *coupon = [MyWebViewController new];
        XYNavigationController *nav = [[XYNavigationController alloc] initWithRootViewController:coupon];
        coupon.openUrl =[FNBaseSettingModel settingInstance].ContactUs;
        
        [self presentViewController:nav animated:YES completion:NULL];

//        [self.navigationController pushViewController:coupon animated:YES];
    };
    [_toolView addSubview:serviceBtn];
    
    UIFont *font = FNFontDefault(FNGlobalFontNormalSize);
    XYLog(@"_model.yhq_price is %@",_model.yhq_price);
    NSString *str = [[NSString alloc]init];
    if (![_model.yhq_price kr_isNotEmpty] ) {
        str = @"暂无券领";
    }else{
        str = [NSString stringWithFormat:@"领%@券",_model.yhq_price] ;

    }
    //领取按钮
    UIButton *lingBtn = [UIButton buttonWithTitle:str titleColor:FNWhiteColor font:font target:self action:@selector(buyRightNow:)];
    lingBtn.tag = 1;
    lingBtn.frame = CGRectMake(CGRectGetMaxX(serviceBtn.frame), 0, (FNDeviceWidth-CGRectGetWidth(serviceBtn.frame))/2, btnH);
    lingBtn.backgroundColor = FNOrange;
    [_toolView addSubview:lingBtn];

    //购买
    UIButton *buyBtn = [UIButton buttonWithTitle:@"立即抢购" titleColor:FNWhiteColor font:font target:self action:@selector(buyRightNow:)];
    buyBtn.frame = CGRectMake(CGRectGetMaxX(lingBtn.frame), 0, (FNDeviceWidth-CGRectGetWidth(serviceBtn.frame))/2, btnH);
    buyBtn.tag = 2;
    buyBtn.backgroundColor = FNMainGobalControlsColor;
    
    [_toolView addSubview:buyBtn];
    
}

-(void)viewWillDisappear:(BOOL)animated{
//    [_toolView removeFromSuperview];
    _toolView.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    if (iOS7) { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    }
    if (self.navigationController.viewControllers.count>=2) {
        self.tabBarController.tabBar.hidden = YES;
    }
    
//    [self setUpToolView];
    _toolView.hidden = NO;
}
- (void)shareItemOnclicked{
//    [FNTipsView showTips:@"Share"];
    [self ClickToInvitMethod];
}
- (void)buyRightNow:(UIButton *)sender{
    if (sender.tag == 1) {
        if ([_model.yhq_url  kr_isNotEmpty]) {
            MyWebViewController *coupon = [MyWebViewController new];
            coupon.openUrl = _model.yhq_url;
            XYNavigationController *nav = [[XYNavigationController alloc] initWithRootViewController:coupon];
            [self presentViewController:nav animated:YES completion:NULL];
        }else {
            [FNTipsView showTips:@"暂无优惠券"];
        }

    }else{
//        NSString *goodsId = self.model.fnuo_id;
//        ALBBDetailsViewController *detail = [ALBBDetailsViewController new];
//        XYNavigationController *nav = [[XYNavigationController alloc] initWithRootViewController:detail];
//        detail.fnuoId = goodsId;
//        detail.goodsId = self.model.id;
//        
//        [self presentViewController:nav animated:NO completion:NULL];
//        [self goToProductDetailsWithUrl:self.model.fnuo_url Fnuo_Id:self.model.fnuo_id Goods_Id:self.model.id YHQ_Price:self.model.yhq_price ToDetail:YES];
#warning 增加跳转方法
//        [self goToProductDetailsWithModel: ToDetail:<#(BOOL)#>]
    }
    
    
}
#pragma mark - FNProductDetailHeaderViewDelegate
- (void)couponViewOnClicked{
    if ( [_model.yhq_url kr_isNotEmpty]) {
        MyWebViewController *coupon = [MyWebViewController new];
        coupon.openUrl = _model.yhq_url;
        XYNavigationController *nav = [[XYNavigationController alloc] initWithRootViewController:coupon];
        [self presentViewController:nav animated:YES completion:NULL];
    }else {
        [FNTipsView showTips:@"暂无优惠券"];
    }
    
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    return cell;
}

- (void)dealloc{
    NSLog(@"des");
}

//分享
-(void)ClickToInvitMethod
{
//    _toolView.hidden = YES;
    NSString *shareText = UserShareWord;             //分享内嵌文字
    NSString *shareUrl = [NSString encodeToPercentEscapeString:ShareUrl];
    
    [self umengShareWithURL:shareUrl image:UserShareImg shareTitle:nil andInfo:shareText];

    
    
}
-(void)shareMethod:(UIGestureRecognizer *)sender{
    NSString *shareText = UserShareWord;             //分享内嵌文字
    NSString *shareUrl = [NSString encodeToPercentEscapeString:ShareUrl];

    [self umengShareWithURL:shareUrl image:UserShareImg shareTitle:nil andInfo:shareText];

    
    
}

@end
