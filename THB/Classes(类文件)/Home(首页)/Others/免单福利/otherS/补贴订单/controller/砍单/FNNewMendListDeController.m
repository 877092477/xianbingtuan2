//
//  FNNewMendListDeController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNNewMendListDeController.h"
//controller
#import "FNNewOrderMendDeController.h"
//model
#import "XYTitleModel.h"
@interface FNNewMendListDeController ()
@property(nonatomic,strong)NSMutableArray *titles;
@end

@implementation FNNewMendListDeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的免单";
    // 推荐方式
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
        *titleHeight = 35;
        // 设置标题字体
        *titleFont = kFONT12;
        *selColor  =RGB(254, 10, 86);
        *norColor  =RGB(140, 140, 140);
    }];
    
    // 推荐方式（设置下标）
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
        
        // 是否显示标签
        *isShowUnderLine = YES;
        
        // 标题填充模式
        *underLineColor = RGB(254, 10, 86);
        
        // 是否需要延迟滚动,下标不会随着拖动而改变
        *isDelayScroll = YES;
        
    }];
    
    // 设置全屏显示
    // 如果有导航控制器或者tabBarController,需要设置tableView额外滚动区域,详情请看FullChildViewController
    self.isfullScreen = NO;
    
    self.view.backgroundColor=RGB(240, 240, 240);
    
    self.titleScrollView.backgroundColor=UIColor.whiteColor;
    
    [self apiRequestCategory];
}
#pragma mark - //setupChildVc 添加子视图
- (void)setupChildVc
{
    //NSArray *titles=@[@"等待确认",@"等待结算",@"已经结算",@"失效订单"];
    //NSArray *statuArray=@[@"0",@"1",@"2",@"3"];
    if(self.titles.count>0){
        for (int i = 0 ; i<self.titles.count; i++) {
            XYTitleModel *model=self.titles[i];
            FNNewOrderMendDeController *VC = [[FNNewOrderMendDeController alloc] init];
            VC.title = model.name;//titles[i];
            VC.type = model.type;//statuArray[i];
            [self addChildViewController:VC];
        }
        [self refreshDisplay];
        [SVProgressHUD dismiss];
    }
}

#pragma mark - //订单分类
- (FNRequestTool *)apiRequestCategory{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=bargainDoing&ctrl=cate" respondType:(ResponseTypeArray) modelType:@"XYTitleModel" success:^(id respondsObject) {
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
