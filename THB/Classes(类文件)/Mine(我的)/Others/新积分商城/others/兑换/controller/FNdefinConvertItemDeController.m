//
//  FNdefinConvertItemDeController.m
//  THB
//
//  Created by Jimmy on 2019/1/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdefinConvertItemDeController.h"
#import "FNIntegralMallDetailController.h"
//view
#import "FNdefineCommodityCell.h"
#import "FNdefinBannerDeCell.h"
@interface FNdefinConvertItemDeController ()<UICollectionViewDelegate,UICollectionViewDataSource,FNdefinBannerDeCellDelegate>
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) NSMutableArray *bannerArr;
@property(nonatomic,strong) NSString *is_integral;
@end

@implementation FNdefinConvertItemDeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.is_integral=@"0";
    [self convertCollectionview];
    [self apiRequstColumnBanner];
    [self apiRequestConvertProduct];
}
#pragma mark - 主视图
-(void)convertCollectionview{
    CGFloat distanceTop=0;
    if ([self.SkipUIIdentifier isEqualToString:@"pub_integral_changegoods"]) {
        distanceTop=33;
        [self optionsView];
    }
    CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight-distanceTop;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 10;
    flowlayout.minimumInteritemSpacing = 10;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, distanceTop, FNDeviceWidth, tableHeight) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.hidden=YES;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNdefineCommodityCell class] forCellWithReuseIdentifier:@"integral_commodity"];
    [self.jm_collectionview registerClass:[FNdefinBannerDeCell class] forCellWithReuseIdentifier:@"integral_banner_01"];
    self.jm_collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.jm_page=1;
        [self apiRequestConvertProduct];
    }];
    self.view.backgroundColor=RGB(240, 240, 240);
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        FNdefinBannerDeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"integral_banner_01" forIndexPath:indexPath];
        cell.delegate=self;
        cell.bannerArray=self.bannerArr;
        return cell;
    }else{
        FNdefineCommodityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"integral_commodity" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=[FNDefiniteProductModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
        return cell;
    }
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
    CGFloat high=130;
    if (indexPath.section==0) {
        if(self.bannerArr.count>0){
            FNDefiniteListItemModel *itemModel=[FNDefiniteListItemModel mj_objectWithKeyValues:self.bannerArr[0]];
            NSString *bannerBili=itemModel.banner_bili;
            CGFloat bannerOneHight;
            if([bannerBili kr_isNotEmpty]){
                bannerOneHight=[bannerBili floatValue] *FNDeviceWidth;
            }else{
                bannerOneHight=165;
            }
            high=bannerOneHight;
        }else{
            high=0;
        }
    }else{
       high=130;
    }
    CGSize size = CGSizeMake(with, high);
    return size;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        FNDefiniteProductModel *itemModel=[FNDefiniteProductModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
        FNIntegralMallDetailController *vc = [FNIntegralMallDetailController new];
        vc.goodsId =itemModel.id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - //FNdefinBannerDeCellDelegate // 点击轮播
- (void)oddWelfBannerClick:(FNDefiniteListItemModel*)model{
    [self loadOtherVCWithModel:model andInfo:nil outBlock:nil];
}
-(void)optionsView{
    UIView *topwhitedView=[[UIView alloc]init];
    topwhitedView.backgroundColor=[UIColor whiteColor];
    topwhitedView.frame=CGRectMake(0, 0, FNDeviceWidth, 32);
    [self.view addSubview:topwhitedView];
    UIButton * optionBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat optionBtnW=[self getWidthWithText:@"只看纯积分兑换" height:20 font:12];
    optionBtn.titleLabel.font = kFONT12; 
    [optionBtn setImage:IMAGE(@"FJ_integral_norImg") forState:UIControlStateNormal];
    [optionBtn setImage:IMAGE(@"FJ_integral_SEImg") forState:UIControlStateSelected];
    [optionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [optionBtn setTitle:@"只看纯积分兑换" forState:UIControlStateNormal];
    [optionBtn addTarget:self action:@selector(optionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [topwhitedView addSubview:optionBtn];
    optionBtn.sd_layout
    .heightIs(20).leftSpaceToView(topwhitedView, 10).centerYEqualToView(topwhitedView).widthIs(optionBtnW+28);
    [optionBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:6.0f];
    
    UIView *lineView= [[UIView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 1))];
    lineView.backgroundColor = RGB(240, 239, 239);
    [topwhitedView addSubview:lineView];
}
-(void)optionBtnAction:(UIButton*)btn{
    btn.selected=!btn.selected;
    if(btn.selected==YES){
       self.is_integral=@"1";
    }else{
       self.is_integral=@"0";
    }
    [self apiRequestConvertProduct];
}
#pragma mark - //获取产品
- (FNRequestTool *)apiRequestConvertProduct{
    [SVProgressHUD show];
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{ @"token":UserAccessToken,PageNumber:@(self.jm_page),PageSize:@(_jm_pro_pagesize),@"is_index":@"0",@"is_integral":self.is_integral}];
    if([self.cid kr_isNotEmpty]){
        params[@"cid"]=self.cid;
    }
    if([self.SkipUIIdentifier kr_isNotEmpty]){
        params[@"SkipUIIdentifier"]=self.SkipUIIdentifier;
    }
    //is_integral
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=convert_goods&ctrl=goods" respondType:(ResponseTypeDataKey) modelType:@"" success:^(NSArray* respondsObject) {
        NSArray* array = respondsObject;
        [SVProgressHUD dismiss];
        [selfWeak.jm_collectionview.mj_footer endRefreshing];
        [selfWeak.jm_collectionview.mj_header endRefreshing];
        
        if (selfWeak.jm_page == 1) {
            if (array.count == 0) {
                [FNTipsView showTips:@"很抱歉，没有找到该类产品~"];
                return ;
            }
            [selfWeak.dataArray removeAllObjects];
            [selfWeak.dataArray addObjectsFromArray:respondsObject];
            if (array.count >= _jm_pro_pagesize) {
                selfWeak.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.jm_page ++;
                    [selfWeak apiRequestConvertProduct];
                }];
            }else{
                selfWeak.jm_collectionview.mj_footer = nil;
            }
            
        } else {
            [selfWeak.dataArray addObjectsFromArray:respondsObject];
            if (array.count >= _jm_pro_pagesize) {
                [selfWeak.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [selfWeak.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        selfWeak.jm_collectionview.hidden = NO;
        //只刷新商品列表
        [UIView performWithoutAnimation:^{
            [selfWeak.jm_collectionview reloadData];
            [SVProgressHUD dismiss];
        }];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
//栏目的幻灯片
- (void)apiRequstColumnBanner{
    @WeakObj(self);
    NSMutableDictionary*params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    if([self.SkipUIIdentifier kr_isNotEmpty]){
        params[@"SkipUIIdentifier"]=self.SkipUIIdentifier;
    }
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=convert_integral&ctrl=super_banner" respondType:(ResponseTypeDataKey) modelType:@"" success:^(NSArray* respondsObject) {
        NSArray *arr = respondsObject;
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dictry in arr) {
            [arrM addObject:dictry];
        }
        selfWeak.bannerArr=arrM;
        [selfWeak.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
    
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)bannerArr{
    if (!_bannerArr) {
        _bannerArr = [NSMutableArray array];
    }
    return _bannerArr;
}
//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}
@end
