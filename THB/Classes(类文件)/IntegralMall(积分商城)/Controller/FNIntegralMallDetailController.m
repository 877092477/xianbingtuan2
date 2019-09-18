//
//  FNIntegralMallDetailController.m
//  THB
//
//  Created by Weller Zhao on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNIntegralMallDetailController.h"
#import "FNIntergralMallDetailHeaderView.h"
#import "FNIntergralMallDetailRecordCell.h"
#import "FNIntergralMallImageCell.h"
#import "FNIntergralMailBottomView.h"
#import "FNGoodsSelectorAlertView.h"
#import "FNImageTextCollectionViewCell.h"
#import "LeftAlignmentLayout.h"
#import "FNTextCollectionReusableView.h"
#import "FNclienteleDeController.h"
#import "FNIntegralMallOrderController.h"
#import "FNShareViewController.h"

#import "FNIntegralMallDetailModel.h"

@interface FNIntegralMallDetailController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, FNIntergralMallDetailRecordCellDelegate, FNIntergralMailBottomViewDelegate>

@property (nonatomic, strong) FNIntergralMailBottomView *bottomView;
@property (nonatomic, strong) FNGoodsSelectorAlertView *alertView;

@property (nonatomic, strong) NSMutableArray *allImages;

@property (nonatomic, strong) FNIntegralMallDetailModel *model;
@property (nonatomic, strong) NSMutableArray *records;

@end

@implementation FNIntegralMallDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allImages = [[NSMutableArray alloc] init];
    self.records = [[NSMutableArray alloc] init];
    [self configUI];
    [self apiRequestGoods];
    [self apiRequestRecords];
}


- (void)configUI {
//    self.title = @"商品详情";
    
    self.bottomView = [[FNIntergralMailBottomView alloc] init];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0).offset(isIphoneX ? -34 : 0);
        make.left.right.equalTo(@0);
    }];
    self.bottomView.delegate = self;
    LeftAlignmentLayout *layout = [[LeftAlignmentLayout alloc] init];
