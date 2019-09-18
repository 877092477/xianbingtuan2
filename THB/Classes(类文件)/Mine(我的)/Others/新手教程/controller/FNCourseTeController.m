//
//  FNCourseTeController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/9.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNCourseTeController.h"
#import "FNCustomeNavigationBar.h"
#import "FNCouseItemTeCell.h"
#import "FNCourseTeModel.h"
#import "JhScrollActionSheetView.h"
#import "JhPageItemModel.h"
@interface FNCourseTeController ()<UICollectionViewDelegate,UICollectionViewDataSource,FNCouseItemTeCellDegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation FNCourseTeController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
 
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([NSString isEmpty:UserAccessToken]) {
        [self warnToLogin];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - set up views
- (void)jm_setupViews{
    
    self.view.backgroundColor =RGB(240, 240, 240);
    CGFloat baseGap=0;
    if(self.understand==YES){
        baseGap=XYTabBarHeight;
    }
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, FNDeviceHeight-baseGap-SafeAreaTopHeight) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=RGB(240, 240, 240);
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.hidden = YES;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNCouseItemTeCell class] forCellWithReuseIdentifier:@"FNCouseItemTeCellID"];
    
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30); 
    self.navigationView.leftButton = self.leftBtn;
    [self.view addSubview:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 18);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    self.navigationView.titleLabel.text=self.keyWord?self.keyWord:@"新手教程";//;
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.leftBtn.imageView.sd_layout
    .centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16).leftSpaceToView(self.leftBtn, 10);
    if(self.understand==YES){
       self.leftBtn.hidden=YES;
    }
    if([UserAccessToken kr_isNotEmpty]){
      [self apiRequestCourse:NO];
    }
    
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNCouseItemTeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNCouseItemTeCellID" forIndexPath:indexPath];
    cell.backgroundColor=RGB(240, 240, 240);
    FNCourseTeModel *model=self.dataArray[indexPath.row];
    cell.model=model;
    cell.delegate=self;
    cell.indexPath=indexPath;
    return cell; 
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=220;
    CGFloat with=FNDeviceWidth;
    CGSize size = CGSizeMake(with, height);
    return size;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNCourseTeModel *model=self.dataArray[indexPath.row];
    [self loadOtherVCWithModel:model andInfo:nil outBlock:nil];
    
}
#pragma mark - //FNCouseItemTeCellDegate // 点击分享
- (void)inCouseItemShareAction:(NSIndexPath *)indexPath{
    FNCourseTeModel *model=self.dataArray[indexPath.row];
    XYLog(@"row:%ld",(long)indexPath.row);
    NSArray *datas = @[@{@"text" : @"微信",@"img" : @"FJ_wximg"},@{@"text" : @"朋友圈",@"img" : @"FJ_pyimg"},@{@"text" : @"QQ",@"img" : @"FJ_qqimg"},@{@"text" : @"微博",@"img" : @"FJ_wbimg"}];
    NSMutableArray *shareArray=[NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *data in datas) {
        JhPageItemModel *item = [[JhPageItemModel alloc] init];
        item.text = data[@"text"];
        item.img = data[@"img"];
        [shareArray addObject:item];
    }
    NSString *hintString=@"";
    //@weakify(self);
    [JhScrollActionSheetView  showShareActionSheetWithTitle:@"" withdescribe:hintString shareDataArray:shareArray handler:^(JhScrollActionSheetView *actionSheet, NSInteger index) {
        //@strongify(self);
        [self shareType:index withModel:model];
    }];
}
-(void)shareType:(NSInteger)sender withModel:(FNCourseTeModel *)model{
    
    UMSocialPlatformType type=UMSocialPlatformType_WechatSession;
    if (sender==0) {
        type=UMSocialPlatformType_WechatSession;
    }else if (sender==1) {
        type=UMSocialPlatformType_WechatTimeLine;
    }else if (sender==2) {
        //type=UMSocialPlatformType_Qzone;
        type=UMSocialPlatformType_QQ;
    } else if (sender==3) {
        type=UMSocialPlatformType_Sina;
    }
    if([model.url kr_isNotEmpty]){
       [self umengShareWithURL:model.url image:nil shareTitle:model.share_title andInfo:model.share_content withType:type];
    }
    
    
}
#pragma mark - // 教程
- (FNRequestTool *)apiRequestCourse:(BOOL)isCache{
    [SVProgressHUD show]; 
    @weakify(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,PageNumber:@(self.jm_page), PageSize:@(_jm_pro_pagesize)}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=course_list&ctrl=index" respondType:(ResponseTypeArray) modelType:@"FNCourseTeModel" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        @strongify(self);
        NSArray* array = respondsObject;
        [SVProgressHUD dismiss];
        if (self.jm_page == 1) {
            if (array.count == 0) {
                [self.jm_collectionview reloadData];
                return ;
            }
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:respondsObject];
            if (array.count >= _jm_pro_pagesize) {
                self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.jm_page ++;
                    [self apiRequestCourse:YES];
                }];
            }else{
                self.jm_collectionview.mj_footer = nil;
            }
        } else {
            [self.dataArray addObjectsFromArray:respondsObject];
            if (array.count >= _jm_pro_pagesize) {
                [self.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [self.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        self.jm_collectionview.hidden = NO;
        [self.jm_collectionview reloadData];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache:isCache];
}

#pragma mark - //数组
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
