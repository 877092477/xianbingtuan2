//
//  FNNewProDetailController.m
//  THB
//
//  Created by Jimmy on 2017/12/16.
//  Copyright © 2017年 方诺科技. All rights reserved.
// 后续商品详细

#import "FNNewProDetailController.h"
#import "FNMembershipUpgradeViewController.h"
#import "FNNewProductDetailModel.h"
#import "FNNewProductDetailHeader.h"
#import "FNHomeSpecialCCell.h"
#import "FNNPDImgCell.h"
#import "JMTitleScrollView.h"
#import "FNCustomeNavigationBar.h"
#import "FNDetailShopController.h"
#import "FNDetailBottomView.h"

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "CircleOfFriendsModel.h"
#import "FNProductImageTool.h"
#import "FNNewProDetailCouponeAlertView.h"
#import "FNNetCouponeExchangeController.h"

static const CGFloat _jm_detail_invitedHeight = 34.0;
@interface FNNewProDetailController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,JMTitleScrollViewDelegate,UIWebViewDelegate,FNNewProDetailCouponeAlertViewDelegate>
@property (nonatomic, strong)FNNewProductDetailModel* model;
@property (nonatomic, strong)FNNewProductDetailHeader* header;
@property (nonatomic, strong)NSMutableArray* products;
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)JMTitleScrollView* titleview;
@property (nonatomic, strong)FNDetailBottomView* bottomview;

@property (nonatomic, copy)NSString* invitedText;
@property (nonatomic, strong)UIView* invitedTextView;
@property (nonatomic, strong)UILabel* invitedTextLabel;

@property (nonatomic, strong)UIImageView* toTopImage;
@property (nonatomic, strong)NSString* FNshopUrl;
@property (nonatomic, assign)NSInteger isemptyUrl;
@property (nonatomic, strong)UIWebView *shopwebView;
@property (nonatomic, strong)FNProductImageTool *tool;

@property (nonatomic, strong)NSArray<NSDictionary*> *lq_list;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, assign)NSInteger lq_index;

@property (nonatomic, strong)FNNewProDetailCouponeAlertView *couponeAlert;

@end

@implementation FNNewProDetailController
- (BOOL)isFullScreenShow {
    return YES;
}

