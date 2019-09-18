//
//  TBRebatesViewController.m
//  THB
//
//  Created by zhongxueyu on 16/3/24.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "TBRebatesViewController.h"
#import "SizeMacros.h"
#import "keywordModel.h"
#import "secondViewController.h"
#import "NSString+KRKit.h"
#import "JMTutorialController.h"
@interface TBRebatesViewController ()<UITextFieldDelegate>
/** 最下层的ScrollView */
@property (nonatomic,strong) UIScrollView *scrollView;

/** 搜索输入框 */
@property (nonatomic,strong) UITextField *keywordTF;

/** 搜索按钮 */
@property (nonatomic,strong) UIButton *searchBtn;

/** 展开箭头按钮 */
@property (nonatomic,strong) UIButton *expandBtn;

/** 热搜视图 */
@property (nonatomic,strong) UIView *hotView;

/** 热搜按钮 */
@property (nonatomic,strong) UIButton *hotBtn;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation TBRebatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"淘宝";
    // Do any additional setup after loading the view.
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight-XYTabBarHeight)];
    if (XYScreenHeight<568) {
        _scrollView.contentSize = CGSizeMake(XYScreenWidth,568);
    }
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    [self loadProductListMethod];
    
    UIButton *tutorialBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [tutorialBtn setImage:IMAGE(@"rebate_tutorial") forState:UIControlStateNormal];
    [tutorialBtn setTitleColor:FNGlobalTextGrayColor forState:UIControlStateNormal];
    [tutorialBtn setTitle:@"  教程" forState:UIControlStateNormal];
    tutorialBtn.titleLabel.font = kFONT14;
    [tutorialBtn sizeToFit];
    [tutorialBtn addTarget:self action:@selector(tutorialBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:tutorialBtn];
    
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
                
            }
            [SVProgressHUD dismiss];
        }
        else{
            
            
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        
        
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
    }];
    
}


-(void)initView:(NSArray *)array{
    CGFloat imgH = 40;
    //头部背景图片
    UIView *headBgView;
    if (XYScreenWidth<375) {
        headBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, 127)];
        UIImage  *backgroudImage = IMAGE(@"shopping_bg");
        headBgView.backgroundColor=[UIColor colorWithPatternImage:backgroudImage] ;
    }else{
        headBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, 177)];
        UIImage  *backgroudImage = IMAGE(@"shopping_bg_177");
        headBgView.backgroundColor=[UIColor colorWithPatternImage:backgroudImage] ;
    }
    
    
    [_scrollView addSubview:headBgView];
    
    //第一行Lable
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(XYScreenWidth/2-50, 15, 100, 30)];
    lable1.text = @"搜索淘宝商品";
    lable1.textColor = [UIColor whiteColor];
    lable1.font =kFONT15;
    [headBgView addSubview:lable1];
    
    //第二行Lable
    UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(XYScreenWidth/2-70, CGRectGetMaxY(lable1.frame), 140, 30)];
    NSString *str  = [FNBaseSettingModel settingInstance ].app_gmfl_bili ;
    lable2.text = [NSString stringWithFormat:@"购物最高返利%@%%",(str!= nil && str.length != 0)?str:@"80"];
    lable2.font =kFONT15;
    lable2.textColor = [UIColor whiteColor];
    [headBgView addSubview:lable2];
    CGFloat bgMargin;
    XYLog(@"XYScreenHeight is %f",XYScreenHeight);
    if (XYScreenHeight<667) {
        bgMargin = 0;
    }else{
        bgMargin = 20;
    }
    //输入框背景
    UIImageView *tfBgImg = [[UIImageView alloc]initWithFrame:CGRectMake(_jm_leftMargin, CGRectGetMaxY(lable2.frame)+bgMargin, XYScreenWidth - _jm_leftMargin*2-60,imgH)];
    tfBgImg.image = IMAGE(@"taobao_bar");
    tfBgImg.userInteractionEnabled = YES;
    [headBgView addSubview:tfBgImg];
    
    //搜索图标
    UIImageView *search = [[UIImageView alloc]initWithFrame:CGRectMake(12, 10, 21, 21)];
    search.image = IMAGE(@"cgf_search");
    [tfBgImg addSubview:search];
    
    //输入框
    _keywordTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(search.frame)+10, 0, CGRectGetWidth(tfBgImg.frame)-CGRectGetWidth(search.frame)-22, CGRectGetHeight(tfBgImg.frame))];
    _keywordTF.placeholder = @"输入淘宝商品标题或关键字";
    _keywordTF.font = kFONT15;
    _keywordTF.returnKeyType = UIReturnKeySearch;//变为搜索按钮
    _keywordTF.delegate = self;//设置代理

    _keywordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [tfBgImg addSubview:_keywordTF];
    
    //搜索按钮
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tfBgImg.frame), CGRectGetMinY(tfBgImg.frame), 60, imgH)];
    [searchBtn setBackgroundImage:IMAGE(@"taobao_btn") forState:UIControlStateNormal];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(clickToSearchWithKeyword:) forControlEvents:UIControlEventTouchUpInside];
    [headBgView addSubview:searchBtn];
    
    //中间的View
    UIView *midView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headBgView.frame), XYScreenWidth, 40)];
    [midView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lableClick:)]];
    [_scrollView addSubview:midView];
    //中间lable
    UILabel *midLable = [[UILabel alloc]initWithFrame:CGRectMake(_jm_leftMargin, 5, 100, 30)];
    midLable.text = @"拿返利小贴士";
    midLable.font =kFONT15;
    midLable.userInteractionEnabled = YES;
    [midLable addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lableClick:)]];
    midLable.textColor = [UIColor blackColor];
    [midView addSubview:midLable];
    
    //中间教程lable
    UILabel *midLable2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(midLable.frame), CGRectGetMinY(midLable.frame)+2, 140, 30)];
    midLable2.text = @"详细教程";
    midLable2.font =kFONT13;
    
    midLable2.textColor = RED;
    midLable2.userInteractionEnabled = YES;
    
