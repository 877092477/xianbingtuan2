//
//  FXOrderNavBarViewController.m
//  嗨如意
//
//  Created by Fnuo-iOS on 2018/5/7.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FXOrderNavBarViewController.h"

@interface FXOrderNavBarViewController ()

@end

@implementation FXOrderNavBarViewController{
    NSMutableArray *title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.useNavigationBarButtonItemsOfCurrentViewController = YES;
    self.useToolbarItemsOfCurrentViewController = YES;
    
    NSMutableArray *initialViewController = [NSMutableArray array];
    FXOrderNavViewController *vc=[FXOrderNavViewController new];
    [initialViewController addObject:vc];
    self.viewController = initialViewController;
    
    [FNAPIHome startWithRequests:@[[self apiRequestHotSearchHeadColumn]] withFinishedBlock:^(NSArray *erros) {
        _slideBar = [[FDSlideBar alloc] initWithFrame:CGRectMake(50, 0, FNDeviceWidth-50, 40)];
        _slideBar.backgroundColor = FNWhiteColor;
        _slideBar.is_middle=YES;
        _slideBar.itemsTitle = title;
        _slideBar.itemColor = FNGlobalTextGrayColor;
        _slideBar.itemSelectedColor = FNMainGobalTextColor;
        _slideBar.sliderColor = FNMainGobalTextColor;
        _slideBar.fontSize=13;
        _slideBar.SelectedfontSize=14;
        [self slideBarItemSelected];
        self.navigationItem.titleView = _slideBar;
    }];
}

-(void)slideBarItemSelected{
    [self showViewController:[self.mutableViewController objectAtIndex:0] animated:NO];
    [_slideBar slideBarItemSelectedCallback:^(NSUInteger index) {
        [self showViewController:[self.mutableViewController objectAtIndex:index] animated:NO];
    }];
}

//获取商品栏目（淘宝，京东，拼多多那几个大栏目）
- (FNAPIHome *)apiRequestHotSearchHeadColumn{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"type":@"4"}];
    return [FNAPIHome apiHomeForHotSearchHeadColumnWithParams:params success:^(id respondsObject) {
        title=[[NSMutableArray alloc]init];
        NSMutableArray *initialViewController = [NSMutableArray array];
        [respondsObject enumerateObjectsUsingBlock:^(HotSearchHeadColumnModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [title addObject:obj.name];
            FXOrderNavViewController *vc=[FXOrderNavViewController new];
            vc.SkipUIIdentifier=obj.SkipUIIdentifier;
            [initialViewController addObject:vc];
        }];
        self.viewController = initialViewController;
    } failure:^(NSString *error) {
        
    } isHidden:YES];
}

@end
