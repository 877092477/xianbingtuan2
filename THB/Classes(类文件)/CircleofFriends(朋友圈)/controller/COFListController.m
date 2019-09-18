//
//  COFListController.m
//  THB
//
//  Created by Jimmy on 2018/8/22.
//  Copyright © 2018年 方诺科技. All rights reserved.
//   后续爆款分享
//朋友圈
#import "COFListController.h"
#import "FNNewProDetailController.h"
#import "COFPublishListController.h"     //单个首页
#import "COFAddInformationController.h"  //发布信息
#import "COFsingleDetailsController.h"   //详情
#import "FNMembershipUpgradeViewController.h"

#import "CircleOfFriendsCell.h"
#import "CireleImageBtn.h"
#import "FNCustomeNavigationBar.h"
#import "FDSlideBar.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "COFshareView.h"

#import "SDCycleScrollView/SDCycleScrollView.h"
#import "CircleOfFriendsModel.h"
#import "CircleOfFriendsFrame.h"
#import "FNShareMutiplyViewModel.h"
#import "CoShareItem.h"
#import "CircleOfFriendsBannerModel.h"
#import "CircleOfFriendsShopHeaderView.h"
#import "CircleOfFriendProductCell.h"
#import "HXPhotoTools.h"
#import "JhScrollActionSheetView.h"
#import "JhPageItemModel.h"

#import <WebKit/WebKit.h>

//mod=appapi&act=circleOfFriends&ctrl=shareFriendCircle

@interface COFListController ()<UITableViewDelegate,UITableViewDataSource,COFshareViewDelegate,UIWebViewDelegate, CircleOfFriendsShopHeaderViewDelegate, CircleOfFriendProductCellDelegate, SDCycleScrollViewDelegate, UIGestureRecognizerDelegate>

//**  导航 **//
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;

//**  添加按钮 **//
@property (nonatomic, strong)UIButton* AddBtn;

//**  分栏视图 **//
@property (nonatomic, strong)UIView* classifyView;

//** 分栏内容 **//
@property (nonatomic, strong)FDSlideBar *slideBar;

//** TableView **//
@property (nonatomic, strong)UITableView* commodityView;

//** 分类model数组 **//
@property(nonatomic ,strong) NSMutableArray* sortArray;

@property (nonatomic, strong) NSArray<CircleOfFriendsBannerModel*> *banners;
@property (nonatomic, strong) NSArray<StoreModel*> *stores;
@property (nonatomic, strong) NSMutableArray<CircleOfFriendsProductModel*> *products;

//** 分类数组 **//
//@property(nonatomic ,strong) NSMutableArray* classifyArr;

//** 选择的分类 **//
@property(nonatomic ,strong) NSString* selectionSort;

//** 选择的商店类型 **//
@property(nonatomic, assign) NSInteger selectionStore;

//** 选中的信息条(单条产品) ID **//
@property(nonatomic ,strong) NSString* productID;

//** 分享的数组 **//
@property(nonatomic ,strong) NSMutableArray *shareimageViewArr;

//** 分享的数组 **//
@property(nonatomic ,strong) UIImageView *shareimage;

//** H5地址 **//
@property(nonatomic ,strong) NSString* js_urlString;

@property(nonatomic ,strong) UIWebView* webInteractionView;

@property (nonatomic, strong) SDCycleScrollView *headerView;

@property (atomic, assign) int count;

@property (nonatomic, copy) NSString *SkipUIIdentifier;

@property (nonatomic, assign) BOOL isSingle;
@property (nonatomic, assign) UMSocialPlatformType shareType;

@end

@implementation COFListController

