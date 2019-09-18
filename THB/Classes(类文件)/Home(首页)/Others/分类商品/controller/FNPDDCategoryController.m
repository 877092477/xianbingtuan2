//
//  FNPDDCategoryController.m
//  THB
//
//  Created by Jimmy on 2018/9/3.
//  Copyright © 2018年 方诺科技. All rights reserved.
//
//拼多多 淘宝商品 分类
#import "FNPDDCategoryController.h"
#import "firstVersionSearchViewController.h"

#import "QJSlideButtonView.h"

#import "FNAPIHome.h"
#import "XYTitleModel.h"
#import "JMCellTool.h"
#import "classifyAdvertisingModel.h"
#import "Index_kuaisurukou_01Model.h"
#import "UIButton+ImageTitleSpacing.h"
#import "OnlyView.h"

#import "FNHomeProductCell.h"
#import "GoodsListTypeOneCell.h"
#import "FNHomeProductSingleRowCell.h"
#import "FNPDDCategorySectionHeader.h"
#import "FNPDDImageCollectionViewCell.h"
#import "GoodsListScreeningView.h"
#import "FNPopUpTool.h"

@interface FNPDDCategoryController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, FNPDDCategorySectionHeaderDelegate>

/** 分类 **/
@property(nonatomic,strong)NSMutableArray *categoryNameArray;
@property(nonatomic,strong)NSMutableArray *categoryIdArray;
/** 数据 **/
@property(nonatomic,strong)NSMutableArray *dataArray;
/** 广告 **/
@property(nonatomic,strong)NSMutableArray *advertisingArray;
@property(nonatomic,strong)NSArray<UIImage*> *advertisingImages;
/** 标题s */
@property (nonatomic,strong) QJSlideButtonView *titleView;
//分类ID
@property (nonatomic,strong) NSString *categoryId;
@property (nonatomic,assign) NSInteger categoryIndex;
@property (nonatomic,strong) UIView *voryView;

@property (nonatomic,assign) BOOL singleBool;

@property (nonatomic, strong) NSArray *SortArr;
@property (nonatomic, assign) BOOL isCuponOn;
@property (nonatomic, copy) NSString* sort;
@property (nonatomic, assign) NSInteger sortIndex;
@property (nonatomic, strong) GoodsListScreeningView *elementview;

@end

@implementation FNPDDCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.title=@"拼多多";
    _singleBool = YES;
    if ([_SkipUIIdentifierString isEqualToString:@"pub_wph_goods"]) {
        _singleBool = [[FNBaseSettingModel settingInstance].wph_goods_columnSwitch isEqualToString:@"0"];
    }
    _sort = @"zonghe";
    [self apiRequestGuanggao];
    [self apiRequestCategory];
    [self apiRequestSortHeader];
    [self navigationView];
    [self CategoryTableView];
}

- (GoodsListScreeningView *)elementview{
    if (_elementview == nil) {
        @weakify(self);
//        _elementview = [[GoodsListScreeningView alloc]initWithFrame:(CGRectMake(0, CGRectGetMaxY(_screeningView.frame)+1+JMNavBarHeigth, JMScreenWidth, 0))];
        _elementview = [[GoodsListScreeningView alloc] init];
        _elementview.btnClickedAction = ^{
            @strongify(self);
            [FNPopUpTool hiddenAnimated:YES];
            self.jm_page=1;
            [self apiRequestProduct];
        };
    }
    return _elementview;
}

