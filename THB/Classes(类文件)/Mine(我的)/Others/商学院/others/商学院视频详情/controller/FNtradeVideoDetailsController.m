//
//  FNtradeVideoDetailsController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNtradeVideoDetailsController.h"
#import "FNVideoPlayerController.h"
#import "FNCustomeNavigationBar.h" 
#import "FNtradeRecommendCell.h"
#import "FNtradeVideoDeTopCell.h"
#import "FNtradeLeftTextHeadView.h" 
#import "JhScrollActionSheetView.h"
#import "JhPageItemModel.h"
@interface FNtradeVideoDetailsController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, assign)BOOL topState;
@end

@implementation FNtradeVideoDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:self.topState animated:NO];
}
#pragma mark - set up views
- (void)jm_setupViews{
    self.topState=NO;
    CGFloat baseGap=SafeAreaTopHeight+1;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, baseGap, FNDeviceWidth, FNDeviceHeight-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=RGB(238, 238, 238);
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNtradeVideoDeTopCell class] forCellWithReuseIdentifier:@"FNtradeVideoDeTopCellID"];
    [self.jm_collectionview registerClass:[FNtradeRecommendCell class] forCellWithReuseIdentifier:@"FNtradeRecommendCellID"];
    
    [self.jm_collectionview registerClass:[FNtradeLeftTextHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNtradeLeftTextHeadViewID"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewHeadID"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableViewFootID"];
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.view addSubview:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 10).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    self.navigationView.titleLabel.text=self.keyWord ? self.keyWord:@"必看视频";
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    
    //self.jm_collectionview.hidden=YES;
    self.view.backgroundColor=RGB(245, 245, 245);;
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
   
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.stateLabel.hidden=YES;
    NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
    for (NSInteger i=1; i<32; i++) {
        [arrM addObject:[UIImage imageNamed:[NSString stringWithFormat:@"FN_bottom_loading－%ld",(long)i]]];
    }
    //[footer setImages:arrM  forState:MJRefreshStateRefreshing];
    [footer setImages:arrM duration:arrM.count * 0.04 forState:MJRefreshStateRefreshing];
    
    self.jm_collectionview.mj_footer=footer;
}
-(void)loadMoreData{
    //[self.jm_collectionview.mj_footer endRefreshing];
   
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){
       return 1;
    }else{
       return 10;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){
        FNtradeVideoDeTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNtradeVideoDeTopCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        [cell.playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        FNtradeRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNtradeRecommendCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        return cell;
    } 
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=0;
    CGFloat itemWith=FNDeviceWidth;
    if(indexPath.section==0){
       itemHeight=300;
    }else{
       itemHeight=112;
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
    return 0;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        if(indexPath.section==2){
            FNtradeLeftTextHeadView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FNtradeLeftTextHeadViewID" forIndexPath:indexPath];
            
            return view;
        }else{
            UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableViewHeadID" forIndexPath:indexPath];
            return view;
        }
    }else{
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableViewFootID" forIndexPath:indexPath];
        view.backgroundColor=RGB(238, 238, 238);
        return view;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGFloat sectionHeight=0;
    if(section==1){
        sectionHeight=40;
    }
    return CGSizeMake(FNDeviceWidth, sectionHeight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGFloat sectionFooterHeight=0;
    if(section==0){
        sectionFooterHeight=9;
    }
    return CGSizeMake(FNDeviceWidth, sectionFooterHeight);
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=0;
    CGFloat bottomGap=0;
    CGFloat rightGap=0;
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    self.topState=NO;
    [self.navigationController popViewControllerAnimated:YES];
}
//分享
-(void)shareBtnClick:(UIButton*)btn{
    NSArray *datas = @[@{@"text" : @"微信",@"img" : @"FJ_wximg"},@{@"text" : @"朋友圈",@"img" : @"FJ_pyimg"},@{@"text" : @"QQ",@"img" : @"FJ_qqimg"},@{@"text" : @"微博",@"img" : @"FJ_wbimg"},@{@"text" : @"保存图片",@"img" : @"FJ_bcimg"}];
    NSMutableArray *shareArray=[NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *data in datas) {
        JhPageItemModel *item = [[JhPageItemModel alloc] init];
        item.text = data[@"text"];
        item.img = data[@"img"];
        [shareArray addObject:item];
    }
    NSString *hintString=@"注：由于新版微信调整了分享策略，如遇到多图无法分享至朋友圈，请先保存图片再打开微信分享。";
    [JhScrollActionSheetView  showShareActionSheetWithTitle:@"分享方式" withdescribe:hintString shareDataArray:shareArray handler:^(JhScrollActionSheetView *actionSheet, NSInteger index) {
        if (index == 4) {
            
        }
    }];
}
//播放
-(void)playBtnClick:(UIButton*)btn{
    self.topState=YES;
   //https:\/\/vd2.bdstatic.com\/mda-ic2rqiyq9ex78pcv\/sc\/mda-ic2rqiyq9ex78pcv.mp4
    FNVideoPlayerController *vc=[[FNVideoPlayerController alloc]init];
    [vc playVideoWithUrl:URL(@"https:\/\/vd2.bdstatic.com\/mda-ic2rqiyq9ex78pcv\/sc\/mda-ic2rqiyq9ex78pcv.mp4")];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
