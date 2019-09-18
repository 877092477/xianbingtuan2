//
//  FNNewWelfareNeController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//  砍价免单

//免单
#import "FNNewWelfareNeController.h"
//controller
#import "secondViewController.h"
#import "FNMendListDeController.h"
#import "FNmakeSingleDeController.h"
#import "FNFreeProductAlertController.h"
#import "FNNewFreeProductDetailController.h"
#import "FNNewMendListDeController.h"
//view
#import "FNNewWelfareFlowDeCell.h"
#import "FNOrderMendCell.h" //横的cell
//model
#import "FNNewWelfDeModel.h"
#import "FNNewWelfGoodsModel.h"

#import "XYNetworkAPI.h"

@interface FNNewWelfareNeController ()<UICollectionViewDelegate,UICollectionViewDataSource, FNNewWelfareFlowDeCellDelegate>
@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UIButton *rightBtn;
//福利商品
@property(nonatomic,strong) NSMutableArray<FNNewWelfGoodsModel*> *goodsArray;

@property (nonatomic, strong) NSMutableArray<UIImage*>* bannerImages;
@property (nonatomic, strong) FNNewWelfDeModel *model;
@end

@implementation FNNewWelfareNeController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=self.title?self.title:@"免单福利";
    
    _bannerImages = [[NSMutableArray alloc] init];
    
    [self oddViewCollectionview];
    [self apiStoreMainReqeuest];
    [self showGuide];
    [self setupNav];
}

#pragma mark - //导航栏
-(void)setupNav{
    UIButton *leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [leftBtn setTitleColor:FNBlackColor forState:UIControlStateNormal];
    [leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    [leftBtn sizeToFit];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.size=CGSizeMake(30,  30);
    self.leftBtn=leftBtn;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    UIButton *rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    [rightbutton setTitle:@"我的免单" forState:UIControlStateNormal];
    rightbutton.titleLabel.font = kFONT12;
    [rightbutton setTitleColor:RGB(60, 60, 60) forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn=rightbutton;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    if(self.understand==YES){
        self.leftBtn.hidden=YES;
    }
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightBtnAction{
    if(![UserAccessToken kr_isNotEmpty]){
        [self gologin]; //[FNTipsView showTips: @"请先登录"];
        //return;
    }else{
        FNNewMendListDeController *vc=[[FNNewMendListDeController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)showGuide {
    NSString *token = UserAccessToken;
    NSString *key = [NSString stringWithFormat:@"%@_had_show_guide", token];
    BOOL hadShow = [[NSUserDefaults standardUserDefaults] boolForKey:key];
    if (hadShow) {
        return;
    }
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    FNFreeProductAlertController *alert = [[FNFreeProductAlertController alloc] init];
//    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - 主视图
-(void)oddViewCollectionview{
    CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight;
    if(self.understand==YES){
        tableHeight=FNDeviceHeight-SafeAreaTopHeight-XYTabBarHeight;
    }
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
    
    
    [self.jm_collectionview registerClass:[FNNewWelfareFlowDeCell class] forCellWithReuseIdentifier:@"FNNewWelfareFlowDeCell"];

    [self.jm_collectionview registerClass:[FNOrderMendCell class] forCellWithReuseIdentifier:@"FNOrderMendCell"];

    @weakify(self)
    self.jm_collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [SVProgressHUD show];
        self.jm_page = 1;
        [self apiRequestGoodsOddWelfare];
    }];
    
//    self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        @strongify(self)
//        [SVProgressHUD show];
//        [self apiRequestGoodsOddWelfare];
//    }];
    self.jm_collectionview.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
    self.view.backgroundColor=RGB(240, 240, 240);
    self.jm_collectionview.backgroundColor=RGB(240, 240, 240);
}

- (void)loadMore {
    [SVProgressHUD show];
    [self apiRequestGoodsOddWelfare];
}
                                
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    int count = 1;
    if (self.model)
        count ++;
    return count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.model && section == 0) {
        return 1;
    }
    return self.goodsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.model && indexPath.section == 0) {
        FNNewWelfareFlowDeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNNewWelfareFlowDeCell" forIndexPath:indexPath];
        [cell setBanners:self.bannerImages];
        [cell setTitle:self.model.flowpath_label_img andImage:self.model.flowpath_img title2:self.model.goods_label_img];
        cell.delegate = self;
        return cell;
    }
    
    FNNewWelfGoodsModel *goods = self.goodsArray[indexPath.row];
    FNOrderMendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNOrderMendCell" forIndexPath:indexPath];
    [cell.imgHeader sd_setImageWithURL:URL(goods.goods_img)];
    cell.lblTitle.text = goods.goods_title;
    cell.lblDesc.text = [NSString stringWithFormat:@"%@ %@", goods.sales_str, goods.stock_str];
    cell.lblMore.attributedText = [[NSAttributedString alloc] initWithString:goods.price_str attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: UIColor.redColor}];
    [cell.btnMore setTitle:goods.btn_str forState:UIControlStateNormal];
    [cell setPadding:0];
    [cell showLine:YES];
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
    if (self.model && indexPath.section == 0) {
        CGFloat height = 204;
        if (self.bannerImages.count > 0) {
            height += (XYScreenWidth / self.bannerImages[0].size.width * self.bannerImages[0].size.height);
        }
        return CGSizeMake(XYScreenWidth, height);
    }
    return CGSizeMake(XYScreenWidth, 120);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.model && indexPath.section == 0) {
        return ;
    }
    
    FNNewWelfGoodsModel *model = self.goodsArray[indexPath.row];
    FNNewFreeProductDetailController *vc = [[FNNewFreeProductDetailController alloc] init];
    vc.fnuo_id = model.fnuo_id;
    vc.data = model.data;
    [self.navigationController pushViewController:vc animated:YES];
}
//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(XYScreenWidth, 0);
}

