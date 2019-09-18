//
//  FNMyVideoCardPayController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNMyVideoCardPayController.h"
#import <AlipaySDK/AlipaySDK.h>

@interface FNMyVideoCardPayController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FNMyVideoCardPayController

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
    cell.CardPayModel = self.PayModel[indexPath.row];
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
    [self.PayModel enumerateObjectsUsingBlock:^(FNMyCardPayTypeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isSelected=NO;
        if (indexPath.row==idx) {
            obj.isSelected=YES;
        }
    }];
    [self.jm_tableview reloadData];
}

-(void)BuyBtnAction{
    NSString __block *PayType;
    [self.PayModel enumerateObjectsUsingBlock:^(FNMyCardPayTypeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected==YES) {
            PayType=obj.pay_type;
        }
    }];
    
    [self requestCreateOrder:_cardId withCount:_count byPayType:PayType];
}

#pragma mark - 网络请求
- (FNRequestTool *)requestPayType{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token":UserAccessToken}];
    @weakify(self)
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=app_movie_card&ctrl=zf_type" respondType:(ResponseTypeArray) modelType:@"FNMyCardPayTypeModel" success:^(id respondsObject) {
        @strongify(self)
        
        if ([FNCurrentVersion isEqualToString:Setting_checkVersion]) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (FNMyCardPayTypeModel *model in respondsObject) {
                if (![model.pay_type isEqualToString: @"money"]) {
                    continue;
                }
                [array addObject:model];
            }
            self.PayModel=array;
        } else {
            self.PayModel=respondsObject;
        }
        self.PayModel[0].isSelected=YES;
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache:NO];
}

- (FNRequestTool *)requestCreateOrder: (NSString*)ID withCount: (NSInteger)count byPayType: (NSString*)type {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token":UserAccessToken, @"num" : @(count), @"cid": ID, @"pay_type": type}];
    @weakify(self)
    [SVProgressHUD show];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=app_movie_card&ctrl=createOrder" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        NSString *oid = respondsObject[@"oid"];
        
        [self requestPayOrder:oid withType:type];
        
        
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:NO isCache:NO];
}

- (FNRequestTool *)requestPayOrder: (NSString*)ID withType: (NSString*)type{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token":UserAccessToken, @"oid" : ID}];
    @weakify(self)
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=app_movie_card&ctrl=pay" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        if ([type isEqualToString:@"money"]) {
            if ([self.delegate respondsToSelector:@selector(didCardPay)]) {
                [self.delegate didCardPay];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } else if ([type isEqualToString:@"alipay"]){
            
            NSString *code = respondsObject[@"code"];
            [[AlipaySDK defaultService] payOrder:code fromScheme:AlisdkSchemes callback:^(NSDictionary *resultDic) {
                XYLog(@"支付:%@",resultDic);
                //                callback(resultDic);
                if ([NSString checkIsSuccess:resultDic[@"resultStatus"] andElement:@"9000"] ) {
                    [FNTipsView showTips:ResultStatusDict[@"9000"]];
                    if ([self.delegate respondsToSelector:@selector(didCardPay)]) {
                        [self.delegate didCardPay];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }else{
                    [SVProgressHUD dismiss];
                    [FNTipsView showTips:ResultStatusDict[resultDic[@"resultStatus"] ] withDuration:2.0];
                }
            }];
            
        }
        
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:NO isCache:NO];
}

@end
