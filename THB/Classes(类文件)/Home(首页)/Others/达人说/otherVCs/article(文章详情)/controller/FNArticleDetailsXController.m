//
//  FNArticleDetailsXController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNArticleDetailsXController.h"
#import "FNArticleHomepageDController.h"
#import "FNCustomeNavigationBar.h"
#import "FNarticleDetailsHeadView.h"
#import "FNarticleImgHeaderXView.h"
#import "FNarticleRecommendItemCell.h"//好文推荐
#import "FNRecommendGoodsItemCell.h"//更多推荐
#import "FNRecommendFineItemXCell.h"
#import "FNArtcleRecommendItemNEWCell.h"
#import "FNArticleDeailsXModel.h"
#import "FNBaseProductModel.h"
#import "FNArticleRecommendXView.h"
#import "DSHPopupContainer.h"
#import "WebViewJavascriptBridge.h"
@interface FNArticleDetailsXController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIWebViewDelegate,FNArticleRecommendXViewDelegate,FNarticleRecommendItemCellDelegate,FNArtcleRecommendItemNEWCellDelegate>
@property (nonatomic, strong)FNArticleDeailsXModel *dataModel;
@property (nonatomic, strong)NSDictionary *dataDictry;
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *topBtn;
@property (nonatomic, strong)UIButton *remindBtn;
@property (nonatomic, strong)UIWebView *webLView;
@property (nonatomic, assign)CGFloat webHeight;
@property (nonatomic, strong)DSHPopupContainer *container;
@property (nonatomic, strong)NSArray *hintArr;

@property (nonatomic, strong)WebViewJavascriptBridge *bridge;
 
@end

