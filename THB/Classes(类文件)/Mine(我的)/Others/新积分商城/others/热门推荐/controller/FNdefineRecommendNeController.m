//
//  FNdefineRecommendNeController.m
//  THB
//
//  Created by Jimmy on 2019/1/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//
//热门推荐 和 新品上市 共同使用
#import "FNdefineRecommendNeController.h"
#import "FNIntegralMallDetailController.h"
//view
#import "FNdefineCommodityCell.h"
#import "FNCombinedButton.h"
@interface FNdefineRecommendNeController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) NSMutableArray *screenArray;
@property(nonatomic,strong) NSMutableArray *btns;
@property(nonatomic,strong) UIView *filterview;
@property(nonatomic,strong) NSString       *sort;
@end

@implementation FNdefineRecommendNeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self arrangeView];
    [self recommendCollectionview];
    [self apiRequstScreen];
    [self apiRequestRecommendProduct];
}
#pragma mark 排序
-(void)arrangeView{
    self.filterview = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 33))];
    self.filterview.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.filterview];
    UIView *lineView= [[UIView alloc]initWithFrame:(CGRectMake(0, 32, FNDeviceWidth, 1))];
    lineView.backgroundColor = RGB(240, 239, 239);
    [self.filterview addSubview:lineView];
}
-(void)addArrangItems{
    
    if (self.screenArray.count>0) {
        NSMutableArray *name=[[NSMutableArray alloc]init];
        [self.screenArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNDefiniteScreenModel *model=[FNDefiniteScreenModel mj_objectWithKeyValues:obj];
            [name addObject:model.name];
        }];
        if (self.btns.count>=1) {
            [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self.btns removeAllObjects];
        }
        
        CGFloat width = FNDeviceWidth*0.25;
        [name enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIView* tmpview = nil;
            tmpview.userInteractionEnabled=YES;
            if (idx<1) {
                UIButton* btn = [UIButton buttonWithTitle:obj titleColor:RGB(140, 140, 140) font:kFONT13 target:self action:nil];
                //@selector(btnClicked:)
                [btn setTitleColor:RGB(255, 131, 20) forState:(UIControlStateSelected)];
                
                [self.filterview addSubview:btn];
                tmpview  = btn;
            }else{
                FNCombinedButton* btn = [[FNCombinedButton alloc]initWithImage:IMAGE(@"FJ_gray_sj") selectedImage:IMAGE(@"FJ_orSH_SJ") title:obj font:kFONT13 titleColor:RGB(140, 140, 140) selectedTitleColor:RGB(255, 131, 20) target:self action:nil];
                btn.tag = idx+100;
                [self.filterview addSubview:btn];
                tmpview  = btn;
            }
            [tmpview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, width*idx, 1, 0)) excludingEdge:(ALEdgeRight)];
            [tmpview autoSetDimension:(ALDimensionWidth) toSize:width];
            tmpview.tag = idx+100;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addarrangTapClick:)];
            [tmpview addGestureRecognizer:tap];
            [self.btns addObject:tmpview];
        }];
        
    }
}
-(void)addarrangTapClick:(id)sender{
    UITapGestureRecognizer * singleTap = (UITapGestureRecognizer *)sender;
    UIView *tmp =nil;
    NSInteger tag = [singleTap view].tag-100;
    FNDefiniteScreenModel *model=[FNDefiniteScreenModel mj_objectWithKeyValues:self.screenArray[tag]];
    if (tag==0) {
        self.sort=model.up_sort;
        UIButton* btn = self.btns[tag];
        tmp= btn;
        
    }else{
        FNCombinedButton* btn = self.btns[tag];
        btn.titleLabel.selected=!btn.titleLabel.selected;
        [btn.titleLabel setImage:IMAGE(@"FJ_orX_SJ") forState:UIControlStateNormal];
        [btn.titleLabel setImage:IMAGE(@"FJ_orSH_SJ") forState:UIControlStateSelected];
        [btn.titleLabel setTitleColor:RGB(255, 131, 20) forState:UIControlStateNormal];
        [btn.titleLabel setTitleColor:RGB(255, 131, 20) forState:UIControlStateSelected];
        tmp = btn;
        if( btn.titleLabel.selected==YES){
            self.sort=model.up_sort;
        }else{
            self.sort=model.down_sort;
        }
    }
    [self.btns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx<1) {
            UIButton* btn = obj;
            btn.selected = btn==tmp;
        }else{
            if(idx!=tag){
                FNCombinedButton* btn = obj;
                btn.titleLabel.selected=NO;
                [btn.titleLabel setImage:IMAGE(@"FJ_gray_sj") forState:UIControlStateNormal];
                [btn.titleLabel setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
                btn.selected = btn==tmp;
            }
        }
    }];
    self.jm_page=1;
    [self apiRequestRecommendProduct];
}
#pragma mark - 主视图
-(void)recommendCollectionview{
    CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight-33;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 10;
    flowlayout.minimumInteritemSpacing = 10;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 33, FNDeviceWidth, tableHeight) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.hidden=YES;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNdefineCommodityCell class] forCellWithReuseIdentifier:@"integral_commodity"];
    
    self.view.backgroundColor=RGB(240, 240, 240);
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FNdefineCommodityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"integral_commodity" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    cell.model=[FNDefiniteProductModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
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
    CGFloat high=130;
    CGSize size = CGSizeMake(with, high);
    return size;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNDefiniteProductModel *itemModel=[FNDefiniteProductModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    FNIntegralMallDetailController *vc = [FNIntegralMallDetailController new];
    vc.goodsId =itemModel.id;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - //排序文字
- (void)apiRequstScreen{
    @WeakObj(self);
    NSMutableDictionary*params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=convert_goods&ctrl=getsort" respondType:(ResponseTypeDataKey) modelType:@"" success:^(NSArray* respondsObject) {
        for (NSDictionary *Dict in respondsObject) {
            [selfWeak.screenArray addObject:Dict];
        }
        [selfWeak addArrangItems];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark - //获取产品
- (FNRequestTool *)apiRequestRecommendProduct{
    [SVProgressHUD show];
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{ @"token":UserAccessToken,PageNumber:@(self.jm_page),PageSize:@(_jm_pro_pagesize),@"is_index":@"0"}];
    if([self.SkipUIIdentifier kr_isNotEmpty]){
        params[@"SkipUIIdentifier"]=self.SkipUIIdentifier;
    }
    if([self.sort kr_isNotEmpty]){
        params[@"sort"]=self.sort;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=convert_goods&ctrl=goods" respondType:(ResponseTypeDataKey) modelType:@"" success:^(NSArray* respondsObject) {
        NSArray* array = respondsObject;
        [SVProgressHUD dismiss];
        [selfWeak.jm_collectionview.mj_footer endRefreshing];
        [selfWeak.jm_collectionview.mj_header endRefreshing];
        
        if (selfWeak.jm_page == 1) {
            if (array.count == 0) {
                [FNTipsView showTips:@"很抱歉，没有找到该类产品~"];
                return ;
            }
            [selfWeak.dataArray removeAllObjects];
            [selfWeak.dataArray addObjectsFromArray:respondsObject];
            if (array.count >= _jm_pro_pagesize) {
                selfWeak.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.jm_page ++;
                    [selfWeak apiRequestRecommendProduct];
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
        [UIView performWithoutAnimation:^{
            [selfWeak.jm_collectionview reloadData];
            [SVProgressHUD dismiss];
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
-(NSMutableArray *)screenArray{
    if (!_screenArray) {
        _screenArray = [NSMutableArray array];
    }
    return _screenArray;
}
-(NSMutableArray *)btns{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

@end
