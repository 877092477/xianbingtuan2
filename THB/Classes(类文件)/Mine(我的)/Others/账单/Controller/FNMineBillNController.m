//
//  FNMineBillNController.m
//  THB
//
//  Created by Jimmy on 2018/9/6.
//  Copyright © 2018年 方诺科技. All rights reserved.
//
//账单
#import "FNMineBillNController.h"

#import "FNbillShopNViewCell.h"
#import "FNincomeNViewCell.h"
#import "FNShopNHeaderView.h"
#import "FNincomeNHeaderView.h"
#import "FDSlideBar.h"
#import "YBPopupMenu.h"

#import "JMMineBillModel.h"

@interface FNMineBillNController ()<UITableViewDataSource,UITableViewDelegate,FNShopNHeaderViewDelegate,FNincomeNHeaderViewDelegate,FNbillShopNViewCellDelegate,YBPopupMenuDelegate>

//头部
@property (nonatomic, strong)FDSlideBar* slideBar;
//右边按钮
@property (nonatomic, strong)UIButton *allBtn;
//收支账单的列表上方金额数组
@property (nonatomic, strong)NSMutableArray* headIncomeArr;
//头部分类
@property (nonatomic, strong)NSMutableArray* headArr;
@property (nonatomic, strong)NSMutableArray* headTitleArr;
@property (nonatomic, strong)NSMutableArray* rightTitleArr;
//信息
@property (nonatomic, strong)NSMutableArray* datalist;
//类型
@property (nonatomic, strong)NSString*  billType;
@property (nonatomic, assign)NSUInteger  billTypeInt;
//type
@property (nonatomic, strong)NSString*  Type;
//提示
@property (nonatomic, strong)UIView *nodataView;
@end

@implementation FNMineBillNController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.title=@"账单";
    self.billType=@"";
    self.Type=@"";
    [self apiRequestHeaderType];
    [self apiRequestSecondLevelType];
    _billTypeInt=0;
    [self navigationView];
    [self initbillSubviews];
   
}
-(void)navigationView{
    _slideBar = [[FDSlideBar alloc] initWithFrame:CGRectMake(0, 0, FNDeviceWidth-180, 40)];
    _slideBar.backgroundColor = FNWhiteColor;
    _slideBar.is_middle=NO;
    NSArray *nameArr=@[@"购物账单",@"收支账单"];
    _slideBar.itemsTitle =  nameArr;
    _slideBar.itemColor = FNColor(132,132,132);
    _slideBar.itemSelectedColor = FNColor(255,21,101);
    _slideBar.sliderColor = [UIColor whiteColor];
    _slideBar.fontSize=12;
    _slideBar.SelectedfontSize=14;
    @WeakObj(self);
    [_slideBar slideBarItemSelectedCallback:^(NSUInteger index) {
        XYLog(@"类型:%lu",(unsigned long)index);
        [selfWeak.allBtn setTitle:@"  全部" forState:UIControlStateNormal];
        selfWeak.billTypeInt=index;
        if(index==0){
            
            [selfWeak.jm_tableview reloadData];
        }else if(index==1){
            [selfWeak  apiRequestIncomeList];
        }
        
        if(selfWeak.headArr.count>0){
            FNheaderTypeModel *model=selfWeak.headArr[index];
            selfWeak.billType=model.type;
        } 
        if(selfWeak.headTitleArr.count>0){
            FNheaderTypeModel *Twomodel=selfWeak.headTitleArr[0];
            selfWeak.Type=Twomodel.type;
        }
       
        [selfWeak apiRequestBillList];
        
    }];
    [_slideBar selectSlideBarItemAtIndex:0];
    self.navigationItem.titleView=_slideBar;
    self.allBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.allBtn setTitleColor:FNGlobalTextGrayColor forState:UIControlStateNormal];
    [self.allBtn setTitle:@"  全  部" forState:UIControlStateNormal];
    self.allBtn.titleLabel.font = kFONT14;
    [self.allBtn sizeToFit];
    [self.allBtn addTarget:self action:@selector(allBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.allBtn];
    
   
    
}
-(void)allBtnAction:(UIButton *)sender{
    
    [YBPopupMenu showRelyOnView:sender titles:self.rightTitleArr icons:self.rightTitleArr menuWidth:100 delegate:self];
}
#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index
{
    //推荐
    NSLog(@"点击了 %@ 选项",ybPopupMenu.titles[index]);
    [self.allBtn setTitle:ybPopupMenu.titles[index] forState:UIControlStateNormal];
    NSString *string=[NSString stringWithFormat:@"%ld",index+100];
    NSDictionary *dic=@{@"selted":string};
    if(self.billTypeInt==0){
       [self ClickToClassify:index+100];
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center postNotificationName:@"biliAll" object:@"all" userInfo:dic];
    }else if(self.billTypeInt==1){
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center postNotificationName:@"incomeAll" object:@"income" userInfo:dic];
        [self ClickToIncomeClassify:index+100];
    }
   
}

