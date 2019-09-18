//
//  FNdefinHuntNeController.m
//  THB
//
//  Created by Jimmy on 2019/1/9.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdefinHuntNeController.h"
#import "FNIntegralMallDetailController.h"
//view
#import "FNCustomeNavigationBar.h"
#import "FNHuntDeLayout.h"
#import "FNdefinHuntHaderView.h"
#import "FNHuntTallyNeCell.h"
#import "FNdefineCommodityCell.h"
#import "FNCombinedButton.h"
//model
#import "CXDBHandle.h"
#import "CXSearchSectionModel.h"
#import "CXSearchModel.h"

@interface FNdefinHuntNeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate,FNdefinHuntHaderViewDelegate>

@property(nonatomic,strong)UICollectionView *huntcollectionview;

@property(nonatomic,strong)FNCustomeNavigationBar *cuNaivgationbar;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UIView   *rankView;
@property(nonatomic,strong)NSString *keyword;
@property(nonatomic,strong)NSString *sort;
@property(nonatomic,strong)NSArray  *hotArray;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *sortArr;
@property(nonatomic,strong)NSMutableArray *btns;
//存储网络请求的热搜，与本地缓存的历史搜索model数组
@property(nonatomic,strong)NSMutableArray *sectionArray;
// 存搜索的数组 字典
@property(nonatomic,strong)NSMutableArray *searchArray;
@end

