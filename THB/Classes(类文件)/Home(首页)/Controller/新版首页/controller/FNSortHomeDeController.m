//
//  FNSortHomeDeController.m
//  THB
//
//  Created by Jimmy on 2018/12/14.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNSortHomeDeController.h"
//controller
#import "FNsortHomeListNeController.h"
#import "lhScanQCodeViewController.h"
#import "MsgCenterViewController.h"
#import "firstVersionSearchViewController.h"
#import "FNGoodsListViewController.h"
#import "FNNewProDetailController.h"
#import "FNGoodsListViewController.h"
#import "FNOddWelfareNeController.h"
#import "FNMemberGradeDeController.h"
#import "FNArrangesingleAeController.h"
#import "FNRelationUeController.h"
#import "FNSomeTimeTeController.h"
#import "FNhairContactsDeController.h"
#import "FNneckRedPacketNaController.h"
#import "FNConnectionsHomeController.h"
//model
#import "FNAPIHome.h"
#import "XYTitleModel.h"
#import "FNLeftclassifyModel.h"
#import "FNBNBouncedModel.h"
#import "FNParseTbWordModel.h"
//view
#import "FNcategoryShowDeView.h"
#import "FNUpPolicyPopupNeView.h"
#import "FNBNHomeBouncedView.h"
#import "FNIntelligentSearchNeView.h"
#import "FNCustomeNavigationBar.h"
#import "FNcenteringDeSearchBar.h"
#import "FNReckoningSetDeController.h"
#import "FNdrawRedPacketNaView.h"
#import "FNChatManager.h"
#import "FNPunchCardAeController.h"
#import "FNMaskBannerBackgroundView.h"
#import "D3View.h"
#import "SYNoticeBrowseLabel.h"

@interface FNSortHomeDeController ()<FNcategoryShowDeViewDelegate,UISearchBarDelegate, FNMaskControllerDelegate>
@property(nonatomic,strong)NSMutableArray *titles;
@property (nonatomic, strong)NSMutableArray *leftDataArr;
//@property (nonatomic, strong)NSMutableArray *rightDataArr;
@property(nonatomic,strong)NSString *leftclassifyID;
@property(nonatomic,strong)FNcategoryShowDeView *cateView;//二级分类
@property(nonatomic,strong)UIButton *optionBtn;//二级分类按钮点击
@property(nonatomic,strong)UIImageView *titleScrollBg;
@property (nonatomic,strong)FNBNBouncedModel *BouncedModel;
@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,strong)UIButton *rightBtn;
@property (nonatomic,strong)UIButton *searchBtn;
@property (nonatomic, strong)FNCustomeNavigationBar* cuNaivgationbar;
@property (nonatomic,strong) UIImageView *TopImageView;
@property (nonatomic,strong) FNcenteringDeSearchBar *centeringSearchBar;

@property (nonatomic, strong) FNMaskBannerBackgroundView *maskBackground;

@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) UIView *hbView;
@property (nonatomic, strong) UIImageView *hbimgView;
@property (nonatomic, strong) SYNoticeBrowseLabel *noticeLabel;
@property (nonatomic, strong) UIView        *msgView;
@property (nonatomic, strong) UIImageView   *msgBGView;
@property (nonatomic, strong) UIButton *hideGreenBtn;
@property (nonatomic, strong) UIButton *msgimgBtn;
@property (nonatomic, strong) FNHometipRedpacketModel *rbModel;
@property (nonatomic, strong) FNHometipRedpacketModel *rightPacketModel;
@property (nonatomic, assign) CGFloat HBPoinX;
@end

@implementation FNSortHomeDeController

- (FNMaskBannerBackgroundView*) maskBackground {
    if (_maskBackground == nil) {
        _maskBackground = [[FNMaskBannerBackgroundView alloc] init];
        [self.view insertSubview:_maskBackground atIndex:0];
        [_maskBackground mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(@0);
            make.width.mas_equalTo(XYScreenWidth);
//            make.height.equalTo(self.maskBackground.mas_width).multipliedBy(0);
        }];
    }

    return _maskBackground;
}


