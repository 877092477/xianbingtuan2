//
//  FNtradeArticleDetailsController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNtradeArticleDetailsController.h"
#import "FNCustomeNavigationBar.h" 
#import "FNtradeRecommendCell.h"
#import "FNtradeVideoDeTopCell.h"
#import "FNtradeArticletHeadView.h"
#import "FNtradeLeftTextHeadView.h"
#import "FNtradeArticletFotterView.h"
#import "WebViewJavascriptBridge.h"
#import "JhScrollActionSheetView.h"
#import "JhPageItemModel.h"
@interface FNtradeArticleDetailsController ()<UIWebViewDelegate>
//UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIWebView *webLView;
@property (nonatomic, assign)CGFloat webHeight;
@property (nonatomic, strong)WebViewJavascriptBridge *bridge;
@end

@implementation FNtradeArticleDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
#pragma mark - set up views
- (void)jm_setupViews{
    CGFloat baseGap=SafeAreaTopHeight+1;
    self.webHeight=10;
    self.webLView = [[UIWebView alloc]initWithFrame:CGRectMake(0, baseGap, FNDeviceWidth, FNDeviceHeight-baseGap)];
    //_webLView.hidden=YES;
    self.webLView.frame=CGRectMake(0, baseGap, FNDeviceWidth, FNDeviceHeight-baseGap);
    self.webLView.delegate=self;
    self.webLView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //self.webLView.scrollView.scrollEnabled = NO;
    self.webLView.scrollView.showsVerticalScrollIndicator=NO;
    self.webLView.scrollView.showsHorizontalScrollIndicator=NO;
    self.webLView.scalesPageToFit = YES;
    self.webLView.backgroundColor = RGB(250, 250, 250);
    [self.view addSubview:self.webLView];
    //@"http://www.hairuyi.com/appapi.talentTalk.detail_html/id.5257.html"
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];//self.urlString
    [self.webLView loadRequest:request];
    //[self.webLView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"ViewController"];
    [WebViewJavascriptBridge enableLogging];
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webLView];
    [self.bridge setWebViewDelegate:self];
    @weakify(self)
    [self.bridge registerHandler:@"WebViewJavascriptBridge" handler:^(id data, WVJBResponseCallback responseCallback) {
        @strongify(self)
        NSLog(@"js call ObjC, data from js is :%@", data);
        NSString *identifier = [data objectForKey:@"identifier"];
        NSString *typeTwo = [data objectForKey:@"identifier2"];
        if([typeTwo kr_isNotEmpty]){
            identifier=typeTwo;
        }
        // 根据不同的标识跳转
        [self jumpToActionFromWebJSMethod:identifier data:data];
    }];
    
 
//    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
//
//    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, baseGap, FNDeviceWidth, FNDeviceHeight-baseGap) collectionViewLayout:flowlayout];
//    self.jm_collectionview.backgroundColor=RGB(238, 238, 238);
//    self.jm_collectionview.dataSource = self;
//    self.jm_collectionview.delegate = self;
//    self.jm_collectionview.showsVerticalScrollIndicator=NO;
//    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
//    [self.view addSubview:self.jm_collectionview];
//
//    [self.jm_collectionview registerClass:[FNtradeRecommendCell class] forCellWithReuseIdentifier:@"FNtradeRecommendCell1ID"];
//
//    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
//
//    [self.jm_collectionview registerClass:[FNtradeArticletHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNtradeArticletHeadViewID"];
//    [self.jm_collectionview registerClass:[FNtradeLeftTextHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNtradeLeftTextHeadViewID"];
//
//    [self.jm_collectionview registerClass:[FNtradeArticletFotterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FNtradeArticletFotterViewID"];
//    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableViewFootID"];
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.view addSubview:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 10).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    self.navigationView.titleLabel.text=self.keyWord ? self.keyWord:@"文章详情";
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    
    
    self.view.backgroundColor=RGB(250, 250, 250);
//    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
//
//    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    footer.stateLabel.hidden=YES;
//    NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
//    for (NSInteger i=1; i<32; i++) {
//        [arrM addObject:[UIImage imageNamed:[NSString stringWithFormat:@"FN_bottom_loading－%ld",(long)i]]];
//    }
//    //[footer setImages:arrM  forState:MJRefreshStateRefreshing];
//    [footer setImages:arrM duration:arrM.count * 0.04 forState:MJRefreshStateRefreshing];