- (FNProductImageTool*)tool {
    if (_tool == nil) {
        _tool = [[FNProductImageTool alloc] init];
    }
    return _tool;
}
- (FNNewProDetailCouponeAlertView *)couponeAlert {
    if (_couponeAlert == nil) {
        _couponeAlert = [[FNNewProDetailCouponeAlertView alloc] init];
        _couponeAlert.delegate = self;
        [self.view addSubview:_couponeAlert];
        [_couponeAlert mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    return _couponeAlert;
}
- (UIImageView *)toTopImage{
    if (_toTopImage == nil) {
        _toTopImage = [[UIImageView alloc]initWithFrame:CGRectMake(XYScreenWidth-65, XYScreenHeight-XYTabBarHeight-60, 47, 47)];
        _toTopImage.image = IMAGE(@"hddb");
        @weakify(self);
        [_toTopImage addJXTouch:^{
            @strongify(self);
            [self.jm_collectionview setContentOffset:(CGPointZero) animated:YES];
        }];
        
        _toTopImage.userInteractionEnabled = YES;
        _toTopImage.hidden = YES;
    }
    return _toTopImage;
}
- (void)setInvitedText:(NSString *)invitedText{
    NSString* tmp = _invitedText?:@"";
    _invitedText = invitedText;
    _invitedTextLabel.text = _invitedText;
    [_invitedTextView layoutIfNeeded];
    if (![tmp isEqualToString:_invitedText]) {
        [self show];
    }
    
}

#pragma mark  返回按钮
- (FNCustomeNavigationBar *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [FNCustomeNavigationBar customeNavigationBarWithCustomeView:self.titleview];
        _navigationView.backgroundColor = [UIColor clearColor];
        UIButton* backbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backbtn setImage:IMAGE(@"detail_return") forState:(UIControlStateNormal)];
        [backbtn addTarget:self action:@selector(backbtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [backbtn sizeToFit];
        _navigationView.leftButton = backbtn;
    }
    return _navigationView;
}


- (JMTitleScrollView *)titleview{
    if (_titleview == nil) {
        _titleview = [[JMTitleScrollView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth-80, 40)) titleArray:@[@"宝贝",@"详情",@"推荐"] fontSize:14 _textLength:3 andButtonSpacing:10 type:StableType];
        _titleview.alpha = 0;
        _titleview.backgroundColor = [UIColor clearColor];
        _titleview.tDelegate = self;
        _titleview.contentSize = CGSizeMake((14*3+10)*3, 44);
        _titleview.titleArray =@[@"宝贝",@"详情",@"推荐"];
        _titleview.alwaysBounceVertical = NO;
        [_titleview setBottomViewAtIndex:0];
    }
    return _titleview;
}

- (NSMutableArray *)products
{
    if (_products == nil) {
        _products = [NSMutableArray new];
    }
    return _products ;
}
- (FNNewProductDetailHeader *)header{
    if (_header == nil) {
        _header = [[FNNewProductDetailHeader alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 0))];
        @weakify(self);
        _header.shopClicked = ^{
            @strongify(self);
            if ([self.model.store_jump_url kr_isNotEmpty]) {
                [self goWebWithUrl:self.model.store_jump_url];
            } else {
                FNDetailShopController* shop = [FNDetailShopController new];
                shop.fnuo_id = self.model.fnuo_id;
                shop.model=self.model.dpArr;
                shop.f_shopurl =self.FNshopUrl;
                if ([self.FNshopUrl containsString:@"m.tmall.com"] || [self.FNshopUrl containsString:@"m.taobao.com"]) {
                    [self.navigationController pushViewController:shop animated:YES];
                }else{
                    //[FNTipsView showTips:@"请重试"];
                    [SVProgressHUD show];
                    [self.shopwebView reload];
                    [self performSelector:@selector(pushShopUrl) withObject:nil afterDelay:5.0];
                    
                }
            }
            
        };
        _header.getCouponClicked = ^{
            @strongify(self);
            if ([NSString isEmpty:UserAccessToken]) {
                if ([FNBaseSettingModel settingInstance].is_need_login.boolValue) {
                    [self warnToLogin];
                    return;
                }
            }
            
            [self judgeNeedPay];
        };
        _header.shareClicked = ^{
            @strongify(self);
            if([self.model.fnuo_id kr_isNotEmpty]){
                [self shareProductWithModel:self.model];
            }
        };
        _header.CopyClicked = ^{
            @strongify(self);
            [FNTipsView showTips:@"复制成功"];
            [[UIPasteboard generalPasteboard] setString:self.model.goods_description];
        };
        _header.upgradeClicked = ^{
            @strongify(self);
            [self loadMembershipUpgradeViewController];
        };
        _header.productClicked = ^(FNBaseProductModel *model) {
            @strongify(self);
            [self goProductVCWithModel:model];
        };
        _header.CommentClicked = ^{
            @strongify(self);
            [self goWebWithUrl:self.model.comment.url];
        };
        _header.bannerClicked = ^(UIImageView *imageview, NSInteger index) {
//            index -= 250;
            @strongify(self);
            MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
            // 弹出相册时显示的第一张图片是点击的图片
            browser.currentPhotoIndex = index;
            NSMutableArray *photos = [NSMutableArray array];
            NSArray *imgs = self.model.imgArr;
            [imgs enumerateObjectsUsingBlock:^(id  _Nonnull sobj, NSUInteger idx, BOOL * _Nonnull stop) {
                MJPhoto *mjPhoto = [[MJPhoto alloc] init];
                
                mjPhoto.url = [NSURL URLWithString:sobj];
                
                mjPhoto.srcImageView = imageview;
                
                [photos addObject:mjPhoto];
            }];
            
            // 设置所有的图片。photos是一个包含所有图片的数组。
            browser.photos = photos;
            [browser show];
        };
        _header.PlayClicked = ^{
            @strongify(self);
        };
        _header.CommentImageClicked = ^(UIImageView *imageview, NSInteger index) {
            @strongify(self);
            MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
            // 弹出相册时显示的第一张图片是点击的图片
            browser.currentPhotoIndex = index;
            NSMutableArray *photos = [NSMutableArray array];
            NSArray *imgs = self.model.comment.rateList.images;
            [imgs enumerateObjectsUsingBlock:^(id  _Nonnull sobj, NSUInteger idx, BOOL * _Nonnull stop) {
                MJPhoto *mjPhoto = [[MJPhoto alloc] init];
                
                mjPhoto.url = [NSURL URLWithString:sobj];
                
                mjPhoto.srcImageView = imageview;
                
                [photos addObject:mjPhoto];
            }];
            
            // 设置所有的图片。photos是一个包含所有图片的数组。
            browser.photos = photos;
            [browser show];
        };
    }
    return _header;
}
- (FNDetailBottomView *)bottomview{
    if (_bottomview == nil) {
        _bottomview = [[FNDetailBottomView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 50))];
//        _bottomview.alpha = 0;
        _bottomview.isSearch = self.isSearch;
        @weakify(self);
        _bottomview.btnClicked = ^(NSInteger index) {
            @strongify(self);
            if (index == 4) {//to bai chun
                
                if ([NSString isEmpty:UserAccessToken]) {
                    if ([FNBaseSettingModel settingInstance].is_need_login.boolValue) {
                        [self warnToLogin];
                        return;
                    }
                }
                
                [self judgeNeedPay];
                
            }else if (index == 3){//to bai chun
                  if ([FNBaseSettingModel settingInstance].all_fx_onoff.boolValue) {
                      if([self.model.fnuo_id kr_isNotEmpty]){
                          [self shareProductWithModel:self.model];
                      }
                  }else{
                      [self loadMembershipUpgradeViewController];
                  }
            }else if (index == 1){//to shop
                if ([self.model.store_jump_url kr_isNotEmpty]) {
                    [self goWebWithUrl:self.model.store_jump_url];
                } else {
                    FNDetailShopController* shop = [FNDetailShopController new];
                    shop.fnuo_id = self.model.fnuo_id;
                    shop.model=self.model.dpArr;
                    shop.f_shopurl =self.FNshopUrl;
                    if ([self.FNshopUrl containsString:@"m.tmall.com"] || [self.FNshopUrl containsString:@"m.taobao.com"]) {
                        [self.navigationController pushViewController:shop animated:YES];
                    }else{
                        [FNTipsView showTips:@"正在获取店铺商品，请稍后再试"];
                    }
                }
                
            }else if (index == 2){//go share
                if([self.model.fnuo_id kr_isNotEmpty]){
                    [self shareProductWithModel:self.model];
                }
            }else if (index == 0){
                XYLog(@"收藏");
            }
        };
    }
    return _bottomview;
}

