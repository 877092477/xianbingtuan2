//
//  FNVideoMarketingHomeController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNVideoMarketingHomeController.h"
#import "FNMyVideoCardController.h"

#import "FNVideoGalleryCell.h"
#import "FNVideoMarketingHeaderCell.h"
#import "ShopRebatesCell.h"
#import "FNVideoCoverCell.h"
#import "FNVideoCardCell.h"
#import "FNVideoCardSecondCell.h"

#import "FNVideoMarketingModel.h"
#import "FNVideoMarketingPlayerController.h"
#import "FNVideoWebController.h"
#import "FNVideoMarketingHotController.h"
#import "FNMyVideoCardUseController.h"
#import "FNMembershipUpgradeViewController.h"

@interface FNVideoMarketingHomeController()<UICollectionViewDataSource, UICollectionViewDelegate, FNVideoGalleryCellDelegate, FNVideoMarketingHeaderCellDelegate>

@property (nonatomic, strong) NSArray<FNVideoMarketingModel*> *dataArray;
@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UIButton *rightBtn;

@property (nonatomic, strong) UIView *vAlert;
@property (nonatomic, strong) UIImageView *imgAlertBackground;
@property (nonatomic, strong) UILabel *lblAlertTitle;
@property (nonatomic, strong) UIButton *btnLeft;
@property (nonatomic, strong) UIButton *btnRight;
@property (nonatomic, strong) UIButton *btnClose;

@end

@implementation FNVideoMarketingHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    [self setupNav];
    [self configAlert];
    [self requestMain];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(onCardUse) name:@"MY_VIDEO_CARD_USE" object:nil];
}

- (void)dealloc
{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)onCardUse {
    
    [self requestMain];
}

- (void)configUI {
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    flowlayout.minimumLineSpacing=0.0f;
    flowlayout.minimumInteritemSpacing=0.0f;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:(CGRectZero) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=RGB(246, 246, 246);
    self.jm_collectionview.showsHorizontalScrollIndicator = NO;
    self.jm_collectionview.showsVerticalScrollIndicator = NO;
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    [self.jm_collectionview registerClass:[FNVideoGalleryCell class] forCellWithReuseIdentifier:@"FNVideoGalleryCell"];
    [self.jm_collectionview registerClass:[FNVideoCoverCell class] forCellWithReuseIdentifier:@"FNVideoCoverCell"];
    [self.jm_collectionview registerClass:[ShopRebatesCell class] forCellWithReuseIdentifier:@"ShopRebatesCell"];
    [self.jm_collectionview registerClass:[FNVideoCardCell class] forCellWithReuseIdentifier:@"FNVideoCardCell"];
    [self.jm_collectionview registerClass:[FNVideoCardSecondCell class] forCellWithReuseIdentifier:@"FNVideoCardSecondCell"];
    [self.jm_collectionview registerClass:[FNVideoMarketingHeaderCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNVideoMarketingHeaderCell"];
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(0, 0, self.understand ? XYTabBarHeight : 0, 0));
    }];
    
}

