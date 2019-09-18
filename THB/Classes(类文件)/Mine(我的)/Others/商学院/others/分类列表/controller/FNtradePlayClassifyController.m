//
//  FNtradePlayClassifyController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/24.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNtradePlayClassifyController.h"
#import "FNtradeVideoDetailsController.h"
#import "FNtradeArticleDetailsController.h"
#import "FNCustomeNavigationBar.h"
#import "FNTrplayCWItemCell.h"
#import "FNtradeRecommendCell.h"
#import "FNtradeHomeModel.h"
@interface FNtradePlayClassifyController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)NSMutableArray *dataArr;

@property (nonatomic, strong)UIView *vEmpty;
@property (nonatomic, strong)UIImageView *imgEmpty;
@property (nonatomic, strong)UILabel *lblEmpty;
@end

@implementation FNtradePlayClassifyController

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
#pragma mark - set up views
- (void)jm_setupViews{
    CGFloat baseGap=SafeAreaTopHeight+1;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    //flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, baseGap, FNDeviceWidth, FNDeviceHeight-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=RGB(238, 238, 238);
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNTrplayCWItemCell class] forCellWithReuseIdentifier:@"FNTrplayCWItemCellID"];
    [self.jm_collectionview registerClass:[FNtradeRecommendCell class] forCellWithReuseIdentifier:@"FNtradeRecommendCellID"];
    
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
    self.navigationView.titleLabel.text=self.keyWord ? self.keyWord:@"必看视频";
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    
    [self.jm_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@(baseGap));
        make.bottom.equalTo(isIphoneX ? @(-34) : @0);
    }];
    
    self.view.backgroundColor=RGB(245, 245, 245);
    if([self.is_video isEqualToString:@"1"]){ 
       self.jm_collectionview.backgroundColor=RGB(240, 240, 240);
    }else{
       self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    }
//    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    footer.stateLabel.hidden=YES;
//    NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
//    for (NSInteger i=1; i<32; i++) {
//        [arrM addObject:[UIImage imageNamed:[NSString stringWithFormat:@"FN_bottom_loading－%ld",(long)i]]];
//    }
//    //[footer setImages:arrM  forState:MJRefreshStateRefreshing]; 
//    [footer setImages:arrM duration:arrM.count * 0.04 forState:MJRefreshStateRefreshing];
//    
//    self.jm_collectionview.mj_footer=footer;
    
    [self requestcCateList];
    
    _vEmpty = [[UIView alloc] init];
    _imgEmpty = [[UIImageView alloc] init];
    _lblEmpty = [[UILabel alloc] init];
    
    [self.view addSubview: _vEmpty];
    [_vEmpty addSubview: _imgEmpty];
    [_vEmpty addSubview: _lblEmpty];
    
    [_vEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.jm_collectionview);
        make.left.top.greaterThanOrEqualTo(self.jm_collectionview);
        make.right.bottom.lessThanOrEqualTo(self.jm_collectionview);
    }];
    
    [_imgEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.centerX.equalTo(@0);
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(@0);
    }];
    
    [_lblEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgEmpty.mas_bottom).offset(10);
        make.centerX.equalTo(@0);
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    _vEmpty.hidden = YES;
    
    _imgEmpty.image = IMAGE(@"trade_image_empty");
    
    _lblEmpty.text = @"暂时没有数据";
    _lblEmpty.textColor = RGB(150, 150, 150);
}
//上拉更多
-(void)loadMoreData{
    if (self.dataArr.count >= _jm_pro_pagesize) {
        self.jm_page ++;
        [self requestcCateList];
    }else{
        [self.jm_collectionview.mj_footer endRefreshing];
    }
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    _vEmpty.hidden = self.dataArr.count > 0;
    return self.dataArr.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self.is_video isEqualToString:@"1"]){
        FNTrplayCWItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNTrplayCWItemCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.cornerRadius=5;
        cell.model=[FNtradeHomeRecommendItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
        return cell;
    }else{
        FNtradeRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNtradeRecommendCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=[FNtradeHomeRecommendItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=195;
    CGFloat itemWith=FNDeviceWidth;
    if([self.is_video isEqualToString:@"1"]){
        itemHeight=195;
    }else{
        itemHeight=112;
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
    if([self.is_video isEqualToString:@"1"]){
        return 10;
    }else{
        return 0;
    } 
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=12;
    CGFloat bottomGap=0;
    CGFloat rightGap=12;
    if([self.is_video isEqualToString:@"1"]){
        leftGap=12;
        rightGap=12;
    }else{
        leftGap=0;
        rightGap=0;
    }
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FNtradeHomeRecommendItemModel *model=[FNtradeHomeRecommendItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
    if([model.atricle_url kr_isNotEmpty]){
        [self goWebDetailWithWebType:@"0" URL:model.atricle_url];
    }
//        if([model.type isEqualToString:@"2"]){
//            FNtradeVideoDetailsController *vc=[[FNtradeVideoDetailsController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//        else{
//            if([model.atricle_url kr_isNotEmpty]){
//                FNtradeArticleDetailsController *vc=[[FNtradeArticleDetailsController alloc]init];
//                vc.urlString=model.atricle_url;
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//        }
    
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - request
//推荐列表
-(void)requestcCateList{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
     NSString *urlStr=@"mod=appapi&act=college&ctrl=get_catelist";
     if([self.is_video isEqualToString:@"1"]){
       urlStr=@"mod=appapi&act=college&ctrl=get_catelist";
     }
     if([self.is_video isEqualToString:@"0"]){
        urlStr=@"mod=appapi&act=college&ctrl=get_catelist";
     }
     if([self.is_video isEqualToString:@"2"]){
        urlStr=@"mod=appapi&act=college&ctrl=search";
     }
     if(![urlStr kr_isNotEmpty]){
        return;
     }
     if([self.cateId kr_isNotEmpty]){
        params[@"id"]=self.cateId;
     }
     if([self.kwString kr_isNotEmpty]){
        params[@"kw"]=self.kwString;
     }
     [FNRequestTool requestWithParams:params api:urlStr respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
         NSArray *array=[NSArray new];
         if([self.is_video isEqualToString:@"2"]){
             array =respondsObject[DataKey];
         }else{
             NSDictionary *dictry =respondsObject[DataKey];
             array =dictry[@"list"];
         }
          if (self.jm_page == 1) {
             if (array.count == 0) {
                 [self.dataArr removeAllObjects];
                 [self.jm_collectionview reloadData];
//                 [FNTipsView showTips:@"很抱歉，暂无更多信息"];
                 return ;
             }
             [self.dataArr removeAllObjects];
             [self.dataArr addObjectsFromArray:array];
              if (array.count >= _jm_pro_pagesize) {
                  self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                      self.jm_page ++;
                      [self requestcCateList];
                  }];
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
        
    } failure:^(NSString *error) {
        [self.jm_collectionview.mj_footer endRefreshing];
    } isHideTips:YES isCache:NO];
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