-(void)judgeNeedPay{
    
    if (self.model.is_need_exchange == 1 && self.model.coupon_exchange != nil) {
        [self.couponeAlert show: self.model.coupon_exchange];
    } else {
        [self judgeCoupone];
    }
    
}

- (void) judgeCoupone {
    if ([FNCurrentVersion isEqualToString:Setting_checkVersion]) {
        FNBaseProductModel *product = [FNBaseProductModel mj_objectWithKeyValues:self.data];
        if ([self.SkipUIIdentifier isEqualToString:@"buy_pinduoduo"]) {
            [self goToPddProductDetailsWithModel:product];
        }else if ([self.SkipUIIdentifier isEqualToString:@"buy_jingdong"]){
            [self goToJDProductDetailsWithModel:product];
        }else if ([self.SkipUIIdentifier isEqualToString:@"pub_wph_goods"]){
            [self goToWphProductDetailsWithModel:self.model];
        }else{
            [self goToProductDetailsWithModel:product];
        }
        return;
    }
    
    if (self.model) {
        
        [self requestCoupon];
        if ([self.SkipUIIdentifier isEqualToString:@"buy_pinduoduo"]) {
            [self goToPddProductDetailsWithModel:self.model];
        }else if ([self.SkipUIIdentifier isEqualToString:@"buy_jingdong"]){
            [self goToJDProductDetailsWithModel:self.model];
        }else if ([self.SkipUIIdentifier isEqualToString:@"pub_wph_goods"]){
            [self goToWphProductDetailsWithModel:self.model];
        }else{
            [self goToProductDetailsWithModel:self.model];
        }
    }
}

- (void)dealloc
{
    [NSNotificationCenter.defaultCenter removeObserver:self];
    [_timer invalidate];
    _timer = nil;
}

- (void)updateTime {
    if (self.lq_list.count <= 0) {
        return ;
    }
    NSDictionary *obj = self.lq_list[_lq_index];
    NSString *other = obj[@"str"];
//    if (other.length != 0) {
//        self.invitedText = other;
//    }else{
//        if (self.invitedText.length != 0) {
//            [self show];
//        }
//    }
    self.invitedText = other;
//    [self show];
    _lq_index = (_lq_index + 1) % self.lq_list.count;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(onAuth) name:@"UserDidAuth" object:nil];
    
    
    if (_data) {
        FNNewProductDetailModel *detail = [FNNewProductDetailModel mj_objectWithKeyValues:_data];
        self.header.model = detail;
        self.bottomview.model = detail;
    }
    
    [self requestMain: NO];
   
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.header stopPlaying];
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)jm_setupViews{
    
    [self.view addSubview:self.navigationView];
    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:JMNavBarHeigth];
    
    [self.view addSubview:self.bottomview];
