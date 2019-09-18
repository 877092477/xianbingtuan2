//
//  FNmerchentReviewSController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/10.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerchentReviewSController.h"
#import "FNmerDiscussReplyController.h"
#import "FNCustomeNavigationBar.h"
#import "FNmerchentReviewModel.h"
#import "FNmerchentReviewItemCell.h"
#import "FNmerReviewHeadMsgCell.h"
#import "FNmerReviewheadView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "FNmerDiscussQueryView.h"
@interface FNmerchentReviewSController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNmerReviewPrintsViewDelegate,FNmerchentReviewItemCellDelegate,FNmerDiscussQueryViewDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)FNmerReviewHeadModel *headModel;
@property (nonatomic, strong)NSString *commentCount;
@property (nonatomic, strong)FNmerDiscussQueryView *customView;
@property (nonatomic, strong)FNmerReviewQueryModel *queryModel;
@end

@implementation FNmerchentReviewSController

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
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
#pragma mark - set up views
- (void)jm_setupViews{
    self.commentCount=@"";
    CGFloat baseGap=SafeAreaTopHeight+1;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, baseGap, FNDeviceWidth, FNDeviceHeight-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    //self.jm_collectionview.alpha = 1;
    //self.jm_collectionview.backgroundColor = [UIColor clearColor];
    self.jm_collectionview.backgroundColor=RGB(246, 245, 245);
    [self.view addSubview:self.jm_collectionview];
    
    [self.jm_collectionview registerClass:[FNmerchentReviewItemCell class] forCellWithReuseIdentifier:@"FNmerchentReviewItemCellID"];
    
    [self.jm_collectionview registerClass:[FNmerReviewheadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNmerReviewheadViewID"];
    
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
    self.navigationView.titleLabel.text=@"评论信息";
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    
    self.view.backgroundColor=RGB(246, 245, 245);
    [self requestReviewHeadMsg];
    [self requestreviews];
    [self requestQueryMsg];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
 
    return self.dataArr.count;
 
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNmerchentReviewItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerchentReviewItemCellID" forIndexPath:indexPath];
    cell.model=[FNmerchentReviewModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
    cell.imgListView.delegate=self;
    cell.indexPa=indexPath;
    cell.delegate=self;
    cell.backgroundColor=[UIColor whiteColor];
    return cell; 
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FNmerReviewheadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNmerReviewheadViewID" forIndexPath:indexPath];
    headerView.model=self.headModel;
    headerView.reviewLB.text=self.commentCount;
    headerView.backgroundColor=[UIColor whiteColor];
    return headerView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=160;
    return CGSizeMake(with,hight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=0;
    CGFloat itemWith=FNDeviceWidth;
 
        FNmerchentReviewModel *itemModel=[FNmerchentReviewModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
        CGFloat itHeight=96;//(FNDeviceWidth-30)/3;
        CGFloat listHeight=0;
        CGFloat row=itemModel.imgs.count;
        CGFloat coFloat=row/2;
        CGFloat secInt=ceil(coFloat);
        NSInteger lonRow=0;
        if(secInt>0){
           lonRow=secInt-1;
        }
        listHeight=itHeight*secInt+2*lonRow;
        CGFloat textheight=70;
        CGFloat textWidth=FNDeviceWidth-77;
        if([itemModel.content kr_isNotEmpty]){
            textheight=[itemModel.content kr_heightWithMaxWidth:textWidth attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        }
        itemHeight=listHeight+textheight+10+44+60+33;
 
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
       return 10;
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=0;
    CGFloat bottomGap=10;
    CGFloat rightGap=0; 
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNmerchentReviewModel *modelItem=[FNmerchentReviewModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
    FNmerDiscussReplyController *vc=[[FNmerDiscussReplyController alloc]init];
    vc.oidStr=modelItem.id;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];

}
// FNmerReviewPrintsViewDelegate  点击评论图片
- (void)inmerReviewPrintsAction:(NSArray*)imgArr isIndex:(NSInteger)index{
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
        // 弹出相册时显示的第一张图片是点击的图片
        browser.currentPhotoIndex = index;
        NSMutableArray *photos = [NSMutableArray array];
        NSArray *imgs = imgArr;
        [imgs enumerateObjectsUsingBlock:^(id  _Nonnull sobj, NSUInteger idx, BOOL * _Nonnull stop) {
            MJPhoto *mjPhoto = [[MJPhoto alloc] init];
            mjPhoto.url = [NSURL URLWithString:sobj];
            //mjPhoto.srcImageView = imageview;
            [photos addObject:mjPhoto];
        }]; 
        // 设置所有的图片。photos是一个包含所有图片的数组。
        browser.photos = photos;
        [browser show];
}
#pragma mark - FNmerchentReviewItemCellDelegate
// 点击点赞
- (void)didMerLikeActionIsIndex:(NSIndexPath*)index{
    XYLog(@"点赞%ld",(long)index.row);
    FNmerchentReviewModel *modelItem=[FNmerchentReviewModel mj_objectWithKeyValues:self.dataArr[index.row]];
    [self requestEndorseMsg:modelItem.id];
}
// 点击评论
- (void)didMerReviewActionIsIndex:(NSIndexPath*)index{
    XYLog(@"评论%ld",(long)index.row);
    FNmerchentReviewModel *modelItem=[FNmerchentReviewModel mj_objectWithKeyValues:self.dataArr[index.row]];
    FNmerDiscussReplyController *vc=[[FNmerDiscussReplyController alloc]init];
    vc.oidStr=modelItem.id;
    [self.navigationController pushViewController:vc animated:YES];
}
//点击疑问
- (void)didMerQueryActionIsIndex:(NSIndexPath*)index{
    XYLog(@"疑问%ld",(long)index.row);
    if(self.queryModel.type.count>0){
        self.customView = [[FNmerDiscussQueryView alloc] initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight)];
        self.customView.delegate=self;
        self.customView.model=self.queryModel;
        self.customView.backIndex=index;
        [self.customView.rightBtn addTarget:self action:@selector(customViewDiss)];
        [self.view addSubview:self.customView];
        [self.customView showView];
    }else{
        [self requestQueryMsg];
        [FNTipsView showTips:@"请重试"];
    }
}
//取消疑问
-(void)customViewDiss{
    [self.customView dismissView];
}
#pragma mark - FNmerDiscussQueryViewDelegate 提交疑问
- (void)didMerAffirmQueryIndex:(NSIndexPath*)index withType:(NSString*)type withContent:(NSString*)content{
    FNmerchentReviewModel *modelItem=[FNmerchentReviewModel mj_objectWithKeyValues:self.dataArr[index.row]];
    XYLog(@"意见%@",content);
    XYLog(@"类型%@",type);
    if([content kr_isNotEmpty] && [type kr_isNotEmpty]){
       [self requestPresentQueryMsg:modelItem.id withType:type withContent:content];
       [self.customView dismissView];
    }
}
#pragma mark - // request
//评论信息头部接口
-(FNRequestTool*)requestReviewHeadMsg{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=comment_info_top" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary *dictry=respondsObject[DataKey];
        self.headModel=[FNmerReviewHeadModel mj_objectWithKeyValues:dictry];
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {
    } isHideTips:YES isCache:NO];
}
//商家中心-评论列表
-(FNRequestTool*)requestreviews{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=comment_list" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary *dictry=respondsObject[DataKey];
        self.commentCount=dictry[@"comment_count"];
        NSArray *array =dictry[@"list"]; 
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
                    [self requestreviews];
                }];
            }else{
            }
        } else {
            [self.dataArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                [self.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [self.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [self.jm_collectionview reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
    } isHideTips:YES isCache:NO];
}

///评论点赞
-(void)requestEndorseMsg:(NSString*)discussid{
    if([discussid kr_isNotEmpty]){
        @weakify(self);
        NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
        params[@"id"]=discussid;
        [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_comment&ctrl=vote" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
            @strongify(self);
            NSDictionary*dictry=respondsObject;
            NSInteger success=[dictry[@"success"] integerValue];
            NSString *mesString=dictry[@"msg"];
            [FNTipsView showTips:mesString];
            if(success==1){
               self.jm_page=1;
               [self requestreviews];
            }
        } failure:^(NSString *error) {
        } isHideTips:NO isCache:NO];
    }
}
///疑问页面
-(void)requestQueryMsg{ 
        @weakify(self);
        NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
        [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_comment&ctrl=doubt_page" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
            @strongify(self);
            NSDictionary*dictry=respondsObject[DataKey];
            self.queryModel=[FNmerReviewQueryModel mj_objectWithKeyValues:dictry];
        } failure:^(NSString *error) {
        } isHideTips:NO isCache:NO];
}
///提交疑问
-(void)requestPresentQueryMsg:(NSString*)msgID withType:(NSString*)type withContent:(NSString*)content{
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    params[@"id"]=content;
    params[@"type"]=type;
    params[@"content"]=content;
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_comment&ctrl=add_doubt" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSDictionary*dictry=respondsObject;
        NSString *mesString=dictry[@"msg"];
        [FNTipsView showTips:mesString];
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
 

@end