#pragma mark - 一些系统的方法
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
    
    [self popupPolicyView];
    
    [self.noticeLabel reloadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //SYNoticeBrowseLabel *noticeLabel = (SYNoticeBrowseLabel *)[self.view viewWithTag:100000];
    [self.noticeLabel releaseNotice];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"首页";
    [self apiRequestTopSearch];
    // 设置标题字体
    /*
     方式一：
     self.titleFont = [UIFont systemFontOfSize:20];
     */
    //分类
//    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
//        *titleHeight = 35;
//        // 设置标题字体
//        *titleFont = kFONT13;
//        *selColor  =RGB(246, 55, 151);
//    }];
    
    // 设置下标
    /*
     方式一
     // 是否显示标签
     self.isShowUnderLine = YES;
     
     // 标题填充模式
     self.underLineColor = [UIColor redColor];
     
     // 是否需要延迟滚动,下标不会随着拖动而改变
     self.isDelayScroll = YES;
     */
    
    // 分类 （设置下标）
//    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
//        // 是否显示标签
//        *isShowUnderLine = YES;
//        // 标题填充模式
//        *underLineColor = RGB(246, 55, 151);
//        // 是否需要延迟滚动,下标不会随着拖动而改变
//        *isDelayScroll = YES;
//    }];
    // 设置全屏显示
    // 如果有导航控制器或者tabBarController,需要设置tableView额外滚动区域,详情请看FullChildViewController
    self.isfullScreen = NO;
    self.view.backgroundColor = UIColor.clearColor;
    self.contentView.frame=CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, JMScreenHeight-SafeAreaTopHeight);
    [self apiRequestCategory];
    
    [self apiRequestTwoCategory];
    //[self setupChildVc];
    [self setupNav];
    
    
    
    [FNNotificationCenter addObserver:self selector:@selector(obserHomeChange) name:@"HomeSeleted" object:nil];
    [FNNotificationCenter addObserver:self selector:@selector(obserHomeRoll) name:@"HomeRoll" object:nil];
    [FNNotificationCenter addObserver:self selector:@selector(obserHomeEndRoll) name:@"HomeEndRoll" object:nil];
    
    if (![NSString checkIsSuccess:[FNBaseSettingModel settingInstance].indexsearch_onoff andElement:@"1"]) {
        [FNNotificationCenter addObserver:self selector:@selector(observingPastedChange:) name:@"pastedChange" object:nil];

        [FNNotificationCenter postNotificationName:@"pastedChange" object:nil];
    }
    
    [self apiRequestBounced];
    
//    YZDisplayViewClickOrScrollDidFinshNote
    
    
}

-(void)obserHomeChange{
    self.optionBtn.selected=NO;
    [UIView animateWithDuration:1.0f animations:^{
        self.cateView.hidden=YES;
    } completion:^(BOOL finished) {
    }];
}
-(void)dealloc{
    [FNNotificationCenter removeObserver:self];
}
#pragma mark -  二级分类（食品++）
-(void)showCateView{
    self.cateView=[FNcategoryShowDeView new];
    self.cateView.delegate=self;
    self.cateView.hidden=YES;
    [self.contentView addSubview:self.cateView];
    self.cateView.backgroundColor=[UIColor redColor];
    [self.contentView bringSubviewToFront:self.cateView];
    self.cateView.sd_layout
    .topSpaceToView(self.titleScrollView, 0).rightSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, XYTabBarHeight);
    
}
#pragma mark -  FNcategoryShowDeViewDelegate // 二级选择分类
- (void)showDeRightViewAction:(FNRightclassifyModel*)sender{
    FNGoodsListViewController *VC=[FNGoodsListViewController new];
    VC.keyword=sender.keyword; 
    [self.navigationController pushViewController:VC animated:YES];
    [self obserHomeChange];
}
#pragma mark - //查看二级分类
-(void)optionBtnAction:(UIButton *)btn{
    btn.selected=!btn.selected;
    [UIView animateWithDuration:1.0f animations:^{
        self.cateView.hidden=!btn.selected; 
    } completion:^(BOOL finished) {
    }];
    
}

