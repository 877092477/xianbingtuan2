//
//  FNmerDiscountsSController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerDiscountsSController.h"
#import "FNmerIssuePagController.h"
#import "FNmerMoneyOffController.h"
#import "FNAlterIssueItemContr.h"
#import "FNCustomeNavigationBar.h"
#import "FNmerDiscountsItemCell.h"
#import "FNmerDiscountsSubtractCell.h"
#import "FNmerDiscountsItemModel.h"
#import "JXCategoryView.h"
#import "FNmerLocationRedpackController.h"
@interface FNmerDiscountsSController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNmerDiscountsItemCellDelegate,FNAlterIssueItemContrDelegate,JXCategoryViewDelegate,FNmerDiscountsSubtractCellDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableArray *typeDataArr;
@property (nonatomic, strong)UIButton  *publishBtn;
@property (nonatomic, strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong)JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong)NSString *sortStr;
@end

@implementation FNmerDiscountsSController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self requestDiscounts];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
#pragma mark - set up views
- (void)jm_setupViews{
    
    CGFloat baseGap=SafeAreaTopHeight+1+44;
    if (_isNavHidden) {
        baseGap = 44;
    }
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, baseGap, FNDeviceWidth, FNDeviceHeight-baseGap-80) collectionViewLayout:flowlayout]; 
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    self.jm_collectionview.backgroundColor=RGB(246, 245, 245);
    [self.view addSubview:self.jm_collectionview];
    
    [self.jm_collectionview registerClass:[FNmerDiscountsItemCell class] forCellWithReuseIdentifier:@"FNmerDiscountsItemCellID"];
    [self.jm_collectionview registerClass:[FNmerDiscountsSubtractCell class] forCellWithReuseIdentifier:@"FNmerDiscountsSubtractCellID"];
    
    self.jm_collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.jm_page = 1;
        
        [SVProgressHUD show];
        [self requestDiscounts];
        
    }];
    
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
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.navigationView.hidden = _isNavHidden;
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.publishBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.publishBtn addTarget:self action:@selector(publishBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.publishBtn];
    [self.publishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.publishBtn.titleLabel.font=kFONT16;
    self.publishBtn.cornerRadius=5;
    self.publishBtn.sd_layout
    .leftSpaceToView(self.view, 20).rightSpaceToView(self.view, 20).bottomSpaceToView(self.view, 15).heightIs(50);
    
    
    if([self.typeStr isEqualToString:@"pub_red_packet_list"] ||
       [self.typeStr isEqualToString:@"hongbao"] ||
       [self.typeStr isEqualToString:@"position_hongbao"]){
        self.navigationView.titleLabel.text=@"红包信息";
       [self.publishBtn setBackgroundColor:RGB(255, 68, 34)];
       [self.publishBtn setTitle:@"发布红包" forState:UIControlStateNormal];
    }
    if([self.typeStr isEqualToString:@"pub_yhq_list"]){
        self.navigationView.titleLabel.text=@"优惠券信息";
       [self.publishBtn setBackgroundColor:RGB(255, 90, 0)];
       [self.publishBtn setTitle:@"发布优惠券" forState:UIControlStateNormal];
    }
    if([self.typeStr isEqualToString:@"red_packet"]){
        self.navigationView.titleLabel.text=@"红包信息";
        [self.publishBtn setBackgroundColor:RGB(255, 68, 34)];
        [self.publishBtn setTitle:@"发布红包" forState:UIControlStateNormal];
    }
    if([self.typeStr isEqualToString:@"yhq"]){
        self.navigationView.titleLabel.text=@"优惠券信息";
        [self.publishBtn setBackgroundColor:RGB(255, 90, 0)];
        [self.publishBtn setTitle:@"发布优惠券" forState:UIControlStateNormal];
    }
    if([self.typeStr isEqualToString:@"full_reduction"]){
        self.navigationView.titleLabel.text=@"满减活动";
        [self.publishBtn setBackgroundColor:RGB(2, 188, 165)];
        [self.publishBtn setTitle:@"创建满减" forState:UIControlStateNormal];
    }
    if([self.typeStr isEqualToString:@"discount"]){
        self.navigationView.titleLabel.text=@"限时折扣";
        [self.publishBtn setBackgroundColor:RGB(255, 76, 74)];
        [self.publishBtn setTitle:@"创建折扣活动" forState:UIControlStateNormal];
    }
    
    [self sortTopView];
    //[self requestDiscounts];
    
    [self requestListType];
}

