//
//  FNCandiesConversionController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNCandiesConversionController.h"
#import "FNCustomeNavigationBar.h"
#import "FNcandiesConversionTopCell.h"
#import "FNcamdiesMyTaskItemCell.h"
#import "FNcandiesPrincipalTaskCell.h"
#import "FNcandiesTaskHeadView.h"
#import "FNcandiesTaskSternView.h"
#import "FNCandiesConversionModel.h"
@interface FNCandiesConversionController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNcandiesPrincipalTaskCellDelegate,FNcamdiesMyTaskItemCellDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)UIImageView *imgHeader;
@property (nonatomic, strong)FNCandiesConversionModel *dataModel;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, assign)BOOL isTask;
@end

@implementation FNCandiesConversionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
    if(self.isTask==YES){
        [self requestBendi];
        [self requestBendiList];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
}
#pragma mark - set up views
- (void)jm_setupViews{
    self.dataArr=[NSMutableArray arrayWithCapacity:0];
    FNCandiesTaskStyleModel *oneModel=[[FNCandiesTaskStyleModel alloc]init];
    oneModel.type=@"topStyle";
    [self.dataArr addObject:oneModel];
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
    [self.jm_collectionview registerClass:[FNcandiesConversionTopCell class] forCellWithReuseIdentifier:@"FNcandiesConversionTopCellID"];
    [self.jm_collectionview registerClass:[FNcamdiesMyTaskItemCell class] forCellWithReuseIdentifier:@"FNcamdiesMyTaskItemCellID"];
    [self.jm_collectionview registerClass:[FNcandiesPrincipalTaskCell class] forCellWithReuseIdentifier:@"FNcandiesPrincipalTaskCellID"];
    
     [self.jm_collectionview registerClass:[FNcandiesTaskHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNcandiesTaskHeadViewID"];
    
    [self.jm_collectionview registerClass:[FNcandiesTaskSternView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FNcandiesTaskSternViewID"];
    
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewHeadID"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FNcandiesTaskSternViewFooterID"];
    
    
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
    
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightBtn.size = CGSizeMake(40, 27);
    self.navigationView.rightButton = self.rightBtn;
    [self.rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.rightBtn setTitle:@"规则" forState:UIControlStateNormal];
    
    self.rightBtn.titleLabel.font=kFONT12;
    
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationView.titleLabel.text=@"兑换任务";
    [self.leftBtn setImage:IMAGE(@"return_w") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor clearColor];
    self.navigationView.titleLabel.textColor=[UIColor whiteColor];
    
    if([UserAccessToken kr_isNotEmpty]){
        [self requestBendi];
        [self requestBendiList];
    }
    
}
- (void)configHeader{
    CGFloat imgH=289;
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
    return self.dataArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    FNCandiesTaskStyleModel *model=self.dataArr[section];
    NSString *type=model.type;
    NSArray *listArr=model.list;
    if([type isEqualToString:@"topStyle"]){
        return 1;
    }
    else{
        return listArr.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNCandiesTaskStyleModel *model=self.dataArr[indexPath.section];
    NSString *type=model.type;
    NSArray *listArr=model.list;
    if([type isEqualToString:@"topStyle"]){
        FNcandiesConversionTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNcandiesConversionTopCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        cell.model=self.dataModel;
        [cell.centreBtn addTarget:self action:@selector(topCentreBtnClick)];
        return cell;
    }
    else if([type isEqualToString:@"my"]){
        FNcamdiesMyTaskItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNcamdiesMyTaskItemCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        cell.model=[FNCandiesMyTaskModel mj_objectWithKeyValues:listArr[indexPath.row]];
        cell.bgImgUrl=model.body_bj;
        cell.delegate=self;
        return cell;
    }
    else{
        //normal
        FNcandiesPrincipalTaskCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNcandiesPrincipalTaskCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        cell.model=[FNCandiesMyTaskModel mj_objectWithKeyValues:listArr[indexPath.row]];
        cell.bgImgUrl=model.body_bj;
        cell.delegate=self;
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNCandiesTaskStyleModel *model=self.dataArr[indexPath.section];
    NSString *type=model.type;
    CGFloat itemHeight=250;
    CGFloat itemWith=FNDeviceWidth;
    if([type isEqualToString:@"topStyle"]){
        itemHeight=240;
        itemWith=FNDeviceWidth;
    }
    else if([type isEqualToString:@"my"]){
        itemHeight=95;
        itemWith=FNDeviceWidth;
    }
    else if([type isEqualToString:@"normal"]){
        itemHeight=175;
        itemWith=FNDeviceWidth;
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
    FNCandiesTaskStyleModel *model=self.dataArr[indexPath.section];
    NSString *type=model.type;
    if (kind==UICollectionElementKindSectionHeader) {
        if([type isEqualToString:@"topStyle"]){
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewHeadID" forIndexPath:indexPath];
            return headerView;
        }else{
            FNcandiesTaskHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNcandiesTaskHeadViewID" forIndexPath:indexPath];
            headerView.model=model;
            return headerView;
        }
    }else{
        if([type isEqualToString:@"topStyle"]){
            UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FNcandiesTaskSternViewFooterID" forIndexPath:indexPath];
            return footerView;
        }else{
            FNcandiesTaskSternView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FNcandiesTaskSternViewID" forIndexPath:indexPath];
            footerView.model=model;
            if([type isEqualToString:@"my"]){
               //[footerView.centreBtn setTitle:@"展开查看更多" forState:UIControlStateNormal];
               [footerView.centreBtn addTarget:self action:@selector(centreBtnAction)];
            }
            return footerView;
        }
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    FNCandiesTaskStyleModel *model=self.dataArr[section];
    NSString *type=model.type;
    CGFloat with=FNDeviceWidth;
    CGFloat hight=0;
    if([type isEqualToString:@"my"]){
        hight=78;
    }
    if([type isEqualToString:@"normal"]){
       hight=66;
    }
    return CGSizeMake(with,hight);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    FNCandiesTaskStyleModel *model=self.dataArr[section];
    NSString *type=model.type;
    CGFloat with=FNDeviceWidth;
    CGFloat hight=38;
    if([type isEqualToString:@"topStyle"]){
        hight=0;
    } 
    return CGSizeMake(with,hight);
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=0;
    CGFloat bottomGap=0;
    CGFloat rightGap=0;
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - FNcandiesPrincipalTaskCellDelegate
// 点击主线任务
- (void)inPrincipalTaskRtightAction:(id)model{
    
    //领任务
    //status: receive_reward 未领取 received 已领取 to_finish 去完成
    FNCandiesMyTaskModel *itemModel=model;
    if([itemModel.status isEqualToString:@"receive_reward"]){
        if([itemModel.id kr_isNotEmpty]){
           [self requestBendiLingquRenwu:itemModel.id];
        }
    }
    else if([itemModel.status isEqualToString:@"received"]){
        [FNTipsView showTips:@"已经领取过了"];
    }
    else if([itemModel.status isEqualToString:@"to_finish"]){
        //[self.navigationController popToRootViewControllerAnimated:YES];
    }
}
#pragma mark -  FNcamdiesMyTaskItemCellDelegate
// 点击我的任务
- (void)inMyTaskRtightAction:(id)model{
    //领奖励
    FNCandiesMyTaskModel *itemModel=model;
    if([itemModel.status isEqualToString:@"receive_reward"]){
        if([itemModel.type kr_isNotEmpty]&&[itemModel.counts floatValue]>0){
           [self requestBendiLingquJiangli:itemModel.id withType:itemModel.type];
        }
    }
    else if([itemModel.status isEqualToString:@"received"]){
        [FNTipsView showTips:@"已经领取过了"];
    }
    else if([itemModel.status isEqualToString:@"to_finish"]){
       // self.tabBarController.selectedIndex = 1;
      //[self.navigationController popToRootViewControllerAnimated:YES];
        self.isTask=YES;
        [self loadOtherVCWithModel:itemModel.skip andInfo:nil outBlock:nil];
    }
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//规则
-(void)rightBtnAction{
    if([self.dataModel.explain_url kr_isNotEmpty]){
        [self goWebWithUrl:self.dataModel.explain_url];
    } 
}
//兑换
-(void)topCentreBtnClick{
    [self loadOtherVCWithModel:self.dataModel.skip andInfo:nil outBlock:nil];
}
//打开收起
-(void)centreBtnAction{
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    CGFloat imgH=289;
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
        self.navigationView.backgroundColor = [RGB(204, 123, 209) colorWithAlphaComponent:conY/JMNavBarHeigth];
    }else if (conY > JMNavBarHeigth){
        self.navigationView.backgroundColor = RGB(204, 123, 209);
    }else{
        self.navigationView.backgroundColor = [UIColor clearColor];
    }
}
#pragma mark - request
-(void)requestBendi{
    [SVProgressHUD show];
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:@"mod=appapi&act=dwqkb&ctrl=task_top" successBlock:^(id responseBody) {
        @strongify(self);
        [SVProgressHUD dismiss];
        NSDictionary *dictry = responseBody[DataKey];
        self.dataModel=[FNCandiesConversionModel mj_objectWithKeyValues:dictry];
        [self.imgHeader setUrlImg:self.dataModel.dwqkb_task_top_bj];
        self.navigationView.titleLabel.text=self.dataModel.dwqkb_task_title;
        [self.leftBtn sd_setImageWithURL:URL(self.dataModel.dwqkb_task_return_btn) forState:UIControlStateNormal];
        [self.rightBtn setTitle:self.dataModel.dwqkb_task_rule_btn forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor colorWithHexString:self.dataModel.dwqkb_task_top_color] forState:UIControlStateNormal];
        self.navigationView.titleLabel.textColor=[UIColor colorWithHexString:self.dataModel.dwqkb_task_top_color];
        [UIView performWithoutAnimation:^{
            [self.jm_collectionview reloadData];
        }];
    } failureBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
    }];
}

-(void)requestBendiList{
    [SVProgressHUD show];
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    
    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:@"mod=appapi&act=dwqkb&ctrl=task_list" successBlock:^(id responseBody) {
        [SVProgressHUD dismiss];
        @strongify(self);
        NSArray *array =responseBody[DataKey];
        if(array.count>0){
            NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNCandiesTaskStyleModel *model=[FNCandiesTaskStyleModel mj_objectWithKeyValues:obj];
                [arrM addObject:model];
            }];
            if(self.dataArr.count>1){
               [self.dataArr removeAllObjects];
                FNCandiesTaskStyleModel *oneModel=[[FNCandiesTaskStyleModel alloc]init];
                oneModel.type=@"topStyle";
                [self.dataArr addObject:oneModel];
                [self.dataArr addObjectsFromArray:arrM];
            }else{
                [self.dataArr addObjectsFromArray:arrM];
            }
        }
        [UIView performWithoutAnimation:^{
            [self.jm_collectionview reloadData];
        }];
    } failureBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
    }];
}
//领取任务
-(void)requestBendiLingquRenwu:(NSString*)taskId{
    [SVProgressHUD show];
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    params[@"id"]=taskId;
    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:@"mod=appapi&act=dwqkb&ctrl=receive_task" successBlock:^(id responseBody) {
        [SVProgressHUD dismiss];
        @strongify(self);
        NSInteger state=[responseBody[SuccessKey] integerValue];
        NSString *msgStr=responseBody[MsgKey];
        [FNTipsView showTips:msgStr];
        if(state==1){
            [self requestBendi];
            [self requestBendiList];
            [UIView performWithoutAnimation:^{
                [self.jm_collectionview reloadData];
            }];
        }
    } failureBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
    }];
}
//领取奖励
-(void)requestBendiLingquJiangli:(NSString*)taskId withType:(NSString*)typeStr{
    [SVProgressHUD show];
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([typeStr isEqualToString:@"task"]){
        if([taskId kr_isNotEmpty]){
           params[@"id"]=taskId;
        }
    }
    params[@"type"]=typeStr;
    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:@"mod=appapi&act=dwqkb&ctrl=receive_reward" successBlock:^(id responseBody) {
        [SVProgressHUD dismiss];
        @strongify(self);
        NSInteger state=[responseBody[SuccessKey] integerValue];
        NSString *msgStr=responseBody[MsgKey];
        [FNTipsView showTips:msgStr];
        if(state==1){
            [self requestBendi];
            [self requestBendiList];
            [UIView performWithoutAnimation:^{
                [self.jm_collectionview reloadData];
            }];
        }
        
    } failureBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
    }];
}


@end
