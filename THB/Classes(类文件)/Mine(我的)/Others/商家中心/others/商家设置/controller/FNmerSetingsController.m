//
//  FNmerSetingsController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerSetingsController.h"
#import "FNmerDeliverySetController.h"
#import "FNmerElseSetingsController.h"
#import "FNmerSiteMapController.h"
#import "FNmerSetPhotoHomeController.h"
#import "FNCustomeNavigationBar.h"
#import "FNmerSetingsModel.h"
#import "FNmerSetingsItemCell.h"
#import "FNmerSetingStyletCell.h"
#import "JMAlertView.h"
#import "FNHContactModel.h"
#import "HXPhotoView.h"
#import "HXAlbumListViewController.h"
#import "HXCustomNavigationController.h"
#import "FNmerSetingSternView.h"
@interface FNmerSetingsController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNmerSiteMapControllerDelegate,FNmerElseSetingsControllerDelegate,FNmerDeliverySetControllerDelegate,HXAlbumListViewControllerDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)FNmerSetingsModel *dataModel;
@property (nonatomic, strong)NSMutableArray *dataOneArr;
@property (nonatomic, strong)NSMutableArray *dataTwoArr;
@property (nonatomic, strong)NSMutableArray *dataThreeArr;
@property (nonatomic, strong)FNHsearchModel *siteModel;
@property (nonatomic, strong)HXPhotoManager *manager;
@property (nonatomic, strong)NSArray *imgsArr;
@property (nonatomic, strong)NSString *merName;
@property (nonatomic, strong)NSString *merPhone;
@property (nonatomic, strong)NSString *address;
@end

