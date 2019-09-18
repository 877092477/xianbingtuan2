//
//  FNCreaditCardMyShareController.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/21.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNCreaditCardMyShareController.h"
#import "FNCustomeNavigationBar.h"
#import "FNImageSliderView.h"
#import "FNCreaditCardMyShareListController.h"
#import "FNCreaditCardMyShareModel.h"

@interface FNCreaditCardMyShareController ()<UICollectionViewDelegateFlowLayout, FNImageSliderViewDelegate>
@property (nonatomic, strong) UILabel *lblCommission;
@property (nonatomic, strong) UILabel *lblDesc;

@property (nonatomic, strong)NSLayoutConstraint* btmCons;
@property (nonatomic, strong) FNCreaditCardMyShareModel *topModel;

@end

@implementation FNCreaditCardMyShareController

- (void)viewDidLoad {
//    self.title = @"我的推广";
    
    _lblCommission = [[UILabel alloc] init];
    [self.view addSubview:_lblCommission];
    [_lblCommission mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@20);
        make.top.equalTo(@36);
        make.right.lessThanOrEqualTo(@-20);
        make.centerX.equalTo(@0);
    }];
    
    _lblDesc = [[UILabel alloc] init];
    [self.view addSubview:_lblDesc];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@20);
        make.top.equalTo(self.lblCommission.mas_bottom).offset(10);
        make.right.lessThanOrEqualTo(@-20);
        make.centerX.equalTo(@0);
    }];
    
    _lblCommission.textColor = RGB(51, 51, 51);
    _lblCommission.font = [UIFont boldSystemFontOfSize:30];
    
    _lblDesc.textColor = RGB(153, 153, 153);
    _lblDesc.font = [UIFont boldSystemFontOfSize:14];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = FNWhiteColor;
    // 设置标题字体
    /*
     方式一：
     self.titleFont = [UIFont systemFontOfSize:20];
     */
    // 推荐方式
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
        //设置标题高度
        *titleHeight = 44;
        // 设置标题字体
        *titleFont = kFONT13;
        *norColor = RGB(153, 153, 153);
        *selColor = RGB(51, 51, 51);
        
    }];
    
    
    // 推荐方式（设置下标）
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
        
        // 是否显示标签
        *isShowUnderLine = YES;
        
        // 标题填充模式
        *underLineColor = RGB(30, 130, 254);
        
        *underLineH = 3;
        
        // 是否需要延迟滚动,下标不会随着拖动而改变
        //        *isDelayScroll = YES;
        
    }];
    
    // 设置全屏显示
    // 如果有导航控制器或者tabBarController,需要设置tableView额外滚动区域,详情请看FullChildViewController
    self.isfullScreen = NO;
    
    [SVProgressHUD show];
    
    [self requestCateggory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark - set up child view controllers
- (void)setupChildVC{
    
    if (self.topModel == nil)
        return;
 
    for (NSInteger index = 0; index < self.topModel.types.count; index ++) {
        NSDictionary *cate = self.topModel.types[index];
        FNCreaditCardMyShareListController *controller = [[FNCreaditCardMyShareListController alloc] init];
        controller.title = [cate valueForKey: @"str"];
        controller.type = [cate valueForKey: @"type"];
        [self addChildViewController:controller];
    }
    
    [self refreshDisplay];
    
    [self.contentView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.contentView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [self.contentView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:120];
    [self.contentView autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];

    [self.view layoutIfNeeded];
    
    
}

#pragma mark - Networking

- (FNRequestTool*) requestCateggory {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=credit_card&ctrl=my_extend_top" respondType:(ResponseTypeModel) modelType:@"FNCreaditCardMyShareModel" success:^(id respondsObject) {
        @strongify(self);
        
        self.topModel = respondsObject;
        [self setupChildVC];
        
        self.lblCommission.text = self.topModel.commission;
        self.lblDesc.text = self.topModel.tips;
        self.title = self.topModel.title;
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache:NO];
}


@end
