//
//  FNPromotionalListIView.m
//  THB
//
//  Created by Jimmy on 2017/12/22.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPromotionalListIView.h"
#import "FNPromotionalListViewModel.h"
#import "FNPromotionalListTCell.h"
#import "FNPromotionalListCCell.h"
#import "FNRushToPurchaseNewCell.h"
#import "FNRushToPurchaseNoCell.h"
#import "FNPromotionalNewCell.h"
@interface FNPromotionalListIView()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, strong)FNPromotionalListViewModel* viewmodel;
@property (nonatomic,strong) UIImageView *toTopImage;
@property (nonatomic,strong) FNBaseProductModel *cautionModel;
@end

@implementation FNPromotionalListIView
- (UIImageView *)toTopImage{
    if (_toTopImage == nil) {
        _toTopImage = [[UIImageView alloc]initWithFrame:CGRectMake(XYScreenWidth-65, XYScreenHeight-XYTabBarHeight-60, 47, 47)];
        _toTopImage.image = IMAGE(@"hddb");
        [_toTopImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickToScrollTopMethod:)]];
        _toTopImage.userInteractionEnabled = YES;
        _toTopImage.hidden = YES;
    }
    return _toTopImage;
}
- (instancetype)initWithViewModel:(id<JMViewModelProtocol>)viewModel{
    self.viewmodel = (FNPromotionalListViewModel*) viewModel; 
    return [super initWithViewModel:viewModel];
}
- (void)jm_setupViews{
    [self addSubview:self.toTopImage];
    [self.toTopImage autoSetDimensionsToSize:self.toTopImage.size];
    [self.toTopImage autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_15];
    
    if ([NSString checkIsSuccess:self.viewmodel.view_type andElement:@"2"]) {
        self.jm_tableview.alpha = 0;
        self.jm_tableview.backgroundColor=FNColor(246, 246, 246);
        self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.jm_tableview];
        [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
        @weakify(self);
        self.jm_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            self.viewmodel.jm_page = 1;
            [self.viewmodel.refreshDataCommand execute:nil];
        }];
        if (@available(iOS 11.0, *)) {
            self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
          
        }
        [self.toTopImage autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.jm_tableview withOffset:-20];
    }else{
        UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
//        flowlayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        flowlayout.minimumLineSpacing = 0;
        flowlayout.minimumInteritemSpacing = 0;
        
        self.jm_collectionview = [[UICollectionView alloc]initWithFrame:(CGRectZero) collectionViewLayout:flowlayout];
        self.jm_collectionview.dataSource = self;
        self.jm_collectionview.delegate = self;
        self.jm_collectionview.backgroundColor = FNHomeBackgroundColor;
        [self.jm_collectionview registerClass:[FNPromotionalListCCell class] forCellWithReuseIdentifier:@"FNPromotionalListCCell"];
        [self.jm_collectionview registerClass:[FNPromotionalNewCell class] forCellWithReuseIdentifier:@"FNPromotionalNewCell"];
//        self.jm_collectionview.alpha = 0;
        [self addSubview:self.jm_collectionview];
        [self.jm_collectionview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
        @weakify(self);
        self.jm_collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            self.viewmodel.jm_page = 1;
            [self.viewmodel.refreshDataCommand execute:nil];
        }];
        if (@available(iOS 11.0, *)) {
            self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self.toTopImage autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.jm_collectionview withOffset:-20];
    }
    [self bringSubviewToFront:self.toTopImage];
}
- (void)jm_bindViewModel{
    [SVProgressHUD show];
    [self.viewmodel.refreshDataCommand execute:nil];
    [[self.viewmodel.refreshUI takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        if ([NSString checkIsSuccess:self.viewmodel.view_type andElement:@"2"]) {
            [self.jm_tableview reloadData];
          
            if (self.jm_tableview.alpha == 0) {
                [UIView animateWithDuration:0.5 animations:^{
                    self.jm_tableview.alpha = 1;
                }];
            }
        }else{
            [self.jm_collectionview reloadData];
//            if (self.jm_collectionview.alpha == 0) {
//                [UIView animateWithDuration:0.5 animations:^{
//                    self.jm_collectionview.alpha = 1;
//                }];
//            }
            
        }
        
    }];
    if ([NSString checkIsSuccess:self.viewmodel.view_type andElement:@"2"]) {
        [[self.viewmodel.refreshEndSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) { 
            JMRefreshDataStatus statu = [x integerValue];
            switch (statu) {
                case JMRefreshHeader_HasMoreData:
                {
                    self.jm_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                        self.viewmodel.jm_page ++;
                        [self.viewmodel.refreshDataCommand execute:nil];
                    }];
                    [self.jm_tableview.mj_header endRefreshing];
                    break;
                }
                case JMRefreshHeader_HasNoMoreData:{
                    self.jm_tableview.mj_footer = nil;
                    [self.jm_tableview.mj_header endRefreshing];
                    break;
                }
                case JMRefreshFooter_HasMoreData:
                {
                    [self.jm_tableview.mj_footer endRefreshing];
                    break;
                }
                case JMRefreshFooter_HasNoMoreData:
                {
                    [self.jm_tableview.mj_footer endRefreshingWithNoMoreData];
                    break;
                }
                case JMRefreshError:{
                    [self.jm_tableview.mj_header endRefreshing];
                    [self.jm_tableview.mj_footer endRefreshing];
                    break;
                }
                    
                default:
                    break;
            }
        }];
    }else{
        [[self.viewmodel.refreshEndSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
            JMRefreshDataStatus statu = [x integerValue];
            switch (statu) {
                case JMRefreshHeader_HasMoreData:
                {
                    self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                        self.viewmodel.jm_page ++;
                        [self.viewmodel.refreshDataCommand execute:nil];
                    }];
                    [self.jm_collectionview.mj_header endRefreshing];
                    break;
                }
                case JMRefreshHeader_HasNoMoreData:{
                    self.jm_collectionview.mj_footer = nil;
                    [self.jm_collectionview.mj_header endRefreshing];
                    break;
                }
                case JMRefreshFooter_HasMoreData:
                {
                    [self.jm_collectionview.mj_footer endRefreshing];
                    break;
                }
                case JMRefreshFooter_HasNoMoreData:
                {
                    [self.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
                    break;
                }
                case JMRefreshError:{
                    [self.jm_collectionview.mj_header endRefreshing];
                    [self.jm_collectionview.mj_footer endRefreshing];
                    break;
                }
                    
                default:
                    break;
            }
        }];
    }
   
}
#pragma mark - action
-(void)ClickToScrollTopMethod:(UIGestureRecognizer *)sender{
    if ([NSString checkIsSuccess:self.viewmodel.view_type andElement:@"2"]) {
        [self.jm_tableview setContentOffset:CGPointMake(0,0) animated:YES];
    }else{
        [self.jm_collectionview setContentOffset:CGPointMake(0,0) animated:YES];
    }
    
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewmodel.products.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*FNPromotionalListTCell* cell = [FNPromotionalListTCell cellWithTableView:tableView atIndexPath:indexPath];
    cell.status = self.viewmodel.status;
    cell.model = self.viewmodel.products[indexPath.row];
    return cell;*/
 
    NSString*status=self.viewmodel.status;
    if ([status integerValue]==1){
        static NSString *reuseIdentifier = @"FNRushToPurchaseNewCell";
        FNRushToPurchaseNewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!cell) {
            cell = [[FNRushToPurchaseNewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
        cell.status = self.viewmodel.status;
        cell.model = self.viewmodel.products[indexPath.row]; 
        return cell;
    }else{
            static NSString *reuseIdentifier = @"FNRushToPurchaseNoCell";
            FNRushToPurchaseNoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
            if (!cell) {
                cell = [[FNRushToPurchaseNoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
            }
            @weakify(self);
            cell.ActionAdmonishNow = ^(FNBaseProductModel *model) {
                @strongify(self);
                self.cautionModel=model;
                NSInteger remind=[model.remind integerValue];
                if(remind==0){
                     [self apiRequestCaution];
                }else{
                     [self apiRequestCancelCaution];
                }
            };
            cell.model = self.viewmodel.products[indexPath.row];
            return cell;
    }
    
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = _plt_cell_height+10;
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 2;
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat height = 2;
    return height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FNBaseProductModel* model = self.viewmodel.products[indexPath.row];
    if (model.is_qiangguang.boolValue) {
        //
        [FNTipsView showTips:@"亲，商品太火爆了已经被抢光了"];
//        [FNTipsView showTips:@"亲，商品太火爆了已经被抢光了"];
    }else if ([NSString checkIsSuccess:self.viewmodel.status andElement:@"0"]){
        [FNTipsView showTips:@"亲，活动还没开始，请耐心等待!"];
    }else{
        [self.viewmodel.cellClickSubject sendNext:self.viewmodel.products[indexPath.row]];
    }
    
}

#pragma mark - Colleciton view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.viewmodel.products.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    FNPromotionalListCCell* cell = [FNPromotionalListCCell cellWithCollectionView:collectionView atIndexPath:indexPath];
//    cell.view_type = self.viewmodel.view_type;
//    cell.model = self.viewmodel.products[indexPath.item];
//    cell.backgroundColor = FNWhiteColor;
    FNPromotionalNewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNPromotionalNewCell" forIndexPath:indexPath];
    cell.view_type = self.viewmodel.view_type;
    cell.model = self.viewmodel.products[indexPath.item];
    [cell setIsLeft: indexPath.row % 2 == 0];
//    cell.backgroundColor = FNWhiteColor;
    return cell;
}
#pragma mark - Collection view delegate flow layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    CGSize size = CGSizeZero;
//    CGFloat width = (JMScreenWidth-5*3)*0.5;
//    CGFloat height = width+110;
//    size = CGSizeMake(width, height);
//
//    return size;
    int w = FNDeviceWidth/2;
    CGFloat h = w+110;
    if (indexPath.row % 2 == 1) //防止出现缝隙
        w = FNDeviceWidth - w;
    return CGSizeMake(w, h);
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.viewmodel.cellClickSubject sendNext:self.viewmodel.products[indexPath.item]];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;

    if (offsetY >XYScreenHeight) {
        
        _toTopImage.hidden = NO;
    }else{
        _toTopImage.hidden = YES;
    }
   
    
}

//提醒
- (FNRequestTool *)apiRequestCaution{
    
    NSString *token = UserAccessToken;
    NSString *fnuo_idString = self.cautionModel.fnuo_id;
    NSString *goods_title = self.cautionModel.goods_title;
    NSString *date_time = self.cautionModel.qg_time;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token,@"fnuo_id":fnuo_idString,@"goods_title":goods_title,@"date_time":date_time}];
    @WeakObj(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appCate&ctrl=getRemind" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"提醒结果:%@",respondsObject);
        [selfWeak jm_bindViewModel];
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
//取消提醒
- (FNRequestTool *)apiRequestCancelCaution{
    
    NSString *token = UserAccessToken;
    NSString *fnuo_idString = self.cautionModel.fnuo_id;
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token,@"fnuo_id":fnuo_idString}];
    @WeakObj(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appCate&ctrl=cancelRemind" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"取消提醒结果:%@",respondsObject);
       [selfWeak jm_bindViewModel];
    } failure:^(NSString *error) {
        
    } isHideTips:NO];
}
@end