#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if([self.typeStr isEqualToString:@"red_packet"] || [self.typeStr isEqualToString:@"yhq"]||[self.typeStr isEqualToString:@"pub_red_packet_list"]||[self.typeStr isEqualToString:@"hongbao"] ||
       [self.typeStr isEqualToString:@"position_hongbao"]||[self.typeStr isEqualToString:@"pub_yhq_list"]){
        FNmerDiscountsItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerDiscountsItemCellID" forIndexPath:indexPath];
        cell.model=self.dataArr[indexPath.row];
        cell.backgroundColor=RGB(246, 245, 245);
        cell.delegate=self;
        cell.index=indexPath;
        return cell;
    }else{
        FNmerDiscountsSubtractCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerDiscountsSubtractCellID" forIndexPath:indexPath];
        cell.backgroundColor=RGB(246, 245, 245);
        cell.model=self.dataArr[indexPath.row];
        cell.delegate=self;
        cell.index=indexPath;
        return cell;
    } 
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNmerDiscountsItemModel *model=self.dataArr[indexPath.row];
    CGFloat itemHeight=model.rowHeight;
    CGFloat itemWith=FNDeviceWidth;
    if([self.typeStr isEqualToString:@"red_packet"] || [self.typeStr isEqualToString:@"yhq"]||[self.typeStr isEqualToString:@"pub_red_packet_list"]||[self.typeStr isEqualToString:@"hongbao"] ||
       [self.typeStr isEqualToString:@"position_hongbao"]||[self.typeStr isEqualToString:@"pub_yhq_list"]){
       itemHeight=model.rowHeight;
    }else{
       itemHeight=126;
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
    return 13;
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=10;
    CGFloat leftGap=0;
    CGFloat bottomGap=0;
    CGFloat rightGap=0;
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
}
#pragma mark - 交易类型
-(void)sortTopView{
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, _isNavHidden ? 0 : SafeAreaTopHeight+1, FNDeviceWidth, 44)];
    self.categoryView.delegate = self;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.selectedAnimationEnabled=YES;
    self.categoryView.backgroundColor=[UIColor whiteColor];
    //self.categoryView.contentEdgeInsetLeft=15;
    //self.categoryView.contentEdgeInsetRight=15;
    //lineView
    self.lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
    
    //line颜色
    self.lineView.indicatorHeight=2;
    self.categoryView.indicators = @[self.lineView];
    [self.view addSubview:self.categoryView];
    
