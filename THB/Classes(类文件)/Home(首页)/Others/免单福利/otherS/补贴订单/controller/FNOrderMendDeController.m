//
//  FNOrderMendDeController.m
//  THB
//
//  Created by Jimmy on 2018/12/19.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//补贴订单
#import "FNOrderMendDeController.h"
//view
#import "FNitemMakeDeCell.h"
#import "YTTextViewAlertView.h"
//model
#import "FNitemMakeDeModel.h"
@interface FNOrderMendDeController ()<UICollectionViewDelegate,UICollectionViewDataSource,FNitemMakeDeCellDegate>
/** 数据数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *Fnid;
@property (nonatomic, strong) NSString *orderId;
@end

@implementation FNOrderMendDeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self orderMendCollectionview];
    [self apiRequestOrderMend];
}

#pragma mark - 主视图
-(void)orderMendCollectionview{
    CGFloat tableHeight=XYScreenHeight-XYNavBarHeigth-35;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 10;
    flowlayout.minimumInteritemSpacing = 10;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, tableHeight) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.hidden=YES;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNitemMakeDeCell class] forCellWithReuseIdentifier:@"mendcellId"];
    
    self.jm_collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.jm_page = 1;
        [self apiRequestOrderMend];
        [SVProgressHUD show];
        
    }];
    //self.jm_collectionview.sd_layout
    //.bottomSpaceToView(self.view, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(self.view, 0);
    self.view.backgroundColor=RGB(240, 240, 240);
    self.jm_collectionview.backgroundColor=RGB(240, 240, 240);
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FNitemMakeDeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mendcellId" forIndexPath:indexPath];
    FNitemMakeDeModel *model=[FNitemMakeDeModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    cell.delegate=self;
    cell.model=model;
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
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=FNDeviceWidth;
    CGSize size = CGSizeMake(with, 145);
    return size;
}
#pragma mark - FNitemMakeDeCellDegate // 补充单号
- (void)replenishCodeClick:(FNitemMakeDeModel*)model{
    XYLog(@"补充单号:%@",model.tip_str);
    self.Fnid=model.id;
    
    YTTextViewAlertView *alertView = [YTTextViewAlertView new];
    alertView.contentString=model.tip_str;
    [alertView show];
    @WeakObj(self);
    alertView.ytAlertViewMakeSureBlock = ^(NSString *repulse_evaluate_str) {
        NSLog(@"确定%@",repulse_evaluate_str);
        selfWeak.orderId=repulse_evaluate_str;
        [self apiRequestCategory];
    };
    
    alertView.ytAlertViewCloseBlock = ^{
        NSLog(@"取消了------VC");
    };
}
#pragma mark - Request  我的订单
- (FNRequestTool *)apiRequestOrderMend{
    @WeakObj(self);
    [SVProgressHUD show];
    [selfWeak.jm_collectionview.mj_footer endRefreshing];
    [selfWeak.jm_collectionview.mj_header endRefreshing];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
    if(self.type){
        params[@"type"]=self.type;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appMiandanOrder&ctrl=index" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSArray* array = respondsObject[DataKey];
        XYLog(@"我的订单:%@",array);
        NSMutableArray *tyArr=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dictry in array) {
            [tyArr addObject:dictry];
        }
        [SVProgressHUD dismiss];
        selfWeak.jm_collectionview.hidden=NO;
        if (selfWeak.jm_page == 1) {
            if (array.count == 0) {
                [selfWeak.jm_collectionview reloadData];
                return ;
            }
            [selfWeak.dataArray removeAllObjects];
            [selfWeak.dataArray addObjectsFromArray:tyArr];
            if (array.count >= _jm_pro_pagesize) {
                selfWeak.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.jm_page ++;
                   [selfWeak apiRequestOrderMend];
                }];
            }else{
                selfWeak.jm_collectionview.mj_footer = nil;
            }
        } else {
            [selfWeak.dataArray addObjectsFromArray:tyArr];
            if (array.count >= _jm_pro_pagesize) {
                [selfWeak.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [selfWeak.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
        
        [selfWeak.jm_collectionview reloadData];
    } failure:^(NSString *error) {

    } isHideTips:YES];
}

//mod=appapi&act=appMiandanOrder&ctrl=sub_order
#pragma mark - //补充订单号
- (FNRequestTool *)apiRequestCategory{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if(self.Fnid){
        params[@"id"]=self.Fnid;
    }
    if(self.orderId){
        params[@"orderId"]=self.orderId;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appMiandanOrder&ctrl=sub_order" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        self.jm_page = 1;
        [self apiRequestOrderMend];
    } failure:^(NSString *error) {
       
    } isHideTips:NO];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
