//
//  FNmerIssuePagController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerIssuePagController.h"
#import "FNCustomeNavigationBar.h"
#import "FNmerIssueEditOCell.h"
#import "FNmerIssueDateSCell.h"
#import "FNmerIssueocModel.h"
#import "FNcalendarPopDeView.h"
#import "NSDate+HXExtension.h"
#import "YBPopupMenu.h"
#import "PGDatePickManager.h"
#import "FNDeliveryDatepView.h"
#import "FNStoreGoodsSelectManagerController.h"
@interface FNmerIssuePagController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNmerIssueEditOCellDelegate,FNcalendarPopDeViewDegate,YBPopupMenuDelegate,PGDatePickerDelegate,FNDeliveryDatepViewDelegate, FNStoreGoodsSelectManagerControllerDelegate>
//UITextFieldDelegate
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableArray *extraArr;
@property (nonatomic, strong)NSMutableArray *conditionArr;
@property (nonatomic, strong)NSString* type;
@property (nonatomic, strong)NSString* name;
@property (nonatomic, strong)NSString* price;//             红包总金额
@property (nonatomic, strong)NSString* counts;//            红包数量
@property (nonatomic, strong)NSString* is_luck;//           是否为拼手气红包    0 否 1 是
@property (nonatomic, strong)NSString* reduct_condition;//  满减门槛
@property (nonatomic, strong)NSString* discount_use;//      使用门槛-特惠商品    值在使用门槛接口，不选则不传
@property (nonatomic, strong)NSString* coupon_use;//        使用门槛-与优惠券叠加    值在使用门槛接口，不选则不传
@property (nonatomic, strong)NSString* allow_cates;//参加满减的商品分类
@property (nonatomic, strong)NSString* allow_goods;//参加满减的具体商品    1,2
@property (nonatomic, strong)NSString* on_line;//买单方式->线上
@property (nonatomic, strong)NSString* on_shop;//买单方式->门店
@property (nonatomic, strong)NSString* start_time;//        开始时间    年月日
@property (nonatomic, strong)NSString* end_time;//          结束时间    年月日
@property (nonatomic, strong)NSString* start_Hour;//        开始时间    年月日 + 时分秒
@property (nonatomic, strong)NSString* end_Hour;//          结束时间    年月日 + 时分秒
@property (nonatomic, assign)NSInteger dateStar;


@property (nonatomic, strong)NSDate *sTime;
@property (nonatomic, strong)NSDate *eTime;
@property (nonatomic, strong)NSString* distanceCount;//距离天数
@property (nonatomic, strong)NSString* validity;//有效期

//添加折扣所需字段
@property (nonatomic, strong)NSString* idZK;//    否    int    折扣id    修改折扣时传递
@property (nonatomic, strong)NSString* discount;//    是    int    具体折扣    例：8 == 8折
@property (nonatomic, strong)NSString* start_hoursZK;//  开始具体时间    00:00
@property (nonatomic, strong)NSString* end_hoursZK;//    结束具体时间    12:00


@property (nonatomic, strong)DSHPopupContainer   *container;

@property (nonatomic, strong)FNmoneyOffFullMinusModel *discountModel;
@end

