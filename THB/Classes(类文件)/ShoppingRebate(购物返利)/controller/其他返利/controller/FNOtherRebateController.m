//
//  FNOtherRebateController.m
//  THB
//
//  Created by Fnuo-iOS on 2018/5/5.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNOtherRebateController.h"

@interface FNOtherRebateController ()

@end

@implementation FNOtherRebateController

- (void)setIsNotHome:(BOOL)isNotHome{
    [super setIsNotHome:isNotHome];
    if (isNotHome) {
        UIBarButtonItem * back = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"return") style:(UIBarButtonItemStyleDone) target:self action:@selector(backAction)];
        self.navigationItem.leftBarButtonItem = back;
    }
}

- (FNOtherRebateHeader *)header{
    if (_header == nil) {
        _header = [[FNOtherRebateHeader alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, FNDeviceWidth*0.35))];
        @weakify(self);
        _header.searchBlock = ^(NSString *text) {
            @strongify(self);
            FNGoodsListViewController* VC = [FNGoodsListViewController new];
            VC.SkipUIIdentifier = self.SkipUIIdentifier;
            VC.keyword=text;
            [self.navigationController pushViewController:VC animated:YES];
        };
    }
    return _header;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self jm_setupViews];
    [FNRequestTool startWithRequests:@[[self requestMain]] withFinishedBlock:^(NSArray *erros) {
        self.header.Model=self.Model.topList[0];
        [self.jm_tableview reloadData];
        [UIView animateWithDuration:0.3 animations:^{
            self.jm_tableview.alpha = 1;
        }];
    }];
}

#pragma mark - initializedSubviews
- (void)jm_setupViews{
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
    self.jm_tableview.alpha = 0;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    UIView* footer = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, XYTabBarHeight))];
    self.jm_tableview.tableHeaderView = self.header;
    self.jm_tableview.tableFooterView = footer;
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
   
    UIButton *tutorialBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [tutorialBtn setImage:IMAGE(@"rebate_tutorial") forState:UIControlStateNormal];
    [tutorialBtn setTitleColor:FNBlackColor forState:UIControlStateNormal];
    [tutorialBtn setTitle:@"  教程" forState:UIControlStateNormal];
    tutorialBtn.titleLabel.font = kFONT14;
    [tutorialBtn sizeToFit];
    [tutorialBtn addTarget:self action:@selector(tutorialBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:tutorialBtn];
}
#pragma mark - action
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tutorialBtnAction:(id)btn{
    JMTutorialController* tutorial = [JMTutorialController new];
    tutorial.tutorialType = TutorialTypeTaoBao;
    [self.navigationController pushViewController:tutorial animated:YES];
}
#pragma mark - request
- (FNRequestTool *)requestMain{
    NSMutableDictionary *Params=[NSMutableDictionary dictionaryWithDictionary:@{@"SkipUIIdentifier":self.SkipUIIdentifier}];
    return [FNRequestTool requestWithParams:Params api:@"mod=appapi&act=appJdPdd&ctrl=buyIndex" respondType:(ResponseTypeModel) modelType:@"OtherRebateModel" success:^(id respondsObject) {
        //
        self.Model=respondsObject;
    } failure:^(NSString *error) {
        [self requestMain];
    } isHideTips:YES];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.Model.keyword.count>=1 ?1:0;
    }else{
        return self.Model.cate.count>=1 ?1:0;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNTBRebateCell* cell = [FNTBRebateCell cellWithTableView:tableView atIndexPath:indexPath];
    if (indexPath.section == 0 ) {
        cell.hotsearchs = self.Model.keyword;
    }else{
        cell.categories = self.Model.cate;
    }
    @WeakObj(self);
    cell.btnClicked = ^(NSString *title,NSString* cid, BOOL isCate) {
        FNGoodsListViewController* VC = [FNGoodsListViewController new];
        VC.SkipUIIdentifier = self.SkipUIIdentifier;
        VC.keyword=title;
        [self.navigationController pushViewController:VC animated:YES];
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
        return self.Model.keyword.count>=1 ?sectionheaer:nil;
    }else{
        return self.Model.cate.count>=1 ?sectionheaer:nil;
    }
    
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat margin = _jm_margin10;
    CGFloat width = (FNDeviceWidth-margin*4)/3;
    CGFloat theight = width*0.7;
    CGFloat height = theight*2+margin*3 + 20;
    if (indexPath.section == 0) {
        return self.Model.keyword.count>=1 ?height:0;
    }else{
        return self.Model.cate.count>=1 ?height:0;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.Model.keyword.count>=1 ?44:0.01;
    }else{
        return self.Model.cate.count>=1 ?44:0.01;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.view endEditing:YES];
}
@end