{
    NSInteger ColumnSelectIndex;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    if(self.understand==YES){
//       self.tabBarController.tabBar.hidden = YES;
//    }
    [self.jm_tableview reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectionSort=@"";
    self.view.backgroundColor=FNColor(246, 246, 246);
    self.products = [[NSMutableArray alloc] init];
    
    [self apiRequestSort];
    [self ofNavigationView];
    [self subfieldView];
    [self commodityTableView];
    [self configHeader:@[]];
    [self addGesture];
   
//    self.shareimage=[[UIImageView alloc]init];
//    self.shareimage.hidden=YES;
//    self.shareimage.frame=CGRectMake(10, 100, 150, 300);
//    [self.view addSubview:self.shareimage];
//    [self.view bringSubviewToFront:self.shareimage];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(onAuth) name:@"UserDidAuth" object:nil];
   
}
- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}


- (void)onAuth {
    self.jm_page = 1;
    [self apiRequestProduct];
}

#pragma mark - 导航
- (void)ofNavigationView{
     self.automaticallyAdjustsScrollViewInsets = NO;
    _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@"圈子"];
    _navigationView.backgroundColor=FNWhiteColor;
    _AddBtn = [UIButton buttonWithTitle:@"" titleColor:FNWhiteColor font:kFONT12 target:self action:@selector(AddBtnAction)];
    [_AddBtn setImage:IMAGE(@"circle_add") forState:(UIControlStateNormal)];
    [_AddBtn setTitle:@" " forState:(UIControlStateSelected)];
    [_AddBtn sizeToFit];
    _AddBtn.size = CGSizeMake(20, 20);
    _AddBtn.borderColor = FNWhiteColor;
    _navigationView.rightButton = _AddBtn;
    _navigationView.titleLabel.textColor=[UIColor blackColor];
    if(self.understand==NO){
       UIButton*_backBtn = [UIButton buttonWithTitle:@"" titleColor:FNWhiteColor font:kFONT12 target:self action:@selector(backBtnAction)];
       [_backBtn setImage:IMAGE(@"return") forState:(UIControlStateNormal)];
       [_backBtn sizeToFit];
       _backBtn.size = CGSizeMake(20, 20);
       _backBtn.borderColor = FNWhiteColor;
       _navigationView.leftButton = _backBtn;
    }
   
    [self.view addSubview:self.navigationView];
}
#pragma mark - 分类
-(void)subfieldView{
    
    //分栏模块
    _classifyView=[[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, 40)];
    _classifyView.backgroundColor=FNWhiteColor;
    [self.view addSubview:_classifyView];
    
    _slideBar = [[FDSlideBar alloc] initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 40)];
    _slideBar.backgroundColor = FNWhiteColor;
    _slideBar.is_middle=YES;
    
    [_classifyView addSubview:_slideBar];
    [_slideBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.left.right.bottom.equalTo(@0);
    }];
    
    @weakify(self);
    [_slideBar slideBarItemSelectedCallback:^(NSUInteger index) {
        @strongify(self);
        XYLog(@"类型:%lu",(unsigned long)index);
        CircleTypeModel *type=self.sortArray[index];
        NSString *name=type.name;
        XYLog(@"name:%@",name);
        self.jm_page = 1;
        self.selectionSort=type.SkipUIIdentifier;
        
        self.SkipUIIdentifier = type.SkipUIIdentifier;
        [self apiRequestShopType];
//        [self apiRequestProduct];
       
    }];
    
     [_slideBar selectSlideBarItemAtIndex:0];
    
}

- (void)addGesture {
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
       initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.delegate = self;
    lpgr.delaysTouchesBegan = YES;
    [self.jm_tableview addGestureRecognizer:lpgr];
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    
    @weakify(self)
    [self authShare: ^(BOOL isAuthed) {
        @strongify(self)
        if (!isAuthed) {
            return;
        }
        CGPoint p = [gestureRecognizer locationInView:self.jm_tableview];
        
        NSIndexPath *indexPath = [self.jm_tableview indexPathForRowAtPoint:p];
        if (indexPath == nil){
        } else {
            CircleOfFriendsProductModel *model = self.products[indexPath.row];
            [FNTipsView showTips:@"复制成功"];
            [[UIPasteboard generalPasteboard] setString:model.content];
        }
        
    }];
}

#pragma mark - 单元
-(void)commodityTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat tableHeight=FNDeviceHeight-XYTabBarHeight-SafeAreaTopHeight-50;
    if(self.understand==NO){
        tableHeight=FNDeviceHeight-SafeAreaTopHeight-50;
    }
    self.jm_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+50, FNDeviceWidth, tableHeight) style:UITableViewStyleGrouped];
    self.jm_tableview.backgroundColor = RGB(245, 245, 245);
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.rowHeight = UITableViewAutomaticDimension;
    self.jm_tableview.estimatedRowHeight = 800;
    [self.jm_tableview registerClass:[CircleOfFriendProductCell class] forCellReuseIdentifier:@"CircleOfFriendProductCell"];
    [self.jm_tableview registerClass:[CircleOfFriendsShopHeaderView class] forHeaderFooterViewReuseIdentifier:@"CircleOfFriendsShopHeaderView"];
    [self.view addSubview:self.jm_tableview];
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.estimatedSectionFooterHeight = 0;
        self.jm_tableview.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }
   @weakify(self);
    self.jm_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.jm_page = 1;
        [self apiRequestProduct];

    }];
    
    self.jm_tableview.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self apiRequestProduct];
       
    }];
    
}

