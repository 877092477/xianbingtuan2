//
//  FNmerAddTallyPhotoController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerAddTallyPhotoController.h"
#import "FNCustomeNavigationBar.h"
#import "FNaddTallyPhotoHeadView.h"
#import "FNTallyPhotoTailView.h"
#import "FNtallyPhotoTextItemCell.h"
#import "FNmerSetPhotoItemModel.h"
@interface FNmerAddTallyPhotoController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNTallyPhotoTailViewDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar *navigationView;
@property (nonatomic, strong)UIButton     *leftBtn;
@property (nonatomic, strong)UIButton     *rightBtn;
@property (nonatomic, strong)NSArray *arrM;
@property (nonatomic, strong)NSMutableArray *dataLbArr;
@property (nonatomic, strong)NSString *labelWord;
@property (nonatomic, strong)NSArray *imgsArr;
@end

@implementation FNmerAddTallyPhotoController

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
    self.arrM=@[@"门店内景",@"门店内堂",@"门店特色风格",@"门店内景",@"门店介绍内景",@"门店内景",@"门店内景"];
    CGFloat baseGap=SafeAreaTopHeight+12;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(12, baseGap, FNDeviceWidth-24, FNDeviceHeight-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.jm_collectionview];
    //[self.jm_collectionview registerClass:[FNmerPhotoHomeSkyCell class] forCellWithReuseIdentifier:@"FNmerPhotoHomeSkyCellID"];
    [self.jm_collectionview registerClass:[FNtallyPhotoTextItemCell class] forCellWithReuseIdentifier:@"FNtallyPhotoTextItemCellID"];
    [self.jm_collectionview registerClass:[FNaddTallyPhotoHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNaddTallyPhotoHeadViewID"];
    [self.jm_collectionview registerClass:[FNTallyPhotoTailView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FNTallyPhotoTailViewID"];
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.navigationView.leftButton = self.leftBtn;
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightBtn.cornerRadius=5;
    self.rightBtn.size = CGSizeMake(54, 27);
    self.navigationView.rightButton = self.rightBtn;
    self.rightBtn.backgroundColor=RGB(255, 223, 197);
    self.rightBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:self.navigationView];
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.textAlignment=NSTextAlignmentLeft;
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.navigationView.titleLabel.text=@"店铺相册";
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).leftSpaceToView(self.navigationView.leftButton, 2).heightIs(20).widthIs(150);
    
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 10).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.navigationView.backgroundColor=[UIColor whiteColor];
    
    self.view.backgroundColor=RGB(250, 250, 250);
    //self.jm_collectionview.hidden=YES;
    self.jm_collectionview.bounces = NO;
    
    [self requestLableListBendi];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataLbArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNmerSetPhotoItemModel *model=self.dataLbArr[indexPath.row];
    FNtallyPhotoTextItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNtallyPhotoTextItemCellID" forIndexPath:indexPath];
    cell.backgroundColor=RGB(255, 241, 231);
    cell.borderWidth=1;
    cell.borderColor = RGB(255, 120, 0);
    cell.cornerRadius=3;
    cell.clipsToBounds = YES;
    cell.titleLb.text=model.name;//self.arrM[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNmerSetPhotoItemModel *model=self.dataLbArr[indexPath.row];
    CGFloat itemWith=60;
    CGFloat itemHeight=23;
    NSString *textString=model.name;//self.arrM[indexPath.row];
    itemWith=12*textString.length+18;
    CGSize  size = CGSizeMake(itemWith, itemHeight);
    return  size;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNmerSetPhotoItemModel *model=self.dataLbArr[indexPath.row];
    self.labelWord=model.name;
    [UIView performWithoutAnimation:^{
        [self.jm_collectionview reloadData];
    }];
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=18;
    CGFloat leftGap=10;
    CGFloat bottomGap=16;
    CGFloat rightGap=10;
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        FNaddTallyPhotoHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNaddTallyPhotoHeadViewID" forIndexPath:indexPath];
        headerView.backgroundColor=[UIColor whiteColor];
        if([self.labelWord kr_isNotEmpty]){
            headerView.compileField.text=self.labelWord;
        }
        [headerView.compileField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        return headerView;
    }else{
        FNTallyPhotoTailView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FNTallyPhotoTailViewID" forIndexPath:indexPath];
        view.backgroundColor=RGB(250, 250, 250);
        view.delegate=self;
        return view;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth-24;
    CGFloat hight=50;
    return CGSizeMake(with,hight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(FNDeviceWidth-24, 550);
}
#pragma mark - 编辑
- (void)textFieldDidChange:(id)sender{
    UITextField *field = (UITextField *)sender;
    self.labelWord=field.text;
    if([self.labelWord kr_isNotEmpty] && self.imgsArr.count>0){
        self.rightBtn.backgroundColor=RGB(255, 120, 0);
    }else{
        self.rightBtn.backgroundColor=RGB(255, 223, 197);
    }
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//确定
-(void)rightBtnAction{
    if(![self.labelWord kr_isNotEmpty]){
        return;
    }
    else if(self.imgsArr.count==0){
        return;
    }
    [self requestRebateAlbum];
}
#pragma mark - FNTallyPhotoTailViewDelegate
// 添加的图片
- (void)didMerTallyPhotoImages:(NSArray*)imgArr{
    XYLog(@"添加图片=%@",imgArr);
    if([self.labelWord kr_isNotEmpty] &&imgArr.count>0){
        self.rightBtn.backgroundColor=RGB(255, 120, 0);
    }else{
        self.rightBtn.backgroundColor=RGB(255, 223, 197);
    }
    self.imgsArr=imgArr;
}
#pragma mark - request
//商家相册标签
-(FNRequestTool*)requestMerlableList{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_album&ctrl=label_list" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        @strongify(self); 
        NSArray *listArr=respondsObject[DataKey];
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        if(listArr.count>0){
            [listArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNmerSetPhotoItemModel *model=[FNmerSetPhotoItemModel mj_objectWithKeyValues:obj];
                [arrM addObject:model];
            }];
        }
        self.dataLbArr=arrM;
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}
#pragma mark -  本地数据 商家相册标签
-(void)requestLableListBendi{
    [SVProgressHUD show];
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}]; 
    @weakify(self);
    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:@"mod=appapi&act=rebate_album&ctrl=label_list" successBlock:^(id responseBody) {
        XYLog(@"responseBody=%@",responseBody);
        @strongify(self);
        [SVProgressHUD dismiss];
        NSArray *listArr=responseBody[DataKey];
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        if(listArr.count>0){
            [listArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNmerSetPhotoItemModel *model=[FNmerSetPhotoItemModel mj_objectWithKeyValues:obj];
                [arrM addObject:model];
            }];
        }
        self.dataLbArr=arrM;
        [self.jm_collectionview reloadData];
    } failureBlock:^(NSString *error) {
    }];
}

