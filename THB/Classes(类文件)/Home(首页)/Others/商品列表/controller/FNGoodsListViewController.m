//
//  FNGoodsListViewController.m
//  THB
//
//  Created by Fnuo-iOS on 2018/5/7.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNGoodsListViewController.h"
#import "FNHomeProductCell.h"
#import "FNHomeProductSingleRowCell.h"

@interface FNGoodsListViewController ()

@property (nonatomic, assign) BOOL singleBool;

@end

@implementation FNGoodsListViewController{
    NSInteger Pages;
    NSMutableArray *title;
    NSInteger ColumnSelectIndex;
    NSString *sort;
    NSInteger yhq;
}

-(NSMutableArray *)SortArr{
    if (_SortArr == nil) {
        _SortArr = [NSMutableArray new];
    }
    return _SortArr;
}
-(NSMutableArray<FNBaseProductModel *> *)list{
    if (_list == nil) {
        _list = [NSMutableArray new];
    }
    return _list;
}

- (GoodsListScreeningView *)elementview{
    if (_elementview == nil) {
        @weakify(self);
        _elementview = [[GoodsListScreeningView alloc]initWithFrame:(CGRectMake(0, CGRectGetMaxY(_screeningView.frame)+1+JMNavBarHeigth, JMScreenWidth, 0))];
        _elementview.btnClickedAction = ^{
            @strongify(self);
            [FNPopUpTool hiddenAnimated:YES];
            Pages=1;
            [self requestGoodsList];
        };
    }
    return _elementview;
}

-(UITextField *)SearchBar{
    if (_SearchBar==nil) {
        _SearchBar=[UITextField new];
        _SearchBar.delegate=self;
        _SearchBar.backgroundColor=[UIColor clearColor];
        _SearchBar.font=kFONT14;
        _SearchBar.textColor=FNBlackColor;
        _SearchBar.height=40;
        _SearchBar.placeholder=@"请输入关键字";
        _SearchBar.text=self.keyword;
        
        UIImage *img1=IMAGE(@"partner_search");
        UIImageView *leftsearchView = [[UIImageView alloc]initWithImage:img1];
        leftsearchView.frame = CGRectMake(0, 0, 30, 30);
        leftsearchView.contentMode = UIViewContentModeCenter;
        _SearchBar.leftViewMode = UITextFieldViewModeAlways;
        _SearchBar.leftView = leftsearchView;

        @weakify(self);
        [_SearchBar addJXTouch:^{
            @strongify(self);
            [self.SearchBar resignFirstResponder];
            firstVersionSearchViewController* search = [firstVersionSearchViewController new];
            search.SkipUIIdentifier=self.SkipUIIdentifier;
            search.SearchBar.text=self.keyword;
            [self.navigationController pushViewController:search animated:YES];
        }];
    }
    return _SearchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    sort=@"zonghe";
    yhq = ![FNBaseSettingModel settingInstance].dgapp_yhq_onoff.boolValue;
    [self Buildtheinterface];//构建界面
    _singleBool = YES;
    
    [SVProgressHUD show];
    [FNRequestTool startWithRequests:@[[self apiRequestHotSearchHeadColumn]] withFinishedBlock:^(NSArray *erros) {
        _slideBar = [[FDSlideBar alloc] initWithFrame:CGRectMake(50, 0, FNDeviceWidth-50, 40)];
        _slideBar.backgroundColor = FNWhiteColor;
        _slideBar.is_middle=YES;
        _slideBar.itemsTitle = title;
        _slideBar.itemColor = FNGlobalTextGrayColor;
        _slideBar.itemSelectedColor = FNMainGobalTextColor;
        _slideBar.sliderColor = FNMainGobalTextColor;
        _slideBar.fontSize=13;
        _slideBar.SelectedfontSize=14;
        [_slideBar selectSlideBarItemAtIndex:ColumnSelectIndex];
        [self slideBarItemSelected];
        self.navigationItem.titleView = _slideBar;
        
        [self apiRequestSort];
    }];
}
-(void)slideBarItemSelected{
    [_slideBar slideBarItemSelectedCallback:^(NSUInteger index) {
        self.SkipUIIdentifier=self.ColumnArray[index].SkipUIIdentifier;
        [self apiRequestSort];
    }];
}