-(void)navigationView{
    NSString *nameString=@"";
    if([self.keywordString isEqualToString:@"拼多多商品"]){
        nameString=@"拼多多";
    }
    if([self.keywordString isEqualToString:@"淘宝商品"]){
        nameString=@"淘宝";
    }
    if([self.keywordString isEqualToString:@"京东商品"]){
        nameString=@"京东";
    }else{
        nameString=self.keywordString;
    }
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [backBtn setTitleColor:FNBlackColor forState:UIControlStateNormal];
    [backBtn setTitle:[NSString stringWithFormat:@"  %@",nameString] forState:UIControlStateNormal];
    backBtn.titleLabel.font = kFONT14;
    [backBtn sizeToFit];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside]; 
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    UIButton * searchBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.backgroundColor=RGB(241, 241, 241);
    [searchBtn sizeToFit];
    searchBtn.titleLabel.font = kFONT11;
    searchBtn.cornerRadius=5;
    [searchBtn setImage:IMAGE(@"partner_search") forState:UIControlStateNormal];
    [searchBtn setTitleColor:FNGlobalTextGrayColor forState:UIControlStateNormal];
    [searchBtn setTitle:@"粘贴宝贝标题,先领券在购物" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10.0f];
    self.navigationItem.titleView =searchBtn;
    searchBtn.sd_layout
    .heightIs(self.navigationItem.titleView.height).leftSpaceToView(backBtn, 20).widthIs(JMScreenWidth-backBtn.size.width*2);
    //searchBtn.imageView.sd_layout
    //.rightSpaceToView(searchBtn.titleLabel, 10).heightIs(searchBtn.imageView.height).widthIs(searchBtn.imageView.width);
    if(self.understand==YES){
        [backBtn setImage:IMAGE(@"") forState:UIControlStateNormal];
    }else{
        [backBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    }
    UIButton *msgBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    msgBtn.hidden=YES;
    [msgBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [msgBtn sizeToFit];
    msgBtn.size = CGSizeMake(msgBtn.width, msgBtn.height); 
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:msgBtn];
}
#pragma mark - 单元
-(void)CategoryTableView{
    
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing=2.0f;
    flowlayout.minimumInteritemSpacing=0.0f;
    flowlayout.headerReferenceSize = CGSizeMake(XYScreenWidth, 88);
    flowlayout.footerReferenceSize = CGSizeZero;
    if (@available(iOS 9.0, *)) {
        flowlayout.sectionHeadersPinToVisibleBounds = YES;
    }
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:(CGRectZero) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=RGB(246, 246, 246);
    self.jm_collectionview.showsHorizontalScrollIndicator = NO;
    self.jm_collectionview.showsVerticalScrollIndicator = NO;
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    [self.jm_collectionview registerClass:[GoodsListTypeOneCell class] forCellWithReuseIdentifier:@"GoodsListTypeOneCell"];
    [self.jm_collectionview registerClass:[FNHomeProductCell class] forCellWithReuseIdentifier:@"HomeViewGoodsCell"];
    [self.jm_collectionview registerClass:[FNHomeProductSingleRowCell class] forCellWithReuseIdentifier:@"HomeViewGoodsSingleCell"];
    [self.jm_collectionview registerClass:[FNPDDImageCollectionViewCell class] forCellWithReuseIdentifier:@"FNPDDImageCollectionViewCell"];
    [self.jm_collectionview registerClass:[FNPDDCategorySectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNPDDCategorySectionHeader"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    
    @WeakObj(self);
    // 下拉刷新
    self.jm_collectionview.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.jm_page = 1;
        [selfWeak apiRequestProduct];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.jm_collectionview.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉加载
    self.jm_collectionview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        selfWeak.jm_page += 1;
        [selfWeak apiRequestProduct];
    }];
    
//    _voryView=[[UIView alloc]init];
//    _voryView.frame=CGRectMake(0, 0, FNDeviceWidth, 200);
//    self.jm_tableview.sectionHeaderHeight=40;
   
}