#pragma mark - //导航栏
-(void)setupNav{
    
//    UIButton *leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [leftBtn setTitleColor:FNBlackColor forState:UIControlStateNormal];
//    //[leftBtn setImage:IMAGE(@"FN_scanDe_img") forState:UIControlStateNormal];
//    [leftBtn sizeToFit];
//    [leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.leftBtn.size=CGSizeMake(30,  30);
//    self.leftBtn=leftBtn;
//    UIButton * searchBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//    searchBtn.height=35;
//    searchBtn.backgroundColor=RGB(241, 241, 241);
//    [searchBtn sizeToFit];
//    searchBtn.titleLabel.font = kFONT13;
//    searchBtn.cornerRadius=35/2;
//    [searchBtn setImage:IMAGE(@"partner_search") forState:UIControlStateNormal];
//    [searchBtn setTitleColor:FNGlobalTextGrayColor forState:UIControlStateNormal];
//    [searchBtn setTitle:@"粘贴宝贝标题,先领券在购物" forState:UIControlStateNormal];
//    [searchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [searchBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10.0f];
//    self.searchBtn=searchBtn;
//    UIButton *rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [rightBtn setImage:[UIImage imageNamed:@"FN_serviceDe_img"] forState:UIControlStateNormal];
//    [rightBtn sizeToFit];
//    rightBtn.size = CGSizeMake(rightBtn.width, rightBtn.height);
//    [rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.rightBtn=rightBtn;
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
//    self.navigationItem.titleView =self.searchBtn;
//
//    searchBtn.sd_layout
//    .heightIs(self.navigationItem.titleView.height).leftSpaceToView(leftBtn, 20).widthIs(JMScreenWidth-60*2);
    
    self.TopImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, SafeAreaTopHeight)];
    self.TopImageView.image=IMAGE(@"");
    self.TopImageView.backgroundColor=[UIColor clearColor];//[_end_ColorStrr?[UIColor colorWithHexString:_end_ColorStrr]:FNMainGobalControlsColor colorWithAlphaComponent:0];
    [self.view addSubview:self.TopImageView];
    
    _cuNaivgationbar = [FNCustomeNavigationBar customeNavigationBarWithSearchBarFrame:(CGRectMake(80, 27, FNDeviceWidth-80*2, 30)) andPlaceholder:@""];
    //NSLog(@"app_seach_str:%@",[FNBaseSettingModel settingInstance].app_seach_str);
    _cuNaivgationbar.searchBar.cornerRadius = 15;
    _cuNaivgationbar.searchBar.delegate  =self;
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSFontAttributeName: kFONT14}];
    
    _cuNaivgationbar.searchBar.backgroundColor=RGBA(246, 245, 245, 0);
    
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [self.leftBtn setImage:[UIImage imageNamed:@"FN_scanDe_img"] forState:UIControlStateNormal];
//    [self.leftBtn sizeToFit];
    //self.leftBtn.size = CGSizeMake(self.leftBtn.width+10, self.leftBtn.height+10);
    self.leftBtn.size = CGSizeMake(30, 30);
//    [self.leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [self.rightBtn setImage:[UIImage imageNamed:@"FN_serviceDe_img"] forState:UIControlStateNormal];
//    [self.rightBtn sizeToFit];
    //self.rightBtn.size = CGSizeMake(self.rightBtn.width+10, self.rightBtn.height+10);
    self.rightBtn.size = CGSizeMake(30, 30);
