//
//  FNHomeHeaderView.m
//  THB
//
//  Created by jimmy on 2017/5/4.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNHomeHeaderView.h"


@interface FNHomeHeaderView ()<MenuCellClickDelegate,SDCycleScrollViewDelegate>
/*
 高度约束 s
 */
@property (nonatomic, strong)NSLayoutConstraint* bannerConsHeight;
@property (nonatomic, strong)NSLayoutConstraint* quickMenuConsHeight;
@property (nonatomic, strong)NSLayoutConstraint* posterImgConsHeight;
@property (nonatomic, strong)NSLayoutConstraint* specialConsHeight;
@property (nonatomic, strong)NSLayoutConstraint* slideBarConsHeight;
@property (nonatomic, assign)CGFloat AllHeight;

@end
@implementation FNHomeHeaderView{
    NSInteger ColumnSelectIndex;
}
#pragma mark- 懒加载
- (UIImageView *)specialbgimgview{
    if (_specialbgimgview == nil) {
        _specialbgimgview = [UIImageView new];
        [_specialbgimgview setUrlImg:[FNBaseSettingModel settingInstance].tw];
    }
    return _specialbgimgview;
}

#pragma mark- 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = FNHomeBackgroundColor;
        [self initializedSubviews];
    }
    return self;
}


#pragma mark - 初始化视图
- (void)initializedSubviews
{
    
    //幻灯片模块
    _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, XYScreenWidth, FNDeviceWidth*0.52) imageNamesGroup:self.bannerArray];
    _bannerView.backgroundColor = FNWhiteColor;
    _bannerView.placeholderImage = DEFAULT;
    _bannerView.delegate=self;
    _bannerView.autoScrollTimeInterval = 5;
    _bannerView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _bannerView.titleLabelTextFont=kFONT17;
    [self addSubview:_bannerView];
    //    [_bannerView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    //    self.bannerConsHeight = [_bannerView autoSetDimension:(ALDimensionHeight) toSize:0];
    
    
    //快速入口模块
    //    _quickMenuView = [[XYQuickMenuView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, _quick_menuH+_quick_pageH))];
    //    _quickMenuView.delegate = self;
    //    _quickMenuView.backgroundColor = FNWhiteColor;
    //
    //    [self addSubview:_quickMenuView];
    //    [_quickMenuView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    
    //    [_quickMenuView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    //    [_quickMenuView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_bannerView];
    //    self.quickMenuConsHeight = [_quickMenuView autoSetDimension:(ALDimensionHeight) toSize:0];
    
    
    //圆形按钮模块
    FNFunctionView *functionview = [[FNFunctionView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, _quick_menuH+_quick_pageH))];
    functionview.backgroundColor=FNWhiteColor;
    functionview.column = 5;
    functionview.row = 2;
    functionview.singleH = _quick_menuH*0.5;
    functionview.scrollview.pagingEnabled=YES;
    
    functionview.btnClickedBlock = ^(NSInteger index) {
        
        if (self.QuickClickedBlock) {
            self.QuickClickedBlock(self.homeModel.index_kuaisurukou_01List[index]);
        }
        
    };
    [self addSubview:functionview];
    self.functionview=functionview;
    
    self.functionbgimgview = [UIImageView new];
    [self.functionbgimgview setUrlImg:[FNBaseSettingModel settingInstance].ksrk];
    [self.functionview insertSubview:self.functionbgimgview atIndex:0];
    [self.functionbgimgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
    //广告模块
    @WeakObj(self);
//    _posterImgView = [[UIImageView  alloc]initWithFrame:CGRectMake(0, 0, JMScreenWidth, 0)];
//    _posterImgView.contentMode = UIViewContentModeScaleAspectFit;
//    [_posterImgView addJXTouch:^{
//        if (selfWeak.PosterClickedBlock) {
//            selfWeak.PosterClickedBlock(selfWeak.posterModel);
//        }
//    }];
//    [self addSubview:_posterImgView];
    
    _adView = [[FNAdView  alloc]initWithFrame:CGRectMake(0, 0, JMScreenWidth, 150)];

    [self addSubview:_adView];
    
    
    //图文模块
    _specialView = [[FNHomeSpecialView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 0.53*FNDeviceWidth))];
    [_specialView insertSubview:self.specialbgimgview atIndex:0];
    _specialView.specialViewClicked = ^(NSInteger index) {
        if (selfWeak.QuickClickedBlock) {
            selfWeak.QuickClickedBlock(selfWeak.homeModel.index_tuwenwei_01List[index]);
        }
    };
    [self addSubview:_specialView];
    //    [_specialView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    //    [_specialView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    //    [_specialView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_posterImgView withOffset:0];
    //    self.specialConsHeight = [_specialView autoSetDimension:(ALDimensionHeight) toSize:0];
    //    [self.specialbgimgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
    
    //商品分栏模块
    _slideBarView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 80)];
    _slideBarView.backgroundColor=FNWhiteColor;
    [self addSubview:_slideBarView];
    //    [_slideBarView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.bottom.equalTo(@0);
    //    }];
    //    self.slideBarConsHeight = [_slideBarView autoSetDimension:(ALDimensionHeight) toSize:80];
    
    UIImageView* img = [[UIImageView alloc]initWithImage:IMAGE(@"home_highRebate")];
    img.contentMode = UIViewContentModeScaleAspectFill;
    img.clipsToBounds = YES;
    [_slideBarView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.centerX.equalTo(_slideBarView.mas_centerX);
        make.height.equalTo(@40);
        make.width.equalTo(@(img.size.width));
    }];
    [img setUrlImg:[FNBaseSettingModel settingInstance].index_cgfjx_ico];
    
    _slideBar = [[FDSlideBar alloc] initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 40)];
    _slideBar.backgroundColor = FNWhiteColor;
    _slideBar.is_middle=YES;
    [_slideBar slideBarItemSelectedCallback:^(NSUInteger index) {
        int idx = 0;
        NSMutableArray* goodsIndexArr=[[NSMutableArray alloc]init];
        
        for (NSDictionary *dict in selfWeak.homeModel.index_goods_01List) {
            
            Index_goods_01Model *goodsModel=[Index_goods_01Model mj_objectWithKeyValues:dict];
            [goodsIndexArr addObject:goodsModel];
            
            if (idx==index) {
                goodsModel.is_check=@"1";
            }else{
                goodsModel.is_check=@"0";
            }
            idx ++;
        }
        //将选中的model传过去
        if (selfWeak.ColumnClickedBlock) {
            selfWeak.ColumnClickedBlock(goodsIndexArr[index]);
        }
    }];
    [_slideBarView addSubview:_slideBar];
    [_slideBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.left.right.bottom.equalTo(@0);
    }];
    
    
    
    //跑马灯模块
    FNScrollmonkeyView *ScrollmonkeyView = [[FNScrollmonkeyView alloc] initWithFrame:CGRectMake(0, 0, JMScreenWidth, 45)];
    ScrollmonkeyView.backgroundColor=FNWhiteColor;
    ScrollmonkeyView.ScrollTextView.textColor = RGBA(102, 102, 102, 102);
    ScrollmonkeyView.Image.image=IMAGE(@"hhorn");
    [self addSubview:ScrollmonkeyView];
    self.FNMarqueeView=ScrollmonkeyView;
    
    
    //秒杀商品模块
    
    
    
    
    //计算高度
    //    [self loadTotalHeight];
    
}