#pragma mark - 构建界面
-(void)Buildtheinterface{
    UIView *mainView=[UIView new];
    mainView.backgroundColor=FNWhiteColor;
    mainView.hidden=YES;
    [self.view addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(@0);
    }];
    self.mainView=mainView;
    
    [mainView addSubview:self.SearchBar];
    [self.SearchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.equalTo(@0);
        make.height.equalTo(@(self.SearchBar.height));
    }];
    
    UIView *line=[UIView new];
    line.backgroundColor=RGB(246, 246, 246);
    [mainView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@1);
        make.top.equalTo(self.SearchBar.mas_bottom).offset(0);
    }];
    
    _screeningView = [[ScreeningView alloc]initWithFrame:(CGRectMake(0, 41, FNDeviceWidth-60, 40))];
    _screeningView.backgroundColor  =FNWhiteColor;
    @weakify(self);
    _screeningView.clickedWithType = ^(NSString *type) {
        @strongify(self);
        if ([type isEqualToString:@"shaixuan"]) {
            if ([self.SkipUIIdentifier isEqualToString:@"buy_taobao"]) {
                self.elementview.types = @"仅看天猫";
            }
            if ([self.SkipUIIdentifier isEqualToString:@"buy_jingdong"]) {
                self.elementview.types = @"仅看自营";
            }
            if ([self.SkipUIIdentifier isEqualToString:@"buy_pinduoduo"]) {
                self.elementview.types = @"";
            }
            [FNPopUpTool showViewWithContentView:self.elementview withDirection:(FMPopupAnimationDirectionNone) finished:^{
                UIButton* button  = (UIButton *)[self.screeningView.views lastObject];
                button.selected=NO;
            }];
            return;
        }
        sort=type;
        Pages=1;
        [self requestGoodsList];
    };
    [mainView addSubview:_screeningView];
    
    UIView *line2=[[UIView alloc]init];
    line2.backgroundColor=RGB(246, 246, 246);
    [mainView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@1);
        make.top.equalTo(self.screeningView.mas_bottom).offset(0);
    }];
    
    UIView *Screeningline=[[UIView alloc]init];
    Screeningline.backgroundColor=RGB(246, 246, 246);
    [mainView addSubview:Screeningline];
    [Screeningline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@1);
        make.left.equalTo(self.screeningView.mas_right).offset(0);
        make.top.equalTo(line.mas_bottom).offset(5);
        make.bottom.equalTo(line2.mas_top).offset(-5);
    }];
    
    UIButton *switchBtn=[[UIButton alloc]init];
    switchBtn.selected=YES;
    [switchBtn setImage:IMAGE(@"list_two") forState:UIControlStateNormal];
    [switchBtn setImage:IMAGE(@"list_one") forState:UIControlStateSelected];
    switchBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    switchBtn.imageEdgeInsets=UIEdgeInsetsMake(8, 0, 8, 0);
    [switchBtn addTarget:self action:@selector(switchButton:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:switchBtn];
    [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(5);
        make.bottom.equalTo(line2.mas_top).offset(-5);
        make.left.equalTo(Screeningline.mas_right).offset(0);
        make.right.equalTo(@0);
    }];
    
    OnlyView* Onlyview=[[OnlyView alloc]init];
    Onlyview.backgroundColor=FNWhiteColor;
    Onlyview.leftImage.image=IMAGE(@"list_quan");
    Onlyview.titleLabel.text=@"仅显示优惠券商品";
    Onlyview.Switch.on = yhq;
    [Onlyview.Switch addTarget:self action:@selector(SwitchClickOn:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:Onlyview];
    [Onlyview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.left.right.equalTo(@0);
        make.top.equalTo(line2.mas_bottom).offset(0);
    }];
    self.Onlyview=Onlyview;
    
    UIView *line3=[[UIView alloc]init];
    line3.backgroundColor=RGB(246, 246, 246);
    [mainView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@1);
        make.top.equalTo(Onlyview.mas_bottom).offset(0);
    }];
    
    [self InitCollectionView];
    [self InitTableView];
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark - 加载Collection
-(void)InitCollectionView{
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing=0;
    flowlayout.minimumInteritemSpacing=0;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:(CGRectZero) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=RGB(246, 246, 246);
    self.jm_collectionview.showsHorizontalScrollIndicator = NO;
    self.jm_collectionview.showsVerticalScrollIndicator = NO;
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
//    self.jm_collectionview.hidden=YES;
    [self.jm_collectionview registerClass:[GoodsListTypeOneCell class] forCellWithReuseIdentifier:@"GoodsListTypeOneCell"];
    [self.jm_collectionview registerClass:[FNHomeProductCell class] forCellWithReuseIdentifier:@"HomeViewGoodsCell"];
    [self.jm_collectionview registerClass:[FNHomeProductSingleRowCell class] forCellWithReuseIdentifier:@"HomeViewGoodsSingleCell"];
    
    [self.mainView addSubview:self.jm_collectionview];
    [self.jm_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.Onlyview.mas_bottom).offset(1);
        make.left.right.bottom.equalTo(@0);
    }];
    
    // 下拉刷新
    self.jm_collectionview.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        Pages=1;
        [self requestGoodsList];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.jm_collectionview.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉加载
    self.jm_collectionview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        Pages++;
        [self requestGoodsList];
    }];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.list.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    /*GoodsListTypeOneCell* cell = [GoodsListTypeOneCell cellWithCollectionView:collectionView atIndexPath:indexPath];
    cell.model = self.list[indexPath.row];
    return cell;*/
