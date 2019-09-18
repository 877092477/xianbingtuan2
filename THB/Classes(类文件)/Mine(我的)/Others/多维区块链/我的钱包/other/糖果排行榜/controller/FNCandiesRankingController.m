//
//  FNCandiesRankingController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNCandiesRankingController.h"
#import "FNCustomeNavigationBar.h"
#import "FNcandiesRankingModel.h"
#import "FNcandiesRankingItemCell.h"
#import "FNcandiesRanSeekCell.h"
#import "FNcandiesRanTopItemCell.h"
@interface FNCandiesRankingController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNcandiesRanSeekCellDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)FNcandiesRankingModel *dataModel;
@property (nonatomic, strong)UIImageView *imgHeader;
@property (nonatomic, strong)NSString* seekPhone;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSArray *top_threeArr;
@end

@implementation FNCandiesRankingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
}
#pragma mark - set up views
- (void)jm_setupViews{
    CGFloat baseGap=0;
    if(self.understand==YES){
        baseGap=XYTabBarHeight;
    }
    [self configHeader];
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    self.jm_collectionview.alpha = 1;
    self.jm_collectionview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
    [self.jm_collectionview registerClass:[FNcandiesRankingItemCell class] forCellWithReuseIdentifier:@"FNcandiesRankingItemCellID"];
    [self.jm_collectionview registerClass:[FNcandiesRanSeekCell class] forCellWithReuseIdentifier:@"FNcandiesRanSeekCellID"];
    [self.jm_collectionview registerClass:[FNcandiesRanTopItemCell class] forCellWithReuseIdentifier:@"FNcandiesRanTopItemCellID"];
    
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.navigationView.leftButton = self.leftBtn;
    
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightBtn.size = CGSizeMake(40, 27);
    self.navigationView.rightButton = self.rightBtn;
    [self.rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.rightBtn setTitle:@"规则" forState:UIControlStateNormal];
    
    self.rightBtn.titleLabel.font=kFONT12;
    
    [self.view addSubview:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 10).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    if(self.understand==YES){
       self.leftBtn.hidden=YES;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationView.titleLabel.text=@"排行榜";
    [self.leftBtn setImage:IMAGE(@"return_w") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor clearColor];
    self.navigationView.titleLabel.textColor=[UIColor whiteColor];
    
    if([UserAccessToken kr_isNotEmpty]){
        [self requestBendi];
    }
    
}
- (void)configHeader{
    CGFloat imgH=415;
    self.imgHeader = [[UIImageView alloc] init];
    [self.view insertSubview:_imgHeader atIndex:0];
    [self.imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(imgH);
    }];
    self.imgHeader.contentMode = UIViewContentModeScaleAspectFill;
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }
    else if(section==1){
        if(self.dataModel.top_three.count>0){
          return 1;
        }else{
          return 0;
        }
    }
    else{
        return self.dataArr.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        FNcandiesRanSeekCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNcandiesRanSeekCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        cell.model=self.dataModel;
        cell.delegate=self;
        return cell;
    }
    else if(indexPath.section==1){
        FNcandiesRanTopItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNcandiesRanTopItemCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        cell.model=self.dataModel;
        return cell;
    }
    else{
        FNcandiesRankingItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNcandiesRankingItemCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=[FNcandiesRankItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=250;
    CGFloat itemWith=FNDeviceWidth;
    if(indexPath.section==0){
        itemHeight=SafeAreaTopHeight+45;
        itemWith=FNDeviceWidth;
    }
    else if(indexPath.section==1){
        itemHeight=281;
        itemWith=FNDeviceWidth;
    }
    else if(indexPath.section==2){
        itemHeight=81;
        itemWith=FNDeviceWidth;
    }
    CGSize  size = CGSizeMake(itemWith, itemHeight);
    return  size;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
//    if(section==2){
//       return 10;
//    }
    return 0;
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=0;
    CGFloat bottomGap=0;
    CGFloat rightGap=0;
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//规则
-(void)rightBtnAction{
    
}
#pragma mark - FNcandiesRanSeekCellDelegate <NSObject>
// 搜索
- (void)didRanSeekWithcontent:(NSString*)str{
    self.seekPhone=str;
    self.jm_page=1;
    [self requestBendi];
}
#pragma mark - request
//排行榜页面接口接口
-(FNRequestTool*)requestPayment{
    @weakify(self);
    [SVProgressHUD show];
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
    if([self.seekPhone kr_isNotEmpty]){
        params[@"phone"]=self.seekPhone;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dwqkb&ctrl=rank_list" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        @strongify(self);
        NSDictionary *dictry = respondsObject[DataKey];
        self.dataModel=[FNcandiesRankingModel mj_objectWithKeyValues:dictry];
        self.navigationView.titleLabel.text=self.dataModel.dwqkb_rank_title;
        [self.leftBtn sd_setImageWithURL:URL(self.dataModel.dwqkb_rank_return_btn) forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor colorWithHexString:self.dataModel.dwqkb_rank_top_color] forState:UIControlStateNormal];
        self.navigationView.titleLabel.textColor=[UIColor colorWithHexString:self.dataModel.dwqkb_rank_top_color];
        [self.imgHeader setUrlImg:self.dataModel.dwqkb_rank_top_bj];
        NSArray *array =self.dataModel.rank_list;
        if (self.jm_page == 1) {
            if (array.count == 0) {
                [self.dataArr removeAllObjects];
                [self.jm_collectionview reloadData];
                return ;
            }
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.jm_page ++;
                    [self requestBendi];
                }];
            }
        } else {
            [self.dataArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                [self.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [self.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [UIView performWithoutAnimation:^{
            [self.jm_collectionview reloadData];
        }];
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:NO isCache:NO];
}

-(void)requestBendi{
    [SVProgressHUD show];
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
    if([self.seekPhone kr_isNotEmpty]){
        params[@"phone"]=self.seekPhone;
    }
    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:@"mod=appapi&act=dwqkb&ctrl=rank_list" successBlock:^(id responseBody) {
        [SVProgressHUD dismiss];
        NSInteger success=[responseBody[SuccessKey] integerValue];
        NSString *msg=responseBody[MsgKey];
        if(success==0){
            [FNTipsView showTips:msg];
            return ;
        }
        @strongify(self);
        NSDictionary *dictry = responseBody[DataKey];
        self.dataModel=[FNcandiesRankingModel mj_objectWithKeyValues:dictry];
        self.navigationView.titleLabel.text=self.dataModel.dwqkb_rank_title;
        if([self.dataModel.dwqkb_rank_return_btn kr_isNotEmpty]){
           [self.leftBtn sd_setImageWithURL:URL(self.dataModel.dwqkb_rank_return_btn) forState:UIControlStateNormal];
        } 
        [self.rightBtn setTitleColor:[UIColor colorWithHexString:self.dataModel.dwqkb_rank_top_color] forState:UIControlStateNormal];
        self.navigationView.titleLabel.textColor=[UIColor colorWithHexString:self.dataModel.dwqkb_rank_top_color];
        [self.imgHeader setUrlImg:self.dataModel.dwqkb_rank_top_bj];
        if([self.dataModel.top_bili kr_isNotEmpty]){
           CGFloat topImgHight=[self.dataModel.top_bili floatValue] *FNDeviceWidth;
           [self.imgHeader mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view);
                make.left.right.equalTo(self.view);
                make.height.mas_equalTo(topImgHight);
           }];
        }
        NSArray *array =self.dataModel.rank_list;
        if (self.jm_page == 1) {
            if (array.count == 0) {
                [self.dataArr removeAllObjects];
                [self.jm_collectionview reloadData];
                return ;
            }
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.jm_page ++;
                    [self requestBendi];
                }];
            }
        } else {
            [self.dataArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                [self.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [self.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [UIView performWithoutAnimation:^{
            [self.jm_collectionview reloadData];
        }];
    } failureBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
    }];
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    CGFloat imgH=415;
    if (conY<0) {
        [_imgHeader mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
            make.height.mas_equalTo(imgH - conY);
        }];
    }else{
        [_imgHeader mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(-conY);
            make.height.mas_equalTo(imgH);
        }];
    }
    if (conY>0 && conY<=JMNavBarHeigth) {
        //滚动中
        self.navigationView.backgroundColor = [RGB(204, 123, 209) colorWithAlphaComponent:conY/JMNavBarHeigth];
    }else if (conY > JMNavBarHeigth){
        self.navigationView.backgroundColor = RGB(204, 123, 209);
    }else{
        self.navigationView.backgroundColor = [UIColor clearColor];
    }
}
@end