- (void)configHeader: (NSArray*)imageNamesGroup  {
    if (self.headerView) {
        [self.headerView removeFromSuperview];
        self.headerView = nil;
    }
    if (imageNamesGroup.count <= 0) {
        self.headerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, XYScreenWidth, 0) imageURLStringsGroup:imageNamesGroup];
        self.headerView.hidden = YES;
        return;
    }
    self.headerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, XYScreenWidth, 103) imageURLStringsGroup:imageNamesGroup];
    self.headerView.autoScrollTimeInterval = 10;
    self.jm_tableview.tableHeaderView = self.headerView;
    self.headerView.delegate = self;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
     return self.products.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    CircleOfFriendsCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CoFcell"];
//    if (cell == nil) {
//        cell = [[CircleOfFriendsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CoFcell"];
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.ProductIndexpath=indexPath;
//    CircleOfFriendsFrame *cFrame = self.dataArray[indexPath.row];
//    cell.circleFrame = cFrame;
//    [cell setChildBtnTag:indexPath.row];
//
//    cell.delegate = self;
    CircleOfFriendProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CircleOfFriendProductCell"];
    CircleOfFriendsProductModel *model = self.products[indexPath.row];
    [cell.btnHeader sd_setBackgroundImageWithURL:URL(model.head_img) forState:UIControlStateNormal completed:nil];
    cell.lblStore.text = model.nickname;
    [cell.imgStore sd_setImageWithURL:URL(model.shop_img)];
    [cell.btnSaveAlbum sd_setBackgroundImageWithURL:URL(model.btn1_img) forState:UIControlStateNormal completed:nil];
    [cell.btnShare sd_setBackgroundImageWithURL:URL(model.btn2_img) forState:UIControlStateNormal completed:nil];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [model.content length])];
    [cell.lblTitle setAttributedText:attributedString];
    //    cell.lblTitle.text = model.content;

    cell.lblTitle.textColor = [UIColor colorWithHexString:model.wenan_color];
    cell.lblTime.text = [NSString getTimeStr:model.time withFormat:@"yyyy-MM-dd HH:mm:ss"];
    if(![model.commission_str kr_isNotEmpty]){
        cell.imgCommission.hidden = YES;
    }else{
        cell.imgCommission.hidden = NO;

    }
    
    cell.lblCommission.text = model.commission_str;
    if (model.thumbs_num.integerValue >= 10000) {
        double thumbs = (model.thumbs_num.doubleValue / 10000);
        [cell.btnLike setTitle:[NSString stringWithFormat:@"%.1f万", thumbs] forState:UIControlStateNormal];
    } else {
        [cell.btnLike setTitle:model.thumbs_num forState:UIControlStateNormal];
    }
    if (model.evaluate_num.integerValue >= 10000) {
        double evaluate = (model.evaluate_num.doubleValue / 10000);
        [cell.btnCommand setTitle:[NSString stringWithFormat:@"%.1f万", evaluate] forState:UIControlStateNormal];
    } else {
        [cell.btnCommand setTitle:model.evaluate_num forState:UIControlStateNormal];
    }
    [cell setImages:model.imgData];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    NSMutableArray *urls = [[NSMutableArray alloc] init];
    for (CircleOfFriendsProductShareModel *content in model.share_content) {
        [array addObject:content.str];
        [colors addObject:[UIColor colorWithHexString:content.color]];
        [urls addObject:content.img];
    }
    [cell setCommands:array withColors:colors ButtonUrl:urls];
    cell.delegate = self;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CircleOfFriendsShopHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CircleOfFriendsShopHeaderView"];
    
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (StoreModel *model in self.stores) {
        [titles addObject:model.name];
    }
    [header setButtons: titles];
    [header setSelectedAt: self.selectionStore];
    header.delegate = self;
    return header;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.stores.count > 0 ? 44 : 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    CircleOfFriendsProductModel *commit = self.products[indexPath.row];
//
//    COFsingleDetailsController *detailsVC=[[COFsingleDetailsController alloc]init];
//    detailsVC.DetailsID=commit.ID;
//    [self.navigationController pushViewController:detailsVC animated:YES];
    
    CircleOfFriendsProductModel *commit = self.products[indexPath.row];
//    CircleOfFriendsImageModel *ImageModel=commit.imgData[index];
    //跳转商品
    if([commit.type isEqualToString:@"pub_one_goods"] && [commit.fnuo_id kr_isNotEmpty]){
        if (commit.imgData.count > 0) {
            [self goProductVCWithModel:commit.imgData[0] withData:commit.imgData[0].data];
        } else {
            [self goProductVCWithModel:commit withData:commit.data];
        }
    } else if ([commit.type isEqualToString:@"pub_guanggao"] && ![commit.url isEqualToString:@""]) {
        [self goWebDetailWithWebType:@"0" URL:commit.url];
    }
}