@implementation FNmerSetingsController

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
    [self isAddDataModel];
    CGFloat baseGap=SafeAreaTopHeight;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
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
    [self.jm_collectionview registerClass:[FNmerSetingStyletCell class] forCellWithReuseIdentifier:@"FNmerSetingStyletCellID"];
    [self.jm_collectionview registerClass:[FNmerSetingsItemCell class] forCellWithReuseIdentifier:@"FNmerSetingsItemCellID"];
    
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableViewFootID"];
    [self.jm_collectionview registerClass:[FNmerSetingSternView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FNmerSetingSternViewID"];
    
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
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.navigationView.titleLabel.text=@"设置";
    self.view.backgroundColor=RGB(250, 250, 250);
    [self requestMerSetingMsg];
    
    
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){
        return self.dataOneArr.count;
    }
    else if(section==1){
        return self.dataTwoArr.count;
    }
    else {
        return self.dataThreeArr.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        FNmerSetingsItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerSetingsItemCellID" forIndexPath:indexPath];
        cell.model=self.dataOneArr[indexPath.row];
        cell.backgroundColor=[UIColor whiteColor];
        return cell;
    }
    else if(indexPath.section==1){
        FNmerSetingStyletCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerSetingStyletCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=self.dataTwoArr[indexPath.row];
        [cell.rightBtn addTarget:self action:@selector(businessClick)];
        return cell;
    }
    else{
        FNmerSetingsItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerSetingsItemCellID" forIndexPath:indexPath];
        cell.model=self.dataThreeArr[indexPath.row];
        cell.backgroundColor=[UIColor whiteColor];
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=70;
    CGFloat itemWith=FNDeviceWidth;
    if(indexPath.section==0){
        itemHeight=53;
    }
    else if(indexPath.section==1){
        itemHeight=92;
    }
    else{
        itemHeight=53;
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
    return 1;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if(indexPath.row==0){
            HXAlbumListViewController *vc = [[HXAlbumListViewController alloc] init];
            vc.delegate = (id)self;
            vc.manager = self.manager;
            HXCustomNavigationController *nav = [[HXCustomNavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
        }
        if(indexPath.row==1||indexPath.row==2||indexPath.row==3){
            FNmerElseSetingsController *vc=[[FNmerElseSetingsController alloc]init];
            if(indexPath.row==1){
                vc.keyWord=@"name";
                vc.content=self.dataModel.name;
                vc.dataModel=self.dataModel;
            }
            if(indexPath.row==2){
                vc.keyWord=@"date";
                NSDictionary *bussiness_hours=self.dataModel.bussiness_hours;
                vc.contentDic=bussiness_hours;
            }
            if(indexPath.row==3){
                vc.keyWord=@"phone";
                vc.dataModel=self.dataModel;
                vc.content=self.dataModel.phone;
            }
            vc.delegate=self;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if(indexPath.row==4){
           FNmerSiteMapController *vc=[[FNmerSiteMapController alloc]init];
            vc.delegate=self;
           [self.navigationController pushViewController:vc animated:YES];
        }
        if(indexPath.row==5){
            FNmerSetPhotoHomeController *vc=[[FNmerSetPhotoHomeController alloc]init]; 
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if(indexPath.section==2){
        if(indexPath.row==0){
            FNmerElseSetingsController *vc=[[FNmerElseSetingsController alloc]init];
            vc.keyWord=@"money";
            vc.content=self.dataModel.commission;
            vc.delegate=self;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if(indexPath.row==1){
           FNmerDeliverySetController *vc=[[FNmerDeliverySetController alloc]init];
           vc.dataModel=self.dataModel;
           vc.delegate=self;
           [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=0;
    CGFloat bottomGap=10;
    CGFloat rightGap=0;
    if(section==0){
       topGap=2;
    }
    if(section==2){
       bottomGap=44;
    }
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==2){
        FNmerSetingSternView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FNmerSetingSternViewID" forIndexPath:indexPath];
            [footview.alterbtn addTarget:self action:@selector(alterbtnClick) forControlEvents:UIControlEventTouchUpInside];
        return footview;
    }else{
        UICollectionReusableView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableViewFootID" forIndexPath:indexPath];
        return footview;
    }  
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if(section==2){
       return CGSizeMake(FNDeviceWidth, 90);
    }else{
       return CGSizeMake(FNDeviceWidth, 0);
    }
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
   
}
//营业
-(void)businessClick{
    //NSInteger businessInt=[self.dataModel.is_open integerValue];
    
    FNmerSetingsItemModel *twoModel=self.dataTwoArr[0];
    if(twoModel.rightState==0){
        
    }
    //[SVProgressHUD setImageViewSize:CGSizeMake(120, 120)];
    //[SVProgressHUD dismissWithDelay:1.5];
    
    NSString *titleStr=@"";
    NSString *hintStr=@"";
    if([self.dataModel.is_open integerValue]==0){
        titleStr=@"店铺暂停营业中";
        hintStr=@"去开启营业";
    }
    if([self.dataModel.is_open integerValue]==1){
        titleStr=@"店铺营业中";
        hintStr=@"去暂停营业";
    }
    JMAlertView* alert = [JMAlertView alertWithTitle:@"" content:titleStr firstTitle:@"取消" andSecondTitle:hintStr alertType:(AlertTypeAlert) clickBlock:^(NSInteger index) {
        if (index == 1) {
            [self requestMerRevise];
            //[self requestYingYeBendi];
        }
    }];
    [alert.secondButton setTitleColor:RGB(255, 120, 37) forState:UIControlStateNormal]; 
    [alert showAlert];
    
}
//修改
-(void)alterbtnClick{ 
    if(![self.merName kr_isNotEmpty]){
       [FNTipsView showTips:@"请输入名字"];
        return;
    }
    else if(![self.merPhone kr_isNotEmpty]){
       [FNTipsView showTips:@"请输入电话"];
        return;
    }
    else if(![self.address kr_isNotEmpty]){
       [FNTipsView showTips:@"请选择地址"];
        return;
    }
    [self requestMerStoreMessage];
}
#pragma mark - FNmerElseSetingsControllerDelegate  //商家中心修改  赏金比例 电话  名字 营业时间 刷新数据
// 修改完成
- (void)inDidMerElseSetingsAction{
    [self requestMerSetingMsg];
    XYLog(@"刷新一下--");
    
}
- (void)inDidMerElseSetingsBackWithcontent:(NSString*)content withType:(NSString *)keyType{
    if([keyType isEqualToString:@"name"]){
        self.merName=content;
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1  inSection:0];
        FNmerSetingsItemCell* cell = (FNmerSetingsItemCell *)[self.jm_collectionview cellForItemAtIndexPath:indexPath];
        cell.rightLB.text=content;
    }
    if([keyType isEqualToString:@"phone"]){
        self.merPhone=content;
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3  inSection:0];
        FNmerSetingsItemCell* cell = (FNmerSetingsItemCell *)[self.jm_collectionview cellForItemAtIndexPath:indexPath];
        cell.rightLB.text=content;
    }
    XYLog(@"修改文本%@",content);
}
#pragma mark - FNmerDeliverySetControllerDelegate  // 修改配送费完成刷新
- (void)inDidMerDeliverySetRefreshAction{
    [self requestMerSetingMsg];
    
}
#pragma mark - FNmerSiteMapControllerDelegate
// 返回地址
- (void)didMerSiteMapBackAction:(id)addressModel{
    self.siteModel=addressModel;
    self.address=self.siteModel.address;
    XYLog(@"地址=:%@",self.siteModel.address);
    XYLog(@"经纬度:%f  度=%f",self.siteModel.latitude,self.siteModel.longitude);
    if(![self.siteModel.province kr_isNotEmpty]&&![self.siteModel.district kr_isNotEmpty]&&[self.siteModel.city kr_isNotEmpty]){
        [FNTipsView showTips:@"地址有误,请修改"];
        return;
       }
    else if([self.siteModel.province kr_isNotEmpty]&&[self.siteModel.city kr_isNotEmpty]&&[self.siteModel.district kr_isNotEmpty]){
        //[self requestMerStoreMessage];
    }
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:4  inSection:0];
    FNmerSetingsItemCell* cell = (FNmerSetingsItemCell *)[self.jm_collectionview cellForItemAtIndexPath:indexPath];
    cell.rightLB.text=self.siteModel.address;
}
#pragma mark - request
//商家中心设置页面
-(FNRequestTool*)requestMerSetingMsg{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if (_isConfirm) {
        params[@"confirm"] = @"1";
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=info" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary *dictry = respondsObject[DataKey];
        self.dataModel=[FNmerSetingsModel mj_objectWithKeyValues:dictry];
        self.merName=self.dataModel.name;
        self.address=self.dataModel.address;
        self.merPhone=self.dataModel.phone;
        [self isRefreshDataModel];
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}
//商家中心-开启|关闭营业
-(FNRequestTool*)requestMerRevise{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=revise_status" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSInteger state=[respondsObject[SuccessKey] integerValue];
        //NSString *msgStr=respondsObject[MsgKey];
        //[FNTipsView showTips:msgStr];
        if(state==1){
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
            [SVProgressHUD showImage:IMAGE(@"FN_sj_SetgouImg") status:@"暂停业务成功"];
            [SVProgressHUD dismissWithDelay:1.5];
            [self requestMerSetingMsg];
        }
    } failure:^(NSString *error) {
    } isHideTips:YES isCache:NO];
}
-(void)isAddDataModel{
    NSArray *titleArr=@[@"店铺头像",@"店铺名称",@"营业时间",@"店铺电话",@"店铺地址",@"店铺相册"];
    NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
    NSMutableArray *arr2M=[NSMutableArray arrayWithCapacity:0];
    NSMutableArray *arr3M=[NSMutableArray arrayWithCapacity:0];
    for (NSString *str in titleArr) {
        FNmerSetingsItemModel *itemModel=[[FNmerSetingsItemModel alloc]init];
        itemModel.rightState=0;
        itemModel.leftStr=str;
        [arrM addObject:itemModel];
    }
    FNmerSetingsItemModel *oModel=arrM[0];
    oModel.rightState=1;
    
    FNmerSetingsItemModel *oneModel=[[FNmerSetingsItemModel alloc]init];
    oneModel.leftStr=@"开启营业";
    oneModel.bottomhint=@"关闭开关后，店铺显示暂停营业，顾客无法下单";
    oneModel.rightState=0;
    [arr2M addObject:oneModel];
    
    FNmerSetingsItemModel *lats1Model=[[FNmerSetingsItemModel alloc]init];
    lats1Model.leftStr=@"赏金比例";
    [arr3M addObject:lats1Model];
    FNmerSetingsItemModel *lats2Model=[[FNmerSetingsItemModel alloc]init];
    lats2Model.leftStr=@"配送设置";
    [arr3M addObject:lats2Model];
    
    self.dataOneArr=arrM;
    self.dataTwoArr=arr2M;
    self.dataThreeArr=arr3M;
}
//刷新数据
-(void)isRefreshDataModel{
    [self.dataOneArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FNmerSetingsItemModel *model=obj;
        if(idx==0){
            model.imageUrl=self.dataModel.img;
            model.rightState=1;
        }
        else if(idx==1){
            model.rightStr=self.dataModel.name;
        }
        else if(idx==2){
            NSDictionary *bussiness_hours=self.dataModel.bussiness_hours;
            //【bussiness_day 日期，start_time开始时间，end_time 结束时间】
            NSString *day=bussiness_hours[@"bussiness_day"];
            NSString *start=bussiness_hours[@"start_time"];
            NSString *end=bussiness_hours[@"end_time"];
            NSString *jointStr=[NSString stringWithFormat:@"%@ %@-%@",day,start,end];
            if([start kr_isNotEmpty]&&[end kr_isNotEmpty]){
               model.rightStr=jointStr;
            }else{
                model.rightStr=@"设置";
            }
            if([self.dataModel.bussiness_hours_str kr_isNotEmpty]){
                model.rightStr=self.dataModel.bussiness_hours_str;
            }else{
               model.rightStr=@"设置";
            }
        }
        else if(idx==3){
            model.rightStr=self.dataModel.phone;
        }
        else if(idx==4){
            model.rightStr=self.dataModel.address;
        }
        else if(idx==5){
            model.rightStr=@"上传";
        }
    }];
    NSInteger is_open=[self.dataModel.is_open integerValue];
    FNmerSetingsItemModel *twoModel=self.dataTwoArr[0];
    twoModel.rightState=is_open;
    
    [self.dataThreeArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FNmerSetingsItemModel *model=obj;
        if(idx==0){
            model.rightStr=self.dataModel.commission_str;
        }
        else if(idx==1){
            model.rightStr=@"修改";
        }
    }];
    [UIView performWithoutAnimation:^{
        [self.jm_collectionview reloadData];
    }];
}

//商家中心-小店信息修改申请  修改店铺地址位置
-(void)requestMerStoreMessage{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    params[@"lat"]=[NSString stringWithFormat:@"%f",self.siteModel.latitude];
    params[@"lng"]=[NSString stringWithFormat:@"%f",self.siteModel.longitude];
    params[@"province"]=self.siteModel.province;
    params[@"city"]=self.siteModel.city;
    params[@"district"]=self.siteModel.district;
    params[@"address"]=self.siteModel.address;
    params[@"name"]=self.merName;
    params[@"phone"]=self.merPhone;
    params[@"id"]=self.dataModel.id;
    [[XYNetworkAPI sharedManager] upImageWithParameter:params imageArray:self.imgsArr imageSize:0.3 url:@"mod=appapi&act=small_store&ctrl=revise_apply" successBlock:^(id responseBody) {
        @strongify(self);
        NSDictionary*dictry=responseBody;
        NSInteger success=[dictry[@"success"] integerValue];
        NSString *mesString=dictry[@"msg"];
        [UIView animateWithDuration:0.2 animations:^{
            [SVProgressHUD dismiss];
        }];
        [FNTipsView showTips:mesString];
        if(success==1){
            [self requestMerSetingMsg];
        }
    } failureBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
    }];
}
- (NSMutableArray *)dataOneArr{
    if (!_dataOneArr) {
        _dataOneArr = [NSMutableArray array];
    }
    return _dataOneArr;
}
- (NSMutableArray *)dataTwoArr{
    if (!_dataTwoArr) {
        _dataTwoArr = [NSMutableArray array];
    }
    return _dataTwoArr;
}
- (NSMutableArray *)dataThreeArr{
    if (!_dataThreeArr) {
        _dataThreeArr = [NSMutableArray array];
    }
    return _dataThreeArr;
}

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.openCamera = NO;
        _manager.saveSystemAblum = NO;
 
//        _manager.openCamera = NO;
//        _manager.cacheAlbum = YES;
//        _manager.lookLivePhoto = YES;
//        _manager.outerCamera = NO;
//        _manager.cameraType = HXPhotoManagerCameraTypeFullScreen;
//        _manager.videoMaxNum = 0;
        _manager.maxNum = 1;
//        _manager.videoMaxDuration = 0.f;
//
//        _manager.style = HXPhotoAlbumStylesSystem;
//        _manager.showDateHeaderSection = NO;
//        _manager.selectTogether = NO;
//        _manager.rowCount = 4;
        _manager.photoMaxNum=1;
    }
    return _manager;
}
#pragma mark - HXAlbumListViewControllerDelegate 选择的照片
- (void)albumListViewController:(HXAlbumListViewController *)albumListViewController didDoneAllList:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photoList videos:(NSArray<HXPhotoModel *> *)videoList original:(BOOL)original{
    @weakify(self);
    [HXPhotoTools getImageForSelectedPhoto:photoList type:HXPhotoToolsFetchOriginalImageTpe completion:^(NSArray<UIImage *> *images) {
        XYLog(@"images:%@",images);
        @strongify(self);
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0  inSection:0];
        FNmerSetingsItemCell* cell = (FNmerSetingsItemCell *)[self.jm_collectionview cellForItemAtIndexPath:indexPath];
        
        self.imgsArr=images;
        if(self.imgsArr.count>0){
           
            cell.headView.image=self.imgsArr[0];
        }
    }];
    
}

@end
