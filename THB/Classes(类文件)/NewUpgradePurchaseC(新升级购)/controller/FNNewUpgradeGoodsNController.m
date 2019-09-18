//
//  FNNewUpgradeGoodsNController.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/17.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewUpgradeGoodsNController.h"
#import "FNUpGoodsDetailsNController.h"

#import "FNCustomeNavigationBar.h"
#import "FNUpgradeHeaderView.h"
#import "FNImageCollectionViewCell.h"
#import "FNUpgradeTwoCollectionViewCell.h"
#import "FNUpgradeCateCollectionViewCell.h"
#import "FNUpgradeGoodsCollectionViewCell.h"
#import "FNUpgradeGoodsCollectionViewCell.h"

#import "FNUpgradeModel.h"
#import "FNUpgradeGoodsModel.h"

@interface FNNewUpgradeGoodsNController()<UICollectionViewDelegate, UICollectionViewDataSource, SliderControlDelegate, FNUpgradeTwoCollectionViewCellDelegate>

@property (nonatomic, strong) FNUpgradeHeaderView* headerView;
@property (nonatomic, strong) FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong) UIImageView *imageNav;
@property (nonatomic, strong) UIButton* settingBtn;
@property (nonatomic, strong) UIImageView* backBtn;

@property (nonatomic, strong) UIImageView* imgHeader;

@property (nonatomic, assign) CGFloat HeaderHeight;

@property (nonatomic, strong) FNUpgradeTopModel *topModel;
@property (nonatomic, strong) NSArray<FNUpgradeModel*> *models;
@property (nonatomic, strong) NSArray<FNUpgradeCateModel*> *cates;
@property (nonatomic, strong) NSMutableArray<FNUpgradeGoodsModel*> *goods;
@property (nonatomic, assign) NSInteger cateIndex;

@end

@implementation FNNewUpgradeGoodsNController

#define PADDING 10
#define HEADER_HEIGHT 80
#define HEADER_OFFSET (self.headerView.frame.size.height + self.navigationView.height)

- (FNUpgradeHeaderView*)headerView {
    if (_headerView == nil) {
        _headerView = [[FNUpgradeHeaderView alloc] initWithFrame:CGRectMake(0, -HEADER_HEIGHT, JMScreenWidth, HEADER_HEIGHT)];
//        _headerView.delegate = self;
    }
    return _headerView;
}


- (FNCustomeNavigationBar *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
        
        _imageNav = [[UIImageView alloc] init];
        //        [_navigationView addSubview:_imageNav];
        [_navigationView insertSubview:_imageNav atIndex:0];
        [_imageNav mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        _imageNav.contentMode = UIViewContentModeScaleAspectFill;
        _imageNav.layer.masksToBounds = YES;
        
        UIButton* leftView = [UIButton new];
        self.backBtn = [[UIImageView alloc] init];
        self.backBtn.size = CGSizeMake(9, 15);
        [leftView addSubview:self.backBtn];
        leftView.frame = CGRectMake(0, 0, 20, 20);
        [leftView addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        
        _navigationView.leftButton = leftView;
        
        if(self.understand==YES){
            self.backBtn.hidden=YES;
        }
        
        
    }
    return _navigationView;
}

- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
    
}

- (void)viewDidLoad {
    _goods = [[NSMutableArray alloc] init];
    [super viewDidLoad];
    
    [self setupNav];
    [self configUI];
    
    [self requestTop];
    [self requestMain];
    [self requestCate];
}

- (void)setupNav {
    
}