@implementation FNdefinHuntNeController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self goodsListView];
    [self huntConvertCollectionview];
    [self setupNav];
    
    [self apiRequstHotVocabulary];
    [self apiRequstScreen];
    
}
#pragma mark - //导航栏
-(void)setupNav{ 
    
    _cuNaivgationbar = [FNCustomeNavigationBar customeNavigationBarWithSearchBarFrame:(CGRectMake(80, 27, FNDeviceWidth-80*2, 30)) andPlaceholder:@"搜索您想要的商品"];
    _cuNaivgationbar.searchBar.cornerRadius = 15;
    _cuNaivgationbar.searchBar.showsCancelButton=NO;
    _cuNaivgationbar.searchBar.delegate  =self;
    [_cuNaivgationbar.searchBar setImage:IMAGE(@"FJ_slices_img") forSearchBarIcon:UISearchBarIconSearch  state:UIControlStateNormal];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSFontAttributeName: kFONT13}];
    
    _cuNaivgationbar.searchBar.backgroundColor=RGB(246, 245, 245);
    
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn setImage:[UIImage imageNamed:@"FJ_leftBack_img"] forState:UIControlStateNormal];
    [self.leftBtn sizeToFit];
    self.leftBtn.size = CGSizeMake(self.leftBtn.width+10, self.leftBtn.height+10);
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.rightBtn setTitle:@"搜索" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font=kFONT14;
    [self.rightBtn setBackgroundImage:IMAGE(@"FJ_rightJX_img") forState:UIControlStateNormal];
    [self.rightBtn sizeToFit];
    self.rightBtn.size = CGSizeMake(58, 30);
    [self.rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _cuNaivgationbar.leftButton = self.leftBtn;
    _cuNaivgationbar.rightButton = self.rightBtn;
    [self.view addSubview:_cuNaivgationbar];
    _cuNaivgationbar.backgroundColor =[UIColor whiteColor];
    _cuNaivgationbar.searchBar.backgroundImage = [UIImage createImageWithColor:RGBA(246, 245, 245,0.3)];
    UITextField *searchField = [_cuNaivgationbar.searchBar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor clearColor]];
    }  
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSFontAttributeName: kFONT12}];
    UIView *lineView = [[UIView alloc]initWithFrame:(CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, 1))];
    lineView.backgroundColor = RGB(240, 239, 239);
    [self.view addSubview:lineView];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.keyword=searchBar.text;
    if(![searchText kr_isNotEmpty]){
        self.huntcollectionview.hidden=NO;
        self.jm_collectionview.hidden=YES;
        self.rankView.hidden=YES;
    }
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self rightBtnAction];  
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightBtnAction{
    if([self.keyword kr_isNotEmpty]){
        self.jm_page = 1;
        self.huntcollectionview.hidden=YES;
        self.rankView.hidden=NO;
        [self apiRequestRecommendProduct];
        [self.cuNaivgationbar.searchBar resignFirstResponder];
        /***  每搜索一次   就会存放一次到历史记录，但不存重复的*/
        if ([self.searchArray containsObject:[NSDictionary dictionaryWithObject:self.keyword forKey:@"name"]]) {
            return;
        }
        [self reloadData:self.keyword];
    }
}
//修改历史
- (void)reloadData:(NSString *)textString
{
    
    [self.searchArray addObject:[NSDictionary dictionaryWithObject:textString forKey:@"name"]];
    NSArray* reversedArray = [[self.searchArray reverseObjectEnumerator] allObjects];
    
    NSDictionary *searchDict = @{@"section_id":@"2",@"section_title":@"历史搜索",@"section_content":reversedArray};
    
    /***由于数据量并不大 这样每次存入再删除没问题  存数据*/
    NSDictionary *parmDict  = @{@"category":@"1"};
    [CXDBHandle saveStatuses:searchDict andParam:parmDict];
    
    CXSearchSectionModel *model = [[CXSearchSectionModel alloc]initWithDictionary:searchDict];
    if (self.sectionArray.count > 1) {
        //[self.sectionArray removeLastObject];
        [self.sectionArray removeObjectAtIndex:0];
    }
    [self.sectionArray addObject:model];
    NSArray* zoonArr = [[self.sectionArray reverseObjectEnumerator] allObjects];
    NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
    for (CXSearchSectionModel *model in zoonArr) {
        [arrM addObject:model];
    }
    self.sectionArray=arrM;
    
    [self.huntcollectionview reloadData];
    
}
#pragma mark - scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_cuNaivgationbar.searchBar resignFirstResponder];
}
#pragma mark - 历史 部分
-(void)huntConvertCollectionview{
    CGFloat distanceTop=SafeAreaTopHeight+1;
    CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight;
    FNHuntDeLayout *flowlayout=[[FNHuntDeLayout alloc]init];
    self.huntcollectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(10, distanceTop, FNDeviceWidth-20, tableHeight) collectionViewLayout:flowlayout];
    self.huntcollectionview.backgroundColor=[UIColor whiteColor];
    self.huntcollectionview.dataSource = self;
    self.huntcollectionview.delegate = self;
    self.huntcollectionview.showsVerticalScrollIndicator=NO;
    self.huntcollectionview.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:self.huntcollectionview];
    [self.huntcollectionview registerClass:[FNHuntTallyNeCell class] forCellWithReuseIdentifier:@"HuntTallyNeCell"];
     [self.huntcollectionview registerClass:[FNdefinHuntHaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadViewIden"];
    self.huntcollectionview.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=[UIColor whiteColor];
    
}
#pragma mark - 商品 部分
-(void)goodsListView{
    CGFloat distanceTop=SafeAreaTopHeight+33;
    CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight-33; 
    self.rankView=[[UIView alloc]initWithFrame:(CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, 33))];
    self.rankView.hidden=YES;
    self.rankView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.rankView];
    UIView *lineView=[[UIView alloc]initWithFrame:(CGRectMake(0, 32, FNDeviceWidth, 1))];
    lineView.backgroundColor = RGB(240, 239, 239);
    [self.rankView addSubview:lineView];
    UICollectionViewFlowLayout* goodsflowlayout = [UICollectionViewFlowLayout new];
    goodsflowlayout.minimumLineSpacing = 10;
    goodsflowlayout.minimumInteritemSpacing = 10;
    goodsflowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, distanceTop, FNDeviceWidth, tableHeight) collectionViewLayout:goodsflowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.hidden=YES;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNdefineCommodityCell class] forCellWithReuseIdentifier:@"integral_commodity"];
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"DefiniteStore"];
    
}
#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if(collectionView==self.huntcollectionview){
       return self.sectionArray.count;
    }else if(collectionView==self.jm_collectionview){
       return 1;
    }else{
       return 0;
    }
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(collectionView==self.huntcollectionview){
       CXSearchSectionModel *sectionModel =  self.sectionArray[section];
       return sectionModel.section_contentArray.count;
    }else if(collectionView==self.jm_collectionview){
       return self.dataArray.count;
    }else{
       return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView==self.huntcollectionview){
       FNHuntTallyNeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HuntTallyNeCell" forIndexPath:indexPath];
       CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
       CXSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
       cell.titleLB.text=contentModel.name;
       cell.titleLB.cornerRadius=14.5;
       return cell;
    }
    else if(collectionView==self.jm_collectionview){
       FNdefineCommodityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"integral_commodity" forIndexPath:indexPath];
       cell.backgroundColor=[UIColor whiteColor];
       cell.model=[FNDefiniteProductModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
       return cell;
    }else{
       UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DefiniteStore" forIndexPath:indexPath];
       return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if(collectionView==self.huntcollectionview){
        if ([kind isEqualToString: UICollectionElementKindSectionHeader]){
            FNdefinHuntHaderView* view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeadViewIden" forIndexPath:indexPath];
            view.delectDelegate = self;
            CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
            [view setText:sectionModel.section_title];
            if([sectionModel.section_id isEqualToString:@"1"]){
               view.delectButton.hidden = YES;
            }else{
               view.delectButton.hidden = NO;
            }
            reusableview = view;
        }
    }
    return reusableview;
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(collectionView==self.huntcollectionview){
        CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
        CXSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
        CGSize figureSize=[FNHuntTallyNeCell getSizeWithText:contentModel.name];
       return figureSize;
    }else{
       return  CGSizeMake(FNDeviceWidth, 130);;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView==self.huntcollectionview){
        CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
        CXSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
        self.keyword=contentModel.name;
        self.cuNaivgationbar.searchBar.text=contentModel.name;
        [self rightBtnAction];
    }
    if(collectionView==self.jm_collectionview){
        FNDefiniteProductModel *itemModel=[FNDefiniteProductModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
        FNIntegralMallDetailController *vc = [FNIntegralMallDetailController new];
        vc.goodsId =itemModel.id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark -  FNdefinHuntHaderViewDelegate<NSObject>
- (void)delectData{
    if (self.sectionArray.count > 1) {
        //[self.sectionArray removeLastObject];
        [self.sectionArray removeObjectAtIndex:0];
        [self.searchArray removeAllObjects];
        [self.huntcollectionview reloadData];
        [CXDBHandle saveStatuses:@{} andParam:@{@"category":@"1"}];
    }
}

#pragma mark - //热门推荐关键词
- (void)apiRequstHotVocabulary{
    @WeakObj(self);
    NSMutableDictionary*params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=convert_integral&ctrl=keyword" respondType:(ResponseTypeDataKey) modelType:@"" success:^(NSArray* respondsObject) {
        NSArray *arr=respondsObject;  
        selfWeak.hotArray=arr;
        [selfWeak prepareData];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
-(void)prepareData{
    
    NSMutableArray *testArray = [@[] mutableCopy];
    //历史  数据查看 是否有数据
    NSDictionary *parmDict  = @{@"category":@"1"};
    NSDictionary *dbDictionary =  [CXDBHandle statusesWithParams:parmDict];
    if (dbDictionary.count) {
        [testArray addObject:dbDictionary];
        [self.searchArray addObjectsFromArray:dbDictionary[@"section_content"]];
    }
    //热门推荐
    NSMutableDictionary*testDict = [NSMutableDictionary dictionaryWithDictionary:@{@"section_id":@"1",@"section_title":@"热门推荐",@"section_content":@[]}];
    if(self.hotArray.count>0){
        testDict[@"section_content"]=self.hotArray;
        [testArray addObject:testDict];
    }
    for (NSDictionary *sectionDict in testArray) {
        CXSearchSectionModel *model = [[CXSearchSectionModel alloc]initWithDictionary:sectionDict];
        [self.sectionArray addObject:model];
    }
    [self.huntcollectionview reloadData];
}
#pragma mark - //排序文字
- (void)apiRequstScreen{
    @WeakObj(self);
    NSMutableDictionary*params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=convert_goods&ctrl=getsort" respondType:(ResponseTypeDataKey) modelType:@"" success:^(NSArray* respondsObject) {
        for (NSDictionary *Dict in respondsObject) {
            [selfWeak.sortArr addObject:Dict];
        }
        [selfWeak addArrangItems];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark - //商品列表
- (FNRequestTool *)apiRequestRecommendProduct{
    [SVProgressHUD show];
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{ @"token":UserAccessToken,PageNumber:@(self.jm_page),PageSize:@(_jm_pro_pagesize),@"is_index":@"0"}];
    if([self.keyword kr_isNotEmpty]){
       params[@"keyword"]=self.keyword;
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
        XYLog(@"搜索=:%@",selfWeak.dataArray);
        //只刷新商品列表
        [UIView performWithoutAnimation:^{
            [selfWeak.jm_collectionview reloadData];
            [SVProgressHUD dismiss];
        }];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
-(void)addArrangItems{
    @WeakObj(self);
    if (selfWeak.sortArr.count>0) {
        NSMutableArray *name=[[NSMutableArray alloc]init];
        [selfWeak.sortArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
                [self.rankView addSubview:btn];
                tmpview  = btn;
            }else{
                FNCombinedButton* btn = [[FNCombinedButton alloc]initWithImage:IMAGE(@"FJ_gray_sj") selectedImage:IMAGE(@"FJ_orSH_SJ") title:obj font:kFONT13 titleColor:RGB(140, 140, 140) selectedTitleColor:RGB(255, 131, 20) target:self action:nil];
                btn.tag = idx+100;
                [self.rankView addSubview:btn];
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
    FNDefiniteScreenModel *model=[FNDefiniteScreenModel mj_objectWithKeyValues:self.sortArr[tag]];
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

-(NSMutableArray *)sortArr{
    if (!_sortArr) {
        _sortArr = [NSMutableArray array];
    }
    return _sortArr;
}
-(NSMutableArray *)btns{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)sectionArray
{
    if (_sectionArray == nil) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}
-(NSMutableArray *)searchArray
{
    if (_searchArray == nil) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}
@end
