//
//  FNPosterController.m
//  THB
//
//  Created by jimmy on 2017/8/28.
//  Copyright © 2017年 方诺科技. All rights reserved.
//  海报

#import "FNPosterController.h"
#import "FNPosterCCell.h"
#import "FNHomeFunctionBtn.h"
#import "FNPosterModel.h"
#import "FNmemberNLayout.h"
#import "JhPageItemModel.h"
#import "JhScrollActionSheetView.h"
#import "HXPhotoTools.h"
@interface FNPosterController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,FNPosterCCellDelegate>
@property (nonatomic, strong)UIView* btmView;
@property (nonatomic, strong)NSMutableArray<FNHomeFunctionBtn *>* btns;
@property (nonatomic, strong)UIButton* morebtn;
@property (nonatomic, strong)NSMutableArray<FNPosterModel *>* posters;
@property (nonatomic, assign)NSInteger selectedIndex;

@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)UIView *botView;
@property (nonatomic, strong)FNPosterModel *seletedModel;
@property (nonatomic, strong)FNPosterModel *haibaoModel;
@end

@implementation FNPosterController

- (BOOL)isFullScreenShow {
    return YES;
}

- (BOOL) needLogin {
    return YES;
}

- (NSMutableArray<FNPosterModel *> *)posters
{
    if (_posters == nil) {
        _posters = [NSMutableArray new];
    }
    return _posters;
}
- (UIButton *)morebtn{
    if (_morebtn == nil) {
        _morebtn = [UIButton buttonWithTitle:@"更多邀请方式" titleColor:FNWhiteColor font:kFONT14 target:self action:@selector(morebtnAction)];
        _morebtn.backgroundColor = RGB(215, 40, 58);
        _morebtn.cornerRadius = 5;
        
    }
    return _morebtn;
}
- (NSMutableArray<FNHomeFunctionBtn *> *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray new];
    }
    return _btns;
}
- (UIView *)btmView{
    if (_btmView  == nil) {
        _btmView = [UIView new];
        _btmView.backgroundColor
        = FNHomeBackgroundColor;
        NSArray* titles = @[@"微信好友",@"QQ好友",@"保存到相册"];
        NSArray* images = @[@"poster_wechat",@"poster_qq",@"poster_save"];
        CGFloat margin = 20;
        CGFloat width = (FNDeviceWidth-margin*4)/3.0;
        CGFloat height = width+20;
        height = 6+38+5+19+5;
        if (self.btns.count>=1) {
            [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self.btns removeAllObjects];
        }
        @WeakObj(self);
        [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNHomeFunctionBtn* btn = [[FNHomeFunctionBtn alloc]initWithFrame:(CGRectMake(margin*(idx+1)+width*idx, 0, width, height)) title:obj andImageURL:images[idx]];
            btn.imgView.contentMode = UIViewContentModeScaleAspectFit;
            btn.tag = 100+idx;
            [btn addJXTouchWithObject:^(FNHomeFunctionBtn* obj) {
                //
                [selfWeak btnClickAtIndex:obj.tag-100];
            }];
            [_btmView addSubview:btn];
            [selfWeak.btns addObject:btn];
            
        }];
        _btmView.height = height+20+44;
        
        [_btmView addSubview:self.morebtn];
        [self.morebtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_margin10];
        [self.morebtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_margin10];
        [self.morebtn autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:_jm_margin10];
        [self.morebtn autoSetDimension:(ALDimensionHeight) toSize:44];
    }
    return _btmView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.title?:@"海报";
    
    [self jm_setupViews];
//    self.jm_collectionview.alpha = 0;
//    self.btmView.alpha = 0;
    [self apiRequestPoster];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initializedSubviews