//    [self.rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    _cuNaivgationbar.leftButton = self.leftBtn;
    _cuNaivgationbar.rightButton = self.rightBtn;
    [self.view addSubview:_cuNaivgationbar];
    _cuNaivgationbar.backgroundColor =[UIColor clearColor];
    [_cuNaivgationbar.searchBar setBackgroundColor:RGBA(246, 245, 245,0.3)];
    _cuNaivgationbar.searchBar.backgroundImage = [UIImage createImageWithColor:RGBA(246, 245, 245,0.3)];
    UITextField *searchField = [_cuNaivgationbar.searchBar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor clearColor]];
    }
    
    self.leftBtn.imageView.sd_layout
    .centerYEqualToView(self.leftBtn).centerXEqualToView(self.leftBtn).widthIs(20).heightIs(20);
    
    self.rightBtn.imageView.sd_layout
    .centerYEqualToView(self.rightBtn).centerXEqualToView(self.rightBtn).widthIs(20).heightIs(20);
    
}
#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    firstVersionSearchViewController *vc = [[firstVersionSearchViewController alloc]init]; 
    [self.navigationController pushViewController:vc animated:YES];
    //[self didFNSkipController:@"HomeViewController"];
   
    return NO;
}
#pragma mark - //搜索
-(void)searchBtnAction
{
    firstVersionSearchViewController *vc = [[firstVersionSearchViewController alloc]init]; 
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - //setupChildVc 添加子视图
- (void)setupChildVc
{
    if (_titles.count>0) {
        for (int i = 0 ; i<_titles.count; i++) {
            
            XYTitleModel *model=_titles[i];
            FNsortHomeListNeController *VC = [[FNsortHomeListNeController alloc] init];
            VC.title = model.catename;
            //VC.type = @"";
            VC.categoryId= model.id;
            VC.keyword= model.keyword;
            VC.showtype= model.show_type_str;
            VC.delegate = self;
            XYLog(@"cid:%@",model.id);
            [self addChildViewController:VC];
        }
    }
    [self refreshDisplay];
    [SVProgressHUD dismiss];
    self.optionBtn.hidden=NO;
    
    //[self isRightBottomAddSubViews];
    
    [self requestTipList];
    
}

#pragma mark - //获取分类数据
- (FNRequestTool *)apiRequestCategory{
   @WeakObj(self);
   [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes], @"is_index": @"1"}];
   return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appCate02&ctrl=getCate" respondType:(ResponseTypeArray) modelType:@"XYTitleModel" success:^(id respondsObject) {
         NSMutableArray *dataArray=[NSMutableArray arrayWithCapacity:0];
         NSArray *titles = respondsObject;
         if (titles.count > 0) {
             [titles enumerateObjectsUsingBlock:^(XYTitleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                 [dataArray addObject:obj];
             }];
             selfWeak.titles=dataArray;
             [selfWeak setupChildVc];
           }
        } failure:^(NSString *error) {

    } isHideTips:YES];
}
#pragma mark - //获取二级分类列表
- (FNRequestTool *)apiRequestTwoCategory{
    @WeakObj(self);
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appCate02&ctrl=showTwoCate" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        
        NSArray* array = respondsObject[DataKey];
        NSMutableArray *typeArr=[NSMutableArray arrayWithCapacity:0];
        for (NSInteger i = 0; i < array.count; i ++) {
            NSDictionary* dictry = array[i];
            FNLeftclassifyModel *model=[FNLeftclassifyModel mj_objectWithKeyValues:dictry];
            if(i==0){
                model.select_type=1;
            }else{
                model.select_type=0;
            }
            [typeArr addObject:model];
        }
        FNLeftclassifyModel *oneModel=typeArr[0];
        selfWeak.leftclassifyID=oneModel.id;
        
        selfWeak.leftDataArr=typeArr;
        [SVProgressHUD dismiss];
        selfWeak.cateView.leftDataArr=typeArr;
        //[selfWeak apiRequestLeftCategory];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark - //首页新样式搜索栏
- (FNRequestTool *)apiRequestTopSearch{
    @WeakObj(self);
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appDiyIndex02&ctrl=top_search" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"搜索top:%@",respondsObject);
        NSArray* arr = respondsObject[DataKey];
        if (arr.count > 0) {
            NSDictionary *dictry=arr[0];
            NSArray *listArr=dictry[@"list"];
            if (listArr.count > 0) {
                NSDictionary *listItem=listArr[0];
                NSArray *imgArr=listItem[@"imgArr"];
                if (imgArr.count > 0) {
                    NSDictionary *leftItem=imgArr[0];
                    NSString *leftImg=leftItem[@"img"];
                    
                    [selfWeak.leftBtn sd_setImageWithURL:URL(leftImg) forState:UIControlStateNormal];
                    [selfWeak.leftBtn addJXTouch:^{
                        [selfWeak loadOtherVCWithModel:leftItem andInfo:nil outBlock:nil];
                    }];
                }
                if (imgArr.count > 1) {
                    NSDictionary *rightItem=imgArr[1];
                    NSString *rightImg=rightItem[@"img"];
                    [selfWeak.rightBtn sd_setImageWithURL:URL(rightImg) forState:UIControlStateNormal];
                    [selfWeak.rightBtn addJXTouch:^{
                        [selfWeak loadOtherVCWithModel:rightItem andInfo:nil outBlock:nil];
                    }];
                }
                
                
                [selfWeak.TopImageView setNoPlaceholderUrlImg:listItem[@"top_bjimg"]];
                selfWeak.cuNaivgationbar.searchBar.placeholder=listItem[@"str"];
                selfWeak.cuNaivgationbar.searchColor=listItem[@"search_color"];
                selfWeak.cuNaivgationbar.searchImg=listItem[@"search_img"];
                NSString *catestr_color=listItem[@"catestr_color"];
                NSString *catestr_color1=listItem[@"catestr_color1"];
                
                NSString *bannerBili = listItem[@"banner_topbj_bili"];
                if ([bannerBili kr_isNotEmpty]) {
                    [self.maskBackground mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.height.equalTo(self.maskBackground.mas_width).multipliedBy([bannerBili floatValue]);
                    }];
                }
                
                [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
                    *titleHeight = 35;
                    // 设置标题字体
                    //*titleFont = kFONT13;
                    //*selColor  =RGB(246, 55, 151);
                    if([catestr_color kr_isNotEmpty]){
                        *norColor=[UIColor colorWithHexString:catestr_color];
                    }
                    if([catestr_color1 kr_isNotEmpty]){
                        *selColor=[UIColor colorWithHexString:catestr_color1];
                    }
                    
                }];
                //self.isShowTitleScale=YES;
                
                
                [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
                    // 是否显示标签
                    *isShowUnderLine = YES;
                    // 标题填充模式
                    //*underLineColor = RGB(246, 55, 151);
                    if([catestr_color1 kr_isNotEmpty]){
                        *underLineColor =[UIColor colorWithHexString:catestr_color1];
                    }
                    // 是否需要延迟滚动,下标不会随着拖动而改变
                    //*isDelayScroll = YES;
                }];
                [self setTopCate];
                [selfWeak.titleScrollBg setNoPlaceholderUrlImg:listItem[@"cate_bjimg"]];
                NSString *cate_ico=listItem[@"cate_ico"];
                if([cate_ico kr_isNotEmpty]){
                    [self.optionBtn sd_setImageWithURL:[NSURL URLWithString:cate_ico] forState:UIControlStateNormal];
                    [self.optionBtn sd_setImageWithURL:[NSURL URLWithString:cate_ico] forState:UIControlStateSelected];
                }
                XYLog(@"搜索IMG:%@",dictry);
            }
        }
        
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
-(void)setTopCate{
    self.isfullScreen = NO;
    self.contentView.frame=CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, JMScreenHeight-SafeAreaTopHeight);
    UIImageView *titleScrollBg=[[UIImageView alloc]init];
    //titleScrollBg.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:titleScrollBg];
    self.titleScrollBg=titleScrollBg;
    
    self.titleScrollBg.sd_layout
    .topSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(35);
    
    [self.contentView addSubview:self.titleScrollView];
    self.titleScrollView.backgroundColor=[UIColor clearColor];
    self.titleScrollView.sd_layout
    .topSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 40).heightIs(35);
    //self.titleScrollView.sd_layout
    //.topSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 40).heightIs(35);
    
    //更多
    UIButton *optionBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [optionBtn setImage:IMAGE(@"home_list_norFN") forState:UIControlStateNormal];
    [optionBtn setImage:IMAGE(@"home_backFN") forState:UIControlStateSelected];
    optionBtn.adjustsImageWhenHighlighted = NO;
    optionBtn.size=CGSizeMake(30, 30);
    [optionBtn addTarget:self action:@selector(optionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    optionBtn.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:optionBtn];
    self.optionBtn=optionBtn;
    self.optionBtn.sd_layout
    .rightSpaceToView(self.contentView, 5).topSpaceToView(self.contentView, 2.5).widthIs(30).heightIs(30);
    
    self.optionBtn.imageView.sd_layout
    .centerYEqualToView(self.optionBtn).centerXEqualToView(self.optionBtn).widthIs(15).heightIs(9);
    
    [self refreshDisplay];
    
    [self showCateView];
}
#pragma mark - 弹框广告
-(FNRequestTool *)apiRequestBounced{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appHigh&ctrl=indexGuanggao" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"广告:%@",respondsObject);
        NSArray* dataarr = respondsObject[DataKey];
        if (dataarr.count>=1) {
            self.BouncedModel=[FNBNBouncedModel mj_objectWithKeyValues:[dataarr firstObject]];
            NSDictionary *dictry=[dataarr firstObject];
            [FNBNHomeBouncedView showWithModel:self.BouncedModel view:self.view purchaseblock:^(id model) {
                [self loadOtherVCWithModel:dictry andInfo:nil outBlock:nil];
            }];
        }
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
#pragma mark - 弹出隐私政策
-(void)popupPolicyView{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSInteger privacy_onoff = [[defaults objectForKey:@"privacy_onoff"] integerValue];
    if(privacy_onoff==0 && [[FNBaseSettingModel settingInstance].privacy_onoff isEqualToString:@"1"]){
        FNUpPolicyPopupNeView *policyview=[[FNUpPolicyPopupNeView alloc]initWithFrame:CGRectMake(0, 0, JMScreenWidth, JMScreenHeight) andHeight:JMScreenHeight-200];
        policyview.alpha = 0;
        [[UIApplication sharedApplication].keyWindow addSubview:policyview];
        [policyview showView];
    }
}
#pragma mark - 智能搜索
- (void)observingPastedChange:(NSNotification*)ntf{
    
}
#pragma mark - //首页提示及红包图
-(FNRequestTool*)requestTipList{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=indexTipList&ctrl=index" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        [self isRightBottomAddSubViews];
        NSDictionary* dictry = respondsObject[DataKey];
        self.rbModel=[FNHometipRedpacketModel mj_objectWithKeyValues:dictry];
        if(self.rbModel.redpacket.count>0){
           self.hbView.hidden=NO;
           self.rightPacketModel=[FNHometipRedpacketModel mj_objectWithKeyValues:self.rbModel.redpacket[0]];
           [self.hbimgView setUrlImg:self.rightPacketModel.img];
        }
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in self.rbModel.tip_list) {
            FNHometipRedpacketModel *tipModel=[FNHometipRedpacketModel mj_objectWithKeyValues:dic];
            [arrM addObject:tipModel.content];
        }
        if(self.rbModel.tip_list.count>0){
            FNHometipRedpacketModel *tipOneModel=[FNHometipRedpacketModel mj_objectWithKeyValues:self.rbModel.tip_list[0]];
            self.noticeLabel.textColor=[UIColor colorWithHexString:tipOneModel.content_color];
            [self.msgimgBtn sd_setImageWithURL:URL(tipOneModel.msgimg) forState:UIControlStateNormal];
            [self.hideGreenBtn sd_setImageWithURL:URL(tipOneModel.closeimg) forState:UIControlStateNormal];
            [self.msgBGView setUrlImg:tipOneModel.img];
            if([tipOneModel.is_new integerValue]==1){
                self.msgView.hidden=NO;
               [self showAfficheAction];
            }
        }
        if(self.rbModel.tip_list.count>1){
            self.noticeLabel.browseMode = SYNoticeBrowseVerticalScrollWhileMore;
            self.noticeLabel.delayTime=3.0; 
            self.noticeLabel.durationTime = 3.0;
        }else{
            self.noticeLabel.browseMode = SYNoticeBrowseHorizontalScrollWhileSingle;
        }
        self.noticeLabel.texts = arrM;
        [self.noticeLabel reloadData];
        
    } failure:^(NSString *error) {
    } isHideTips:YES isCache:NO];
}
#pragma mark - //首页温馨提示关闭操作
-(FNRequestTool*)requestTipListClose{
    //@weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=indexTipList&ctrl=close" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //@strongify(self);
        NSInteger state=[respondsObject[SuccessKey] integerValue];
        //NSString *msgStr=respondsObject[MsgKey];
        //[FNTipsView showTips:msgStr];
        if(state==1){
          
        }
    } failure:^(NSString *error) {
    } isHideTips:YES isCache:NO];
}
- (NSMutableArray *)titles{
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}
-(NSMutableArray *)leftDataArr{
    if (!_leftDataArr) {
         _leftDataArr = [NSMutableArray array];
    }
    return _leftDataArr;
    
}