//    [self.bottomview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
//    [self.bottomview autoSetDimension:(ALDimensionHeight) toSize:self.bottomview.height];
    [self.bottomview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0).offset(isIphoneX ? -34 : 0);
        make.height.mas_equalTo(self.bottomview.height);
    }];
    
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.headerReferenceSize = CGSizeMake(JMScreenWidth, 100);
    
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 0)) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor = FNHomeBackgroundColor;
//    self.jm_collectionview.alpha = 0;
    self.jm_collectionview.dataSource =self;
    self.jm_collectionview.delegate =self;
    self.jm_collectionview.emptyDataSetSource = nil;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNHomeSpecialCCell class] forCellWithReuseIdentifier:@"FNHomeSpecialCCell"];
    [self.jm_collectionview registerClass:[FNNPDImgCell class] forCellWithReuseIdentifier:@"FNNPDImgCell"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"topheader"];
    [self.jm_collectionview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.jm_collectionview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:self.bottomview];
    
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view bringSubviewToFront:self.navigationView];
    [self setUpInvitedView];
    
    [self.view addSubview:self.toTopImage];
    [self.toTopImage autoSetDimensionsToSize:self.toTopImage.size];
    [self.toTopImage autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_leftMargin];
    [self.toTopImage autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:self.bottomview withOffset:-_jmsize_10*2];
    [self.view addSubview: self.tool];
}
- (void)setUpInvitedView{
    _invitedTextView = [UIView new];
    _invitedTextView.cornerRadius = _jm_detail_invitedHeight*0.5;
    _invitedTextView.backgroundColor = [UIColor clearColor];
    _invitedTextView.hidden = YES;
    [self.view addSubview:_invitedTextView];
    
    [_invitedTextView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:_jm_leftMargin+JMNavBarHeigth];
    [_invitedTextView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_leftMargin];
    [_invitedTextView autoSetDimension:(ALDimensionHeight) toSize:_jm_detail_invitedHeight];
    [_invitedTextView autoSetDimension:(ALDimensionWidth) toSize:FNDeviceWidth-_jm_leftMargin*2];
    
    UIImageView* imgView = [UIImageView new];
    imgView.image = IMAGE(@"invite_people_head");
    imgView.cornerRadius = _jm_detail_invitedHeight *0.5;
    [_invitedTextView addSubview:imgView];
    
    [imgView autoSetDimensionsToSize:(CGSizeMake(_jm_detail_invitedHeight, _jm_detail_invitedHeight))];
    [imgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [imgView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    _invitedTextLabel = [UILabel new];
    _invitedTextLabel.font = kFONT14;
    _invitedTextLabel.textColor  =FNWhiteColor;
    [_invitedTextView addSubview:_invitedTextLabel];
    [_invitedTextLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:imgView withOffset:_jm_margin10];
    [_invitedTextLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_invitedTextLabel autoSetDimension:(ALDimensionWidth) toSize:FNDeviceWidth-(_jm_detail_invitedHeight*1.5+10+_jm_leftMargin) relation:(NSLayoutRelationLessThanOrEqual)] ;
    
    UIView* bgview = [UIView new];
    bgview.cornerRadius = _jm_detail_invitedHeight*0.5;
    bgview.backgroundColor = [FNBlackColor colorWithAlphaComponent:0.4];
    [_invitedTextView insertSubview:bgview atIndex:0];
    
    [bgview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [bgview autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
    [bgview autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];
    [bgview autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:_invitedTextLabel withOffset:_jm_detail_invitedHeight*0.5];
    
    
}
-(void)pushShopUrl{
    [SVProgressHUD dismiss];
    if([self.FNshopUrl kr_isNotEmpty]){
        FNDetailShopController* shop = [FNDetailShopController new];
        shop.fnuo_id = self.model.fnuo_id;
        shop.model=self.model.dpArr;
        shop.f_shopurl =self.FNshopUrl;
        [self.navigationController pushViewController:shop animated:YES];
    }else{
        [self performSelector:@selector(Addtautology) withObject:nil afterDelay:1.0];
    }
    
}
-(void)Addtautology{
    [FNTipsView showTips:@"正在获取数据，请稍后再试"];
}

#pragma mark - action
- (void)backbtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - show or hide invited view
-(void)show{
    
    @synchronized(self){
        _invitedTextView.x = -FNDeviceWidth;
        _invitedTextView.hidden = NO;
        @WeakObj(self);
        [UIView animateWithDuration:IMGDuration animations:^{
            selfWeak.invitedTextView.x =  _jm_leftMargin;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:IMGDuration delay:3.0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
                selfWeak.invitedTextView.x = -FNDeviceWidth;
            } completion:^(BOOL finished) {
                selfWeak.invitedTextView.hidden = YES;
            }];
        }];
    };
    
}
#pragma mark - collection data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return section == 0 ?self.model.images.count:self.products.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FNNPDImgCell* cell = [FNNPDImgCell cellWithCollectionView:collectionView atIndexPath:indexPath];
//        cell.image = self.model.detailArr[indexPath.item];
//        cell.image = self.model.detailArr[indexPath.item];
        [cell configImage: self.model.images[indexPath.item]];
        cell.imageClicked = ^(UIImageView *imgview,NSIndexPath *sender) {
            MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
            // 弹出相册时显示的第一张图片是点击的图片
            browser.currentPhotoIndex = sender.item;
            NSMutableArray *photos = [NSMutableArray array];
            NSArray *imgs = self.model.detailArr;
            [imgs enumerateObjectsUsingBlock:^(id  _Nonnull sobj, NSUInteger idx, BOOL * _Nonnull stop) {
                MJPhoto *mjPhoto = [[MJPhoto alloc] init];
                
                mjPhoto.url = [NSURL URLWithString:sobj];
              
                mjPhoto.srcImageView = imgview;
                
                [photos addObject:mjPhoto];
            }];
            
            // 设置所有的图片。photos是一个包含所有图片的数组。
            browser.photos = photos;
            [browser show];
        };
        return cell;
    }else{
        FNHomeSpecialCCell* cell = [FNHomeSpecialCCell cellWithCollectionView:collectionView atIndexPath:indexPath];
        cell.model = self.products[indexPath.item];
        return cell;
        
    }
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView* reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"topheader" forIndexPath:indexPath];
    if (reusableview.subviews.count>=1) {
        [reusableview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    if (indexPath.section == 0) {
        [reusableview addSubview:self.header];
        
        UIView* header = [[UIView alloc]initWithFrame:(CGRectMake(0, self.header.height+10, JMScreenWidth, 40))];
        header.backgroundColor = FNWhiteColor;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 2, 14)];
        line.backgroundColor = RGB(255, 0, 54);
        [header addSubview:line];
        
        UILabel* titlelabel = [[UILabel alloc]initWithFrame: CGRectMake(20, 10, JMScreenWidth - 40, 14)];
        titlelabel.font = kFONT14;
        titlelabel.text = @"宝贝详情";
        [header addSubview:titlelabel];
//        [titlelabel autoCenterInSuperview];
        [reusableview addSubview:header];
        if (self.model.detailArr.count==0){
            header.hidden=YES;
        }else{
            header.hidden=NO;
        }
    }else{
        UIView* header = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, 40))];
        header.backgroundColor = FNWhiteColor;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 2, 14)];
        line.backgroundColor = RGB(255, 0, 54);
        [header addSubview:line];
        UILabel* titlelabel = [[UILabel alloc]initWithFrame: CGRectMake(20, 10, JMScreenWidth - 40, 14)];
        titlelabel.font = [UIFont boldSystemFontOfSize:14];
        titlelabel.text = @"精品推荐";
        [header addSubview:titlelabel];