#pragma mark - Request
- (void)apiStoreMainReqeuest{
    @WeakObj(self);
    [SVProgressHUD show];
    self.jm_page = 1;
    [FNRequestTool startWithRequests:@[[self apiRequestOddWelfare],[self apiRequestGoodsOddWelfare]] withFinishedBlock:^(NSArray *erros) {
        [selfWeak.jm_collectionview reloadData];
        [SVProgressHUD dismiss];
        self.jm_collectionview.hidden=NO;
    }];
}
#pragma mark - Request 免单首页
- (FNRequestTool *)apiRequestOddWelfare{
    @weakify(self)
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=bargainList&ctrl=index" respondType:(ResponseTypeModel) modelType:@"FNNewWelfDeModel" success:^(id respondsObject) {
        @strongify(self)
        self.model = respondsObject;
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (FNNewWelfDeBannerModel *banner in self.model.banner) {
            if ([banner.img kr_isNotEmpty])
                [array addObject:banner.img];
        }
        @weakify(self)
        [XYNetworkAPI downloadImages:array withFinishedBlock:^(NSArray<UIImage *> *images) {
            @strongify(self)
            [self.bannerImages addObjectsFromArray:images];
            [self.jm_collectionview reloadData];
        }];
        
        [SVProgressHUD dismiss];
        self.jm_collectionview.hidden=NO;
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {

    } isHideTips:YES];
}
//福利补贴商品
- (FNRequestTool *)apiRequestGoodsOddWelfare{
    @weakify(self)
    [self.jm_collectionview.mj_footer endRefreshing];
    [self.jm_collectionview.mj_header endRefreshing];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken, @"p": @(self.jm_page)}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=bargainList&ctrl=goods" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
//        selfWeak.goodsArray=respondsObject;
        
        if (self.jm_page == 1) {
            [self.goodsArray removeAllObjects];
        }
        if (((NSArray*)respondsObject).count > 0) {
            self.jm_page ++;
            self.jm_collectionview.mj_footer.hidden = NO;
        } else {
            self.jm_collectionview.mj_footer.hidden = YES;
        }
        
        for (NSDictionary *dict in respondsObject) {
            FNNewWelfGoodsModel *model = [FNNewWelfGoodsModel mj_objectWithKeyValues:dict];
            model.data = dict;
            [self.goodsArray addObject:model];
        }
        
        
        [SVProgressHUD dismiss];
        self.jm_collectionview.hidden=NO;
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {

    } isHideTips:YES];
}
-(NSMutableArray *)goodsArray{
    if (!_goodsArray) {
        _goodsArray = [NSMutableArray array];
    }
    return _goodsArray;
}

#pragma mark - FNNewWelfareFlowDeCellDelegate
- (void)didItemSelectedAt:(NSInteger)index {
    FNNewWelfDeBannerModel *model = self.model.banner[index];
    [self loadOtherVCWithModel:model andInfo:nil outBlock:nil];
}


@end
