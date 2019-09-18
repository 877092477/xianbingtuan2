//
//  FNLiveCouponeSearchController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/24.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveCouponeSearchController.h"
#import "FNCustomeNavigationBar.h"
#import "FNMaximumSpacingFlowLayout.h"

#import "FNLiveCouponeTagCell.h"
#import "FNLiveCouponeSearchModel.h"
#import "FNLiveCouponeListController.h"
#import "FNLiveCouponeSearchHeaderReusableView.h"
#import "FNLeftItemsCollectionViewFlowLayout.h"

@interface FNLiveCouponeSearchController ()<UICollectionViewDelegate, UICollectionViewDataSource, FNLiveCouponeSearchHeaderReusableViewDelegate, UITextFieldDelegate>


@property (nonatomic, strong)FNLiveCouponeSearchModel *model;

@property (nonatomic, strong)UIImageView* backImage;
@property (nonatomic, strong)UIButton* backBtn;
@property (nonatomic, strong)UIButton* searchBtn;
@property (nonatomic, strong)UITextField *txfSearch;
@property (nonatomic, strong)UIImageView *imgSearch;

@property (nonatomic, strong) UIImageView *imgTag;
@property (nonatomic, strong) UILabel *lblTag;

@property (nonatomic, strong)NSMutableArray<NSString*> *keywords;

@end

@implementation FNLiveCouponeSearchController

#define FNLiveCouponeSearchHistory @"FNLiveCouponeSearchHistory"

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray* array = [[NSUserDefaults standardUserDefaults] valueForKey:FNLiveCouponeSearchHistory];
    _keywords = [[NSMutableArray alloc] initWithArray:array];
    [self configUI];
    [self requestMain];
}

- (void)configUI {
//    [self.view addSubview:self.navigationView];
//    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
//    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:self.navigationView.height];
//    [self.navigationView autoSetDimension:(ALDimensionWidth) toSize:XYScreenWidth];
    
    [self configNav];
    
    _imgTag = [[UIImageView alloc] init];
    _lblTag = [[UILabel alloc] init];
    
    [self.view addSubview:_imgTag];
    [self.view addSubview:_lblTag];
    
    [_imgTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
//        make.top.equalTo(self.navigationView.mas_bottom).offset(20);
        make.top.equalTo(@20);
        make.width.height.mas_equalTo(18);
    }];
    
    [_lblTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgTag.mas_right).offset(8);
        make.centerY.equalTo(self.imgTag);
        make.right.lessThanOrEqualTo(@-20);
    }];
    
//    _imgTag.image = IMAGE(@"live_coupone_image_tag");
    
//    _lblTag.text = @"复制 #淘宝标题# 查找优惠券";
    _lblTag.textColor = RGB(254, 89, 74);
    _lblTag.font = kFONT14;
    
    FNLeftItemsCollectionViewFlowLayout* flowlayout = [FNLeftItemsCollectionViewFlowLayout new];
    flowlayout.headerReferenceSize = CGSizeMake(XYScreenWidth, 40);
    flowlayout.footerReferenceSize = CGSizeMake(XYScreenWidth, 40);
    flowlayout.sectionInset = UIEdgeInsetsMake(_jmsize_10, _jmsize_10, _jmsize_10, _jmsize_10);
    if (@available(iOS 10.0, *)) {
        flowlayout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
        flowlayout.estimatedItemSize = CGSizeMake(44, 44);
    }
    flowlayout.estimatedItemSize = CGSizeMake(44, 44);
    flowlayout.minimumInteritemSpacing  = 5;
    flowlayout.minimumLineSpacing  = 5;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=FNWhiteColor;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.emptyDataSetSource = nil;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNLiveCouponeTagCell class] forCellWithReuseIdentifier:@"FNLiveCouponeTagCell"];
    [self.jm_collectionview registerClass:[FNLiveCouponeSearchHeaderReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"sectionFooter"];
    [self.view addSubview:self.jm_collectionview];
    
    [self.jm_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(self.lblTag.mas_bottom).offset(20);
    }];
}

- (void)configNav{
    UIView *leftView = [[UIView alloc] init];
    leftView.frame = CGRectMake(0, 0, 25, 25);
    
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.searchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.searchBtn.frame=CGRectMake(0, 0, 54, 32);
//    [self.searchBtn setBackgroundImage:IMAGE(@"live_coupone_button_search") forState:(UIControlStateNormal)];
//    [self.searchBtn setTitle:@"搜索" forState:(UIControlStateNormal)];
    self.searchBtn.titleLabel.font = kFONT15;
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBtn];
    
    _txfSearch = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, XYScreenWidth - 100, 30)];
    _txfSearch.backgroundColor = RGB(248, 248, 248);
    _txfSearch.cornerRadius = 15;
    
    _imgSearch = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
