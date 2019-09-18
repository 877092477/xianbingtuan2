//
//  FNStoreLocationRedpackDetailController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/24.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreLocationRedpackDetailController.h"
#import "FNCustomeNavigationBar.h"
#import "FNStoreLocationRedpackDetailHeaderCell.h"
#import "FNStoreLocationRedpackReceiveDetailModel.h"
#import "FNStoreLocationRedpackDetailTotalCell.h"
#import "FNStoreLocationRedpackDetailAdCell.h"
#import "FNStoreLocationRedpackDetailCateView.h"
#import "FNStoreLocationRedpackDetailImageCell.h"
#import "FNStoreLocationRedpackListController.h"
#import "FNStoreLocationRedpackFeedbackModel.h"
#import "FNNewStoreDetailController.h"

@interface FNStoreLocationRedpackDetailController()<UICollectionViewDelegate, UICollectionViewDataSource, FNStoreLocationRedpackDetailTotalCellDelegate, FNStoreLocationRedpackDetailAdCellDelegate, FNStoreLocationRedpackDetailHeaderCellDelegate>

@property (nonatomic, strong) FNCustomeNavigationBar *navigationView;
@property (nonatomic, strong) FNStoreLocationRedpackReceiveDetailModel *model;
@property (nonatomic, strong) UIImage *adImage;
@property (nonatomic, assign) NSInteger cateIndex;

@property (nonatomic, assign) BOOL isClose;

@property (nonatomic, strong) NSArray<FNStoreLocationRedpackFeedbackModel*> *feedbacks;

@end

@implementation FNStoreLocationRedpackDetailController

- (FNCustomeNavigationBar *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
        _navigationView.backgroundColor = [UIColor clearColor];
        
        UIButton* leftView = [UIButton new];
        UIImageView *imgBack = [[UIImageView alloc] init];
        imgBack.size = CGSizeMake(9, 15);
        imgBack.image = IMAGE(@"connection_button_back");
        [leftView addSubview:imgBack];
        leftView.frame = CGRectMake(10, 0, 20, 20);
        [leftView addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        
        _navigationView.leftButton = leftView;
        
        self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
        self.navigationView.titleLabel.sd_layout
        .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
        [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
        _navigationView.titleLabel.text=@"商品属性";
        
        if(self.understand==YES){
            _navigationView.leftButton.hidden=YES;
        }
        
        
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
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self apiRequestMain];
}

- (void)configUI {
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing=0;
    flowlayout.minimumInteritemSpacing=0;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:(CGRectZero) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=RGB(246, 246, 246);
    self.jm_collectionview.showsHorizontalScrollIndicator = NO;
    self.jm_collectionview.showsVerticalScrollIndicator = NO;
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    
    [self.jm_collectionview registerClass:[FNStoreLocationRedpackDetailHeaderCell class] forCellWithReuseIdentifier:@"FNStoreLocationRedpackDetailHeaderCell"];
    [self.jm_collectionview registerClass:[FNStoreLocationRedpackDetailTotalCell class] forCellWithReuseIdentifier:@"FNStoreLocationRedpackDetailTotalCell"];
    [self.jm_collectionview registerClass:[FNStoreLocationRedpackDetailAdCell class] forCellWithReuseIdentifier:@"FNStoreLocationRedpackDetailAdCell"];
    [self.jm_collectionview registerClass:[FNStoreLocationRedpackDetailImageCell class] forCellWithReuseIdentifier:@"FNStoreLocationRedpackDetailImageCell"];
    
    
    [self.jm_collectionview registerClass:[FNStoreLocationRedpackDetailCateView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNStoreLocationRedpackDetailCateView"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];

    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.navigationView];
    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:self.navigationView.height];
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        int count = 2;
        if (!_isClose && self.model && [self.model.adv_data.is_advertising isEqualToString:@"1"] && _adImage) {
            count ++;
        }
        return count;
    } else if (section == 1) {
        NSArray *cate = self.model.store.cate;
        if (cate.count > _cateIndex) {
            NSDictionary *dic = cate[_cateIndex];
            return ((NSArray*)dic[@"img"]).count;
        }
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            FNStoreLocationRedpackDetailHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNStoreLocationRedpackDetailHeaderCell" forIndexPath:indexPath];
            cell.delegate = self;
            [cell setModel:self.model];
            return cell;
        } else if (indexPath.row == 1) {
            FNStoreLocationRedpackDetailTotalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNStoreLocationRedpackDetailTotalCell" forIndexPath:indexPath];
            cell.delegate = self;
            [cell setModel:self.model];
            return cell;
        } else if (indexPath.row == 2) {
            FNStoreLocationRedpackDetailAdCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNStoreLocationRedpackDetailAdCell" forIndexPath:indexPath];
            cell.imgAd.image = _adImage;
            cell.delegate = self;
            return cell;
        }
    } else if (indexPath.section == 1) {
        FNStoreLocationRedpackDetailImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNStoreLocationRedpackDetailImageCell" forIndexPath:indexPath];
        NSArray *cate = self.model.store.cate;
        NSDictionary *dic = cate[_cateIndex];
        NSString * img = ((NSArray*)dic[@"img"])[indexPath.row];
        [cell.imageView sd_setImageWithURL:URL(img)];
        return cell;
    }
    return [[UICollectionViewCell alloc] init];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0)
            return CGSizeMake(FNDeviceWidth,  FNDeviceWidth);
        else if (indexPath.row == 1)
            return CGSizeMake(FNDeviceWidth,  90);
        else if (indexPath.row == 2) {
            if (self.model && [self.model.adv_data.is_advertising isEqualToString:@"1"] && _adImage) {
                return CGSizeMake(FNDeviceWidth,  FNDeviceWidth * _adImage.size.height / _adImage.size.width);
            }
            return CGSizeMake(FNDeviceWidth,  0);
        }
    } else if (indexPath.section == 1) {
        int w = FNDeviceWidth/2;
        if (indexPath.row % 2 == 1) //防止出现缝隙
            w = FNDeviceWidth - w;
        return CGSizeMake(w, 170);
    }
    return CGSizeMake(FNDeviceWidth,  0);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 2) {
        
        [self goWebWithUrl:self.model.adv_data.adv_url];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind==UICollectionElementKindSectionHeader) {
        FNStoreLocationRedpackDetailCateView* cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FNStoreLocationRedpackDetailCateView" forIndexPath:indexPath];
        cell.delegate = self;
        [cell setModel: self.model];
        [cell setSelectedAt: _cateIndex];
        return cell;
    }else{
        UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        reusableview.backgroundColor = UIColor.clearColor;
        return reusableview;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(JMScreenWidth, 0);
    }
    return CGSizeMake(JMScreenWidth, 44);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(JMScreenWidth, 12);
}


