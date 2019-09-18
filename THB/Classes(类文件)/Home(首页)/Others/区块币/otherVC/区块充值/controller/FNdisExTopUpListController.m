//
//  FNdisExTopUpListController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/9.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdisExTopUpListController.h"
#import "FNCustomeNavigationBar.h"
#import "FNdisExchangeWuCell.h"
#import "FNdisExTopUpItemCell.h"
@interface FNdisExTopUpListController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)NSMutableArray *dataArr;
@end

@implementation FNdisExTopUpListController
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
    self.navigationView.titleLabel.text=self.keyWord?self.keyWord:@"充值记录";
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.leftBtn.imageView.sd_layout
    .centerYEqualToView(self.leftBtn).widthIs(8).heightIs(16).leftSpaceToView(self.leftBtn, 10);
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - set up views
- (void)jm_setupViews{
    [self setTopViews];
    self.view.backgroundColor=RGB(250, 250, 250);
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+1, FNDeviceWidth, FNDeviceHeight-SafeAreaTopHeight-1) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=RGB(250, 250, 250);
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNdisExTopUpItemCell class] forCellWithReuseIdentifier:@"FNdisExTopUpItemCellID"];
    [self.jm_collectionview registerClass:[FNdisExchangeWuCell class] forCellWithReuseIdentifier:@"FNdisExchangeWuCellID"];
    
    if([UserAccessToken kr_isNotEmpty]){
       [self requestOrderList];
    }
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(self.dataArr.count>0){
       return self.dataArr.count;
    }else{
       return 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.dataArr.count>0){
        FNdisExTopUpItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNdisExTopUpItemCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        FNdisExTopUpItemModel *model=[FNdisExTopUpItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
        cell.model=model;
        return cell;
    }else{
        FNdisExchangeWuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNdisExchangeWuCellID" forIndexPath:indexPath];
        cell.stateImg.sd_layout
        .topSpaceToView(self, 118).centerXEqualToView(cell).widthIs(149).heightIs(160);
        cell.stateLB.sd_layout
        .topSpaceToView(cell.stateImg, 28).leftSpaceToView(cell, 15).rightSpaceToView(cell, 15).heightIs(20);
        cell.backgroundColor=RGB(250, 250, 250);
        cell.stateImg.image=IMAGE(@"FN_czNulImg");
        cell.stateLB.text=@"暂时没有充值记录哦~";
        cell.stateLB.textColor=RGB(205, 205, 205);
        cell.stateLB.font=kFONT15;
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=0;
    CGFloat with= FNDeviceWidth;
    if(self.dataArr.count>0){
       height=99;
    }else{
       CGFloat wuHeight=FNDeviceHeight-SafeAreaTopHeight;
       height=wuHeight;
    }
    CGSize  size= CGSizeMake(with, height);
    return  size;
}
#pragma mark - // 交易列表
-(FNRequestTool*)requestOrderList{ 
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=qkb&ctrl=recharge_list" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSArray *array =respondsObject[DataKey];
        if (self.jm_page == 1) {
            if (array.count == 0) {
                return ;
            }
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.jm_page ++;
                    [self requestOrderList];
                }];
            }else{
            }
        } else {
            [self.dataArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                [self.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [self.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [self.jm_collectionview reloadData];
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache:NO];
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
