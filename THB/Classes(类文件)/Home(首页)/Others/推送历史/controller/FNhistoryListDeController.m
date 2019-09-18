//
//  FNhistoryListDeController.m
//  THB
//
//  Created by Jimmy on 2018/12/21.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//历史消息
#import "FNhistoryListDeController.h"
#import "FNmesHistoryItemController.h"
#import "XYTitleModel.h"
#import "FNhistoryItemModel.h"
@interface FNhistoryListDeController ()
@property(nonatomic,strong)NSMutableArray *titles;
@end

@implementation FNhistoryListDeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=self.title?self.title:@"消息中心";
    // 分类
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
        *titleHeight = 35;
        // 设置标题字体
        *titleFont = kFONT15;
        *selColor  =RGB(255, 74, 74);
        *norColor  =RGB(129, 128, 129);
    }]; 
    // 分类设置下标）
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
        // 是否显示标签
        *isShowUnderLine = YES;
        // 标题填充模式
        *underLineColor = RGB(255, 74, 74);
        // 是否需要延迟滚动,下标不会随着拖动而改变
        *isDelayScroll = YES;
    }];
    self.isfullScreen = NO;
    self.view.backgroundColor=RGB(245, 245, 245);
    self.titleScrollView.backgroundColor=RGB(245, 245, 245);
    [self setupChildVc];
    [self apiRequestMessageCategory];
}

#pragma mark - //setupChildVc 添加子视图
- (void)setupChildVc
{
    //NSArray *titles=@[@"官方消息",@"订单消息"];
    //NSArray *statuArray=@[@"0",@"1"];
    if(self.titles.count>0){
        for (int i = 0 ; i<self.titles.count; i++) {
            XYTitleModel *model=self.titles[i];
            FNmesHistoryItemController *VC = [[FNmesHistoryItemController alloc] init];
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
    @WeakObj(self);
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=tuisong&ctrl=cate" respondType:(ResponseTypeArray) modelType:@"XYTitleModel" success:^(id respondsObject) {
        NSMutableArray *dataArray=[NSMutableArray arrayWithCapacity:0];
        NSArray *titles = respondsObject;
        if (titles.count > 0) {
            [titles enumerateObjectsUsingBlock:^(XYTitleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [dataArray addObject:obj];
            }];
            selfWeak.titles=dataArray;
            [selfWeak setupChildVc];
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