#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
    
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0)
        return self.advertisingImages.count;
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 ) {
        FNPDDImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNPDDImageCollectionViewCell" forIndexPath:indexPath];
        [cell setImage:self.advertisingImages[indexPath.row]];
        return cell;
    } else {
    
        FNBaseProductModel *model = self.dataArray[indexPath.row];
        
        if(_singleBool==YES){
            FNHomeProductSingleRowCell *cell = [FNHomeProductSingleRowCell cellWithCollectionView:collectionView atIndexPath:indexPath];
            cell.model = model;
            cell.backgroundColor=[UIColor whiteColor];
            cell.sharerightNow = ^(FNBaseProductModel *mod) {
                [self shareProductWithModel:mod];
            };
            cell.clipsToBounds = YES;
            return cell;
        }else{
            FNHomeProductCell *cell = [FNHomeProductCell cellWithCollectionView:collectionView atIndexPath:indexPath];
            [cell setIsLeft: indexPath.row % 2 == 0];
            cell.model = model;
            cell.backgroundColor=[UIColor clearColor];
            cell.borderColor = FNGlobalTextGrayColor;
            cell.clipsToBounds = YES;
            cell.sharerightNow = ^(FNBaseProductModel *mod) {
                [self shareProductWithModel:mod];
            };
            return cell;
        }
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UIImage *image = self.advertisingImages[indexPath.row];
        return CGSizeMake(XYScreenWidth, XYScreenWidth * image.size.height / image.size.width);
    } else {
        if(_singleBool==YES){
            CGFloat singlewidth=140;
            return CGSizeMake(FNDeviceWidth,  singlewidth);
        }else{
            double w = FNDeviceWidth/2;
            return CGSizeMake(w, w+110);
        }
    }
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(2, 0, 2, 0);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        [self loadOtherVCWithModel:self.advertisingArray[indexPath.row] andInfo:nil outBlock:nil];
        return;
    }
    FNBaseProductModel *model = self.dataArray[indexPath.row];
    if (model.is_qiangguang.boolValue) {
        [FNTipsView showTips:@"商品太火爆了，已被抢光，赶紧看一下其他商品吧〜"];
    }else{
        [self goProductVCWithModel:model withData:model.data];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(XYScreenWidth, 0);
    }
    if (_SortArr.count>0) {
        return CGSizeMake(XYScreenWidth, 120);
    } else {
        return CGSizeMake(XYScreenWidth, 0);
    }
}

// 设置Footer的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(XYScreenWidth, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
    }

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        FNPDDCategorySectionHeader *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNPDDCategorySectionHeader" forIndexPath:indexPath];
        
        
        NSMutableArray *name=[[NSMutableArray alloc]init];
        NSMutableArray *type=[[NSMutableArray alloc]init];
        NSMutableArray *image1=[[NSMutableArray alloc]init];
        NSMutableArray *image2=[[NSMutableArray alloc]init];
        if (_SortArr.count>0) {
            [_SortArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [name addObject:[obj objectForKey:@"name"]];
                [type addObject:[obj objectForKey:@"type"]];
                [image1 addObject:@""];
                [image2 addObject:@""];
            }];
        }
        [name addObject:@"筛选"];
        [type addObject:@"shaixuan"];
        [image1 addObject:@"partner_down"];
        [image2 addObject:@"partner_up"];
        [view.screeningView setTitles:name images:image1 selectedImage:image2 types:type];
        @WeakObj(self);
        @weakify(view)
        [view.screeningView setClickedWithSiteType:^(NSString *type, NSInteger site) {
//            [view showFilter];
            
            CGRect rect = [view_weak_ convertRect:view_weak_.bounds toView:self.view];
            NSLog(@"%f  %f", rect.origin.y, rect.size.height);
            selfWeak.elementview.frame = CGRectMake(0, rect.origin.y + 80 + JMNavBarHeigth, XYScreenWidth, 200);
            if ([type isEqualToString:@"shaixuan"]) {
                if ([selfWeak.SkipUIIdentifierString isEqualToString:@"pub_gettaobao"]) {
                    selfWeak.elementview.types = @"仅看天猫";
                }
                if ([selfWeak.SkipUIIdentifierString isEqualToString:@"pub_jingdongshangpin"]) {
                    selfWeak.elementview.types = @"仅看自营";
                }
                if ([self.SkipUIIdentifierString isEqualToString:@"pub_pddshangpin"]) {
                    selfWeak.elementview.types = @"";
                }
                [FNPopUpTool showViewWithContentView:self.elementview withDirection:(FMPopupAnimationDirectionNone) finished:^{
//                    UIButton* button  = (UIButton *)[self.screeningView.views lastObject];
//                    button.selected=NO;
                }];
                return;
            }
            
            selfWeak.sort = type;
            selfWeak.sortIndex = site;
            [SVProgressHUD show];
            selfWeak.jm_page = 1;
            [selfWeak apiRequestProduct];
        }];
        [view.screeningView setButtonAtIndex:self.sortIndex];
        [view setTitles:_categoryNameArray withBlock:^(NSInteger index) {
            XYLog(@"index is %ld",(long)index);
            [SVProgressHUD show];
            selfWeak.jm_page = 1;
            selfWeak.categoryId =selfWeak.categoryIdArray[index];
            selfWeak.categoryIndex = index;
            [selfWeak apiRequestProduct];
        }];
        [view setCategoryAt:self.categoryIndex];
        view.delegate = self;
        return view;
    }
    return [[UICollectionReusableView alloc] init];
}

