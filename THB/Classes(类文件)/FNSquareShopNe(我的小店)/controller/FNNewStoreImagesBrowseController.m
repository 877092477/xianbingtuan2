//
//  FNNewStoreImagesBrowseController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/21.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStoreImagesBrowseController.h"
#import "FNImageCollectionViewCell.h"
#import "FNCustomeNavigationBar.h"

@interface FNNewStoreImagesBrowseController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray<NSString*> *imageUrls;

@property (nonatomic, strong) FNCustomeNavigationBar *navigationView;

@property (nonatomic, strong) UIView *vBottom;
@property (nonatomic, strong) UILabel *lblName;

@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) BOOL isEnd;

@end

@implementation FNNewStoreImagesBrowseController

- (FNCustomeNavigationBar *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
        _navigationView.backgroundColor = UIColor.clearColor;
        
        UIButton* leftView = [UIButton new];
        UIImageView *imgBack = [[UIImageView alloc] init];
        imgBack.size = CGSizeMake(9, 15);
        imgBack.image = IMAGE(@"connection_button_back");
        [leftView addSubview:imgBack];
        leftView.frame = CGRectMake(10, 0, 20, 20);
        [leftView addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        
        _navigationView.leftButton = leftView;
        
        
    }
    return _navigationView;
}

- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:self.isPop.boolValue];
    
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
    
    [self requestImages];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageUrls = [[NSMutableArray alloc] init];
    
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing=0;
    flowlayout.minimumInteritemSpacing=0;
    flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:(CGRectZero) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=UIColor.blackColor;
    self.jm_collectionview.showsHorizontalScrollIndicator = NO;
    self.jm_collectionview.showsVerticalScrollIndicator = NO;
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.pagingEnabled = YES;
    [self.jm_collectionview registerClass:[FNImageCollectionViewCell class] forCellWithReuseIdentifier:@"FNImageCollectionViewCell"];
    
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self.view addSubview:self.navigationView];
    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:self.navigationView.height];
    
    _vBottom = [[UIView alloc] init];
    _lblName = [[UILabel alloc] init];
    
    [self.view addSubview:_vBottom];
    [_vBottom addSubview: _lblName];
    [_vBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.mas_equalTo(124);
    }];
    [_lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@20);
        make.right.lessThanOrEqualTo(@-20);
    }];
    
    _vBottom.backgroundColor = RGBA(0, 0, 0, 0.3);
    _lblName.textColor = UIColor.whiteColor;
    _lblName.font = [UIFont boldSystemFontOfSize:15];
    
    self.jm_page = 1;
    [self requestImages];
    
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageUrls.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    FNImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNImageCollectionViewCell" forIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:URL(self.imageUrls[indexPath.row])];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(FNDeviceWidth,  FNDeviceHeight);

}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - ScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    int page = offsetX / scrollView.bounds.size.width;
    if (page == self.imageUrls.count - 1) {
        [self requestImages];
    }
}

#pragma mark - Networking
- (void)requestImages{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{@"p": @(self.jm_page)}];
    if ([_album_id kr_isNotEmpty]) {
        params[@"id"] = _album_id;
    }
    if (_isLoading || _isEnd) {
        return;
    }
    _isLoading = YES;
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_album&ctrl=album_img" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        
        self.isLoading = NO;
        self.jm_page ++;
        NSArray *list = respondsObject[@"list"];
        if (list.count == 0) {
            self.isEnd = YES;
        }
        for (NSDictionary *dic in list) {
            [self.imageUrls addObject: dic[@"img"]];
        }
        [self.jm_collectionview reloadData];
        self.lblName.text = respondsObject[@"album"];
    } failure:^(NSString *error) {
        self.isLoading = NO;
        
    } isHideTips:NO];
}



@end