- (void)configUI {
    self.view.backgroundColor=RGB(250, 250, 250);
    
    _imgHeader = [[UIImageView alloc] init];
    _imgHeader.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview: _imgHeader];
    [_imgHeader mas_makeConstraints: ^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.mas_equalTo(0);
    }];
    
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
//    flowlayout.minimumLineSpacing = 10;
//    flowlayout.minimumInteritemSpacing = 10;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 0) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor clearColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
//    self.jm_collectionview.hidden=YES;
    [self.view addSubview:self.jm_collectionview];
    self.jm_collectionview.contentInset = UIEdgeInsetsMake(HEADER_OFFSET, 0, 0, 0);
    [self.jm_collectionview addSubview: self.headerView];
    
    [self.jm_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        //        make.top.equalTo(@0);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(self.understand ? @(-XYTabBarHeight) : (isIphoneX ? @-34 : @0));
    }];
    
    [self.jm_collectionview registerClass:[FNImageCollectionViewCell class] forCellWithReuseIdentifier:@"FNImageCollectionViewCell"];
    [self.jm_collectionview registerClass:[FNUpgradeTwoCollectionViewCell class] forCellWithReuseIdentifier:@"FNUpgradeTwoCollectionViewCell"];
    [self.jm_collectionview registerClass:[FNUpgradeCateCollectionViewCell class] forCellWithReuseIdentifier:@"FNUpgradeCateCollectionViewCell"];
    [self.jm_collectionview registerClass:[FNUpgradeGoodsCollectionViewCell class] forCellWithReuseIdentifier:@"FNUpgradeGoodsCollectionViewCell"];
    
    
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
//
//    [self.jm_collectionview registerClass:[FNOrderMendCell class] forCellWithReuseIdentifier:@"FNOrderMendCell"];
    
    
    [self.view addSubview:self.navigationView];
    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:self.navigationView.height];
    
}


- (void)configHeader {
    if (self.topModel == nil) {
        return;
    }
    self.navigationView.titleLabel.frame = CGRectMake(0, 0, 200, 20);
    self.navigationView.titleLabel.text = self.topModel.top_title;
    self.navigationView.titleLabel.textColor = [UIColor colorWithHexString: self.topModel.top_title_color];
    [self.navigationView.titleLabel sizeToFit];
    [self.navigationView.titleLabel mas_makeConstraints:  ^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(self.navigationView.leftButton);
    }];
    [self.headerView.imgHeader sd_setImageWithURL:URL(self.topModel.head_img)];
    self.headerView.lblName.text = self.topModel.name;
    self.headerView.lblName.textColor = [UIColor colorWithHexString: self.topModel.name_color];
    self.headerView.lblLevel.text = self.topModel.lv_str;
    self.headerView.lblLevel.textColor = [UIColor colorWithHexString: self.topModel.lv_color];
    [self.headerView.imgLevel sd_setImageWithURL:[NSURL URLWithString:self.topModel.vip_logo]];
    
    [self.backBtn sd_setImageWithURL: URL(self.topModel.returnimg)];
    @weakify(self)
    [_imgHeader sd_setImageWithURL:[NSURL URLWithString:_topModel.bjimg] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (image) {
            
            self.HeaderHeight = XYScreenWidth * image.size.height / image.size.width;
            [self.imgHeader mas_updateConstraints: ^(MASConstraintMaker *make) {
                make.height.mas_equalTo(self.HeaderHeight);
            }];
            [self.view layoutIfNeeded];
        }
    }];
}

#pragma mark - Networking
- (void)requestTop{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=updateModel&ctrl=top_index" respondType:(ResponseTypeModel) modelType:@"FNUpgradeTopModel" success:^(id respondsObject) {
        @strongify(self)
        self.topModel = respondsObject;
        [self configHeader];
    } failure:^(NSString *error) {
        
        
    } isHideTips:YES];
    
}

- (void)requestMain{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=updateModel&ctrl=getIndex" respondType:(ResponseTypeArray) modelType:@"FNUpgradeModel" success:^(id respondsObject) {
        @strongify(self)
        
        self.models = respondsObject;
        
        for (FNUpgradeModel *model in self.models) {
            if (([model.type isEqualToString:@"update_goods_one_banner_01"] || [model.type isEqualToString: @"update_goods_two_banner_01"]) && model.list.count > 0) {
                @weakify(model)
                @weakify(self)
                [SDWebImageManager.sharedManager downloadImageWithURL:URL(model.list[0].img) options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    @strongify(model)
                    @strongify(self)
                    if(image && finished){
                        model.bili=image.size.height/image.size.width;
                        [self.jm_collectionview reloadData];

                    }
                }];
            } if ([model.type isEqualToString:@"update_goods_list_01"]) {
                [self requestCate];
            }
        }
        
        [self.jm_collectionview reloadData];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:YES];
    
}