//上传图片
-(void)requestRebateAlbum{
    [SVProgressHUD show];
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.labelWord kr_isNotEmpty]){
        params[@"label_name"]=self.labelWord;
    }
    @weakify(self);
    [[XYNetworkAPI sharedManager] upImageWithParameter:params imageArray:self.imgsArr imageSize:0.3 url:@"mod=appapi&act=rebate_album&ctrl=add" successBlock:^(id responseBody) {
        @strongify(self);
        NSDictionary*dictry=responseBody;
        NSInteger success=[dictry[@"success"] integerValue];
        NSString *mesString=dictry[@"msg"];
        [UIView animateWithDuration:0.2 animations:^{
            [SVProgressHUD dismiss];
        }];
        [FNTipsView showTips:mesString];
        if(success==1){
           if([self.delegate respondsToSelector:@selector(inDidMerAddTallyPhotoRefreshAction)]) {
               [self.delegate inDidMerAddTallyPhotoRefreshAction];
            }
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
//            if ([self.delegate respondsToSelector:@selector(inDidMerAddTallyPhotoRefreshAction)]) {
//                [self.delegate inDidMerAddTallyPhotoRefreshAction];
//            }
//            [self.navigationController popViewControllerAnimated:YES];
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
- (NSMutableArray *)dataLbArr{
    if (!_dataLbArr) {
        _dataLbArr = [NSMutableArray array];
    }
    return _dataLbArr;
}

@end
