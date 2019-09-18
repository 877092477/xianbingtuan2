//
//  FNCategoryListingsController.m
//  THB
//
//  Created by Jimmy on 2018/9/5.
//  Copyright © 2018年 方诺科技. All rights reserved.
//
//分类列表
#import "FNCategoryListingsController.h"
#import "ProductListViewController.h"
#import "FNGoodsListViewController.h"
#import "firstVersionSearchViewController.h"

#import "FNLeftclassifyModel.h"

#import "FNLeftClassifyNeViewCell.h"
#import "FNoptionRightCollectionViewCell.h"
#import "FNRightTopReusableView.h"
#import "FNCustomeNavigationBar.h"

@interface FNCategoryListingsController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNLeftClassifyNeViewCellDelegate,UISearchBarDelegate>
//** TableView **//
@property (nonatomic, strong)UITableView* CategoryLeftTableView;
@property (nonatomic, strong)NSMutableArray *leftDataArr;
@property (nonatomic, strong)NSMutableArray *rightDataArr;
@property (nonatomic, strong)NSString *leftclassifyID;

@property (nonatomic, strong)FNLeftclassifyModel *CategoryItem;
@property (nonatomic, strong)NSString *SkipUIIdentifier;

@property (nonatomic, assign)CGFloat headerheight;
@end

