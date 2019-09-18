//
//  FNmerPhotoSceneController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/1.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerPhotoSceneController.h"
#import "FNmerEditTallyController.h"
#import "FNmerAddTallyPhotoController.h"
#import "FNCustomeNavigationBar.h"
#import "FNmerPhotoHomeItemCell.h"
#import "FNmerPhotoHomeSkyCell.h"
#import "FNmerPhotoSceneheadView.h"
#import "FNmerPhotoDeletePuView.h"
#import "DSHPopupContainer.h"
#import "FNmerSetPhotoItemModel.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "HXPhotoView.h"
#import "HXAlbumListViewController.h"
#import "HXCustomNavigationController.h"
@interface FNmerPhotoSceneController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNmerPhotoHomeItemCellDelegate,HXAlbumListViewControllerDelegate,FNmerEditTallyControllerDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar *navigationView;
@property (nonatomic, strong)DSHPopupContainer      *container;
@property (nonatomic, strong)UIButton     *leftBtn;
@property (nonatomic, strong)UIButton     *rightBtn;
@property (nonatomic, strong)UIButton     *rightDeleteBtn;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)HXPhotoManager *manager;
@property (nonatomic,strong)NSString *lableWordID;
@property (nonatomic,strong)NSString *photoCounts;
@property (nonatomic,strong)NSString *photoItemID;
@property (nonatomic,strong)NSArray *imgsArr;
@end