//    self.jm_collectionview.mj_footer=footer;
    
}
#pragma mark - Web view delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    XYLog(@"second should request is %@",request.URL);
    XYLog(@"navtype is %ld",(long)navigationType);
    return YES;
}
//监听contentSize
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentSize"]) {
//        CGFloat _webViewHeight = self.webLView.scrollView.contentSize.height;
//        CGSize webSize = [self.webLView sizeThatFits:CGSizeZero];
//        CGRect frame = self.webLView.frame;
//        //通过webview的contentSize获取内容高度
//        frame.size.height = self.webLView.scrollView.contentSize.height;
//        //这里获取webView的高度
//        _webViewHeight = frame.size.height;
//        XYLog(@"height=%f",webSize.height);
//        self.webHeight=webSize.height+10;
        
    }
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //NSLog(@"didFailLoadWithError");
    if(error){
        [_webLView reload];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //[_webLView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#EFEFF4'"];
    NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    BOOL complete = [readyState isEqualToString:@"complete"];
    if (complete) {
        XYLog(@"加载完毕...");
//        [UIView performWithoutAnimation:^{
//            [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:0]];
//        }];
//        [self performSelector:@selector(reloadSectionHeight) withObject:nil afterDelay:3.0f];
    }
}
//- (void)reloadSectionHeight{
//    [UIView performWithoutAnimation:^{
//        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:0]];
//
//        [self.jm_collectionview reloadData];
//    }];
//}
//-(void)loadMoreData{
//    //[self.jm_collectionview.mj_footer endRefreshing];
//}
//#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 2;
//}
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    if(section==0){
//        return 1;
//    }else{
//        return 5;
//    }
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    if(indexPath.section==0){
//        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
//        cell.backgroundColor=[UIColor whiteColor];
//        if (self.webLView.superview != cell) {
//            _webLView.frame=CGRectMake(0, 0, FNDeviceWidth, self.webHeight);
//            [cell addSubview:_webLView];
//        }
//        return cell;
//    }else{
//        FNtradeRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNtradeRecommendCell1ID" forIndexPath:indexPath];
//        cell.backgroundColor=[UIColor whiteColor];
//        return cell;
//    }
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    CGFloat itemHeight=112;
//    CGFloat itemWith=FNDeviceWidth;
//    if(indexPath.section==0){
//        itemHeight=self.webHeight;
//    }
//    else if(indexPath.section==1){
//        itemHeight=112;
//    }else{
//        itemHeight=0;
//    }
//    CGSize  size = CGSizeMake(itemWith, itemHeight);
//    return  size;
//}
////设置每个item水平间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 0;
//}
////设置每个item垂直间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 0;
//}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    if (kind == UICollectionElementKindSectionHeader) {
//        if(indexPath.section==0){
//            FNtradeArticletHeadView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FNtradeArticletHeadViewID" forIndexPath:indexPath];
//            view.backgroundColor=[UIColor whiteColor];
//            return view;
//        }else{
//            FNtradeLeftTextHeadView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FNtradeLeftTextHeadViewID" forIndexPath:indexPath];
//            view.backgroundColor=[UIColor whiteColor];
//            return view;
//        }
//    }else{
//        if(indexPath.section==0){
//            FNtradeArticletFotterView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FNtradeArticletFotterViewID" forIndexPath:indexPath];
//            view.backgroundColor=[UIColor whiteColor];
//            return view;
//        }else{
//            UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableViewFootID" forIndexPath:indexPath];
//            view.backgroundColor=[UIColor whiteColor];
//            return view;
//        }
//    }
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    CGFloat sectionHeight=0;
//    if(section==0){
//       sectionHeight=105;
//    }
//    else if(section==1){
//       sectionHeight=40;
//    }
//    return CGSizeMake(FNDeviceWidth, sectionHeight);
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    CGFloat sectionFooterHeight=0;
//    if(section==0){
//       sectionFooterHeight=125;
//    }
//    return CGSizeMake(FNDeviceWidth, sectionFooterHeight);
//}
//#pragma mark - <UICollectionViewDelegateFlowLayout>
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    CGFloat topGap=0;
//    CGFloat leftGap=0;
//    CGFloat bottomGap=0;
//    CGFloat rightGap=0;
//    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
//}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)isTranspondClick{
        NSArray *datas = @[@{@"text" : @"微信",@"img" : @"FJ_wximg"},@{@"text" : @"朋友圈",@"img" : @"FJ_pyimg"},@{@"text" : @"QQ",@"img" : @"FJ_qqimg"},@{@"text" : @"微博",@"img" : @"FJ_wbimg"}];
        NSMutableArray *shareArray=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *data in datas) {
            JhPageItemModel *item = [[JhPageItemModel alloc] init];
            item.text = data[@"text"];
            item.img = data[@"img"];
            [shareArray addObject:item];
        }
        NSString *hintString=@"注：分享策略";
        @weakify(self);
        [JhScrollActionSheetView  showShareActionSheetWithTitle:@"分享方式" withdescribe:hintString shareDataArray:shareArray handler:^(JhScrollActionSheetView *actionSheet, NSInteger index) {
            @strongify(self);
            [self shareType:index];
        }];
    
}
-(void)shareType:(NSInteger)sender{
    //NSString*imgurl = self.posters[self.selectedIndex].image;
    NSString*shareurl = self.urlString;
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
    [self umengShareWithURL:shareurl image:nil shareTitle:[NSString stringWithFormat:@"来自%@App",[FNBaseSettingModel settingInstance].AppDisplayName] andInfo:nil withType:type];
    
}
@end
