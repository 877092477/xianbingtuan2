//
//  JMASBindAlipayController.m
//  THB
//
//  Created by jimmy on 2017/3/31.
//  Copyright © 2017年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */
#import "JMASBindAlipayController.h"
#import "FNTextFieldCell.h"
#import "FNAliPayModel.h"

@interface JMASBindAlipayController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)FNAliPayModel *Model;

@property (nonatomic, strong)UITableView* tableView;

@property (nonatomic, copy)NSString* Str1;
@property (nonatomic, copy)NSString* Str2;

@end

@implementation JMASBindAlipayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [FNRequestTool startWithRequests:@[[self requestData]] withFinishedBlock:^(NSArray *erros) {
        self.title=self.Model.set_alipay_topstr1;
        [self initializedSubviews];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (FNRequestTool *)requestData{
    @weakify(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dg_app_updatestr&ctrl=setAlipay" respondType:(ResponseTypeModel) modelType:@"FNAliPayModel" success:^(id respondsObject) {
        @strongify(self);
        self.Model=respondsObject;
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
}

#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.title = @" 绑定支付宝";
    _tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = YES;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor=FNWhiteColor;
    [self.view addSubview:_tableView];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
    UIView* view1 = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 0))];
    UILabel *topLabel=[UILabel new];
    topLabel.textColor=FNGlobalTextGrayColor;
    topLabel.text=self.Model.set_alipay_topstr4;
    topLabel.numberOfLines=0;
    topLabel.font=kFONT14;
    [view1 addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(LeftSpace));
        make.right.equalTo(@(-LeftSpace));
        make.centerY.equalTo(view1.mas_centerY);
    }];
    [topLabel sizeToFit];
    view1.height=topLabel.height+20;
    _tableView.tableHeaderView = view1;
    
    UIView* view2 = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 40+LeftSpace*2))];
    UIButton *confirmBtn = [UIButton buttonWithTitle:@"确定" titleColor:FNWhiteColor font:kFONT15 target:self action:@selector(confirmBindAction)];
    confirmBtn.backgroundColor = RED;
    confirmBtn.cornerRadius = 5;
    confirmBtn.frame = CGRectMake(LeftSpace, LeftSpace, FNDeviceWidth-LeftSpace*2, 40);
    [view2 addSubview:confirmBtn];
    
    _tableView.tableFooterView = view2;
    
    [self.tableView reloadData];
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    @WeakObj(self);
    FNTextFieldCell* cell  = [FNTextFieldCell cellWithTableView:tableView atIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {
        cell.textField.placeholder = self.Model.set_alipay_topstr3;
        cell.textField.text=self.Str2;
        
    }else if (indexPath.row==1) {
        cell.textField.placeholder = self.Model.set_alipay_topstr2;
        cell.textField.text=self.Str1;
    }

    cell.textDidChangeBlock = ^(NSIndexPath* sender,NSString* text){
        if (sender.row == 0) {
            selfWeak.Str2 = text;
        }else{
            selfWeak.Str1 = text;
        }
    };
    return cell;
}

#pragma mark -  Table veiw delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma mark - action
- (void)confirmBindAction{
    if (![self.Str2 kr_isNotEmpty]) {
        [FNTipsView showTips:self.Model.set_alipay_topstr3];
        return;
    }
    if (![self.Str1 kr_isNotEmpty]) {
        [FNTipsView showTips:self.Model.set_alipay_topstr2];
        return;
    }
    [self.view endEditing:YES];
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"zfb_au":self.Str1,
                                                                                 @"realname":self.Str2,
                                                                                 @"token":UserAccessToken
                                                                                 }];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_mine_updateUser successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody2 is %@",responseBody);
        
        if ([[dict objectForKey:XYSuccess]  isEqual: @1]) {
            [[NSUserDefaults standardUserDefaults] setValue:self.Str2 forKey:XYrealname];
            [[NSUserDefaults standardUserDefaults] setValue:self.Str1 forKey:XYzfb_au];
            [[NSUserDefaults standardUserDefaults] synchronize];
    
            
            [FNTipsView showTips:@"绑定成功"];
            UIViewController* __block vc = nil;
            if ([NSString isEmpty:self.vcstring]) {
                
                [self.navigationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj isKindOfClass:NSClassFromString(self.vcstring)]) {
                        vc = obj;
                    }
                }];
                
            }
            if (vc) {
                [self.navigationController popToViewController:vc animated:YES];
            }else{
                [FNNotificationCenter postNotificationName:@"EditProfile" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }
            [FNNotificationCenter postNotificationName:@"RefreshProfile" object:nil];
            
            
        }else
        {
            [FNTipsView showTips:responseBody[MsgKey]];
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }


    } failureBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
        [XYNetworkAPI cancelAllRequest];
    }];

}
@end
