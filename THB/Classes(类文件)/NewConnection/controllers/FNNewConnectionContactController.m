//
//  FNNewConnectionContactController.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/13.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewConnectionContactController.h"
#import "FNNewConnectionContactListController.h"
#import "FNNewConnectionContactSearchController.h"


@interface FNNewConnectionContactController()<UICollectionViewDelegate>

@property (nonatomic, strong) UIButton *rightbutton;

@end

@implementation FNNewConnectionContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"聊天";
    // 设置标题字体
    /*
     方式一：
     self.titleFont = [UIFont systemFontOfSize:20];
     */
    // 推荐方式
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
        *titleHeight = 35;
        // 设置标题字体
        *titleFont = kFONT14;
        *selColor = RGB(51, 51, 51);
    }];
    
    // 设置下标
    /*
     方式一
     // 是否显示标签
     self.isShowUnderLine = YES;
     
     // 标题填充模式
     self.underLineColor = [UIColor redColor];
     
     // 是否需要延迟滚动,下标不会随着拖动而改变
     self.isDelayScroll = YES;
     */
    
    // 推荐方式（设置下标）
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
        
        // 是否显示标签
        *isShowUnderLine = YES;
        
        // 标题填充模式
        *underLineColor = RGB(98, 231, 255);
        
        // 是否需要延迟滚动,下标不会随着拖动而改变
        //        *isDelayScroll = YES;
        
    }];
    
    // 设置全屏显示
    // 如果有导航控制器或者tabBarController,需要设置tableView额外滚动区域,详情请看FullChildViewController
    self.isfullScreen = NO;
    self.contentScrollView.delegate = self;
//    [self setupChildVc];
    [self requestCateggory];
    [self setupNav];
    
}

//导航栏
-(void)setupNav{
    UIButton *leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setImage: [UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    leftbutton.frame=CGRectMake(0, 0, 21, 21);
    [leftbutton addTarget:self action:@selector(LeftBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    
    _rightbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_rightbutton setImage: [UIImage imageNamed:@"live_coupone_nav_button_search"] forState:UIControlStateNormal];
    _rightbutton.frame=CGRectMake(0, 0, 21, 21);
    [_rightbutton addTarget:self action:@selector(RightBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_rightbutton];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];

}

-(void)LeftBtnMethod:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)RightBtnMethod:(UIButton *)sender
{
    FNNewConnectionContactSearchController *vc = [[FNNewConnectionContactSearchController alloc] init];
    [self.navigationController pushViewController: vc animated: YES];
}

- (void)requestCateggory{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,}];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection02&ctrl=cate" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        
        @strongify(self)
        NSArray *array = respondsObject;
        for (NSInteger index = 0; index < array.count; index++) {
            NSDictionary *dict = array[index];
            FNNewConnectionContactListController *vc = [[FNNewConnectionContactListController alloc] init];
            vc.title = dict[@"name"];
            vc.type = dict[@"type"];
            if ([vc.type isEqualToString: _type]) {
                self.selectIndex = index;
            }
            [self addChildViewController:vc];
        }
        self.rightbutton.hidden = YES;
        [self refreshDisplay];
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        [XYNetworkAPI cancelAllRequest];
        [SVProgressHUD dismiss];
        [self.jm_collectionview.mj_footer endRefreshing];
    } isHideTips:YES];
    
}


#pragma mark - scroll view delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/JMScreenWidth;
//    NSLog(@"aaaa %ld", index);
    self.rightbutton.hidden = index != 1;

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/JMScreenWidth;
    //    NSLog(@"aaaa %ld", index);
    self.rightbutton.hidden = index != 1;
    [super scrollViewDidScroll: scrollView];
    
}


@end
