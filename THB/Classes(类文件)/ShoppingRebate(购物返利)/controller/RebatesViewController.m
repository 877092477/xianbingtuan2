//
//
//  THB
//
//  Created by zhongxueyu on 16/3/15.
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

#import "RebatesViewController.h"
#import "FNAPIHome.h"
#import "HotSearchHeadColumnModel.h"
#import "FNOtherRebateController.h"
#import "ShopRebatesViewController.h"
@interface RebatesViewController ()
@property (nonatomic, strong)ShopRebatesViewController* shop;
@property (nonatomic, strong)FNOtherRebateController* taobao;
@property (nonatomic, strong)FNOtherRebateController* jingdong;
@property (nonatomic, strong)FNOtherRebateController* pinduoduo;
@end

@implementation RebatesViewController
- (void)setIsNotHome:(BOOL)isNotHome{
    [super setIsNotHome:isNotHome];
    self.shop.isNotHome = isNotHome;
    self.taobao.isNotHome = isNotHome;
    self.jingdong.isNotHome = isNotHome;
    self.pinduoduo.isNotHome = isNotHome;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.useNavigationBarButtonItemsOfCurrentViewController = YES;
    self.useToolbarItemsOfCurrentViewController = YES;
    
    NSMutableArray *initialViewController = [NSMutableArray array];
    UIViewController *VC=[UIViewController new];
    VC.view.backgroundColor=FNWhiteColor;
    [initialViewController addObject:VC];
    
    self.viewController = initialViewController;
    
    [FNAPIHome startWithRequests:@[[self apiRequestHotSearchHeadColumn]] withFinishedBlock:^(NSArray *erros) {
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取商品栏目（淘宝，京东，拼多多那几个大栏目）
- (FNAPIHome *)apiRequestHotSearchHeadColumn{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"type":@"0"}];
    return [FNAPIHome apiHomeForHotSearchHeadColumnWithParams:params success:^(id respondsObject) {
        NSMutableArray *initialViewController = [NSMutableArray array];
        [respondsObject enumerateObjectsUsingBlock:^(HotSearchHeadColumnModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.SkipUIIdentifier isEqualToString:@"buy_taobao"]) {
                self.taobao = [FNOtherRebateController new];
                self.taobao.title=obj.name;
                self.taobao.isNotHome = self.isNotHome;
                self.taobao.SkipUIIdentifier=obj.SkipUIIdentifier;
                [initialViewController addObject:self.taobao];
            }
            if ([obj.SkipUIIdentifier isEqualToString:@"buy_jingdong"]) {
                self.jingdong = [FNOtherRebateController new];
                self.jingdong.title=obj.name;
                self.jingdong.isNotHome = self.isNotHome;
                self.jingdong.SkipUIIdentifier=obj.SkipUIIdentifier;
                [initialViewController addObject:self.jingdong];
            }
            if ([obj.SkipUIIdentifier isEqualToString:@"buy_pinduoduo"]) {
                self.pinduoduo = [FNOtherRebateController new];
                self.pinduoduo.title=obj.name;
                self.pinduoduo.SkipUIIdentifier=obj.SkipUIIdentifier;
                self.pinduoduo.isNotHome = self.isNotHome;
                [initialViewController addObject:self.pinduoduo];
            }
            if ([obj.SkipUIIdentifier isEqualToString:@"buy_shangcheng"]) {
                ShopRebatesViewController *vc = [[ShopRebatesViewController alloc] initWithShopType:@"shangcheng" withStr:@""];
                vc.isNotHome = self.isNotHome;
                self.shop = vc;
                [initialViewController addObject:self.shop];
            }
        }];
        self.viewController = initialViewController;
        if(self.viewController.count>0){
            [self showViewController:[self.mutableViewController objectAtIndex:0] animated:NO];
            self.navigationStrategy=RMMultipleViewsControllerNavigationStrategySegmentedControl;
        } 
    } failure:^(NSString *error) {
        [self apiRequestHotSearchHeadColumn];
    } isHidden:YES];
}

@end