//        [titlelabel autoCenterInSuperview];
        [reusableview addSubview:header];
        
    }
    
    
    return reusableview;
}
#pragma mark - collection flowlayout delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    CGFloat oneHeight=self.header.height+44;
    if (self.model.detailArr.count==0){
        oneHeight=self.header.height+10;
    }
    return section == 0 ?  CGSizeMake(self.header.width, oneHeight) :CGSizeMake(JMScreenWidth, 34);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeZero;
    if (indexPath.section == 0) {
        UIImage*img = self.model.images[indexPath.item];
        CGFloat height = 0;
        if (img && [img isKindOfClass:[UIImage class]]) {
            height = JMScreenWidth*(img.size.height/img.size.width);
        }else{
            height = 0;
        }
        size = CGSizeMake(JMScreenWidth, height);
    }else{
        CGFloat width = (JMScreenWidth-15)*0.5;
        CGFloat height = width+ _hscc_btm_h + 34 +30;
        size = CGSizeMake(width, height);
    }
    
    return size;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if (section == 0) {
        insets = UIEdgeInsetsMake(0, 0, 10, 0);
    }else{
        insets = UIEdgeInsetsMake(0, 5, 5, 5);
    }
        
    
    return insets;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 5;
    }
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 5;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        [self goProductVCWithModel:self.products[indexPath.item]];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    if (conY>=self.navigationView.height && conY<= 2*self.navigationView.height) {
        CGFloat alpha = (conY-self.navigationView.height)/self.navigationView.height;
        self.navigationView.backgroundColor = [FNWhiteColor colorWithAlphaComponent:alpha];
        self.titleview.alpha = alpha;
    }else if (conY >= self.navigationView.height*2){
        self.navigationView.backgroundColor = [FNWhiteColor colorWithAlphaComponent:1];
        self.titleview.alpha = 1;
    }else{
        self.navigationView.backgroundColor = [FNWhiteColor colorWithAlphaComponent:0];
        self.titleview.alpha = 0;
    }
    
    if ( conY>=(self.header.height+44+self.model.imgH-self.navigationView.height )) {
        [self.titleview setBottomViewAtIndex:2];
    }else if(conY>=self.header.height+10-self.navigationView.height && conY<(self.header.height+44+self.model.imgH -self.navigationView.height)){
        [self.titleview setBottomViewAtIndex:1];
    }else{
        [self.titleview setBottomViewAtIndex:0];
    }
    
    if (conY>=JMScreenHeight) {
        self.toTopImage.hidden = NO;
    }else{
        self.toTopImage.hidden = YES;
    }
}


