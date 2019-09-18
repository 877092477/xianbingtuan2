//
//  FNarrangeItemAeController.m
//  THB
//
//  Created by 李显 on 2019/1/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNarrangeItemAeController.h"
//view
#import "FNarrangeCommonitemCell.h"
#import "FNrankingAgoUeCell.h"
#import "FNCombinedButton.h"
//model
#import "FNarrangeItemModel.h"
#import "FNgradeUeModel.h"
@interface FNarrangeItemAeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate>
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) NSString *phoneString;
@property(nonatomic,assign) NSInteger sortInt;
@property(nonatomic,strong) NSString *sortString;
@property(nonatomic,strong) FNgradeHeadModel *headModel;
@property(nonatomic,strong) UIView *headView;
@property(nonatomic,strong) UILabel* dateLB;
@property(nonatomic,strong) UISearchBar* searchBar;
@property(nonatomic,strong) UIView *screenView;
@property(nonatomic,strong) UIImageView* bgImageView;
@property(nonatomic,strong) NSMutableArray* btns;
@end

@implementation FNarrangeItemAeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self arrangeListCollectionview];
    [self apiRequestArrangeSort];
    [self apiRequestArrangeList];
    [self topHeadView];
}
#pragma mark - 主视图
-(void)arrangeListCollectionview{
    UIImageView *bgImageView=[[UIImageView alloc]init];
    
    [self.view addSubview:bgImageView];
    bgImageView.sd_layout
    .leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0);
    if([self.bgimgUrl kr_isNotEmpty]){
        [bgImageView setNoPlaceholderUrlImg:self.bgimgUrl];
    }
    
    CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight-90-2.5;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 87.5, FNDeviceWidth-20, tableHeight) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.hidden=YES;
    self.jm_collectionview.cornerRadius=5/2;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNrankingAgoUeCell class] forCellWithReuseIdentifier:@"rankingAgoUeCellID"];
    [self.jm_collectionview registerClass:[FNarrangeCommonitemCell class] forCellWithReuseIdentifier:@"arrangeCommonitemCellID"];
    
    self.view.backgroundColor=[UIColor whiteColor];
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
    
    FNarrangeItemModel *model=[FNarrangeItemModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    NSInteger numInt=[model.num integerValue];
    
    if(numInt<4){
        FNrankingAgoUeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"rankingAgoUeCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=[FNarrangeItemModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
        return cell;
    }else{
        FNarrangeCommonitemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"arrangeCommonitemCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=[FNarrangeItemModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
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
    FNarrangeItemModel *model=[FNarrangeItemModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    NSInteger numInt=[model.num integerValue];
    CGFloat with=FNDeviceWidth-20;
    CGFloat high=0;
    if(numInt<4){
        high=215;
        with=(FNDeviceWidth-20)/3-5;
    }else{
        high=65;
        with=FNDeviceWidth-20;
    }
    CGSize size = CGSizeMake(with, high);
    
    return size;
}
-(void)topHeadView{
    self.headView=[[UIView alloc]init];
    self.headView.backgroundColor=[UIColor whiteColor];
    self.headView.cornerRadius=5/2;
    [self.view addSubview:self.headView];
    self.headView.sd_layout
    .topSpaceToView(self.view, 15).leftSpaceToView(self.view, 10).rightSpaceToView(self.view, 10).heightIs(75);
 
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.delegate=self;
    self.searchBar.backgroundImage = [UIImage createImageWithColor:FNWhiteColor];
    self.searchBar.placeholder=@"请输入手机查排名";
    self.searchBar.cornerRadius=27/2;
    self.searchBar.borderWidth=0.5;
    self.searchBar.borderColor = RGB(165,165,165);
    self.searchBar.clipsToBounds = YES;
    [self.searchBar setBackgroundColor:FNWhiteColor];
    self.searchBar.backgroundImage = [UIImage createImageWithColor:FNWhiteColor];
    [self.headView addSubview:self.searchBar];
    [self.searchBar setImage:IMAGE(@"FJ_slices_img") forSearchBarIcon:UISearchBarIconSearch  state:UIControlStateNormal];
    UITextField *searchField = [self.searchBar valueForKey:@"searchField"];
    if (searchField) {
        searchField.font=[UIFont systemFontOfSize:9];
        if ([self.searchBar.placeholder kr_isNotEmpty]) {
            NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.searchBar.placeholder attributes:
                                              @{NSForegroundColorAttributeName:RGB(165,165,165),
                                                NSFontAttributeName:[UIFont systemFontOfSize:9]}];
            searchField.attributedPlaceholder = attrString;
        }
    }
    
    self.dateLB=[UILabel new];
    self.dateLB.textColor=RGB(153,153,153);
    self.dateLB.font=kFONT12;
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    [self.headView addSubview:self.dateLB];
    
    self.screenView = [[UIView alloc]initWithFrame:(CGRectMake(10, 44, FNDeviceWidth-20-20, 26))];
    self.screenView.cornerRadius=26/2;
    [self.headView addSubview:self.screenView];
    
    self.bgImageView=[UIImageView new];
    self.bgImageView.cornerRadius=26/2;
    self.bgImageView.backgroundColor=[UIColor whiteColor];
    [self.screenView addSubview:self.bgImageView];
    
    CGFloat dateW=(FNDeviceWidth-40)/2-10;
    self.searchBar.sd_layout
    .topSpaceToView(self.headView, 8).rightSpaceToView(self.headView, 9).heightIs(27).widthIs(dateW-10);
    
    self.dateLB.sd_layout
    .leftSpaceToView(self.headView, 10).centerYEqualToView(self.searchBar).heightIs(15).widthIs(dateW);
    
    self.screenView.sd_layout
    .leftSpaceToView(self.headView, 10).rightSpaceToView(self.headView, 10).bottomSpaceToView(self.headView, 10).heightIs(26);
    
    self.bgImageView.sd_layout
    .leftSpaceToView(self.screenView, 0).rightSpaceToView(self.screenView, 0).bottomSpaceToView(self.screenView, 0).topSpaceToView(self.screenView, 0);
    
}
-(void)addSortBtnView{
    self.dateLB.text=self.headModel.update_time;//@"更新时间：2018-12-21";
    self.searchBar.placeholder=self.headModel.search_str;//@"搜索手机号码查询";
    [self.bgImageView setNoPlaceholderUrlImg:self.headModel.bg_img];
    NSMutableArray *name=[[NSMutableArray alloc]init];
    NSString *strColor=@"FFFFFF";
    if (self.headModel.list.count>0) {
        FNgradeSortItemModel *onemodel=[FNgradeSortItemModel mj_objectWithKeyValues:self.headModel.list[0]];
        strColor=onemodel.str_color;
        [self.headModel.list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNgradeSortItemModel *model=[FNgradeSortItemModel mj_objectWithKeyValues:obj];
            
            [name addObject:model.str];
        }];
    }
    if (self.btns.count>=1) {
        [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.btns removeAllObjects];
    }
    CGFloat width = (FNDeviceWidth-40)*0.25;
    [name enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FNgradeSortItemModel *onemodel=[FNgradeSortItemModel mj_objectWithKeyValues:self.headModel.list[idx]];
        NSInteger is_up=[onemodel.is_up integerValue];
        FNCombinedButton* tmpview = nil;
        tmpview.userInteractionEnabled=YES;
        //if (idx<2) {
        if (is_up==0) {
            FNCombinedButton* btn = [[FNCombinedButton alloc]initWithImage:IMAGE(@"") selectedImage:IMAGE(@"") title:obj font:kFONT13 titleColor:[UIColor colorWithHexString:strColor] selectedTitleColor:[UIColor colorWithHexString:strColor] target:self action:nil];
            [self.screenView addSubview:btn];
            tmpview  = btn;
        }else{
            FNCombinedButton* btn = [[FNCombinedButton alloc]initWithImage:IMAGE(@"FN_SX_sortImg") selectedImage:IMAGE(@"FJ_orSH_SJ") title:obj font:kFONT12 titleColor:[UIColor colorWithHexString:strColor] selectedTitleColor:[UIColor colorWithHexString:strColor] target:self action:nil];
            [btn.titleLabel sd_setImageWithURL:[NSURL URLWithString:self.headModel.sort_img] forState:UIControlStateNormal];
            [btn.titleLabel sd_setImageWithURL:[NSURL URLWithString:self.headModel.sort_ascimg] forState:UIControlStateSelected];
            
            btn.tag = idx+100;
            [self.screenView addSubview:btn];
            tmpview  = btn;
        }
        [tmpview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, width*idx, 0, 0)) excludingEdge:(ALEdgeRight)];
        [tmpview autoSetDimension:(ALDimensionWidth) toSize:width];
        tmpview.tag = idx+100;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [tmpview addGestureRecognizer:tap];
        [self.btns addObject:tmpview];
    }];
}
#pragma mark - action
-(void)tapClick:(id)sender{
    UITapGestureRecognizer * singleTap = (UITapGestureRecognizer *)sender;
    
    UIView *tmp =nil;
    
    UIView *view = (UIView *)singleTap.view;
    
    NSInteger index = view.tag;
    
    NSInteger tag = index-100;
    NSString *strColor=@"FFFFFF";
    if (self.headModel.list.count>0) {
        FNgradeSortItemModel *onemodel=[FNgradeSortItemModel mj_objectWithKeyValues:self.headModel.list[0]];
        strColor=onemodel.str_color;
    }
    FNgradeSortItemModel *seletedmodel=[FNgradeSortItemModel mj_objectWithKeyValues:self.headModel.list[tag]];
    NSInteger is_up=[seletedmodel.is_up integerValue];
    
    if (is_up==0) {
        FNCombinedButton* btn = self.btns[tag];
        tmp= btn;
        self.sortInt=1;
    }else{
        FNCombinedButton* btn = self.btns[tag];
        btn.titleLabel.selected=!btn.titleLabel.selected;
        
        [btn.titleLabel sd_setImageWithURL:[NSURL URLWithString:self.headModel.sort_descimg] forState:UIControlStateNormal];
        [btn.titleLabel sd_setImageWithURL:[NSURL URLWithString:self.headModel.sort_ascimg] forState:UIControlStateSelected];
        
        [btn.titleLabel setTitleColor:[UIColor colorWithHexString:strColor] forState:UIControlStateNormal];
        [btn.titleLabel setTitleColor:[UIColor colorWithHexString:strColor] forState:UIControlStateSelected];
        tmp = btn;
        NSInteger state=0;
        if( btn.titleLabel.selected==YES){
            state=1;
        }else{
            state=0;
        }
        self.sortInt=state;
    }
    [self.btns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FNgradeSortItemModel *enmodel=[FNgradeSortItemModel mj_objectWithKeyValues:self.headModel.list[idx]];
        NSInteger enis_up=[enmodel.is_up integerValue];
      
        if (enis_up==0) {
            FNCombinedButton* btn = obj;
            btn.selected = btn==tmp;
        }else{
            if(idx!=tag){
                FNCombinedButton* btn = obj;
                btn.titleLabel.selected=NO;
                
                [btn.titleLabel sd_setImageWithURL:[NSURL URLWithString:self.headModel.sort_img] forState:UIControlStateNormal];
                
                [btn.titleLabel setTitleColor:[UIColor colorWithHexString:strColor] forState:UIControlStateNormal];
                btn.selected = btn==tmp;
            }
        }
    }];
    
    NSArray *listArr=self.headModel.list;
    if(listArr.count>0){
        FNgradeSortItemModel *model=[FNgradeSortItemModel mj_objectWithKeyValues:listArr[tag]];
        if(self.sortInt==1){
            self.sortString=model.sort_asc;
        }
        else{
            self.sortString=model.sort_desc;
        }
        self.jm_page=1;
        [self apiRequestArrangeList];
    }
}
#pragma mark - 搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if ([searchBar.text kr_isNotEmpty]) {
        self.phoneString=searchBar.text;
        [self.searchBar resignFirstResponder];
        self.jm_page=1;
        [self apiRequestArrangeList];
    }
}
#pragma mark - //排行榜列表数据
- (FNRequestTool *)apiRequestArrangeList{
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
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection_phb&ctrl=phb_list" respondType:(ResponseTypeDataKey) modelType:@"" success:^(NSArray* respondsObject) {
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
                    [selfWeak apiRequestArrangeList];
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
        
        [selfWeak.jm_collectionview reloadData];
        //[selfWeak.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

#pragma mark - //排行榜排序栏目
- (FNRequestTool *)apiRequestArrangeSort{
    
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{ @"token":UserAccessToken}];
    
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection_phb&ctrl=phb_datacolumn" respondType:(ResponseTypeDataKey) modelType:@"" success:^(NSArray* respondsObject) {
        
        selfWeak.headModel=[FNgradeHeadModel mj_objectWithKeyValues:respondsObject];
        
        [self addSortBtnView];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)btns{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

@end
