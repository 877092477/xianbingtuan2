//
//  FNmerchantIndentListController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerchantIndentListController.h"
#import "FNmerchantIndentItemController.h"
#import "FNCustomeNavigationBar.h"
#import "JXCategoryView.h"
#import "FNmerchantIndentModel.h"

@interface FNmerchantIndentListController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong)JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong)JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong)FNmerchantIndentModel *sortModel;
@property (nonatomic, strong)NSMutableArray *typeArr;
@end

@implementation FNmerchantIndentListController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([NSString isEmpty:UserAccessToken]) {
        [self warnToLogin];
    }
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - set up views
- (void)jm_setupViews{
    self.view.backgroundColor=RGB(246, 245, 245);
    [self setTopViews];
    [self sortTopView];
    [self requestExchange];
    
}
#pragma mark - set top views
- (void)setTopViews{
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
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    self.navigationView.titleLabel.text=self.keyWord?self.keyWord:@"交易订单";
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.leftBtn.imageView.sd_layout
    .centerYEqualToView(self.leftBtn).widthIs(8).heightIs(16).leftSpaceToView(self.leftBtn, 10);
    if(self.understand==YES){
        self.leftBtn.hidden=YES;
    }
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 交易类型
-(void)sortTopView{
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+1, FNDeviceWidth, 39)];
    self.categoryView.delegate = self;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.backgroundColor=[UIColor whiteColor];
    //self.categoryView.contentEdgeInsetLeft=15;
    //self.categoryView.contentEdgeInsetRight=15;
    //lineView
    self.lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.lineView.indicatorWidth = 60;//JXCategoryViewAutomaticDimension;
    //line颜色
    self.lineView.indicatorHeight=2;
    self.categoryView.indicators = @[self.lineView];
    [self.view addSubview:self.categoryView];
    
}
#pragma mark - 点击交易类型
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    
    //XYLog(@"JX滑动=%ld",(long)index);
    //NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    //NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    //NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.listContainerView didClickSelectedItemAtIndex:index];
}
- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}
#pragma mark - JXCategoryListContainerViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    id<JXCategoryListContentViewDelegate> list = [self preferredListAtIndex:index];
    return list;
}
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.typeArr.count;
}
- (id<JXCategoryListContentViewDelegate>)preferredListAtIndex:(NSInteger)index {
    FNmerchantIndentItemController *vc=[[FNmerchantIndentItemController alloc] init];
    FNmerchantIndentTypeModel *model=self.typeArr[index];
    vc.type=model.status;
    vc.indentModel=self.sortModel;
    vc.naviController = self.navigationController;
    return vc;
}
#pragma mark -    request
//商家中心-交易订单头部
-(FNRequestTool*)requestExchange{
    [SVProgressHUD show];
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=order_type" respondType:(ResponseTypeModel) modelType:@"FNmerchantIndentModel" success:^(id respondsObject) {
        @strongify(self);
        [SVProgressHUD dismiss];
        self.sortModel=respondsObject;
        NSArray *cateArr=self.sortModel.status;
        if(cateArr.count>0){
            NSMutableArray *nameArray=[NSMutableArray arrayWithCapacity:0];
            NSMutableArray *tyArray=[NSMutableArray arrayWithCapacity:0];
            [cateArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNmerchantIndentTypeModel *model=[FNmerchantIndentTypeModel mj_objectWithKeyValues:obj];
                [nameArray addObject:model.title];
                [tyArray addObject:model];
            }];
            self.typeArr=tyArray;
            self.categoryView.titleFont=kFONT14;
            self.categoryView.titleSelectedFont=kFONT14;
            self.categoryView.titleColor=RGB(140, 140, 140);
            self.categoryView.titleSelectedColor=[UIColor colorWithHexString:self.sortModel.select_color];
            self.lineView.indicatorColor=[UIColor colorWithHexString:self.sortModel.select_color];
            self.categoryView.titles =nameArray;
            [self.categoryView reloadData];
            
            if(self.typeArr.count>0){
                [self.categoryView selectItemAtIndex:0];
                CGFloat listTopGap=SafeAreaTopHeight+40;
                self.listContainerView = [[JXCategoryListContainerView alloc] initWithDelegate:self];
                self.listContainerView.didAppearPercent = 0.01; //滚动一点就触发加载
                self.listContainerView.frame = CGRectMake(0, listTopGap, FNDeviceWidth, FNDeviceHeight-listTopGap);
                [self.view addSubview:self.listContainerView];
                self.categoryView.contentScrollView = self.listContainerView.scrollView;
            }
        }
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:NO];
}
- (NSMutableArray *)typeArr{
    if (!_typeArr) {
        _typeArr = [NSMutableArray array];
    }
    return _typeArr;
}

@end