#pragma mark - JMTitleScrollViewDelegate
- (void)clickedTitleView:(JMTitleScrollView *)titleView atIndex:(NSInteger)index{
  
    if (index == 0) {
        [self.jm_collectionview setContentOffset:(CGPointZero) animated:YES];
    }else if (index == 1){
        [self.jm_collectionview setContentOffset:(CGPointMake(0, self.header.height+10-self.navigationView.height)) animated:YES];
    }else{
        [self.jm_collectionview setContentOffset:(CGPointMake(0, self.header.height+44+self.model.imgH-self.navigationView.height+10)) animated:YES];
    }
}

#pragma mark - Notification
//授权后通知更新商品优惠券信息，防止丢单
- (void)onAuth {
    [SVProgressHUD show];
    [self requestMain: NO];
}

#pragma mark - request
- (void)requestMain: (BOOL)isCache{
    
//    [SVProgressHUD show];
    [FNRequestTool startWithRequests:@[[self requestDetail: isCache],[self requestProduct:isCache]] withFinishedBlock:^(NSArray *erros) {
        [self.jm_collectionview reloadData];
        [SVProgressHUD dismiss];
        [self apiRequestTop];
    }];
}

- (FNRequestTool *)requestComment {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"fnuo_id":_fnuo_id}];
    @weakify(self)
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=goods_comment&ctrl=index" respondType:(ResponseTypeModel) modelType:@"FNNewProductCommentModel" success:^(id respondsObject) {
        self.model.comment = respondsObject;
        self.header.model = self.model;
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        
    } isHideTips:NO];
}

