//
//  FNLogisticsInfosController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLogisticsInfosController.h"
#import "FNCustomeNavigationBar.h"
#import "FNlogisticsInfoItemCell.h"
#import "FNlogisticsHeadView.h"
#import "FNlogisticsInfoModel.h"
@interface FNLogisticsInfosController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)FNCustomeNavigationBar *navigationView;
@property (nonatomic, strong)UIButton     *leftBtn;
@property (nonatomic, strong)FNlogisticsInfoModel *dataModel;
@property (nonatomic, strong)NSMutableArray *dataArr;
@end

@implementation FNLogisticsInfosController

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
    
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    [self.view addSubview:self.jm_collectionview];
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.jm_collectionview registerClass:[FNlogisticsInfoItemCell class] forCellWithReuseIdentifier:@"FNlogisticsInfoItemCellID"];
    
    [self.jm_collectionview registerClass:[FNlogisticsHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNlogisticsHeadViewID"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableViewFooterID"];
    
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 10).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.leftButton = self.leftBtn;
    
    [self.view addSubview:self.navigationView];
    
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    self.navigationView.titleLabel.text=@"物流信息";
    self.navigationView.titleLabel.textColor=[UIColor whiteColor];
    [self.leftBtn setImage:IMAGE(@"return_w") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor clearColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if([self.SkipUIIdentifier kr_isNotEmpty]&&[self.orderID kr_isNotEmpty]){
       [self requestLogisticsInfo];
    } 
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNlogisticsInfoItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNlogisticsInfoItemCellID" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    cell.model=self.dataArr[indexPath.row];
    return cell; 
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemWith=FNDeviceWidth;
    CGFloat itemHeight=83;
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
    return 0;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=0;
    CGFloat bottomGap=0;
    CGFloat rightGap=0;
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        FNlogisticsHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNlogisticsHeadViewID" forIndexPath:indexPath];
        headerView.backgroundColor=[UIColor whiteColor];
        headerView.model=self.dataModel;
        [headerView.cyBtn addTarget:self action:@selector(cyBtnClick)];
        return headerView;
    }else{
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableViewFooterID" forIndexPath:indexPath];
        view.backgroundColor=[UIColor whiteColor];
        return view;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=234;
    return CGSizeMake(with,hight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(FNDeviceWidth, 50);
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//复制
-(void)cyBtnClick{
    if([self.dataModel.wl_num kr_isNotEmpty]){
       [FNTipsView showTips:@"复制成功"];
       [[UIPasteboard generalPasteboard] setString:self.dataModel.wl_num];
    }
}
//滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    
    if (conY>0 && conY<=234) {
        //滚动中
        self.navigationView.backgroundColor = [RGB(47, 95, 160) colorWithAlphaComponent:conY/JMNavBarHeigth];
    }else if (conY > 234){
        self.navigationView.backgroundColor = RGB(47, 95, 160);
    }else{
        self.navigationView.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark - request
//物流信息
-(FNRequestTool*)requestLogisticsInfo{
    [SVProgressHUD show];
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    params[@"SkipUIIdentifier"]=self.SkipUIIdentifier;
    params[@"oid"]=self.orderID;
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=wl_list&ctrl=index" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        [SVProgressHUD  dismiss];
        @strongify(self);
        NSDictionary *dictry = respondsObject[DataKey];
        self.dataModel=[FNlogisticsInfoModel mj_objectWithKeyValues:dictry];
 
        self.navigationView.titleLabel.text=self.dataModel.title;
        [self.leftBtn sd_setImageWithURL:URL(self.dataModel.return_img) forState:UIControlStateNormal];
        self.navigationView.titleLabel.textColor=[UIColor colorWithHexString:self.dataModel.title_color];
        self.navigationView.backgroundColor=[UIColor clearColor];
        
        NSArray *arrM=self.dataModel.wl_data;
        if(arrM.count==0){
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
            [SVProgressHUD showImage:IMAGE(@"") status:@"暂无更多信息"];
            [SVProgressHUD dismissWithDelay:2.0];
        }
        NSMutableArray *arrList=[NSMutableArray arrayWithCapacity:0];
        [arrM enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNlogisticsInfoItemModel *model=[FNlogisticsInfoItemModel mj_objectWithKeyValues:obj];
            model.state=idx;
            [arrList addObject:model];
        }];
        self.dataArr=arrList;
        [UIView performWithoutAnimation:^{
            [self.jm_collectionview reloadData];
        }];
    } failure:^(NSString *error) {
        [SVProgressHUD  dismiss];
    } isHideTips:NO isCache:NO];
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