- (void)requestCate{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=updateModel&ctrl=cate" respondType:(ResponseTypeArray) modelType:@"FNUpgradeCateModel" success:^(id respondsObject) {
        @strongify(self)
        
        self.cates = respondsObject;
        [self.jm_collectionview reloadData];
        
        self.cateIndex = 0;
        self.jm_page = 1;
        if (_cates.count > 0) {
            [self requestGoods:_cates[_cateIndex].id];
        }
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:YES];
    
}

- (void)requestGoods: (NSString*)cid {
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"cid": cid}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=updateModel&ctrl=goods_list" respondType:(ResponseTypeArray) modelType:@"FNUpgradeGoodsModel" success:^(id respondsObject) {
        @strongify(self)
        
        if (self.jm_page == 1) {
            [self.goods removeAllObjects];
        }
        [self.goods addObjectsFromArray: respondsObject];
        
        [self.jm_collectionview reloadData];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:YES];
    
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return self.models.count;
    }
    else {
        if (self.goods.count > 0)
            return self.goods.count;
        return 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FNUpgradeModel *model = self.models[indexPath.row];
        float jiange = model.jiange.floatValue;
        if ([model.type isEqualToString: @"update_goods_one_banner_01"]) {
            
            FNImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNImageCollectionViewCell" forIndexPath:indexPath];
            //设置左右间距
            [cell setPadding: PADDING jiange: jiange];
            if (model.list.count > 0) {
                FNUpgradeDataModel *data = model.list[0];
                [cell.imageView sd_setImageWithURL: URL(data.img)];
            }
            return cell;
        } else if ([model.type isEqualToString: @"update_goods_two_banner_01"]) {
            FNUpgradeTwoCollectionViewCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNUpgradeTwoCollectionViewCell" forIndexPath:indexPath];
            if (model.list.count > 0) {
                FNUpgradeDataModel *data = model.list[0];
                [cell.imgLeft sd_setImageWithURL: URL(data.img)];
            }
            if (model.list.count > 1) {
                FNUpgradeDataModel *data = model.list[1];
                [cell.imgRight sd_setImageWithURL: URL(data.img)];
            }
            [cell setJiange: jiange];
            cell.delegate = self;
            return cell;
        } else if ([model.type isEqualToString: @"update_goods_list_01"]) {
            FNUpgradeCateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNUpgradeCateCollectionViewCell" forIndexPath:indexPath];
            NSMutableArray *titles = [[NSMutableArray alloc] init];
            for (FNUpgradeCateModel *cate in _cates) {
                [titles addObject: cate.catename];
            }
            [cell.sliderView setTitles: titles];
            [cell.sliderView setSelected: _cateIndex animated: NO];
            cell.sliderView.delegate = self;
            return cell;
        }
    } else {
        if (self.goods.count > 0) {
            FNUpgradeGoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNUpgradeGoodsCollectionViewCell" forIndexPath:indexPath];
            FNUpgradeGoodsModel *model = self.goods[indexPath.row];
            cell.lblTitle.text = model.title;
            cell.lblPrice.text = model.price;
            cell.lblButton.text = model.btn_str;
            cell.lblButton.textColor = [UIColor colorWithHexString:model.btn_color];
            [cell.imgHeader sd_setImageWithURL:URL(model.img)];
            [cell setButton: model.btn_img];
            [cell setTag: model.label_img];
            [cell setIsLeft: indexPath.row % 2 == 0];
            return cell;
        } else {
            
        }
    }
    
    FNImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNImageCollectionViewCell" forIndexPath:indexPath];
    cell.imageView.image = nil;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FNUpgradeModel *model = self.models[indexPath.row];
        float jiange = model.jiange.floatValue;
        if ([model.type isEqualToString: @"update_goods_one_banner_01"]) {
            return CGSizeMake(XYScreenWidth, (XYScreenWidth - PADDING * 2) * model.bili + jiange);
        } else if ([model.type isEqualToString: @"update_goods_two_banner_01"]) {
            return CGSizeMake(XYScreenWidth, (XYScreenWidth - PADDING * 2) / 2 * model.bili +jiange);
        } else if ([model.type isEqualToString: @"update_goods_list_01"] + jiange) {
            return CGSizeMake(XYScreenWidth, self.cates.count == 0 ? 0 : 36);
        }
    } else {
        if (self.goods.count > 0) {
            return CGSizeMake(XYScreenWidth / 2 - 5, 265);
        } else {
            return CGSizeMake(XYScreenWidth, XYScreenWidth);
        }
    }
    return CGSizeMake(XYScreenWidth, 0);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
