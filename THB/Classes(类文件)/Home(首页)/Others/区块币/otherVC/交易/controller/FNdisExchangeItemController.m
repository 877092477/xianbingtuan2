//
//  FNdisExchangeItemController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/7.
//  Copyright © 2019 方诺科技. All rights reserved.
//
#define COLOR_WITH_RGB(R,G,B,A) [UIColor colorWithRed:R green:G blue:B alpha:A]
#import "FNdisExchangeItemController.h" 
#import "FNdisOddBuyController.h"
#import "FNdistrictExchangeModel.h"
#import "FNdisExChangeItemCell.h"
#import "FNdisExchangeWuCell.h"
#import "FNdisExchangeHeadView.h"
#import "JMAlertView.h"
@interface FNdisExchangeItemController ()<UICollectionViewDelegate,UICollectionViewDataSource,FNdisExChangeItemCellDelegate>
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSString *headStr;
@property (nonatomic, strong)NSString *oidStr;

@property (nonatomic, strong)NSDictionary *orderDic;

@end

@implementation FNdisExchangeItemController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = COLOR_WITH_RGB(arc4random()%255/255.0, arc4random()%255/255.0, arc4random()%255/255.0, 1);
    
    //self.view.backgroundColor =RGB(250, 250, 250);
}
#pragma mark - set up views
- (void)jm_setupViews{ 
    
    self.view.backgroundColor=RGB(250, 250, 250);
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    CGFloat listTopGap=SafeAreaTopHeight+45;
    CGFloat zomHeight=self.view.frame.size.height-listTopGap-1;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 1, self.view.frame.size.width, zomHeight) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=RGB(250, 250, 250);
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNdisExChangeItemCell class] forCellWithReuseIdentifier:@"FNdisExChangeItemCellID"];
    [self.jm_collectionview registerClass:[FNdisExchangeWuCell class] forCellWithReuseIdentifier:@"FNdisExchangeWuCellID"];
    [self.jm_collectionview registerClass:[FNdisExchangeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNdisExchangeHeadView"];
    
    if([UserAccessToken kr_isNotEmpty]){
       [self requestExchangeListIsCache];
    }
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
        FNdisExChangeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNdisExChangeItemCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.delegate=self;
        cell.index=indexPath;
        FNdisExchangeOddItemModel *model=[FNdisExchangeOddItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
        cell.model=model;
        cell.type=self.type;
        return cell;
    }else{
        FNdisExchangeWuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNdisExchangeWuCellID" forIndexPath:indexPath];
        cell.backgroundColor=RGB(250, 250, 250);
        cell.stateImg.image=IMAGE(@"FN_disExWuimg");
        cell.stateLB.text=@"您暂时还没有订单哦";
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height=125;
    CGFloat with= FNDeviceWidth; 
    CGSize  size= CGSizeMake(with, height);
    if(self.dataArr.count>0){
       height=125;
    }else{
        CGFloat listTopGap=SafeAreaTopHeight+45;
        CGFloat rowheight=self.view.frame.size.height-listTopGap-1;
        height=rowheight;
    }
    return  size;
    
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    FNdisExchangeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNdisExchangeHeadView" forIndexPath:indexPath];
    headerView.backgroundColor=RGB(250, 250, 250);
    if([self.headStr kr_isNotEmpty]){
        headerView.titleLB.hidden=NO;
        headerView.titleLB.text=self.headStr;
    }else{
        headerView.titleLB.hidden=YES;
    }
    if([self.orderDic[@"order_str_bj"] kr_isNotEmpty]){
        [headerView.topBtn sd_setBackgroundImageWithURL:URL(self.orderDic[@"order_str_bj"]) forState:UIControlStateNormal];
        [headerView.topBtn setTitle:self.orderDic[@"order_str"] forState:UIControlStateNormal];
        [headerView.topBtn setTitleColor:[UIColor colorWithHexString:self.orderDic[@"order_str_color"]] forState:UIControlStateNormal];
        headerView.topBtn.hidden=NO;
    } else{
        headerView.topBtn.hidden=YES;
    }
    return headerView;
   
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=45;
    if([self.headStr kr_isNotEmpty]){
        if([self.orderDic[@"order_str_bj"] kr_isNotEmpty]){
          hight=60;
        }else{
          hight=28;
        }
    }else{
        if([self.orderDic[@"order_str_bj"] kr_isNotEmpty]){
            hight=32;
        }else{
            hight=0;
        }
    }
    return CGSizeMake(with,hight);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    XYLog(@"type=%@",self.type);
    if(self.dataArr.count>0){
        if([self.type isEqualToString:@"buy"] || [self.type isEqualToString:@"sell"]){
            FNdisExchangeOddItemModel *model=[FNdisExchangeOddItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
            FNdisOddBuyController *oddVc=[[FNdisOddBuyController alloc]init];
            oddVc.oid=model.id;
            oddVc.type=model.type;
            if([self.type isEqualToString:@"buy"]){
                oddVc.keyWord=@"购买";
            }
            if([self.type isEqualToString:@"sell"]){
                oddVc.keyWord=@"出售";
            }
            [self.naviController pushViewController:oddVc animated:YES];
        }
    }
    
}
//点击
- (void)didExChangeItemAcrossAction:(NSIndexPath*)index{
    XYLog(@"type=%ld",(long)index.row);
    if(self.dataArr.count>0){
        if([self.type isEqualToString:@"buy"] || [self.type isEqualToString:@"sell"]){
            FNdisExchangeOddItemModel *model=[FNdisExchangeOddItemModel mj_objectWithKeyValues:self.dataArr[index.row]];
            FNdisOddBuyController *oddVc=[[FNdisOddBuyController alloc]init];
            oddVc.oid=model.id;
            oddVc.type=model.type;
            if([self.type isEqualToString:@"buy"]){
                oddVc.keyWord=@"购买";
            }
            if([self.type isEqualToString:@"sell"]){
                oddVc.keyWord=@"出售";
            }
            [self.naviController pushViewController:oddVc animated:YES];
        }
    } 
}
#pragma mark - FNdisExChangeItemCellDelegate // 取消
- (void)didExChangeItemCancelAction:(NSIndexPath*)index{
    FNdisExchangeOddItemModel *model=[FNdisExchangeOddItemModel mj_objectWithKeyValues:self.dataArr[index.row]];
    self.oidStr=model.id;
    JMAlertView* alert = [JMAlertView alertWithTitle:@"提示" content:@"是否取消委托单?" firstTitle:@"取消" andSecondTitle:@"确定" alertType:(AlertTypeAlert) clickBlock:^(NSInteger index) {
        if (index == 1) {
            [self requestReleaseCancelOrder];
        }
    }];
    [alert showAlert];
}
#pragma mark - // 交易页面下详细列表
-(FNRequestTool*)requestExchangeListIsCache{
    //@WeakObj(self);
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
    if([self.type kr_isNotEmpty]){
        params[@"type"]=self.type;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=qkb&ctrl=select_jy_list" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        
        NSDictionary *dictry=respondsObject[DataKey];
        self.orderDic=respondsObject[DataKey];
        self.headStr =dictry[@"title"];
        NSArray *array =dictry[@"list"];//respondsObject;
        if (self.jm_page == 1) {
            if (array.count == 0) {
                return ;
            }
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.jm_page ++;
                    [self requestExchangeListIsCache];
                }];
            }else{
            }
        } else {
            [self.dataArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                [self.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [self.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [self.jm_collectionview reloadData];
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache:NO];
}
#pragma mark - //取消委托单
-(FNRequestTool*)requestReleaseCancelOrder{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.oidStr kr_isNotEmpty]){
        params[@"oid"]=self.oidStr;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=qkb_transaction&ctrl=cancel_order" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //NSDictionary* dict = respondsObject[DataKey];
        //XYLog(@"发布%@",respondsObject);
        @strongify(self);
        NSInteger state=[respondsObject[SuccessKey] integerValue];
        if(state==1){
            self.jm_page=1;
            [self requestExchangeListIsCache];
        }
    } failure:^(NSString *error) {
        
    } isHideTips:NO isCache:NO];
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

- (void)listDidAppear {
    XYLog(@"显示JXList");
    
    [FNNotificationCenter addObserver:self selector:@selector(updateNOIsCache) name:@"FBupdateNOIsCache" object:nil];
}
- (void)listDidDisappear {
    
}

-(void)updateNOIsCache{ 
    self.jm_page=1;
    [self requestExchangeListIsCache];
    XYLog(@"JXList已刷新");
}
-(void)dealloc{
    [FNNotificationCenter removeObserver:self];
}
@end
