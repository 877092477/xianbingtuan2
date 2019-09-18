//
//  FNReckDetailsSeController.m
//  THB
//
//  Created by Jimmy on 2018/12/26.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNReckDetailsSeController.h"
//view
#import "FNreckDetailsSeHeader.h"
#import "FNreckDetailsItemSeCell.h"
//model
#import "FNreckDetailsSeModel.h"
@interface FNReckDetailsSeController ()<UICollectionViewDelegate,UICollectionViewDataSource,FNreckDetailsItemSeCellDegate>
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)FNreckDetailsSeModel *dataModel;
@end

@implementation FNReckDetailsSeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navReckDetails];
    [self reckDetailsSeCollectionview];
    
    [self apiRequestDetails];
}
#pragma mark - 导航栏
-(void)navReckDetails{
    UIButton *leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [leftBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [leftBtn setTitle:@"账单详情" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftBtn.titleLabel.font=kFONT14;
    [leftBtn sizeToFit];
    leftBtn.size = CGSizeMake(leftBtn.width+10, leftBtn.height+10);
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [leftBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10.0f];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 主视图
-(void)reckDetailsSeCollectionview{
    CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight;
    CGFloat topInterval=SafeAreaTopHeight+45;
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
    //self.jm_collectionview.hidden=YES;
    [self.view addSubview:self.jm_collectionview];
    
    [self.jm_collectionview registerClass:[FNreckDetailsItemSeCell class] forCellWithReuseIdentifier:@"FNreckSetDeCellId"];
    [self.jm_collectionview registerClass:[FNreckDetailsSeHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNreckDeHeaderViewID"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footViewID"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footNoViewID"];
    
    self.jm_collectionview.backgroundColor=RGB(246, 245, 245);
}
#pragma mark -  FNreckDetailsItemSeCellDegate
// 复制
- (void)inDuplicateOrderIDClick:(NSIndexPath*)index{
    FNreckDetailsItemModel *model=[FNreckDetailsItemModel mj_objectWithKeyValues:self.dataModel.list[index.row]];
    XYLog(@"复制:%@",model.val);
    [[UIPasteboard generalPasteboard] setString:model.val?:@""];
    [FNTipsView showTips:@"已复制"];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;//self.dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==1){
        return self.dataModel.list.count;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNreckDetailsItemSeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNreckSetDeCellId" forIndexPath:indexPath];
    cell.backgroundColor =[UIColor whiteColor];
    if(indexPath.section==1){
        FNreckDetailsItemModel *model=[FNreckDetailsItemModel mj_objectWithKeyValues:self.dataModel.list[indexPath.row]];
        cell.model=model;
        cell.indexPath=indexPath;
        cell.delegate=self;
    }
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
    CGSize size = CGSizeMake(with, 35);
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ( [kind isEqual: UICollectionElementKindSectionHeader] ) {
        FNreckDetailsSeHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNreckDeHeaderViewID" forIndexPath:indexPath];
        //headerView.backgroundColor=RGB(245, 245, 245);
        headerView.model=self.dataModel;
        return headerView;
    }else{
        if(indexPath.section==0){
            UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footViewID" forIndexPath:indexPath];
            footView.backgroundColor=[UIColor whiteColor];
            UIView *line=[[UIView alloc]init];
            line.frame=CGRectMake(10, 7, FNDeviceWidth-20, 1);
            line.backgroundColor=RGB(246, 245, 245);
            [footView addSubview:line];
            return footView;
        }
        UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footNoViewID" forIndexPath:indexPath];
        return footView;
    } 
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=120;
    if(section==0){
        hight=120;
    }else{
        hight=0;
    }
    return CGSizeMake(with,hight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=15;
    if(section==0){
        hight=15;
    }else{
        hight=0;
    }
    return CGSizeMake(with,hight);
}
#pragma mark - //账单详情
- (FNRequestTool *)apiRequestDetails{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,}];
    if([self.Oid kr_isNotEmpty]){
        params[@"id"]=self.Oid;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=account_list&ctrl=detail" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //XYLog(@"账单头部分类:%@",respondsObject);
        //FNreckSetCateDeModel
        NSDictionary* dictry = respondsObject[DataKey];
        selfWeak.dataModel=[FNreckDetailsSeModel mj_objectWithKeyValues:dictry]; 
        selfWeak.jm_collectionview.hidden = NO;
        [UIView performWithoutAnimation:^{
            [selfWeak.jm_collectionview reloadData];
        }];
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