#pragma mark - UITableViewDataSource delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        if(self.advertisingArray.count==0){
            return 0;
        }else{
            return 1;
        }
    }
    if(section==1){
        return 1;
    }else{
       return self.dataArray.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==1){
        if(_categoryNameArray.count>0){
            return 40;
        }
        return 0;
    } if(section==2){
        return 0;
    }
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if(self.advertisingArray.count==0){
            return 0;
        }else{
            return 200;
        }
    } if(indexPath.section==1){
        return 0.01;
    }
    else{
        CGFloat height = [JMCellTool cellHeightTableview:tableView atIndexPath:indexPath andModel:self.dataArray[indexPath.row]];
        return height;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"classifycell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"classifycell"];
            if(self.advertisingArray.count>0){
                classifyAdvertisingModel * Model= self.advertisingArray[0];
                UIImageView *headerView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
                headerView.userInteractionEnabled=YES;
                UITapGestureRecognizer *icontap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(advertisingAction)];
                [headerView addGestureRecognizer:icontap];
                [headerView setUrlImg:Model.img];
                [cell.contentView addSubview:headerView];
            }
            
        }
        return cell;
    }
    if(indexPath.section==1){
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ycell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ycell"];
            
        }
        return cell;
    }else{
        return [JMCellTool tableView:tableView atIndexPath:indexPath superVC:self andModel:self.dataArray[indexPath.row]];
       
    }
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if(section==1){
        if(_categoryNameArray.count>0){

            return _voryView;
        }else{
             return [UIView new];
        }
    }
    else{
         return [UIView new];
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
        FNBaseProductModel *model = self.dataArray[indexPath.row];
        if (model.is_qiangguang.boolValue) {
            [FNTipsView showTips:@"商品太火爆了，已被抢光，赶紧看一下其他商品吧〜"];
        }else{
            [self goProductVCWithModel:model withData:model.data];
        }
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    if (conY>= 200 ) {
        [self.titleView removeFromSuperview];
        [self.view addSubview:self.titleView];
        [self.view bringSubviewToFront:self.titleView];
    }else{
        if (![self.voryView.subviews containsObject:self.titleView]) {
            
            [self.voryView addSubview:self.titleView];
            
        }
    }
    
}
-(void)advertisingAction{
    classifyAdvertisingModel * Model= self.advertisingArray[0];
    [self loadOtherVCWithModel:Model andInfo:nil outBlock:nil];
}
#pragma mark - 返回
-(void)backBtnAction{
    if(self.understand==NO){
      [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)searchBtnAction{
    firstVersionSearchViewController *vc = [[firstVersionSearchViewController alloc]init];
    if ([_SkipUIIdentifierString isEqualToString:@"pub_jingdongshangpin"]) {
        vc.SkipUIIdentifier = @"buy_jingdong";
    } else if ([_SkipUIIdentifierString isEqualToString:@"pub_pddshangpin"]) {
        vc.SkipUIIdentifier = @"buy_pinduoduo";
    }
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Request
//获取广告
- (FNRequestTool *)apiRequestGuanggao{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"SkipUIIdentifier":self.SkipUIIdentifierString}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appJdPdd&ctrl=guanggao" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSArray *array = respondsObject[DataKey];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dictDict in array) {
            [arrM addObject: [classifyAdvertisingModel mj_objectWithKeyValues:dictDict]];
        }
        selfWeak.advertisingArray=arrM;
        NSLog(@"Guanggao:%@",respondsObject);
        NSMutableArray *imgNames = [[NSMutableArray alloc] init];
        for (classifyAdvertisingModel *model in arrM) {
            [imgNames addObject:model.img];
        }
        @weakify(self);
        [XYNetworkAPI downloadImages:imgNames withFinishedBlock:^(NSArray<UIImage *> *images) {
            @strongify(self);
            self.advertisingImages = images;
            [self.jm_collectionview reloadData];
        }];
//
//        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
//        [selfWeak.jm_tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
//        [selfWeak.jm_collectionview reloadSections:indexSet];
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        if(selfWeak.advertisingArray.count==0){
            [selfWeak apiRequestGuanggao];
        }
        [SVProgressHUD dismiss];
    } isHideTips:YES];
}
//获取分类数据
- (FNAPIHome *)apiRequestCategory{
    [SVProgressHUD show];
    @WeakObj(self);
    NSString* type = @"ksrk";
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"type":type,@"SkipUIIdentifier":self.SkipUIIdentifierString}];
    Index_kuaisurukou_01Model *model=[Index_kuaisurukou_01Model mj_objectWithKeyValues:self.itemModel];
    NSString* show_type_str = model.show_type_str;
    if([show_type_str kr_isNotEmpty]){
        params[@"show_type_str"]=show_type_str;
    }
    
    return [FNAPIHome apiHomeForNewNavCategoriesWithParams:params success:^(id respondsObject) {
        [selfWeak.categoryNameArray removeAllObjects];
        [selfWeak.categoryIdArray removeAllObjects];
        NSArray<XYTitleModel *> *titles = respondsObject;
        if (titles.count > 0) {
            [titles enumerateObjectsUsingBlock:^(XYTitleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [selfWeak.categoryNameArray  addObject:obj.category_name];
                [selfWeak.categoryIdArray  addObject:obj.id];
            }];
        }
        
        [selfWeak apiRequestProduct];
        [self.jm_collectionview reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        if (self.dataArray.count==0) {
            [self apiRequestCategory];
        }
        [SVProgressHUD dismiss];
    } isHidden:YES];
}

