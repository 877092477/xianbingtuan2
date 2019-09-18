//
//  FNNewOrderMendDeController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

//补贴订单
#import "FNNewOrderMendDeController.h"
#import "FNNewFreeAddOrderController.h"
#import "FNNewFreeShareWebController.h"
//view
//#import "FNitemMakeDeCell.h"
#import "FNOrderMendCell.h"
#import "YTTextViewAlertView.h"
//model
#import "FNNewFreeOrderModel.h"
@interface FNNewOrderMendDeController ()<UICollectionViewDelegate,UICollectionViewDataSource>
/** 数据数组 */
@property (nonatomic, strong) NSMutableArray<FNNewFreeOrderModel*> *dataArray;
@end

@implementation FNNewOrderMendDeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self orderMendCollectionview];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self apiRequestOrderMend: NO];
}

#pragma mark - 主视图
-(void)orderMendCollectionview{
    CGFloat tableHeight=XYScreenHeight-XYNavBarHeigth-35;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 10;
    flowlayout.minimumInteritemSpacing = 10;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, tableHeight) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.hidden=YES;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNOrderMendCell class] forCellWithReuseIdentifier:@"FNOrderMendCell"];
    
    self.jm_collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.jm_page = 1;
        [self apiRequestOrderMend: YES];
        [SVProgressHUD show];
        
    }];
    //self.jm_collectionview.sd_layout
    //.bottomSpaceToView(self.view, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(self.view, 0);
    self.view.backgroundColor=RGB(240, 240, 240);
    self.jm_collectionview.backgroundColor=RGB(240, 240, 240);
    
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FNOrderMendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNOrderMendCell" forIndexPath:indexPath];
    FNNewFreeOrderModel *model=self.dataArray[indexPath.row];
    [cell.imgHeader sd_setImageWithURL:URL(model.goods_img)];
    cell.lblTitle.text = model.goods_title;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:model.list_str];
    [str appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" ￥%@", model.fl_price] attributes:@{NSForegroundColorAttributeName: UIColor.redColor}]];
    [cell setCommission:str];
    
    NSDate *orderTime = [NSDate dateWithTimeIntervalSince1970:model.createDate.doubleValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
    NSString *time = [formatter stringFromDate:orderTime];
    cell.lblDesc.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"下单时间:%@", time] attributes:@{NSForegroundColorAttributeName: RGB(200, 200, 200)}];
    if ([model.type isEqualToString:@"assistance"]) {
        [cell setEndTime: [NSDate dateWithTimeIntervalSince1970:model.act_over_time.doubleValue]];
    } else if ([model.type isEqualToString:@"additional"]) {
        
    } else if ([model.type isEqualToString:@"restore"]) {
        
    } else if ([model.type isEqualToString:@"restore_success"]) {
        
    } else if ([model.type isEqualToString:@"fail"]) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:model.list_str];
        [cell setCommission:str];
    } else if ([model.type isEqualToString:@"fail_additional"]) {
        cell.lblDesc.attributedText = [[NSAttributedString alloc] initWithString:model.tip_str attributes:@{NSForegroundColorAttributeName: UIColor.redColor}];
    }
    [cell.btnMore setTitle:model.label forState:UIControlStateNormal];
    [cell.btnMore setTitleColor:[UIColor colorWithHexString:model.font_color] forState:UIControlStateNormal];
    cell.btnMore.backgroundColor = [UIColor colorWithHexString:model.color];
    
    return cell;
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
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=FNDeviceWidth;
    CGSize size = CGSizeMake(with, 140);
    return size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FNNewFreeOrderModel *model=self.dataArray[indexPath.row];
    if ([model.type isEqualToString:@"assistance"]) {

//        FNNewFreeShareWebController *vc = [[FNNewFreeShareWebController alloc] init];
//        vc.url = model.share_url;
//        [self.navigationController pushViewController:vc animated:YES];
        [self goWebWithUrl:model.share_url];
        
    } else if ([model.type isEqualToString:@"additional"]) {
        [self addOrderId:model.ID];
    } else if ([model.type isEqualToString:@"restore"]) {
        
    } else if ([model.type isEqualToString:@"restore_success"]) {
        
    } else if ([model.type isEqualToString:@"fail"]) {
        
    } else if ([model.type isEqualToString:@"fail_additional"]) {
        [self addOrderId:model.ID];
    }
}

- (void)addOrderId: (NSString*)orderId {
    FNNewFreeAddOrderController *vc = [[FNNewFreeAddOrderController alloc] init];
    vc.orderId = orderId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Request  我的订单
- (FNRequestTool *)apiRequestOrderMend: (BOOL) isCache{
    
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,PageNumber:@(self.jm_page)}];
    if(self.type){
        params[@"type"]=self.type;
    }
    @weakify(self)
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=bargainDoing&ctrl=order" respondType:(ResponseTypeArray) modelType:@"FNNewFreeOrderModel" success:^(id respondsObject) {
        @strongify(self)
        NSArray* array = respondsObject;
        
        [SVProgressHUD dismiss];
        self.jm_collectionview.hidden=NO;
        if (self.jm_page == 1) {
            [self.dataArray removeAllObjects];
        }
        self.jm_page ++;
        
        [self.dataArray addObjectsFromArray:array];
        self.jm_collectionview.mj_footer.hidden = array.count > 0;
        [self.jm_collectionview.mj_footer endRefreshing];
        [self.jm_collectionview.mj_header endRefreshing];
        
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {

    } isHideTips:YES isCache:isCache];
}


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
