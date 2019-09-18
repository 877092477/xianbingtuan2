//
//  FNmeMembersIndentSController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmeMembersIndentSController.h"
#import "FNCustomeNavigationBar.h"
#import "JXCategoryView.h"
#import "FNmeMemberIndentitCell.h"
#import "FNmeMemberNorItemCell.h"
#import "FNmeMemberIndentItemModel.h"
#import "FNSortHomeDeController.h"
#import "HomeViewController.h"
#import "FNmeMemberEvaluatesController.h"
#import "FNTeOrderDetailsDeController.h"

#import "JMAlertView.h"
@interface FNmeMembersIndentSController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,JXCategoryViewDelegate,FNmeMemberIndentitCellDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSString *statusStr;
@end

@implementation FNmeMembersIndentSController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (BOOL)isFullScreenShow {
    return YES;
}

- (BOOL)needLogin {
    return YES;
}
 
#pragma mark - set up views
- (void)jm_setupViews{
    self.statusStr=@"0";
    CGFloat baseGap=SafeAreaTopHeight+35;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, baseGap, FNDeviceWidth, FNDeviceHeight-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    
    self.jm_collectionview.backgroundColor=RGB(250, 250, 250);
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNmeMemberIndentitCell class] forCellWithReuseIdentifier:@"FNmeMemberIndentitCellID"];
    
    [self.jm_collectionview registerClass:[FNmeMemberNorItemCell class] forCellWithReuseIdentifier:@"FNmeMemberNorItemCellID"];