- (void)apiRequestSortHeader{
    [SVProgressHUD show];
    NSString* type = @"ksrk";
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"type":type,@"SkipUIIdentifier":self.SkipUIIdentifierString}];
    Index_kuaisurukou_01Model *model=[Index_kuaisurukou_01Model mj_objectWithKeyValues:self.itemModel];
    NSString* show_type_str = model.show_type_str;
    if([show_type_str kr_isNotEmpty]){
        params[@"show_type_str"]=show_type_str;
    }
    
    @weakify(self);
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appGoodsSort&ctrl=getSort" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        self.SortArr = respondsObject;
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:YES];
    
}
//获取产品
- (FNRequestTool *)apiRequestProduct{
    [self.jm_collectionview.mj_footer endRefreshing];
    [self.jm_collectionview.mj_header endRefreshing];
    [SVProgressHUD show];
    @WeakObj(self);
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"is_ksrk":@"1",PageNumber:@(self.jm_page), @"token":UserAccessToken,PageSize:@(_jm_pro_pagesize),@"SkipUIIdentifier":self.SkipUIIdentifierString}];
    Index_kuaisurukou_01Model *model=[Index_kuaisurukou_01Model mj_objectWithKeyValues:self.itemModel];
    NSString* commission = model.commission;
    NSString* start_price = model.start_price;
    NSString* end_price = model.end_price;
    NSString* goods_sales = model.goods_sales;
    NSString* keyword = model.keyword;
    NSString* show_type_str = model.show_type_str;
    if([self.categoryId kr_isNotEmpty]){
        params[@"cid"]=self.categoryId;
    }
    if([commission kr_isNotEmpty]){
        params[@"commission"]=commission;
    }
