//
//  FNmerchentOrderDetailsController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/6.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerchentOrderDetailsController.h"
#import "FNCustomeNavigationBar.h"
#import "FNmerOrderTopItemCell.h"
#import "FNmerOrderGoodsItemCell.h"
#import "FNmerOrderHintItemCell.h"
#import "FNmerOrderMsgItemCell.h"
#import "FNmerOrderAddressCellCollection.h"
#import "FNmerOrderZModel.h"
#import "FNmerOrderCheckCell.h"
#import "FNmerConsumeScanController.h"
@interface FNmerchentOrderDetailsController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)FNmerOrderZModel *dataModel;
@end

@implementation FNmerchentOrderDetailsController
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
}
#pragma mark - set up views
- (void)jm_setupViews{
    CGFloat baseGap=SafeAreaTopHeight+1;
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
    //self.jm_collectionview.alpha = 1;
    //self.jm_collectionview.backgroundColor = [UIColor clearColor];
    self.jm_collectionview.backgroundColor=RGB(246, 245, 245);
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNmerOrderTopItemCell class] forCellWithReuseIdentifier:@"FNmerOrderTopItemCellID"];
    [self.jm_collectionview registerClass:[FNmerOrderGoodsItemCell class] forCellWithReuseIdentifier:@"FNmerOrderGoodsItemCellID"];
    [self.jm_collectionview registerClass:[FNmerOrderHintItemCell class] forCellWithReuseIdentifier:@"FNmerOrderHintItemCellID"];
    [self.jm_collectionview registerClass:[FNmerOrderMsgItemCell class] forCellWithReuseIdentifier:@"FNmerOrderMsgItemCellID"];
    [self.jm_collectionview registerClass:[FNmerOrderAddressCellCollection class] forCellWithReuseIdentifier:@"FNmerOrderAddressCellCollection"];
    [self.jm_collectionview registerClass:[FNmerOrderCheckCell class] forCellWithReuseIdentifier:@"FNmerOrderCheckCell"];
    
    
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
    self.navigationView.titleLabel.text=@"订单详情";
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    
    self.view.backgroundColor=RGB(246, 245, 245);
    self.jm_collectionview.hidden=YES;
    
    [self requestOrderDetails];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    FNmerOrderZZHModel *centerModel=[FNmerOrderZZHModel mj_objectWithKeyValues:self.dataModel.center];
    NSArray *goodsArr=centerModel.goods;
    NSArray *ordermsgArr=self.dataModel.order_msg;
    if(section==0){
       return 1;
    }
    if (section == 1) {
        if ([self.dataModel.buy_type isEqualToString:@"toStore"]) {
            if ([self.dataModel.is_pay isEqualToString:@"1"] ) {
                return 1;
            } else {
                return 0;
            }
        } else if ([self.dataModel.buy_type isEqualToString:@"takeOut"]) {
            return 1;
        } else {
            return 0;
        }
    }
    else if(section==2){
       return goodsArr.count;
    }
    else if(section==3){
        return 1;
    }
    else if(section==4){
       return ordermsgArr.count;
    }else{
       return 0;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNmerOrderZZHModel *centerModel=[FNmerOrderZZHModel mj_objectWithKeyValues:self.dataModel.center];
    NSArray *goodsArr=centerModel.goods;
    NSArray *ordermsgArr=self.dataModel.order_msg;
    if(indexPath.section==0){
        FNmerOrderTopItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerOrderTopItemCellID" forIndexPath:indexPath];
        cell.model=self.dataModel;
        return cell;
    } else if (indexPath.section == 1) {
        if ([self.dataModel.buy_type isEqualToString:@"toStore"]) {
            FNmerOrderCheckCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerOrderCheckCell" forIndexPath:indexPath];
            [cell setModel:self.dataModel];
            return cell;
        } else {
            FNmerOrderAddressCellCollection *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerOrderAddressCellCollection" forIndexPath:indexPath];
            [cell setModel:self.dataModel];
            return cell;
        }
    }
    else if(indexPath.section==2){
        FNmerOrderGoodsItemHModel *goodsModel=[FNmerOrderGoodsItemHModel mj_objectWithKeyValues:goodsArr[indexPath.row]];
        FNmerOrderGoodsItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerOrderGoodsItemCellID" forIndexPath:indexPath];
        cell.model=goodsModel;
        return cell;
    }
    else if(indexPath.section==3){
        FNmerOrderHintItemCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerOrderHintItemCellID" forIndexPath:indexPath];
        cell.model=self.dataModel;
        [cell.contactBtn addTarget:self action:@selector(contactBtnClick)];
        return cell;
    }
    else {
        FNmerOrderZZHModel *msgModel=[FNmerOrderZZHModel mj_objectWithKeyValues:ordermsgArr[indexPath.row]];
        FNmerOrderMsgItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerOrderMsgItemCellID" forIndexPath:indexPath];
        cell.model=msgModel;
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=200;
    CGFloat itemWith=FNDeviceWidth;
    if(indexPath.section==0){
       itemHeight=120;
    }
    else if (indexPath.section == 1) {
        if ([self.dataModel.buy_type isEqualToString:@"toStore"]) {
            itemHeight=50;
        } else if ([self.dataModel.buy_type isEqualToString:@"takeOut"]) {
            itemHeight=104;
        }
    }
    else if(indexPath.section==2){
       itemHeight=47;
    }
    else if(indexPath.section==3){
       itemHeight=110;
    }
    else if(indexPath.section==4){
       itemHeight=25;
    }
    else{
       itemHeight=0;
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
    return 0;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if ([self.dataModel.is_cancel isEqualToString:@"1"] || [self.dataModel.is_use isEqualToString:@"1"]) {
//            不跳转
            return;
        }
        if ([self.dataModel.buy_type isEqualToString:@"toStore"]) {
            FNmerConsumeScanController *vc = [[FNmerConsumeScanController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=0;
    CGFloat bottomGap=0;
    CGFloat rightGap=0;
    if(section==4){
       bottomGap=30;
    }
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES]; 
}
//拨打电话
-(void)contactBtnClick{
    FNmerOrderZZHModel *centerModel=[FNmerOrderZZHModel mj_objectWithKeyValues:self.dataModel.center];
    NSString *phoneString=centerModel.user_phone;
    if([phoneString kr_isPhoneNumber]){
        NSString *str = [NSString stringWithFormat:@"tel:%@",phoneString];
        UIWebView *callWebView = [[UIWebView alloc]init];
        [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebView];
    }
}
#pragma mark - // request
//订单详情页
-(FNRequestTool*)requestOrderDetails{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.orderId kr_isNotEmpty]){
        params[@"order_id"]=self.orderId;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=order_detail" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary *dictry=respondsObject[DataKey];
        self.dataModel=[FNmerOrderZModel mj_objectWithKeyValues:dictry];
        self.jm_collectionview.hidden=NO;
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) { 
    } isHideTips:YES isCache:NO];
}
@end
