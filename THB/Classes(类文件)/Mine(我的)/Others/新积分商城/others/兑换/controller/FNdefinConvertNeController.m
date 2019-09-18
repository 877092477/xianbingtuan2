//
//  FNdefinConvertNeController.m
//  THB
//
//  Created by Jimmy on 2019/1/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdefinConvertNeController.h"

//controller
#import "FNdefinConvertItemDeController.h"
//model
#import "XYTitleModel.h"
@interface FNdefinConvertNeController ()
@property(nonatomic,strong) NSMutableArray *ClassifyArr;
@end

@implementation FNdefinConvertNeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     [self apiRequstClassify];
    // 设置标题字体
    //分类
        [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
            *titleHeight = 35;
            // 设置标题字体
            *titleFont = kFONT13;
            *selColor  =RGB(255, 131, 20);
        }];
    
    // 分类 （设置下标）
        [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
            // 是否显示标签
            *isShowUnderLine = YES;
            // 标题填充模式
            *underLineColor = RGB(255, 131, 20);
            // 是否需要延迟滚动,下标不会随着拖动而改变
            *isDelayScroll = YES;
        }];
    // 设置全屏显示
    // 如果有导航控制器或者tabBarController,需要设置tableView额外滚动区域,详情请看FullChildViewController
    self.isfullScreen = NO;
   
}

//分类文字
- (void)apiRequstClassify{
    @WeakObj(self);
    NSMutableDictionary*params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    if([self.SkipUIIdentifier kr_isNotEmpty]){
        params[@"SkipUIIdentifier"]=self.SkipUIIdentifier;
    }
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=convert_goods&ctrl=cate" respondType:(ResponseTypeArray) modelType:@"XYTitleModel" success:^(NSArray* respondsObject) {
        NSMutableArray *dataArray=[NSMutableArray arrayWithCapacity:0];
        NSArray *titles = respondsObject;
        if (titles.count > 0) {
            [titles enumerateObjectsUsingBlock:^(XYTitleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [dataArray addObject:obj];
            }];
            selfWeak.ClassifyArr=dataArray;
            [selfWeak setupChildVc];
        }
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
    
}

#pragma mark - //setupChildVc 添加子视图
- (void)setupChildVc
{
    if (_ClassifyArr.count>0) {
        for (int i = 0 ; i<_ClassifyArr.count; i++) {
            XYTitleModel *model=_ClassifyArr[i];
            FNdefinConvertItemDeController *VC = [[FNdefinConvertItemDeController alloc] init];
            VC.title = model.name;
            //VC.type = @"";
            VC.cid= model.id;
            VC.SkipUIIdentifier=self.SkipUIIdentifier;
            XYLog(@"cid:%@",model.id);
            [self addChildViewController:VC];
        }
    }
    [self refreshDisplay];
    [SVProgressHUD dismiss];
    
}
-(NSMutableArray *)ClassifyArr{
    if (!_ClassifyArr) {
        _ClassifyArr = [NSMutableArray array];
    }
    return _ClassifyArr;
}
@end