@implementation FNmerIssuePagController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //区别标识
    //pub_red_packet_list 红包
    //red_packet 红包
    //pub_yhq_list 优惠券
    //yhq 优惠券
    //discount 折扣
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
    self.on_line=@"0";
    self.on_shop=@"0";
    self.distanceCount=@"0天";
    self.validity=@"0天";
    self.allow_cates=@"";
    self.allow_goods=@"";
    if([self.typeStyle isEqualToString:@"discount"]){
        if(![self.idAlter kr_isNotEmpty]){
           [self addDiscountModel];
        }else{
           [self requestActivityDiscountMsg];
        }
    } 
    if([self.typeStyle isEqualToString:@"pub_red_packet_list"]||[self.typeStyle isEqualToString:@"red_packet"]||[self.typeStyle isEqualToString:@"pub_yhq_list"]||[self.typeStyle isEqualToString:@"yhq"]){
        [self addDataArrMsg];
    }
    CGFloat baseGap=SafeAreaTopHeight+15;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, baseGap, FNDeviceWidth, FNDeviceHeight-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    self.jm_collectionview.backgroundColor=RGB(246, 245, 245);
    [self.view addSubview:self.jm_collectionview]; 
    
    [self.jm_collectionview registerClass:[FNmerIssueEditOCell class] forCellWithReuseIdentifier:@"FNmerIssueEditOCellID"];
    
    [self.jm_collectionview registerClass:[FNmerIssueDateSCell class] forCellWithReuseIdentifier:@"FNmerIssueDateSCellID"];
    
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
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    
    self.view.backgroundColor=RGB(246, 245, 245);
    if([self.typeStyle isEqualToString:@"pub_red_packet_list"]){
       self.navigationView.titleLabel.text=@"发布红包";
    }else if([self.typeStyle isEqualToString:@"pub_yhq_list"]){
       self.navigationView.titleLabel.text=@"发布优惠券";
    }
    if([self.typeStyle isEqualToString:@"red_packet"]){
       self.navigationView.titleLabel.text=@"发布红包";
    }
    if([self.typeStyle isEqualToString:@"yhq"]){
        self.navigationView.titleLabel.text=@"发布优惠券";
    }
    if([self.typeStyle isEqualToString:@"full_reduction"]){
        self.navigationView.titleLabel.text=@"创建满减";
    }
    if([self.typeStyle isEqualToString:@"discount"]){
        self.navigationView.titleLabel.text=@"创建限时折扣";
    }
    
    //[self requestConditionList];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){
       return self.dataArr.count;
    }
    else if(section==1){
        return self.extraArr.count;
    }
    else{
       return 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
       FNmerIssueEditOCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerIssueEditOCellID" forIndexPath:indexPath];
        //FNmerIssueocModel *itemModel=self.dataArr[indexPath.row];
        //FNmerIssueEditOCell *cell = [FNmerIssueEditOCell cellWithCollectionView:collectionView atIndexPath:indexPath withStyle:itemModel.isStyle];
        cell.model=self.dataArr[indexPath.row];
        cell.delegate=self;
        cell.index=indexPath; 
       return cell;
    }
    else if(indexPath.section==1){
        FNmerIssueEditOCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerIssueEditOCellID" forIndexPath:indexPath];
        cell.model=self.extraArr[indexPath.row];
        cell.delegate=self;
        cell.index=indexPath;
        return cell;
    }
    else{
       FNmerIssueDateSCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerIssueDateSCellID" forIndexPath:indexPath];
        if([self.typeStyle isEqualToString:@"pub_red_packet_list"]||[self.typeStyle isEqualToString:@"red_packet"]){
            [cell.issueBtn setTitle:@"发布红包" forState:UIControlStateNormal];
            [cell.issueBtn setBackgroundImage:IMAGE(@"FN_yhqANhbNobg") forState:UIControlStateNormal];
        }else if([self.typeStyle isEqualToString:@"pub_yhq_list"]||[self.typeStyle isEqualToString:@"yhq"]){
            [cell.issueBtn setTitle:@"发布优惠券" forState:UIControlStateNormal];
            [cell.issueBtn setBackgroundImage:IMAGE(@"FN_yhqANhbNobg") forState:UIControlStateNormal];
        }
        else if([self.typeStyle isEqualToString:@"full_reduction"]){
            [cell.issueBtn setTitle:@"创建满减" forState:UIControlStateNormal];
        }
        else if([self.typeStyle isEqualToString:@"discount"]){ 
            [cell.issueBtn setBackgroundImage:IMAGE(@"FN_zhekounoBCimg") forState:UIControlStateNormal];
            if(![self.idAlter kr_isNotEmpty]){
                [cell.issueBtn setTitle:@"创建限时折扣" forState:UIControlStateNormal];
            }else{
                [cell.issueBtn setTitle:@"确认修改" forState:UIControlStateNormal];
            }
        }
        [cell.startBtn addTarget:self action:@selector(startBtnClick)];
        [cell.endBtn addTarget:self action:@selector(endBtnClick)];
        [cell.issueBtn addTarget:self action:@selector(issueBtnClick)];
        
        if([self.typeStyle isEqualToString:@"discount"]){
            if([self.start_time kr_isNotEmpty]){
                [cell.startBtn setTitle:self.start_time forState:UIControlStateNormal];
            }
            if([self.end_time kr_isNotEmpty]){
                [cell.endBtn setTitle:self.end_time forState:UIControlStateNormal];
            }
        }
        if([self.typeStyle isEqualToString:@"pub_red_packet_list"]||[self.typeStyle isEqualToString:@"red_packet"]||[self.typeStyle isEqualToString:@"pub_yhq_list"]||[self.typeStyle isEqualToString:@"yhq"]){
            if([self.start_Hour kr_isNotEmpty]){
                [cell.startBtn setTitle:self.start_Hour forState:UIControlStateNormal];
            }
            if([self.end_Hour kr_isNotEmpty]){
                [cell.endBtn setTitle:self.end_Hour forState:UIControlStateNormal];;
            }
        }
        cell.hintLB.text=[NSString stringWithFormat:@"满减活动将于 %@ 后开始，有效期  %@",self.distanceCount,self.validity];
        //[cell.hintLB fn_changeColorWithTextColor:RGB(255, 102, 0) changeTexts:@[self.distanceCount,self.validity]];
        [cell.hintLB fn_changeColorWithTextColor:RGB(255, 102, 0) changeText:self.distanceCount];
        [cell.hintLB fn_changeColorWithTextColor:RGB(255, 102, 0) changeText:self.validity];
        cell.typeStr=self.typeStyle;
       return cell;
    }
} 
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=70;
    CGFloat itemWith=FNDeviceWidth;
    if(indexPath.section==0){
       FNmerIssueocModel *model=self.dataArr[indexPath.row];
       itemHeight=model.rowheight;
    }
    else if(indexPath.section==1){
        itemHeight=75;
    }else{
       itemHeight=190;
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
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=0;
    CGFloat bottomGap=0;
    CGFloat rightGap=0;
//    if(section==0){
//       topGap=10;
//    }
//    if(section==2){
//       bottomGap=10;
//    }
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
     
}
//FNmerIssueEditOCellDelegate
// 编辑
- (void)didMerIssueEditOC:(NSIndexPath*)index withContent:(NSString*)content{
    FNmerIssueocModel *item1Model=self.dataArr[index.row];
    item1Model.value=content;
    if([self.typeStyle isEqualToString:@"pub_red_packet_list"]||[self.typeStyle isEqualToString:@"red_packet"]||[self.typeStyle isEqualToString:@"pub_yhq_list"]||[self.typeStyle isEqualToString:@"yhq"]){
        if(index.row==0){
            self.name=content;
        }
        if(index.row==2){
            self.price=content;
        }
        if(index.row==3){
            self.counts=content;
        }
        if(index.row==4){
            self.reduct_condition=content;
        }
        if([self.price kr_isNotEmpty]&&[self.reduct_condition kr_isNotEmpty]){
            FNmerIssueocModel *itemModel=self.dataArr[4];
            itemModel.bottomHint=[NSString stringWithFormat:@"商品满 %@ 元即可减少 %@元",self.reduct_condition,self.price];
            //@"商品满 0 元即可减少 0 元";
            itemModel.value1Orange=self.price;
            itemModel.value2Orange=self.reduct_condition;
            NSIndexPath *indexReload = [NSIndexPath indexPathForRow:4 inSection:0];
            @weakify(self);
            [UIView performWithoutAnimation:^{
                @strongify(self);
                [self.jm_collectionview reloadItemsAtIndexPaths:@[indexReload]];
            }];
        }
    }
    if([self.typeStyle isEqualToString:@"discount"]){
        if(index.row==1){
           self.discount=content;
        }
    }
    //pub_red_packet_list 红包
    //red_packet 红包
    //pub_yhq_list 优惠券
    //yhq 优惠券
    //discount 折扣
    [self upCellBtnBGimg];
}
// 修改 红包 状态
- (void)didMerIssueLuckIndex:(NSIndexPath*)index withLuck:(NSString*)luck{
    if([self.typeStyle isEqualToString:@"red_packet"] || [self.typeStyle isEqualToString:@"pub_red_packet_list"]){
        FNmerIssueocModel *itemModel=self.dataArr[index.row];
        itemModel.isStyle=3;
        if(index.row==2){
            if([itemModel.isCommon integerValue]==0){
                itemModel.isCommon=@"1";
                itemModel.bottomHint=@"当前为拼手气红包，改为普通红包";
                itemModel.value1Orange=@"改为普通红包";
            }else{
                itemModel.isCommon=@"0";
                itemModel.bottomHint=@"当前为普通红包，改为拼手气红包";
                itemModel.value1Orange=@"改为拼手气红包";
            }
            self.is_luck=itemModel.isCommon;
            @weakify(self);
            [UIView performWithoutAnimation:^{
                @strongify(self);
                [self.jm_collectionview reloadItemsAtIndexPaths:@[index]];
            }];
        }
    }
    
}
// 点击右边按钮
- (void)didMerIssueCouponUseIndex:(NSIndexPath*)index withView:(UICollectionViewCell*)cell{
    if([self.typeStyle isEqualToString:@"discount"]){
        if(index.row==2){
            XYLog(@"时间");
            FNDeliveryDatepView *customDateView = [[FNDeliveryDatepView alloc] init];
            customDateView.delegate=self;
            [customDateView.leftBtn addTarget:self action:@selector(inDateCancelClick)];
            self.container = [[DSHPopupContainer alloc] initWithCustomPopupView:customDateView];
            self.container.autoDismissWhenClickedBackground=NO;
            self.container.maskColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
            [self.container show];
        }
        if(index.row==3){
            XYLog(@"适用范围");
            FNStoreGoodsSelectManagerController *vc = [[FNStoreGoodsSelectManagerController alloc] init];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        XYLog(@"红包或者优惠券适用范围");
        FNStoreGoodsSelectManagerController *vc = [[FNStoreGoodsSelectManagerController alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    [self upCellBtnBGimg];
//    FNmerIssueEditOCell *itemCell=(FNmerIssueEditOCell *)[self.jm_collectionview cellForItemAtIndexPath:index];
//    NSMutableArray *arrTitle=[NSMutableArray arrayWithCapacity:0];
//    for (FNmerIssueocModel *model in self.conditionArr) {
//        [arrTitle addObject:model.str];
//    }
//    if(arrTitle.count>0){
//        [YBPopupMenu showRelyOnView:itemCell.dibuView titles:arrTitle icons:nil menuWidth:150 otherSettings:^(YBPopupMenu *popupMenu) {
//            popupMenu.priorityDirection = YBPopupMenuPriorityDirectionTop;//YBPopupMenuPriorityDirectionBottom;
//            popupMenu.borderWidth = 1;
//            popupMenu.borderColor = RGB(246, 245, 245);
//            popupMenu.delegate = self;
//            popupMenu.showMaskView=NO;
//            popupMenu.offset=2;
//            popupMenu.maxVisibleCount = 3;
//            popupMenu.fontSize=12;
//            popupMenu.itemHeight = 50;
//            popupMenu.dismissOnTouchOutside = YES;
//            popupMenu.textColor = RGB(24, 24, 24);
//        }];
//    }
    
}
// YBPopupMenuDelegate
//- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index
//{
//    //推荐回调
//    XYLog(@"点击了 %@ 选项",ybPopupMenu.titles[index]);
//    FNmerIssueocModel *model=self.conditionArr[index];
//    self.discount_use=model.type;
//}
// 开关
- (void)didMerIssueEditSwitch:(NSIndexPath*)index withView:(UICollectionViewCell*)cell{
    FNmerIssueEditOCell *itemCell=(FNmerIssueEditOCell *)[self.jm_collectionview cellForItemAtIndexPath:index];
    FNmerIssueocModel *model=self.dataArr[index.row];
    model.isStyle=5;
    if(model.switchState==0){
       model.switchState=1;
       [itemCell.switchBtn setBackgroundImage:IMAGE(@"FN_xdSJ_kqim") forState:UIControlStateNormal];
        self.coupon_use=@"1";
    }else{
       model.switchState=0;
        [itemCell.switchBtn setBackgroundImage:IMAGE(@"FN_xdSJ_gbimg") forState:UIControlStateNormal];
        self.coupon_use=@"0";
    }
    
    [UIView performWithoutAnimation:^{
        //[self.jm_collectionview reloadItemsAtIndexPaths:@[index]];
        //[self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:0]];
    }];
}

#pragma mark - //开始时间  选择日历
-(void)startBtnClick{
    self.dateStar=1;
    NSDate *today = [NSDate dateWithTimeIntervalSinceNow: 0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dayTo=[formatter stringFromDate:today];
    FNcalendarPopDeView *calendarView = [[FNcalendarPopDeView alloc]initWithFrame:self.view.frame withMinimumDate:dayTo];
    calendarView.delegate=self;
    [[UIApplication sharedApplication].delegate.window addSubview:calendarView];
}
//结束时间  日历
-(void)endBtnClick{
    self.dateStar=2;
    NSDate *today = [NSDate dateWithTimeIntervalSinceNow: 0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dayTo=[formatter stringFromDate:today];
    FNcalendarPopDeView *calendarView = [[FNcalendarPopDeView alloc]initWithFrame:self.view.frame withMinimumDate:dayTo];
    calendarView.delegate=self;
    [[UIApplication sharedApplication].delegate.window addSubview:calendarView];
}
#pragma mark -   FNDeliveryDatepViewDelegate 单天营业时间 HH:mm 只在 创建添加折扣时使用
- (void)inDateConfirmActionWithContent:(NSString*)start withContent:(NSString*)end{
    XYLog(@"开始时间 = %@  结束时间 = %@", start,end);
    self.start_hoursZK=start;
    self.end_hoursZK=end;
    [self.container dismiss];
    if([self.typeStyle isEqualToString:@"discount"]){
        @weakify(self);
        [UIView performWithoutAnimation:^{
            @strongify(self);
            [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:0]];
        }];
        NSIndexPath *index = [NSIndexPath indexPathForRow:2 inSection:0];
        FNmerIssueEditOCell *itemCell=(FNmerIssueEditOCell *)[self.jm_collectionview cellForItemAtIndexPath:index];
        if([start kr_isNotEmpty]&&[end kr_isNotEmpty]){
           [itemCell.rightBtn setTitle:[NSString stringWithFormat:@"%@ - %@",start,end] forState:UIControlStateNormal];
        }
    }
}
-(void)inDateCancelClick{
    [self.container dismiss];
}
//发布
-(void)issueBtnClick{
 
//        params[@"discount_use"]=self.discount_use;
//        params[@"coupon_use"]=self.coupon_use;
  if([self.typeStyle isEqualToString:@"pub_red_packet_list"]||[self.typeStyle isEqualToString:@"red_packet"]||[self.typeStyle isEqualToString:@"pub_yhq_list"]||[self.typeStyle isEqualToString:@"yhq"]){
      if(![self.name kr_isNotEmpty]){
          [FNTipsView showTips:@"请输入名称"];
          return;
      }
      else if(![self.price kr_isNotEmpty]){
          [FNTipsView showTips:@"请输入总金额"];
          return;
      }
      else if(![self.counts kr_isNotEmpty]){
          [FNTipsView showTips:@"请输入数量"];
          return;
      }
      else if(![self.reduct_condition kr_isNotEmpty]){
          [FNTipsView showTips:@"请选择满减门槛"];
          return;
      }
      else if(![self.start_Hour kr_isNotEmpty]){
          [FNTipsView showTips:@"请选择开始时间"];
          return;
      }
      else if(![self.end_Hour kr_isNotEmpty]){
          [FNTipsView showTips:@"请选择结束时间"];
          return;
      }
   
      [self requestAdd_red_packet];
    }
    
    if([self.typeStyle isEqualToString:@"discount"]){
        if(![self.discount kr_isNotEmpty]){
            [FNTipsView showTips:@"请输入折扣信息"];
            return;
        }
        else if(![self.start_hoursZK kr_isNotEmpty]){
            [FNTipsView showTips:@"请选择开始具体时间"];
            return;
        }
        else if(![self.end_hoursZK kr_isNotEmpty]){
            [FNTipsView showTips:@"请选择结束具体时间"];
            return;
        }
        else if(![self.start_time kr_isNotEmpty]){
            [FNTipsView showTips:@"请选择开始时间"];
            return;
        }
        else if(![self.end_time kr_isNotEmpty]){
            [FNTipsView showTips:@"请选择结束时间"];
            return;
        }
        else if(![self.allow_cates kr_isNotEmpty]){
            [FNTipsView showTips:@"请添加商品"];
            return;
        }
        else if(![self.allow_goods kr_isNotEmpty]){
            [FNTipsView showTips:@"请添加商品"];
            return;
        }
        
        
        [self requestAddDiscount];
    }
    
}
#pragma mark - FNcalendarPopDeViewDegate // 选择日期(yyyy-MM-dd) 关闭日历后 打开 选择时间时分
- (void)popSeletedDateClick:(NSString *)date{
    if([self.typeStyle isEqualToString:@"pub_red_packet_list"]||[self.typeStyle isEqualToString:@"red_packet"]||[self.typeStyle isEqualToString:@"pub_yhq_list"]||[self.typeStyle isEqualToString:@"yhq"]){
        XYLog(@"选择日期=:%@",date);
        PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
        PGDatePicker *datePicker = datePickManager.datePicker;
        //    datePicker.isOnlyHourFlag = YES;
        datePicker.delegate = self;
        datePicker.datePickerMode = PGDatePickerModeTimeAndSecond;
        [self presentViewController:datePickManager animated:YES completion:nil];
    }
    
}
//选择日历
- (void)popSeletedDateStyleClick:(NSDate *)date{
    if(self.dateStar==1){
        self.start_time=[date dateStringWithFormat:@"yyyy-MM-dd"];
        //self.sTime=date;
        self.sTime=date;
        NSDate *seletedDate=[self inBecomeTimeAddTimeZone:date];
        NSDate *today = [self inGainCurrentTimeAddTimeZone];//[NSDate dateWithTimeIntervalSinceNow: 0];
       
        CGFloat timeCha=[self inGainTimeDifferenceWithAtPresent:today toSeleted:seletedDate];
        
        if(timeCha/24<1){
            self.distanceCount=[NSString stringWithFormat:@"%.0f 小时",timeCha];
        }else{
            CGFloat downFloat=floorf(timeCha/24);
            CGFloat hourFloat=(timeCha/24-downFloat)*24;
            self.distanceCount=[NSString stringWithFormat:@"%.1f 天",timeCha/24];
            if(hourFloat>0){
               self.distanceCount=[NSString stringWithFormat:@"%.0f 天 %.0f 小时",downFloat,hourFloat];
            }
        }
    }
    if(self.dateStar==2){
        self.end_time=[date dateStringWithFormat:@"yyyy-MM-dd"];
        self.eTime=date;
        
    }
    if([self.typeStyle isEqualToString:@"discount"]){
        if([self.end_time kr_isNotEmpty]&&[self.end_time kr_isNotEmpty]){
            CGFloat timeLTCha=[self inGainTimeDifferenceWithAtPresent:self.sTime toSeleted:self.eTime];
            if(timeLTCha/24<1){
                self.validity=[NSString stringWithFormat:@"%.0f 小时",timeLTCha];
            }else{
                CGFloat downFloat=floorf(timeLTCha/24);
                CGFloat hourFloat=(timeLTCha/24-downFloat)*24;
                self.validity=[NSString stringWithFormat:@"%.1f 天",timeLTCha/24];
                if(hourFloat>0){
                    self.validity=[NSString stringWithFormat:@"%.0f 天 %.0f 小时",downFloat,hourFloat];
                }
            }
        }
    }
    @weakify(self);
    [UIView performWithoutAnimation:^{
        @strongify(self);
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:2]];
    }];
}

#pragma mark - PGDatePickerDelegate  选择时间  (时分HH:mm:ss)
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    XYLog(@"dateComponents = %@", dateComponents);
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDate * date = [calendar dateFromComponents:dateComponents];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"hh:mm:ss";
    NSString * str = [formatter stringFromDate:date];
    //NSString *joint=[NSString stringWithFormat:@"%@ %@",self.start_time,str];
    //NSDate*dateJoint=[self StringToDate:joint inPattern:@"yyyy-MM-dd HH:mm:ss"];
    //[self stringDateWithString:joint pattern:@"yyyy-mm-dd hh:mm:ss"];
    //NSLog(@"时间=%@",str);
    if(self.dateStar==1){
        self.start_Hour=[NSString stringWithFormat:@"%@ %@",self.start_time,str];
        NSString *joint=[NSString stringWithFormat:@"%@ %@",self.start_time,str];
        self.sTime=[self StringToDate:joint inPattern:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *today = [self inGainCurrentTimeAddTimeZone];
        CGFloat timeCha=[self inGainTimeDifferenceWithAtPresent:today toSeleted:self.sTime];
        if(timeCha/24<1){
            self.distanceCount=[NSString stringWithFormat:@"%.0f 小时",timeCha];
        }else{
            CGFloat downFloat=floorf(timeCha/24);
            CGFloat hourFloat=(timeCha/24-downFloat)*24;
            self.distanceCount=[NSString stringWithFormat:@"%.1f 天",timeCha/24];
            if(hourFloat>0){
                self.distanceCount=[NSString stringWithFormat:@"%.0f 天 %.0f 小时",downFloat,hourFloat];
            }
        }
    }
    if(self.dateStar==2){
        self.end_Hour=[NSString stringWithFormat:@"%@ %@",self.end_time,str];
        NSString *joint=[NSString stringWithFormat:@"%@ %@",self.end_time,str];
        self.eTime=[self StringToDate:joint inPattern:@"yyyy-MM-dd HH:mm:ss"];
        
        CGFloat timeYouX=[self inGainTimeDifferenceWithAtPresent:self.sTime toSeleted:self.eTime];
        if(timeYouX/24<1){
            self.validity=[NSString stringWithFormat:@"%.0f 小时",timeYouX];
        }else{
            CGFloat downFloat=floorf(timeYouX/24);
            CGFloat hourFloat=(timeYouX/24-downFloat)*24;
            self.validity=[NSString stringWithFormat:@"%.1f 天",timeYouX/24];
            if(hourFloat>0){
                self.validity=[NSString stringWithFormat:@"%.0f 天 %.0f 小时",downFloat,hourFloat];
            }
        }
        XYLog(@"有效期开始时间=%@  有效期结束时间=%@",self.sTime,self.eTime);
        XYLog(@"有效期=%.2f",timeYouX/24);
    }
    @weakify(self);
    [UIView performWithoutAnimation:^{
        @strongify(self);
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:2]];
    }];
    [self upCellBtnBGimg];
}
-(NSDate *)stringDateWithString:(NSString *)strDate pattern:(NSString *)pattern{
    NSDateFormatter *poformatter = [[NSDateFormatter alloc]init];
    //formatter.dateFormat = pattern;
    [poformatter setDateFormat:pattern];
    //[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    return  [poformatter dateFromString:strDate];
}
-(NSDate*)StringToDate:(NSString*)curdate inPattern:(NSString*)pattern{
    
     NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    
     NSString *inputDate = curdate;//[NSString stringWithFormat:@"%@ %@",curdate,curtime];
    
     [inputFormatter setDateFormat:pattern];  //@"yyyy-MM-dd HH:mm:ss"   //注意格式符的大小写。HH为24小时的小时数据格式
    
     NSDate *date = [inputFormatter dateFromString:inputDate];
    
     //  默认的 NSDate Date的显示的是格林威治标准时间GMT，在中国存在时差，所以要转换为中国时区+8。
    
     NSTimeInterval timeZoneOffset = [[NSTimeZone systemTimeZone] secondsFromGMT];
    
     date = [date dateByAddingTimeInterval: timeZoneOffset];
    
     return date;
    
}
//刷新保存背景图片状态
-(void)upCellBtnBGimg{
    NSIndexPath *indexReload = [NSIndexPath indexPathForRow:0 inSection:2];
    FNmerIssueDateSCell *itemCell=(FNmerIssueDateSCell *)[self.jm_collectionview cellForItemAtIndexPath:indexReload];
    
    if([self.name kr_isNotEmpty]&&[self.price kr_isNotEmpty]&&[self.counts kr_isNotEmpty]&&[self.is_luck kr_isNotEmpty]&&[self.reduct_condition kr_isNotEmpty]&&[self.discount_use kr_isNotEmpty]&&[self.coupon_use kr_isNotEmpty]&&[self.start_Hour kr_isNotEmpty]&&[self.end_Hour kr_isNotEmpty]){
        if([self.typeStyle isEqualToString:@"pub_red_packet_list"]||[self.typeStyle isEqualToString:@"red_packet"]){
            [itemCell.issueBtn setBackgroundImage:IMAGE(@"FN_CXhbBCimg") forState:UIControlStateNormal];
        }else if([self.typeStyle isEqualToString:@"pub_yhq_list"]||[self.typeStyle isEqualToString:@"yhq"]){
            [itemCell.issueBtn setBackgroundImage:IMAGE(@"FN_CXyhBCimg") forState:UIControlStateNormal];
        }
        if([self.typeStyle isEqualToString:@"discount"]){
            [itemCell.issueBtn setBackgroundImage:IMAGE(@"FN_zhekouBCimg") forState:UIControlStateNormal];
        }
    }else{
        if([self.typeStyle isEqualToString:@"pub_red_packet_list"]||[self.typeStyle isEqualToString:@"red_packet"]){
            [itemCell.issueBtn setBackgroundImage:IMAGE(@"FN_yhqANhbNobg") forState:UIControlStateNormal];
        }else if([self.typeStyle isEqualToString:@"pub_yhq_list"]||[self.typeStyle isEqualToString:@"yhq"]){
            [itemCell.issueBtn setBackgroundImage:IMAGE(@"FN_yhqANhbNobg") forState:UIControlStateNormal];
        }
        if([self.typeStyle isEqualToString:@"discount"]){
            [itemCell.issueBtn setBackgroundImage:IMAGE(@"FN_zhekounoBCimg") forState:UIControlStateNormal];
        }
    }
}
#pragma mark - 创建限时折扣使用 选择买单方式 线上 线下
// 线上
- (void)didMerIssueEditPaymentMethod:(NSIndexPath*)index withOnLine:(NSString*)onLineStyle{
    self.on_line=onLineStyle;
}
// 线下
- (void)didMerIssueEditPaymentMethod:(NSIndexPath*)index withOnShop:(NSString*)onShopStyle{
    self.on_shop=onShopStyle;
}
#pragma mark - 页面数据
//优惠券||红包
-(void)addDataArrMsg{
//      title;左边标题
//      value;值
//      valueHint;右边提示
//      unit;单位
//      bottomHint;底部提示
//      startDate;开始时间
//      endDate;结束时间
//      value1Orange;
//      value2Orange;
//      rowheight;高度
//      isCompile;//是否可以编辑 YES不可以编辑
//      editType;//编辑键盘类型 
    //      isStyle;右边样式 1:只编辑 2:只显示文字 3:编辑+单位  4:不能编辑显示选择文字 5:不能编辑 只选择开关 6:线上线下按钮
    //isBoth ;//1:修改单个颜色  2:修改两个颜色;
    //self.typeStyle
    self.is_luck=@"0";
    FNmerIssueocModel *item1Model=[[FNmerIssueocModel alloc]init];
    item1Model.title=@"*红包名称";
    item1Model.valueHint=@"红包名称";
    item1Model.bottomHint=@"";
    item1Model.type=self.typeStyle;
    item1Model.rowheight=57;
    item1Model.editType=@"defu";
    item1Model.isStyle=1;
    
    FNmerIssueocModel *itemHintModel=[[FNmerIssueocModel alloc]init];
    itemHintModel.title=@"*支持买单方式";
    itemHintModel.value=@"仅限线上支付";
    itemHintModel.bottomHint=@"";
    itemHintModel.type=self.typeStyle;
    itemHintModel.rowheight=57;
    itemHintModel.isCompile=YES;
    itemHintModel.isStyle=2;
    
    FNmerIssueocModel *item2Model=[[FNmerIssueocModel alloc]init];
    item2Model.title=@"*面值总金额";
    item2Model.valueHint=@"请输入红包面额";
    item2Model.unit=@"元";
    item2Model.type=self.typeStyle;
    item2Model.isCommon=@"0";
    item2Model.editType=@"float";
    item2Model.isStyle=3;
    
    FNmerIssueocModel *item3Model=[[FNmerIssueocModel alloc]init];
    item3Model.title=@"*总发行量";
    item3Model.valueHint=@"2019";
    item3Model.unit=@"个";
    item3Model.type=self.typeStyle;
    item3Model.rowheight=57;
    item3Model.editType=@"int";
    item3Model.isStyle=3;
    
    FNmerIssueocModel *item4Model=[[FNmerIssueocModel alloc]init];
    item4Model.title=@"*满减门槛";
    item4Model.valueHint=@"20";
    item4Model.unit=@"元";
    item4Model.bottomHint=@"商品满 0 元即可减少 0 元";
    item4Model.value1Orange=@"0";
    item4Model.value2Orange=@"0";
    item4Model.type=self.typeStyle;
    item4Model.rowheight=70;
    item4Model.editType=@"float";
    item4Model.isStyle=3;
    item4Model.isBoth=2;
    
    FNmerIssueocModel *item5Model=[[FNmerIssueocModel alloc]init];
    item5Model.title=@"*适用范围";
    item5Model.bottomHint=@"";
    item5Model.valueHint=@"请选择适用商品";
    item5Model.type=self.typeStyle;
    item5Model.rowheight=57;
    item5Model.isStyle=4;
    
    FNmerIssueocModel *itemOverlayModel=[[FNmerIssueocModel alloc]init];
    itemOverlayModel.value=@"";
    itemOverlayModel.bottomHint=@"";
    itemOverlayModel.type=self.typeStyle;
    itemOverlayModel.rowheight=57;
    itemOverlayModel.isCompile=YES;
    itemOverlayModel.isStyle=5;
    itemOverlayModel.switchState=0;
    
    if([self.typeStyle isEqualToString:@"red_packet"] || [self.typeStyle isEqualToString:@"pub_red_packet_list"]){
        item2Model.rowheight=70;
        item2Model.bottomHint=@"*当前为普通红包，改为拼手气红包";
        item2Model.value1Orange=@"改为拼手气红包";
        item2Model.isBoth=1;
        itemOverlayModel.title=@"*可与优惠券叠加使用";
    }
    if([self.typeStyle isEqualToString:@"pub_yhq_list"]||[self.typeStyle isEqualToString:@"yhq"]){
        item2Model.rowheight=57;
        itemOverlayModel.title=@"*可与红包叠加使用";
    }
    
    NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
    [arrM addObject:item1Model];
    [arrM addObject:itemHintModel];
    [arrM addObject:item2Model];
    [arrM addObject:item3Model];
    [arrM addObject:item4Model];
    [arrM addObject:item5Model];
    [arrM addObject:itemOverlayModel];
    self.dataArr=arrM;
}
//折扣商品
-(void)addDiscountModel{
    //      isStyle;右边样式 1:只编辑 2:只显示文字 3:编辑+单位  4:不能编辑显示选择文字 5:不能编辑 只选择开关 6:线上线下按钮
    FNmerIssueocModel *item1Model=[[FNmerIssueocModel alloc]init];
    item1Model.title=@"*支持买单方式";
    item1Model.type=self.typeStyle;
    item1Model.rowheight=57;
    item1Model.editType=@"defu";
    item1Model.isStyle=6;
    item1Model.online=@"线上";
    item1Model.offline=@"线下";
    
    FNmerIssueocModel *item2Model=[[FNmerIssueocModel alloc]init];
    item2Model.title=@"*优惠折扣";
    item2Model.type=self.typeStyle;
    item2Model.rowheight=57;
    item2Model.unit=@"折";
    item2Model.valueHint=@"0";
    item2Model.editType=@"float";
    item2Model.isStyle=3;
    
    FNmerIssueocModel *item3Model=[[FNmerIssueocModel alloc]init];
    item3Model.title=@"*活动时间";
    item3Model.type=self.typeStyle;
    item3Model.rowheight=57;
    item3Model.editType=@"defu";
    item3Model.valueHint=@"请选择活动时间";
    item3Model.isStyle=4;
    
    FNmerIssueocModel *item4Model=[[FNmerIssueocModel alloc]init];
    item4Model.title=@"*适用范围";
    item4Model.type=self.typeStyle;
    item4Model.rowheight=57;
    item4Model.editType=@"defu";
    item4Model.valueHint=@"仅限指定商品使用";
    item4Model.isStyle=4;
    
    if([self.idAlter kr_isNotEmpty]){
        item1Model.onlineState=self.discountModel.on_line;
        item1Model.offlineState=self.discountModel.on_shop;
        item2Model.value=self.discountModel.discount;
        item3Model.value=[NSString stringWithFormat:@"%@-%@",self.discountModel.start_hours,self.discountModel.end_hours];
        self.start_time=self.discountModel.start_time;
        self.end_time=self.discountModel.end_time;
        NSDate *startTi=[self StringToDate:self.discountModel.start_time inPattern:@"yyyy-MM-dd"];
        NSDate *endTi=[self StringToDate:self.discountModel.end_time inPattern:@"yyyy-MM-dd"];
        NSDate *today = [self inGainCurrentTimeAddTimeZone];//[NSDate dateWithTimeIntervalSinceNow: 0];
        
        CGFloat timeCha=[self inGainTimeDifferenceWithAtPresent:today toSeleted:startTi];
        
        if(timeCha/24<1){
            self.distanceCount=[NSString stringWithFormat:@"%.0f 小时",timeCha];
        }else{
            CGFloat downFloat=floorf(timeCha/24);
            CGFloat hourFloat=(timeCha/24-downFloat)*24;
            self.distanceCount=[NSString stringWithFormat:@"%.1f 天",timeCha/24];
            if(hourFloat>0){
                self.distanceCount=[NSString stringWithFormat:@"%.0f 天 %.0f 小时",downFloat,hourFloat];
            }
        }
        if(timeCha/24<0){
            self.distanceCount=@"0天";
        }
        CGFloat timeYouX=[self inGainTimeDifferenceWithAtPresent:startTi toSeleted:endTi];
        if(timeYouX/24<1){
            self.validity=[NSString stringWithFormat:@"%.0f 小时",timeYouX*24];
        }else{
            CGFloat downFloat=floorf(timeYouX/24);
            CGFloat hourFloat=(timeYouX/24-downFloat)*24;
            self.validity=[NSString stringWithFormat:@"%.0f 天",timeYouX/24];
            if(hourFloat>0){
                self.validity=[NSString stringWithFormat:@"%.0f 天 %.0f 小时",downFloat,hourFloat];
            }
        }
    }
    
    NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
    [arrM addObject:item1Model];
    [arrM addObject:item2Model];
    [arrM addObject:item3Model];
    [arrM addObject:item4Model];
    self.dataArr=arrM;
    
}
#pragma mark - request
//商家中心-发布红包or优惠券
-(void)requestAdd_red_packet{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    //params[@"type"]=self.type;
    if([self.typeStyle isEqualToString:@"pub_red_packet_list"]||[self.typeStyle isEqualToString:@"red_packet"]){
        params[@"type"]=@"hongbao";
    }else if([self.typeStyle isEqualToString:@"pub_yhq_list"]||[self.typeStyle isEqualToString:@"yhq"]){
        params[@"type"]=@"yhq";
    }
    params[@"name"]=self.name;
    params[@"price"]=self.price;
    params[@"counts"]=self.counts;
    params[@"is_luck"]=self.is_luck;
    
    
    params[@"reduct_condition"]=self.reduct_condition;
    if([self.discount_use kr_isNotEmpty]){
       params[@"discount_use"]=self.discount_use;
    }
    if([self.coupon_use kr_isNotEmpty]){
        params[@"coupon_use"]=self.coupon_use;
    }
    params[@"allow_cates"]=self.allow_cates;
    params[@"allow_goods"]=self.allow_goods;
    if([self.on_line kr_isNotEmpty]){
        params[@"on_line"]=self.on_line;
    }
    if([self.on_shop kr_isNotEmpty]){
        params[@"on_shop"]=self.on_shop;
    }
    params[@"start_time"]=self.start_Hour;
    params[@"end_time"]=self.end_Hour;
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=add_red_packet" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSInteger state=[respondsObject[SuccessKey] integerValue];
        NSString *msgStr=respondsObject[MsgKey];
        [FNTipsView showTips:msgStr];
        if(state==1){
            if (self.inMerIssuePagData) {
                self.inMerIssuePagData();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}

// 促销工具-添加or修改折扣
-(void)requestAddDiscount{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    //params[@"type"]=self.type;
    if([self.typeStyle isEqualToString:@"pub_red_packet_list"]||[self.typeStyle isEqualToString:@"red_packet"]){
        params[@"type"]=@"hongbao";
    }else if([self.typeStyle isEqualToString:@"pub_yhq_list"]||[self.typeStyle isEqualToString:@"yhq"]){
        params[@"type"]=@"yhq";
    }
    
    
    if([self.idAlter kr_isNotEmpty]){
        params[@"id"]=self.idAlter;
    }
    if([self.discount kr_isNotEmpty]){
        params[@"discount"]=self.discount;
    }
    if([self.start_hoursZK kr_isNotEmpty]){
        params[@"start_hours"]=self.start_hoursZK;
    }
    if([self.end_hoursZK kr_isNotEmpty]){
        params[@"end_hours"]=self.end_hoursZK;
    }
    
    if([self.start_time kr_isNotEmpty]){
        params[@"start_time"]=self.start_time;
    }
    if([self.end_time kr_isNotEmpty]){
        params[@"end_time"]=self.end_time;
    }
    if([self.allow_cates kr_isNotEmpty]){
        params[@"allow_cates"]=self.allow_cates;
    }
    if([self.allow_goods kr_isNotEmpty]){
        params[@"allow_goods"]=self.allow_goods;
    }
    if([self.on_line kr_isNotEmpty]){
        params[@"on_line"]=self.on_line;
    }
    if([self.on_shop kr_isNotEmpty]){
        params[@"on_shop"]=self.on_shop;
    }
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_store_activity&ctrl=add_discount" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSInteger state=[respondsObject[SuccessKey] integerValue];
        NSString *msgStr=respondsObject[MsgKey];
        [FNTipsView showTips:msgStr];
        if(state==1){
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}
//商家中心-红包使用门槛接口  ******不再使用******
-(FNRequestTool*)requestConditionList{
    [SVProgressHUD show];
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.typeStyle isEqualToString:@"pub_red_packet_list"]||[self.typeStyle isEqualToString:@"red_packet"]){
        params[@"type"]=@"hongbao";
    }else if([self.typeStyle isEqualToString:@"pub_yhq_list"]||[self.typeStyle isEqualToString:@"yhq"]){
        params[@"type"]=@"yhq";
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=using_threshold" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        NSArray *arrM = respondsObject[DataKey];
        @strongify(self);
        if(arrM.count>0){
            NSMutableArray *typeArray=[NSMutableArray arrayWithCapacity:0];
            
            [arrM enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNmerIssueocModel *model=[FNmerIssueocModel mj_objectWithKeyValues:obj];
                [typeArray addObject:model];
            }];
            self.conditionArr=typeArray;
        }
    } failure:^(NSString *error) {
        
    } isHideTips:NO isCache:NO];
}
//促销工具-折扣详细
-(void)requestActivityDiscountMsg{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.idAlter kr_isNotEmpty]){
        params[@"id"]=self.idAlter;
    }
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_store_activity&ctrl=discount_detail" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary *dictry=respondsObject[DataKey];
        self.discountModel=[FNmoneyOffFullMinusModel mj_objectWithKeyValues:dictry];
        self.discount=self.discountModel.discount;
        self.start_hoursZK=self.discountModel.start_hours;
        self.end_hoursZK=self.discountModel.end_hours;
        self.start_time=self.discountModel.start_time;
        self.end_time=self.discountModel.end_time;
        self.allow_cates=self.discountModel.allow_cates;
        self.allow_goods=self.discountModel.allow_goods;
        self.on_line=self.discountModel.on_line;
        self.on_shop=self.discountModel.on_shop;
        [self addDiscountModel];
        [UIView performWithoutAnimation:^{
            [self.jm_collectionview reloadData];
        }];
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (NSMutableArray *)extraArr{
    if (!_extraArr) {
        _extraArr = [NSMutableArray array];
    }
    return _extraArr;
}
- (NSMutableArray *)conditionArr{
    if (!_conditionArr) {
        _conditionArr = [NSMutableArray array];
    }
    return _conditionArr;
}

