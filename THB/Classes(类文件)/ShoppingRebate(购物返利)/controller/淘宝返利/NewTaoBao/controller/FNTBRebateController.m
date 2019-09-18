//
//  FNTBRebateController.m
//  THB
//
//  Created by jimmy on 2017/10/30.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNTBRebateController.h"
#import "ProductListViewController.h"
#import "JMTutorialController.h"
#import "FNTBRebateCell.h"
#import "FNTBRebateHeader.h"
#import "XYTitleModel.h"
#import "FNTBRebateHotModel.h"
@interface FNTBRebateController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)FNTBRebateHeader*   header;
@property (nonatomic, strong)NSArray* hotwords;
@property (nonatomic, strong)NSArray* categories;
@end

@implementation FNTBRebateController
- (void)setIsNotHome:(BOOL)isNotHome{
    [super setIsNotHome:isNotHome];
    if (isNotHome) {
        UIBarButtonItem * back = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"return") style:(UIBarButtonItemStyleDone) target:self action:@selector(backAction)];
        self.navigationItem.leftBarButtonItem = back;
    }
}
- (FNTBRebateHeader *)header{
    if (_header == nil) {
        _header = [[FNTBRebateHeader alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 0))];
        @weakify(self);
        _header.searchBlock = ^(NSString *text) {
            @strongify(self);
            ProductListViewController *vc = [[ProductListViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.searchTitle =text;
            //    vc.type = 1;
            vc.categoryID = @"";
            [self.navigationController pushViewController:vc animated:YES];
        };
    }
    return _header;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self jm_setupViews];
    [FNRequestTool startWithRequests:@[[self requestHots],[self requestCategories] ] withFinishedBlock:^(NSArray *erros) {
        [self.jm_tableview reloadData];
        [UIView animateWithDuration:0.3 animations:^{
            self.jm_tableview.alpha = 1;
        }];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    UIView* footer = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, XYTabBarHeight))];
    self.jm_tableview.tableHeaderView = self.header;
    self.jm_tableview.tableFooterView = footer;
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
    UIButton *tutorialBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [tutorialBtn setImage:IMAGE(@"rebate_tutorial") forState:UIControlStateNormal];
    [tutorialBtn setTitleColor:FNGlobalTextGrayColor forState:UIControlStateNormal];
    [tutorialBtn setTitle:@"  教程" forState:UIControlStateNormal];
    tutorialBtn.titleLabel.font = kFONT14;
    [tutorialBtn sizeToFit];
    [tutorialBtn addTarget:self action:@selector(tutorialBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:tutorialBtn];
}
- (void)tutorialBtnAction:(id)btn{
    JMTutorialController* tutorial = [JMTutorialController new];
    tutorial.tutorialType = TutorialTypeShop;
    [self.navigationController pushViewController:tutorial animated:YES];
}
#pragma mark - request
- (FNRequestTool *)requestHots{
    
    return [FNRequestTool requestWithParams:[NSMutableDictionary dictionaryWithDictionary:@{}] api:_api_others_getkeyword respondType:(ResponseTypeArray) modelType:@"FNTBRebateHotModel" success:^(id respondsObject) {
        //
        self.hotwords =respondsObject;
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
}

- (FNRequestTool *)requestCategories{
    
    return [FNRequestTool requestWithParams:[NSMutableDictionary dictionaryWithDictionary:@{}] api:_api_others_rebatecate respondType:(ResponseTypeArray) modelType:@"XYTitleModel" success:^(id respondsObject) {
        //
        self.categories =respondsObject;
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
}
#pragma mark - action
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.hotwords.count>=1 ?1:0;
    }else{
        return self.categories.count>=1 ?1:0;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNTBRebateCell* cell = [FNTBRebateCell cellWithTableView:tableView atIndexPath:indexPath];
    if (indexPath.section == 0 ) {
        cell.hotsearchs = self.hotwords;
    }else{
        cell.categories = self.categories;
    }
    @WeakObj(self);
    cell.btnClicked = ^(NSString *title,NSString* cid, BOOL isCate) {

        ProductListViewController *vc = [[ProductListViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.searchTitle =title;
        //    vc.type = 1;
        vc.categoryID = @"";
        [selfWeak.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* sectionheaer = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 44))];
    sectionheaer.backgroundColor = FNWhiteColor;
    UIImageView * imgview = [UIImageView new];
    imgview.image = section == 0 ?IMAGE(@"shop_hot_search"):IMAGE(@"shop_classly");
    [imgview sizeToFit];
    [sectionheaer addSubview:imgview];
    [imgview autoSetDimensionsToSize:imgview.size];
    [imgview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_margin10];
    [imgview autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    UILabel* titleLabel = [UILabel new];
    titleLabel.font = kFONT13;
    titleLabel.text = section == 0 ?@"正在热搜":@"商品分类";
    [sectionheaer addSubview:titleLabel];
    [titleLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:imgview withOffset:_jm_margin10];
    [titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_margin10];
    [titleLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    if (section == 0) {
        return self.hotwords.count>=1 ?sectionheaer:nil;
    }else{
        return self.categories.count>=1 ?sectionheaer:nil;
    }
    
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat margin = _jm_margin10;
    CGFloat width = (FNDeviceWidth-margin*4)/3;
    CGFloat theight = width*0.7;
    CGFloat height = theight*2+margin*3;
    if (indexPath.section == 0) {
        return self.hotwords.count>=1 ?height:0;
    }else{
        return self.categories.count>=1 ?height:0;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.hotwords.count>=1 ?44:0.01;
    }else{
        return self.categories.count>=1 ?44:0.01;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.view endEditing:YES];
}
@end