#pragma mark - 设置数据
-(void)setHomeModel:(FNHomeModel *)homeModel{
    _homeModel = homeModel;
    if(_homeModel){
        //设置幻灯片模块数据
        if (homeModel.index_huandengpian_01List.count>0) {
            NSMutableArray* images = [NSMutableArray new];
            for (NSDictionary *dict in homeModel.index_huandengpian_01List) {
                Index_huandengpian_01Model *huandengpianModel=[Index_huandengpian_01Model mj_objectWithKeyValues:dict];
                [images addObject:huandengpianModel.img];
            }
            self.bannerView.autoScroll = images.count >1;
            
            self.bannerView.imageURLStringsGroup = images;
        }
        
        
        //设置快速入口模块数据
        if (homeModel.index_kuaisurukou_01List.count>0) {
            NSMutableArray* images = [NSMutableArray new];
            NSMutableArray* titles = [NSMutableArray new];
            NSMutableArray* font_Colors = [NSMutableArray new];
            
            for (NSDictionary *dict in homeModel.index_kuaisurukou_01List) {
                Index_kuaisurukou_01Model *kuaisurukou=[Index_kuaisurukou_01Model mj_objectWithKeyValues:dict];
                [images addObject:kuaisurukou.img];
                [font_Colors addObject:kuaisurukou.font_color];
                [titles addObject:kuaisurukou.name];
            }
            
            self.functionview.titles = titles;
            self.functionview.images = images;
            self.functionview.font_Colors = font_Colors;
            CGFloat height = 0;
            if (titles.count > 5 && titles.count <=10) {
                height = _quick_menuH;
                self.functionview.column = 5;
                self.functionview.row = 2;
            }else if (titles.count > 10){
                height = _quick_menuH + _quick_pageH;
                self.functionview.column = 5;
                self.functionview.row = 2;
            }else{
                height = _quick_menuH * 0.5;
                self.functionview.row = 1;
                self.functionview.column = titles.count;
                
            }
            self.functionview.height = height;
            
            [self.functionview setBtnviews];
            
            
        }
        
        
        //设置广告模块数据
        if (homeModel.index_threemodel_01List.count>0) {
            NSMutableArray* images = [NSMutableArray new];
            
            for (NSDictionary *dict in homeModel.index_threemodel_01List) {
                Index_threemodel_01Model *threemodel=[Index_threemodel_01Model mj_objectWithKeyValues:dict];
                [images addObject:threemodel.img];
                //
            }
//            [self.posterImgView sd_setImageWithURL:[NSURL URLWithString:images[0]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                self.posterImgView.height=image.size.height/image.size.width*JMScreenWidth;
//
//            }];
            //计算高度
            CGFloat padding = 0;
            
            if (images.count>1) {
                padding = 5;
            }
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:images[0]]];
            
            UIImage *image = [UIImage imageWithData:data];
            CGFloat imgW = (JMScreenWidth-(padding*images.count+padding))/images.count;
            
            _adView.height=image.size.height/image.size.width*imgW+padding*2;

            _adView.imgArr = images;
            
            
        }
        
        
        //设置跑马灯
        [self.FNMarqueeView setSuper_msglist:homeModel.index_paomadeng_01List];
        
        //设置秒杀商品
        
        
        
        //设置图文位
        if (homeModel.index_tuwenwei_01List.count>0) {
            NSMutableArray* tuwenweiArr=[[NSMutableArray alloc]init];
            
            for (NSDictionary *dict in homeModel.index_tuwenwei_01List) {
                MenuModel *tuwenweiModel=[MenuModel mj_objectWithKeyValues:dict];
                [tuwenweiArr addObject:tuwenweiModel];
            }
            _specialView.specialArray = tuwenweiArr;
        }
        
        //设置商品分类
        if (homeModel.index_goods_01List.count>0) {
            int idx = 0;
            NSMutableArray *title=[[NSMutableArray alloc]init];
            for (NSDictionary *dict in homeModel.index_goods_01List) {
                
                Index_goods_01Model *goodsModel=[Index_goods_01Model mj_objectWithKeyValues:dict];
                [title addObject:goodsModel.name];
                if ([goodsModel.is_check integerValue]==1) {
                    ColumnSelectIndex=idx;
                }
                idx ++;
            }
            _slideBar.itemsTitle = title;
            _slideBar.itemColor = FNGlobalTextGrayColor;
            _slideBar.itemSelectedColor = FNMainGobalTextColor;
            _slideBar.sliderColor = FNMainGobalTextColor;
            _slideBar.fontSize=13;
            _slideBar.SelectedfontSize=14;
            [_slideBar selectSlideBarItemAtIndex:ColumnSelectIndex];
            
        }
        [self setConstrainInView];
        
    }
}




