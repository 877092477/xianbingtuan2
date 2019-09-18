//
//  JMMemberChargeController.m
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
#import "JMMemberChargeController.h"
#import "JMMemberUpgradeHeader.h"
#import "JMHiBuyAPITool.h"
#import "JMMemberDisplayModel.h"
#import <AlipaySDK/AlipaySDK.h>
@interface JMMemberChargeController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *topUpBtn;
@property (nonatomic, weak) UIButton* selectedBtn;
@property (nonatomic, weak) UIButton* proxyBtn;
@property (nonatomic, strong)JMMemberUpgradeHeader* header;
@property (nonatomic, strong)JMMemberDisplayModel* model;

@property (nonatomic, strong) UILabel* tipsLabel;


@end

@implementation JMMemberChargeController
#pragma mark -  setter
- (void)setModel:(JMMemberDisplayModel *)model{
    _model = model;
    _header.model = model;
    _header.lessDate = [NSString stringWithFormat:@"剩余%@天",_model.sy_day];
    _tipsLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@",_model.str1,_model.str2,_model.str3];
    
    NSString *labelText = _tipsLabel.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:15];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    _tipsLabel.attributedText = attributedString;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self apiRequestDisplay];
    [self initializedSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma makr - api request
- (void)apiRequestDisplay{
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"type":@1}];
    @WeakObj(self);
    [JMHiBuyAPITool apiHiBuyForUpgradeMemberWithParams:params success:^(id respondsObject) {
        selfWeak.model = respondsObject;
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
        [FNTipsView showTips:error];
        
    }];
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    
    self.title = [FNBaseSettingModel settingInstance].vip_name;
    _header = [[JMMemberUpgradeHeader alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 0))];
    _header.model = self.model;

    [self.scrollView addSubview:_header];
    self.scrollView.backgroundColor = FNHomeBackgroundColor;
    
    
    UIView *footerView = [[UIView alloc]initWithFrame:(CGRectMake(0, CGRectGetMaxY(_header.frame), FNDeviceWidth, 44))];
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
    
    [self.scrollView addSubview:footerView];
    [footerView autoSetDimension:(ALDimensionHeight) toSize:44];
    [footerView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [footerView autoSetDimension:(ALDimensionWidth) toSize:FNDeviceWidth];
    [footerView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_header];
    
    //tips label
    _tipsLabel = [UILabel new];
    _tipsLabel.numberOfLines = 3;
    _tipsLabel.font = kFONT14;
    _tipsLabel.textColor = FNColor(89, 90, 91);
    _tipsLabel.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:_tipsLabel];
    [_tipsLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:LeftSpace];
    [_tipsLabel autoSetDimension:(ALDimensionWidth) toSize:FNDeviceWidth-LeftSpace*2 relation:(NSLayoutRelationEqual)];
    [_tipsLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:footerView withOffset:LeftSpace*2];
    
    self.scrollView.contentSize = CGSizeMake(FNDeviceWidth, FNDeviceHeight);
    
}
#pragma mark - action
- (void)selectedBtnAction:(UIButton *)btn{
    btn.selected = !btn.selected;
    _proxyBtn.selected = btn.selected ;
}
- (void)proxyBtnAction:(UIButton *)btn{
    [self goWebWithUrl:self.model.hdy_url];
}
#pragma mark - top up
- (IBAction)topUpAction:(id)sender {
    if (self.selectedBtn.selected == NO) {
        [FNTipsView showTips:[NSString stringWithFormat:@"请阅读%@购买协议，若已阅读请勾选，代表已遵循协议",[FNBaseSettingModel settingInstance].vip_name]];
        return;
    }

    [self apiRequestUpgrade];
}
- (void)apiRequestUpgrade{
    [SVProgressHUD show];
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"type":@0}];

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

@end