//    if([start_price kr_isNotEmpty]){
//        params[@"start_price"]=start_price;
//    }
//    if([end_price kr_isNotEmpty]){
//        params[@"end_price"]=end_price;
//    }
    if([goods_sales kr_isNotEmpty]){
        params[@"goods_sales"]=goods_sales;
    }
    if([keyword kr_isNotEmpty]){
        params[@"keyword"]=keyword;
    }
    if([show_type_str kr_isNotEmpty]){
        params[@"show_type_str"]=show_type_str;
    }
    params[@"yhq"]=@(_isCuponOn);
    if([_sort kr_isNotEmpty]){
        params[@"sort"] = _sort;
    }
    params[@"start_price"]=self.elementview.lowprice;
    params[@"end_price"]=self.elementview.highprice;
    if ([self.SkipUIIdentifierString isEqualToString:@"buy_taobao"]) {
        params[@"is_tm"]=@(self.elementview.is_tm);
    }
    if ([self.SkipUIIdentifierString isEqualToString:@"buy_jingdong"]) {
        params[@"isJdSale"]=@(self.elementview.isJdSale);
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appGoods02&ctrl=getgoods" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in respondsObject) {
            FNBaseProductModel *model = [FNBaseProductModel mj_objectWithKeyValues:dic];
            model.data = dic;
            [array addObject:model];
        }
//        NSArray* array = respondsObject;
        if (selfWeak.jm_page == 1) {
            if (array.count == 0) {
                [FNTipsView showTips:@"很抱歉，没有找到该类产品~"];
                return ;
            }
            [selfWeak.dataArray removeAllObjects];
            [selfWeak.dataArray addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                selfWeak.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.jm_page ++;
                    [selfWeak apiRequestProduct];
                }];
            }else{
            }
        } else {
            [selfWeak.dataArray addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                [selfWeak.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [selfWeak.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
        [selfWeak.jm_collectionview reloadData];
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *error) {
        if (self.dataArray.count==0) {
            //[self apiRequestCategory];
            [self apiRequestProduct];
        }
        [selfWeak.jm_collectionview.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
    } isHideTips:YES];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)categoryIdArray {
    if (!_categoryIdArray) {
        _categoryIdArray = [NSMutableArray array];
    }
    return _categoryIdArray;
}

- (NSMutableArray *)categoryNameArray {
    if (!_categoryNameArray) {
        _categoryNameArray = [NSMutableArray array];
    }
    return _categoryNameArray;
}
- (NSMutableArray *)advertisingArray {
    if (!_advertisingArray) {
        _advertisingArray = [NSMutableArray array];
    }
    return _advertisingArray;
}

#pragma mark - FNPDDCategorySectionHeaderDelegate

- (void)didCuponClick: (BOOL)isOn {
    self.isCuponOn = isOn;
    self.jm_page=1;
    [self apiRequestProduct];
}

- (void)didRowStyleClick:(BOOL)isSingle {
    _singleBool = !isSingle;
    [self.jm_collectionview reloadData];
}



@end