- (FNRequestTool *)requestDetail: (BOOL)isCache{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    NSString *APIUrl=@"mod=appapi&act=newgoods_detail&ctrl=index";
    if ([self.SkipUIIdentifier isEqualToString:@"buy_pinduoduo"]) {
        APIUrl=@"mod=appapi&act=appPddGoodsDetail&ctrl=pddIndex";
    }else if ([self.SkipUIIdentifier isEqualToString:@"buy_jingdong"]){
        APIUrl=@"mod=appapi&act=appJdGoodsDetail&ctrl=jdIndex";
        params[@"yhq_url"] = self.yhqUrl;
    }else if ([self.SkipUIIdentifier isEqualToString:@"pub_wph_goods"]) {
        APIUrl=@"mod=appapi&act=wph_detail&ctrl=index";
    }
    if (self.fnuo_id) {
        params[@"fnuo_id"] = self.fnuo_id;
    }
    if (self.goods_title) {
        params[@"goods_title"] = self.goods_title;
    }
    if (self.getGoodsType) {
        params[@"getGoodsType"] = self.getGoodsType;
    }
    
    if (_isLive) {
        params[@"is_live"] = @(YES);
    }
    if (self.data) {
        NSError *error = nil;
        NSData * JSONData = [NSJSONSerialization dataWithJSONObject:self.data options:kNilOptions error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
//        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        XYLog(@"detailModel is %@",jsonString);
    
        params[@"data"] = jsonString;
    }
    
    @weakify(self)
    return [FNRequestTool requestWithParams:params api:APIUrl respondType:(ResponseTypeModel) modelType:@"FNNewProductDetailModel" success:^(id respondsObject) {
        @strongify(self)
        self.model = respondsObject;
        self.model.data = self.data;
        self.header.model = respondsObject;
        
        self.bottomview.model = respondsObject;
        if ([self.model.html_detail_img_url kr_isNotEmpty]) {
            @weakify(self)
            [self.tool loadUrl: self.model.html_detail_img_url block: ^(NSArray<NSString*> *images) {
                @strongify(self)
                
                self.model.detailArr=images;
                if (self.model.detailArr.count>=1) {
                    [self.model.images removeAllObjects];
                    self.model.imgH = 0;
                }
                NSMutableArray *imageUrls = [[NSMutableArray alloc] init];
                NSMutableArray* results = [NSMutableArray arrayWithArray:self.model.detailArr];
                @weakify(self)
                [XYNetworkAPI downloadImages:results withIndexBlock:^(UIImage *img, NSInteger index) {
                    @strongify(self)
                    if (img.size.width > 10 && img.size.height > 10) {
                        CGFloat height = img?JMScreenWidth*(img.size.height/img.size.width):0;
                        [imageUrls addObject: self.model.detailArr[index]];
                        self.model.imgH+=height ;
                        [self.model.images addObject:img];
                        if (index == results.count - 1) {
                            self.model.detailArr = imageUrls;
                            [self.jm_collectionview reloadData];
                        }
                    }
                } failureBlock:^(NSError *error) {
                    [self.jm_collectionview reloadData];
                }];
            }];
        } else {
            [self requestProductDetailImg];
        }

        [self.jm_collectionview reloadData];
        [SVProgressHUD dismiss];
        [self requestComment];
        [self webShopURL];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache:isCache];
}
- (FNRequestTool *)requestProduct:(BOOL)ishide{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,PageNumber:@(self.jm_page),PageSize:@"20",@"is_index":@"0"}];
    if([self.SkipUIIdentifier kr_isNotEmpty]){
        params[@"SkipUIIdentifier"]=self.SkipUIIdentifier;
    }
    if([self.goods_title kr_isNotEmpty]){
        params[@"goods_title"]=self.goods_title;
    }
    if([self.fnuo_id kr_isNotEmpty]){
        params[@"fnuo_id"]=self.fnuo_id;
    }
    return  [FNRequestTool requestWithParams:params api:_api_home_recommendproduct respondType:(ResponseTypeArray) modelType:@"FNBaseProductModel" success:^(NSArray* respondsObject) {
        //
        if (self.jm_page == 1) {
            [self.products removeAllObjects];
            [self.products addObjectsFromArray:respondsObject];
        }
        if (!ishide) {
            [self.jm_collectionview reloadData];
        }
    } failure:^(NSString *error) {
        //
        [self.jm_collectionview reloadData];
    } isHideTips:ishide];
}
- (FNRequestTool *)requestCoupon{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"fnuo_id":self.fnuo_id}];
    if (_isLive) {
        params[@"is_live"] = @(YES);
    }
    
    return  [FNRequestTool requestWithParams:params api:@"mod=appapi&act=newgoods_detail&ctrl=click_yhq" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
}
- (FNRequestTool *)requestExchangeCoupon: (NSString*)ID SkipUIIdentifier: (NSString*)SkipUIIdentifier yhq_price: (NSString*)yhq_price{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"fnuo_id":ID, @"SkipUIIdentifier": SkipUIIdentifier, @"yhq_price": yhq_price}];
    @weakify(self)
    return  [FNRequestTool requestWithParams:params api:@"mod=appapi&act=coupon_exchange&ctrl=doing" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        [self judgeCoupone];
        [self.couponeAlert dismiss];
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}