#pragma mark - initializedSubviews
- (void)initbillSubviews
{
    self.jm_tableview = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight-SafeAreaTopHeight)) style:(UITableViewStylePlain)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.backgroundColor = FNWhiteColor;
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.jm_tableview];
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.estimatedRowHeight = 0;
        self.jm_tableview.estimatedSectionFooterHeight = 0;
        self.jm_tableview.estimatedSectionHeaderHeight= 0;
        self.jm_tableview.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }
    @WeakObj(self);
    self.jm_tableview.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.jm_page = 1;
        [selfWeak apiRequestBillList];
    }];
    self.jm_tableview.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        selfWeak.jm_page += 1;
        [self apiRequestBillList]; 
    }];
    
    [self.jm_tableview registerClass:[FNShopNHeaderView class]  forHeaderFooterViewReuseIdentifier:@"ShopNView"];
    [self.jm_tableview registerClass:[FNincomeNHeaderView class]  forHeaderFooterViewReuseIdentifier:@"incomeNView"];
    
    self.nodataView=[UIView new];
    self.nodataView.hidden=YES;
    self.nodataView.frame=CGRectMake(FNDeviceWidth/2-50, FNDeviceHeight/2-50, 100, 100);
    [self.jm_tableview addSubview:self.nodataView];
    UIImageView *dataimage=[UIImageView new];
    dataimage.frame=CGRectMake(4, 0, 92, 60);
    dataimage.image=IMAGE(@"order_nodata");
    [self.nodataView addSubview:dataimage];
    UILabel *datalable=[UILabel new];
    datalable.frame=CGRectMake(0, 70, 100, 20);
    datalable.textColor=[UIColor grayColor];
    datalable.textAlignment=NSTextAlignmentCenter;
    datalable.text=@"暂无数据";
    datalable.font=[UIFont fontWithDevice:12];
    [self.nodataView addSubview:datalable];
    
}
#pragma mark - Tabel view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==1){
        return self.datalist.count;
    }else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==1){
        if(self.billTypeInt==0){
            FNbillShopNViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BillNcellID"];
            if (cell == nil) {
                cell = [[FNbillShopNViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BillNcellID"];
            }
            cell.model = self.datalist[indexPath.row];
            cell.delegate = self;
            cell.IndexPath = indexPath;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            FNincomeNViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"incomeNcellID"];
            if (cell == nil) {
                cell = [[FNincomeNViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"incomeNcellID"];
            }
            cell.model = self.datalist[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else{
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"kongcellID"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kongcellID"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section==0){
        if(self.billTypeInt==0){
            FNShopNHeaderView *heardView = [[FNShopNHeaderView alloc]initWithReuseIdentifier:@"ShopNView"];
            heardView.delegate = self;
            heardView.typeArr=self.headTitleArr;
            return heardView;
            
        }else{
            FNincomeNHeaderView *heardView = [[FNincomeNHeaderView alloc]initWithReuseIdentifier:@"incomeNView"];
            heardView.delegate = self;
            heardView.headerArr=self.headIncomeArr;
            heardView.typeArr=self.headTitleArr;
            return heardView;
        }
    
    }else{
         return [UIView new];
    }
    
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        if(self.billTypeInt==0){
            return 100;
        }else{
            return 70;
        }
    }else{
        return 0.01;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        if(self.billTypeInt==0){
            return 50;
            
        }else{
            return 140;
        }
    }else{
         return 0.01;
    }
    
}
-(void)ClickToClassify:(NSUInteger)sender{
    NSLog(@"sender:%lu",(unsigned long)sender);
    FNheaderTypeModel *model=self.headTitleArr[sender-100];
    self.Type=model.type;
    [self apiRequestBillList];
    [self.allBtn setTitle:model.name forState:UIControlStateNormal];
    
}
-(void)ClickToIncomeClassify:(NSUInteger)sender{
    NSLog(@"sendertwo:%lu",(unsigned long)sender);
    FNheaderTypeModel *model=self.headTitleArr[sender-100];
    self.Type=model.type;
    [self apiRequestBillList];
    [self.allBtn setTitle:model.name forState:UIControlStateNormal];
}
-(void)ClickTocopy:(NSIndexPath*)sender{
   FNBillDetailsModel*model= self.datalist[sender.row];
   [[UIPasteboard generalPasteboard] setString:model.oid];
}

#pragma mark - Request
//获取账单头部分类
- (FNRequestTool *)apiRequestHeaderType{
    @WeakObj(self);
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appHigh&ctrl=billTopCate" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"头部分类:%@",respondsObject);
        
        NSMutableArray *name=[[NSMutableArray alloc]init];
        NSMutableArray *type=[[NSMutableArray alloc]init];
        NSArray* array = respondsObject[DataKey];
        if (array.count>0) {
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [name addObject:[obj objectForKey:@"name"]];
            }];
        }
        NSLog(@"type:%@",type);
        NSMutableArray *typeArr=[[NSMutableArray alloc]init];
        for (NSDictionary *dictry in array) {
            [typeArr addObject:[FNheaderTypeModel  mj_objectWithKeyValues:dictry]];
        }
        selfWeak.slideBar.itemsTitle =  name;
        selfWeak.slideBar.itemColor = FNColor(132,132,132);
        selfWeak.slideBar.itemSelectedColor = FNColor(255,21,101);
        FNheaderTypeModel *model=typeArr[0];
        selfWeak.billType=model.type;
        selfWeak.headArr=typeArr;
        [SVProgressHUD dismiss];
       
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}

//获取账单二级分类来源
- (FNRequestTool *)apiRequestSecondLevelType{
    @WeakObj(self);
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appHigh&ctrl=billCate" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"二级分类:%@",respondsObject);
        NSArray* array = respondsObject[DataKey];
        NSMutableArray *typeArr=[[NSMutableArray alloc]init];
        NSMutableArray *nameArr=[[NSMutableArray alloc]init];
        for (NSDictionary *dictry in array) {
            [nameArr addObject:dictry[@"name"]];
            [typeArr addObject:[FNheaderTypeModel  mj_objectWithKeyValues:dictry]];
        }
        FNheaderTypeModel *model=typeArr[0];
        selfWeak.headTitleArr=typeArr;
        selfWeak.Type=model.type;
        selfWeak.rightTitleArr=nameArr;
        [SVProgressHUD dismiss];
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [selfWeak.jm_tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        [selfWeak apiRequestBillList];
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}

//获取账单明细列表
- (FNRequestTool *)apiRequestBillList{
    [self.jm_tableview.mj_header endRefreshing];
    [self.jm_tableview.mj_footer endRefreshing];
    [SVProgressHUD show];
    @WeakObj(self);
    NSString *token = UserAccessToken;
    XYLog(@"类型1:%@",selfWeak.billType);
    XYLog(@"类型2:%@",selfWeak.Type);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token,@"billType":selfWeak.billType,@"type":selfWeak.Type,@"p":@(self.jm_page)}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appHigh&ctrl=billList" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"账单明细:%@",respondsObject);
        NSArray *commitsList =  respondsObject [DataKey];
        NSMutableArray *arrM = [NSMutableArray array];
        //FNBillDetailsModel
        for (NSDictionary *dictDict in commitsList) {
            [arrM addObject:[FNBillDetailsModel mj_objectWithKeyValues:dictDict]];
        }
        if (arrM.count == 0) {
            [selfWeak.jm_tableview.mj_footer endRefreshingWithNoMoreData];
            self.nodataView.hidden=NO;
        }else{
            self.nodataView.hidden=YES;
        }
        
        
        if (self.jm_page == 1) {
            if (arrM.count == 0) {
                [selfWeak.datalist removeAllObjects];
                [FNTipsView showTips:@"没有数据"];
            }
            [selfWeak.datalist removeAllObjects];
            selfWeak.datalist = arrM;

        } else {
            [selfWeak.datalist addObjectsFromArray:arrM];
        }
        [UIView animateWithDuration:0.2 animations:^{
            [SVProgressHUD dismiss];
        }];
        
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
            [selfWeak.jm_tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
//收支账单的列表上方金额数组
- (FNRequestTool *)apiRequestIncomeList{
    [SVProgressHUD show];
    @WeakObj(self);
    NSString *token = UserAccessToken;
    XYLog(@"类型1:%@",selfWeak.billType);
    XYLog(@"类型2:%@",selfWeak.Type);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appHigh&ctrl=receiptBillList" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"账单明细:%@",respondsObject);
        NSArray *commitsList =  respondsObject [DataKey];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dictDict in commitsList) {
            [arrM addObject:[FNheaderIncomeModel mj_objectWithKeyValues:dictDict]];
        }
        selfWeak.headIncomeArr=arrM;
        //NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        //[selfWeak.jm_tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        [UIView animateWithDuration:0.2 animations:^{
            [SVProgressHUD dismiss];
            [selfWeak.jm_tableview reloadData];
        }];
        
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
- (NSMutableArray *)datalist
{
    if (_datalist == nil) {
        _datalist = [NSMutableArray new];
    }
    return _datalist;
}
-(NSMutableArray *)headTitleArr{
    if (!_headTitleArr) {
        _headTitleArr= [NSMutableArray array];
    }
    return _headTitleArr;
}
-(NSMutableArray *)headArr{
    if (!_headArr) {
        _headArr = [NSMutableArray array];
    }
    return _headArr;
}
-(NSMutableArray *)headIncomeArr{
    if (!_headIncomeArr) {
        _headIncomeArr= [NSMutableArray array];
    }
    return _headIncomeArr;
}
-(NSMutableArray *)rightTitleArr{
    if (!_rightTitleArr) {
        _rightTitleArr= [NSMutableArray array];
    }
    return _rightTitleArr;
}

@end
