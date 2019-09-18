//
//  FNUpSpecificationsNSView.m
//  THB
//
//  Created by Jimmy on 2018/9/27.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpSpecificationsNSView.h"

//view
#import "FNSpeciHeadNeCell.h"
#import "FNCollectionHeaderNeLayout.h"
#import "FNSpeciItemChoiceNeCell.h"
#import "FNSpeciItemHeadNeView.h"
#import "FNSpeciQuantityNeCell.h"
#import "FNSpquantityNeView.h"

FNUpSpecificationsNSView *_SpecificationsView = nil;

@interface FNUpSpecificationsNSView ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNCollectionHeaderNeLayoutDelegate,FNSpeciHeadNeCellDelegate,FNSpquantityNeViewDelegate>


{
    NSInteger QuantityNe;
}
@end

@implementation FNUpSpecificationsNSView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [FNBlackColor colorWithAlphaComponent:0.3];
        [self setupViews];
    }
    return self;
}
+ (instancetype)shareInstance{
    if (_SpecificationsView == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _SpecificationsView = [[FNUpSpecificationsNSView alloc]initWithFrame:FNKeyWindow.bounds];
        });
    }
    return _SpecificationsView;
}
#pragma mark - 出现 消失
- (void)showAnimation{
    _SpecificationsView.bgView.frame=CGRectMake(0, JMScreenHeight, JMScreenWidth, JMScreenHeight-200);
    [UIView animateWithDuration:0.5f animations:^{
        _SpecificationsView.bgView.frame=CGRectMake(0, 200, JMScreenWidth, JMScreenHeight-200);
    }];
}
- (void)DetailsViewDismiss{
    [UIView animateWithDuration:0.5f animations:^{
        _SpecificationsView.bgView.frame=CGRectMake(0, JMScreenHeight, JMScreenWidth, JMScreenHeight-200);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

+ (void)showWithModel:(id)model selectWithProperty:(id)Arr view:(UIView *)view backblock:(void (^)(id model,NSString* amountString))block{
    _SpecificationsView = [FNUpSpecificationsNSView shareInstance];
    [view addSubview:_SpecificationsView];
    _SpecificationsView.dataDic=model;
    _SpecificationsView.dataArr=Arr;
    //_SpecificationsView.selectSpecificationBlock=block;
    _SpecificationsView.selectSpecificationAndAmountBlock=block;
    [_SpecificationsView showAnimation];
}

-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr=dataArr;
    [_collectionView reloadData];
    
}
-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic=dataDic;
    [self.tableView reloadData];
}
#pragma mark -  Subviews
- (void)setupViews{
    QuantityNe=1;
    _bgView=[[UIView alloc]initWithFrame:CGRectMake(0, JMScreenHeight, JMScreenWidth, JMScreenHeight-200)];
    //_bgView.backgroundColor = FNWhiteColor;
    _bgView.backgroundColor= [UIColor clearColor];
    [self addSubview:_bgView];
    [self AddtableView];
    [self AddcollectionView];
    _confirmBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _confirmBtn.frame = CGRectMake(0, JMScreenHeight-200-50, JMScreenWidth, 50);
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:FNWhiteColor forState:UIControlStateNormal];
    //_confirmBtn.backgroundColor = FNColor(254,19,30);
    _confirmBtn.backgroundColor = RED;
    [_confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_bgView addSubview:_confirmBtn];
    
    
}
#pragma mark - 确定
-(void)confirmBtnClick{
    /*if (self.selectSpecificationBlock) {
        self.selectSpecificationBlock(self.dataArr);
    }*/
    NSString *QuantityString=[NSString stringWithFormat:@"%ld",(long)QuantityNe];
    if (self.selectSpecificationAndAmountBlock) {
        self.selectSpecificationAndAmountBlock(self.dataArr,QuantityString);
    }
    [_SpecificationsView DetailsViewDismiss];
}
-(void)AddtableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, JMScreenWidth, 110) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_bgView addSubview:self.tableView];
    _tableView.backgroundColor= [UIColor clearColor];
    _tableView.rowHeight=110;
}
#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    FNSpeciHeadNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SpeciHeadNeCell"];
    if (cell == nil) {
        cell = [[FNSpeciHeadNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SpeciHeadNeCell"];
    }
    cell.datadic=self.dataDic;
    cell.delegate=self;
    cell.seleArray=self.dataArr;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark - LazyLoad
- (void)AddcollectionView
{
    
    CGFloat DCMargin = 10;
    FNCollectionHeaderNeLayout *layout = [FNCollectionHeaderNeLayout new];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 110, JMScreenWidth, JMScreenHeight-200-160) collectionViewLayout:layout];
    _collectionView.backgroundColor = FNWhiteColor;
    //自定义layout初始化
    layout.delegate = self;
    layout.lineSpacing = 8.0;
    layout.interitemSpacing = DCMargin;
    layout.headerViewHeight = 35;
    layout.footerViewHeight = 5;
    layout.itemInset = UIEdgeInsetsMake(0, DCMargin, 0, DCMargin);
    _collectionView.showsVerticalScrollIndicator=NO;
    _collectionView.showsHorizontalScrollIndicator=NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.alwaysBounceVertical = YES;
        
    [_collectionView registerClass:[FNSpeciItemChoiceNeCell class] forCellWithReuseIdentifier:@"SpeciItemChoiceNeCell"];//cell
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];//cell
    [_collectionView registerClass:[FNSpeciItemHeadNeView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SpeciItemHeadNeView"]; //头部
     [_collectionView registerClass:[FNSpquantityNeView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SpquantityNe"]; //头部
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"]; //尾部
    
    [_bgView addSubview:self.collectionView];
        
    
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return _dataArr.count+1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section==_dataArr.count){
        return 1;
    }else{
        FNUpGoodsAttrNModel *model=_dataArr[section];
        return model.attr_val.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==_dataArr.count){
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
        return cell;
    }else{
        FNSpeciItemChoiceNeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SpeciItemChoiceNeCell" forIndexPath:indexPath];
        FNUpGoodsAttrNModel *model=_SpecificationsView.dataArr[indexPath.section];
        FNUpGoodsAttrItemNModel *ItemNModel=model.attr_val[indexPath.row];
        cell.content = ItemNModel;
        return cell;
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    if ([kind  isEqualToString:UICollectionElementKindSectionHeader]) {
        if(indexPath.section<_dataArr.count){
            FNSpeciItemHeadNeView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SpeciItemHeadNeView" forIndexPath:indexPath];
            
            headerView.headTitle = self.dataArr[indexPath.section];
            
            return headerView;
        }else{
            FNSpquantityNeView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SpquantityNe" forIndexPath:indexPath];
            headerView.delegate=self;
            headerView.indexPath=indexPath;
            headerView.Quantity=QuantityNe;
            return headerView;
        }
    }else {

        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter" forIndexPath:indexPath];
        return footerView;
    }
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section<_dataArr.count){
        FNUpGoodsAttrNModel *model=_dataArr[indexPath.section];
        FNUpGoodsAttrItemNModel *ItemNModel=model.attr_val[indexPath.row];
        //限制每组内的Item只能选中一个
        for (FNUpGoodsAttrItemNModel *ExModel in model.attr_val) {
            NSLog(@"ExModel:%@",ExModel.name);
            if(ExModel.id==ItemNModel.id){
                ExModel.isSelect = !ExModel.isSelect;
            }else{
                ExModel.isSelect = NO;
            }
        } 
        [_collectionView reloadData];
        [self.tableView reloadData];
    }
}
#pragma mark - FNCollectionHeaderNeLayoutDelegate
#pragma mark - 自定义layout必须实现的方法
- (NSString *)collectionViewItemSizeWithIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section<_dataArr.count){
        FNUpGoodsAttrNModel *model=_SpecificationsView.dataArr[indexPath.section];
        FNUpGoodsAttrItemNModel *ItemNModel=[FNUpGoodsAttrItemNModel mj_objectWithKeyValues:model.attr_val[indexPath.row]];
        NSString *titleString=ItemNModel.name;
        return titleString;
    }else{
        return @"";
    }
    
}
- (CGSize)collectionViewDynamicHeaderSizeWithIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section<_dataArr.count){
        return CGSizeMake(FNDeviceWidth, 35);
    }else{
        return CGSizeMake(FNDeviceWidth, 50);
    }
}
#pragma mark - FNSpeciHeadNeCellDelegate
- (void)SpeciHeadNedisappear{
    [self DetailsViewDismiss];
}
#pragma mark - FNSpquantityNeViewDelegate
- (void)SpeciMinusQuantity:(NSIndexPath *)indexPath{
    //QuantityNe
    QuantityNe-=1;
    [_collectionView reloadData];
} 
- (void)SpeciAddQuantity:(NSIndexPath *)indexPath{
    
    QuantityNe+=1;
    [_collectionView reloadData];
}

- (NSMutableArray *)seleArray {
    if (!_seleArray) {
        _seleArray = [NSMutableArray array];
    }
    return _seleArray;
}
@end