#pragma mark - FNMaskControllerDelegate
- (void)controller: (FNsortHomeListNeController*)controller didMaskBackground: (NSString*)bgImgUrl foreground: (NSString*)foreImgUrl percent: (CGFloat)percent {
    [self.maskBackground setBackgroundImage:bgImgUrl];
    [self.maskBackground setForegroundImage:foreImgUrl];
    [self.maskBackground setPercent:percent];
}

#pragma mark - scroll view delegate
- (void)onItemChange: (NSNotification*)noti {
    
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        if ([noti.object isEqual:self.childViewControllers[i]] && [self.childViewControllers[i] isKindOfClass:[FNsortHomeListNeController class]]) {
            FNsortHomeListNeController *vc = (FNsortHomeListNeController*)self.childViewControllers[i];
            [vc playBanner];
        } else if ([self.childViewControllers[i] isKindOfClass:[FNsortHomeListNeController class]]) {
            FNsortHomeListNeController *vc = (FNsortHomeListNeController*)self.childViewControllers[i];
            [vc stopBanner];
        }
    }
}
#pragma mark - 右下 Views 温馨提示和红包
-(void)isRightBottomAddSubViews{
    //不能在这里做刷新UI操作
    self.HBPoinX=FNDeviceWidth-80;
    self.hbView=[[UIView alloc]init];
    self.hbView.hidden=YES;
    [self.view addSubview:self.hbView];
    [self.view bringSubviewToFront:self.hbView];
    self.hbimgView=[[UIImageView alloc]init];
    //self.hbimgView.image=IMAGE(@"FN_YB_homeimg");
    [self.hbView addSubview:self.hbimgView];
    self.hbView.frame = CGRectMake(self.HBPoinX+50, XYScreenHeight - 280, 74, 62);
//    [self.hbView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view.mas_bottom).offset(-200);
//        make.right.equalTo(self.view.mas_right).offset(-8);
//        make.height.mas_equalTo(62);
//        make.width.mas_equalTo(74);
//    }];
    [self.hbimgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.hbView);
    }];
    self.hbView.userInteractionEnabled=YES;
    self.hbimgView.userInteractionEnabled=YES;
    UITapGestureRecognizer *hbimgViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hbimgViewClick)];
    [self.hbimgView addGestureRecognizer:hbimgViewTap];
    self.hbimgView.alpha=0.5f;
 
