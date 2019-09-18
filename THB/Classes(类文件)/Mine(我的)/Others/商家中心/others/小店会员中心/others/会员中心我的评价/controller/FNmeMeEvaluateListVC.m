//
//  FNmeMeEvaluateListVC.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmeMeEvaluateListVC.h"
#import "FNmeMemberEvaluatesController.h"
#import "FNCustomeNavigationBar.h"
#import "FNmeMeEvaluateItemsCell.h"
#import "FNmeMemberNorItemCell.h"
#import "JXCategoryView.h"
#import "FNmeMeEvaluatesModel.h"
#import "FNmerchentReviewModel.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "FNMemberPopAmendEvView.h"
#import "DSHPopupContainer.h"
@interface FNmeMeEvaluateListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,JXCategoryViewDelegate,FNmeMeEvaluMsgViewDelegate,FNMemberPopAmendEvViewDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong)JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong)UIImageView *headImgView;
@property (nonatomic, strong)UILabel *nameLB;
@property (nonatomic, strong)UIButton *evaluateBtn;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableArray *typeArr;
@property (nonatomic, strong)NSString *typeStr;
@property (nonatomic, strong)NSString *moreId;
@property (nonatomic, strong)NSString *storeId;
@property (nonatomic, strong)NSString *orderId;
@property (nonatomic, strong)FNmerchentReviewModel *moreModel;
@property (nonatomic, strong)FNmeMeEvaluatesModel *headModel;
@property (nonatomic, strong)DSHPopupContainer *container;
@property (nonatomic, strong)FNMemberPopAmendEvView *customView;
@end