#pragma mark - CircleOfFriendProductCellDelegate
- (void)productCellDidLikeClick:(CircleOfFriendProductCell*)cell {
    if ([NSString isEmpty:UserAccessToken]) {
        [self gologin];
        return;
    }
    XYLog(@"喜欢");
    NSIndexPath *indexpath = [self.jm_tableview indexPathForCell:cell];
    CircleOfFriendsProductModel *model = self.products[indexpath.row];
    if([model.is_thumb integerValue]==0){
        [self apiRequestLike:model.ID success:^(id respondsObject) {
            int num = model.thumbs_num.intValue;
            model.thumbs_num = [NSString stringWithFormat:@"%d", num + 1];
            model.is_thumb = @"1";
            [self.jm_tableview reloadData];
        }];
    }else{
        [self apiRequestDislike: model.ID success:^(id respondsObject) {
            int num = model.thumbs_num.intValue;
            model.thumbs_num = [NSString stringWithFormat:@"%d", num - 1];
            model.is_thumb = @"0";
            [self.jm_tableview reloadData];
        }];
    }
}

- (void)productCellDidCommentClick:(CircleOfFriendProductCell*)cell {
    NSIndexPath *indexpath = [self.jm_tableview indexPathForCell:cell];
    CircleOfFriendsProductModel *model = self.products[indexpath.row];

    COFsingleDetailsController *detailsVC=[[COFsingleDetailsController alloc]init];

    detailsVC.DetailsID=model.ID;
    CircleOfFriendsFrame *frame = [[CircleOfFriendsFrame alloc] init];
    frame.productModel = model;
    detailsVC.detailsDictry = frame;
    [self.navigationController pushViewController:detailsVC animated:YES];
    XYLog(@"评轮");
}

- (void)productCellDidShareClick:(CircleOfFriendProductCell*)cell {
    if ([NSString isEmpty:UserAccessToken]) {
        [self gologin];
        return;
    }
    
    @weakify(self)
    [self authShare: ^(BOOL isAuthed) {
        @strongify(self)
        if (!isAuthed) {
            return;
        }
        
        if ([FNBaseSettingModel settingInstance].all_fx_onoff.boolValue) {
            
            NSIndexPath *indexpath = [self.jm_tableview indexPathForCell:cell];
            CircleOfFriendsProductModel *commit = self.products[indexpath.row];
            self.productID=commit.ID;
            self.js_urlString=commit.jsurl;
            
            NSArray *datas = @[@{@"text" : @"微信",@"img" : @"FJ_wximg"},@{@"text" : @"朋友圈",@"img" : @"FJ_pyimg"},@{@"text" : @"QQ",@"img" : @"FJ_qqimg"},@{@"text" : @"微博",@"img" : @"FJ_wbimg"},@{@"text" : @"保存图片",@"img" : @"FJ_bcimg"}];
            NSMutableArray *shareArray=[NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *data in datas) {
                JhPageItemModel *item = [[JhPageItemModel alloc] init];
                item.text = data[@"text"];
                item.img = data[@"img"];
                [shareArray addObject:item];
            }
            NSString *hintString=@"注：由于新版微信调整了分享策略，如遇到多图无法分享至朋友圈，请先保存图片再打开微信分享。";
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
            [alert addAction:[UIAlertAction actionWithTitle:@"多图不分组分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [JhScrollActionSheetView  showShareActionSheetWithTitle:@"分享方式" withdescribe:hintString shareDataArray:shareArray handler:^(JhScrollActionSheetView *actionSheet, NSInteger index) {
                    if (index == 4) {
                        [self saveImages:indexpath.row];
                        return ;
                    }
                    
                    self.isSingle = NO;
                    [self apiRequestShareInformation];
                }];
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"单图分组分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [JhScrollActionSheetView  showShareActionSheetWithTitle:@"分享方式" withdescribe:hintString shareDataArray:shareArray handler:^(JhScrollActionSheetView *actionSheet, NSInteger index) {
                    if (index == 4) {
                        [self saveImages:indexpath.row];
                        return ;
                    }
                    self.isSingle = YES;
                    self.shareType = UMSocialPlatformType_WechatSession;
                    
                    if (index==0) {
                        self.shareType=UMSocialPlatformType_WechatSession;
                    }else if (index==1) {
                        self.shareType=UMSocialPlatformType_WechatTimeLine;
                    }else if (index==2) {
                        //type=UMSocialPlatformType_Qzone;
                        self.shareType=UMSocialPlatformType_QQ;
                    } else if (index==3) {
                        self.shareType=UMSocialPlatformType_Sina;
                    }
                    [self apiRequestShareInformation];
                    
                }];
                
            }]];

            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
            
        }else{
            [self loadMembershipUpgradeViewController];
        }
    }];
}

