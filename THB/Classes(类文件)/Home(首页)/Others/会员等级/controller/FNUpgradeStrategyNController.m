//
//  FNUpgradeStrategyNController.m
//  THB
//
//  Created by Jimmy on 2018/9/7.
//  Copyright © 2018年 方诺科技. All rights reserved.
//
//晋级攻略
#import "FNUpgradeStrategyNController.h"
#import "secondViewController.h"

#import "FNCustomeNavigationBar.h"
#import "FNmemberNLayout.h"
#import "FNmemberStrategyNCell.h"
#import "FNmemberGradeNView.h"

#import "GradeMemberNModel.h"

@interface FNUpgradeStrategyNController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)FNmemberGradeNView *GradeView;
@property(nonatomic,strong)NSMutableArray *StrategyList;
@end

@implementation FNUpgradeStrategyNController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=FNColor(255, 64, 63);
    [self apiRequestStrategy];
    [self navigationView];
    [self UpgradeCollectionview];
}

- (void)navigationView{
    FNCustomeNavigationBar* navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@"晋级攻略"];
    
    navigationView.backgroundColor=FNColor(255, 64, 63);
    UIButton* MemberbackBtn = [UIButton buttonWithTitle:@"" titleColor:FNWhiteColor font:kFONT12 target:self action:@selector(backAction)];
    [MemberbackBtn setImage:IMAGE(@"return2member") forState:(UIControlStateNormal)];
    [MemberbackBtn sizeToFit];
    MemberbackBtn.size = CGSizeMake(MemberbackBtn.width+_jmsize_10, 20);
    navigationView.leftButton = MemberbackBtn;
    
    UIButton* ruleBtn = [UIButton buttonWithTitle:@"  规则  " titleColor:FNWhiteColor font:kFONT12 target:self action:@selector(ruleBtnAction)];
    //[ruleBtn setImage:IMAGE(@"return") forState:(UIControlStateNormal)];
    [ruleBtn sizeToFit];
    ruleBtn.size = CGSizeMake(ruleBtn.width+_jmsize_10, 20);
    navigationView.rightButton = ruleBtn;
    [self.view addSubview:navigationView];
}
//返回
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//规则
-(void)ruleBtnAction{
    secondViewController *web = [secondViewController new];
    web.url =self.StrategyModel.url;
    //web.isLaunch = YES;
    [self.navigationController pushViewController:web animated:YES];
}
#pragma mark -  单元
-(void)UpgradeCollectionview{
    self.GradeView=[[FNmemberGradeNView alloc]initWithFrame:CGRectMake(40, SafeAreaTopHeight, FNDeviceWidth-80, 55)];
    //GradeView.backgroundColor=[UIColor blueColor];
    self.GradeView.model=@"当前等级";
    [self.view addSubview:self.GradeView];
    
    
    CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight;
    FNmemberNLayout* flowlayout = [FNmemberNLayout new];
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+55, FNDeviceWidth, tableHeight-120) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=FNColor(255, 64, 63);
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.backgroundColor=FNColor(255, 64, 63);
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNmemberStrategyNCell class] forCellWithReuseIdentifier:@"memberStrategyCell"];
    //[self.jm_collectionview registerClass:[FNRightTopReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    self.jm_collectionview.showsVerticalScrollIndicator = NO;
    
     self.jm_collectionview.showsHorizontalScrollIndicator = NO;
}
#pragma mark -  UICollectionViewDataSource&&
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.StrategyList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    FNmemberStrategyNCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"memberStrategyCell" forIndexPath:indexPath];
    cell.indexPath=indexPath;
    GradeStrategyModel *item=self.StrategyList[indexPath.row];
    NSLog(@"name:%@",item.name);
    cell.model=self.StrategyList[indexPath.row];
    
    return cell;
}

#pragma mark - Collection view delegate && UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=JMScreenWidth-80;
    CGSize size = CGSizeMake(with, FNDeviceHeight-SafeAreaTopHeight-180);
    return size;
}

#pragma mark - Collection view Header
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    //UICollectionElementKindSectionHeader
//    //FNRightTopReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
//    //headerView.model=self.CategoryItem;
//    return [UIView new];
//
//}
//header的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(JMScreenWidth, 150);
//}

#pragma mark - Request
//会员等级攻略
- (FNRequestTool *)apiRequestStrategy{
    
    [SVProgressHUD show];
    @WeakObj(self);
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appHigh&ctrl=strategy" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"会员攻略:%@",respondsObject);
        NSArray *arrAy=  respondsObject [DataKey];
        NSMutableArray *arrM = [NSMutableArray array];
        NSString* is_thislv=@"0";
        for (NSDictionary *dictDict in arrAy) {
            NSInteger grade=[dictDict[@"is_thislv"] integerValue];
            if(grade==1){
                is_thislv=dictDict[@"num"];
            }
            [arrM addObject:[GradeStrategyModel mj_objectWithKeyValues:dictDict]];
        }
        selfWeak.GradeView.model=is_thislv;
        selfWeak.StrategyList=arrM;
        
      
            [SVProgressHUD dismiss];
            [selfWeak.jm_collectionview reloadData];
       
        
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
- (NSMutableArray *)StrategyList
{
    if (_StrategyList == nil) {
        _StrategyList = [NSMutableArray new];
    }
    return _StrategyList;
}
@end