//    FNBaseProductModel *model = self.list[indexPath.row];
//    FNHomeProductCell *cell = [FNHomeProductCell cellWithCollectionView:collectionView atIndexPath:indexPath];
//    cell.model = model;
////    cell.backgroundColor=[UIColor whiteColor];
//
//    cell.borderColor = FNGlobalTextGrayColor;
//
//    cell.clipsToBounds = YES;
//    cell.sharerightNow = ^(FNBaseProductModel *mod) {
//
//        [self shareProductWithModel:mod];
//
//    };
//    return cell;
    
    FNBaseProductModel *model = self.list[indexPath.row];
    
    if(_singleBool==YES){
        FNHomeProductSingleRowCell *cell = [FNHomeProductSingleRowCell cellWithCollectionView:collectionView atIndexPath:indexPath];
        cell.model = model;
        //                cell.backgroundColor=[UIColor whiteColor];
        cell.sharerightNow = ^(FNBaseProductModel *mod) {
            [self shareProductWithModel:mod];
        };
        cell.clipsToBounds = YES;
        return cell;
    }else{
        FNHomeProductCell *cell = [FNHomeProductCell cellWithCollectionView:collectionView atIndexPath:indexPath];
        cell.model = model;
        //                cell.backgroundColor=[UIColor whiteColor];
        [cell setIsLeft: indexPath.row % 2 == 0];
        cell.borderColor = FNGlobalTextGrayColor;
        cell.clipsToBounds = YES;
        cell.sharerightNow = ^(FNBaseProductModel *mod) {
            [self shareProductWithModel:mod];
        };
        return cell;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    double w=(JMScreenWidth-2)/2;
//    return CGSizeMake(w, w+120);
    if(_singleBool==YES){
        CGFloat singlewidth=140;
        return CGSizeMake(FNDeviceWidth,  singlewidth);
    }else{
        int w = FNDeviceWidth/2;
        CGFloat h = w+110;
        if (indexPath.row % 2 == 1) //防止出现缝隙
            w = FNDeviceWidth - w;
        return CGSizeMake(w, h);
    }
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(2, 0, 2, 0);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self goProductVCWithModel:self.list[indexPath.row] withData: self.list[indexPath.row].data];
}