//    self.categoryView.titleFont=kFONT14;
//    self.categoryView.titleSelectedFont=kFONT16;
//    self.categoryView.titleColor=RGB(51, 51, 51);
//    self.categoryView.titleSelectedColor=RGB(51, 51, 51);
//    self.lineView.indicatorColor=RGB(255, 68, 68);;
//    self.categoryView.titles =@[@"全部",@"进行中",@"未开始",@"过期/下架"];
//    self.lineView.verticalMargin=5;
//    [self.categoryView reloadData];
    
    UIView *topLine=[[UIView alloc]init];
    [self.view addSubview:topLine];
    topLine.backgroundColor=RGB(246, 245, 245);
    topLine.sd_layout
    .topSpaceToView(self.view, SafeAreaTopHeight).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(1);
    topLine.hidden = _isNavHidden;
}
//点击分类
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    XYLog(@"%ld",(long)index);
    FNmerDiscountsTopTypeModel *model=self.typeDataArr[index];
    self.sortStr=model.type;
    self.jm_page=1;
    [self requestDiscounts];
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//发布
-(void)publishBtnAction{   
    if([self.typeStr isEqualToString:@"full_reduction"]){
        FNmerMoneyOffController *vc=[[FNmerMoneyOffController alloc]init];
        vc.typeStyle=self.typeStr;
        vc.inMerMoneyOffData = ^{
           self.jm_page=1;
           [self requestDiscounts];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.typeStr isEqualToString:@"position_hongbao"]) {
        FNmerLocationRedpackController *vc = [[FNmerLocationRedpackController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        FNmerIssuePagController *vc=[[FNmerIssuePagController alloc]init];
        vc.typeStyle=self.typeStr;
        if([self.typeStr isEqualToString:@"hongbao"]){
            vc.typeStyle=@"red_packet";
        }
        vc.inMerIssuePagData = ^{
           self.jm_page=1;
           [self requestDiscounts];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - // FNmerDiscountsItemCellDelegate 红包||优惠券
//刷新某一行
- (void)didMerDiscountsRefreshIndex:(NSIndexPath*)index{
    FNmerDiscountsItemModel *model=self.dataArr[index.row];
    model.rowHeight=205;
    @weakify(self);
    [UIView performWithoutAnimation:^{
        @strongify(self);
        //[self.jm_collectionview reloadData];
        [self.jm_collectionview reloadItemsAtIndexPaths:@[index]];
    }];
}
// 修改
- (void)didMerDiscountsAmendIndex:(NSIndexPath*)index{
    
    FNmerDiscountsItemModel *model=self.dataArr[index.row];
    
    if([self.typeStr isEqualToString:@"position_hongbao"]){
        FNmerLocationRedpackController *vc = [[FNmerLocationRedpackController alloc] init];
        vc.redpackId = model.id;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    FNAlterIssueItemContr *vc=[[FNAlterIssueItemContr alloc]init];
    vc.pagId=model.id;
    vc.typeStyle=self.typeStr;
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
// 上架||下架
- (void)didMerDiscountsStateIndex:(NSIndexPath*)index{
    FNmerDiscountsItemModel *model=self.dataArr[index.row];
    if([model.id kr_isNotEmpty]){
       [self requestAmendState:model.id];
    }
}
#pragma mark - FNmerDiscountsSubtractCellDelegate  满减||折扣 : 修改 上架||下架
// 修改
- (void)didMerDiscountsSubtractAmendIndex:(NSIndexPath*)index{
    FNmerDiscountsItemModel *model=self.dataArr[index.row];
    if([self.typeStr isEqualToString:@"full_reduction"]){
        FNmerMoneyOffController *vc=[[FNmerMoneyOffController alloc]init];
        vc.typeStyle=self.typeStr;
        vc.activityID=model.id;
        vc.inMerMoneyOffData = ^{
            self.jm_page=1;
            [self requestDiscounts];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    if([self.typeStr isEqualToString:@"discount"]){
        FNmerIssuePagController *vc=[[FNmerIssuePagController alloc]init];
        vc.typeStyle=self.typeStr;
        vc.idAlter=model.id;
        vc.inMerIssuePagData = ^{
            self.jm_page=1;
            [self requestDiscounts];
        };
        [self.navigationController pushViewController:vc animated:YES]; 
    }
}
// 上架||下架
- (void)didMerDiscountsSubtractStateIndex:(NSIndexPath*)index{
    FNmerDiscountsItemModel *model=self.dataArr[index.row];
    if([model.id kr_isNotEmpty]){
       [self requestSubtractState:model.id];
    }
}
#pragma mark - FNAlterIssueItemContrDelegate
// 修改成功
- (void)didMerAlterIssueRevampMsg{
    self.jm_page = 1;
    [self requestDiscounts];
}
#pragma mark - request
//商家中心-红包or优惠券列表
-(void)requestDiscounts{
//-(FNRequestTool*)requestDiscounts{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
    NSString *urlString=@"mod=appapi&act=rebate_store_activity&ctrl=full_reduction_list";
   //hongbao 红包 yhq 优惠券
    NSString *type=@"";
    if([self.typeStr isEqualToString:@"pub_red_packet_list"]){
        urlString=@"mod=appapi&act=small_store&ctrl=red_packet_list";
        params[@"type"]=@"hongbao";
        type=@"red_packet";
        if([self.sortStr kr_isNotEmpty]){
            params[@"s_type"]=self.sortStr;
        }
    }
    if([self.typeStr isEqualToString:@"hongbao"] ||
       [self.typeStr isEqualToString:@"position_hongbao"]){
        urlString=@"mod=appapi&act=small_store&ctrl=red_packet_list";
        params[@"type"]=self.typeStr;
        type=@"red_packet";
        if([self.sortStr kr_isNotEmpty]){
            params[@"s_type"]=self.sortStr;
        }
    }
    if([self.typeStr isEqualToString:@"pub_yhq_list"]){
        urlString=@"mod=appapi&act=small_store&ctrl=red_packet_list";
        type=@"yhq";
        params[@"type"]=@"yhq";
        if([self.sortStr kr_isNotEmpty]){
            params[@"s_type"]=self.sortStr;
        }
    }
    if([self.typeStr isEqualToString:@"red_packet"]){
        urlString=@"mod=appapi&act=small_store&ctrl=red_packet_list";
        type=@"red_packet";
        params[@"type"]=@"hongbao";
        if([self.sortStr kr_isNotEmpty]){
            params[@"s_type"]=self.sortStr;
        }
    }
    if([self.typeStr isEqualToString:@"yhq"]){
        urlString=@"mod=appapi&act=small_store&ctrl=red_packet_list";
        type=@"yhq";
        params[@"type"]=@"yhq";
        if([self.sortStr kr_isNotEmpty]){
            params[@"s_type"]=self.sortStr;
        }
    }
    if([self.typeStr isEqualToString:@"full_reduction"]){
        urlString=@"mod=appapi&act=rebate_store_activity&ctrl=full_reduction_list";
        if([self.sortStr kr_isNotEmpty]){
            params[@"type"]=self.sortStr;
        }
    }
    if([self.typeStr isEqualToString:@"discount"]){
        urlString=@"mod=appapi&act=rebate_store_activity&ctrl=discount_list";
        if([self.sortStr kr_isNotEmpty]){
            params[@"type"]=self.sortStr;
        }
    }
    
//    return [FNRequestTool requestWithParams:params api:urlString respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
//        @strongify(self);
//        NSArray *enArr=respondsObject[DataKey];
//        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
//        if(enArr.count>0){
//            [enArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                FNmerDiscountsItemModel *model=[FNmerDiscountsItemModel mj_objectWithKeyValues:obj];
//                model.rowHeight=175;
//                model.typeStr=type;
//                //model.typeZY=self.typeStr;
//                [arrM addObject:model];
//            }];
//        }
//        NSArray *array =arrM;
//        if (self.jm_page == 1) {
//            if (array.count == 0) {
//                [self.dataArr removeAllObjects];
//                [self.jm_collectionview reloadData];
//                return ;
//            }
//            [self.dataArr removeAllObjects];
//            [self.dataArr addObjectsFromArray:array];
//            if (array.count >= _jm_pro_pagesize) {
//                self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//                    self.jm_page ++;
//                    [self requestDiscounts];
//                }];
//            }else{
//            }
//        } else {
//            [self.dataArr addObjectsFromArray:array];
//            if (array.count >= _jm_pro_pagesize) {
//                [self.jm_collectionview.mj_footer endRefreshing];
//
//            }else{
//                [self.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
//            }
//        }
//        [self.jm_collectionview reloadData];
//        [SVProgressHUD dismiss];
//    } failure:^(NSString *error) {
//    } isHideTips:YES isCache:NO];

    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:urlString successBlock:^(id responseBody) {
        XYLog(@"responseBody=%@",responseBody);
        @strongify(self);
        NSArray *enArr=responseBody[DataKey];
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        if(enArr.count>0){
            [enArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNmerDiscountsItemModel *model=[FNmerDiscountsItemModel mj_objectWithKeyValues:obj];
                model.typeZY=self.typeStr;
                model.typeStr=type;
                if([self.typeStr isEqualToString:@"red_packet"] || [self.typeStr isEqualToString:@"hongbao"] || [self.typeStr isEqualToString:@"position_hongbao"]){
                   model.rowHeight=175;
                }
                if([self.typeStr isEqualToString:@"yhq"]){
                   model.rowHeight=153;
                }
                model.typeStr=type;
                [arrM addObject:model];
            }];
        }
        NSArray *array =arrM;//respondsObject[DataKey];
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
                    [self requestDiscounts];
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
        [self.jm_collectionview.mj_header endRefreshing];
        [self.jm_collectionview reloadData];
        [SVProgressHUD dismiss];
    } failureBlock:^(NSString *error) {
    }];
}
//商家中心-红包下架or上架
-(void)requestAmendState:(NSString*)idStr{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],@"id":idStr}];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=change_status" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self); 
        NSInteger state=[respondsObject[SuccessKey] integerValue];
        NSString *msgStr=respondsObject[MsgKey];
        [FNTipsView showTips:msgStr];
        if(state==1){
            self.jm_page=1;
            [self requestDiscounts];
        }
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}
// 修改满减状态【上架和下架】接口
-(void)requestSubtractState:(NSString*)idStr{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],@"id":idStr}];
//    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_store_activity&ctrl=change_full_rd_status" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
//        @strongify(self);
//        NSInteger state=[respondsObject[SuccessKey] integerValue];
//        NSString *msgStr=respondsObject[MsgKey];
//        [FNTipsView showTips:msgStr];
//        if(state==1){
//            self.jm_page=1;
//            [self requestDiscounts];
//        }
//    } failure:^(NSString *error) {
//    } isHideTips:NO isCache:NO];
    
    params[@"id"]=idStr;
    NSString *urlStr=@"";
    if([self.typeStr isEqualToString:@"full_reduction"]){
        urlStr=@"mod=appapi&act=rebate_store_activity&ctrl=change_full_rd_status";
    }
    if([self.typeStr isEqualToString:@"discount"]){
        urlStr=@"mod=appapi&act=rebate_store_activity&ctrl=change_discount_status";
    }
    if(![urlStr kr_isNotEmpty]){
        return;
    }
    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:urlStr successBlock:^(id responseBody) {
        //XYLog(@"responseBody=%@",responseBody);
        @strongify(self);
        NSInteger state=[responseBody[SuccessKey] integerValue];
        NSString *msgStr=responseBody[MsgKey];
        [FNTipsView showTips:msgStr];
        if(state==1){
            self.jm_page=1;
            [self requestDiscounts];
        }
    } failureBlock:^(NSString *error) {
    }];
}
//商家中心-促销活动列表顶部分类
-(void)requestListType{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
//    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=red_packet_list_type" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
//        @strongify(self);
//        NSArray *enArr=respondsObject[DataKey];
//        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
//        NSMutableArray *arrTitleM=[NSMutableArray arrayWithCapacity:0];
//        if(enArr.count>0){
//            [enArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                FNmerDiscountsTopTypeModel *model=[FNmerDiscountsTopTypeModel mj_objectWithKeyValues:obj];
//                [arrM addObject:model];
//                [arrTitleM addObject:model.str];
//            }];
//            UIColor *colorSeleted=RGB(255, 68, 34);
//            if([self.typeStr isEqualToString:@"red_packet"]){
//                colorSeleted=RGB(255, 68, 34);
//            }
//            if([self.typeStr isEqualToString:@"yhq"]){
//                colorSeleted=RGB(255, 90, 0);
//                [self.publishBtn setBackgroundColor:RGB(255, 90, 0)];
//            }
//            if([self.typeStr isEqualToString:@"full_reduction"]){
//               colorSeleted=RGB(2, 188, 165);
//                [self.publishBtn setBackgroundColor:RGB(2, 188, 165)];
//            }
//            if([self.typeStr isEqualToString:@"discount"]){
//                colorSeleted=RGB(255, 76, 74);
//            }
//            self.typeDataArr=arrM;
//            self.categoryView.titleFont=kFONT14;
//            self.categoryView.titleSelectedFont=kFONT16;
//            self.categoryView.titleColor=RGB(51, 51, 51);
//            self.categoryView.titleSelectedColor=RGB(51, 51, 51);
//            self.lineView.indicatorColor=colorSeleted;
//            self.categoryView.titles =arrTitleM;
//            self.lineView.verticalMargin=5;
//            [self.categoryView reloadData];
//        }
//    } failure:^(NSString *error) {
//    } isHideTips:NO isCache:NO];
    
    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:@"mod=appapi&act=small_store&ctrl=red_packet_list_type" successBlock:^(id responseBody) {
        XYLog(@"responseBody=%@",responseBody);
        @strongify(self);
        NSArray *enArr=responseBody[DataKey];
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arrTitleM=[NSMutableArray arrayWithCapacity:0];
        if(enArr.count>0){
            [enArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNmerDiscountsTopTypeModel *model=[FNmerDiscountsTopTypeModel mj_objectWithKeyValues:obj];
                [arrM addObject:model];
                [arrTitleM addObject:model.str];
            }];
            UIColor *colorSeleted=RGB(255, 68, 34);
            if([self.typeStr isEqualToString:@"red_packet"]){
                colorSeleted=RGB(255, 68, 34);
            }
            if([self.typeStr isEqualToString:@"yhq"]){
                colorSeleted=RGB(255, 90, 0);
            }
            if([self.typeStr isEqualToString:@"full_reduction"]){
                colorSeleted=RGB(2, 188, 165);
            }
            if([self.typeStr isEqualToString:@"discount"]){
                colorSeleted=RGB(255, 76, 74);
            }
            self.typeDataArr=arrM;
            self.categoryView.titleFont=kFONT14;
            self.categoryView.titleSelectedFont=kFONT14;
            self.categoryView.titleColor=RGB(51, 51, 51);
            self.categoryView.titleSelectedColor=RGB(51, 51, 51);
            self.lineView.indicatorColor=colorSeleted;
            self.categoryView.titles =arrTitleM;
            self.lineView.verticalMargin=5;
            [self.categoryView reloadData];
            
            FNmerDiscountsTopTypeModel *model=self.typeDataArr[0];
            self.sortStr=model.type;
            [self requestDiscounts];
        }
    } failureBlock:^(NSString *error) {
    }];
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (NSMutableArray *)typeDataArr{
    if (!_typeDataArr) {
        _typeDataArr = [NSMutableArray array];
    }
    return _typeDataArr;
}

@end