- (void)productCellDidSaveClick:(CircleOfFriendProductCell*)cell {
    NSIndexPath *indexpath = [self.jm_tableview indexPathForCell:cell];
    [self saveImages:indexpath.row];
}
// 详情
-(void)detailsClickAction:(UIButton *)sender{
    if ([NSString isEmpty:UserAccessToken]) {
        [self warnToLogin];
        return;
    }
    XYLog(@"详情");
//    NSIndexPath *indexpath = [self.jm_tableview indexPathForCell:cell];
//    CircleOfFriendsProductModel *commit = self.products[indexpath.row];
//    NSString *typeString=commit.type;
//    if([typeString isEqualToString:@"pub_one_goods"]){
//        FNNewProDetailController* detail = [FNNewProDetailController new];
//        detail.fnuo_id = commit.fnuo_id;
//        detail.getGoodsType = commit.goods_type;
//        detail.goods_title = @"";
//        detail.SkipUIIdentifier = commit.goods_type;
//        detail.dataDict=commit;
//        [self.navigationController pushViewController:detail animated:YES];
//    }else if([typeString isEqualToString:@"pub_more_goods"]){
//        
//    }
//    else if([typeString isEqualToString:@"pub_guanggao"]){
//        NSLog(@"url:%@",commit.url);
//        
//        if([commit.url kr_isNotEmpty]){
//            XYLog(@"广告");
//            [self goWebDetailWithWebType:@"0" URL:commit.url];
//        }else{
//            [FNTipsView showTips:@"返回的无效链接!" withDuration:1.0];
//        }
//    }
    
}

- (void)productCellDidHeaderClick:(CircleOfFriendProductCell*)cell {
    NSIndexPath *indexpath = [self.jm_tableview indexPathForCell:cell];
    CircleOfFriendsProductModel *commit = self.products[indexpath.row];
    COFPublishListController *publishVc=[[COFPublishListController alloc]init];
    publishVc.publisherID=commit.uid;
    publishVc.publisherName=commit.nickname;
    [self.navigationController pushViewController:publishVc animated:YES];
}

- (void)productCell:(CircleOfFriendProductCell *)cell didPhotoClickAtIndex:(NSInteger)index {

    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    CircleOfFriendsProductModel *commit = self.products[indexPath.row];
    if([commit.type isEqualToString:@"pub_one_goods"] || [commit.type isEqualToString:@"pub_more_goods"]){
        [self goProductVCWithModel:commit.imgData[index] withData:commit.imgData[index].data];
        return;
    } else {
        NSIndexPath *indexpath = [self.jm_tableview indexPathForCell:cell];
        CircleOfFriendsProductModel *commit = self.products[indexpath.row];
        CircleOfFriendsImageModel *ImageModel=commit.imgData[index];
     
        //NSArray *imageArr=commit.img;
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
        // 弹出相册时显示的第一张图片是点击的图片
        browser.currentPhotoIndex = index;
        NSMutableArray *photos = [NSMutableArray array];
        NSArray *imgs = commit.img;
        [imgs enumerateObjectsUsingBlock:^(id  _Nonnull sobj, NSUInteger idx, BOOL * _Nonnull stop) {
            MJPhoto *mjPhoto = [[MJPhoto alloc] init];

            mjPhoto.url = [NSURL URLWithString:sobj];

            //mjPhoto.srcImageView = imgview;

            [photos addObject:mjPhoto];
        }];

        // 设置所有的图片。photos是一个包含所有图片的数组。
        browser.photos = photos;
        [browser show];
    }
    
}

- (void)productCell:(CircleOfFriendProductCell*)cell didCopyClickAtIndex: (NSInteger)index {
    
    @weakify(self)
    [self authShare: ^(BOOL isAuthed) {
        @strongify(self)
        if (!isAuthed) {
            return;
        }
        
        NSIndexPath *indexpath = [self.jm_tableview indexPathForCell:cell];
        CircleOfFriendsProductModel *model = self.products[indexpath.row];
        CircleOfFriendsProductShareModel *content = model.share_content[index];
        
    //    [FNTipsView showTips:@"复制成功"];
    //    [[UIPasteboard generalPasteboard] setString:content.str];
        [self apiRequestCopy:model.ID andType:content.share_type];
        
    }];
}