@implementation FNCategoryListingsController
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
    self.view.backgroundColor=FNColor(246, 246, 246);
    [self setUpCustomizedNaviBar];
    [self apiRequestCategory];
    [self CategoryTableView];
}
#pragma mark - initNavBar 导航栏
- (void)setUpCustomizedNaviBar{ 
    
    FNCustomeNavigationBar*_cuNaivgationbar = [FNCustomeNavigationBar customeNavigationBarWithSearchBarFrame:(CGRectMake(80, 27, FNDeviceWidth-80*2, 30)) andPlaceholder:@"粘贴宝贝标题,先领券再购物"];
    _cuNaivgationbar.searchBar.cornerRadius = 5;
    _cuNaivgationbar.searchBar.delegate  =self;
    _cuNaivgationbar.searchBar.backgroundImage = [UIImage createImageWithColor:FNColor(246, 246, 246)];
    UIView *searchTextField = nil;
    searchTextField = [[[_cuNaivgationbar.searchBar.subviews firstObject] subviews] lastObject];
    searchTextField.backgroundColor =  FNColor(246, 246, 246);
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSFontAttributeName: kFONT14}];
    
    
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [backBtn sizeToFit];
    backBtn.size = CGSizeMake(backBtn.width+10, backBtn.height+10);
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *msgBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    msgBtn.hidden=YES;
    [msgBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [msgBtn sizeToFit];
    msgBtn.size = CGSizeMake(msgBtn.width+10, msgBtn.height+10);
    _cuNaivgationbar.leftButton = backBtn;
    _cuNaivgationbar.rightButton = msgBtn;
    _cuNaivgationbar.backgroundColor =[UIColor whiteColor];
    _cuNaivgationbar.leftButton.hidden=self.understand;

    [self.view addSubview:_cuNaivgationbar];
}
#pragma mark - 左边单元
-(void)CategoryTableView{
    //self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight;
    if(self.understand==YES){
        tableHeight=FNDeviceHeight-SafeAreaTopHeight-XYTabBarHeight;
    }
    self.jm_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+1, FNDeviceWidth*0.25, tableHeight-1) style:UITableViewStylePlain];
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jm_tableview.backgroundColor=[UIColor whiteColor];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    [self.view addSubview:self.jm_tableview];
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.estimatedRowHeight = 0;
        self.jm_tableview.estimatedSectionFooterHeight = 0;
        self.jm_tableview.estimatedSectionHeaderHeight= 0;
        self.jm_tableview.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }
    
    
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 10;
    flowlayout.minimumInteritemSpacing = 10;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(FNDeviceWidth*0.25+1, SafeAreaTopHeight+1, FNDeviceWidth*0.75-1, tableHeight-1) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNoptionRightCollectionViewCell class] forCellWithReuseIdentifier:@"rightClassifycellId"];
    [self.jm_collectionview registerClass:[FNRightTopReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
}

#pragma mark -  UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.leftDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNLeftClassifyNeViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CategorycellID"];
    if (cell == nil) {
        cell = [[FNLeftClassifyNeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CategorycellID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FNLeftclassifyModel *model=self.leftDataArr[indexPath.row];
    cell.evaluate=model;
    cell.indexAc=indexPath;
    cell.delegate=self;
    return cell;
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)chooseBtnClickAction:(NSInteger)sender{
    FNLeftclassifyModel *model=self.leftDataArr[sender];
    self.leftclassifyID=model.id;
    self.CategoryItem=model;
    self.SkipUIIdentifier=model.SkipUIIdentifier;
    for (FNLeftclassifyModel *Fnmode in self.leftDataArr) {
        if (Fnmode.id==model.id) {
            Fnmode.select_type=1;
        }else{
            Fnmode.select_type=0;
        }
    }
    [self uploadHeaderHeight];
    [self.jm_tableview reloadData];
    [self apiRequestLeftCategory];
}
#pragma mark -  UICollectionViewDataSource&&
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.rightDataArr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FNoptionRightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"rightClassifycellId" forIndexPath:indexPath];
    FNRightclassifyModel *model=self.rightDataArr[indexPath.row];
    cell.model=model;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
#pragma mark - Collection view delegate && UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=(JMScreenWidth*0.75-40)/3;
    CGSize size = CGSizeMake(with, with+20);
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNRightclassifyModel *model=self.rightDataArr[indexPath.row];
    FNGoodsListViewController *VC=[FNGoodsListViewController new];
    //VC.SkipUIIdentifier=self.SkipUIIdentifier;
    VC.keyword=model.keyword;
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{ 
   //UICollectionElementKindSectionHeader
   FNRightTopReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
   headerView.model=self.CategoryItem;
   @WeakObj(self);
   [headerView.advertisingView addJXTouch:^{
//       [selfWeak loadOtherVCWithModel:selfWeak.CategoryItem andInfo:nil outBlock:nil];
       [selfWeak goWebWithUrl:selfWeak.CategoryItem.banner_url];

   }];
   return headerView;

}
//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    XYLog(@"headerheight=%f",self.headerheight);
    return CGSizeMake(JMScreenWidth*0.75-40, self.headerheight);
}
#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{ 
    
    /*ProductListViewController *vc = [[ProductListViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.searchTitle =self.CategoryItem.name;
    vc.categoryID = @"";
    [self.navigationController pushViewController:vc animated:YES];*/
    /*FNGoodsListViewController *VC=[FNGoodsListViewController new];
    VC.SkipUIIdentifier=self.SkipUIIdentifier;
    VC.keyword=self.CategoryItem.name;
    [self.navigationController pushViewController:VC animated:YES];*/
    firstVersionSearchViewController *vc = [[firstVersionSearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    return NO;
}
-(void)backBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Request
//获取分类列表左边
- (FNRequestTool *)apiRequestCategory{
    @WeakObj(self);
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appCate&ctrl=one" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
       
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
        
        if(typeArr.count>0){
            FNLeftclassifyModel *oneModel=typeArr[0];
            selfWeak.leftclassifyID=oneModel.id;
            selfWeak.CategoryItem=oneModel;
            [selfWeak uploadHeaderHeight];
            selfWeak.leftDataArr=typeArr;
            [SVProgressHUD dismiss];
            [selfWeak.jm_tableview reloadData];
            [selfWeak apiRequestLeftCategory];
        }
        
    } failure:^(NSString *error) {
        if(selfWeak.leftDataArr.count==0){
            [self apiRequestCategory];
        }
    } isHideTips:NO];
}
-(void)uploadHeaderHeight{
    @WeakObj(self);
    //XYLog(@"banner_img*=%@",self.CategoryItem.banner_img);
    [[SDWebImageManager sharedManager] downloadImageWithURL:URL(self.CategoryItem.banner_img) options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //XYLog(@"received=:%ld    expected=:%ld",(long)receivedSize,(long)expectedSize);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        NSData *imageData=UIImageJPEGRepresentation(image, 1.0);
        NSInteger lent=imageData.length/1024;
        if (error){
            selfWeak.headerheight=40;
        }
        else if(lent>0){
            selfWeak.headerheight=150;
        }
        else if(lent<0 ||lent==0 ){
            selfWeak.headerheight=40;
        }
        [selfWeak.jm_collectionview reloadData];
    }];
    
}

//获取分类列表右边
- (FNRequestTool *)apiRequestLeftCategory{
    @WeakObj(self);
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,@"id":self.leftclassifyID}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appCate&ctrl=two" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        
        NSArray* array = respondsObject[DataKey];
        NSMutableArray *typeArr=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dictry in array) {
            FNRightclassifyModel *model=[FNRightclassifyModel mj_objectWithKeyValues:dictry];
            [typeArr addObject:model];
        }
        selfWeak.rightDataArr=typeArr;
        [SVProgressHUD dismiss];
        [selfWeak.jm_collectionview reloadData];
        
    } failure:^(NSString *error) {
        if(selfWeak.rightDataArr.count==0){
            [self apiRequestLeftCategory];
        }
    } isHideTips:NO];
}

-(NSMutableArray *)leftDataArr{
    if (!_leftDataArr) {
        _leftDataArr = [NSMutableArray array];
    }
    return _leftDataArr;
}
-(NSMutableArray *)rightDataArr{
    if (!_rightDataArr) {
        _rightDataArr = [NSMutableArray array];
    }
    return _rightDataArr;
}
@end