#pragma - mark Networking

//获取小店首页数据
- (FNRequestTool *)apiRequestMain{
    
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{}];
    
    if([self.latitude kr_isNotEmpty]){
        params[@"lat"]=self.latitude;
    }
    if([self.longitude kr_isNotEmpty]){
        params[@"lng"]=self.longitude;
    }
    if([_lid kr_isNotEmpty]){
        params[@"lid"]=_lid;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=position_redpacket&ctrl=redpacket_info" respondType:(ResponseTypeModel) modelType:@"FNStoreLocationRedpackReceiveDetailModel" success:^(id respondsObject) {
        
        self.model = respondsObject;
        [self.jm_collectionview reloadData];
        
//        self.navigationView.titleLabel.text=self.model.top_title;
//        self.navigationView.titleLabel.textColor = [UIColor colorWithHexString: self.model.top_title_color];
        
        self.navigationView.titleLabel.frame = CGRectMake(0, 0, 200, 20);
        self.navigationView.titleLabel.text = self.model.top_title;
        self.navigationView.titleLabel.textColor = [UIColor colorWithHexString: self.model.top_title_color];
        [self.navigationView.titleLabel sizeToFit];
        [self.navigationView.titleLabel mas_makeConstraints:  ^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.centerY.equalTo(self.navigationView.leftButton);
        }];
        
        self.adImage = nil;
        if ([self.model.adv_data.is_advertising isEqualToString:@"1"]) {
            @weakify(self)
            [SDWebImageManager.sharedManager downloadImageWithURL:URL(self.model.adv_data.adv_img) options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                @strongify(self)
                self.adImage = image;
                
                [self.jm_collectionview reloadData];
            }];
        }
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

- (FNRequestTool *)apiRequestFeedback: (NSString*)pid{
    
    @weakify(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{ @"rid": self.model.rid, @"store_id": self.model.store_id}];
    if([pid kr_isNotEmpty]){
        params[@"lid"]=pid;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=position_redpacket&ctrl=feedback_doing" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        
        [FNTipsView showTips:@"感谢您的反馈"];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

- (FNRequestTool *)apiRequestClose: (NSString*)pid{
    
    @weakify(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{}];
    if([pid kr_isNotEmpty]){
        params[@"pid"]=pid;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=position_redpacket&ctrl=feedback_cate" respondType:(ResponseTypeArray) modelType:@"FNStoreLocationRedpackFeedbackModel" success:^(id respondsObject) {
        @strongify(self)
        
        self.feedbacks = respondsObject;
        [self showCloseAlert];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

#pragma mark - FNStoreLocationRedpackDetailCateViewDelegate

- (void) cateView: (FNStoreLocationRedpackDetailCateView*)cateView didItemSelectedAt: (NSInteger)index {
    
    _cateIndex = index;
    [self.jm_collectionview reloadData];
    
}

#pragma mark - FNStoreLocationRedpackDetailTotalCellDelegate

- (void) didTotalCellMoreClick: (FNStoreLocationRedpackDetailTotalCell*)cell {
    FNStoreLocationRedpackListController *vc = [[FNStoreLocationRedpackListController alloc] init];
    vc.lid = _lid;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - FNStoreLocationRedpackDetailAdCellDelegate

- (void)adCellDidClose: (FNStoreLocationRedpackDetailAdCell*)cell {
    [self apiRequestClose: @""];
}

- (void)showCloseAlert {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    for (FNStoreLocationRedpackFeedbackModel *model in self.feedbacks) {
        @weakify(model)
        [alert addAction:[UIAlertAction actionWithTitle:model.name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            @strongify(model)
            if ([model.list_type isEqualToString:@"show_second"]) {
                [self apiRequestClose: model.id];
            } else {
                if ([model.is_close isEqualToString:@"1"]) {
                    self.isClose = YES;
                    [self.jm_collectionview reloadData];
                }
                [self apiRequestFeedback: model.id];
            }
            
        }]];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - FNStoreLocationRedpackDetailHeaderCellDelegate

- (void)headerCellDidLocationClick:(FNStoreLocationRedpackDetailHeaderCell*)cell {
    if (self.model) {
        FNNewStoreDetailController *store = [[FNNewStoreDetailController alloc] init];
        store.storeID = self.model.store.store_id;
        store.storeName = self.model.store.store_name;
        [self.navigationController pushViewController:store animated:YES];
    }
}
- (void)headerCellDidHeaderClick:(FNStoreLocationRedpackDetailHeaderCell*)cell {
    if (self.model) {
        FNNewStoreDetailController *store = [[FNNewStoreDetailController alloc] init];
        store.storeID = self.model.store.store_id;
        store.storeName = self.model.store.store_name;
        [self.navigationController pushViewController:store animated:YES];
    }
}

@end
