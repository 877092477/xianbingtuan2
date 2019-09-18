//
//  FNArrangesingleAeController.m
//  THB
//
//  Created by 李显 on 2019/1/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNArrangesingleAeController.h"
//controller
#import "FNarrangeItemAeController.h"
//view
#import "FNCustomeNavigationBar.h"
//model
#import "XYTitleModel.h"
@interface FNArrangesingleAeController ()
@property(nonatomic,strong) NSMutableArray *ClassifyArr;
@property(nonatomic,strong) FNCustomeNavigationBar* cuNaivgationbar;
@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UIButton *rightBtn;
@property(nonatomic,strong) UIImageView *TopImageView;
@property(nonatomic,strong) UIImageView *titleScrollBg;
@property(nonatomic,strong) NSString *bgimgUrl;
@end

@implementation FNArrangesingleAeController
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
    
    //分类
    [self apiRequstClassify];
    self.isfullScreen = NO;
    [self setupNav];
}

//排行榜头部数据
- (void)apiRequstClassify{
    @WeakObj(self);
    NSMutableDictionary*params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection_phb&ctrl=phb_top" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSDictionary *dictry=respondsObject[DataKey];
        selfWeak.bgimgUrl=dictry[@"bg_img"];
        NSMutableArray *dataArray=[NSMutableArray arrayWithCapacity:0];
        NSArray *titles = dictry[@"list"];
        NSString *catestr_color=dictry[@"font_color"];
        NSString *catestr_color1=dictry[@"font_color"];
        NSString *titleName=dictry[@"title"];
        if([titleName kr_isNotEmpty]){
            selfWeak.cuNaivgationbar.titleLabel.text=titleName;
        }
        if (titles.count > 0) {
            [titles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [dataArray addObject:[XYTitleModel mj_objectWithKeyValues:obj]];
            }];
            selfWeak.ClassifyArr=dataArray;
        }
        [selfWeak setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
            *titleHeight = 35;
            // 设置标题字体
            *titleFont = kFONT14;
            //*selColor  =RGB(246, 55, 151);
            if([catestr_color kr_isNotEmpty]){
                *norColor=[UIColor colorWithHexString:catestr_color];
            }
            if([catestr_color1 kr_isNotEmpty]){
                *selColor=[UIColor colorWithHexString:catestr_color1];
            }
        }];
        
        [selfWeak setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
            // 是否显示标签
            *isShowUnderLine = YES;
            // 标题填充模式
            //*underLineColor = RGB(246, 55, 151);
            if([catestr_color1 kr_isNotEmpty]){
                *underLineColor = [UIColor colorWithHexString:catestr_color1];
            }
            // 是否需要延迟滚动,下标不会随着拖动而改变
            *isDelayScroll = YES;
        }];
        [selfWeak setTopCate];
        [selfWeak.TopImageView setNoPlaceholderUrlImg:dictry[@"bg_img"]];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
    
}
-(void)setTopCate{
    self.isfullScreen = NO;
    self.contentView.frame=CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, JMScreenHeight-SafeAreaTopHeight);

    [self.contentView addSubview:self.titleScrollView];
    self.titleScrollView.backgroundColor=[UIColor clearColor];
    
    self.titleScrollView.sd_layout
    .topSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(35);
    
    [self setupChildVc];//最后加载子控制器不然line的颜色改变不了
    
    [self refreshDisplay];
    
}
#pragma mark - //setupChildVc 添加子视图
- (void)setupChildVc
{
    if (_ClassifyArr.count>0) {
        for (int i = 0 ; i<_ClassifyArr.count; i++) {
            XYTitleModel *model=_ClassifyArr[i];
            FNarrangeItemAeController *VC = [[FNarrangeItemAeController alloc] init];
            VC.title = model.str;
            VC.type = model.type;
            VC.bgimgUrl=self.bgimgUrl;
            [self addChildViewController:VC];
        }
    }
    [self refreshDisplay];
}
#pragma mark - //导航栏
-(void)setupNav{
    self.TopImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight)];
    self.TopImageView.image=IMAGE(@"");
    self.TopImageView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.TopImageView];
    
    _cuNaivgationbar = [FNCustomeNavigationBar customeNavigationBarWithTitle:@"会员等级"];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn setImage:[UIImage imageNamed:@"return-white"] forState:UIControlStateNormal];
    [self.leftBtn sizeToFit];
    self.leftBtn.size = CGSizeMake(self.leftBtn.width+10, self.leftBtn.height+10);
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_cuNaivgationbar];
    _cuNaivgationbar.backgroundColor =[UIColor clearColor];
    _cuNaivgationbar.leftButton = self.leftBtn;
    
    [self.view sendSubviewToBack:self.TopImageView];
    
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSMutableArray *)ClassifyArr{
    if (!_ClassifyArr) {
        _ClassifyArr = [NSMutableArray array];
    }
    return _ClassifyArr;
}

@end
