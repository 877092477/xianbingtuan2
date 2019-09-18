//
//  FNDetailPunchPeController.m
//  THB
//
//  Created by 李显 on 2019/2/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//
//打卡明细
#import "FNDetailPunchPeController.h"
#import "FNcardDetailItemPeCell.h"
#import "FNnorCardTeCell.h"
#import "FNDetailCardZoModel.h"
#import "FNcardDetailPeHeaderView.h"
@interface FNDetailPunchPeController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) FNDetailCardZoModel *dataModel;
@property (nonatomic, strong)UICollectionView *detailCollectionview;
@end

@implementation FNDetailPunchPeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"挑战明细";
    [self punchDetailCollectionview];
    [self apiRequestpayType];
    [self apiRequestCardRecord];
}

#pragma mark - 打卡明细UI
-(void)punchDetailCollectionview{
    
    CGFloat tableHeight=FNDeviceHeight;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.detailCollectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, tableHeight) collectionViewLayout:flowlayout];
    self.detailCollectionview.backgroundColor=[UIColor whiteColor];
    self.detailCollectionview.dataSource = self;
    self.detailCollectionview.delegate = self;
    self.detailCollectionview.showsVerticalScrollIndicator=NO;
    self.detailCollectionview.showsHorizontalScrollIndicator=NO;
    self.detailCollectionview.hidden=YES;
    [self.view addSubview:self.detailCollectionview];
    [self.detailCollectionview registerClass:[FNcardDetailItemPeCell class] forCellWithReuseIdentifier:@"FNcardDetailItemPeCell"];
    
    [self.detailCollectionview registerClass:[FNnorCardTeCell class] forCellWithReuseIdentifier:@"FNnorCardTeCellID"];
    
    [self.detailCollectionview registerClass:[FNcardDetailPeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNcardDetailPeHeaderViewID"];
    
    [self.detailCollectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footNoViewID"];
    
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(self.dataArray.count>0){
       return self.dataArray.count;
    }
    else{
        return 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.dataArray.count>0){
        FNcardDetailItemPeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNcardDetailItemPeCell" forIndexPath:indexPath];
        cell.model=[FNDayCardZoModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
        return cell;
    }else{
        FNnorCardTeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNnorCardTeCellID" forIndexPath:indexPath];
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=FNDeviceWidth;
    CGFloat height=60;
    if(self.dataArray.count>0){
       height=60;
    }else{
       height=278;
    }
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
    
    if ([kind isEqual: UICollectionElementKindSectionHeader] ) {
        FNcardDetailPeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNcardDetailPeHeaderViewID" forIndexPath:indexPath];
        headerView.model=self.dataModel;
        return headerView;
        
    }else{
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footNoViewID" forIndexPath:indexPath];
        headerView.backgroundColor=[UIColor whiteColor];
        return headerView;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=210;
    
    return CGSizeMake(with,hight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=0;
    
    return CGSizeMake(with,hight);
}
#pragma mark - //打卡明细
- (FNRequestTool *)apiRequestpayType{
    [SVProgressHUD show];
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appClockRecord&ctrl=detail" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        selfWeak.detailCollectionview.hidden = NO;
        NSDictionary *dictry = respondsObject[DataKey];
        selfWeak.dataModel=[FNDetailCardZoModel mj_objectWithKeyValues:dictry];
        [selfWeak.detailCollectionview reloadData];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

#pragma mark - //挑战记录
- (FNRequestTool *)apiRequestCardRecord{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,@"p":@(self.jm_page)}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appClockRecord&ctrl=dk_record" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSArray *array = respondsObject[DataKey];
        [selfWeak.detailCollectionview.mj_footer endRefreshing];
        if (selfWeak.jm_page == 1) {
            if (array.count == 0) { 
                return ;
            }
            [selfWeak.dataArray removeAllObjects];
            [selfWeak.dataArray addObjectsFromArray:array];
            if (array.count >= 5) {
                selfWeak.detailCollectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.jm_page ++;
                    [selfWeak apiRequestCardRecord];
                }];
            }
            
        } else {
            [selfWeak.dataArray addObjectsFromArray:array];
            
        }
        selfWeak.detailCollectionview.hidden = NO;
        
        [selfWeak.detailCollectionview reloadData];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
