//
//  SearchViewController.m
//  THB
//
//  Created by zhongxueyu on 16/4/5.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有 2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "SearchViewController.h"
#import "SizeMacros.h"
#import "keywordModel.h"
#import "ProductListViewController.h"
#import "DetailsTutorialViewController.h"
#import "secondViewController.h"
#import "NSString+KRKit.h"
#import "UIView+KRKit.h"
#define MARGIN 15
@interface SearchViewController ()<UITextFieldDelegate>


/** HeadView */
@property (nonatomic,strong) UIView *HeadView;

/** 搜索输入框背 */
@property (nonatomic,strong) UITextField *keywordTF;

/** 搜索输入框右边的关闭按钮 */
@property (nonatomic,strong) UIButton *closeBtn;

/** 搜索按钮 */
@property (nonatomic,strong) UIButton *searchBtn;

/** 热搜按钮 */
@property (nonatomic,strong) UIButton *hotBtn;

/** 热搜视图 */
@property (nonatomic,strong) UIView *hotView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadProductListMethod];
    
    if (self.keywords && self.keywords.length>=1) {
        
    }
    
}
#pragma 获取数据
-(void)loadProductListMethod
{
    [SVProgressHUD show];
    NSMutableArray *nameArray = [NSMutableArray array];
    [[XYNetworkAPI sharedManager] postResultWithParameter:[NSString GetParamDic] url:_api_home_getkeyword successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
        
        XYLog(@"responseBody2 is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            [self.dataArray removeAllObjects];
            NSArray *tempArray = [dict objectForKey:XYData];
            
            if (tempArray) {
                for (int i = 0; i < tempArray.count; i ++) {
                    keywordModel *model = [keywordModel mj_objectWithKeyValues:tempArray[i]];
                    [self.dataArray addObject:model];
                    [nameArray addObject:model.name];
                }
                [self initView:nameArray];
                [SVProgressHUD dismiss];
            }
            
        }
        else{
            
            
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        
        
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
    }];
    
}
-(void)LeftBtnMethod:(UIButton *)sender
{
    NSArray * ctrlArray = self.navigationController.viewControllers;

    [self.navigationController popToViewController:[ctrlArray objectAtIndex:0] animated:YES];

}
-(void)initView:(NSArray *)array{
    //头部
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, XYStatusBarHeight, XYScreenWidth, JMNavBarHeigth)];
    _HeadView = headView;
    [self.view addSubview:_HeadView];
    UIButton *leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setImage: [UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    leftbutton.frame=CGRectMake(MARGIN-5, MARGIN*2, 20, 18);
    leftbutton.centerY = isIphoneX ? 64: 44;
    [leftbutton addTarget:self action:@selector(LeftBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:leftbutton];
    
    //搜索框
    UIImageView *titleView=[[UIImageView alloc]initWithFrame:CGRectMake(MARGIN*2+10, CGRectGetMinY(leftbutton.frame)-5, XYScreenWidth-MARGIN*2-15-40, 28)];
    titleView.image=[UIImage imageNamed:@"goodbg"];
    titleView.userInteractionEnabled = YES;
    [headView addSubview:titleView];
    UIImageView *search = [[UIImageView alloc]initWithFrame:CGRectMake(12, 5, 21, 21)];
    search.image = IMAGE(@"cgf_search");
    [titleView addSubview:search];
    //搜索按钮
    _searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleView.frame)+10, CGRectGetMinY(titleView.frame), 30, 30)];
    [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [_searchBtn setTitleColor:RGB(94, 94, 94) forState:UIControlStateNormal];
    _searchBtn.tag = 100;
    [_searchBtn addTarget:self action:@selector(ClickToSearchMethod:) forControlEvents:UIControlEventTouchUpInside];
    _searchBtn.titleLabel.font = kFONT14;
    [headView addSubview:_searchBtn];
    
    //输入框
    _keywordTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(search.frame)+10, 0, CGRectGetWidth(titleView.frame)-CGRectGetWidth(_searchBtn.frame)-10, CGRectGetHeight(titleView.frame))];
    _keywordTF.placeholder = @"输入商品关键字";
    self.keywordTF.delegate = self;
    _keywordTF.font = kFONT14;
    _keywordTF.returnKeyType = UIReturnKeySearch;//变为搜索按钮
    _keywordTF.delegate = self;//设置代理
    _keywordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [titleView addSubview:_keywordTF];
    //    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnTapTitleView:)];
    //    [titleView addGestureRecognizer:tap];
    //    [self.keywordTF becomeFirstResponder];
    //搜索框上的关闭按钮
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_keywordTF.frame), 7, 14, 14)];
    [closeBtn setBackgroundImage:IMAGE(@"close") forState:UIControlStateNormal];
    [closeBtn setBackgroundImage:IMAGE(@"gwc_close") forState:UIControlStateHighlighted];
    _closeBtn = closeBtn;
    //    [titleView addSubview:_closeBtn];
    
    
    
    
    //分割线
    UIImageView *lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame)+8, XYScreenWidth, 1)];
    lineImg.image = IMAGE(@"member_line1");
    [headView addSubview:lineImg];
    
    //热搜视图
    CGFloat addH ;
    if (array.count%3>0) {
        addH = 1;
    }else{
        addH = 0;
    }
    CGFloat hotViewH = array.count/3*47+addH*47;
    _hotView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_HeadView.frame), XYScreenWidth, hotViewH)];
    [self.view addSubview:_hotView];
    
    //热门搜索lable
    UIImageView *hotIcon = [[UIImageView alloc]initWithFrame:CGRectMake(LeftSpace-2, 7, 15, 15)];
    hotIcon.image = IMAGE(@"HOT_icon");
    [_hotView addSubview:hotIcon];
    UILabel *hotLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(hotIcon.frame)+7, 0, 100, 28)];
    hotLable.text = @"热门搜索";
    hotLable.font =kFONT14;
    hotLable.textColor = RGB(77, 77, 77);
    [_hotView addSubview:hotLable];
    