- (FNRequestTool *)requestProductDetailImg{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"fnuo_id":self.fnuo_id,@"pdd":@"0",@"jd":@"0",@"wph":@"0"}];
    
//    if ([self.dataDict isKindOfClass:[FNBaseProductModel class]]) {
//        params[@"shop_id"]=((FNBaseProductModel*)self.dataDict).shop_id;
//    }
    params[@"shop_id"] = self.model.shop_id;
//    if ([[self.dataDict valueForKey:@"shop_id"] kr_isNotEmpty]){
//        params[@"shop_id"]=[self.dataDict valueForKey:@"shop_id"];
//    }
    if ([self.SkipUIIdentifier isEqualToString:@"buy_pinduoduo"]) {
        params[@"pdd"] = @"1";
    }
    if ([self.SkipUIIdentifier isEqualToString:@"buy_jingdong"]){
        params[@"jd"] = @"1";
    }
    if ([self.SkipUIIdentifier isEqualToString:@"pub_wph_goods"]){
        params[@"wph"] = @"1";
    }
    @weakify(self)
    return  [FNRequestTool requestWithParams:params api:@"mod=appapi&act=goods_detail_img&ctrl=index" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
       NSLog(@"DetailImg:%@",respondsObject);
        
        NSDictionary* dictry = respondsObject[DataKey];
        self.model.detailArr=dictry[@"detailArr"];
        if (self.model.detailArr.count>=1) {
            [self.model.images removeAllObjects];
            self.model.imgH = 0;
        }
        NSMutableArray* results = [NSMutableArray arrayWithArray:self.model.detailArr];
        [XYNetworkAPI downloadImages:results withIndexBlock:^(UIImage *img, NSInteger index) {
            
            CGFloat height = img?JMScreenWidth*(img.size.height/img.size.width):0;
            self.model.imgH+=height ;
            [self.model.images addObject:img];
            if (index == results.count - 1) {
                [self.jm_collectionview reloadData];
            }
        } failureBlock:^(NSError *error) {
            [self.jm_collectionview reloadData];
        }];
        
    } failure:^(NSString *error) {
        
    } isHideTips:NO];
}



- (FNRequestTool *)apiRequestTop{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"fnuo_id":self.fnuo_id}];
    @WeakObj(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=newgoods_detail&ctrl=lq_list" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        
        self.lq_list = respondsObject;
        
        [self updateTime];
        [self.timer invalidate];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
        
        //
//        if ([respondsObject isKindOfClass:[NSDictionary class]]) {
//            NSString *other = respondsObject[@"str"];
//            if (other.length != 0) {
//                selfWeak.invitedText = respondsObject[@"str"];
//            }else{
//                if (selfWeak.invitedText.length != 0) {
//                    [selfWeak show];
//                }
//
//            }
//        }
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
    
//    __weak typeof(self) weakSelf = self;
//    double delayInSeconds = 10;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        [weakSelf apiRequestTop];
//    });
    
}
-(void)webShopURL{
    self.shopwebView = [[UIWebView alloc]initWithFrame:CGRectZero];
    self.shopwebView.scrollView.scrollEnabled=YES;
    self.shopwebView.backgroundColor = [UIColor clearColor];
    self.shopwebView.delegate = self;
    [self.view addSubview:self.shopwebView];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.model.dpArr.shop_url]];
    [self.shopwebView loadRequest:request];
}
#pragma mark -UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    _FNshopUrl=webView.request.URL.absoluteString;
    XYLog(@"shopUrl:%@",_FNshopUrl);
    XYLog(@"absoluteString:%@",webView.request.URL.absoluteString);
    if ([_FNshopUrl containsString:@"m.tmall.com"] ) {
        
        return NO;
    }
    else if ([_FNshopUrl containsString:@"m.taobao.com"] ) {
        
        return NO;
        
    }
    
    return [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
}

#pragma mark - FNNewProDetailCouponeAlertViewDelegate

- (void)didBuyClick{
//    [self judgeCoupone];
    [self requestExchangeCoupon: self.model.fnuo_id SkipUIIdentifier: self.model.coupon_exchange.SkipUIIdentifier yhq_price:self.model.yhq_price];
}
- (void)didCancleClick{
    [self.couponeAlert dismiss];
}
- (void)didRechargeClick{
    FNNetCouponeExchangeController *vc = [[FNNetCouponeExchangeController alloc] init];
    [self.navigationController pushViewController:vc animated: YES];
}

@end
