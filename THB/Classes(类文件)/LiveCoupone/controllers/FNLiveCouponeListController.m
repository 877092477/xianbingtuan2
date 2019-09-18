//
//  FNLiveCouponeListController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveCouponeListController.h"
#import "FNLiveCouponeModel.h"
#import "FNLiveCouponeCell.h"

@interface FNLiveCouponeListController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray<FNLiveCouponeModel*> *coupones;
@property (nonatomic, strong) UIImageView *imgEmpty;
@property (nonatomic, strong) UILabel *lblEmpty;

@end

@implementation FNLiveCouponeListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _coupones = [[NSMutableArray alloc] init];
    [self requestCoupones];
    [self configUI];
}

- (void)configUI {
    self.view.backgroundColor = FNWhiteColor;
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init];
    flowayout.minimumLineSpacing=0;
    flowayout.minimumInteritemSpacing=0;
    
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowayout];
    [self.jm_collectionview registerClass:[FNLiveCouponeCell class] forCellWithReuseIdentifier:@"FNLiveCouponeCell"];
    
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.delegate=self;
    self.jm_collectionview.dataSource=self;
    
    self.jm_collectionview.backgroundColor=FNHomeBackgroundColor;
    if([self.jm_collectionview respondsToSelector:@selector(setPrefetchingEnabled:)]){
        self.jm_collectionview.prefetchingEnabled = YES;
    }
    
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, 0, 0, 0))];
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    @weakify(self)
    
    self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        [self requestCoupones];
    }];
    
    _imgEmpty = [[UIImageView alloc] init];
    _lblEmpty = [[UILabel alloc] init];
    [self.view addSubview:_imgEmpty];
    [self.view addSubview:_lblEmpty];
    [_imgEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@-40);
    }];
    [_lblEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.imgEmpty.mas_bottom).offset(20);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
    }];
    
    _imgEmpty.image = IMAGE(@"live_coupone_image_empty");
    _lblEmpty.textColor = RGB(102, 102, 102);
    _lblEmpty.text = @"抱歉，暂时还没有找到券\n正在努力寻找中..";
    _lblEmpty.numberOfLines = 0;
    _lblEmpty.font = kFONT15;
    
    _lblEmpty.hidden = YES;
    _imgEmpty.hidden = YES;
}

#pragma mark UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    _lblEmpty.hidden = self.coupones.count > 0;
    _imgEmpty.hidden = self.coupones.count > 0;
    
    return self.coupones.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FNLiveCouponeCell *cell = [self.jm_collectionview dequeueReusableCellWithReuseIdentifier:@"FNLiveCouponeCell" forIndexPath:indexPath];
    
    FNLiveCouponeModel *model = self.coupones[indexPath.row];
    [cell.imgHeader sd_setImageWithURL:URL(model.img)];
    cell.lblTitle.text = model.name;
    cell.lblDesc.text = model.str;
    cell.lblCount.text = model.count_str;
    //        [cell.btnAccept sd_setBackgroundImageWithURL:URL(model.btn_img) forState:(UIControlStateNormal)];
    [cell.btnAccept sd_setImageWithURL:URL(model.btn_img)];
    
    return cell;
}

#pragma mark - collectionView delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(FNDeviceWidth,  86);
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (self.coupones.count>0) {
        FNLiveCouponeModel *model = self.coupones[indexPath.row];
        [self goWebWithUrl:model.url];
    }
}

#pragma mark - Networking

- (void)requestCoupones{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"p": @(self.jm_page)}];
    if ([self.cid kr_isNotEmpty]) {
        params[@"cid"] = self.cid;
    }
    if ([self.keyword kr_isNotEmpty]) {
        params[@"keyword"] = self.keyword;
    }
    if ([self.type kr_isNotEmpty]) {
        params[@"type"] = self.type;
    }
    if ([self.show_type_str kr_isNotEmpty]) {
        params[@"show_type_str"] = self.show_type_str;
    }
    [SVProgressHUD show];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=life_coupon&ctrl=coupon_list" respondType:(ResponseTypeArray) modelType:@"FNLiveCouponeModel" success:^(NSArray* respondsObject) {
        
        [SVProgressHUD dismiss];
        @strongify(self)
        
        if (self.jm_page == 1) {
            [self.coupones removeAllObjects];
        }
        
        self.jm_page ++;
        
        if (respondsObject.count <= 0) {
            self.jm_collectionview.mj_footer = nil;
        } else {
            @weakify(self)
            self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                @strongify(self)
                [self requestCoupones];
            }];
        }
        
        [self.coupones addObjectsFromArray:respondsObject];
        [self.jm_collectionview reloadData];
        [self.jm_collectionview.mj_footer endRefreshing];
        
        
    } failure:^(NSString *error) {
            [XYNetworkAPI cancelAllRequest];
            [SVProgressHUD dismiss];
            [self.jm_collectionview.mj_footer endRefreshing];
    } isHideTips:YES];
    
}


@end
