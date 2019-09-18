//
//  JMMemberUpgradeController.m
//  THB
//
//  Created by jimmy on 2017/4/1.
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
#import "JMMemberUpgradeController.h"

#import "JMMemberUpgradeHeader.h"
#import "FNSectionHeaderView.h"
#import "JMMemberUpgradePayCell.h"

#import "JMHiBuyAPITool.h"
#import "JMMemberDisplayModel.h"
#import <AlipaySDK/AlipaySDK.h>
@interface JMMemberUpgradeController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *purchaseBtn;
@property (nonatomic, weak) UIButton* selectedBtn;
@property (nonatomic, weak) UIButton* proxyBtn;
@property (nonatomic, strong) JMMemberUpgradeHeader* headerView;
@property (nonatomic, strong) JMMemberDisplayModel* model;
@end

@implementation JMMemberUpgradeController
- (void)setModel:(JMMemberDisplayModel *)model{
    _model = model;
    self.headerView.model = _model;
    if (_model.zftype.count>0) {
        _model.zftype[0].isSelected = YES;
    }
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self apiRequestDisplay];
    [self initializedSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - api request

- (void)apiRequestDisplay{
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"type":@0}];
    @WeakObj(self);
    [JMHiBuyAPITool apiHiBuyForUpgradeMemberWithParams:params success:^(id respondsObject) {
        selfWeak.model = respondsObject;
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
        [FNTipsView showTips:error];
        
    }];
}
- (void)apiRequestUpgrade{
    
    if (self.model == nil || self.model.zftype.count == 0) {
        return;
    }
    [SVProgressHUD show];
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"type":self.model.zftype[0].type}];
    if (_headerView.codeTextField.text && _headerView.codeTextField.text.length>=1) {
        params[@"tgid"] = _headerView.codeTextField.text;
    }
    [JMHiBuyAPITool apiHiBuyForUpgradeMemberOperatingWithParams:params success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        if (respondsObject) {
            [[AlipaySDK defaultService] payOrder:respondsObject fromScheme:AlisdkSchemes callback:^(NSDictionary *resultDic) {
                if ([NSString checkIsSuccess:resultDic[@"resultStatus"] andElement:@"9000"] ) {
                    [FNTipsView showTips:ResultStatusDict[@"9000"]];
//                    [selfWeak finishedGeneratingOrderWihtType:OrderDetailTypeToBeDelivered];
                }else{
                    
//                    [selfWeak finishedGeneratingOrderWihtType:OrderDetailTypeNotPay];
                    [FNTipsView showTips:ResultStatusDict[resultDic[@"resultStatus"] ] withDuration:2.0];
                }
                
            }];

        }
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
        [FNTipsView showTips:error];
    }];
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.title = self.title?:[NSString stringWithFormat:@"成为%@",[FNBaseSettingModel settingInstance].vip_name];
    
    _headerView = [[JMMemberUpgradeHeader alloc] initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 0))];
    _headerView.codeTextField.text = Userextend_id;
    if (_headerView.codeTextField.text !=nil && _headerView.codeTextField.text.length >= 1) {
        _headerView.codeTextField.enabled = NO;
    }
    _headerView.model = self.model;
    
    self.tableView.tableHeaderView = _headerView;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = FNHomeBackgroundColor;
    
    
    UIView *footerView = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 44))];
    footerView.backgroundColor = FNHomeBackgroundColor;
    
    UIButton *selectedBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [selectedBtn setImage:[UIImage imageNamed:@"by_choose_off"] forState:UIControlStateNormal];
    [selectedBtn setImage:[UIImage imageNamed:@"by_choose_on"] forState:UIControlStateSelected];
    [selectedBtn sizeToFit];
    selectedBtn.selected = YES;
    selectedBtn.contentMode = UIViewContentModeScaleAspectFill;
    [selectedBtn addTarget:self action:@selector(selectedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:selectedBtn];
    _selectedBtn = selectedBtn;
    
    UIButton *proxyBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    proxyBtn.titleLabel.font = kFONT14;
    [proxyBtn setTitleColor:FNMainTextNormalColor forState:UIControlStateNormal];
    [proxyBtn setTitleColor:RED forState:UIControlStateSelected];
    
    [proxyBtn setTitle:[NSString stringWithFormat:@"《%@购买协议》",[FNBaseSettingModel settingInstance].vip_name] forState:UIControlStateNormal];
    NSAttributedString *att = [[NSAttributedString alloc]initWithString:proxyBtn.currentTitle attributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}];
    [proxyBtn setAttributedTitle:att forState:UIControlStateNormal];
    [proxyBtn sizeToFit];
    [proxyBtn addTarget:self action:@selector(proxyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:proxyBtn];
    _proxyBtn = proxyBtn;
    
    [selectedBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:LeftSpace];
    [selectedBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [selectedBtn autoSetDimensionsToSize:(CGSizeMake(selectedBtn.width+LeftSpace, selectedBtn.height+LeftSpace))];
    
    
    [proxyBtn autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:selectedBtn withOffset:0];
    [proxyBtn autoSetDimensionsToSize:proxyBtn.size];
    [proxyBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    self.tableView.tableFooterView = footerView;
    
}
#pragma mark - action
- (void)selectedBtnAction:(UIButton *)btn{
    btn.selected = !btn.selected;
    _proxyBtn.selected = btn.selected ;
}
- (void)proxyBtnAction:(UIButton *)btn{
    [self goWebWithUrl:self.model.hdy_url];
}
- (IBAction)purchaseRightNow:(id)sender {
    if (self.selectedBtn.selected == NO) {
        [FNTipsView showTips:[NSString stringWithFormat:@"请阅读%@购买协议，若已阅读请勾选，代表已遵循协议",[FNBaseSettingModel settingInstance].vip_name]];
        
        return;
    }
    if (self.model.is_yqbt.boolValue && (![self.headerView.codeTextField.text kr_isNotEmpty])) {
        [FNTipsView showTips:@"请填写邀请码"];
        return;
    }

    [self apiRequestUpgrade];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.zftype.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JMMemberUpgradePayCell* cell = [JMMemberUpgradePayCell cellWithTableView:tableView atIndexPath:indexPath];
    [cell.imgView setUrlImg:self.model.zftype[indexPath.row].icon];
    cell.titleLabel.text = self.model.zftype[indexPath.row].name;
    cell.seletedImgView.highlighted = self.model.zftype[0].isSelected;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FNSectionHeaderView* header = [[FNSectionHeaderView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 40))];
    header.backgroundColor = FNWhiteColor;
    header.titleLabel.text = @"支付方式";
    return header;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.model.zftype.count >0) {
        [self.model.zftype enumerateObjectsUsingBlock:^(JMPaymentWayModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.isSelected = idx == indexPath.row;
        }];
    }
}
@end