-(void)setupNav{
    UIButton *leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [leftBtn setTitleColor:FNBlackColor forState:UIControlStateNormal];
    [leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    [leftBtn sizeToFit];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.size=CGSizeMake(30,  30);
    self.leftBtn=leftBtn;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    UIButton *rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
//    [rightbutton setTitle:@"我的免单" forState:UIControlStateNormal];
    rightbutton.titleLabel.font = kFONT12;
    [rightbutton setTitleColor:RGB(60, 60, 60) forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn=rightbutton;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    if(self.understand==YES){
        self.leftBtn.hidden=YES;
    }
}

- (void)configAlert {
    _vAlert = [[UIView alloc] init];
    _imgAlertBackground = [[UIImageView alloc] init];
    _lblAlertTitle = [[UILabel alloc] init];
    _btnLeft = [[UIButton alloc] init];
    _btnRight = [[UIButton alloc] init];
    _btnClose = [[UIButton alloc] init];
    
    //    _vAlert;
    [_vAlert addSubview:_imgAlertBackground];
    [_vAlert addSubview:_lblAlertTitle];
    [_vAlert addSubview:_btnLeft];
    [_vAlert addSubview:_btnRight];
    [_vAlert addSubview:_btnClose];
    
    //    _vAlert;
    [_imgAlertBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.mas_equalTo(300);
        make.height.equalTo(self.imgAlertBackground.mas_height).dividedBy(1);
//        make.top.equalTo(@166);
    }];
    [_lblAlertTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imgAlertBackground);
        make.top.equalTo(self.imgAlertBackground).offset(80);
        make.left.greaterThanOrEqualTo(self.imgAlertBackground).offset(20);
        make.right.lessThanOrEqualTo(self.imgAlertBackground).offset(-20);
    }];
    [_btnLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.imgAlertBackground);
        make.right.equalTo(self.imgAlertBackground.mas_centerX);
        make.bottom.equalTo(self.imgAlertBackground).offset(-15);
        make.height.mas_equalTo(30);
    }];
    [_btnRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imgAlertBackground);
        make.bottom.equalTo(self.btnLeft);
        make.left.equalTo(self.imgAlertBackground.mas_centerX);
        make.height.mas_equalTo(30);
    }];
    [_btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.imgAlertBackground);
    }];
    
    _vAlert.backgroundColor = RGBA(0, 0, 0, 0.3);
    
    _lblAlertTitle.font = kFONT15;
    _lblAlertTitle.textColor = RGB(51, 51, 51);
    
    [_btnLeft setTitle:@"卡密续费" forState:UIControlStateNormal];
    [_btnLeft addTarget:self action:@selector(leftAlertBtnAction)];
    [_btnLeft setTitleColor:RGB(245, 62, 60) forState:UIControlStateNormal];
    
    if ([FNCurrentVersion isEqualToString:Setting_checkVersion]) {
        [_btnRight setTitle:@"取消" forState:UIControlStateNormal];
    } else {
        [_btnRight setTitle:@"VIP续费" forState:UIControlStateNormal];
    }
    [_btnRight addTarget:self action:@selector(rightAlertBtnAction)];
    [_btnRight setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    
    [_btnClose setImage:IMAGE(@"video_card_alert_close") forState:UIControlStateNormal];
    [_btnClose addTarget:self action:@selector(close)];
}