//    if (@available(iOS 10.0, *)) {
//        layout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
//    }
//    layout.estimatedItemSize = CGSizeMake(XYScreenWidth, XYScreenWidth);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    self.jm_collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 44) collectionViewLayout:layout];
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.backgroundColor = UIColor.whiteColor;
    self.jm_collectionview.showsVerticalScrollIndicator = NO;
    
    [self.jm_collectionview registerClass:[FNIntergralMallDetailHeaderView class] forCellWithReuseIdentifier:@"FNIntergralMallDetailHeaderView"];
    [self.jm_collectionview registerClass:[FNImageTextCollectionViewCell class] forCellWithReuseIdentifier:@"FNImageTextCollectionViewCell"];
    [self.jm_collectionview registerClass:[FNIntergralMallDetailRecordCell class] forCellWithReuseIdentifier:@"FNIntergralMallDetailRecordCell"];
    [self.jm_collectionview registerClass:[FNIntergralMallImageCell class] forCellWithReuseIdentifier:@"FNIntergralMallImageCell"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView"];
    [self.jm_collectionview registerClass:[FNTextCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNTextCollectionReusableView"];
    [self.view addSubview:self.jm_collectionview];
    
    [self.jm_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(@0);
        make.left.right.top.equalTo(@0);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.alertView = [[FNGoodsSelectorAlertView alloc] init];
    [self.view addSubview:self.alertView];
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
}

- (void) updateView {
    [self updateBottomView];
    [self updateAlertView];
}

- (void) updateBottomView {
    if (self.model == nil)
        return;
    [self.bottomView setTips:self.model.tip_str
              withTitleColor:[UIColor colorWithHexString:self.model.tip_color]
             backgroundColor:[UIColor colorWithHexString:self.model.tip_bjcolor] isHidden:self.model.is_can_buy.boolValue];
    self.bottomView.lblLeft.text = self.model.kf_str;
    self.bottomView.lblLeft.textColor = [UIColor colorWithHexString:self.model.kf_fontcolor];
    [self.bottomView.imgLeft sd_setImageWithURL:URL(self.model.kf_img)];
//    [self.bottomView.btnLeft setTitle:self.model.kf_str forState:UIControlStateNormal];
//    [self.bottomView.btnLeft sd_setImageWithURL:URL(self.model.kf_img) forState:UIControlStateNormal];
//    [self.bottomView.btnLeft setTitleColor:[UIColor colorWithHexString:self.model.kf_fontcolor] forState:UIControlStateNormal];
    self.bottomView.btnLeft.backgroundColor = [UIColor colorWithHexString:self.model.kf_bjcolor];
    
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat: [self.model.btn_fxz[@"bili"] kr_isNotEmpty] ? @"%@\n" : @"%@", self.model.btn_fxz[@"bili"]] attributes: @{NSFontAttributeName: kFONT14, NSForegroundColorAttributeName: UIColor.whiteColor}];
    [str1 appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", self.model.btn_fxz[@"str"]] attributes:@{NSFontAttributeName: kFONT12, NSForegroundColorAttributeName: UIColor.whiteColor}]];
    [self.bottomView.btnCenter setAttributedTitle:str1 forState:UIControlStateNormal];
    [self.bottomView.btnCenter setTitleColor:[UIColor colorWithHexString:self.model.btn_fxz[@"fontcolor"]] forState:UIControlStateNormal];
    [self.bottomView.btnCenter sd_setBackgroundImageWithURL:URL(self.model.btn_fxz[@"img"]) forState:UIControlStateNormal];

    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:[self.model.btn_zgz[@"bili"] kr_isNotEmpty] ? @"%@\n" : @"%@", self.model.btn_zgz[@"bili"]] attributes: @{NSFontAttributeName: kFONT14, NSForegroundColorAttributeName: UIColor.whiteColor}];
    [str2 appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", self.model.btn_zgz[@"str"]] attributes:@{NSFontAttributeName: kFONT12, NSForegroundColorAttributeName: UIColor.whiteColor}]];
    [self.bottomView.btnRight setAttributedTitle:str2 forState:UIControlStateNormal];
    [self.bottomView.btnRight setTitleColor:[UIColor colorWithHexString:self.model.btn_zgz[@"fontcolor"]] forState:UIControlStateNormal];
    [self.bottomView.btnRight setEnabled:self.model.is_can_buy.boolValue];
    [self.bottomView.btnRight sd_setBackgroundImageWithURL:URL(self.model.btn_zgz[@"img"]) forState:UIControlStateNormal];
}

- (void) updateAlertView {
    if (self.model == nil)
        return;
    [self.alertView.imgHeader sd_setImageWithURL:URL(self.model.goods_img)];
    self.alertView.lblPrice.text = self.model.str;
    int count = self.model.stock.intValue < self.model.limit_num ? self.model.stock.intValue : self.model.limit_num;
    [self.alertView setMaxCount:count withStock: self.model.stock.intValue];
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    NSMutableArray *datas = [[NSMutableArray alloc] init];
    for (FNIntegralMallDetailAtrrSectionModel* section in self.model.attr_data) {
        [titles addObject:section.name];
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (FNIntegralMallDetailAtrrDataModel *attr in section.attr_val) {
            [data addObject:attr.name];
        }
        [datas addObject:data];
    }
    [self.alertView setTitles:titles withDatas:datas];
    
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 1)
        return self.model.detail_label.count;
    if (section == 3)
        return self.allImages.count;
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FNIntergralMallDetailHeaderView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNIntergralMallDetailHeaderView" forIndexPath:indexPath];
        [cell setHeader:self.model.banner_img];
        cell.lblTitle.text = self.model.goods_title;
        cell.lblPrice.text = self.model.str;
        cell.lblPrice.textColor = [UIColor colorWithHexString:self.model.str_color];
        
        cell.lblDesc.text = [NSString stringWithFormat: @"商品价¥%@ %@", self.model.price, self.model.postage_str];
        cell.lblCount.text = self.model.sales_str;
        [cell setModel: self.model];
        
        @weakify(self)
        cell.upgradeClicked = ^{
            @strongify(self);
            [self loadMembershipUpgradeViewController];
        };
        cell.shareClicked = ^{
            @strongify(self);
            [self didCenterClick: nil];
        };
        
        return cell;
    }
    else if (indexPath.section == 1) {
        FNImageTextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNImageTextCollectionViewCell" forIndexPath:indexPath];
        FNIntegralMallDetailLabelModel *label = self.model.detail_label[indexPath.row];
        [cell.imgHeader sd_setImageWithURL:URL(label.img)];
        [cell setText:label.str];
        return cell;
    }
    else if (indexPath.section == 2) {
        FNIntergralMallDetailRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNIntergralMallDetailRecordCell" forIndexPath:indexPath];
        [cell setRecords:self.records];
        [cell.imgRecord sd_setImageWithURL:URL(self.model.buy_img)];
        cell.delegate = self;
        return cell;
    } else {
        FNIntergralMallImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNIntergralMallImageCell" forIndexPath:indexPath];
        UIImage *image = self.allImages[indexPath.row];
        [cell setImage:image];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        return CGSizeMake(XYScreenWidth, 44);
    }
    return CGSizeMake(XYScreenWidth, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(XYScreenWidth, 10);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3 && kind == UICollectionElementKindSectionHeader) {
        FNTextCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FNTextCollectionReusableView" forIndexPath:indexPath];
        view.backgroundColor = UIColor.whiteColor;
        [view setTitle:@"商品详情"];
        return view;
    }
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
    view.backgroundColor = FNHomeBackgroundColor;
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        BOOL showMidUpgrade = self.model.mid_zgz && [self.model.mid_zgz[@"is_show"] isEqual:@"1"] && ![FNCurrentVersion isEqualToString:Setting_checkVersion];
        if (showMidUpgrade) {
            return CGSizeMake(XYScreenWidth, XYScreenWidth + 160);
        }
        return CGSizeMake(XYScreenWidth, XYScreenWidth + 120);

    } else if (indexPath.section == 1) {
        return CGSizeMake(XYScreenWidth/3, 47);
    } else if (indexPath.section == 2) {
        return CGSizeMake(XYScreenWidth, 108);
    } else if (indexPath.section == 3) {
        UIImage *image = self.allImages[indexPath.row];
        CGFloat rowHeight=0;
        if (image && [image isKindOfClass:[UIImage class]]) {
            rowHeight= XYScreenWidth * image.size.height / image.size.width;
        }
        return CGSizeMake(XYScreenWidth,rowHeight);
    }
    return CGSizeMake(XYScreenWidth, XYScreenWidth);
}