//    [midView addSubview:midLable2];
    
    //    //展开箭头按钮
    //    _expandBtn = [[UIButton alloc]initWithFrame:CGRectMake(XYScreenWidth-30, CGRectGetMinY(midLable2.frame)+7, 15, 8)];
    //    [_expandBtn setBackgroundImage:IMAGE(@"cgf_down") forState:UIControlStateNormal];
    //    [_expandBtn setBackgroundImage:IMAGE(@"cgf_up") forState:UIControlStateSelected];
    //    [_expandBtn addTarget:self action:@selector(expandBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    //    [midView addSubview:_expandBtn];
    
    //分割线
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(midView.frame)-1, XYScreenWidth, 1)];
    line.image = IMAGE(@"member_line1");
    [midView addSubview:line];
    
    CGFloat detailImgH ;
    if (XYScreenWidth < 375) {
        detailImgH = 64;
    }else{
        detailImgH = 80;
    }
    //返利教程
    UIImageView *detailImg = [[UIImageView alloc]initWithFrame:CGRectMake(_jm_leftMargin, CGRectGetMaxY(midView.frame)+10, XYScreenWidth-_jm_leftMargin*2, detailImgH)];
    detailImg.image = IMAGE(@"shopping_3foot");
    [_scrollView addSubview:detailImg];
    
    //热搜视图
    CGFloat hotBtnH = (array.count/3+1)*37+50;
    _hotView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(detailImg.frame)+15, XYScreenWidth, hotBtnH)];
    [_scrollView addSubview:_hotView];
    
    //灰色的背景
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, 7)];
    grayView.backgroundColor = RGB(238, 238, 238);
    [_hotView addSubview:grayView];
    //热门搜索lable
    UILabel *hotLable = [[UILabel alloc]initWithFrame:CGRectMake(_jm_leftMargin, CGRectGetMaxY(grayView.frame)+6, 100, 28)];
    hotLable.text = @"热门搜索";
    hotLable.font =kFONT16;
    hotLable.textColor = [UIColor blackColor];
    [_hotView addSubview:hotLable];
    
    //分割线
    UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hotLable.frame)+7, XYScreenWidth, 1)];
    line2.image = IMAGE(@"member_line1");
    [_hotView addSubview:line2];
    CGFloat leftMargin = _jm_leftMargin-4;
    
    UIView *hotBtnBg = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line2.frame)+10, XYScreenWidth, (array.count/3+1)*37)];
    hotBtnBg.userInteractionEnabled = YES;
    //    hotBtnBg.backgroundColor = RED;
    [_hotView addSubview:hotBtnBg];
    XYLog(@"W is %f",XYScreenWidth);
    for (int i = 0; i<array.count; i++) {
//        if (i<9) {
            CGFloat btnW = XYScreenWidth/3-10;
            CGFloat btnH = 27;
            CGFloat btnX ;
            CGFloat btnY;
            btnY = i/3*btnH+(i/3)*10;
            btnX = (i-((i/3)*3))*btnW+leftMargin+(i-(i/3)*3)*5;
            _hotBtn = [[UIButton alloc]initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
            _hotBtn.tag = i;
            [_hotBtn setBackgroundImage:IMAGE(@"shopping_btns") forState:UIControlStateNormal];
            [_hotBtn setTitleColor:RGB(77, 77, 77) forState:UIControlStateNormal];
            [_hotBtn setTitleColor:RGB(226, 104, 98) forState:UIControlStateHighlighted];
            _hotBtn.titleLabel.font = kFONT13;
            
            [_hotBtn setTitle:array[i] forState:UIControlStateNormal];
            [_hotBtn addTarget:self action:@selector(hotBtnClickBtn:) forControlEvents:UIControlEventTouchUpInside];
            [hotBtnBg addSubview:_hotBtn];
//        }
       
    }
    _scrollView.contentSize = CGSizeMake(XYScreenWidth,CGRectGetMaxY(_hotView.frame)+array.count/3*17);

    
    
    
}