//    @WeakObj(self);
//    dispatch_queue_t queue = dispatch_get_main_queue();
//    //创建定时器
//    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//    //设置定时器
//    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0*NSEC_PER_SEC));
//    uint64_t interval = (uint64_t)(1.0*NSEC_PER_SEC);
//    dispatch_source_set_timer(self.timer, start, interval, 0);
//    //设置
//    dispatch_source_set_event_handler(self.timer, ^{
//        [selfWeak.hbView d3_swing];
//        static int gcdIdx = 0;
//        gcdIdx++;
//        if(gcdIdx == 200) {
//            // 终止
//            dispatch_suspend(selfWeak.timer);
//        }
//    });
//    //启动定时器
//    dispatch_resume(self.timer);
    
    self.msgView=[[UIView alloc]init];
    self.msgView.hidden=YES;
    [self.view addSubview:self.msgView];
    self.msgView.frame=CGRectMake(0, FNDeviceHeight, FNDeviceWidth, 33);
    
    self.msgBGView=[[UIImageView alloc]init];
    [self.msgView addSubview:self.msgBGView];
    self.msgBGView.frame=CGRectMake(0, 0, FNDeviceWidth, 33);
    
    self.noticeLabel = [[SYNoticeBrowseLabel alloc] initWithFrame:CGRectMake(33, 0, FNDeviceWidth-70, 33)];
    [self.msgView addSubview:self.noticeLabel];
    self.noticeLabel.frame=CGRectMake(33, 0, FNDeviceWidth-70, 33);
    self.noticeLabel.tag = 100000;
    //self.noticeLabel.backgroundColor =  RGBA(205, 234, 212, 0.7);
    self.noticeLabel.textColor =  RGB(68, 133, 105);
    self.noticeLabel.textFont = [UIFont systemFontOfSize:13.0];
    NSArray *tessArr=@[@""];
    self.noticeLabel.texts = tessArr;
    @weakify(self);
    self.noticeLabel.textClick = ^(NSInteger index){
        //XYLog(@"点击时，暂停动画；点击释放时，恢复动画。");
        @strongify(self);
        NSDictionary *dictry=self.rbModel.tip_list[0];
        [self loadOtherVCWithModel:dictry andInfo:nil outBlock:nil];
    };
    //self.noticeLabel.images = @[[UIImage imageNamed:@""]];
    self.noticeLabel.browseMode = SYNoticeBrowseHorizontalScrollWhileSingle;
    
    self.msgimgBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.msgimgBtn setImage:IMAGE(@"FN_homeGTzimg") forState:UIControlStateNormal];
    [self.msgView addSubview:self.msgimgBtn];
    [self.msgimgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.msgView.mas_top).offset(0);
        make.left.equalTo(self.msgView.mas_left).offset(7);
        make.height.mas_equalTo(33);
        make.width.mas_equalTo(33);
    }];
    self.msgimgBtn.imageView.sd_layout
    .centerXEqualToView(self.msgimgBtn).centerYEqualToView(self.msgimgBtn).widthIs(16).heightIs(12);
    
    self.hideGreenBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.hideGreenBtn addTarget:self action:@selector(hideAfficheAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.hideGreenBtn setImage:IMAGE(@"FN_homeGGbimg") forState:UIControlStateNormal];
    [self.msgView addSubview:self.hideGreenBtn];
    [self.hideGreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.msgView.mas_bottom).offset(-4);
        make.right.equalTo(self.msgView.mas_right).offset(-10);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(25);
    }];
    self.hideGreenBtn.imageView.sd_layout
    .centerXEqualToView(self.hideGreenBtn).centerYEqualToView(self.hideGreenBtn).widthIs(9).heightIs(9);
}
//点击红包
-(void)hbimgViewClick{
    [self loadOtherVCWithModel:self.rightPacketModel andInfo:nil outBlock:nil];
}
//显示温馨提示
-(void)showAfficheAction{
    @WeakObj(self);
    CGFloat bottomTap=FNDeviceHeight-XYTabBarHeight-33;
    selfWeak.msgView.hidden=NO;
    [UIView animateWithDuration:0.6f animations:^{
        selfWeak.msgView.frame=CGRectMake(0, bottomTap, FNDeviceWidth, 33);
    }];
}
//隐藏温馨提示
-(void)hideAfficheAction{
    CGFloat bottomTap=FNDeviceHeight;
    @WeakObj(self);
    [UIView animateWithDuration:0.6f animations:^{
        selfWeak.msgView.frame=CGRectMake(0, bottomTap, FNDeviceWidth, 33);
    } completion:^(BOOL finished) {
        selfWeak.msgView.hidden=YES;
    }];
    if(![NSString isEmpty:UserAccessToken]){
       [self requestTipListClose];
    }
}
//显示红包
-(void)showHBViewAction{
    @WeakObj(self);
    [UIView animateWithDuration:0.6f animations:^{
        selfWeak.hbView.frame=CGRectMake(self.HBPoinX, self.hbView.frame.origin.y, 74, 62);
        selfWeak.hbimgView.alpha=1.0f;
    } completion:^(BOOL finished) {
    }];
}
//向右移动红包
-(void)hideHBViewAction{
    @WeakObj(self);
    [UIView animateWithDuration:0.6f animations:^{
        selfWeak.hbView.frame=CGRectMake(self.HBPoinX+50, self.hbView.frame.origin.y, 74, 62);
        selfWeak.hbimgView.alpha=0.5f;
    } completion:^(BOOL finished) {
    }];
}
//滑动
-(void)obserHomeRoll{
    [self hideHBViewAction];
}
//滑动结束
-(void)obserHomeEndRoll{
    [self showHBViewAction];
}

@end
