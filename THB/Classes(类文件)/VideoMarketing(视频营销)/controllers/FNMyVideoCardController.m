//
//  FNMyVideoCardController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNMyVideoCardController.h"
#import "FNMyVideoCardListController.h"
#import "FNMyVideoCardBuyController.h"
#import "XYTitleModel.h"

@interface FNMyVideoCardController ()

@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UIButton *rightBtn;
@property (nonatomic, strong) NSMutableArray *titles;

@end

@implementation FNMyVideoCardController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我的卡密";
    // 分类
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
        *titleHeight = 44;
        // 设置标题字体
        *titleFont = kFONT15;
        *selColor  =RGB(102, 102, 102);
        *norColor  =RGB(102, 102, 102);
    }];
    // 分类设置下标）
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
        // 是否显示标签
        *isShowUnderLine = YES;
        // 标题填充模式
        *underLineColor = RGB(249, 104, 70);
        // 是否需要延迟滚动,下标不会随着拖动而改变
        *isDelayScroll = NO;
    }];
    self.isfullScreen = NO;
    self.view.backgroundColor=RGB(245, 245, 245);
    self.titleScrollView.backgroundColor=UIColor.whiteColor;
    [self setupChildVc];
    [self apiRequestMessageCategory];
    [self setupNav];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

-(void)setupNav{
    UIButton *leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [leftBtn setTitleColor:FNBlackColor forState:UIControlStateNormal];
    [leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    [leftBtn sizeToFit];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.size=CGSizeMake(30,  30);
    self.leftBtn=leftBtn;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    UIButton *rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    //    [rightbutton setTitle:@"我的免单" forState:UIControlStateNormal];
    rightbutton.titleLabel.font = kFONT12;
    [rightbutton setTitleColor:RGB(60, 60, 60) forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn=rightbutton;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    if(self.understand==YES){
        self.leftBtn.hidden=YES;
    }
    
}

-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightBtnAction{
    FNMyVideoCardBuyController *vc = [[FNMyVideoCardBuyController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - //setupChildVc 添加子视图
- (void)setupChildVc
{
    //NSArray *titles=@[@"官方消息",@"订单消息"];
    //NSArray *statuArray=@[@"0",@"1"];
    if(self.titles.count>0){
        for (int i = 0 ; i<self.titles.count; i++) {
            XYTitleModel *model=self.titles[i];
            FNMyVideoCardListController *VC = [[FNMyVideoCardListController alloc] init];
            VC.title = model.name;//titles[i];//
            VC.type = model.type;//statuArray[i];
            [self addChildViewController:VC];
        }
        [self refreshDisplay];
        [SVProgressHUD dismiss];
    }
    self.titleScrollView.backgroundColor=[UIColor whiteColor];//RGB(240, 240, 240);
}
#pragma mark - //消息分类
- (FNRequestTool *)apiRequestMessageCategory{
    @weakify(self)
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=app_movie_order&ctrl=cate" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        NSMutableArray *dataArray=[NSMutableArray arrayWithCapacity:0];
        NSString *title = respondsObject[@"title"];
        self.title = title;
        NSString *right_title = respondsObject[@"right_title"];
        [self.rightBtn setTitle:right_title forState:UIControlStateNormal];
        NSArray *titles = [XYTitleModel mj_objectArrayWithKeyValuesArray:respondsObject[@"cate"]] ;
        if (titles.count > 0) {
            [titles enumerateObjectsUsingBlock:^(XYTitleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [dataArray addObject:obj];
            }];
            self.titles=dataArray;
            [self setupChildVc];
        }
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
- (NSMutableArray *)titles{
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}


@end