//    _imgSearch.image = IMAGE(@"live_coupone_image_search");
    _imgSearch.contentMode = UIViewContentModeCenter;
    _txfSearch.leftView = _imgSearch;
    _txfSearch.leftViewMode = UITextFieldViewModeAlways;
    _txfSearch.font = kFONT14;
    _txfSearch.returnKeyType = UIReturnKeySearch;
    _txfSearch.delegate = self;
//    _txfSearch.placeholder = @"商家";
    
    self.navigationItem.titleView = _txfSearch;
    
}


- (void)backBtnAction {
    [self dismissViewControllerAnimated:NO completion:nil];
}



#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return self.model.search_list.count;
    } else {
        return _keywords.count;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.model)
        return 2;
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNLiveCouponeTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNLiveCouponeTagCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        FNLiveCouponeSearchHotModel *hot = self.model.search_list[indexPath.row];
        cell.lblTag.text = hot.keyword;
        cell.lblTag.textColor = [hot.is_hot isEqualToString:@"1"] ? RGB(254, 89, 74) : RGB(102, 102, 102);
    } else {
        cell.lblTag.text = _keywords[indexPath.row];
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind==UICollectionElementKindSectionHeader) {
        FNLiveCouponeSearchHeaderReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"sectionHeader" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            [reusableview setTitle:self.model.str isClearShow:NO];
            
        } else {
            [reusableview setTitle:self.model.his_str isClearShow:YES];
        }
        reusableview.delegate = self;
        return reusableview;
    }else{
        UICollectionReusableView* reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"sectionFooter" forIndexPath:indexPath];
        return reusableview;
    }
    return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FNLiveCouponeSearchHotModel *hot = self.model.search_list[indexPath.row];
        
        [self addHistory:hot.keyword];
        
        FNLiveCouponeListController *vc = [[FNLiveCouponeListController alloc] init];
        vc.keyword = hot.keyword;
        vc.cid = hot.ID;
        vc.title = hot.keyword;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        NSString *keyword = self.keywords[indexPath.row];
        [self addHistory:keyword];
        
        FNLiveCouponeListController *vc = [[FNLiveCouponeListController alloc] init];
        vc.keyword = keyword;
        vc.title = keyword;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - Collection view delegate && flow layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(JMScreenWidth, 44);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    //return CGSizeMake(JMScreenWidth, self.dibuImageView.image.size.width/self.dibuImageView.image.size.height*(JMScreenWidth-20)+20);
    return CGSizeMake(JMScreenWidth, 0);
}

#pragma mark - Networking
- (void)requestMain{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=life_coupon&ctrl=search" respondType:(ResponseTypeModel) modelType:@"FNLiveCouponeSearchModel" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        @strongify(self)
        self.model = respondsObject;
        
        [self.searchBtn sd_setBackgroundImageWithURL:URL(self.model.search_btnimg) forState:(UIControlStateNormal)];
        [self.imgSearch sd_setImageWithURL:URL(self.model.search_img)];
        self.txfSearch.placeholder = self.model.search_str;
        
        [self.imgTag sd_setImageWithURL:URL(self.model.search_copyimg)];
        self.lblTag.text = self.model.str_copy;
        
        [self.jm_collectionview reloadData];
        
    } failure:^(NSString *error) {

            [XYNetworkAPI cancelAllRequest];
            [SVProgressHUD dismiss];
            [self.jm_collectionview.mj_footer endRefreshing];

    } isHideTips:YES];
    
}

- (void)addHistory: (NSString*)keyword {
    if (![keyword kr_isNotEmpty])
        return;
    
    for (NSInteger index = _keywords.count - 1; index >= 0; index--) {
        if ([keyword isEqualToString:_keywords[index]]) {
            [_keywords removeObjectAtIndex:index];
        }
    }
    [_keywords insertObject:keyword atIndex:0];
    [self.jm_collectionview reloadData];
    
    [[NSUserDefaults standardUserDefaults] setValue:_keywords forKey:FNLiveCouponeSearchHistory];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - Action
- (void)searchBtnAction {
    NSString *keyword = _txfSearch.text;
    if ([keyword kr_isNotEmpty]) {
        [self addHistory:keyword];
        
        FNLiveCouponeListController *vc = [[FNLiveCouponeListController alloc] init];
        vc.keyword = keyword;
        vc.title = keyword;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - FNLiveCouponeSearchHeaderReusableViewDelegate
- (void)didClearClick:(FNLiveCouponeSearchHeaderReusableView *)view {
    [_keywords removeAllObjects];
    [self.jm_collectionview reloadData];
    
    [[NSUserDefaults standardUserDefaults] setValue:@[] forKey:FNLiveCouponeSearchHistory];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self searchBtnAction];
    return YES;
}

@end
