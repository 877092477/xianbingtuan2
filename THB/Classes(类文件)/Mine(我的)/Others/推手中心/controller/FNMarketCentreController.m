//
//  FNMarketCentreController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/13.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNMarketCentreController.h"
#import "FNmarketBillListController.h"
#import "JMASBindAlipayController.h"
#import "FNWithdrawController.h"
#import "FNCustomeNavigationBar.h"
#import "FNmarketCentreItemCell.h"
#import "FNmarkeAwardItemsCell.h"
#import "FNmarketCentreHeadCell.h" 
#import "FNMarketCentreModel.h"
#import "FNHandSlapdController.h"
#import "FNHandResultController.h"
@interface FNMarketCentreController ()<UICollectionViewDelegate,UICollectionViewDataSource,FNmarketCentreHeadCellDelegate,FNmarScreensfViewDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)UIImageView *imgBgView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableArray *typeArr;
@property (nonatomic, strong)FNMarketCentreModel *headModel;
@property (nonatomic, strong)NSString *seletedType;
@property (nonatomic, assign)CGFloat bgImgHeight;
@property (nonatomic, strong)NSString *typeString;
@end

@implementation FNMarketCentreController

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
    self.seletedType=@"order";
    self.bgImgHeight=267+SafeAreaTopHeight;
    [self inAddSubViewImg];
    CGFloat baseGap=0;
    if(self.understand==YES){
        baseGap=XYTabBarHeight;
    }
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    //self.jm_collectionview.alpha = 1;
    self.jm_collectionview.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.jm_collectionview];
    
    [self.jm_collectionview registerClass:[FNmarketCentreItemCell class] forCellWithReuseIdentifier:@"FNmarketCentreItemCellID"];
    [self.jm_collectionview registerClass:[FNmarkeAwardItemsCell class] forCellWithReuseIdentifier:@"FNmarkeAwardItemsCellID"];
    [self.jm_collectionview registerClass:[FNmarketCentreHeadCell class] forCellWithReuseIdentifier:@"FNmarketCentreHeadCellID"]; 
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.leftBtn.size = CGSizeMake(40, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    
    
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightBtn.size = CGSizeMake(75, 30);
    self.rightBtn.titleLabel.font=kFONT13;
    [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationView.rightButton = self.rightBtn;
    [self.rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.rightBtn setImage:IMAGE(@"FN_market_xyimg") forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"账单明细" forState:UIControlStateNormal]; 
    
    [self.view addSubview:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 5).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    
    self.rightBtn.imageView.sd_layout
    .rightSpaceToView(self.rightBtn, 0).centerYEqualToView(self.rightBtn).widthIs(6).heightIs(10);
    self.rightBtn.titleLabel.sd_layout
    .rightSpaceToView(self.rightBtn.imageView, 9).centerYEqualToView(self.rightBtn).leftSpaceToView(self.rightBtn, 2).heightIs(17);
    self.rightBtn.titleLabel.textAlignment=NSTextAlignmentRight; 
    
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:16];
    self.navigationView.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.navigationView.titleLabel.text=@"推手中心";
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=RGB(250, 250, 250);
    if(self.understand==YES){
        self.leftBtn.hidden=YES;
    }
    if([UserAccessToken kr_isNotEmpty]){
       [self requestSlapdHeader];
    }
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
- (void)inAddSubViewImg{
    self.imgBgView = [[UIImageView alloc] init];
    [self.view insertSubview:self.imgBgView atIndex:0];
    [self.imgBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(self.bgImgHeight);
    }];
    self.imgBgView.contentMode = UIViewContentModeScaleAspectFill;
    self.imgBgView.clipsToBounds=YES;
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){
       return 1;
    }else{
        return self.dataArr.count;
    } 
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        FNmarketCentreHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmarketCentreHeadCellID" forIndexPath:indexPath];
        cell.model=self.headModel;
        cell.listView.dataArr=self.typeArr;
        cell.seletedType=self.seletedType;
        cell.delegate=self;
        cell.listView.delegate=self;
        [cell.leftTopBtn addTarget:self action:@selector(duplicateCodeClick)];
        [cell.rightTopBtn addTarget:self action:@selector(extractClick)];
        return cell;
    }else{
        if([self.seletedType isEqualToString:@"order"]){
            FNmarketCentreItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmarketCentreItemCellID" forIndexPath:indexPath];
            cell.model=[FNMarketCentreStoreItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
            //cell.backgroundColor=RGB(250, 250, 250);
            return cell;
        }
        else if([self.seletedType isEqualToString:@"store"]){
            FNmarkeAwardItemsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmarkeAwardItemsCellID" forIndexPath:indexPath];
            cell.model=[FNMarketCentreStoreItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
            //cell.backgroundColor=RGB(250, 250, 250);
            return cell;
        }else{
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
            return cell;
        }
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=0;
    CGFloat itemWith=FNDeviceWidth;
    if(indexPath.section==0){
        itemHeight=self.bgImgHeight;
    }
    else if(indexPath.section==1){
        itemHeight=70;
    }
    return  CGSizeMake(itemWith, itemHeight);
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - 滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    CGFloat imgH=self.bgImgHeight;
//    if([self.headModel.bili kr_isNotEmpty]){
//        imgH=FNDeviceWidth*[self.headModel.bili floatValue];
//    }
    if (conY<0) {
        [self.imgBgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
            make.height.mas_equalTo(imgH - conY);
        }];
    }else{
        [self.imgBgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(-conY);
            make.height.mas_equalTo(imgH);
        }];
    }
    if (conY>0 && conY<=JMNavBarHeigth) {
        //滚动中
        self.navigationView.backgroundColor = [RGB(255, 68, 107) colorWithAlphaComponent:conY/JMNavBarHeigth];
    }else if (conY > JMNavBarHeigth){
        self.navigationView.backgroundColor = RGB(255, 68, 107);
    }else{
        self.navigationView.backgroundColor = [UIColor clearColor];
    }
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//账单明细
-(void)rightBtnAction{
    FNmarketBillListController *vc=[[FNmarketBillListController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//复制邀请码
-(void)duplicateCodeClick{
    if ([self.headModel.code kr_isNotEmpty]) {
        UIPasteboard *pab = [UIPasteboard generalPasteboard];
        [pab setString:self.headModel.code];
        if (pab == nil) {
            [FNTipsView showTips:@"复制失败"];
        }else{
            [FNTipsView showTips:@"复制成功"];
        }
    }
}
//立即提现
-(void)extractClick{
    if ([[ProfileModel profileInstance].zfb_au kr_isNotEmpty]) {
        FNWithdrawController* vc = [[FNWithdrawController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        JMASBindAlipayController* alipay = [JMASBindAlipayController new];
        [self.navigationController pushViewController:alipay animated:YES];
    }
}
#pragma mark - FNmarketCentreHeadCellDelegate
// 点击 订单佣金  开店奖励
-(void)inMarketCentreHeadisSeletedType:(NSString *)type  withIndex:(NSInteger)index{
    XYLog(@"type1=%@",type);
    self.seletedType=type;
    NSArray *listArr=self.headModel.select;
    if(listArr.count>0){
        FNMarketCentreSelectModel *itemModel=[FNMarketCentreSelectModel mj_objectWithKeyValues:listArr[index]];
        NSArray *arrM=itemModel.list;
        NSMutableArray *arrList=[NSMutableArray arrayWithCapacity:0];
        [arrM enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNMarketCentreSelectItemModel *itemModel=[FNMarketCentreSelectItemModel mj_objectWithKeyValues:obj];
            if(idx==0){
                itemModel.seletedInt=1;
            }
            if(index==0 && [itemModel.type1 kr_isNotEmpty]){
                itemModel.img=@"FN_mer_sjNorimg";
                itemModel.imgOne=@"FN_mer_sjTopimg";
                itemModel.imgTwo=@"FN_mer_sjBaseimg";
            }
            itemModel.select_color=self.headModel.select_color;
            [arrList addObject:itemModel];
        }];
         FNMarketCentreSelectItemModel *oneModel=[FNMarketCentreSelectItemModel mj_objectWithKeyValues:arrM[0]];
        self.typeString=oneModel.type;
        self.typeArr=arrList;
        if([self.typeString kr_isNotEmpty]){
           self.jm_page=1;
           [self requestSotreList];
        }
    }
    [UIView performWithoutAnimation:^{ 
        [self.jm_collectionview reloadData];
    }];
}
#pragma mark - FNmarScreensfViewDelegate
// 点击  状态
-(void)inMarketScreensfSeletedType:(NSString *)type{
    XYLog(@"type2=%@",type);
    self.typeString=type;
    if([self.typeString kr_isNotEmpty]){
        self.jm_page=1;
        [self requestSotreList];
    }
}
#pragma mark - request
//推手中心首页接口
-(FNRequestTool*)requestSlapdHeader{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.confirm kr_isNotEmpty]){
       params[@"confirm"]=self.confirm;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=push_hand&ctrl=index" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
       
        NSDictionary *dictry = respondsObject[DataKey];
        self.headModel=[FNMarketCentreModel mj_objectWithKeyValues:dictry];
        NSString *statusStr=self.headModel.status;
        if([statusStr isEqualToString:@"no_apply"]){
            FNHandSlapdController *vc=[[FNHandSlapdController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if([statusStr isEqualToString:@"in_check"]){
            FNHandResultController *vc=[[FNHandResultController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if(![statusStr isEqualToString:@"no_apply"]&&![statusStr isEqualToString:@"in_check"]){
            [self.imgBgView setUrlImg:self.headModel.img];
            if([self.headModel.bili kr_isNotEmpty]){
                CGFloat imgHight=FNDeviceWidth*[self.headModel.bili floatValue]-64+SafeAreaTopHeight;
                if(imgHight<267+SafeAreaTopHeight){
                   imgHight=267+SafeAreaTopHeight;
                }
                self.bgImgHeight=FNDeviceWidth*[self.headModel.bili floatValue]-64+SafeAreaTopHeight;
                if(self.bgImgHeight<267+SafeAreaTopHeight){
                   self.bgImgHeight=267+SafeAreaTopHeight;
                }
                [self.imgBgView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view).offset(0);
                    make.left.right.equalTo(self.view);
                    make.height.mas_equalTo(imgHight);
                }];
            }
            self.navigationView.titleLabel.text=@"推手中心";
            [self.leftBtn setImage:IMAGE(@"return_w") forState:UIControlStateNormal];
            self.navigationView.titleLabel.textColor=[UIColor colorWithHexString:self.headModel.color];
            self.navigationView.backgroundColor=[UIColor clearColor];
            [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            //[self requestMerchantList];
           
            NSArray *listArr=self.headModel.select;
            if(listArr.count>0){
                FNMarketCentreSelectModel *leftModel=[FNMarketCentreSelectModel mj_objectWithKeyValues:listArr[0]];
                NSArray *arrM=leftModel.list;
                NSMutableArray *arrList=[NSMutableArray arrayWithCapacity:0];
                [arrM enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    FNMarketCentreSelectItemModel *itemModel=[FNMarketCentreSelectItemModel mj_objectWithKeyValues:obj];
                    itemModel.select_color=self.headModel.select_color;
                    if(idx==0){
                       itemModel.seletedInt=1;
                    }
                    if(idx>0 && [itemModel.type1 kr_isNotEmpty]){
                        itemModel.img=@"FN_mer_sjNorimg";
                        itemModel.imgOne=@"FN_mer_sjTopimg";
                        itemModel.imgTwo=@"FN_mer_sjBaseimg";
                    }
                    [arrList addObject:itemModel];
                }]; 
                self.typeArr=arrList;
                FNMarketCentreSelectItemModel *oneModel=[FNMarketCentreSelectItemModel mj_objectWithKeyValues:arrM[0]];
                self.typeString=oneModel.type;
                self.jm_page=1;
                [self requestSotreList];
            }
             [self.jm_collectionview reloadData];
        }
        if([statusStr isEqualToString:@"no_apply"]){
            NSString *msgStr=respondsObject[MsgKey];
            [FNTipsView showTips:msgStr];
        }
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}
//推手中心-推荐店铺列表
-(FNRequestTool*)requestSotreList{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}]; 
    NSString *urlStr=@"mod=appapi&act=push_hand&ctrl=sotre_list";
    params[@"type"]=self.typeString;
    if([self.seletedType isEqualToString:@"order"]){
        urlStr=@"mod=appapi&act=push_hand&ctrl=order_commission_list";
        //@"mod=appapi&act=push_hand&ctrl=sotre_list"; 
    }
    if([self.seletedType isEqualToString:@"store"]){
        urlStr=@"mod=appapi&act=push_hand&ctrl=opne_award";
    }
    return [FNRequestTool requestWithParams:params api:urlStr respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSArray *array =respondsObject[DataKey];
        if (self.jm_page == 1) {
            if (array.count == 0) {
                [self.dataArr removeAllObjects];
                [self.jm_collectionview reloadData];
                return ;
            }
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:array];
            if (array.count >= _jm_pro_pagesize) {
                self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.jm_page ++;
                    [self requestSotreList];
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
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (NSMutableArray *)typeArr {
    if (!_typeArr) {
        _typeArr = [NSMutableArray array];
    }
    return _typeArr;
}
@end
