//
//  FNStoreCouponeController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/23.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreCouponeController.h"
#import "FNStoreMyCouponeController.h"
#import "FNStoreCouponeCateModel.h"

@interface FNStoreCouponeController()

@property (nonatomic, strong) NSArray<FNStoreCouponeCateModel*> *cates;

@end

@implementation FNStoreCouponeController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"店铺类型";
    self.view.backgroundColor = UIColor.whiteColor;
    // 推荐方式
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
        *titleHeight = 35;
        // 设置标题字体
        *titleFont = kFONT15;
        *selColor  =RGB(246, 55, 151);
        *norColor  =RGB(129, 128, 129);
    }];
    
    // 推荐方式（设置下标）
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
        
        // 是否显示标签
        *isShowUnderLine = YES;
        
        // 标题填充模式
        *underLineColor = RGB(246, 55, 151);
        
        // 是否需要延迟滚动,下标不会随着拖动而改变
        *isDelayScroll = YES;
        
    }];
    
    // 设置全屏显示
    // 如果有导航控制器或者tabBarController,需要设置tableView额外滚动区域,详情请看FullChildViewController
    self.isfullScreen = NO;
    
    
    [self requestCate];
    
}

#pragma mark - set up child view controllers
- (void)setupChildVC{
    @weakify(self)
    
    [self.cates enumerateObjectsUsingBlock:^(FNStoreCouponeCateModel * _Nonnull cate, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self)
        FNStoreMyCouponeController *controller = [[FNStoreMyCouponeController alloc] init];
        
        controller.cate_type = cate.type;
        controller.title = cate.str;
        
        [self addChildViewController:controller];
        
    }];
    [self refreshDisplay];
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.top.right.equalTo(@0);
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.titleScrollView.mas_bottom);
    }];
    [self.view layoutIfNeeded];
    
    
}

#pragma - mark Networking

- (void)requestCate {
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_red_packet&ctrl=my_card_top" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        
        NSDictionary *data = respondsObject[@"cates"];
        self.cates = [FNStoreCouponeCateModel mj_objectArrayWithKeyValuesArray:data];
        
        [self setupChildVC];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO];
    
}

@end