@implementation FNmeMeEvaluateListVC

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
    self.navigationView.titleLabel.text=@"";
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+75, FNDeviceWidth, 44)];
    self.categoryView.delegate = self;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.backgroundColor=[UIColor whiteColor];
    self.categoryView.titleFont=kFONT13;
    self.categoryView.titleSelectedFont=kFONT13;
    self.categoryView.titleColor=RGB(51, 51, 51);
    //self.categoryView.titles =@[@"全部评价(50)",@"有图评价"];
    //self.categoryView.titleSelectedColor=RGB(251, 89, 7);
    [self.view addSubview:self.categoryView];
    self.lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.lineView.indicatorWidth = 40;//JXCategoryViewAutomaticDimension;
    //line颜色
    //self.lineView.indicatorColor=RGB(251, 89, 7);
    self.lineView.indicatorHeight=3;
    self.categoryView.indicators = @[self.lineView];
    
    self.view.backgroundColor=RGB(250, 250, 250);
    
    CGFloat topGap=SafeAreaTopHeight+120;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, topGap, FNDeviceWidth, FNDeviceHeight-topGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=RGB(250, 250, 250);
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    [self.view addSubview:self.jm_collectionview];
    
    [self.jm_collectionview registerClass:[FNmeMeEvaluateItemsCell class] forCellWithReuseIdentifier:@"FNmeMeEvaluateItemsCellID"];
     [self.jm_collectionview registerClass:[FNmeMemberNorItemCell class] forCellWithReuseIdentifier:@"FNmeMemberNorItemCellID"];
    //    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewID"];
    //    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView"];
    
    
    UIView *topBgView=[[UIView alloc]init];
    topBgView.frame=CGRectMake(0, SafeAreaTopHeight+1, FNDeviceWidth,65);
    topBgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:topBgView];
    self.headImgView=[[UIImageView alloc]init];
    [topBgView addSubview:self.headImgView];
    
    self.nameLB=[[UILabel alloc]init];
    [topBgView addSubview:self.nameLB];
    
    self.evaluateBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.evaluateBtn addTarget:self action:@selector(writeTextClick)];
    [topBgView addSubview:self.evaluateBtn];
    
    self.headImgView.cornerRadius=41/2;
    self.nameLB.font=[UIFont systemFontOfSize:13];
    self.nameLB.textColor=RGB(51, 51, 51);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.headImgView.sd_layout
    .widthIs(41).heightIs(41).centerYEqualToView(topBgView).leftSpaceToView(topBgView, 15);
    self.nameLB.sd_layout
    .leftSpaceToView(self.headImgView, 12).centerYEqualToView(topBgView).rightSpaceToView(topBgView, 85).heightIs(20);
    self.evaluateBtn.sd_layout
    .rightSpaceToView(topBgView, 15).centerYEqualToView(topBgView).widthIs(65).heightIs(25);
    
    
    [self requestMemberEvaluateHeader];
}
//点击类型
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    XYLog(@"%ld",(long)index);
    FNmeMeEvaluatesTabItemModel *oneModel=self.typeArr[index];
    self.typeStr=oneModel.type;
    self.jm_page = 1;
    [self requestEvaluateList];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if(self.dataArr.count>0){
        return self.dataArr.count;
    }else{
        return 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.dataArr.count>0){
        FNmeMeEvaluateItemsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmeMeEvaluateItemsCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        FNmerchentReviewModel *itemModel=[FNmerchentReviewModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
        cell.model=itemModel;
        cell.listView.index=indexPath;
        cell.listView.delegate=self;
        return cell;
    }else{
        FNmeMemberNorItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmeMemberNorItemCellID" forIndexPath:indexPath];
        cell.backgroundColor=RGB(250, 250, 250);
        cell.imgView.image=IMAGE(@"FN_meMeNorEvimg");
        cell.hintLB.text=@"竟然一条评价都没有 ";
        cell.hintLB.font=[UIFont systemFontOfSize:11];
        cell.hintLB.textColor=RGB(153, 153, 153);
        cell.lookBtn.hidden=YES;
        return cell;
    }
   
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemWith=FNDeviceWidth;
    CGFloat itemHeight=0;
    if(self.dataArr.count>0){
        FNmerchentReviewModel *itemModel=[FNmerchentReviewModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
        NSArray *imgArr=itemModel.imgs;
        CGFloat imgCount=imgArr.count;
        CGFloat imgsItemFloat=(FNDeviceWidth-87)/3;
        CGFloat imgsFloat=0;
        CGFloat imgsRowFloat=imgCount/3;
        CGFloat verticalGap=10;
        if(imgArr.count==0){
            imgsFloat=0;
        }else{
            if(imgArr.count<4){
                imgsFloat=imgsItemFloat*1;
            }else if(imgArr.count>3){
                NSInteger imgRow=ceil(imgsRowFloat);
                imgsFloat=imgsItemFloat*imgRow;
            }
        }
        CGFloat textheight=0;
        CGFloat textWidth=FNDeviceWidth-95;
        if([itemModel.content kr_isNotEmpty]){
            textheight=[itemModel.content kr_heightWithMaxWidth:textWidth attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        }
        CGFloat respondHeight=0;
        if([itemModel.sub_comment kr_isNotEmpty]){
            CGFloat respondTextWidth=FNDeviceWidth-100;
            NSString *jointStr=[NSString stringWithFormat:@"%@:  %@",itemModel.sub_comment_str,itemModel.sub_comment];
            CGFloat respondTextheight=[jointStr kr_heightWithMaxWidth:respondTextWidth attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
            respondHeight=respondTextheight+25;
        }else{
            respondHeight=0;
        }
        itemHeight=177+textheight+35+imgsFloat+30+verticalGap+respondHeight;
        XYLog(@"高=%f",itemHeight);
        XYLog(@"textheight高=%f",textheight);
        XYLog(@"imgsFloat高=%f",imgsFloat);
        CGSize  size = CGSizeMake(itemWith, itemHeight);
        return  size;
    }
    else{
        CGFloat topGap=SafeAreaTopHeight+120;
        itemHeight=FNDeviceHeight-topGap;
        CGSize  size = CGSizeMake(itemWith, itemHeight);
        return  size;
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
    return 15;
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=0;
    CGFloat bottomGap=0;
    CGFloat rightGap=0;
    if(self.dataArr.count>0){
       topGap=15;
    }
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}

#pragma mark - FNmeMeEvaluMsgViewDelegate
//查看图片
- (void)didmeMeEvaluMsgViewTheImage:(NSIndexPath*)indexs withSite:(NSInteger)siteInt{
    XYLog(@"查看%ld",(long)indexs.row);
    FNmerchentReviewModel *itemModel=[FNmerchentReviewModel mj_objectWithKeyValues:self.dataArr[indexs.row]];
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
    // 弹出相册时显示的第一张图片是点击的图片
    browser.currentPhotoIndex = siteInt;
    NSMutableArray *photos = [NSMutableArray array];
    NSArray *imgs = itemModel.imgs;
    [imgs enumerateObjectsUsingBlock:^(id  _Nonnull sobj, NSUInteger idx, BOOL * _Nonnull stop) {
        MJPhoto *mjPhoto = [[MJPhoto alloc] init];
        mjPhoto.url = [NSURL URLWithString:sobj];
        [photos addObject:mjPhoto];
    }];
    // 设置所有的图片。photos是一个包含所有图片的数组。
    browser.photos = photos;
    [browser show];
}
//进入
- (void)didmeMeEvaluMsgEnterIntoAction:(NSIndexPath*)indexs{
    
}
//点赞
- (void)didmeMeEvaluMsgGiveaLikeAction:(NSIndexPath*)indexs{
    
}
//更多
- (void)didmeMeEvaluMsgMoreAction:(NSIndexPath*)indexs{
    FNmerchentReviewModel *itemModel=[FNmerchentReviewModel mj_objectWithKeyValues:self.dataArr[indexs.row]];
    self.moreModel=itemModel;
    self.moreId=itemModel.id;
    self.storeId=itemModel.store_id;
    self.orderId=itemModel.order_id;
    self.customView = [[FNMemberPopAmendEvView alloc] init];
    self.customView.delegate=self;
    if([itemModel.username containsString:@"匿名"]){
       self.customView.dataArr=@[@"修改评价",@"取消匿名",@"删除评价",@"取消"];
    }else{
       self.customView.dataArr=@[@"修改评价",@"使用匿名",@"删除评价",@"取消"];
    }
    self.container = [[DSHPopupContainer alloc] initWithCustomPopupView:self.customView];
    self.container.autoDismissWhenClickedBackground=YES;
    self.container.maskColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    [self.container show];
}
#pragma mark - FNMemberPopAmendEvViewDelegate
//选择更多
- (void)didMemberPopAmendTypeAction:(NSInteger)indexs{
    if(indexs==0){
        //修改评价
        FNmeMemberEvaluatesController *vc=[[FNmeMemberEvaluatesController alloc]init];
        vc.orderId=self.orderId;
        vc.store_id=self.storeId;
        vc.isAmend=@"1";
        vc.amendModel=self.moreModel;
        vc.inMeMemberEvaluatesRefreshData = ^{
            self.jm_page = 1;
            [self requestEvaluateList];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(indexs==1){
        //取消匿名
        if([self.moreId kr_isNotEmpty]){
           [self requestMemberEvaluate:self.moreId withType:indexs];
        }
    }
    if(indexs==2){
        //删除评价
        if([self.moreId kr_isNotEmpty]){
           [self requestMemberEvaluate:self.moreId withType:indexs];
        }
    }
    if(indexs==3){
       //取消 
    }
    [self.container dismiss];
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//写评价
-(void)writeTextClick{
    
}
#pragma mark - request
//我的评价页面
-(FNRequestTool*)requestMemberEvaluateHeader{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_comment&ctrl=my_comment_top" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary *dictry = respondsObject[DataKey];
        self.headModel=[FNmeMeEvaluatesModel mj_objectWithKeyValues:dictry];
        [self.headImgView setUrlImg:self.headModel.head_img];
        self.nameLB.text=self.headModel.nickname;
        [self.evaluateBtn setTitle:self.headModel.btn_str forState:UIControlStateNormal];
        [self.evaluateBtn setTitleColor:[UIColor colorWithHexString:self.headModel.color] forState:UIControlStateNormal];
        self.evaluateBtn.titleLabel.font=kFONT12;
        self.evaluateBtn.cornerRadius=25/2;
        self.evaluateBtn.borderWidth=1;
        self.evaluateBtn.borderColor = [UIColor colorWithHexString:self.headModel.color];
        self.evaluateBtn.clipsToBounds = YES;
        NSArray *tabArr=self.headModel.tab;
        if(tabArr.count>0){
            NSMutableArray *arrTitle=[NSMutableArray arrayWithCapacity:0];
            self.typeArr=[NSMutableArray arrayWithCapacity:0];
            [tabArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNmeMeEvaluatesTabItemModel *itemModel=[FNmeMeEvaluatesTabItemModel mj_objectWithKeyValues:obj];
                [arrTitle addObject:itemModel.str];
                [self.typeArr addObject:itemModel];
            }];
            self.categoryView.titles =arrTitle;
            self.categoryView.titleSelectedColor=[UIColor colorWithHexString:self.headModel.color];
            self.lineView.indicatorColor=[UIColor colorWithHexString:self.headModel.color];
            [self.categoryView reloadData];
            FNmeMeEvaluatesTabItemModel *oneModel=[FNmeMeEvaluatesTabItemModel mj_objectWithKeyValues:tabArr[0]];
            self.typeStr=oneModel.type;
            [self requestEvaluateList];
        }
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}
//我的评价
-(FNRequestTool*)requestEvaluateList{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
    if([self.typeStr kr_isNotEmpty]){
        params[@"type"]=self.typeStr;
    }
    [SVProgressHUD show];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_comment&ctrl=my_comment_list" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
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
                    [self requestEvaluateList];
                }];
            }else{
            }
            [self.jm_collectionview.mj_footer endRefreshing];
        } else {
            [self.dataArr addObjectsFromArray:array];
            [self.jm_collectionview.mj_footer endRefreshing];
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
//我的评价页面
-(void)requestMemberEvaluate:(NSString*)oid withType:(NSInteger)typeInt{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    params[@"id"]=oid;
    NSString *urlStr=@"";
    if(typeInt==1){
        //取消匿名
       urlStr=@"mod=appapi&act=rebate_comment&ctrl=anonymous";
    }
    if(typeInt==2){
        //删除评价
        urlStr=@"mod=appapi&act=rebate_comment&ctrl=del";
    }
    [FNRequestTool requestWithParams:params api:urlStr respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSString *msgStr = respondsObject[MsgKey];
        NSInteger stateInt = [respondsObject[SuccessKey] integerValue];
         [FNTipsView showTips:msgStr];
        if(stateInt==1){
           self.jm_page=1;
           [self requestEvaluateList];
        }
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
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
