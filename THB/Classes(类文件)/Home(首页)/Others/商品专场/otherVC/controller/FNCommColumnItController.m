//
//  FNCommColumnItController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNCommColumnItController.h"
#import "FNCustomeNavigationBar.h"
#import "FNCommodityGoodsItemMCell.h"
#import "FNCommColummitHeaderView.h"
@interface FNCommColumnItController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)NSMutableArray *dataGoodsArr;
@end

@implementation FNCommColumnItController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - set top views
- (void)setTopViews{
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.view addSubview:self.navigationView];
    [self.view bringSubviewToFront:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 17);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    self.navigationView.titleLabel.text=self.keyWord?self.keyWord:@"美好家居";//;
    [self.leftBtn setImage:IMAGE(@"return_w") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=RGB(255, 90, 79);
    self.navigationView.titleLabel.textColor=[UIColor whiteColor];
    self.leftBtn.imageView.sd_layout
    .centerYEqualToView(self.leftBtn).widthIs(8).heightIs(16).leftSpaceToView(self.leftBtn, 10);
    if(self.understand==YES){
        self.leftBtn.hidden=YES;
    }
    self.navigationView.hidden=YES;
    
    NSString *jsonInfo=[self.headModel valueForKey:@"jsonInfo"];
    if ([jsonInfo kr_isNotEmpty]) {
        NSData *data = [jsonInfo dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error == nil && json) {
            NSString *special_nav_bjcolor=json[@"special_nav_bjcolor"];
            NSString *special_nav_color=json[@"special_nav_color"];
            if([special_nav_bjcolor kr_isNotEmpty]){
                self.navigationView.backgroundColor=[UIColor colorWithHexString:special_nav_bjcolor];
            }
            if([special_nav_color kr_isNotEmpty]){
               self.navigationView.titleLabel.textColor=[UIColor colorWithHexString:special_nav_color];
            }
        }
    }

}

-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - set up views
- (void)jm_setupViews{
    
    self.view.backgroundColor =RGB(250, 250, 250);
    CGFloat baseGap=0;
    if(self.understand==YES){
        baseGap=XYTabBarHeight;
    }
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=RGB(250, 250, 250);
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.alpha = 1;
    self.jm_collectionview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.jm_collectionview];
    
    [self.jm_collectionview registerClass:[FNCommodityGoodsItemMCell class] forCellWithReuseIdentifier:@"FNCommodityGoodsItemMCellID"];
    [self.jm_collectionview registerClass:[FNCommColummitHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNCommColummitHeaderViewID"];
 
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self setTopViews];
    
    [self requestSpecialGoods]; 
    
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataGoodsArr.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNBaseProductModel *model=[FNBaseProductModel mj_objectWithKeyValues:self.dataGoodsArr[indexPath.row]];
    FNCommodityGoodsItemMCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNCommodityGoodsItemMCellID" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    cell.model=model;
    cell.sharerightNow = ^(FNBaseProductModel *mod) {
        [self shareProductWithModel:mod];
    };
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height=300;
    CGFloat with= (FNDeviceWidth-10)/2;
    CGSize  size= CGSizeMake(with, height);
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
    return 0;
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FNCommColummitHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNCommColummitHeaderViewID" forIndexPath:indexPath];
    [headerView.backBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    NSString *jsonInfo=[self.headModel valueForKey:@"jsonInfo"];
    if ([jsonInfo kr_isNotEmpty]) {
        NSData *data = [jsonInfo dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error == nil && json) {
            NSString *special_img=json[@"special_img"];
            if([special_img kr_isNotEmpty]){
               [headerView.bgImgView setUrlImg:special_img];
            } 
        }
    }
    return headerView; 
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=217;
    return CGSizeMake(with,hight);
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
   
    return UIEdgeInsetsMake(0, 5, 0, 5);
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNBaseProductModel *model=[FNBaseProductModel mj_objectWithKeyValues:self.dataGoodsArr[indexPath.row]];
    [self goProductVCWithModel:model withData:model.data];
}
#pragma mark - Table view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y; 
    if (conY>0 && conY<=217) {
        self.navigationView.hidden=YES;
    }else if (conY > 217){
        self.navigationView.hidden=NO;
    }
    else{
        self.navigationView.hidden=YES;
    }
}
#pragma mark - //专场商品
-(FNRequestTool*)requestSpecialGoods{
    //[SVProgressHUD show];
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page),@"cid":@""}];
    if([self.show_type_str kr_isNotEmpty]){
        params[@"show_type_str"]=self.show_type_str;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=goods_special_performance&ctrl=getgoods" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //[SVProgressHUD dismiss];
        @strongify(self);
        NSArray *array=respondsObject[DataKey];
        if (self.jm_page == 1) {
            if (array.count == 0) {
                return ;
            }
            [self.dataGoodsArr removeAllObjects];
            [self.dataGoodsArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.jm_page ++;
                    [self requestSpecialGoods];
                }];
            }else{
            }
        } else {
            [self.dataGoodsArr addObjectsFromArray:array];
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
        
    } isHideTips:YES];
}
- (NSMutableArray *)dataGoodsArr{
    if (!_dataGoodsArr) {
        _dataGoodsArr = [NSMutableArray array];
    }
    return _dataGoodsArr;
}
@end
