//
//  FNHandSlapdController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNHandSlapdController.h"
#import "FNCustomeNavigationBar.h"
#import "FNhandSlapdFunctionCell.h"
#import "FNhandConditionItemCell.h"
#import "FNhandTermItemCell.h"
#import "FNhandConditionSternView.h"
#import "FNHandSlapdModel.h"
#import "FNHandResultController.h"
@interface FNHandSlapdController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIImageView *imgBgView;
@property (nonatomic, strong)FNHandSlapdModel *dataModel;
@property (nonatomic, strong)NSMutableArray *conditionArr;
@end

@implementation FNHandSlapdController

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
    [self inAddSubViewImg];
    CGFloat topGap=SafeAreaTopHeight;
    CGFloat baseGap=0;
    if(self.understand==YES){
        baseGap=XYTabBarHeight;
    }
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, topGap, FNDeviceWidth, FNDeviceHeight-topGap-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    self.jm_collectionview.alpha = 1;
    self.jm_collectionview.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.jm_collectionview];
   
    [self.jm_collectionview registerClass:[FNhandSlapdFunctionCell class] forCellWithReuseIdentifier:@"FNhandSlapdFunctionCellID"];
    [self.jm_collectionview registerClass:[FNhandTermItemCell class] forCellWithReuseIdentifier:@"FNhandTermItemCellID"];
    
    [self.jm_collectionview registerClass:[FNhandConditionSternView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FNhandConditionSternViewID"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewID"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerViewID"];
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.leftBtn.size = CGSizeMake(40, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal]; 
    
    [self.view addSubview:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 5).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:16];
    self.navigationView.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.navigationView.titleLabel.text=@"成为推手";
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=RGB(250, 250, 250);
    if(self.understand==YES){
        self.leftBtn.hidden=YES;
    }
    if([UserAccessToken kr_isNotEmpty]){
       [self requestHandSlapdMsg];
    }
}
- (void)inAddSubViewImg{
    CGFloat imgH=FNDeviceHeight;
    self.imgBgView = [[UIImageView alloc] init];
    [self.view insertSubview:self.imgBgView atIndex:0];
    [self.self.imgBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(imgH);
    }];
    self.imgBgView.contentMode = UIViewContentModeScaleAspectFill;
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{ 
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        FNhandSlapdFunctionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNhandSlapdFunctionCellID" forIndexPath:indexPath];
        [cell.contentImgView setUrlImg:self.dataModel.equity_img];
        return cell;
    }else{
        FNhandTermItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNhandTermItemCellID" forIndexPath:indexPath];
        cell.model=self.dataModel; 
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=0;
    CGFloat itemWith=FNDeviceWidth;
    if(indexPath.section==0){
       itemHeight=465;
       itemWith=FNDeviceWidth;
    }
    else if(indexPath.section==1){
        NSArray *listArr=self.dataModel.condition;
        itemHeight=listArr.count*50+85;
        itemWith=FNDeviceWidth;
    }
    return  CGSizeMake(itemWith, itemHeight);
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 1;
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
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewID" forIndexPath:indexPath];
            headerView.backgroundColor=[UIColor clearColor];
            return headerView;
    }
    else{
        if(indexPath.section==0){
            UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerViewID" forIndexPath:indexPath];
            footView.backgroundColor=[UIColor clearColor];
            return footView;
        }else{
            FNhandConditionSternView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FNhandConditionSternViewID" forIndexPath:indexPath];
            [footView.askBtn addTarget:self action:@selector(askBtnClick)];
            [footView.askBtn sd_setImageWithURL:URL(self.dataModel.btn) forState:UIControlStateNormal];
            footView.hintLB.text=@"注：达到所有申请条件才能申请成为推手";
            return footView;
        }
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=0; 
    return CGSizeMake(with,hight);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=0;
    if(section==0){
        hight=0;
    }
    else if(section==1){
        hight=152;
    }
    return CGSizeMake(with,hight);
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES]; 
}
//申请成为推手
-(void)askBtnClick{
    [self requestHand];
}
#pragma mark - request
//推手中心-申请页面
-(FNRequestTool*)requestHandSlapdMsg{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=push_hand&ctrl=apply_page" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary *dictry = respondsObject[DataKey];
        self.dataModel=[FNHandSlapdModel mj_objectWithKeyValues:dictry];
        [self.imgBgView setUrlImg:self.dataModel.bg_img];
        self.navigationView.titleLabel.text=self.dataModel.title;
        [self.leftBtn sd_setImageWithURL:URL(self.dataModel.return_icon) forState:UIControlStateNormal];
        //[self.leftBtn setImage:IMAGE(@"return_w") forState:UIControlStateNormal];
        self.navigationView.titleLabel.textColor=[UIColor colorWithHexString:self.dataModel.title_color];
        self.navigationView.backgroundColor=[UIColor clearColor];
        [self.jm_collectionview reloadData]; 
        
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}
//推手中心-申请接口
-(FNRequestTool*)requestHand{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=push_hand&ctrl=apply" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSInteger stateInt=[respondsObject[SuccessKey] integerValue];
        NSString *msgStr=respondsObject[MsgKey];
        [FNTipsView showTips:msgStr];
        if(stateInt==1){
           [self didFNSkipController:@"FNHandResultController"];
        }
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}
@end
