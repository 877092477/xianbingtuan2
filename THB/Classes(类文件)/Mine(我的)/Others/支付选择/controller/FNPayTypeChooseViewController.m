//
//  FNPayTypeChooseViewController.m
//  THB
//
//  Created by Fnuo-iOS on 2018/6/15.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNPayTypeChooseViewController.h"

@interface FNPayTypeChooseViewController ()

@end

@implementation FNPayTypeChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"选择支付方式";
    
    [self InitializeView];
    
    [SVProgressHUD show];
    [FNRequestTool startWithRequests:@[[self requestPayType]] withFinishedBlock:^(NSArray *erros) {
        [SVProgressHUD dismiss];
        [self.jm_tableview reloadData];
    }];
}

-(void)InitializeView{
    UIButton * BuyBtn = [UIButton buttonWithTitle:@"确认支付" titleColor:FNWhiteColor font:kFONT15 target:self action:@selector(BuyBtnAction)];
    BuyBtn.backgroundColor=RGB(255, 51, 102);
    BuyBtn.cornerRadius=5;
    [self.view addSubview:BuyBtn];
    [BuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.bottom.equalTo(@-20);
        make.height.equalTo(@50);
    }];
    
    self.jm_tableview=[[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.backgroundColor=FNWhiteColor;
    self.jm_tableview.showsVerticalScrollIndicator = NO;
    [self.jm_tableview removeEmptyCellRows];
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.bottom.equalTo(BuyBtn.mas_top).offset(-20);
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.PayModel.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNPayTypeChooseCell *cell=[FNPayTypeChooseCell cellWithTableView:tableView];
    cell.PayModel = self.PayModel[indexPath.row];
    return cell;
    
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.PayModel enumerateObjectsUsingBlock:^(PayTypeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isSelected=NO;
        if (indexPath.row==idx) {
            obj.isSelected=YES;
        }
    }];
    [self.jm_tableview reloadData];
}

-(void)BuyBtnAction{
    NSString __block *PayType;
    [self.PayModel enumerateObjectsUsingBlock:^(PayTypeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected==YES) {
            PayType=obj.type;
        }
    }];
    
    if (self.successCheckBlock) {
        self.successCheckBlock(PayType);
    }
}

#pragma mark - 网络请求
- (FNRequestTool *)requestPayType{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dg_app_updatestr&ctrl=zf_type" respondType:(ResponseTypeArray) modelType:@"PayTypeModel" success:^(id respondsObject) {
        //
        self.PayModel=respondsObject;
        self.PayModel[0].isSelected=YES;
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
}

@end
