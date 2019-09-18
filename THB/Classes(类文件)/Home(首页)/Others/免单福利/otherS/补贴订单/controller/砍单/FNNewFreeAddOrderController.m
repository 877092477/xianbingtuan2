//
//  FNNewFreeAddOrderController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNNewFreeAddOrderController.h"

@interface FNNewFreeAddOrderController ()

@property (nonatomic, strong) UILabel *lblTip;
@property (nonatomic, strong) UIImageView *imgIcon;
@property (nonatomic, strong) UITextField *txvInput;
@property (nonatomic, strong) UIView *vLine;
@property (nonatomic, strong) UIButton *btnSubmit;

@end

@implementation FNNewFreeAddOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"补充单号";
    
    [self configUI];
}

- (void)configUI {
    _lblTip = [[UILabel alloc] init];
    _imgIcon = [[UIImageView alloc] init];
    _txvInput = [[UITextField alloc] init];
    _vLine = [[UIView alloc] init];
    _btnSubmit = [[UIButton alloc] init];
    
    [self.view addSubview: _lblTip];
    [self.view addSubview: _imgIcon];
    [self.view addSubview: _txvInput];
    [self.view addSubview: _vLine];
    [self.view addSubview: _btnSubmit];
    
    [_lblTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
        make.top.equalTo(@30);
    }];
    [_imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.top.equalTo(self.lblTip.mas_bottom).offset(30);
        make.width.height.mas_equalTo(20);
    }];
    
    [_txvInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgIcon.mas_right).offset(10);
        make.right.equalTo(@-30);
        make.centerY.equalTo(self.imgIcon);
        make.height.mas_equalTo(20);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.txvInput.mas_bottom).offset(8);
    }];
    [_btnSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.top.equalTo(self.vLine.mas_bottom).offset(30);
        make.height.mas_equalTo(50);
    }];
    
    _lblTip.text = @"温馨提示：请输入正确的订单号，避免审核不通过";
    _lblTip.textColor = RGB(200, 200, 200);
    _lblTip.font = kFONT13;
    _lblTip.numberOfLines = 0;
    
    _imgIcon.image = IMAGE(@"new_free_order_icon");
    _imgIcon.contentMode = UIViewContentModeScaleAspectFit;
    
    _txvInput.placeholder = @"请输入购买商品的订单号";
    
    _vLine.backgroundColor = RGB(200, 200, 200);
    
    _btnSubmit.backgroundColor = RED;
    _btnSubmit.cornerRadius = 5;
    [_btnSubmit setTitle:@"确定" forState:UIControlStateNormal];
    [_btnSubmit setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [_btnSubmit addTarget:self action:@selector(onSubmit)];
}

- (void)onSubmit {
    NSString *str = _txvInput.text;
    if ([str kr_isNotEmpty])
        [self apiRequestAddOrderId:_orderId inputId:str];
    else
        [FNTipsView showTips: @"请输入订单号"];
}

- (FNRequestTool *)apiRequestAddOrderId: (NSString*)orderId inputId: (NSString*)inputId{
    
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token":UserAccessToken,@"id":orderId, @"orderId": inputId}];
    @weakify(self)
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=bargainDoing&ctrl=sub_order" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:NO isCache:NO];
}


@end
