//
//  FNdistrictExchangeController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/7.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdistrictExchangeController.h"
#import "FNdisExchangeItemController.h"
#import "FNdisOddLaunchController.h"
#import "FNdistrictExchangeModel.h"
#import "JXCategoryView.h"
#import "FNCustomeNavigationBar.h"
@interface FNdistrictExchangeController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate,FNdisOddLaunchControllerDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong)JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong)NSMutableArray *typeArr;
@property (nonatomic, strong)UIButton *addBtn;

@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@property (nonatomic, assign) BOOL shouldHandleScreenEdgeGesture;
@property (nonatomic, assign) BOOL isNeedIndicatorPositionChangeItem;
@property (nonatomic, assign) NSInteger seletedItem;
@end

@implementation FNdistrictExchangeController
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
- (instancetype)init
{
    self = [super init];
    if (self) {
        _shouldHandleScreenEdgeGesture = YES;
        _isNeedIndicatorPositionChangeItem=YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - set up views
- (void)jm_setupViews{
    self.view.backgroundColor=RGB(250, 250, 250);
    [self setTopViews];
    [self sortTopView];
    [self requestExchange];
    
    self.addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.addBtn addTarget:self action:@selector(addBtnAction)];
    [self.addBtn setImage:IMAGE(@"FN_disExaddimg") forState:UIControlStateNormal];
    
} 
-(void)addBtnAction{
    FNdisOddLaunchController *vc=[[FNdisOddLaunchController alloc]init];
    vc.delegate=self;
    vc.index=self.seletedItem;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -FNdisOddLaunchControllerDelegate //发布 刷新
- (void)didOddLaunchStateAction:(NSInteger)index{
   [self.categoryView selectItemAtIndex:index];
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
    self.navigationView.titleLabel.text=self.keyWord?self.keyWord:@"交易";
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
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+1, FNDeviceWidth, 44)];
    self.categoryView.delegate = self;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.backgroundColor=[UIColor whiteColor];
    //self.categoryView.contentEdgeInsetLeft=15;
    //self.categoryView.contentEdgeInsetRight=15;
    //lineView
    self.lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.lineView.indicatorWidth = 40;//JXCategoryViewAutomaticDimension;
    //line颜色
    self.lineView.indicatorHeight=2;
    self.categoryView.indicators = @[self.lineView];
    [self.view addSubview:self.categoryView];
    
}
#pragma mark - 点击交易类型
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    if (_shouldHandleScreenEdgeGesture) {
        self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    }
    self.seletedItem=index;
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
    FNdisExchangeItemController *vc=[[FNdisExchangeItemController alloc] init];
    FNdisExchangeSortItemModel *model=self.typeArr[index];
    vc.type=model.type;
    vc.naviController = self.navigationController; 
    return vc;
}
#pragma mark - //  交易页面的几个分类
-(FNRequestTool*)requestExchange{
    //@WeakObj(self);
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
   
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=qkb&ctrl=transaction_list" respondType:(ResponseTypeModel) modelType:@"FNdisExchangeSortModel" success:^(id respondsObject) {
        @strongify(self);
        FNdisExchangeSortModel *sortModel=respondsObject;
        NSArray *cateArr=sortModel.list;

        if(cateArr.count>0){
            NSMutableArray *nameArray=[NSMutableArray arrayWithCapacity:0];
            NSMutableArray *tyArray=[NSMutableArray arrayWithCapacity:0];
            [cateArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNdisExchangeSortItemModel *model=[FNdisExchangeSortItemModel mj_objectWithKeyValues:obj];
                [nameArray addObject:model.title];
                [tyArray addObject:model];
            }];
            self.typeArr=tyArray;
            self.categoryView.titleFont=kFONT16;
            self.categoryView.titleSelectedFont=kFONT16;
            self.categoryView.titleColor=RGB(153, 153, 153);
            self.categoryView.titleSelectedColor=[UIColor colorWithHexString:sortModel.dominant_color];
            self.lineView.indicatorColor=[UIColor colorWithHexString:sortModel.dominant_color];
            self.categoryView.titles =nameArray;
            [self.categoryView reloadData];
           
            if(self.typeArr.count>0){
                [self.categoryView selectItemAtIndex:0];
                CGFloat listTopGap=SafeAreaTopHeight+45;
                self.listContainerView = [[JXCategoryListContainerView alloc] initWithDelegate:self];
                self.listContainerView.didAppearPercent = 0.01; //滚动一点就触发加载
                self.listContainerView.frame = CGRectMake(0, listTopGap, FNDeviceWidth, FNDeviceHeight-listTopGap);
                [self.view addSubview:self.listContainerView];
                self.categoryView.contentScrollView = self.listContainerView.scrollView;
                if (self.addBtn.superview != self.view) {
                    [self.view addSubview:self.addBtn];
                    self.addBtn.sd_layout
                    .rightSpaceToView(self.view, 5).bottomSpaceToView(self.view, 100).widthIs(64).heightIs(64);
                } 
            }
        }
        
    } failure:^(NSString *error) {
        
    } isHideTips:NO];
}
- (NSMutableArray *)typeArr{
    if (!_typeArr) {
        _typeArr = [NSMutableArray array];
    }
    return _typeArr;
}

#pragma mark - JXCategoryListContentViewDelegate

//- (UIView *)listView {
//    return self.view;
//}

@end
