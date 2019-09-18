//
//  FNmesHistoryItemController.m
//  THB
//
//  Created by Jimmy on 2018/12/21.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//历史
#import "FNmesHistoryItemController.h"
//view
#import "FNhistoryItemDeCell.h"
//model
#import "FNhistoryItemModel.h"
@interface FNmesHistoryItemController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation FNmesHistoryItemController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self historyCollectionview];
    [self apiRequestHistoryMsg];
}

#pragma mark - 主视图
-(void)historyCollectionview{
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
    [self.jm_collectionview registerClass:[FNhistoryItemDeCell class] forCellWithReuseIdentifier:@"historyItemDeCellId"];
    self.jm_collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.jm_page = 1;
        [self apiRequestHistoryMsg];
    }];
    
    self.view.backgroundColor=RGB(245, 245, 245);
    self.jm_collectionview.backgroundColor=RGB(245, 245, 245);
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FNhistoryItemDeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"historyItemDeCellId" forIndexPath:indexPath];
    FNhistoryItemModel *model=[FNhistoryItemModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
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
    FNhistoryItemModel *model=[FNhistoryItemModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    CGFloat with=FNDeviceWidth;
    CGFloat textW=FNDeviceWidth-40;
    CGSize textSize = [model.title sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(textW, MAXFLOAT)]; 
    CGSize contentSize = [model.msg sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    CGFloat height=90+textSize.height+contentSize.height;
    CGSize size = CGSizeMake(with, height);
    return size;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNhistoryItemModel *model=[FNhistoryItemModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    [self loadOtherVCWithModel:model andInfo:nil outBlock:nil];
}
#pragma mark - Request  消息中心
- (FNRequestTool *)apiRequestHistoryMsg{
    @WeakObj(self);
    [SVProgressHUD show];
    [selfWeak.jm_collectionview.mj_footer endRefreshing];
    [selfWeak.jm_collectionview.mj_header endRefreshing];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
    if(self.type){
        params[@"type"]=self.type;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=tuisong" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSArray* array = respondsObject[DataKey];
        XYLog(@"我的消息:%@",array);
        NSMutableArray *addArr=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dictry in array) {
            [addArr addObject:dictry];
        }
        [SVProgressHUD dismiss];
        selfWeak.jm_collectionview.hidden=NO;
        if (selfWeak.jm_page == 1) {
            if (array.count == 0) {
                [selfWeak.jm_collectionview reloadData];
                return ;
            }
            [selfWeak.dataArray removeAllObjects];
            [selfWeak.dataArray addObjectsFromArray:addArr];
            if (array.count >= _jm_pro_pagesize) {
                selfWeak.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.jm_page ++;
                    [selfWeak apiRequestHistoryMsg];
                }];
            }else{
                selfWeak.jm_collectionview.mj_footer = nil;
            }
        } else {
            [selfWeak.dataArray addObjectsFromArray:addArr];
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
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