@implementation FNArticleDetailsXController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.title=@"文章详情";
}
#pragma mark - set up views
- (void)jm_setupViews{
    self.webHeight=1;//FNDeviceHeight;
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
     
    
    CGFloat baseGap=0;
    if(self.understand==YES){
        baseGap=XYTabBarHeight;
    }
    self.view.backgroundColor =[UIColor whiteColor];
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, FNDeviceHeight-SafeAreaTopHeight-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];//=RGB(250, 250, 250);
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.jm_collectionview registerClass:[FNRecommendFineItemXCell class] forCellWithReuseIdentifier:@"FNRecommendFineItemXCellID"];
    
    //[self.jm_collectionview registerClass:[FNarticleRecommendItemCell class] forCellWithReuseIdentifier:@"FNarticleRecommendItemCellID"];
    
    [self.jm_collectionview registerClass:[FNArtcleRecommendItemNEWCell class] forCellWithReuseIdentifier:@"FNArtcleRecommendItemNEWCellID"];
    
    [self.jm_collectionview registerClass:[FNRecommendGoodsItemCell class] forCellWithReuseIdentifier:@"FNRecommendGoodsItemCellID"];
    [self.jm_collectionview registerClass:[FNarticleDetailsHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNarticleDetailsHeadViewID"];
    [self.jm_collectionview registerClass:[FNarticleImgHeaderXView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNarticleImgHeaderXView1ID"];
    [self.jm_collectionview registerClass:[FNarticleImgHeaderXView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNarticleImgHeaderXView2ID"];
    
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];
    
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self setTopViews];
    if([self.articleID kr_isNotEmpty]){
       [self requestArticleDetails];
       [self requestTalentTalk];
    }
    _webLView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 260, FNDeviceWidth, self.webHeight)];
    //_webLView.hidden=YES;
    _webLView.frame=CGRectMake(0, 325, FNDeviceWidth, self.webHeight);
    _webLView.delegate=self;
    _webLView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webLView.scrollView.scrollEnabled = NO;
    _webLView.scalesPageToFit = YES;
    //[self.view insertSubview:_webLView atIndex:0];
    //[self.view bringSubviewToFront:self.webLView];
    [_webLView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"ViewController"];
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
    
    
//    UIButton *sendBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [sendBtn addTarget:self action:@selector(sendBtnAction)];
//    [sendBtn setImage:IMAGE(@"FN_dhTX_img") forState:UIControlStateNormal];
//    [self.view addSubview:sendBtn];
//
//    sendBtn.sd_layout
//    .rightSpaceToView(self.view, 10).topSpaceToView(self.view, 80).widthIs(50).heightIs(50);
}
-(void)sendBtnAction{
    [self.bridge callHandler:@"WebViewJavascriptBridge" data:@{@"name": @"ZhuYan"} responseCallback:^(id responseData) {
        NSLog(@"from js: %@", responseData);
    }];
}
#pragma mark - Web view delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    XYLog(@"second should request is %@",request.URL);
    XYLog(@"navtype is %ld",(long)navigationType);
    return YES;
}
//监听回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentSize"]) { 
        CGFloat _webViewHeight = self.webLView.scrollView.contentSize.height;
        CGSize webSize = [self.webLView sizeThatFits:CGSizeZero];
        CGRect frame = self.webLView.frame;
        //通过webview的contentSize获取内容高度
        frame.size.height = self.webLView.scrollView.contentSize.height;
        //这里获取webView的高度
        _webViewHeight = frame.size.height;
        XYLog(@"height=%f",webSize.height);
        self.webHeight=webSize.height+10;
        
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
    
    NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    BOOL complete = [readyState isEqualToString:@"complete"];
    if (complete) {
        XYLog(@"加载完毕...");
        [UIView performWithoutAnimation:^{
             [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:0]];
        }];
       
        [self performSelector:@selector(reloadSectionHeight) withObject:nil afterDelay:3.0f];
        
    }
}
- (void)reloadSectionHeight{
    [UIView performWithoutAnimation:^{
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:0]];
    }];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }
    else if(section==1){
        NSArray *goodsArr=self.dataModel.more_goods;
        return goodsArr.count;
    }else if(section==2){
        NSArray *articleArr=self.dataModel.article;
        return articleArr.count;
    }else{
        return  0;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        FNRecommendFineItemXCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNRecommendFineItemXCellID" forIndexPath:indexPath];
        
        return cell;
    }
    else if(indexPath.section==1){
        NSArray *goodsArr=self.dataModel.more_goods;
        FNBaseProductModel *itemModel=[FNBaseProductModel mj_objectWithKeyValues:goodsArr[indexPath.row]];
        FNRecommendGoodsItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNRecommendGoodsItemCellID" forIndexPath:indexPath];
        cell.model=itemModel;
        return cell;
    }else if(indexPath.section==2){
        NSArray *articleArr=self.dataModel.article;
        FNEssayItemDModel *itemModel=[FNEssayItemDModel mj_objectWithKeyValues:articleArr[indexPath.row]];
//        FNarticleRecommendItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNarticleRecommendItemCellID" forIndexPath:indexPath];
//        cell.model=itemModel;
//        cell.delegate=self;
//        cell.indexS=indexPath;
//        cell.backgroundColor=RGB(250, 250, 250);
//        return cell;
        
        FNArtcleRecommendItemNEWCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNArtcleRecommendItemNEWCellID" forIndexPath:indexPath];
        cell.model=itemModel;
        cell.backgroundColor=RGB(250, 250, 250);
        cell.indexS=indexPath;
        cell.delegate=self;
        return cell;
    }else{
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
        return cell;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=0;
    CGFloat with=FNDeviceWidth;
    if(indexPath.section==0){
        height= 1;//self.webHeight;
    }
    else if(indexPath.section==1){
        height=120;
    }
    else if(indexPath.section==2){
        NSArray *articleArr=self.dataModel.article;
        FNEssayItemDModel *itemModel=[FNEssayItemDModel mj_objectWithKeyValues:articleArr[indexPath.row]];
        if([itemModel.article kr_isNotEmpty]){
            height=300;
        }else{
            height=245;
        }
        //height=300;//240;
    }else{
        height=0;
    }
    CGSize size = CGSizeMake(with, height);
    return size;
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        FNarticleDetailsHeadView *headerView= [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNarticleDetailsHeadViewID" forIndexPath:indexPath];
        headerView.model=self.dataModel;
        [headerView.headImg addTarget:self action:@selector(headImgAction)];
        [headerView.nameLB addTarget:self action:@selector(headImgAction)];
        if (self.webLView.superview != headerView) {
            _webLView.frame=CGRectMake(0, 260, FNDeviceWidth, self.webHeight);
            [headerView addSubview:_webLView];
        }
        return headerView;
    }
    else if(indexPath.section==1){
        FNarticleImgHeaderXView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNarticleImgHeaderXView1ID" forIndexPath:indexPath];
        NSArray *goodsArr=self.dataModel.more_goods;
        if(goodsArr.count>0){
            headerView.topImgView.hidden=NO;
           [headerView.topImgView setNoPlaceholderUrlImg:self.dataModel.more_str];
        }else{
           headerView.topImgView.hidden=YES;
        }
        
        return headerView;
    }
    else if(indexPath.section==2){
        FNarticleImgHeaderXView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNarticleImgHeaderXView2ID" forIndexPath:indexPath];
        [headerView.topImgView setNoPlaceholderUrlImg:self.dataModel.article_str];
        return headerView;
    }else{
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
        return headerView;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=45;
    if(section==0){
        hight=260+self.webHeight;//325
    }else if(section==1){
        NSArray *goodsArr=self.dataModel.more_goods;
        if(goodsArr.count>0){
           hight=35;
        }else{
           hight=0;
        }
    }else if(section==2){
        hight=35;
    }else{
        hight=0;
    }
    return CGSizeMake(with,hight);
}
-(void)headImgAction{
    FNArticleHomepageDController *vc=[[FNArticleHomepageDController alloc]init];
    vc.understand=NO;
    vc.talentID=self.dataModel.talent_id;
    vc.dataDictry=self.dataDictry;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        NSArray *goodsArr=self.dataModel.more_goods;
        FNBaseProductModel *model=[FNBaseProductModel mj_objectWithKeyValues:goodsArr[indexPath.row]];
        [self goProductVCWithModel:model withData:model.data];
    }
    else if(indexPath.section==2){
        NSArray *articleArr=self.dataModel.article;
        FNArticleItemXModel *itemModel=[FNArticleItemXModel mj_objectWithKeyValues:articleArr[indexPath.row]];
        FNArticleDetailsXController *vc=[[FNArticleDetailsXController alloc]init];
        vc.articleID=itemModel.id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - set top views
- (void)setTopViews{
    self.view.backgroundColor =RGB(250, 250, 250);
    CGFloat baseGap=0;
    if(self.understand==YES){
        baseGap=XYTabBarHeight;
    }
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.view addSubview:self.navigationView];
    [self.view bringSubviewToFront:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 18);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    
    [self.leftBtn setImage:IMAGE(@"return_w") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.leftBtn.imageView.sd_layout
    .centerYEqualToView(self.leftBtn).widthIs(8).heightIs(16).leftSpaceToView(self.leftBtn, 10);
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:200];
    //self.navigationView.titleLabel.text=@"达人文章";
    if(self.understand==YES){
       self.leftBtn.hidden=YES;
    }
    
    self.topBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.topBtn addTarget:self action:@selector(topBtnAction)];
    [self.topBtn setImage:IMAGE(@"FN_drDB_img") forState:UIControlStateNormal];
    self.topBtn.hidden=YES;
    [self.view addSubview:self.topBtn];
    self.topBtn.sd_layout
    .rightSpaceToView(self.view, 10).bottomSpaceToView(self.view, 100).widthIs(35).heightIs(35);
    
    self.remindBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.remindBtn addTarget:self action:@selector(remindBtnAction)];
    [self.remindBtn setImage:IMAGE(@"FN_dhTX_img") forState:UIControlStateNormal];
    [self.view addSubview:self.remindBtn];
    self.remindBtn.hidden=YES;
    self.remindBtn.sd_layout
    .rightSpaceToView(self.view, 10).bottomSpaceToView(self.topBtn, 8).widthIs(35).heightIs(35);
    
}
-(void)leftBtnAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)topBtnAction{
    [self.jm_collectionview setContentOffset:CGPointMake(0,0) animated:YES];
}
//提到的好货
-(void)remindBtnAction{
    if(self.hintArr.count>0){
        FNArticleRecommendXView *customView = [[FNArticleRecommendXView alloc] init];
        customView.delegate=self;
        customView.dataArr=self.hintArr;
        [customView.leftBtn addTarget:self action:@selector(customViewDiss)];
        self.container = [[DSHPopupContainer alloc] initWithCustomPopupView:customView];
        self.container.autoDismissWhenClickedBackground=NO;
        self.container.maskColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
        [self.container show];
    }else{
        [FNTipsView showTips:@"没有商品"];
    }
}
-(void)customViewDiss{
    [self.container dismiss];
}
#pragma mark - FNArticleRecommendXViewDelegate // 点击提到的好货 
- (void)inRecommendXViewAction:(NSInteger)index{
    FNBaseProductModel *model=[FNBaseProductModel mj_objectWithKeyValues:self.hintArr[index]];
    [self goProductVCWithModel:model withData:model.data];
    [self.container dismiss];
}
#pragma mark -FNarticleRecommendItemCellDelegate // 点击头像或者名字
- (void)didArticleRecommendHeadItemAction:(NSIndexPath*)indexS{
    NSArray *articleArr=self.dataModel.article;
    FNArticleItemXModel *itemModel=[FNArticleItemXModel mj_objectWithKeyValues:articleArr[indexS.row]];
    FNArticleHomepageDController *vc=[[FNArticleHomepageDController alloc]init];
    vc.understand=NO;
    vc.talentID=itemModel.talent_id;
    vc.dataDictry=articleArr[indexS.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - FNArtcleRecommendItemNEWCellDelegate // 点击头像或者名字
- (void)didRecommendItemNEWCellAction:(NSIndexPath*)indexS{
    NSArray *articleArr=self.dataModel.article;
    FNEssayItemDModel *model=[FNEssayItemDModel mj_objectWithKeyValues:articleArr[indexS.row]];
    FNArticleHomepageDController *vc=[[FNArticleHomepageDController alloc]init];
    vc.understand=NO;
    vc.talentID=model.talent_id;
    vc.dataDictry=articleArr[indexS.row];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Table view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    
//    if (conY>0 && conY<=JMNavBarHeigth) {
//
//        [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
//        self.navigationView.titleLabel.textColor=[UIColor blackColor];
//        //滚动中FNMainGobalControlsColor
//        self.navigationView.backgroundColor = [FNWhiteColor colorWithAlphaComponent:conY/JMNavBarHeigth];
//    }else if (conY > JMNavBarHeigth){
//        self.navigationView.backgroundColor = FNWhiteColor;
//        self.navigationView.titleLabel.textColor=[UIColor blackColor];
//        [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
//    }
//
//    else{
//        self.navigationView.backgroundColor = [UIColor clearColor];
//        self.navigationView.titleLabel.textColor=[UIColor whiteColor];
//        [self.leftBtn setImage:IMAGE(@"return_w") forState:UIControlStateNormal];
//    }
    
    if(conY>FNDeviceHeight+50){
        self.topBtn.hidden=NO;
    }else{
        self.topBtn.hidden=YES;
    }
}
#pragma mark - // 达人说文章详情
-(FNRequestTool*)requestArticleDetails{
    @WeakObj(self);
    //@weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.articleID kr_isNotEmpty]){
       params[@"id"]=self.articleID;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=talentTalk&ctrl=detail" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //@strongify(self);
        //FNArticleDeailsXModel
        selfWeak.dataModel=[FNArticleDeailsXModel mj_objectWithKeyValues:respondsObject[DataKey]];
        selfWeak.dataDictry=respondsObject[DataKey];
        if([selfWeak.dataModel.info_url kr_isNotEmpty]){
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:selfWeak.dataModel.info_url]];
            [selfWeak.webLView loadRequest:request];
        }
        [selfWeak.jm_collectionview reloadData];
        selfWeak.navigationView.titleLabel.text=selfWeak.dataModel.shorttitle;
        if([selfWeak.dataModel.bg_navcolor kr_isNotEmpty]){
            selfWeak.navigationView.backgroundColor=[UIColor colorWithHexString:selfWeak.dataModel.bg_navcolor];
            [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
            [self.leftBtn setImage:IMAGE(@"return_w") forState:UIControlStateNormal];
        }else{
            [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
            [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
        }
        if([selfWeak.dataModel.bg_navfontcolor kr_isNotEmpty]){
            selfWeak.navigationView.titleLabel.textColor=[UIColor colorWithHexString:selfWeak.dataModel.bg_navfontcolor];
        }
        if([selfWeak.dataModel.return_img kr_isNotEmpty]){
           [self.leftBtn sd_setImageWithURL:URL(selfWeak.dataModel.return_img) forState:UIControlStateNormal];
        }
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

//达人说详情提到的商品
-(FNRequestTool*)requestTalentTalk{
    @WeakObj(self);
    //@weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.articleID kr_isNotEmpty]){
        params[@"id"]=self.articleID;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=talentTalk&ctrl=goods" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        //@strongify(self);
        XYLog(@"提到的:%@",respondsObject);
        NSDictionary *dictry=respondsObject;
        NSArray *arrM=dictry[@"goods_data"]; 
        selfWeak.hintArr=arrM;
        if(selfWeak.hintArr.count>0){
           selfWeak.remindBtn.hidden=NO;
        }else{
           selfWeak.remindBtn.hidden=YES;
        }
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
@end