-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightBtnAction{
    FNMyVideoCardController *vc = [[FNMyVideoCardController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)leftAlertBtnAction{
    FNMyVideoCardUseController *vc = [[FNMyVideoCardUseController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [self close];
}
-(void)rightAlertBtnAction{
    if (![FNCurrentVersion isEqualToString:Setting_checkVersion]) {
        FNMembershipUpgradeViewController *vc = [[FNMembershipUpgradeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    [self close];
}


- (void)close {
    [self.vAlert removeFromSuperview];
}

- (void)showAlertWithBackground: (NSString*)bgURL{
    _lblAlertTitle.text = @"续费方式";
    @weakify(self)
    [_imgAlertBackground sd_setImageWithURL:URL(bgURL) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (error == nil && image) {
            [self.imgAlertBackground mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(self.imgAlertBackground.mas_width).dividedBy(image.size.width / image.size.height);
            }];
        }
    }];
    
    [FNKeyWindow addSubview:_vAlert];
    [_vAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataArray ? _dataArray.count : 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_dataArray == nil)
        return 0;
    FNVideoMarketingModel *model = _dataArray[section];
    NSArray *items = _dataArray[section].list;
    if ([model.type isEqualToString:@"movie_banner_01"]) {
        return items == nil ? 0 : 1;
    }
    return items == nil ? 0 : items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FNVideoMarketingModel *model = _dataArray[indexPath.section];
    FNVideoMarketingItemModel *item = model.list[indexPath.row];
    
    if ([model.type isEqualToString:@"movie_banner_01"]) {
        FNVideoGalleryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNVideoGalleryCell" forIndexPath:indexPath];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (FNVideoMarketingItemModel* item in model.list) {
            [array addObject:item.img];
        }
        [cell setImageUrls:array];
        cell.delegate = self;
        
        return cell;
    }
    else if ([model.type isEqualToString:@"movie_recommend_01"]) {
        FNVideoCoverCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNVideoCoverCell" forIndexPath:indexPath];
        [cell setImage:item.img withTitle:item.name];
        return cell;
    } else if ([model.type isEqualToString:@"movie_privilege_01"]) {
        FNVideoCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNVideoCardCell" forIndexPath:indexPath];
        [cell.imgBackground sd_setImageWithURL:URL(item.img)];
        cell.lblTitle.text = item.title;
        cell.lblTitle.textColor = [UIColor colorWithHexString:item.color];
        cell.lblDesc.text = item.content;
        cell.lblDesc.textColor = [UIColor colorWithHexString:item.contentcolor];
        [cell.btnMore setTitle:item.btntitle forState:UIControlStateNormal];
        [cell.btnMore setTitleColor:[UIColor colorWithHexString:item.btncolor] forState:UIControlStateNormal];
        [cell.btnMore sd_setBackgroundImageWithURL:URL(item.btnimg) forState:UIControlStateNormal];
        return cell;
    } else if ([model.type isEqualToString:@"movie_privilege_02"]) {
        FNVideoCardSecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNVideoCardSecondCell" forIndexPath:indexPath];
        [cell.imgBackground sd_setImageWithURL:URL(item.img)];
        cell.lblTitle.text = item.title;
        cell.lblTitle.textColor = [UIColor colorWithHexString:item.color];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:item.act_str attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString: item.act_str_color]}];
        [str appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        [str appendAttributedString:[[NSAttributedString alloc] initWithString:item.time_str attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString: item.time_str_color]}]];
        cell.lblDesc.attributedText = str;
//        cell.lblDesc.text = item.content;
//        cell.lblDesc.textColor = [UIColor colorWithHexString:item.contentcolor];
        [cell.btnMore setTitle:item.btntitle forState:UIControlStateNormal];
        [cell.btnMore setTitleColor:[UIColor colorWithHexString:item.btncolor] forState:UIControlStateNormal];
        [cell.btnMore sd_setBackgroundImageWithURL:URL(item.btnimg) forState:UIControlStateNormal];
        return cell;
    }
    else {
        ShopRebatesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopRebatesCell" forIndexPath:indexPath];
        [cell.imgHeader sd_setImageWithURL:URL(item.img)];
        cell.lblTitle.text = item.name;
        cell.isCircle = NO;
        cell.borderWidth = 1;
        cell.borderColor = RGB(246, 246, 246);
        return cell;
    }
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    FNVideoMarketingHeaderCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FNVideoMarketingHeaderCell" forIndexPath:indexPath];
    FNVideoMarketingModel *model = _dataArray[indexPath.section];
    if ([model.type isEqualToString:@"movie_banner_01"]) {
        [cell setImage:nil withTitle:@"" isMoreShow:NO];
    } else if ([model.type isEqualToString:@"movie_privilege_01"]) {
        [cell setImage:model.img withTitle:model.content isMoreShow:NO];
    } else if ([model.type isEqualToString:@"movie_privilege_02"]) {
        [cell setImage:model.img withTitle:model.content isMoreShow:NO];
    } else if ([model.type isEqualToString:@"movie_provide_01"]) {
        [cell setImage:model.img withTitle:model.content isMoreShow:NO];
    } else if ([model.type isEqualToString:@"movie_recommend_01"]) {
        [cell setImage:model.img withTitle:model.content isMoreShow:YES];
    }
    cell.delegate = self;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    FNVideoMarketingModel *model = _dataArray[section];
    
    if ([model.type isEqualToString:@"movie_banner_01"] || [model.type isEqualToString:@"movie_privilege_02"]) {
        return CGSizeMake(JMScreenWidth, 0);
    }
    return CGSizeMake(JMScreenWidth, 44);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(JMScreenWidth, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNVideoMarketingModel *model = _dataArray[indexPath.section];
    
    if ([model.type isEqualToString:@"movie_banner_01"]) {
        return CGSizeMake(XYScreenWidth, XYScreenWidth * 9 / 16);
    }
    else if ([model.type isEqualToString:@"movie_recommend_01"]) {
        CGFloat width = XYScreenWidth / 3;
        return CGSizeMake(width, width / 0.75 + 40);
    } else if ([model.type isEqualToString:@"movie_privilege_01"]) {
        return CGSizeMake(XYScreenWidth, XYScreenWidth * 0.31);
    } else if ([model.type isEqualToString:@"movie_privilege_02"]) {
        return CGSizeMake(XYScreenWidth, XYScreenWidth * 0.25);
    }
    else {
        CGFloat width = XYScreenWidth / 3;
        return CGSizeMake(width, width);
    }
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNVideoMarketingModel *model = _dataArray[indexPath.section];
    FNVideoMarketingItemModel *item = model.list[indexPath.row];
    
    if ([model.type isEqualToString:@"movie_banner_01"]) {
        return;
    }
    else if ([model.type isEqualToString:@"movie_recommend_01"]) {
        
        [self goMovie:item];
        return ;
    } else if ([model.type isEqualToString:@"movie_privilege_01"]) {
        [self loadOtherVCWithModel:item andInfo:nil outBlock:nil];
    } else if ([model.type isEqualToString:@"movie_privilege_02"]) {
//        [self loadOtherVCWithModel:item andInfo:nil outBlock:nil];
        [self showAlertWithBackground: item.tip_img];
    } else if ([model.type isEqualToString:@"movie_provide_01"]) {
        [self goWebsite:item];
    }
}

- (void)goWebsite: (FNVideoMarketingItemModel*) item {
    if ([item.is_visit isEqualToString:@"1"]) {
        FNVideoWebController *vc = [[FNVideoWebController alloc] init];
        vc.url = item.url;
        vc.title = item.name;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self showAlert:item.visit_str];
    }
}