//在代理方法中实现你想要的点击操作就可以了
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"点击了搜索");
    if ([self.keywordTF.text kr_isNotEmpty]) {
        ProductListViewController *vc = [[ProductListViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.searchTitle = self.keywordTF.text;
//        vc.type = 1;
        vc.categoryID = @"";
        
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [FNTipsView showTips:@"请输入商品关键词~"];
    }
    return YES;
}
//热门搜索按钮点击方法
-(void)hotBtnClickBtn:(UIButton *)sender
{
    ProductListViewController *vc = [[ProductListViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.searchTitle = sender.titleLabel.text;
//    vc.type = 1;
    vc.categoryID = @"";
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)tutorialBtnAction:(id)btn{
    JMTutorialController* tutorial = [JMTutorialController new];
    tutorial.tutorialType = TutorialTypeTaoBao;
    [self.navigationController pushViewController:tutorial animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)expandBtnMethod:(UIButton *)sender
{
    XYLog(@"expandBtn");
}

-(void)clickToSearchWithKeyword:(UIButton *)sender
{
    if ([self.keywordTF.text kr_isNotEmpty]) {
        [self getUrlMethod];
    }else{
        [FNTipsView showTips:@"请输入商品关键词~"];
    }
    
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

#pragma 获取数据
-(void)getUrlMethod
{
    
    ProductListViewController *vc = [[ProductListViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.searchTitle = self.keywordTF.text;
    vc.type = 1;
    vc.categoryID = @"";
    [self.keywordTF becomeFirstResponder];

    [self.navigationController pushViewController:vc animated:YES];
    //    //将中文转码避免白屏
    //    NSString *keyword = [self encodeToPercentEscapeString:self.keywordTF.text];

//    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"token":UserAccessToken,
//                                                                                 @"time":[NSString GetNowTimes],
//                                                                                 @"keyword":keyword}];
//    param[SignKey] = [NSString getSignStringWithDictionary:param];
    //    [SVProgressHUD show];
    //    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_shoprebate_gettaobaoUrl successBlock:^(id responseBody) {
    //
    //        NSDictionary *dict = responseBody;
    //        XYLog(@"responseBody2 is %@",responseBody);
    //        if ([[dict objectForKey:XYSuccess]  isEqual: @1]) {
    //
    //            NSString *url = [dict objectForKey:XYData];
    //
    //            XYLog(@"url is %@",url);
    //            TBWebViewViewController *vc = [[TBWebViewViewController alloc]init];
    //            vc.hidesBottomBarWhenPushed = YES;
    //            vc.navigationController.navigationBarHidden = NO;
    //            vc.url = url;
    //            [self.navigationController pushViewController:vc animated:YES];
    //            [SVProgressHUD dismiss];
    //        }else{
    //
    //            [XYNetworkAPI queryFinishTip:dict];
    //            [XYNetworkAPI cancelAllRequest];
    //        }
    //
    //
    //    } failureBlock:^(NSString *error) {
    //
    //        [XYNetworkAPI cancelAllRequest];
    //    }];
    
}

//详细教程
-(void)lableClick:(UITapGestureRecognizer *)tap
{
    self.navigationController.navigationBarHidden  = NO;
    secondViewController *secondVC = [[secondViewController alloc]init];
    NSString *url = [NSString stringWithFormat:@"%@%@",IP,_api_mine_course];
    secondVC.url = url;
    secondVC.navigationController.navigationBarHidden = NO;
    secondVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:secondVC animated:YES];
}
@end