#pragma mark - 重新布局
-(void)setConstrainInView{
    //先将所有视图隐藏，后面再根据后台要求显示
    self.bannerView.hidden = YES;
    self.functionview.hidden = YES;
    self.posterImgView.hidden = YES;
    self.adView.hidden = YES;
    self.specialView.hidden = YES;
    self.slideBarView.hidden=YES;
    self.FNMarqueeView.hidden = YES;
    self.FNSpecialGoodsView.hidden = YES;
    
    //给视图设置Y值
    _AllHeight=0;
    
    for (int i=0; i<_homeModel.TypeArr.count; i++) {
        
        
        UIView *paibanView=[_homeModel.TypeDic objectForKey:_homeModel.TypeArr[i]];
        
        XYLog(@"self.homeModel.TypeDic %@,self.homeModel.TypeArr %@",_homeModel.TypeDic,_homeModel.TypeArr[i]);
        
        if (i==0) {
            paibanView.y=0;
            [_homeModel.TypeDic setObject:paibanView forKey:_homeModel.TypeArr[i]];
        }else{
            UIView *shangpaibanView=[_homeModel.TypeDic objectForKey:_homeModel.TypeArr[i-1]];
            paibanView.y=shangpaibanView.frame.origin.y+shangpaibanView.frame.size.height+[_homeModel.jiangeArr[i-1] floatValue];
            [_homeModel.TypeDic setObject:paibanView forKey:_homeModel.TypeArr[i]];
            XYLog(@"shangpaibanView is %@",shangpaibanView);
            
        }
        
        paibanView.hidden=NO;
        _AllHeight+=paibanView.height+[_homeModel.jiangeArr[i] floatValue];
        XYLog(@"paibanView.height is %.f",paibanView.height);
        
    }
    for (UIView *subView in self.subviews) {
        NSLog(@"subView is %@",subView);
        
    }
    if (self.RefreshFrameBlock) {
        self.RefreshFrameBlock(_AllHeight);
    }
    
    
}




