//
//  FNSomeTimeTeController.m
//  THB
//
//  Created by 李显 on 2019/1/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNSomeTimeTeController.h"
//view
#import "FNCustomeNavigationBar.h"
#import "FNsomeItemTeCell.h"
#import "FDSlideBar.h"
#import "FNCombinedButton.h"
#import "FNgoodsLibScreenUeView.h"
#import "JhScrollActionSheetView.h"
#import "JhPageItemModel.h"
//model
#import "FNSomeTeItemModel.h"
#import "FNBaseProductModel.h"
#import "FNgradeUeModel.h"
@interface FNSomeTimeTeController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,FNsomeItemTeCellDelegate,FNgoodsLibScreenUeViewDegate>
@property(nonatomic,strong)FNCustomeNavigationBar *topNaivgationbar;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UIButton *shareBtn;
@property(nonatomic,strong)UIButton *checkAllBtn;
@property(nonatomic,strong)UILabel *shareNumberLB;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *importArray;
@property(nonatomic,strong)NSMutableArray *screenArray;
@property(nonatomic,strong)NSMutableArray *screenBtns;
@property(nonatomic,strong)NSMutableArray *popCateArr;
@property(nonatomic,strong)NSString *keyword;  //商品关键字
@property(nonatomic,strong)NSString *cid;      //商品分类
@property(nonatomic,strong)NSString *sort;     //排序
@property(nonatomic,strong)NSString *typeString;     //分类使用
@property(nonatomic,assign)NSInteger sortInt;
@property(nonatomic,strong)FDSlideBar *topSlideBar;//分栏内容
@property(nonatomic,strong)UIView *screenView;
@property(nonatomic,strong)FNgradeUeModel *headModel;
@property(nonatomic,strong)FNgoodsLibScreenUeView *popupView;
@end

@implementation FNSomeTimeTeController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self setTopNavBar];
    [self sortTopView];
    [self someTimeCollectionview];
    [self toScreenView];
    
    [self apiRequestGoodsCate];
    
    [self baseViews];
    
    [self poppingView];
}

