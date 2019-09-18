//
//  FNNewStoreImagesController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/7.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStoreImagesController.h"
#import "FNmerPhotoHomeItemCell.h"
#import "FNmerPhotoHomeSkyCell.h"
#import "FNmerSetPhotoItemModel.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "FNNewStoreImagesBrowseController.h"

@interface FNNewStoreImagesController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray<FNmerSetPhotoItemModel*> *images;
@property (nonatomic, assign) NSInteger currentAlbumIndex;
@property (nonatomic, assign) NSInteger currentImageIndex;
@property (nonatomic, strong) MJPhotoBrowser *browser;

@property (nonatomic, strong) NSMutableArray *photos;

@end

@implementation FNNewStoreImagesController

- (void)viewDidLoad {
    [super viewDidLoad];
    _images = [[NSArray alloc] init];
    _photos = [NSMutableArray array];
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
    
    [self.jm_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    self.title=@"店铺相册";
    _browser = [[MJPhotoBrowser alloc]init];
    
    self.view.backgroundColor=RGB(250, 250, 250);
    //self.jm_collectionview.hidden=YES;
    [self requestAlbum];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _images.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    if(self.dataArr.count>0){
        FNmerPhotoHomeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerPhotoHomeItemCellID" forIndexPath:indexPath];
        cell.index=indexPath;
//        cell.delegate=self;
        cell.backgroundColor=RGB(250, 250, 250);
        cell.model=_images[indexPath.row];
        return cell;
//    }else{
//        FNmerPhotoHomeSkyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerPhotoHomeSkyCellID" forIndexPath:indexPath];
//        [cell.addBtnView addTarget:self action:@selector(addBtnViewAction)];
//        return cell;
//    }
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

    _currentAlbumIndex = indexPath.row;
    _currentImageIndex = 0;
    [_photos removeAllObjects];
//    [_browser show];
    self.jm_page = 1;
//    [self requestImages: _images[indexPath.row].id];
    FNNewStoreImagesBrowseController *vc = [[FNNewStoreImagesBrowseController alloc] init];
    
    vc.album_id = _images[indexPath.row].id;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=20;
    CGFloat leftGap=20;
    CGFloat bottomGap=10;
    CGFloat rightGap=20;
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}

#pragma mark -  本地数据 商家相册列表
- (void)requestAlbum{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{@"id":_store_id}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_album&ctrl=album_list" respondType:(ResponseTypeArray) modelType:@"FNmerSetPhotoItemModel" success:^(id respondsObject) {
        @strongify(self)
        
        self.images = respondsObject;
        [self.jm_collectionview reloadData];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO];
    
}

//- (void)requestImages: (NSString*)album_id {
//    @weakify(self);
//    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{@"id":album_id, @"p": @(self.jm_page)}];
//
//    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_album&ctrl=album_img" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
//        @strongify(self)
//        self.jm_page ++;
//        NSArray *list = respondsObject[@"list"];
//        for (NSDictionary *dict in list) {
//            MJPhoto *mjPhoto = [[MJPhoto alloc] init];
//
//            mjPhoto.url = [NSURL URLWithString:dict[@"img"]];
//
////            mjPhoto.srcImageView = imgview;
//
//            [self.photos addObject:mjPhoto];
//        }
//
//        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
//        browser.delegate = self;
//        browser.currentPhotoIndex = _currentImageIndex;
//        browser.photos = self.photos;
//        [browser show];
//    } failure:^(NSString *error) {
//
//
//    } isHideTips:NO];
//}

#pragma mark - MJPhotoBrowserDelegate
- (void)photoBrowser:(MJPhotoBrowser *)photoBrowser didChangedToPageAtIndex:(NSUInteger)index {
//    _currentImageIndex = index;
//    if (index == self.photos.count - 1) {
//        [self requestImages: self.images[_currentAlbumIndex].id];
//    }
}

@end