#pragma mark - 点击事件方法
/**
 快速入口点击方法
 
 @param index 位置
 */
-(void)OnTapMenuView:(NSInteger )index{
    if (self.QuickClickedBlock) {
        self.QuickClickedBlock(self.quickArray[index]);
    }
}

#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (self.BannerClickedBlock) {
        self.BannerClickedBlock(index);
    }
}



//旧版注释代码
//- (void)setQuickArray:(NSArray <MenuModel *>*)quickArray{
//    _quickArray = quickArray;
//    if (_quickArray.count > 0) {
//        _quickMenuView.menuModelArray = _quickArray;
//        CGFloat height = 0;
//        if (_quickArray.count >= 6 && _quickArray.count <=10) {
//            height = _quick_menuH;
//        }else if (_quickArray.count > 10){
//            height = _quick_menuH + _quick_pageH;
//        }else{
//            height = _quick_menuH * 0.5;
//        }
//        self.quickMenuConsHeight.constant = height;
//        self.quickMenuView.hidden = NO;
//    }else{
//        self.quickMenuConsHeight.constant = 0;
//        self.quickMenuView.hidden = YES;
//    }
//    [self loadTotalHeight];
//
//}
//- (void)setBannerArray:(NSArray *)bannerArray{
//    _bannerArray = bannerArray;
//    if (_bannerArray.count> 0) {
//        _bannerView.autoScroll = _bannerArray.count >1;
//        _bannerView.imageURLStringsGroup = _bannerArray;
//        self.bannerConsHeight.constant = FNDeviceWidth*0.52;
//        self.bannerView.hidden = NO;
//    }else{
//        self.bannerConsHeight.constant = 0;
//        self.bannerView.hidden = YES;
//    }
//    [self loadTotalHeight];
//
//}
//- (void)setPosterModel:(MenuModel *)posterModel{
//    _posterModel = posterModel;
//    @WeakObj(self);
//    [_posterImgView sd_setImageWithURL:URL(_posterModel.img) placeholderImage:IMAGE(@"") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (image) {
//            selfWeak.posterImgConsHeight.constant = FNDeviceWidth*image.size.height/image.size.width;
//            selfWeak.height = selfWeak.bannerConsHeight.constant
//            +selfWeak.quickMenuConsHeight.constant
//            +selfWeak.posterImgConsHeight.constant
//            +selfWeak.specialConsHeight.constant;
//            //            if (selfWeak.RefreshFrameBlock) {
//            //                selfWeak.RefreshFrameBlock();
//            //            }
//        }
//    }];
//    self.posterImgView.hidden = NO;
//    [self loadTotalHeight];
//}
//- (void)setSpecialArray:(NSArray<MenuModel *> *)specialArray{
//    _specialArray = specialArray;
//    if (_specialArray.count> 0) {
//        _specialView.specialArray = _specialArray;
//        self.specialConsHeight.constant = 0.53*FNDeviceWidth;
//        self.specialView.hidden = NO;
//    }else{
//        self.specialConsHeight.constant = 0;
//        self.specialView.hidden = YES;
//    }
//
//    [self loadTotalHeight];
//}
//-(void)setColumnArray:(NSArray<HotSearchHeadColumnModel *> *)ColumnArray{
//    _ColumnArray = ColumnArray;
//    if (_ColumnArray.count> 0) {
//        NSMutableArray *title=[[NSMutableArray alloc]init];
//        [ColumnArray enumerateObjectsUsingBlock:^(HotSearchHeadColumnModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [title addObject:obj.name];
//            if ([obj.is_check integerValue]==1) {
//                ColumnSelectIndex=idx;
//            }
//        }];
//        _slideBar.itemsTitle = title;
//        _slideBar.itemColor = FNGlobalTextGrayColor;
//        _slideBar.itemSelectedColor = FNMainGobalTextColor;
//        _slideBar.sliderColor = FNMainGobalTextColor;
//        _slideBar.fontSize=13;
//        _slideBar.SelectedfontSize=14;
//        [_slideBar selectSlideBarItemAtIndex:ColumnSelectIndex];
//        self.slideBarConsHeight.constant = 80;
//        self.slideBar.hidden = NO;
//    }else{
//        self.slideBarConsHeight.constant = 40;
//        self.slideBar.hidden = YES;
//    }
//
//    [_slideBarView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@(self.slideBarConsHeight.constant));
//    }];
//
//    [self loadTotalHeight];
//}
//
//
//-(void)loadTotalHeight{
//    self.height = self.bannerConsHeight.constant + self.quickMenuConsHeight.constant +self.posterImgConsHeight.constant +self.specialConsHeight.constant+self.slideBarConsHeight.constant+5;
//
//}

@end