//    UIView *hotBtnBg = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hotLable.frame)+5, XYScreenWidth, array.count/3*47)];
//    [_hotView addSubview:hotBtnBg];
    CGFloat leftMargin = LeftSpace-4;
    //    NSArray *array = [NSArray arrayWithObjects:@"手机",@"连衣裙",@"女包",@"男鞋",@"风衣",@"打底衫",@"平板电脑",@"手提电脑",@"雪纺衫", nil];
    for (int i = 0; i<array.count; i++) {
        CGFloat btnW = XYScreenWidth/3-10;
        CGFloat btnH = 27;
        CGFloat btnX ;
        CGFloat btnY;
        btnY = (i/3*btnH+(i/3)*10)+CGRectGetMaxY(hotLable.frame)+5;
        btnX = (i-((i/3)*3))*btnW+leftMargin+(i-(i/3)*3)*5;
        
        
        _hotBtn = [[UIButton alloc]initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        _hotBtn.tag = i;
        
        [_hotBtn setTitleColor:RGB(77, 77, 77) forState:UIControlStateNormal];
        _hotBtn.titleLabel.font = kFONT13;
        [_hotBtn setTitle:array[i] forState:UIControlStateNormal];
        keywordModel *model = self.dataArray[i];
        if ([model.highlight isEqualToString:@"1"]) {
            
            [_hotBtn setBackgroundImage:IMAGE(@"HOT") forState:UIControlStateNormal];
        }else{
            
            [_hotBtn setBackgroundImage:IMAGE(@"search_btn") forState:UIControlStateNormal];
        }
        [_hotBtn addTarget:self action:@selector(hotBtnClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_hotView addSubview:_hotBtn];
    }
    
    //返利教程
    CGFloat lableW = 120;
    UILabel *midLable = [[UILabel alloc]initWithFrame:CGRectMake(XYScreenWidth/2-lableW/2, CGRectGetMaxY(_hotView.frame)+10, lableW, 30)];
    midLable.adjustsFontSizeToFitWidth = YES;
    NSString* text =  @"3步轻松赚积分,拿返利";
#if APP_YWXJ == 1
    text = @"3步轻松赚积分,拿佣金";
#endif
    midLable.text = text;
    midLable.font =kFONT17;
    midLable.textColor = RGB(137, 137, 137);
    [self.view addSubview:midLable];
    
    //中间教程lable
    UILabel *midLable2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(midLable.frame), CGRectGetMinY(midLable.frame)+2, 140, 30)];
    midLable2.text = @"详细教程";
    midLable2.font =kFONT13;
    midLable2.textColor = RED;
    midLable2.userInteractionEnabled = YES;
    [midLable2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lableClick:)]];
    [self.view addSubview:midLable2];
    
    CGFloat detailImgH ;
    if (XYScreenWidth < 375) {
        detailImgH = JMNavBarHeigth;
    }else{
        detailImgH = 80;
    }
    //返利教程图片
    UIImageView *detailImg = [[UIImageView alloc]initWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(midLable.frame)+10, XYScreenWidth-LeftSpace*2, detailImgH)];
    detailImg.image = IMAGE(@"shopping_3foot");