@implementation FNmerPhotoSceneController

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
    [self.jm_collectionview registerClass:[FNmerPhotoSceneheadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNmerPhotoSceneheadViewID"];
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 10).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.navigationView.leftButton = self.leftBtn;
    
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightBtn.size = CGSizeMake(30, 30);
    self.rightBtn.imageView.sd_layout
    .rightSpaceToView(self.rightBtn, 5).centerYEqualToView(self.rightBtn).widthIs(15).heightIs(15);
    [self.rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.rightBtn setImage:IMAGE(@"FN_YJAddicon") forState:UIControlStateNormal];
    self.navigationView.rightButton = self.rightBtn; 
    [self.view addSubview:self.navigationView];
    
    self.rightDeleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.rightDeleteBtn addTarget:self action:@selector(rightDeleteBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.rightDeleteBtn setImage:IMAGE(@"FN_merLJXicon") forState:UIControlStateNormal];
    self.rightDeleteBtn.selected=NO;
    [self.navigationView addSubview:self.rightDeleteBtn];
    
    
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.textAlignment=NSTextAlignmentLeft;
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.navigationView.titleLabel.text=@"店铺相册";
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).leftSpaceToView(self.navigationView.leftButton, 2).heightIs(20).widthIs(150);
    
    self.rightDeleteBtn.sd_layout
    .centerYEqualToView(self.navigationView.rightButton).widthIs(30).heightIs(30).rightSpaceToView(self.navigationView.rightButton, 5);
    self.rightDeleteBtn.imageView.sd_layout
    .centerXEqualToView(self.rightDeleteBtn).centerYEqualToView(self.rightDeleteBtn).widthIs(15).heightIs(15);
    
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor]; 
    
    self.view.backgroundColor=RGB(250, 250, 250);
    //self.jm_collectionview.hidden=YES;
    [self requestZhaoPianBendi];
    
    
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNmerPhotoHomeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerPhotoHomeItemCellID" forIndexPath:indexPath];
    cell.backgroundColor=RGB(250, 250, 250);
    cell.index=indexPath;
    cell.delegate=self;
    cell.model=self.dataArr[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemWith=(FNDeviceWidth-52)/2;
    CGFloat itemHeight=itemWith*(169/161)+14;//itemWith+8;
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
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
    // 弹出相册时显示的第一张图片是点击的图片
    browser.currentPhotoIndex = indexPath.row;
    NSMutableArray *photos = [NSMutableArray array];
    NSArray *imgs = self.dataArr;
    [imgs enumerateObjectsUsingBlock:^(id  _Nonnull sobj, NSUInteger idx, BOOL * _Nonnull stop) {
        FNmerSetPhotoItemModel *model=sobj;
        MJPhoto *mjPhoto = [[MJPhoto alloc] init];
        mjPhoto.url = [NSURL URLWithString:model.img];
        //mjPhoto.srcImageView = imageview;
        [photos addObject:mjPhoto];
    }];
    // 设置所有的图片。photos是一个包含所有图片的数组。
    browser.photos = photos;
    [browser show];
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=20;
    CGFloat leftGap=20;
    CGFloat bottomGap=10;
    CGFloat rightGap=20;
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FNmerPhotoSceneheadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNmerPhotoSceneheadViewID" forIndexPath:indexPath];
    headerView.backgroundColor=[UIColor whiteColor];
    [headerView.editBtnView addTarget:self action:@selector(editBtnViewAction) forControlEvents:(UIControlEventTouchUpInside)];
    headerView.titleLB.text=[NSString stringWithFormat:@"%@ (%@)",self.keyWord,self.photoCounts];;
    return headerView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=50;
    return CGSizeMake(with,hight);
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightBtnAction{
    HXAlbumListViewController *vc = [[HXAlbumListViewController alloc] init];
    vc.delegate =self;
    vc.manager = self.manager;
    HXCustomNavigationController *nav = [[HXCustomNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    
//    FNmerAddTallyPhotoController *vc=[[FNmerAddTallyPhotoController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
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
//编辑标签
-(void)editBtnViewAction{
    FNmerEditTallyController *vc=[[FNmerEditTallyController alloc]init];
    vc.lableWord=self.keyWord;
    vc.lableWordID= self.lableWordID;
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - FNmerEditTallyControllerDelegate
// 编辑标签成功刷新
- (void)inDidMerEditTallyRefreshAction{
    XYLog(@"刷新标签");
    [self requestZhaoPianBendi];
}
#pragma mark - FNmerPhotoHomeItemCellDelegate
// 点击删除
- (void)didMerdeletePhotoAlbumIndex:(NSIndexPath*)index{
    FNmerSetPhotoItemModel *model=self.dataArr[index.row];
    self.photoItemID=model.id;
    FNmerPhotoDeletePuView *puView = [[FNmerPhotoDeletePuView alloc] init];
    puView.titleLB.text=@"删除  门店照片 ";
    puView.hintLB.text=@"确定要删除  门店照片 吗？";
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
#pragma mark -  本地数据 商家相册内照片
-(void)requestZhaoPianBendi{
    [SVProgressHUD show];
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
    if([self.photoID kr_isNotEmpty]){
        params[@"id"]=self.photoID;
    }
    @weakify(self);
    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:@"mod=appapi&act=rebate_album&ctrl=album_img_admin" successBlock:^(id responseBody) {
        XYLog(@"responseBody=%@",responseBody);
        @strongify(self);
        [SVProgressHUD dismiss];
        NSDictionary *enArr=responseBody[DataKey];
        self.keyWord=enArr[@"album"];
        self.photoCounts=enArr[@"counts"];
        self.lableWordID=enArr[@"album_id"];
        NSArray *listArr=enArr[@"list"];
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        if(enArr.count>0){
            [listArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNmerSetPhotoItemModel *model=[FNmerSetPhotoItemModel mj_objectWithKeyValues:obj];
                model.state=0;
                model.type=1;
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
        [self.jm_collectionview reloadData];
    } failureBlock:^(NSString *error) {
    }];
}
#pragma mark -  本地数据 删除图片
-(void)requestDeleteImgBendi{
    [SVProgressHUD show];
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    params[@"id"]=self.photoItemID;
    @weakify(self);
    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:@"mod=appapi&act=rebate_album&ctrl=del" successBlock:^(id responseBody) {
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

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
//选择图片
- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.openCamera = NO;
        _manager.cacheAlbum = YES;
        _manager.lookLivePhoto = YES;
        _manager.outerCamera = NO;
        _manager.cameraType = HXPhotoManagerCameraTypeFullScreen;
        _manager.videoMaxNum = 0;
        _manager.maxNum = 3;
        _manager.videoMaxDuration = 30.f;
        _manager.saveSystemAblum = NO;
        _manager.style = HXPhotoAlbumStylesSystem;
        _manager.showDateHeaderSection = NO;
        _manager.selectTogether = NO;
        _manager.rowCount = 4;
        _manager.photoMaxNum=9;
    }
    return _manager;
}
#pragma mark - HXAlbumListViewControllerDelegate 选择的照片
- (void)albumListViewController:(HXAlbumListViewController *)albumListViewController didDoneAllList:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photoList videos:(NSArray<HXPhotoModel *> *)videoList original:(BOOL)original{
    @weakify(self);
    [HXPhotoTools getImageForSelectedPhoto:photoList type:HXPhotoToolsFetchOriginalImageTpe completion:^(NSArray<UIImage *> *images) {
        XYLog(@"images:%@",images);
        @strongify(self);
        self.imgsArr=images;
        [self requestRebateAlbum];
    }];
    
}

//上传图片
-(void)requestRebateAlbum{
    [SVProgressHUD show];
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.keyWord kr_isNotEmpty]){
        params[@"label_name"]=self.keyWord;
    }
    @weakify(self);
        [[XYNetworkAPI sharedManager] upImageWithParameter:params imageArray:self.imgsArr imageSize:0.3 url:@"mod=appapi&act=rebate_album&ctrl=add" successBlock:^(id responseBody) {
            @strongify(self);
            NSInteger state=[responseBody[SuccessKey] integerValue];
            NSString *msgStr=responseBody[MsgKey];
            [UIView animateWithDuration:0.2 animations:^{
                [SVProgressHUD dismiss];
            }];
            [FNTipsView showTips:msgStr];
            if(state==1){
               [self.navigationController popViewControllerAnimated:YES];
            }
        } failureBlock:^(NSString *error) {
            [SVProgressHUD dismiss];
        }];
    
    
//    [self diduUpImageWithParameter:params imageArray:self.imgsArr imageSize:0.3 url:@"mod=appapi&act=rebate_album&ctrl=add" successBlock:^(id responseBody) {
//        @strongify(self);
//        NSInteger state=[responseBody[SuccessKey] integerValue];
//        NSString *msgStr=responseBody[MsgKey];
//        [FNTipsView showTips:msgStr];
//        if(state==1){
//            [self requestZhaoPianBendi];
//        }
//    } failureBlock:^(NSString *error) {
//
//    }];
}

-(void)diduUpImageWithParameter:(NSDictionary *)parameter imageArray:(NSArray *)images imageSize:(CGFloat)size url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    
    AFHTTPRequestOperationManager *manger=[AFHTTPRequestOperationManager manager];
    
    [manger.requestSerializer setTimeoutInterval:20];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html",@"application/javascript",@"application/json", nil];
    NSString *urlStr=[[NSMutableString stringWithString:@"http://192.168.0.254/fnuoos_dgapp/?"] stringByAppendingFormat:@"%@",[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ];
    [manger POST:urlStr parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i=1; i<=images.count; i++) {
            UIImage *image=[UIImage scaleImage:images[i-1] toKb:800];
            NSData *imageData=UIImageJPEGRepresentation(image, size);
            // 上传的参数名
            NSString * Name =[NSString stringWithFormat:@"img%d",i];
            // 上传filename
            NSString * fileName = [NSString stringWithFormat:@"%@_image%d.png",[NSString GetNowTimes],i];
            [formData appendPartWithFileData:imageData name:Name fileName:fileName mimeType:@"image/jpg/png/jpeg"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        if ([errorStr kr_isNotEmpty]) {
            failureBlock(errorStr);
        }
    }];
}
@end