#pragma mark - Network
- (void)apiRequestGoods {
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"id": _goodsId, TokenKey: UserAccessToken}];
    @weakify(self);
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=convert_goods&ctrl=detail" respondType:(ResponseTypeModel) modelType:@"FNIntegralMallDetailModel" success:^(id respondsObject) {
        @strongify(self);
        [SVProgressHUD dismiss];
        self.model = respondsObject;
        self.title = [self.model.top_title kr_isNotEmpty] ? self.model.top_title : @"商品详情";;
        
        [self.jm_collectionview reloadData];
        [self requestImage];
        
        [self updateView];
        
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:NO];
}

- (void)apiRequestRecords {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"gid": _goodsId, TokenKey: UserAccessToken}];
    @weakify(self);
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=convert_goods&ctrl=buy_record" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        [self.records removeAllObjects];
        for (id data in respondsObject) {
            NSString *name = [data valueForKey:@"str"];
            [self.records addObject:name];
        }
        
        [self.jm_collectionview reloadData];
        
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:NO];
}

- (void) requestImage {
    [self.allImages removeAllObjects];
    @weakify(self);
    [XYNetworkAPI downloadImages:self.model.detail_img withIndexBlock:^(UIImage *image, NSInteger index) {
        @strongify(self);
        [self.allImages addObject:image];
        [self.jm_collectionview reloadData];
    } failureBlock:^(NSError *error) {
        
    }];
}


#pragma mark - FNIntergralMallDetailRecordCellDelegate
- (void)didGoodsClick:(FNIntergralMallDetailRecordCell *)cell {
    [self.alertView show];
}

#pragma mark - FNIntergralMailBottomViewDelegate

- (void)didLeftClick: (FNIntergralMailBottomView*)view {
    FNclienteleDeController *vc = [[FNclienteleDeController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didCenterClick: (FNIntergralMailBottomView*)view {
//    FNShareViewController *share = [[FNShareViewController alloc] init];
//    [self.navigationController pushViewController:share animated:YES];
    FNShareViewController *share = [[FNShareViewController alloc] init];
    share.SkipUIIdentifier = self.model.SkipUIIdentifier;
    share.fnuo_id = self.model.fnuo_id;
    [self.navigationController pushViewController:share animated:YES];
}
- (void)didRightClick: (FNIntergralMailBottomView*)view {
    NSMutableString *vals = [[NSMutableString alloc] init];
    NSArray *selectedArray = [self.alertView getSelectedArray];
    for (NSInteger index = 0; index < selectedArray.count; index++) {
        int val = ((NSNumber*)selectedArray[index]).intValue;
        if (val == -1) {
            [self.alertView show];
            return;
        }
        NSString *key = self.model.attr_data[index].attr_val[val].ID;
        [vals appendString: index == 0 ? [NSString stringWithFormat:@"%@", key] : [NSString stringWithFormat:@",%@", key]];
    }
    FNIntegralMallOrderController *vc = [[FNIntegralMallOrderController alloc] init];
    vc.count = self.alertView.count;
    vc.goodsId = self.model.ID;
    vc.val = vals;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didTipsClick: (FNIntergralMailBottomView*)view {
    
}

@end