//        FNUpgradeModel *model = self.models[section];
//        return model.jiange.floatValue;
        return 0;
    } else {
        return 10;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FNUpgradeModel *model = self.models[indexPath.row];
        if ([model.type isEqualToString: @"update_goods_one_banner_01"]) {
            if (model.list.count > 0) {
                [self loadOtherVCWithModel:model.list[0] andInfo:nil outBlock:nil];
            }
        }
    } else {
        if (self.goods.count > 0) {
            FNUpgradeGoodsModel *model = self.goods[indexPath.row];
            FNUpGoodsDetailsNController *detailsVC=[[FNUpGoodsDetailsNController alloc]init];
            detailsVC.DetailsID=model.id;
            [self.navigationController pushViewController:detailsVC animated:YES];
        }
    }
}

#pragma mark - Table view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y + HEADER_OFFSET;

    if (conY<0) {
        [_imgHeader mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
            make.height.mas_equalTo(_HeaderHeight - conY);
        }];
    }else{
        [_imgHeader mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(-conY);
            make.height.mas_equalTo(_HeaderHeight);
        }];
    }

//    NSArray *rgb = [UIColor getRGBWithHexString:_headerModel.color];
//    int r = [((NSNumber*)rgb[0]) intValue];
//    int g = [((NSNumber*)rgb[1]) intValue];
//    int b = [((NSNumber*)rgb[2]) intValue];
    if (conY>0 && conY<=JMNavBarHeigth) {
        //滚动中
        float percent = conY/JMNavBarHeigth;
        self.navigationView.backgroundColor = [FNMainGobalControlsColor colorWithAlphaComponent:conY/JMNavBarHeigth];
//        [self.msgBtn setTitleColor:RGB(r + (255 - r)*percent, g + (255 - g)*percent, b + (255 - b)*percent) forState:UIControlStateNormal];
//        [self.settingBtn setTitleColor:RGB(r + (255 - r)*percent, g + (255 - g)*percent, b + (255 - b)*percent) forState:UIControlStateNormal];
    }else if (conY > JMNavBarHeigth){
        //
        self.navigationView.backgroundColor = FNMainGobalControlsColor;
//        [self.msgBtn setTitleColor:FNWhiteColor forState:UIControlStateNormal];
//        [self.settingBtn setTitleColor:FNWhiteColor forState:UIControlStateNormal];
    }else{
        self.navigationView.backgroundColor = [UIColor clearColor];
//        [self.msgBtn setTitleColor:[UIColor colorWithHexString:_headerModel.color] forState:UIControlStateNormal];
//        [self.settingBtn setTitleColor:[UIColor colorWithHexString:_headerModel.color] forState:UIControlStateNormal];
    }
}

#pragma mark - SliderControlDelegate
- (void)sliderControl: (SliderControl*) slider didCellSelectedAtIndex: (NSInteger) index {
    _cateIndex = index;
    [self requestGoods: _cates[_cateIndex].id];
}

#pragma mark - FNUpgradeTwoCollectionViewCellDelegate
- (void) didLeftClick: (FNUpgradeTwoCollectionViewCell*)cell {
    NSIndexPath *indexPath = [self.jm_collectionview indexPathForCell:cell];
    
    FNUpgradeModel *model = self.models[indexPath.row];
    if (model.list.count > 0) {
        [self loadOtherVCWithModel:model.list[0] andInfo:nil outBlock:nil];
    }
}
- (void) didRightClick: (FNUpgradeTwoCollectionViewCell*)cell {
    NSIndexPath *indexPath = [self.jm_collectionview indexPathForCell:cell];
    
    FNUpgradeModel *model = self.models[indexPath.row];
    if (model.list.count > 1) {
        [self loadOtherVCWithModel:model.list[1] andInfo:nil outBlock:nil];
    }
}

@end