#pragma mark - 加载Table
-(void)InitTableView{
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.backgroundColor=FNHomeBackgroundColor;
    self.jm_tableview.showsVerticalScrollIndicator = NO;
    self.jm_tableview.hidden = YES;
    [self.jm_tableview removeEmptyCellRows];
    [self.mainView addSubview:self.jm_tableview];
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.Onlyview.mas_bottom).offset(1);
        make.left.right.bottom.equalTo(@0);
    }];
    
    // 下拉刷新
    self.jm_tableview.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        Pages=1;
        [self requestGoodsList];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.jm_tableview.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉加载
    self.jm_tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        Pages++;
        [self requestGoodsList];
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*GoodsListTypeTwoCell *cell=[GoodsListTypeTwoCell cellWithTableView:tableView];
    cell.model = self.list[indexPath.row];
    cell.sharerightNow = ^(FNBaseProductModel *mod) {
        [self shareProductWithModel:mod];
    };
    return cell;*/
    
    return [JMCellTool tableView:tableView atIndexPath:indexPath superVC:self andModel:self.list[indexPath.row]];
    
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FNBaseProductModel *model = self.list[indexPath.row];
    [self goProductVCWithModel:self.list[indexPath.row] withData:model.data];
}

//切换视图
-(void)switchButton:(UIButton *)sender{
    sender.selected=!sender.selected;
//    if (sender.selected==YES) {
//        self.jm_collectionview.hidden=YES;
//        self.jm_tableview.hidden=NO;
//    }else{
//        self.jm_collectionview.hidden=NO;
//        self.jm_tableview.hidden=YES;
//    }
    _singleBool = !_singleBool;
    [self.jm_collectionview reloadData];
}

//仅显示优惠券商品
-(void)SwitchClickOn:(UISwitch *)sender{
    if (sender.on==YES) {
        yhq=1;
    }else{
        yhq=0;
    }
    Pages=1;
    [self requestGoodsList];
}