//    [self.jm_collectionview registerClass:[FNmerOrderGoodsItemCell class] forCellWithReuseIdentifier:@"FNmerOrderGoodsItemCellID"];
//    [self.jm_collectionview registerClass:[FNmerOrderHintItemCell class] forCellWithReuseIdentifier:@"FNmerOrderHintItemCellID"];
//    [self.jm_collectionview registerClass:[FNmerOrderMsgItemCell class] forCellWithReuseIdentifier:@"FNmerOrderMsgItemCellID"];
    
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
    self.navigationView.titleLabel.text=@"我的订单";
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    
    self.view.backgroundColor=RGB(250, 250, 250);
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+1, FNDeviceWidth, 33)];
    self.categoryView.delegate = self;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.backgroundColor=[UIColor whiteColor];
    self.categoryView.titleFont=kFONT14;
    self.categoryView.titleSelectedFont=kFONT14;
    self.categoryView.titleColor=RGB(140, 140, 140);
    self.categoryView.titles =@[@"全部订单",@"待付款",@"待使用",@"待评价",@"已失效"];
    self.categoryView.titleSelectedColor=RGB(244, 47, 25);
    [self.view addSubview:self.categoryView];
    
    [self requestOrderList];
}
//点击类型
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    XYLog(@"%ld",(long)index);
    self.statusStr=[NSString stringWithFormat:@"%ld",(long)index];
    self.jm_page=1;
    [self requestOrderList];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(self.dataArr.count>0){
       return self.dataArr.count;
    }else{
       return 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.dataArr.count>0){
        FNmeMemberIndentitCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmeMemberIndentitCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.cornerRadius=5/2;
        cell.model=[FNmeMemberIndentItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
        cell.delegate=self;
        cell.index=indexPath;
        return cell;
    }else{
        FNmeMemberNorItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmeMemberNorItemCellID" forIndexPath:indexPath];
        cell.backgroundColor=RGB(250, 250, 250);
        [cell.lookBtn addTarget:self action:@selector(lookBtnClick)];
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=141;
    CGFloat itemWith=FNDeviceWidth-20;
    if(self.dataArr.count>0){
        itemHeight=141;
    }else{
        CGFloat baseGap=SafeAreaTopHeight+35;
        itemHeight=FNDeviceHeight-baseGap;
    }
    CGSize  size = CGSizeMake(itemWith, itemHeight);
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
    return 10;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.dataArr.count>0){
        
        FNmeMemberIndentItemModel *model=[FNmeMemberIndentItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];

        if ([model.buy_type isEqualToString:@"faceToFace"]) {
            //当面付不可进详情 https://www.showdoc.cc/14126?page_id=2147150236791477
            return;
        }
        
        FNTeOrderDetailsDeController *vc=[[FNTeOrderDetailsDeController alloc]init];
        vc.oidString=model.orderId;
        [self.navigationController pushViewController:vc animated:YES];
    } 
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=10;
    CGFloat bottomGap=0;
    CGFloat rightGap=10;
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//去逛逛
-(void)lookBtnClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
         if ([controller isKindOfClass:[FNSortHomeDeController class]] ||[controller isKindOfClass:[HomeViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
         }else{
             NSNotification *notification =[NSNotification notificationWithName:@"FNLookGoods" object:nil userInfo:nil];
             [[NSNotificationCenter defaultCenter] postNotification:notification];
             [self.navigationController popToRootViewControllerAnimated:YES];
             //self.tabBarController.selectedIndex=0;
         }
    }
}
#pragma mark - FNmeMemberIndentitCellDelegate
//取消申请退款
- (void)didmeMemberCancelRefundAction:(NSIndexPath*)indexPath{
    FNmeMemberIndentItemModel *model=[FNmeMemberIndentItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
    JMAlertView* alert = [JMAlertView alertWithTitle:@"" content:@"订单取消申请退款吗？" firstTitle:@"取消" andSecondTitle:@"确认" alertType:(AlertTypeAlert) clickBlock:^(NSInteger index) {
        if (index == 1) {
            [self requestCancelApplyFor:model.id];
        }
    }];
    [alert.firstButton setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    [alert.secondButton setTitleColor:RGB(250, 120, 0) forState:UIControlStateNormal];
    [alert showAlert];
}
//取消订单
- (void)didmeMemberCancelIndentitAction:(NSIndexPath*)indexPath{
    FNmeMemberIndentItemModel *model=[FNmeMemberIndentItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
    JMAlertView* alert = [JMAlertView alertWithTitle:@"" content:@"取消订单吗？" firstTitle:@"取消" andSecondTitle:@"确认" alertType:(AlertTypeAlert) clickBlock:^(NSInteger index) {
        if (index == 1) {
            [self requestCancelApplyFor:model.id];
        }
    }];
    [alert.firstButton setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    [alert.secondButton setTitleColor:RGB(250, 120, 0) forState:UIControlStateNormal];
    [alert showAlert];
}
//评价
- (void)didmeMemberEvaluateIndentitAction:(NSIndexPath*)index{
    FNmeMemberIndentItemModel *model=[FNmeMemberIndentItemModel mj_objectWithKeyValues:self.dataArr[index.row]];
    FNmeMemberEvaluatesController *vc=[[FNmeMemberEvaluatesController alloc]init];
    vc.orderId=model.id;
    vc.store_id=model.store_id;
    vc.inMeMemberEvaluatesRefreshData = ^{
        self.jm_page = 1;
        [self requestOrderList];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
//确认送达
- (void)didmeMemberAffirmIndentitAction:(NSIndexPath*)indexPath{
    JMAlertView* alert = [JMAlertView alertWithTitle:@"" content:@"订单确认送达吗？" firstTitle:@"取消" andSecondTitle:@"已送达" alertType:(AlertTypeAlert) clickBlock:^(NSInteger index) {
        if (index == 1) {
            FNmeMemberIndentItemModel *model=[FNmeMemberIndentItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
            [self requestCommentMsg:model.id];
        }
    }];
    [alert.firstButton setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    [alert.secondButton setTitleColor:RGB(250, 120, 0) forState:UIControlStateNormal];
    [alert showAlert];
    
}
#pragma mark - request
//我的订单-
-(FNRequestTool*)requestOrderList{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
    
    if([self.statusStr kr_isNotEmpty]){
        params[@"status"]=self.statusStr;
    }
//    [SVProgressHUD show];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_order&ctrl=order_list" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSArray *array =respondsObject[DataKey];
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
                    [self requestOrderList];
                }];
            }else{
            }
            [self.jm_collectionview.mj_footer endRefreshing];
        } else {
            [self.dataArr addObjectsFromArray:array];
            [self.jm_collectionview.mj_footer endRefreshing];
            if (array.count >= _jm_pro_pagesize) {
                //[self.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                //[self.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [self.jm_collectionview reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
    } isHideTips:YES isCache:NO];
}
//订单确认送达
-(void)requestCommentMsg:(NSString*)orderID{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    params[@"id"]=orderID;
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_order&ctrl=confirm_service" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary*dictry=respondsObject;
        NSString *mesString=dictry[MsgKey]; 
        NSInteger stateInt=[dictry[SuccessKey] integerValue];
        if(stateInt==1){
            self.jm_page=1;
            [self requestOrderList];
        }
        [FNTipsView showTips:mesString];
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}
//申请退款/取消申请接口
-(void)requestCancelApplyFor:(NSString*)orderID{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    params[@"id"]=orderID;
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_order&ctrl=apply_refund" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary*dictry=respondsObject;
        NSString *mesString=dictry[MsgKey];
        NSInteger stateInt=[dictry[SuccessKey] integerValue];
        if(stateInt==1){
            self.jm_page=1;
            [self requestOrderList];
        }
        [FNTipsView showTips:mesString];
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}
//取消订单
-(void)requestCancelOrder:(NSString*)orderID{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    params[@"id"]=orderID;
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_order&ctrl=apply_refund" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary*dictry=respondsObject;
        NSString *mesString=dictry[MsgKey];
        NSInteger stateInt=[dictry[SuccessKey] integerValue];
        if(stateInt==1){
            self.jm_page=1;
            [self requestOrderList];
        }
        [FNTipsView showTips:mesString];
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
