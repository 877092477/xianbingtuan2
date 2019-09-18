//
//  FNcandiesGrowUpController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcandiesGrowUpController.h"
#import "FNcandiesGrowUpListController.h"
#import "FNcandiesGrowModel.h"
#import "FNCustomeNavigationBar.h"
#import "FNcanGrowUpTopCell.h"
#import "FNcanGrowUpStayItemCell.h"
#import "FNcanGrowUpTextItemCell.h"
#import "FNcandiesGradeHeadView.h"
@interface FNcandiesGrowUpController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)FNcandiesGrowModel *dataModel;
@property (nonatomic, strong)UIImageView *imgHeader;
@property (nonatomic, strong)NSArray *textArr;
@property (nonatomic, strong)NSMutableArray *gradeArr;
@end

@implementation FNcandiesGrowUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
}
#pragma mark - set up views
- (void)jm_setupViews{
    self.textArr=@[
                   @"1、成长值与CPS佣金挂钩，获得的佣金越多，成长值增长越快。",
                   @"2、自购佣金：每获得1元自购佣金，则获得1点成长值。",
                   @"3、团队佣金：团队佣金每获得1元，则获得0.1点成长值（累计制：若0.01元佣金，则获得0.001点成长值）。",
                   @"4、成长值共分为7个级别，V0-V6，等级越高 手续费越低。",
                   @"5、达到相应的成长值则对应相应的成长值级别（例如初始级别是V0，达到10点成长值级别是V1，100点成长值级别是V2）。后台可设置。",
                   @"6.自购货团队产生佣金后，增加相应的成长值（冻结状态），确认收货15天（无退货维权）成长值解冻。"];
    
    CGFloat baseGap=0;
    if(self.understand==YES){
        baseGap=XYTabBarHeight;
    }
    [self configHeader];
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    self.jm_collectionview.alpha = 1;
    self.jm_collectionview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
    [self.jm_collectionview registerClass:[FNcanGrowUpTopCell class] forCellWithReuseIdentifier:@"FNcanGrowUpTopCellID"];
    [self.jm_collectionview registerClass:[FNcanGrowUpStayItemCell class] forCellWithReuseIdentifier:@"FNcanGrowUpStayItemCellID"];
    [self.jm_collectionview registerClass:[FNcanGrowUpTextItemCell class] forCellWithReuseIdentifier:@"FNcanGrowUpTextItemCellID"];
    
    [self.jm_collectionview registerClass:[FNcandiesGradeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNcandiesGradeHeadViewID"];
    
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewID"];
    
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
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
    
    if(self.understand==YES){
        self.leftBtn.hidden=YES;
    }
    
    self.view.backgroundColor = RGB(250,250,250);
    self.navigationView.titleLabel.text=@"成长值";
    [self.leftBtn setImage:IMAGE(@"return_w") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor clearColor];
    self.navigationView.titleLabel.textColor=[UIColor whiteColor];
    
    if([UserAccessToken kr_isNotEmpty]){
       [self requestBendi];
    }
    [self.jm_collectionview reloadData];
    
}
- (void)configHeader{
    CGFloat imgH=279;
    self.imgHeader = [[UIImageView alloc] init];
    [self.view insertSubview:_imgHeader atIndex:0];
    [self.imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(imgH);
    }]; 
    self.imgHeader.contentMode = UIViewContentModeScaleAspectFill;
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //if(section==2){
    //    return self.textArr.count;
    //}
    return 1; 
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        FNcanGrowUpTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNcanGrowUpTopCellID" forIndexPath:indexPath];
        cell.gradeView.dataArr=self.gradeArr;
        cell.model=self.dataModel;
        return cell;
    }
    else if(indexPath.section==1){
        FNcanGrowUpStayItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNcanGrowUpStayItemCellID" forIndexPath:indexPath];
        cell.model=self.dataModel;
        return cell;
    }
    else{
        FNcanGrowUpTextItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNcanGrowUpTextItemCellID" forIndexPath:indexPath];
        //cell.backgroundColor=[UIColor clearColor];
        cell.contentStr=self.dataModel.dwqkb_grow_lv_detail;//self.textArr[indexPath.row];
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=0;
    CGFloat itemWith=FNDeviceWidth;
    if(indexPath.section==0){
        itemHeight=SafeAreaTopHeight+220;
        itemWith=FNDeviceWidth;
    }
    else if(indexPath.section==1){
        itemHeight=120;
        itemWith=FNDeviceWidth;
    }
    else if(indexPath.section==2){
        NSString *textStr=self.dataModel.dwqkb_grow_lv_detail;//self.textArr[indexPath.row];
        if([textStr kr_isNotEmpty]){
            itemHeight=[textStr kr_heightWithMaxWidth:FNDeviceWidth-40 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        }else{
          itemHeight=10;
        } 
        itemWith=FNDeviceWidth-40;
    }
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
     
    return 0;
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==2){
        FNcandiesGradeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNcandiesGradeHeadViewID" forIndexPath:indexPath];
        headerView.titleLB.text=self.dataModel.lv_explain_str;
        [headerView.detailBtn addTarget:self action:@selector(detailBtnAction)];
        [headerView.detailBtn setTitle:self.dataModel.see_detail forState:UIControlStateNormal];
        return headerView;
    }else{
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewID" forIndexPath:indexPath];
        return headerView;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=0;
    if(section==2){
       hight=45;
    }
    return CGSizeMake(with,hight);
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=0;
    CGFloat bottomGap=0;
    CGFloat rightGap=0;
    if(section==0){
        bottomGap=10;
    }
    if(section==2){
       leftGap=20;
       rightGap=20;
       bottomGap=20;
    }
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//成长值明细
-(void)detailBtnAction{
    FNcandiesGrowUpListController *vc=[[FNcandiesGrowUpListController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    CGFloat imgH=279;
    if (conY<0) {
        [_imgHeader mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
            make.height.mas_equalTo(imgH - conY);
        }];
    }else{
        [_imgHeader mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(-conY);
            make.height.mas_equalTo(imgH);
        }];
    }
    if (conY>0 && conY<=JMNavBarHeigth) {
        //滚动中
        self.navigationView.backgroundColor = [RGB(49, 49, 49) colorWithAlphaComponent:conY/JMNavBarHeigth];
    }else if (conY > JMNavBarHeigth){
        self.navigationView.backgroundColor = RGB(49, 49, 49);
    }else{
        self.navigationView.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark - request
-(void)requestBendi{
    [SVProgressHUD show];
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:@"mod=appapi&act=dwqkb&ctrl=grow" successBlock:^(id responseBody) {
        @strongify(self);
        NSDictionary *dictry = responseBody[DataKey];
        self.dataModel=[FNcandiesGrowModel mj_objectWithKeyValues:dictry];
        [self.imgHeader setUrlImg:self.dataModel.dwqkb_grow_top_bj];
        self.navigationView.titleLabel.text=self.dataModel.dwqkb_grow_title;
        [self.leftBtn sd_setImageWithURL:URL(self.dataModel.dwqkb_grow_return_btn) forState:UIControlStateNormal];
        self.navigationView.titleLabel.textColor=[UIColor colorWithHexString:self.dataModel.dwqkb_grow_top_color];
        [self inGradeScheduleValue];
        [UIView performWithoutAnimation:^{
            [self.jm_collectionview reloadData];
        }];
    } failureBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
    }];
}
//等级进度
-(void)inGradeScheduleValue{
    NSInteger sup_lv=[self.dataModel.sup_lv integerValue]-1;
    NSInteger now_lv=[self.dataModel.now_lv integerValue];
    if(now_lv>0){
        now_lv=[self.dataModel.now_lv integerValue]-1;
        self.gradeArr=[NSMutableArray arrayWithCapacity:0];
        for (NSInteger i=0; i<sup_lv; i++) {
            FNcandiesGrowGardeItemModel *model=[[FNcandiesGrowGardeItemModel alloc]init];
            model.maxVal=sup_lv;
            model.colour1str=self.dataModel.dwqkb_grow_progress_scolor;
            model.colour2str=self.dataModel.dwqkb_grow_progress_ecolor;
            model.colourText=self.dataModel.dwqkb_grow_lv_color;
            
            if(i<now_lv+1){
                model.gradeValue=[NSString stringWithFormat:@"V%ld",(long)i+1];
                model.gradeRiValue=[NSString stringWithFormat:@"V%ld",(long)i+2];
                model.valLGarde=1;
                
            }else{
                model.valLGarde=0;
            }
            if(i==now_lv){
                model.valRDGarde=1;
                model.presentInt=1;
            }else{
                model.presentInt=0;
                //model.valRDGarde=0;
            }
            if(i<now_lv){
                model.gardeInt=1;
            }else{
                model.gardeInt=0;
            }
            if(i==now_lv-1){
                //model.presentInt=1;
                model.presentVal=i+1;
                model.bufferState=1;
            }else{
                //model.presentInt=0;
                model.bufferState=0;
            }
            if(now_lv==0){
                if(i==0){
                    model.presentInt=1;
                    model.gradeValue=[NSString stringWithFormat:@"V%ld",(long)i+1];
                }else{
                    model.presentInt=0;
                }
            }
            if(i<sup_lv-1){
                model.valRGarde=0;
            }else{
                model.valRGarde=1;
            }
            [self.gradeArr addObject:model];
        }
    
    }
}
@end