#pragma mark - 添加
-(void)AddBtnAction{
    if ([NSString isEmpty:UserAccessToken]) {
        [self warnToLogin];
        return;
    }
    COFAddInformationController *addVC=[[COFAddInformationController alloc]init];
    [self.navigationController pushViewController:addVC animated:YES];
}
//返回
-(void)backBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
    
- (void)saveImages: (NSInteger)index {
    
    @weakify(self)
    [self authShare: ^(BOOL isAuthed) {
        @strongify(self)
        if (!isAuthed) {
            return;
        }
        CircleOfFriendsProductModel *commit = self.products[index];
        self.count = 0;
        [FNTipsView showTips:@"文案复制成功"];
        [[UIPasteboard generalPasteboard] setString:commit.content];
        [SVProgressHUD show];
        @weakify(self);
        for (NSString *imageUrl in commit.share_img) {
            [[SDWebImageManager sharedManager] downloadImageWithURL:URL(imageUrl) options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                if (finished) {
                    @strongify(self);
                    
                    NSString *name = [NSString stringWithFormat:@"%lf", [NSDate dateWithTimeIntervalSinceNow:0].timeIntervalSince1970];
                    [HXPhotoTools savePhotoToCustomAlbumWithName:name photo: image];
                    self.count++;
                    if (self.count == commit.share_img.count) {
                        
                        [SVProgressHUD dismiss];
                        [FNTipsView showTips:@"保存成功～"];
                    }
                }
                if (error)
                    [SVProgressHUD dismiss];
            }];
        }
        
    }];
}

#pragma mark - CircleOfFriendsShopHeaderViewDelegate
- (void)didHeader:(CircleOfFriendsShopHeaderView *)header selectedAt:(NSInteger)index {
    self.jm_page = 1;
    self.selectionStore = index;
    
    [self apiRequestProduct];
}

#pragma mark -   COFshare分享
-(void)COFshareBtnClick:(NSInteger )sender{
    NSLog(@"分享%ld",(long)sender);
    //[SVProgressHUD show];
    //NSArray *itemArr=[self backPicture:_shareimageViewArr];//items;
    //if(itemArr.count>0){
        //[SVProgressHUD dismiss];
    
    //BOOL imageClear = [self ClearImage:_shareimageViewArr];
    //if (imageClear==YES){
    //    NSLog(@"成功");
    //}else{
    //    NSLog(@"失败");
    //}
     
    UIActivityViewController* vc = [[UIActivityViewController alloc]initWithActivityItems:_shareimageViewArr applicationActivities:nil];
    [self presentViewController:vc animated:YES completion:nil];
    
    
   

}
#pragma mark - Request
//获取搜排序文字
- (FNRequestTool *)apiRequestSort{
    @WeakObj(self);
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends&ctrl=cate" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"朋友圈:%@",respondsObject);
        NSMutableArray *name=[[NSMutableArray alloc]init];
        NSMutableArray *type=[[NSMutableArray alloc]init];
        NSArray* array = respondsObject[DataKey];
        if (array.count>0) {
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [name addObject:[obj objectForKey:@"name"]];
                [type addObject:[obj objectForKey:@"SkipUIIdentifier"]];
            }];
            _SkipUIIdentifier = type[0];
        }
        //NSLog(@"type:%@",type);
        NSMutableArray *typeArr=[[NSMutableArray alloc]init];
        for (NSDictionary *dictry in array) {
            [typeArr addObject:[CircleTypeModel mj_objectWithKeyValues:dictry]];
        }
        if (typeArr.count>0) {
            selfWeak.sortArray=typeArr;
            selfWeak.slideBar.itemsTitle =  name;//classify
            selfWeak.slideBar.itemColor = FNGlobalTextGrayColor;
            selfWeak.slideBar.itemSelectedColor = FNMainGobalTextColor;// //FNColor(246, 71, 111)
            selfWeak.slideBar.sliderColor = FNMainGobalTextColor;
            selfWeak.slideBar.fontSize=13;
            selfWeak.slideBar.SelectedfontSize=14;
            
            selfWeak.selectionSort=type[0];
        }
        
        [SVProgressHUD dismiss];
