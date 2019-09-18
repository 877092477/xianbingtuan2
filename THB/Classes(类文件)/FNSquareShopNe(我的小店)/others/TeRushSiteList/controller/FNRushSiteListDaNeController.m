//
//  FNRushSiteListDaNeController.m
//  69橙子
//
//  Created by Jimmy on 2018/11/30.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//小店收货地址
#import "FNRushSiteListDaNeController.h"
//view
#import "FNSiteItemDaNeCell.h"
#import "FNrushNoGoodsNeCell.h"
//controller
#import "FNRushLocationNewDaController.h"
//model
#import "FNrushSiteDaNeModel.h"
@interface FNRushSiteListDaNeController ()<UITableViewDelegate,UITableViewDataSource,FNSiteItemDaNeCellDelegate,FNRushLocationNewDaControllerDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/**  地址列表   **/
@property(nonatomic,strong)NSMutableArray *dataArray;

/**  地址ID  **/
@property(nonatomic,strong)NSString *addressid;
@end

@implementation FNRushSiteListDaNeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"收货地址";
    [self apiRequestSiteList];
    [self navRightButton];
    [self siteMessageTableView];
}
-(void)navRightButton{
    UIButton *addButton= [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.titleLabel.font=kFONT12;
    [addButton sizeToFit];
    [addButton setTitle:@"添加新地址" forState:UIControlStateNormal];
    [addButton setTitleColor:RGB(1, 172, 243) forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
}
#pragma mark - 添加
-(void)addButtonAction{
    FNrushSiteDaNeModel *addressModel=[[FNrushSiteDaNeModel alloc]init];
    FNRushLocationNewDaController *vc=[[FNRushLocationNewDaController alloc]init];
    vc.addState=1;
    vc.addressModel=addressModel;
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -FNRushLocationNewDaControllerDelegate // 刷新
-(void)inLocationBackChoicegender{
    [self apiRequestSiteList];
}
#pragma mark - 单元
-(void)siteMessageTableView{
    CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight-1;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.jm_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, tableHeight) style:UITableViewStylePlain];
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.hidden=YES;
    self.jm_tableview.rowHeight=100;
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.estimatedRowHeight = 0;
        self.jm_tableview.estimatedSectionFooterHeight = 0;
        self.jm_tableview.estimatedSectionHeaderHeight= 0;
        self.jm_tableview.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }
    self.jm_tableview.emptyDataSetDelegate = self;
    self.jm_tableview.emptyDataSetSource = self;
    [self.view addSubview:self.jm_tableview];
    self.jm_tableview.backgroundColor=FNColor(240,240,240);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FNSiteItemDaNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SiteItemDaNeCellID"];
    if (cell == nil) {
        cell = [[FNSiteItemDaNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SiteItemDaNeCellID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.model=[FNUpAddressNeModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
    cell.delegate=self;
    cell.indexPath=indexPath;
    cell.model=self.dataArray[indexPath.row];
    UILongPressGestureRecognizer * longPressGesture =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(cellLongPress:)];
    
    longPressGesture.minimumPressDuration=1.5f;//设置长按 时间
    [cell addGestureRecognizer:longPressGesture];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(siteListSelectAddressAction:)]) {
        [self.delegate siteListSelectAddressAction:self.dataArray[indexPath.row]];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)cellLongPress:(UILongPressGestureRecognizer *)longRecognizer{
    
    
    if (longRecognizer.state==UIGestureRecognizerStateBegan) {
        
        [self becomeFirstResponder];
        CGPoint location = [longRecognizer locationInView:self.jm_tableview];
        NSIndexPath * indexPath = [self.jm_tableview indexPathForRowAtPoint:location];
        FNrushSiteDaNeModel *dataModel=[FNrushSiteDaNeModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
        self.addressid=dataModel.id;
        UIAlertView *WXinstall=[[UIAlertView alloc]initWithTitle:@"删除地址?" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [WXinstall show];
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([btnTitle isEqualToString:@"取消"]) {
        
    }else if ([btnTitle isEqualToString:@"确定"] ) {
                XYLog(@"你点击了确定");
        [self apiRequestSiteDelete];
    }
}
#pragma mark - FNSiteItemDaNeCellDelegate   编辑
- (void)SiteItemCopyreaderAction:(NSIndexPath *)indexPath{
    FNRushLocationNewDaController *vc=[[FNRushLocationNewDaController alloc]init];
    vc.addState=2;
    FNrushSiteDaNeModel *model=[FNrushSiteDaNeModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    vc.addressModel=model;
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
//收货地址列表
- (FNRequestTool *)apiRequestSiteList{
    [self.jm_tableview.mj_footer endRefreshing];
    [self.jm_tableview.mj_header endRefreshing];
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,@"p":@(self.jm_page)}];
    
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_address&ctrl=address_list" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"小点收货地址列表:%@",respondsObject);
        NSArray* arrM = respondsObject[DataKey];
        NSMutableArray *arrList=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dittry in arrM) {
            [arrList addObject:dittry];
        }
        if (selfWeak.jm_page == 1) {
            if (arrList.count == 0) {
                //[SVProgressHUD showInfoWithStatus:@"很抱歉，没有找到该类产品~"];
                //return ;
            }
            [selfWeak.dataArray removeAllObjects];
            [selfWeak.dataArray addObjectsFromArray:arrList];
            if (arrList.count >= _jm_pro_pagesize) {
                selfWeak.jm_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.jm_page ++;
                    [selfWeak apiRequestSiteList];
                }];
            }else{
                selfWeak.jm_tableview.mj_footer = nil;
            }
        } else {
            [selfWeak.dataArray addObjectsFromArray:arrList];
            if (arrList.count >= _jm_pro_pagesize) {
                [selfWeak.jm_tableview.mj_footer endRefreshing];
            }else{
                [selfWeak.jm_tableview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        selfWeak.jm_tableview.hidden=NO;
        [selfWeak.jm_tableview reloadData];
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache:NO];
}
//删除地址
- (FNRequestTool *)apiRequestSiteDelete{
    
    //@WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,@"id":self.addressid}];
    
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_address&ctrl=del_address" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"小点收货地址列表:%@",respondsObject);
        [self apiRequestSiteList];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
#pragma mark  实现成为第一响应者方法
-(BOOL)canBecomeFirstResponder{
    return YES;
}

#pragma mark - DZNEmptyDataSetSource
- (nullable NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSAttributedString *att = [[NSAttributedString alloc]initWithString:@"暂无数据" attributes:@{NSFontAttributeName:kFONT14,NSForegroundColorAttributeName:FNGlobalTextGrayColor}];
    return att;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"pcresults_empty"];
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{
    return YES;
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
@end
