//
//  FNMerActivityToolController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNMerActivityToolController.h"
#import "FNmerDiscountsSController.h" 
#import "FNCustomeNavigationBar.h"
#import "FNmeActivitToolItemCell.h"
#import "FNmeActivitToolModel.h"
#import "FNmerDiscountsCateController.h"
@interface FNMerActivityToolController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)FNCustomeNavigationBar *navigationView;
@property (nonatomic, strong)UIButton     *leftBtn;
@property (nonatomic, strong)NSMutableArray *dataArr;
@end

@implementation FNMerActivityToolController

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
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, baseGap, FNDeviceWidth, FNDeviceHeight-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    self.jm_collectionview.backgroundColor=RGB(250, 250, 250);
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNmeActivitToolItemCell class] forCellWithReuseIdentifier:@"FNmeActivitToolItemCellID"];
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 10).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.leftButton = self.leftBtn;
    
    [self.view addSubview:self.navigationView];
   
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    self.navigationView.titleLabel.text=@"促销工具";
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    
    self.view.backgroundColor=RGB(250, 250, 250);
    //self.jm_collectionview.hidden=YES;
    
    [self requestBendi];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FNmeActivitToolItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmeActivitToolItemCellID" forIndexPath:indexPath];
    cell.model=self.dataArr[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemWith=FNDeviceWidth;
    CGFloat itemHeight=82;
    CGSize  size = CGSizeMake(itemWith, itemHeight);
    return  size;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 6;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FNmeActivitToolModel *model=self.dataArr[indexPath.row];
    
    if ([model.type isEqualToString: @"red_packet"]) {
        
        FNmerDiscountsCateController *vc = [[FNmerDiscountsCateController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    FNmerDiscountsSController *vc=[[FNmerDiscountsSController alloc]init];
    vc.typeStr=model.type;
    [self.navigationController pushViewController:vc animated:YES];
    //[self loadOtherVCWithModel:model andInfo:nil outBlock:nil];
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=6;
    CGFloat leftGap=0;
    CGFloat bottomGap=15;
    CGFloat rightGap=0;
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)requestBendi{
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    [SVProgressHUD show];
    @weakify(self);
    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:@"mod=appapi&act=rebate_sale&ctrl=cate_list" successBlock:^(id responseBody) {
        XYLog(@"responseBody=%@",responseBody);
        @strongify(self);
        NSArray *arrM = responseBody[DataKey];
        if(arrM.count>0){
            NSMutableArray *typeArray=[NSMutableArray arrayWithCapacity:0];
            [arrM enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNmeActivitToolModel *model=[FNmeActivitToolModel mj_objectWithKeyValues:obj];
                [typeArray addObject:model];
            }];
            self.dataArr=typeArray;
            [UIView performWithoutAnimation:^{
                [self.jm_collectionview reloadData];
            }];
        }
    } failureBlock:^(NSString *error) {
        
    }];
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