- (void)jm_setupViews
{
//    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
//    flowlayout.sectionInset = UIEdgeInsetsMake(0, _jm_margin10, 0, _jm_margin10);
//    flowlayout.minimumInteritemSpacing = 10;
//    flowlayout.minimumLineSpacing = 10;
//    flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    [self bottomView];
    
    FNmemberNLayout* flowlayout = [FNmemberNLayout new];
    
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 0)) collectionViewLayout:flowlayout];
    self.jm_collectionview.dataSource =self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.backgroundColor = FNWhiteColor;
    self.jm_collectionview.showsHorizontalScrollIndicator = NO;
    [self.jm_collectionview registerClass:[FNPosterCCell class] forCellWithReuseIdentifier:@"FNPosterCCell"];
    //self.jm_collectionview.pagingEnabled = YES;
    //self.jm_collectionview.bounces = NO;
    [self.view addSubview:self.jm_collectionview];
    
    //[self.view addSubview:self.btmView];
    
    //[self.btmView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    //[self.btmView autoSetDimension:(ALDimensionHeight) toSize:self.btmView.height];
    
    //[self.jm_collectionview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];;
    //[self.jm_collectionview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:self.btmView];
    
    
    self.jm_collectionview.sd_layout
    .bottomSpaceToView(self.botView, 10).topSpaceToView(self.view, 10).rightEqualToView(self.view).leftEqualToView(self.view);
    self.jm_collectionview.backgroundColor=RGB(245, 245, 245);
    self.view.backgroundColor=RGB(245, 245, 245);
    
}
-(void)bottomView{
    UIView *botView=[[UIView alloc]init];
    botView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:botView];
    self.botView=botView;
    
    UIButton *leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    leftBtn.backgroundColor=[UIColor whiteColor];
    leftBtn.borderWidth=0.5;
    leftBtn.borderColor = RGB(244,62,121);
    leftBtn.cornerRadius=15;
    leftBtn.clipsToBounds = YES;
    leftBtn.titleLabel.font=kFONT14;
    [leftBtn setTitleColor:RGB(244,62,121) forState:UIControlStateNormal];
    [leftBtn setTitle:@"复制邀请链接" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [botView addSubview:leftBtn];
    self.leftBtn=leftBtn;
    
    
    
    UIButton *rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    rightBtn.backgroundColor=RGB(244,62,121);
    rightBtn.cornerRadius=15;
    rightBtn.titleLabel.font=kFONT14;
    [rightBtn setTitle:@"分享邀请海报" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [botView addSubview:rightBtn];
    self.rightBtn=rightBtn;
    
    self.botView.sd_layout
    .bottomSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).leftSpaceToView(self.view, 0).heightIs(50);
    self.leftBtn.sd_layout
    .bottomSpaceToView(self.botView, 10).leftSpaceToView(self.botView, 40).heightIs(30);
    [self.leftBtn setupAutoSizeWithHorizontalPadding:10 buttonHeight:30];
    self.rightBtn.sd_layout
    .bottomSpaceToView(self.botView, 10).rightSpaceToView(self.botView, 40).heightIs(30);
    [self.rightBtn setupAutoSizeWithHorizontalPadding:10 buttonHeight:30];
    
}
-(void)leftBtnAction{
    [[UIPasteboard generalPasteboard] setString:self.haibaoModel.haibao_share_wenan?:@""];
    [FNTipsView showTips:@"已复制"];
}
-(void)rightBtnAction{
   
    NSArray *datas = @[@{@"text" : @"微信",@"img" : @"FJ_wximg"},@{@"text" : @"朋友圈",@"img" : @"FJ_pyimg"},@{@"text" : @"QQ空间",@"img" : @"MA_KJimg"},@{@"text" : @"QQ",@"img" : @"FJ_qqimg"},@{@"text" : @"微博",@"img" : @"FJ_wbimg"},@{@"text" : @"保存图片",@"img" : @"FJ_bcimg"}];
//    NSMutableArray *shareArray=[NSMutableArray arrayWithCapacity:0];
//    for (NSDictionary *data in datas) {
//        JhPageItemModel *item = [JhPageItemModel mj_objectWithKeyValues:data];
//        [shareArray addObject:item];
//    }
    NSArray *shareArray=[JhPageItemModel mj_objectArrayWithKeyValuesArray:datas];
    NSString *hintString=@"注：由于新版微信调整了分享策略，如遇到多图无法分享至朋友圈，请先保存图片再打开微信分享。";
    if([self.haibaoModel.haibao_tip_str kr_isNotEmpty]){
        hintString=self.haibaoModel.haibao_tip_str;
    }
    [JhScrollActionSheetView  showShareActionSheetWithTitle:@"分享方式" withdescribe:hintString shareDataArray:shareArray handler:^(JhScrollActionSheetView *actionSheet, NSInteger index) {
        if (index == 5) {
            [self saveImages];
            return ;
        }
        [self shareType:index];
    }];
}
-(void)shareType:(NSInteger)sender{
    NSString*imgurl = self.posters[self.selectedIndex].image;
    //NSString*shareurl = self.haibaoModel.haibao_share_wenan;
    //NSString *url=@"";
    UMSocialPlatformType type=UMSocialPlatformType_WechatSession;
    if (sender==0) {
        type=UMSocialPlatformType_WechatSession;
    }else if (sender==1) {
        type=UMSocialPlatformType_WechatTimeLine;
    }else if (sender==2) {
        //type=UMSocialPlatformType_Qzone;
        type=UMSocialPlatformType_QQ;
    }else if (sender==3) {
        type=UMSocialPlatformType_QQ;
    }else if (sender==4) {
        type=UMSocialPlatformType_Sina;
    }
    [self umengShareWithURL:nil image:imgurl shareTitle:[NSString stringWithFormat:@"来自%@App",[FNBaseSettingModel settingInstance].AppDisplayName] andInfo:nil withType:type];
    
}
- (void)saveImages{
    
    NSString*imageUrl = self.posters[self.selectedIndex].image;
    [SVProgressHUD show];
    [[SDWebImageManager sharedManager] downloadImageWithURL:URL(imageUrl) options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (finished) {
            NSString *name = [NSString stringWithFormat:@"%lf", [NSDate dateWithTimeIntervalSinceNow:0].timeIntervalSince1970];
            [HXPhotoTools savePhotoToCustomAlbumWithName:name photo: image];
            [SVProgressHUD dismiss];
            [FNTipsView showTips:@"保存成功"];
        }
    }];
    
}
- (void)apiRequestPoster{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    [FNRequestTool requestWithParams:params api:@"mod=new_share&act=agency&ctrl=ssAnnual" respondType:(ResponseTypeArray) modelType:@"FNPosterModel" success:^(id respondsObject) {
        //
        [self.posters removeAllObjects];
        [self.posters addObjectsFromArray:respondsObject];
        if (self.posters.count>=1) {
            [self.posters enumerateObjectsUsingBlock:^(FNPosterModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx == 0) {
                    obj.is_check = @"1";
                }else{
                    obj.is_check = @"0";
                }
            }];
        }
        [self.jm_collectionview reloadData];
//        [UIView animateWithDuration:1.0 animations:^{
//            self.jm_collectionview.alpha = 1.0;
//            self.btmView.alpha = 1.0;
//        } completion:^(BOOL finished) {
//            
//        }];
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
    
    //分享信息 mod=appapi&act=playbill&ctrl=playbill_msg
    NSMutableDictionary* paramsL = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    [FNRequestTool requestWithParams:paramsL api:@"mod=appapi&act=playbill&ctrl=playbill_msg" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSDictionary* dictry = respondsObject[DataKey];
        FNPosterModel *model=[FNPosterModel mj_objectWithKeyValues:dictry];
        selfWeak.haibaoModel=model;
        selfWeak.leftBtn.borderColor = [UIColor colorWithHexString:model.haibao_left_bordercolor];
        [selfWeak.leftBtn setTitleColor:[UIColor colorWithHexString:model.haibao_left_strcolor] forState:UIControlStateNormal];
        [selfWeak.leftBtn setTitle:model.haibao_left_str forState:UIControlStateNormal];
        
        selfWeak.rightBtn.borderColor = [UIColor colorWithHexString:model.haibao_right_bordercolor];
        [selfWeak.rightBtn setTitleColor:[UIColor colorWithHexString:model.haibao_right_strcolor] forState:UIControlStateNormal];
        [selfWeak.rightBtn setTitle:model.haibao_right_str forState:UIControlStateNormal];
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
}
#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.posters.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNPosterCCell* cell = [FNPosterCCell cellWithCollectionView:collectionView atIndexPath:indexPath];
    [cell.posterimgview  setUrlImg:self.posters[indexPath.row].image];
    cell.chooseBtn.selected = self.posters[indexPath.row].is_check.boolValue;
    cell.backgroundColor=RGB(245, 245, 245);
    cell.btmview.backgroundColor=RGB(245, 245, 245);
    cell.indxpath=indexPath;
    cell.delegate=self;
    return cell;
}

#pragma mark - Collection view delegate && flow layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = FNDeviceHeight-self.botView.height-SafeAreaTopHeight-60; //FNDeviceHeight-self.btmView.height-64;
    CGFloat with= (height-44)*0.55;//JMScreenWidth-80;
    CGSize size = CGSizeMake(with, height);//
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.posters enumerateObjectsUsingBlock:^(FNPosterModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == indexPath.row) {
            obj.is_check = @"1";
            self.selectedIndex = idx;
        }else{
            obj.is_check = @"0";
        }
    }];
    [self.jm_collectionview reloadData];
    self.seletedModel=self.posters[indexPath.row];
}
#pragma mark -FNPosterCCellDelegate // 选择
- (void)posterChooseAction:(NSIndexPath*)sender{
    [self.posters enumerateObjectsUsingBlock:^(FNPosterModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == sender.row) {
            obj.is_check = @"1";
            self.selectedIndex = idx;
        }else{
            obj.is_check = @"0";
        }
    }];
    [self.jm_collectionview reloadData];
    self.seletedModel=self.posters[sender.row];
}
#pragma mark - umeng share

-(void)btnClickAtIndex:(NSInteger)index{
    NSString*imgurl = self.posters[self.selectedIndex].image;
    if (index == 0) { //微信
        [self umengShareWithURL:nil image:[NSData dataWithContentsOfURL:URL(imgurl)] shareTitle:nil andInfo:nil withType:(UMSocialPlatformType_WechatSession)];
    }else if(index == 1){ // QQ
        [self umengShareWithURL:nil image:[NSData dataWithContentsOfURL:URL(imgurl)] shareTitle:nil andInfo:nil withType:(UMSocialPlatformType_QQ)];
    }else if(index == 2){
        [SVProgressHUD show];
        UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:[NSData dataWithContentsOfURL:URL(imgurl)]], self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    }else if(index == 3){
    }
    
    
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    [FNTipsView showTips:@"已保存"];
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}


- (void)morebtnAction{
    NSString*imgurl = self.posters[self.selectedIndex].image;
    
    [self umengShareWithURL:nil image:[NSData dataWithContentsOfURL:URL(imgurl)] shareTitle:[NSString stringWithFormat:@"来自%@App",[FNBaseSettingModel settingInstance].AppDisplayName] andInfo:nil];
}
@end

