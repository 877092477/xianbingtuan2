//
//  FNPartnerGoodsController.m
//  SuperMode
//
//  Created by jimmy on 2017/10/19.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPartnerGoodsController.h"
#import "FNPartnerGoodsView.h"
#import "FNPartnerGoodsViewModel.h"

@interface FNPartnerGoodsController ()
@property (nonatomic, strong)FNPartnerGoodsView* goodsview;
@property (nonatomic, strong)FNPartnerGoodsViewModel* viewmodel;

@end

@implementation FNPartnerGoodsController

- (FNPartnerGoodsView *)goodsview{
    if (_goodsview == nil) {
        _goodsview = [[FNPartnerGoodsView alloc]initWithViewModel:self.viewmodel];
        @weakify(self);
        _goodsview.selectCommodityType = ^(FNBaseProductModel *model) {
            @strongify(self);
            [self goProductVCWithModel:model];
        }; 
        _goodsview.PlShareType = ^(NSInteger shareType, NSString *shareFnuo_id) {
            @strongify(self);
            [SVProgressHUD show];
            NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"goods_type":@"taobao",@"fnuo_id":shareFnuo_id}];
            [FNRequestTool requestWithParams:params api:@"mod=appapi&act=shareMoreImg&ctrl=ercode" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
                NSArray *DataArr=[respondsObject valueForKey:@"data"];
                NSMutableArray* images = [NSMutableArray new];
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    // 处理耗时操作的代码块...
                    for (NSDictionary *dic in DataArr) {
                        [images addObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:URL([dic objectForKey:@"img"])]]];
                    }
                    //通知主线程刷新
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                        UIActivityViewController* vc = [[UIActivityViewController alloc]initWithActivityItems:images applicationActivities:nil];
                        [self presentViewController:vc animated:YES completion:nil];
                    });
                });
            } failure:^(NSString *error) {
                //
            } isHideTips:NO];
        };
    }
    return _goodsview;
}
- (FNPartnerGoodsViewModel *)viewmodel{
    if (_viewmodel == nil) {
        _viewmodel  =[FNPartnerGoodsViewModel new];
    }
    return _viewmodel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.title?:@"合伙人商品库";
    
    UIButton *RightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [RightBtn setTitleColor:FNGlobalTextGrayColor forState:UIControlStateNormal];
    [RightBtn setTitle:@"批量分享" forState:UIControlStateNormal];
    [RightBtn setTitle:@"取消" forState:UIControlStateSelected];
    RightBtn.titleLabel.font = kFONT14;
    [RightBtn sizeToFit];
    [RightBtn addTarget:self action:@selector(RightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:RightBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    [self.view addSubview:self.goodsview];
    [self.goodsview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
    if (!(isIphoneX)) {//execpt iphone x
        [FNNotificationCenter addObserver:self selector:@selector(observingKeyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
        [FNNotificationCenter addObserver:self selector:@selector(observingKeyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    }

}

- (void)jm_bindViewModel{
    [[self.viewmodel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id model) {
        [self shareProductWithModel:model];
    }];
}

#pragma mark - action
- (void)observingKeyboardWillShow{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)observingKeyboardWillHide{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)RightBtnAction:(UIButton *)sender{
    sender.selected=!sender.selected;
    _goodsview.isPL=sender.selected;
}

@end