#pragma mark - 导航栏view
-(void)setTopNavBar{
    self.topNaivgationbar = [FNCustomeNavigationBar customeNavigationBarWithSearchBarFrame:(CGRectMake(80, 27, FNDeviceWidth-80*2, 30)) andPlaceholder:@"输入你想要搜索的宝贝"];
    self.topNaivgationbar.searchBar.cornerRadius=30/2;
    self.topNaivgationbar.searchBar.delegate=self;
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftBtn setTitle:@"商品库" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font=kFONT14;
    [self.leftBtn sizeToFit];
    self.leftBtn.size = CGSizeMake(self.leftBtn.width+10, 30);
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.leftBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10.0f];
    
    self.topNaivgationbar.leftButton = self.leftBtn;
    
    [self.view addSubview:_topNaivgationbar];
    self.topNaivgationbar.backgroundColor =[UIColor whiteColor];
    [self.topNaivgationbar.searchBar setBackgroundColor:RGBA(246, 245, 245,1)];
    self.topNaivgationbar.searchBar.backgroundImage = [UIImage createImageWithColor:RGBA(246, 245, 245,1)];
    UITextField *searchField = [_topNaivgationbar.searchBar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor clearColor]];
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:_topNaivgationbar.searchBar.placeholder attributes:@{NSForegroundColorAttributeName:RGB(200, 200, 200),NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        searchField.attributedPlaceholder = attrString;
        searchField.clearButtonMode = UITextFieldViewModeNever;
    }
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSFontAttributeName: kFONT12}];
    [self.topNaivgationbar.searchBar setImage:IMAGE(@"FJ_slices_img") forSearchBarIcon:UISearchBarIconSearch  state:UIControlStateNormal];
    //self.topNaivgationbar.searchBar.showsCancelButton=NO;
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.rightBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.rightBtn.titleLabel.font=kFONT12;
    [self.rightBtn sizeToFit];
    self.rightBtn.size = CGSizeMake(self.leftBtn.width+10, 30);
    self.topNaivgationbar.rightButton = self.rightBtn;
    
    [self sortTopView];
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightBtnAction{  
    NSMutableArray *arrList=[NSMutableArray arrayWithCapacity:0];
    for (FNBaseProductModel *model in self.dataArray) {
        if (model.someState==1) {
            [arrList addObject:model];
        }
    }
    if(arrList.count>9){
        [FNTipsView showTips:@"最多分享9个商品"];
        return;
    }
    if(arrList.count==0){
        return;
    }
    if ([self.delegate respondsToSelector:@selector(someTimeDoteyList:)]){
        [self.delegate someTimeDoteyList:arrList];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if([searchBar.text kr_isNotEmpty]){
        self.jm_page=1;
        self.sort=@"";
        self.cid=@"";
        self.keyword=searchBar.text;
        [self apiRequestSomeTimeList];
        [self.topNaivgationbar.searchBar resignFirstResponder];
    }
}
-(void)poppingView{
    self.popupView=[[FNgoodsLibScreenUeView alloc]init];
    self.popupView.hidden=YES;
    self.popupView.delegate=self;
    self.popupView.frame=CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight);
    [self.view addSubview:self.popupView];
}
#pragma mark - FNgoodsLibScreenUeViewDegate //选择二级类型
-(void)ingoodsLibChildTypeAction:(FNSomeGoodsCateModel*)model{
    XYLog(@"type:%@",model.addType);
    NSString *addType=model.addType;
    if([addType isEqualToString:@"sort"]){
        self.sort=model.type;
    }
    if([addType isEqualToString:@"cate"]){
        self.cid=model.id;
    }
    self.jm_page=1;
    self.keyword=@"";
    [self apiRequestSomeTimeList];
}
-(void)sortTopView{
    @WeakObj(self);
    self.topSlideBar = [[FDSlideBar alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, 40)];
    self.topSlideBar.backgroundColor =RGB(246, 245, 245);
    //self.topSlideBar.is_middle=YES;
    self.topSlideBar.is_mean=YES;
    [self.topSlideBar selectSlideBarItemAtIndex:0];
    [self.topSlideBar slideBarItemSelectedCallback:^(NSUInteger index) {
        FNSomeGoodsCateModel *model=selfWeak.importArray[index];
        selfWeak.SkipUIIdentifier=model.SkipUIIdentifier;
        selfWeak.jm_page=1;
        [selfWeak apiRequestSomeTimeList];
    }];
    [self.view addSubview:self.topSlideBar];
}
#pragma mark - 主视图
-(void)someTimeCollectionview{
    CGFloat baseH=41;
    if(XYTabBarHeight>49){
        baseH=XYTabBarHeight;
    }
    CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight-80-baseH;
    CGFloat topInterval=SafeAreaTopHeight+80;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(1, topInterval, FNDeviceWidth, tableHeight) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.hidden=YES;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNsomeItemTeCell class] forCellWithReuseIdentifier:@"FNsomeItemTeCellId"];
    self.view.backgroundColor=RGB(246, 245, 245);
    self.jm_collectionview.backgroundColor=RGB(246, 245, 245);
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    FNsomeItemTeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNsomeItemTeCellId" forIndexPath:indexPath];
    cell.backgroundColor =RGB(243, 243, 243);
    FNBaseProductModel *model=self.dataArray[indexPath.row];
    cell.model=model;
    cell.delegate=self;
    cell.indexPath=indexPath;
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
    return 1;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=FNDeviceWidth;
    CGSize size = CGSizeMake(with, 120);
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - FNsomeItemTeCellDelegate // 选择
- (void)inchoiceSomeItemAction:(NSIndexPath*)index withState:(NSInteger)state{
    FNBaseProductModel *model=self.dataArray[index.row];
    model.someState=state;
    
    [self ergodicityDataArray];
}
-(void)ergodicityDataArray{
    NSMutableArray *addModelArr=[NSMutableArray arrayWithCapacity:0];
    for (FNBaseProductModel *itemModel in self.dataArray) {
        if(itemModel.someState==1){
            [addModelArr addObject:itemModel];
        }
    }
    if(addModelArr.count>0){
        self.shareNumberLB.text=[NSString stringWithFormat:@"共%lu件",(unsigned long)addModelArr.count];//@"共110件";
    }else{
        self.shareNumberLB.text=@"";
    }
    if(addModelArr.count==self.dataArray.count){
        self.checkAllBtn.selected=YES;
    }else{
        self.checkAllBtn.selected=NO;
    }
}
#pragma mark - 筛选view
-(void)toScreenView{
    self.screenView=[[UIView alloc]init];
    self.screenView.backgroundColor=[UIColor whiteColor];
    self.screenView.cornerRadius=5/2;
    [self.view addSubview:self.screenView];
    self.screenView.sd_layout
    .leftSpaceToView(self.view, 10).rightSpaceToView(self.view, 10).topSpaceToView(self.view, SafeAreaTopHeight+45).heightIs(34);
}