//        [selfWeak apiRequestProduct];
        [selfWeak apiRequestBanner];
        [selfWeak apiRequestShopType];
    } failure:^(NSString *error) {
//        if(selfWeak.sortArray.count==0){
//            [selfWeak apiRequestSort];
//        }
    } isHideTips:NO];
}
- (FNRequestTool *)apiRequestBanner{
    @weakify(self);
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends02&ctrl=banner" respondType:(ResponseTypeArray) modelType:@"CircleOfFriendsBannerModel" success:^(id respondsObject) {
        @strongify(self);
        [SVProgressHUD dismiss];
        self.banners = respondsObject;
        NSMutableArray *images = [[NSMutableArray alloc] init];
        for (CircleOfFriendsBannerModel *model in self.banners) {
            [images addObject:model.img];
        }
        [self configHeader:images];
    } failure:^(NSString *error) {
        @strongify(self);
//        [self apiRequestBanner];
    } isHideTips:NO];
}
- (FNRequestTool *)apiRequestShopType{
    @weakify(self);
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{}];
    if ([_SkipUIIdentifier kr_isNotEmpty]) {
        params[@"SkipUIIdentifier"] = _SkipUIIdentifier;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends&ctrl=shopType" respondType:(ResponseTypeArray) modelType:@"StoreModel" success:^(id respondsObject) {
        @strongify(self);
        self.stores = respondsObject;
        
        self.selectionStore = 0;
        [self apiRequestProduct];
        
        [self.jm_tableview reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        @strongify(self);
//        [self apiRequestShopType];
    } isHideTips:NO];
}
//获取交互
- (FNRequestTool *)apiRequestInteraction{
    @WeakObj(self);
    [SVProgressHUD show];
     NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token,@"p":@(self.jm_page)}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends&ctrl=jsCircle" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        XYLog(@"朋友圈交互:%@",respondsObject);
        NSDictionary* dictry = respondsObject[DataKey];
        //NSInteger is_need_js=[dictry[@"is_need_js"] integerValue];
        selfWeak.js_urlString=dictry[@"url"];
        /*if(is_need_js==0){
            [self apiRequestShareInformation];
        }else if (is_need_js==1){
            [self apiRequestHFURL];
        }*/
        [self apiRequestShareInformation];
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
//获取交互
- (void)apiRequestHFURL{
    self.webInteractionView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.webInteractionView.delegate=self;
    [self.view addSubview:self.webInteractionView];
    NSURL *telURL =[NSURL URLWithString:_js_urlString]; 
    [self.webInteractionView loadRequest:[NSURLRequest requestWithURL:telURL]];
   
}
-(void)webViewDidFinishLoad:(UIWebView*)webView{
     [self apiRequestShareInformation];
}

//获取朋友圈列表
- (void)apiRequestProduct{
    [self.jm_tableview.mj_header endRefreshing];
    [self.jm_tableview.mj_footer endRefreshing];
    [SVProgressHUD show];
     NSString *token = UserAccessToken;
    
    XYLog(@"selectionSort:%@",self.selectionSort);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"p":@(self.jm_page),@"SkipUIIdentifier":self.selectionSort,@"token":token}];
    if (self.stores != nil && self.stores.count > 0) {
        params[@"goods_type"] = self.stores[self.selectionStore].type;
    }
    @weakify(self);
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends02&ctrl=index" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSArray<CircleOfFriendsProductModel*> *array = respondsObject;
        if (self.jm_page == 1) {
            [self.products removeAllObjects];
        }
        if (array > 0)
            self.jm_page ++;
        for (NSDictionary *dic in respondsObject) {
            CircleOfFriendsProductModel *model = [CircleOfFriendsProductModel mj_objectWithKeyValues:dic];
            model.data = dic;
            [self.products addObject:model];
        }
//        [self.products addObjectsFromArray:array];
        [self.jm_tableview.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        [self.jm_tableview reloadData];
        
    } failure:^(NSString *error) {
//        @strongify(self);
//        if (self.products.count == 0) {
//            [self apiRequestProduct];
//        }
        
    } isHideTips:NO];
}
//点赞
- (FNRequestTool *)apiRequestLike: (NSString*) productID success: (RequestSuccess)success{
    @weakify(self);
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token,@"id":productID}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends&ctrl=add_thumbs" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"点赞结果:%@",respondsObject);
        @strongify(self);
//        [self apiRequestProduct];
        success(respondsObject);
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
//复制
- (FNRequestTool *)apiRequestCopy: (NSString*) ID andType: (NSString*)type{
    [SVProgressHUD show];
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token,@"id":ID, @"share_type": type}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends02&ctrl=get_copy_wenan" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSDictionary *dictry = respondsObject[DataKey];
        NSString *content = [dictry objectForKey:@"str"];
        
        [FNTipsView showTips:@"评论复制成功"];
        [[UIPasteboard generalPasteboard] setString:content];
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        [FNTipsView showTips:@"复制失败，请稍后重试"];
        [SVProgressHUD dismiss];
    } isHideTips:NO];
}

