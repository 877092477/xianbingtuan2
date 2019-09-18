//
//  FNmerConsumeSeekController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/7.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerConsumeSeekController.h"
#import "FNCustomeNavigationBar.h"
#import "FNmerConsumeSeekHCell.h"
#import "FNmerOrderMsgItemCell.h"
#import "FNmerConSeekGoodsItemCell.h"
#import "FNconSeekDiscountsItemCell.h"
#import "FNconSeekGoodsHeadView.h"
#import "FNconSeekGoodsSternView.h"
#import "FNmerOrderZModel.h"
#import "FNmerConsumeModel.h"
@interface FNmerConsumeSeekController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNmerConsumeSeekHCellDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar *navigationView; 
@property (nonatomic, strong)UIButton     *leftBtn;
@property (nonatomic, strong)UIButton     *rightBtn;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSString  *seekOdd;
@property (nonatomic, strong)FNmerConsumeModel *dataModel;
@end

@implementation FNmerConsumeSeekController

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

- (void)setSeekWord: (NSString*)word {
    _seekOdd = word;
    _seekWord = word;
}

#pragma mark - set up views
- (void)jm_setupViews{
//    self.seekOdd=@"";
    self.dataArr=[NSMutableArray arrayWithCapacity:0];
    FNmerConsumeModel *oneModel=[[FNmerConsumeModel alloc]init];
    oneModel.type=@"seekStyle";
    oneModel.seekStr=self.seekWord ? self.seekWord:@"";
    [self.dataArr addObject:oneModel];
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.leftBtn.size = CGSizeMake(40, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightBtn.size = CGSizeMake(54, 27);
    self.navigationView.rightButton = self.rightBtn;
    [self.rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.rightBtn setTitle:@"确认" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font=kFONT14;
    self.rightBtn.backgroundColor=RGB(255, 188, 133);
    self.rightBtn.cornerRadius=5/2;
    [self.view addSubview:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 5).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:16];
    self.navigationView.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    self.navigationView.titleLabel.text=@"扫描/输入消费码";
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=RGB(250, 250, 250);
    
    CGFloat baseGap=SafeAreaTopHeight+1;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, baseGap, FNDeviceWidth, FNDeviceHeight-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
    [self.jm_collectionview registerClass:[FNmerConsumeSeekHCell class] forCellWithReuseIdentifier:@"FNmerConsumeSeekHCellID"];
    [self.jm_collectionview registerClass:[FNmerOrderMsgItemCell class] forCellWithReuseIdentifier:@"FNmerOrderMsgItemCellID"];
    [self.jm_collectionview registerClass:[FNmerConSeekGoodsItemCell class] forCellWithReuseIdentifier:@"FNmerConSeekGoodsItemCellID"];
    [self.jm_collectionview registerClass:[FNconSeekDiscountsItemCell class] forCellWithReuseIdentifier:@"FNconSeekDiscountsItemCellID"];
    
    
    [self.jm_collectionview registerClass:[FNconSeekGoodsHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNconSeekGoodsHeadViewID"];
    
    [self.jm_collectionview registerClass:[FNconSeekGoodsSternView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FNconSeekGoodsSternViewID"];
    
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewID"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView"];
    
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    
    if([self.seekWord kr_isNotEmpty]){
       [self requestOrderDetails:self.seekWord];
       self.rightBtn.backgroundColor=RGB(255, 121, 37);
    }
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    FNmerConsumeModel *model=self.dataArr[section];
    NSArray *listarr=model.listArr;
    if([model.type isEqualToString:@"seekStyle"]){
       return 1;
    }
    else if([model.type isEqualToString:@"twoStyle"]){
        return listarr.count;
    }
    else if([model.type isEqualToString:@"msgStyle"]){
        return listarr.count;
    }
    else{
     return 0;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNmerConsumeModel *model=self.dataArr[indexPath.section];
    NSArray *listarr=model.listArr;
    if([model.type isEqualToString:@"seekStyle"]){
        FNmerConsumeSeekHCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerConsumeSeekHCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        cell.cornerRadius=5/2;
        cell.delegate=self;
        cell.model=model;
        return cell;
    }
    else if([model.type isEqualToString:@"twoStyle"]){
        FNmerConsumeGoodsItemModel *itemModel=[FNmerConsumeGoodsItemModel mj_objectWithKeyValues:listarr[indexPath.row]];
        if([itemModel.type isEqualToString:@"goods"]){
            FNmerConSeekGoodsItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerConSeekGoodsItemCellID" forIndexPath:indexPath];
            cell.backgroundColor=[UIColor clearColor];
            cell.model=itemModel;
            return cell;
        }else{
            FNconSeekDiscountsItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNconSeekDiscountsItemCellID" forIndexPath:indexPath];
            cell.backgroundColor=[UIColor clearColor];
            cell.model=itemModel;
            return cell;
        }
    }
    else if([model.type isEqualToString:@"msgStyle"]){
        FNmerOrderZZHModel *msgModel=[FNmerOrderZZHModel mj_objectWithKeyValues:listarr[indexPath.row]];
        FNmerOrderMsgItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerOrderMsgItemCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        cell.model=msgModel;
        return cell;
    }
    else{
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemWith=FNDeviceWidth;
    CGFloat itemHeight=0;
    FNmerConsumeModel *model=self.dataArr[indexPath.section];
    if([model.type isEqualToString:@"seekStyle"]){
        itemHeight=97;
    }
    else if([model.type isEqualToString:@"twoStyle"]){
        FNmerConsumeGoodsItemModel *itemModel=[FNmerConsumeGoodsItemModel mj_objectWithKeyValues:model.listArr[indexPath.row]];
        if([itemModel.type isEqualToString:@"goods"]){
           itemHeight=38;
        }else{
           itemHeight=26;
        } 
    }
    else if([model.type isEqualToString:@"msgStyle"]){
        itemHeight=22;
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
    
    FNmerConsumeModel *model=self.dataArr[indexPath.section];
    if (kind == UICollectionElementKindSectionHeader) {
        FNconSeekGoodsHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNconSeekGoodsHeadViewID" forIndexPath:indexPath];
        headerView.backgroundColor=[UIColor clearColor];
        if([model.type isEqualToString:@"seekStyle"]){
           headerView.titleLB.text=@"";
           headerView.lineView.backgroundColor=[UIColor clearColor];
        }
        else if([model.type isEqualToString:@"twoStyle"]){
            headerView.titleLB.text=self.dataModel.store;
            headerView.lineView.backgroundColor=RGB(246, 245, 245);
            headerView.backgroundColor=[UIColor clearColor];
        }
        else if([model.type isEqualToString:@"msgStyle"]){
            headerView.titleLB.text=@"订单信息";
            headerView.lineView.backgroundColor=RGB(246, 245, 245);
            headerView.backgroundColor=[UIColor clearColor];
        }
        return headerView;
    }
    else{
        if([model.type isEqualToString:@"seekStyle"]){
            UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView" forIndexPath:indexPath];
            footView.backgroundColor=[UIColor clearColor];
            return footView;
        }else{
            FNconSeekGoodsSternView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FNconSeekGoodsSternViewID" forIndexPath:indexPath];
            footView.model=model;
            footView.backgroundColor=[UIColor clearColor];
            if([model.type isEqualToString:@"msgStyle"]){
                [footView.matterBtn addTarget:self action:@selector(matterBtnClick)];
            }
            return footView;
        }
    } 
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=0;
    FNmerConsumeModel *oneModel=self.dataArr[section];
    if([oneModel.type isEqualToString:@"seekStyle"]){
        hight=15;
    }
    else if([oneModel.type isEqualToString:@"twoStyle"]){
        hight=59;
    }
    else if([oneModel.type isEqualToString:@"msgStyle"]){
        hight=56;
    }
    else{
        hight=0;
    }
    return CGSizeMake(with,hight);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=0;
    FNmerConsumeModel *oneModel=self.dataArr[section];
    if([oneModel.type isEqualToString:@"seekStyle"]){
        hight=0;
    }
    else if([oneModel.type isEqualToString:@"twoStyle"]){
        hight=65;
    }
    else if([oneModel.type isEqualToString:@"msgStyle"]){
        hight=90;
    }
    else{
        hight=0;
    }
    return CGSizeMake(with,hight);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=0;
    CGFloat bottomGap=0;
    CGFloat rightGap=0;
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}

#pragma mark - FNmerConsumeSeekHCellDelegate
// 编辑
- (void)didmerConsumeSeekHActionwithContent:(NSString*)content withIndex:(NSIndexPath*)index{
    XYLog(@"编辑:%@",content);
//    NSIndexPath *indexReload = [NSIndexPath indexPathForRow:0 inSection:0];
//     FNmerConsumeSeekHCell *itemCell=(FNmerConsumeSeekHCell *)[self.jm_collectionview cellForItemAtIndexPath:indexReload];
    if([content kr_isNotEmpty]){
       self.rightBtn.backgroundColor=RGB(255, 121, 37);
       //itemCell.backgroundColor=RGB(250, 250, 250);
    }else{
       self.rightBtn.backgroundColor=RGB(255, 188, 133);
       //itemCell.backgroundColor=[UIColor whiteColor];
    }
    self.seekOdd=content;
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//确认
-(void)rightBtnAction{
    if([self.seekOdd kr_isNotEmpty]){
       [self requestOrderDetails:self.seekOdd];
    }
}
//确认此订单
-(void)matterBtnClick{
    if([self.dataModel.id kr_isNotEmpty]){
       [self requestAffirmUseOrder:self.dataModel.id];
    }
}
#pragma mark - // request
//根据付款码【扫二维码】展示订单接口
-(void)requestOrderDetails:(NSString*)orderId{ 
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([orderId kr_isNotEmpty]){
        params[@"code"]=orderId;
    }
     [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_store_other&ctrl=show_order_by_code" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary *dictry=respondsObject[DataKey];
         self.dataModel=[FNmerConsumeModel mj_objectWithKeyValues:dictry];
         NSArray *goodsArr=self.dataModel.goods;
         NSArray *msgArr=self.dataModel.order_msg;
         if(self.dataArr.count>1){
            [self.dataArr removeAllObjects];
             self.dataArr=[NSMutableArray arrayWithCapacity:0];
             FNmerConsumeModel *oneModel=[[FNmerConsumeModel alloc]init];
             oneModel.type=@"seekStyle";
             oneModel.seekStr=orderId;
             [self.dataArr addObject:oneModel];
             if(goodsArr.count>0){
                 FNmerConsumeModel *twoModel=[[FNmerConsumeModel alloc]init];
                 twoModel.type=@"twoStyle";
                 twoModel.listArr=goodsArr;
                 twoModel.shifu=self.dataModel.shifu;
                 [self.dataArr addObject:twoModel];
             }
             if(msgArr.count>0){
                 FNmerConsumeModel *msgModel=[[FNmerConsumeModel alloc]init];
                 msgModel.type=@"msgStyle";
                 msgModel.listArr=msgArr;
                 [self.dataArr addObject:msgModel];
             }
         }else{
             if(goodsArr.count>0){
                 FNmerConsumeModel *twoModel=[[FNmerConsumeModel alloc]init];
                 twoModel.type=@"twoStyle";
                 twoModel.listArr=goodsArr;
                 twoModel.shifu=self.dataModel.shifu;
                 [self.dataArr addObject:twoModel];
             }
             if(msgArr.count>0){
                 FNmerConsumeModel *msgModel=[[FNmerConsumeModel alloc]init];
                 msgModel.type=@"msgStyle";
                 msgModel.listArr=msgArr;
                 [self.dataArr addObject:msgModel];
             }
         }
         self.jm_collectionview.backgroundColor=RGB(250, 250, 250);
         [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {
    } isHideTips:YES isCache:NO];
}
//商家中心-确认使用订单
-(void)requestAffirmUseOrder:(NSString*)orderId{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([orderId kr_isNotEmpty]){
        params[@"id"]=orderId;
    }
    [FNRequestTool requestWithParams:params api:@"mod=&act=under_rebate_store&ctrl=order_use" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSInteger stateInt=[respondsObject[SuccessKey] integerValue];
        NSString *msgStr=respondsObject[MsgKey];
        if(stateInt==1){
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
            [SVProgressHUD showImage:IMAGE(@"FN_sj_SetgouImg") status:msgStr];
            [SVProgressHUD dismissWithDelay:1.5];
        }
        if(stateInt==0){
           [FNTipsView showTips:msgStr];
        }
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}
@end