- (void)goMovie: (FNVideoMarketingItemModel*) item {
    if ([item.is_visit isEqualToString:@"1"]) {
        if ([item.show_type isEqualToString:@"1"]) {
            FNVideoWebController *vc = [[FNVideoWebController alloc] init];
            vc.url = item.movie_url;
            vc.title = item.name;
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            FNVideoMarketingPlayerController *vc = [[FNVideoMarketingPlayerController alloc] init];
            vc.model = item;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
        [self showAlert:item.visit_str];
    }
}

- (void)showAlert: (NSString*)str {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message: str preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Networking

- (FNRequestTool*) requestMain {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=app_movie&ctrl=index" respondType:(ResponseTypeArray) modelType:@"FNVideoMarketingModel" success:^(id respondsObject) {
        @strongify(self);
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (FNVideoMarketingModel *model in respondsObject) {
            if ([model.type isEqualToString: @"movie_top_01"]) {
                FNVideoMarketingItemModel *item = model.list.firstObject;
                if (item) {
                    self.title = item.title;
                    [self.rightBtn setTitle:item.right_str forState:UIControlStateNormal];
                    self.rightBtn.hidden = ![item.is_show isEqualToString:@"1"];
                }
                continue;
            }
            [array addObject:model];
        }
        self.dataArray = array;
        [self.jm_collectionview reloadData];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache:NO];
}

#pragma mark - FNVideoGalleryCellDelegate
- (void)cell:(FNVideoGalleryCell *)cell didItemClickAt:(NSInteger)index {
    NSIndexPath *indexPath = [self.jm_collectionview indexPathForCell:cell];
    FNVideoMarketingItemModel *item = self.dataArray[indexPath.section].list[index];
    if ([item.is_visit isEqualToString:@"0"]) {
        [self showAlert:item.visit_str];
    } else {
        [self loadOtherVCWithModel:item andInfo:nil outBlock:nil];
    }
}

#pragma mark - FNVideoMarketingHeaderCellDelegate
- (void)headerdidMoreClick:(FNVideoMarketingHeaderCell *)header {
    FNVideoMarketingHotController *vc = [[FNVideoMarketingHotController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