//分享信息
- (FNRequestTool *)apiRequestShareInformation{
    [self.webInteractionView removeFromSuperview];
    @WeakObj(self);
    XYLog(@"FnID:%@",selfWeak.productID);
    [SVProgressHUD show];
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token":token,@"id":selfWeak.productID}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends&ctrl=shareFriendCircle" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"分享信息:%@",respondsObject);
        NSArray *commitsList =  respondsObject [DataKey];
        NSMutableArray *arrM = [NSMutableArray array];
        NSDictionary *dictDict= commitsList[0];
        NSString *contentString=dictDict[@"content"];
        [[UIPasteboard generalPasteboard] setString:contentString];
        NSArray *imgArr=dictDict[@"img"];
        for (NSString *imageString in imgArr) {
            [arrM addObject:imageString];
        }
        
        selfWeak.shareimageViewArr=[self backPicture:arrM];//items
        NSLog(@"shareimageViewArr:%@",selfWeak.shareimageViewArr);
        [SVProgressHUD dismiss];
        
        [FNTipsView showTips:@"文案复制成功"];
        if (selfWeak.isSingle && arrM.count > 0) {
//            [selfWeak umengShareWithURL:nil image:arrM[0] shareTitle:nil andInfo:nil withType:selfWeak.shareType];
            [selfWeak umengShareWithURL:nil image:arrM[0] shareTitle:nil andInfo:nil withType:selfWeak.shareType];
            selfWeak.isSingle = NO;
            return;
        }
        
        UIActivityViewController* vc = [[UIActivityViewController alloc]initWithActivityItems:_shareimageViewArr applicationActivities:nil];
        [self presentViewController:vc animated:YES completion:nil];
        
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
//不喜欢 不赞
- (FNRequestTool *)apiRequestDislike: (NSString*)productID success: (RequestSuccess)success{
    @weakify(self);
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"id":productID,@"token":token}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends&ctrl=cancel_thumbs" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        XYLog(@"不喜欢结果:%@",respondsObject);
//        [self apiRequestProduct];
        success(respondsObject);
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}


-(NSMutableArray *)products{
    if (!_products) {
        _products = [NSMutableArray array];
    }
    return _products;
}
-(NSMutableArray *)sortArray{
    if (!_sortArray) {
        _sortArray = [NSMutableArray array];
    }
    return _sortArray;
}
-(NSMutableArray *)shareimageViewArr{
    if (!_shareimageViewArr) {
        _shareimageViewArr = [NSMutableArray array];
    }
    return _shareimageViewArr;
}

//-(NSMutableArray *)classifyArr{
//    if (!_classifyArr) {
//        _classifyArr = [NSMutableArray array];
//    }
//    return _classifyArr;
//}

//将网络图片地址缓存到本地
-(NSMutableArray*)backPicture:(NSArray*)imageArr{
    
    NSMutableArray *items = [NSMutableArray array];
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    for (int i = 0; i < imageArr.count; i++) {
        UIImage *imagerang = [UIImage imageWithData:[NSData dataWithContentsOfURL:URL(imageArr[i])]];
        //图片缓存的地址，自己进行替换
        NSString *imagePath = [docPath stringByAppendingString:[NSString stringWithFormat:@"ShareWX%d%@.jpg",i,[NSString GetNowTimes]]];
        //把图片写进缓存，一定要先写入本地，不然会分享出错
        [UIImageJPEGRepresentation(imagerang, 0.5) writeToFile:imagePath atomically:YES];
        //把缓存图片的地址转成NSUrl格式
        NSURL *shareobj = [NSURL fileURLWithPath:imagePath];
        //这个部分是自定义ActivitySource
        CoShareItem *item = [[CoShareItem alloc] initWithData: imagerang andFile:shareobj];
        //分享的数组
        [items addObject:item];
      
    }
   
    return items;
}
//删除分享时缓存的图片
-(BOOL)ClearImage:(NSMutableArray*)arr{
    BOOL result=NO;
    for (CoShareItem *item in arr) {
        NSString *fileString=[item.path  absoluteString];
        NSArray *imageStrArr=[fileString componentsSeparatedByString:@"://"];
        NSString *path=imageStrArr[1];
        NSFileManager *manager = [NSFileManager defaultManager];
        result = [manager removeItemAtPath:path error:nil];
    }
    return result;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    CircleOfFriendsBannerModel *banner = self.banners[index];
    [self goWebDetailWithWebType:@"0" URL:banner.url];
}

@end