#pragma mark - 网络请求
//获取商品栏目（淘宝，京东，拼多多那几个大栏目）
- (FNRequestTool *)apiRequestHotSearchHeadColumn{
    @weakify(self)
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"type":@"3"}];
    return [FNRequestTool requestWithParams:params api:_api_home_getType respondType:(ResponseTypeArray) modelType:@"HotSearchHeadColumnModel" success:^(NSArray* respondsObject) {
        @strongify(self)
        self.ColumnArray=respondsObject;
        title=[[NSMutableArray alloc]init];
        [respondsObject enumerateObjectsUsingBlock:^(HotSearchHeadColumnModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [title addObject:obj.name];
            if (self.SkipUIIdentifier==nil) {
                self.SkipUIIdentifier=obj.SkipUIIdentifier;

                if ([obj.is_check integerValue]==1) {
                    self.SkipUIIdentifier=obj.SkipUIIdentifier;
                    ColumnSelectIndex=idx;
                }
            }else{
                if ([obj.SkipUIIdentifier isEqualToString:self.SkipUIIdentifier]) {
                    self.SkipUIIdentifier=obj.SkipUIIdentifier;
                    ColumnSelectIndex=idx;
                }
            }
            
        }];
    } failure:^(NSString *error) {
//        if(selfWeak.ColumnArray.count==0){
//            [self apiRequestHotSearchHeadColumn];
//        }
    } isHideTips:YES];
}
//获取搜排序文字
- (FNRequestTool *)apiRequestSort{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"type":@"shouye"}];
    if(self.SkipUIIdentifier){
        params[@"SkipUIIdentifier"]=self.SkipUIIdentifier;
    }
    NSLog(@"searSkipUIIdentifier:%@",self.SkipUIIdentifier);
    @WeakObj(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appGoodsCate02&ctrl=getSort" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //
        NSMutableArray *name=[[NSMutableArray alloc]init];
        NSMutableArray *type=[[NSMutableArray alloc]init];
        NSMutableArray *image1=[[NSMutableArray alloc]init];
        NSMutableArray *image2=[[NSMutableArray alloc]init];
        NSArray* array = respondsObject[DataKey];
        [selfWeak.SortArr removeAllObjects];
        if (array.count>0) {
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [name addObject:[obj objectForKey:@"name"]];
                [type addObject:[obj objectForKey:@"type"]];
                [image1 addObject:@""];
                [image2 addObject:@""];
                [selfWeak.SortArr addObject:obj];
            }];
        }
        [name addObject:@"筛选"];
        [type addObject:@"shaixuan"];
        [image1 addObject:@"partner_down"];
        [image2 addObject:@"partner_up"];
        [_screeningView setTitles:name images:image1 selectedImage:image2 types:type];
        Pages=1;
        [self requestGoodsList];
    } failure:^(NSString *error) {
//        if(selfWeak.SortArr.count==0){
//            [self apiRequestSort];
//        }
    } isHideTips:YES];
}
//获取商品列表
- (void)requestGoodsList{
    NSInteger pagesize=10;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    params[@"p"]=@(Pages);
    params[@"yhq"]=@(yhq);
    params[@"keyword"]=self.keyword;
    params[@"is_index"]=@(0);
    params[@"SkipUIIdentifier"]=self.SkipUIIdentifier;
    params[@"sort"]=sort;
    params[@"start_price"]=self.elementview.lowprice;
    params[@"end_price"]=self.elementview.highprice;
    if ([self.SkipUIIdentifier isEqualToString:@"buy_taobao"]) {
        params[@"is_tm"]=@(self.elementview.is_tm);
    }
    if ([self.SkipUIIdentifier isEqualToString:@"buy_jingdong"]) {
        params[@"isJdSale"]=@(self.elementview.isJdSale);
    }
    @WeakObj(self);
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appGoods02&ctrl=getgoods" respondType:(ResponseTypeDataKey) modelType:@"" success:^(NSArray *respondsObject) {
        //
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in respondsObject) {
            FNBaseProductModel *model = [FNBaseProductModel mj_objectWithKeyValues:dict];
            model.data = dict;
            [array addObject:model];
        }
        
        [SVProgressHUD dismiss];
        self.mainView.hidden=NO;
        if (Pages==1) {
            [self.list removeAllObjects];
            [self.list addObjectsFromArray:array];
            if (array.count >= pagesize) {
                [self.jm_collectionview.mj_header endRefreshing];
                [self.jm_collectionview.mj_footer endRefreshing];
                [self.jm_tableview.mj_header endRefreshing];
                [self.jm_tableview.mj_footer endRefreshing];
            }else{
                [self.jm_collectionview.mj_header endRefreshing];
                [self.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
                [self.jm_tableview.mj_header endRefreshing];
                [self.jm_tableview.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [self.list addObjectsFromArray:array];
            if (array.count >= pagesize) {
                [self.jm_collectionview.mj_header endRefreshing];
                [self.jm_collectionview.mj_footer endRefreshing];
                [self.jm_tableview.mj_header endRefreshing];
                [self.jm_tableview.mj_footer endRefreshing];
            }else{
                [self.jm_collectionview.mj_header endRefreshing];
                [self.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
                [self.jm_tableview.mj_header endRefreshing];
                [self.jm_tableview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [self.jm_collectionview reloadData];
        [self.jm_tableview reloadData];
    } failure:^(NSString *error) {
//        if(selfWeak.list.count==0){
//            [self requestGoodsList];
//        }
    } isHideTips:YES];
}

@end