//获取本时区时间
-(NSDate *)inGainCurrentTimeAddTimeZone{
    NSDate *nowDate = [NSDate date];
    // 设置系统时区为本地时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    // 计算本地时区与 GMT 时区的时间差
    NSInteger interval = [zone secondsFromGMT];
    // 在 GMT 时间基础上追加时间差值，得到本地时间
    nowDate = [nowDate dateByAddingTimeInterval:interval];
    NSLog(@"现在时间: nowDate=%@",nowDate);
    return nowDate;
    //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSString *nowDateString = [dateFormatter stringFromDate:nowDate]; 
}
//为选择的时间添加时区
-(NSDate*)inBecomeTimeAddTimeZone:(NSDate*)date{
    NSDate *nowDate = date;
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMT];
    nowDate = [nowDate dateByAddingTimeInterval:interval];
    return nowDate;
}
//计算时间差2 时间一  时间二
-(CGFloat)inGainTimeDifferenceWithAtPresent:(NSDate *)presentDate toSeleted:(NSDate*)seletedDate{
    NSTimeInterval timeInterval = [seletedDate timeIntervalSinceDate:presentDate];
    CGFloat badFloat=timeInterval/3600.00;
    return badFloat;
}

#pragma mark - FNStoreGoodsSelectManagerControllerDelegate


