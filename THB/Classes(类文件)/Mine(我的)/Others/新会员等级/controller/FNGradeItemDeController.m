//
//  FNGradeItemDeController.m
//  THB
//
//  Created by Jimmy on 2019/1/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNGradeItemDeController.h"
//model
#import "FNgradeUeModel.h"
//view
#import "FNgradeUeCell.h"
#import "FNgradeFiltrateUeCell.h"
@interface FNGradeItemDeController ()<UICollectionViewDelegate,UICollectionViewDataSource,FNgradeFiltrateUeCellDelegate>
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) FNgradeHeadModel *headModel;
@property(nonatomic,strong) NSString *phoneString;
@property(nonatomic,strong) NSString *sortString;
@property(nonatomic,assign) NSInteger sortPalce;
@end

@implementation FNGradeItemDeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sortPalce=0;
    [self gradeUserListCollectionview];
    
    [self apiRequestGradeUserList];
    [self apiRequestGradeUe];
    
}
#pragma mark - 主视图
-(void)gradeUserListCollectionview{
    CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight-33-15;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 10;
    flowlayout.minimumInteritemSpacing = 10;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 15, FNDeviceWidth, tableHeight) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.hidden=YES;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNgradeUeCell class] forCellWithReuseIdentifier:@"gradeUeCellID"];
    [self.jm_collectionview registerClass:[FNgradeFiltrateUeCell class] forCellWithReuseIdentifier:@"gradeFiltrateUeCellID"];
    
    self.view.backgroundColor=RGB(240, 240, 240);
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){
       return 1;
    }else{
       return self.dataArray.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){
        FNgradeFiltrateUeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"gradeFiltrateUeCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.delegate=self;
        cell.model=self.headModel;
        cell.sortPalce=self.sortPalce;
        return cell;
    }else{
        FNgradeUeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"gradeUeCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=[FNgradeUeModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
        return cell;
    }
    
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
    CGFloat high=0;
    if(indexPath.section==0){
        high=80;
    }else{
        high=65;
    }
    CGSize size = CGSizeMake(with, high);
    
    return size;
}
#pragma mark - //FNgradeFiltrateUeCellDelegate <NSObject>
// 点击排序
- (void)filtrateIntegralClickWithPlace:(NSInteger)place WithState:(NSInteger)state{
    self.sortPalce=place;
    NSArray *listArr=self.headModel.list;
    if(listArr.count>0){
       FNgradeSortItemModel *model=[FNgradeSortItemModel mj_objectWithKeyValues:listArr[place]];
        if(state==1){
            self.sortString=model.sort_asc;
        }
        else{
            self.sortString=model.sort_desc;
        }
        self.jm_page=1;
        [self apiRequestGradeUserList];
    }
    
}
- (void)filtrateIntegralPhone:(NSString*)phoneString{
    XYLog(@"phoneString:%@",phoneString);
    if([phoneString kr_isNotEmpty]){
        
        self.phoneString=phoneString;
        self.jm_page=1;
        [self apiRequestGradeUserList];
    }
    
}
#pragma mark - //会员等级用户列表
- (FNRequestTool *)apiRequestGradeUserList{
    [SVProgressHUD show];
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{ @"token":UserAccessToken,PageNumber:@(self.jm_page),PageSize:@(_jm_pro_pagesize),@"is_index":@"0"}];
    //sort排序 传接口的type
    //phone关键词手机号
    //type 会员等级类型
    if([self.type kr_isNotEmpty]){
        params[@"type"]=self.type;
    }
    if([self.phoneString kr_isNotEmpty]){
        params[@"phone"]=self.phoneString;
    }
    if([self.sortString kr_isNotEmpty]){
        params[@"sort"]=self.sortString;
    } 
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection&ctrl=mem_list" respondType:(ResponseTypeDataKey) modelType:@"" success:^(NSArray* respondsObject) {
        NSArray* array = respondsObject;
        [SVProgressHUD dismiss];
        [selfWeak.jm_collectionview.mj_footer endRefreshing];
        [selfWeak.jm_collectionview.mj_header endRefreshing];
        
        if (selfWeak.jm_page == 1) {
            if (array.count == 0) {
                
                return ;
            }
            [selfWeak.dataArray removeAllObjects];
            [selfWeak.dataArray addObjectsFromArray:respondsObject];
            if (array.count >= _jm_pro_pagesize) {
                selfWeak.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.jm_page ++;
                    [selfWeak apiRequestGradeUserList];
                }];
            }else{
                selfWeak.jm_collectionview.mj_footer = nil;
            }
            
        } else {
            [selfWeak.dataArray addObjectsFromArray:respondsObject];
            if (array.count >= _jm_pro_pagesize) {
                [selfWeak.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [selfWeak.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        selfWeak.jm_collectionview.hidden = NO;
        //只刷新商品列表
        
        //[selfWeak.jm_collectionview reloadData];
        [selfWeak.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

#pragma mark - //会员等级页面
- (FNRequestTool *)apiRequestGradeUe{
    
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{ @"token":UserAccessToken}];
    
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection&ctrl=mem_datacolumn" respondType:(ResponseTypeDataKey) modelType:@"" success:^(NSArray* respondsObject) {
        
        self.headModel=[FNgradeHeadModel mj_objectWithKeyValues:respondsObject];
        [SVProgressHUD dismiss];
        
        //[selfWeak.jm_collectionview reloadData];
        [selfWeak.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:0]];
        
        
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
