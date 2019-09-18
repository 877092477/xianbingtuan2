//
//  FNmerSetPhotoHomeController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/1.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerSetPhotoHomeController.h"
#import "FNmerPhotoSceneController.h"
#import "FNCustomeNavigationBar.h"
#import "FNmerPhotoHomeItemCell.h"
#import "FNmerPhotoHomeSkyCell.h"
#import "FNmerPhotoDeletePuView.h" 
#import "DSHPopupContainer.h"
#import "FNmerSetPhotoItemModel.h"
#import "FNmerAddTallyPhotoController.h"
@interface FNmerSetPhotoHomeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNmerPhotoHomeItemCellDelegate,FNmerAddTallyPhotoControllerDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar *navigationView;
@property (nonatomic, strong)DSHPopupContainer      *container;
@property (nonatomic, strong)UIButton     *leftBtn;
@property (nonatomic, strong)UIButton     *rightBtn;
@property (nonatomic, strong)UIButton     *rightDeleteBtn;
@property (nonatomic, strong)UIButton     *rightRankBtn;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSString *photoItemID;
@property (nonatomic, assign)NSInteger gestureState;
@end

@implementation FNmerSetPhotoHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self requestZhaoPianBendi];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
#pragma mark - set up views
- (void)jm_setupViews{
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
    self.jm_collectionview.backgroundColor=RGB(250, 250, 250);
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNmerPhotoHomeSkyCell class] forCellWithReuseIdentifier:@"FNmerPhotoHomeSkyCellID"];
    [self.jm_collectionview registerClass:[FNmerPhotoHomeItemCell class] forCellWithReuseIdentifier:@"FNmerPhotoHomeItemCellID"];
    
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 10).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16); 
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.leftButton = self.leftBtn;
    
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightBtn.size = CGSizeMake(30, 30);
    self.rightBtn.imageView.sd_layout
    .rightSpaceToView(self.rightBtn, 5).centerYEqualToView(self.rightBtn).widthIs(15).heightIs(15);
    self.navigationView.rightButton = self.rightBtn;
    [self.rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.rightBtn setImage:IMAGE(@"FN_YJAddicon") forState:UIControlStateNormal];
    
    [self.view addSubview:self.navigationView];
    
    self.rightDeleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.rightDeleteBtn addTarget:self action:@selector(rightDeleteBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.rightDeleteBtn setImage:IMAGE(@"FN_merLJXicon") forState:UIControlStateNormal];
    [self.rightDeleteBtn setImage:IMAGE(@"FN_merpreOrLJTicon") forState:UIControlStateSelected]; 
    self.rightDeleteBtn.selected=NO;
    [self.navigationView addSubview:self.rightDeleteBtn];
    
    self.rightDeleteBtn.sd_layout
    .centerYEqualToView(self.navigationView.rightButton).widthIs(30).heightIs(30).rightSpaceToView(self.navigationView.rightButton, 5);
    self.rightDeleteBtn.imageView.sd_layout
    .centerXEqualToView(self.rightDeleteBtn).centerYEqualToView(self.rightDeleteBtn).widthIs(15).heightIs(15);
    
    
    self.rightRankBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.rightRankBtn addTarget:self action:@selector(rightRankBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.rightRankBtn setImage:IMAGE(@"FN_merblPXicon") forState:UIControlStateNormal];
    [self.rightRankBtn setImage:IMAGE(@"FN_merorPXicon") forState:UIControlStateSelected];
    self.rightRankBtn.selected=NO;
    [self.navigationView addSubview:self.rightRankBtn];
    self.rightRankBtn.sd_layout
    .centerYEqualToView(self.navigationView.rightButton).widthIs(30).heightIs(30).rightSpaceToView(self.rightDeleteBtn, 2);
    self.rightRankBtn.imageView.sd_layout
    .centerXEqualToView(self.rightRankBtn).centerYEqualToView(self.rightRankBtn).widthIs(15).heightIs(15);
    
    
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    self.navigationView.titleLabel.text=@"店铺相册";
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    
    self.view.backgroundColor=RGB(250, 250, 250);
    //self.jm_collectionview.hidden=YES;
    //[self requestZhaoPianBendi];
    self.gestureState=0;
    
}
- (void)longPressMethod:(UILongPressGestureRecognizer *)longPressGes {
    if(self.gestureState==1){
        // 判断手势状态
        switch (longPressGes.state) {
                
            case UIGestureRecognizerStateBegan: {
                
                // 判断手势落点位置是否在路径上(长按cell时,显示对应cell的位置,如path = 1 - 0,即表示长按的是第1组第0个cell). 点击除了cell的其他地方皆显示为null
                NSIndexPath *indexPath = [self.jm_collectionview indexPathForItemAtPoint:[longPressGes locationInView:self.jm_collectionview]];
                // 如果点击的位置不是cell,break
                if (nil == indexPath) {
                    break;
                }
                NSLog(@"%@",indexPath);
                // 在路径上则开始移动该路径上的cell
                [self.jm_collectionview beginInteractiveMovementForItemAtIndexPath:indexPath];
            }
                break;
                
            case UIGestureRecognizerStateChanged:
                // 移动过程当中随时更新cell位置
                [self.jm_collectionview updateInteractiveMovementTargetPosition:[longPressGes locationInView:self.jm_collectionview]];
                break;
                
            case UIGestureRecognizerStateEnded:
                // 移动结束后关闭cell移动
                [self.jm_collectionview endInteractiveMovement];
                break;
            default:
                [self.jm_collectionview cancelInteractiveMovement];
                break;
        }
    }
   
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if(self.dataArr.count>0 && self.gestureState==1){
        FNmerSetPhotoItemModel *model=self.dataArr[sourceIndexPath.row];
        [self.dataArr removeObject:model];
        [self.dataArr insertObject:model atIndex:destinationIndexPath.row];
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        for (FNmerSetPhotoItemModel *itemModel in self.dataArr) {
            [arrM addObject:itemModel.id];
        }
        NSString *stringJoint=[arrM componentsJoinedByString:@","];
        XYLog(@"排序=%@",stringJoint);
        if([stringJoint kr_isNotEmpty]){
           [self requestSortImgWithIds:stringJoint];
        }
    }
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(self.dataArr.count>0){
       return self.dataArr.count;
    }else{
       return 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.dataArr.count>0){
        FNmerPhotoHomeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerPhotoHomeItemCellID" forIndexPath:indexPath];
        cell.index=indexPath;
        cell.delegate=self;
        cell.backgroundColor=RGB(250, 250, 250);
        cell.model=self.dataArr[indexPath.row];
        return cell;
    }else{
        FNmerPhotoHomeSkyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerPhotoHomeSkyCellID" forIndexPath:indexPath];
        [cell.addBtnView addTarget:self action:@selector(addBtnViewAction)];
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemWith=(FNDeviceWidth-52)/2;
    CGFloat itemHeight=itemWith*(169/161)+14;//itemWith+8;
    if(self.dataArr.count==0){
        itemWith=FNDeviceWidth;
        itemHeight=FNDeviceHeight-SafeAreaTopHeight-1;
    }
    CGSize  size = CGSizeMake(itemWith, itemHeight);
    return  size;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 7;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.dataArr.count>0){
        FNmerSetPhotoItemModel *model=self.dataArr[indexPath.row];
        FNmerPhotoSceneController *vc=[[FNmerPhotoSceneController alloc]init];
        vc.photoID=model.id;
        //vc.keyWord=model.name;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=20;
    CGFloat leftGap=20;
    CGFloat bottomGap=10;
    CGFloat rightGap=20;
    if(self.dataArr.count==0){
        topGap=0;
        bottomGap=0;
        leftGap=0;
        rightGap=0;
    }
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightBtnAction{
    FNmerAddTallyPhotoController *vc=[[FNmerAddTallyPhotoController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)rightDeleteBtnAction:(UIButton*)btn{
    btn.selected=!btn.selected;
    if(btn.selected==YES){
        [self.dataArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNmerSetPhotoItemModel *model=obj;
            model.state=1;
        }];
    }else{
        [self.dataArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNmerSetPhotoItemModel *model=obj;
            model.state=0;
        }];
    }
    [UIView performWithoutAnimation:^{
        [self.jm_collectionview reloadData];
    }];
}
//排序
-(void)rightRankBtnAction:(UIButton*)btn{
    btn.selected=!btn.selected;
    if(btn.selected==YES){
        self.gestureState=1;
    }else{
        self.gestureState=0;
    }
}
//添加
-(void)addBtnViewAction{
    FNmerAddTallyPhotoController *vc=[[FNmerAddTallyPhotoController alloc]init];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - FNmerAddTallyPhotoControllerDelegate // 添加相册成功刷新
- (void)inDidMerAddTallyPhotoRefreshAction{
    XYLog(@"刷新相册");
    //[self requestZhaoPianBendi];
}
#pragma mark - FNmerPhotoHomeItemCellDelegate
// 点击删除
- (void)didMerdeletePhotoAlbumIndex:(NSIndexPath*)index{
    FNmerSetPhotoItemModel *model=self.dataArr[index.row];
    self.photoItemID=model.id;
    FNmerPhotoDeletePuView *puView = [[FNmerPhotoDeletePuView alloc] init];
    [puView.leftBtn addTarget:self action:@selector(puViewVanishClick)];
    [puView.rightBtn addTarget:self action:@selector(puViewDeleteClick)];
    self.container = [[DSHPopupContainer alloc] initWithCustomPopupView:puView];
    self.container.autoDismissWhenClickedBackground=NO;
    self.container.maskColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    [self.container show];
}
-(void)puViewVanishClick{
    [self.container dismiss];
}
-(void)puViewDeleteClick{
    [self requestDeleteImgBendi];
    [self.container dismiss];
}
#pragma mark -  本地数据 商家相册列表
-(void)requestZhaoPianBendi{
    [SVProgressHUD show];
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
    @weakify(self);
    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:@"mod=appapi&act=rebate_album&ctrl=album_list_admin" successBlock:^(id responseBody) {
        XYLog(@"responseBody=%@",responseBody);
        @strongify(self);
        [SVProgressHUD dismiss];
        NSDictionary *enArr=responseBody[DataKey];
        NSArray *listArr=enArr[@"list"];
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        if(enArr.count>0){
            [listArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNmerSetPhotoItemModel *model=[FNmerSetPhotoItemModel mj_objectWithKeyValues:obj];
                model.state=0;
                model.type=0;
                [arrM addObject:model];
            }];
        }
        NSArray *array =arrM;//respondsObject[DataKey];
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
                    [self requestZhaoPianBendi];
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
        if(self.dataArr.count>0){
            UILongPressGestureRecognizer *longPresssGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMethod:)];
            [self.jm_collectionview addGestureRecognizer:longPresssGes];
        }
        [self.jm_collectionview reloadData];
    } failureBlock:^(NSString *error) {
    }];
}
#pragma mark -  本地数据 删除相册
-(void)requestDeleteImgBendi{
    [SVProgressHUD show];
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    params[@"id"]=self.photoItemID;
    @weakify(self);
    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:@"mod=appapi&act=rebate_album&ctrl=album_del" successBlock:^(id responseBody) {
        XYLog(@"responseBody=%@",responseBody);
        @strongify(self);
        NSInteger state=[responseBody[SuccessKey] integerValue];
        NSString *msgStr=responseBody[MsgKey];
        [FNTipsView showTips:msgStr];
        if(state==1){
            [self requestZhaoPianBendi];
        }
    } failureBlock:^(NSString *error) {
    }];
}
#pragma mark -  商家相册排序
-(void)requestSortImgWithIds:(NSString*)ids{
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    params[@"ids"]=ids;
    @weakify(self);
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_album&ctrl=sort" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary*dictry=respondsObject;
        NSString *mesString=dictry[@"msg"];
        NSInteger state=[respondsObject[SuccessKey] integerValue];
        //[FNTipsView showTips:mesString];
        XYLog(@"mesString==%@",mesString);
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