/**
 适用范围选择回调
 
 @param vc 当前viewcontroller
 @param cates 商品列表
 @param isAll 是否全场通用
 */
- (void)goodsSelectController: (FNStoreGoodsSelectManagerController*)vc cates: (NSArray<FNStoreManagerCateModel*> *)cates isAll: (BOOL)isAll {
    NSLog (@"count: %ld   isAll: %d", cates.count, isAll);
    
    NSMutableString *cateString = [[NSMutableString alloc] init];
    NSMutableString *goodsString = [[NSMutableString alloc] init];
    if (cates.count == 0) {
        _allow_cates = @"";
        _allow_goods = @"";
    } else {
        BOOL isFirst = YES;
        BOOL isFirstCate = YES;
        for (FNStoreManagerCateModel *cate in cates) {
            if (isFirstCate)
                [cateString appendString:cate.id];
            else
                [cateString appendString:[NSString stringWithFormat:@",%@", cate.id]];
            isFirstCate = NO;
            for (FNStoreManagerGoodsModel *goods in cate.goods) {
                if (isFirst)
                    [goodsString appendString:goods.id];
                else
                    [goodsString appendString:[NSString stringWithFormat:@",%@", goods.id]];
                isFirst = NO;
            }
        }
        
        _allow_cates = cateString;
        _allow_goods = goodsString;
        
        NSLog (@"_allow_cates %@", cateString);
        NSLog (@"_allow_cates %@", goodsString);
        NSInteger rowInt=3;
        NSString *goodsState=@"";
        if(isAll){
            goodsState=@"全场通用";
            if([self.typeStyle isEqualToString:@"discount"]){
                rowInt=3;
            }else{
                rowInt=5;
            }
        }else{
            goodsState=@"仅限指定商品使用";
            if([self.typeStyle isEqualToString:@"discount"]){
                rowInt=3;
            }else{
                rowInt=5;
            }
        }
        NSIndexPath *index = [NSIndexPath indexPathForRow:rowInt inSection:0];
        FNmerIssueEditOCell *itemCell=(FNmerIssueEditOCell *)[self.jm_collectionview cellForItemAtIndexPath:index];
        [itemCell.rightBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [itemCell.rightBtn setTitle:goodsState forState:UIControlStateNormal];
    }
}

@end