#if APP_YWXJ == 1
    detailImg.image = IMAGE(@"ywjx_shopping_3foot");
    
#endif
    [self.view addSubview:detailImg];
    
    
}

//搜索按钮
-(void)ClickToSearchMethod:(UIButton *)sender
{
    //    else{
    if ([self.keywordTF.text kr_isNotEmpty]) {
        if (self.type == 1) {
            //创建通知
            NSDictionary *dataDict = [NSDictionary dictionaryWithObjectsAndKeys:self.keywordTF.text,@"keyword", nil];
            NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dataDict];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [self.navigationController popViewControllerAnimated:YES];
        }else if (self.type == 2){
            ProductListViewController *vc = [[ProductListViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.searchTitle = self.keywordTF.text;
            vc.type = 1;
            vc.categoryID = @"";
            
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            ProductListViewController *vc = [[ProductListViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.searchTitle = self.keywordTF.text;
            vc.type = 1;
            vc.categoryID = @"";
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else{
        [FNTipsView showTips:@"请输入想要搜索的关键词~"];
        [self.keywordTF kr_shake];
    }
    //    }
}

//在代理方法中实现你想要的点击操作就可以了
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"点击了搜索");
    if ([self.keywordTF.text kr_isNotEmpty]) {
        ProductListViewController *vc = [[ProductListViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.searchTitle = self.keywordTF.text;
        vc.type = 1;
        vc.categoryID = @"";
        
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [FNTipsView showTips:@"请输入商品关键词~"];
    }
    return YES;
}


//详细教程
-(void)lableClick:(UITapGestureRecognizer *)tap
{
    secondViewController *secondVC = [[secondViewController alloc]init];
    NSString *url = [NSString stringWithFormat:@"%@%@",IP,_api_mine_course];
    secondVC.navigationController.navigationBarHidden = NO;
    secondVC.url = url;
    [self.navigationController pushViewController:secondVC animated:YES];
}

- (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    NSString *outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                       NULL, /* allocator */
                                                                                       (__bridge CFStringRef)input,
                                                                                       NULL, /* charactersToLeaveUnescaped */
                                                                                       (CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8);
    return
    outputStr;
}

//热门搜索按钮点击方法
-(void)hotBtnClickBtn:(UIButton *)sender
{
    if (self.type == 1 || self.type == 2) {
        ProductListViewController *vc = [[ProductListViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.searchTitle = sender.titleLabel.text;
        vc.categoryID = @"";
        
        vc.type = 1;
        [self.navigationController pushViewController:vc animated:YES];
        XYLog(@"tag is %ld",(long)sender.tag);
    }else{
        //        //将中文转码避免白屏
        //        NSString *keyword = [self encodeToPercentEscapeString:sender.titleLabel.text];
        //        XYLog(@"tag is %ld",(long)sender.tag);
//        NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"token":UserAccessToken,
//                                                                                     @"time":[NSString GetNowTimes],
//                                                                                     @"keyword":keyword}];
//        param[SignKey] = [NSString getSignStringWithDictionary:param];
        //        [SVProgressHUD show];
        //        [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_shoprebate_gettaobaoUrl successBlock:^(id responseBody) {
        //
        //            NSDictionary *dict = responseBody;
        //            XYLog(@"responseBody2 is %@",responseBody);
        //            if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
        //
        //                NSString *url = [dict objectForKey:XYData];
        //
        //                XYLog(@"url is %@",url);
        //                TBWebViewViewController *vc = [[TBWebViewViewController alloc]init];
        //                vc.hidesBottomBarWhenPushed = YES;
        //                vc.url = url;
        //                [self.navigationController pushViewController:vc animated:YES];
        //                [SVProgressHUD dismiss];
        //            }else{
        //
        //                [XYNetworkAPI queryFinishTip:dict];
        //                [XYNetworkAPI cancelAllRequest];
        //            }
        //
        //
        //        } failureBlock:^(NSString *error) {
        //
        //            [XYNetworkAPI cancelAllRequest];
        //        }];
        
        ProductListViewController *vc = [[ProductListViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.searchTitle = sender.titleLabel.text;
        vc.categoryID = @"";
        vc.type = 1;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = NO;
    
    if (iOS7) { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    }
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self.keywordTF becomeFirstResponder];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar cnReset];
    [self.keywordTF resignFirstResponder];
}
#pragma mark -Getter
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