-(void)addSortBtnView{
    
    NSMutableArray *name=[[NSMutableArray alloc]init];
    NSString *strColor=@"FFFFFF";
    NSString *check_color=@"FFFFFF";
    if (self.screenArray.count>0) {
        FNSomeGoodsScreenModel *colormodel=self.screenArray[0];
        strColor=colormodel.color;
        check_color=colormodel.check_color;
        [self.screenArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNSomeGoodsScreenModel *model=obj;
            [name addObject:model.name];
        }];
        if (self.screenBtns.count>=1) {
            [self.screenBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self.screenBtns removeAllObjects];
        }
        CGFloat width = (FNDeviceWidth-20)/3;
        [name enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNgradeSortItemModel *onemodel=self.screenArray[idx];
            NSInteger is_up=[onemodel.is_up integerValue];
            FNCombinedButton* tmpview = nil;
            tmpview.userInteractionEnabled=YES;
            if (is_up==0) {
                FNCombinedButton* btn = [[FNCombinedButton alloc]initWithImage:IMAGE(@"") selectedImage:IMAGE(@"") title:obj font:kFONT13 titleColor:[UIColor colorWithHexString:strColor] selectedTitleColor:[UIColor colorWithHexString:check_color] target:self action:nil];
                [self.screenView addSubview:btn];
                tmpview  = btn;
            }else{
                FNCombinedButton* btn = [[FNCombinedButton alloc]initWithImage:IMAGE(@"FS_grayX_img") selectedImage:IMAGE(@"FS_redX_img") title:obj font:kFONT13 titleColor:[UIColor colorWithHexString:strColor] selectedTitleColor:[UIColor colorWithHexString:check_color] target:self action:nil];
                btn.tag = idx+100;
                [self.screenView addSubview:btn];
                tmpview  = btn;
            }
            [tmpview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, width*idx, 0, 0)) excludingEdge:(ALEdgeRight)];
            [tmpview autoSetDimension:(ALDimensionWidth) toSize:width];
            tmpview.tag = idx+100;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
            [tmpview addGestureRecognizer:tap];
            [self.screenBtns addObject:tmpview];
        }];
    }
}
#pragma mark - action
-(void)tapClick:(id)sender{
    UITapGestureRecognizer * singleTap = (UITapGestureRecognizer *)sender;
    UIView *tmp =nil;
    UIView *view = (UIView *)singleTap.view;
    NSInteger index = view.tag;
    NSInteger tag = index-100;
    NSString *strColor=@"FFFFFF";
    NSString *check_color=@"FFFFFF";
    if (self.screenArray.count>0) {
        FNSomeGoodsScreenModel *onemodel=self.screenArray[0];
        strColor=onemodel.color;
        check_color=onemodel.check_color;
    }
    FNSomeGoodsScreenModel *seletedmodel=self.screenArray[tag];
    NSInteger is_up=[seletedmodel.is_up integerValue];
    if (is_up==0) {
        FNCombinedButton* btn = self.screenBtns[tag];
        tmp= btn;
    }else{
        FNCombinedButton* btn = self.screenBtns[tag];
        btn.titleLabel.selected=!btn.titleLabel.selected;
        [btn.titleLabel setImage:IMAGE(@"FS_grayX_img") forState:UIControlStateNormal];
        [btn.titleLabel setImage:IMAGE(@"FS_redX_img") forState:UIControlStateSelected];
        [btn.titleLabel setTitleColor:[UIColor colorWithHexString:strColor] forState:UIControlStateNormal];
        [btn.titleLabel setTitleColor:[UIColor colorWithHexString:check_color] forState:UIControlStateSelected];
        tmp = btn;
        
        FNSomeGoodsScreenModel *model=self.screenArray[tag];
        self.typeString=model.type;
        if([self.typeString isEqualToString:@"sort"] || [self.typeString isEqualToString:@"cate"]){
           [self apiRequestScreenTwoCate];
        }
        if([self.typeString isEqualToString:@"cate"]){
           //刷新商品排序price_desc
        }
        
    }
    [self.screenBtns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FNSomeGoodsScreenModel *enmodel=self.screenArray[idx];
        NSInteger enis_up=[enmodel.is_up integerValue];
        if (enis_up==0) {
            FNCombinedButton* btn = obj;
            btn.selected = btn==tmp;
        }else{
            if(idx!=tag){
                FNCombinedButton* btn = obj;
                btn.titleLabel.selected=NO;
                [btn.titleLabel setImage:IMAGE(@"FS_grayX_img") forState:UIControlStateNormal];
                [btn.titleLabel setTitleColor:[UIColor colorWithHexString:strColor] forState:UIControlStateNormal];
                btn.selected = btn==tmp;
            }
        }
    }];
}
-(void)baseViews{
    
    self.shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.shareBtn.titleLabel.font=kFONT17;
    self.shareBtn.backgroundColor=RGB(239, 98, 112);
    [self.shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.shareBtn setTitle:@"分享宝贝" forState:UIControlStateNormal];
    [self.shareBtn addTarget:self action:@selector(shareBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shareBtn];
    
    self.checkAllBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.checkAllBtn.titleLabel.font=kFONT13;
    [self.checkAllBtn setTitleColor:RGB(130, 130, 130) forState:UIControlStateNormal];
    [self.checkAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    [self.checkAllBtn setImage:IMAGE(@"FK_blue_Norxz_img") forState:UIControlStateNormal];
    [self.checkAllBtn setImage:IMAGE(@"FK_blue_xz_img") forState:UIControlStateSelected];
    [self.checkAllBtn addTarget:self action:@selector(checkAllBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.checkAllBtn];
    
    self.shareNumberLB=[[UILabel alloc]init];
    self.shareNumberLB.font=kFONT17;
    
    self.shareNumberLB.textColor=RGB(239, 98, 112);
    self.shareNumberLB.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:self.shareNumberLB];
    
    CGFloat baseH=0;
    if(XYTabBarHeight>49){
       baseH=XYTabBarHeight-40;
    }
    self.shareBtn.sd_layout
    .rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, baseH).widthIs(105).heightIs(40);
    
    self.checkAllBtn.sd_layout
    .leftSpaceToView(self.view, 0).bottomSpaceToView(self.view, baseH).widthIs(90).heightIs(40);
    [self.checkAllBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:30];
    
    self.shareNumberLB.sd_layout
    .rightSpaceToView(self.shareBtn, 5).centerYEqualToView(self.shareBtn).widthIs(120).heightIs(30);
    
}
-(void)shareBtnAction{
    [self rightBtnAction];
}
-(void)checkAllBtnAction:(UIButton *)btn{
    btn.selected=!btn.selected;
    if(btn.selected==YES){
        for (FNBaseProductModel *model in self.dataArray) {
            model.someState=1;
        }
        self.shareNumberLB.text=[NSString stringWithFormat:@"共%lu件",(unsigned long)self.dataArray.count];
    }else{
        for (FNBaseProductModel *model in self.dataArray) {
            model.someState=0;
        }
        self.shareNumberLB.text=@"";
    }
    [self.jm_collectionview reloadData];
}
#pragma mark - //商品库分类（会没有分类的情况）
- (FNRequestTool *)apiRequestGoodsCate{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appGoodsBank&ctrl=cate" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"商品库分类:%@",respondsObject);
        NSDictionary *dictry=respondsObject[DataKey];
        NSString *str=dictry[@"str"];
        NSString *search_str=dictry[@"search_str"];
        NSString *btn_str=dictry[@"btn_str"];
        NSString *btn_color=dictry[@"btn_color"];
        if([str kr_isNotEmpty]){
            [selfWeak.leftBtn setTitle:str forState:UIControlStateNormal];
        }
        if([search_str kr_isNotEmpty]){
            selfWeak.topNaivgationbar.searchBar.placeholder=search_str;
        }
        if([btn_str kr_isNotEmpty]){
            [selfWeak.rightBtn setTitle:btn_str forState:UIControlStateNormal];
        }
        if([btn_color kr_isNotEmpty]){
            [selfWeak.rightBtn setTitleColor:[UIColor colorWithHexString:btn_color] forState:UIControlStateNormal];
        }
        NSArray *cateArr=dictry[@"cate"];
        if(cateArr.count>0){
            NSMutableArray *title=[NSMutableArray arrayWithCapacity:0];
            [cateArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [title addObject:obj[@"name"]];
                FNSomeGoodsCateModel *model=[FNSomeGoodsCateModel mj_objectWithKeyValues:obj];
                [selfWeak.importArray addObject:model];
            }];
            selfWeak.topSlideBar.itemsTitle = title;
            selfWeak.topSlideBar.itemColor = RGB(130, 130, 130);
            selfWeak.topSlideBar.itemSelectedColor = RGB(239, 98, 112);
            selfWeak.topSlideBar.sliderColor = RGB(239, 98, 112);
            selfWeak.topSlideBar.fontSize=14;
            selfWeak.topSlideBar.SelectedfontSize=14;
            
            FNSomeGoodsCateModel *oneModel=selfWeak.importArray[0];
            selfWeak.SkipUIIdentifier=oneModel.SkipUIIdentifier;
            [selfWeak apiRequestScreencate];
           
        }else{
            selfWeak.SkipUIIdentifier=@"buy_taobao";
            [selfWeak apiRequestScreencate];
        }
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

#pragma mark - //商品库筛选栏文字
- (FNRequestTool *)apiRequestScreencate{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    if([self.SkipUIIdentifier kr_isNotEmpty]){
        params[@"SkipUIIdentifier"]=self.SkipUIIdentifier;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appGoodsBank&ctrl=screencate" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"筛选栏文字:%@",respondsObject);
        NSArray *arrAy=respondsObject[DataKey];
        if(arrAy.count>0){
            [arrAy enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNSomeGoodsScreenModel *model=[FNSomeGoodsScreenModel mj_objectWithKeyValues:obj];
                [selfWeak.screenArray addObject:model];
            }];
            [selfWeak addSortBtnView];
            FNSomeGoodsScreenModel *model=selfWeak.screenArray[0];
            selfWeak.sort=model.type;
            [selfWeak apiRequestSomeTimeList];
        }
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark - //弹出 筛选分类
- (FNRequestTool *)apiRequestScreenTwoCate{
    @WeakObj(self);
    NSString *urlString=@"";
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    if([self.typeString kr_isNotEmpty]){
        params[@"type"]=self.typeString;
    }
    if([self.SkipUIIdentifier kr_isNotEmpty]){
        params[@"SkipUIIdentifier"]=self.SkipUIIdentifier;//@"buy_taobao";
    }
    if([self.typeString isEqualToString:@"sort"]){
        urlString=@"mod=appapi&act=appGoodsBank&ctrl=getSort";
    }
    if([self.typeString isEqualToString:@"cate"]){
        urlString=@"mod=appapi&act=appGoodsCate02&ctrl=getCate";
    }
    
    return [FNRequestTool requestWithParams:params api:urlString respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"弹出 筛选分类:%@",respondsObject);
        NSArray *cateArr=respondsObject[DataKey];
        if(cateArr.count>0){
            NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
            [cateArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNSomeGoodsCateModel *model=[FNSomeGoodsCateModel mj_objectWithKeyValues:obj];
                model.addType=self.typeString;
                [arrM addObject:model];
            }];
            //selfWeak.popCateArr=arrM;
            if(arrM.count>0){
               self.popupView.dataArr=arrM;
               self.popupView.hidden=NO;
               [self.popupView showView];
            }
        }
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark - //宝贝分享list
- (FNRequestTool *)apiRequestSomeTimeList{
    [SVProgressHUD show];
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{ @"token":UserAccessToken,PageNumber:@(self.jm_page),PageSize:@(_jm_pro_pagesize)}];
    //SkipUIIdentifier
    //keyword  商品关键字
    //cid      商品分类
    //sort     排序
    if([self.SkipUIIdentifier kr_isNotEmpty]){
        params[@"SkipUIIdentifier"]=self.SkipUIIdentifier;//@"buy_taobao";
    }
    if([self.sort kr_isNotEmpty]){
        params[@"sort"]=self.sort;
    }
    if([self.cid kr_isNotEmpty]){
        params[@"cid"]=self.cid;
    }
    if([self.keyword kr_isNotEmpty]){
        params[@"keyword"]=self.keyword;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appGoodsBank&ctrl=index" respondType:(ResponseTypeDataKey) modelType:@"" success:^(NSArray* respondsObject) {
        NSArray* array = respondsObject;
        [SVProgressHUD dismiss];
        [selfWeak.jm_collectionview.mj_footer endRefreshing];
        [selfWeak.jm_collectionview.mj_header endRefreshing];
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dictry in array) {
            FNBaseProductModel *model=[FNBaseProductModel mj_objectWithKeyValues:dictry];
            [arrM addObject:model];
        }
        
        if (selfWeak.jm_page == 1) {
            if (array.count == 0) {
                [selfWeak.jm_collectionview reloadData];
                return ;
            }
            [selfWeak.dataArray removeAllObjects];
            [selfWeak.dataArray addObjectsFromArray:arrM];
            if (array.count >= _jm_pro_pagesize) {
                selfWeak.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    selfWeak.jm_page ++;
                    [selfWeak apiRequestSomeTimeList];
                }];
            }else{
                selfWeak.jm_collectionview.mj_footer = nil;
            }
            
        } else {
            [selfWeak.dataArray addObjectsFromArray:arrM];
            if (array.count >= _jm_pro_pagesize) {
                [selfWeak.jm_collectionview.mj_footer endRefreshing];
                
            }else{
                [selfWeak.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        selfWeak.jm_collectionview.hidden = NO;
        [selfWeak.jm_collectionview reloadData];
        [self ergodicityDataArray];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark - //分享图片
-(void)openShareImgS{ 
    __block NSString *ShareFnuo_id=@"";
    NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
    [self.dataArray enumerateObjectsUsingBlock:^(FNBaseProductModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj.someState==1){
            if (ShareFnuo_id.length==0) {
                ShareFnuo_id=obj.fnuo_id;
            }else{
                ShareFnuo_id=[NSString stringWithFormat:@"%@,%@",ShareFnuo_id,obj.fnuo_id];
            }
            [arrM addObject:obj.fnuo_id];
        }
    }];
    //XYLog(@"ShareFnuo_id=:%@",ShareFnuo_id);
    if (ShareFnuo_id.length==0) {
        [FNTipsView showTips:@"请选择商品分享"];
        return;
    }
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"goods_type":@"taobao",@"fnuo_id":ShareFnuo_id}];
    if([self.SkipUIIdentifier kr_isNotEmpty]){
        params[@"goods_type"]=self.SkipUIIdentifier;//@"buy_taobao";
    }
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=shareMoreImg&ctrl=ercode" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSArray *DataArr=[respondsObject valueForKey:@"data"];
        NSMutableArray* images = [NSMutableArray new];
        NSMutableArray* shareimages = [NSMutableArray new];
        for (NSDictionary *dic in DataArr) {
            [images addObject:dic[@"img"]];
        }
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [XYNetworkAPI downloadImages:images withIndexBlock:^(UIImage *img, NSInteger index) {
                [shareimages addObject:img];
                //XYLog(@"分享的图片=:%@",img);
                if(shareimages>0){
                    [SVProgressHUD dismiss];
                    UIActivityViewController* vc = [[UIActivityViewController alloc]initWithActivityItems:shareimages applicationActivities:nil];
                    [self presentViewController:vc animated:YES completion:nil];
                }
            } failureBlock:^(NSError *error) {
                [SVProgressHUD dismiss];
            }];
        });
    } failure:^(NSString *error) {
        
    } isHideTips:NO];
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)importArray{
    if (!_importArray) {
        _importArray = [NSMutableArray array];
    }
    return _importArray;
}
-(NSMutableArray *)screenArray{
    if (!_screenArray) {
        _screenArray = [NSMutableArray array];
    }
    return _screenArray;
}
-(NSMutableArray *)screenBtns{
    if (!_screenBtns) {
        _screenBtns = [NSMutableArray array];
    }
    return _screenBtns;
}
-(NSMutableArray *)popCateArr{
    if (!_popCateArr) {
        _popCateArr = [NSMutableArray array];
    }
    return _popCateArr;
}


@end
