//
//  FNNewStorePayTypeAlertView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/1.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStorePayTypeAlertView.h"
#import "FNNewStorePayTypeAlertCell.h"

@interface FNNewStorePayTypeAlertView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIButton *btnBg;
@property (nonatomic, strong) UIView *vAlert;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIButton *btnClose;
@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) UITableView *tbvPay;

@property (nonatomic, strong) NSArray<FNNewStorePayTypeModel*> *payTypes;

@end

@implementation FNNewStorePayTypeAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        
        [self apiRequestPayType];
    }
    return self;
}

- (void)configUI {
    _btnBg = [[UIButton alloc] init];
    _vAlert = [[UIView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _vLine = [[UIView alloc] init];
    _btnClose = [[UIButton alloc] init];
    _tbvPay = [[UITableView alloc] init];
    
    [self addSubview:_btnBg];
    [self addSubview:_vAlert];
    [_vAlert addSubview:_lblTitle];
    [_vAlert addSubview:_vLine];
    [_vAlert addSubview:_btnClose];
    [_vAlert addSubview:_tbvPay];
    
    [_btnBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_vAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.mas_bottom);
        make.height.mas_equalTo(422);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
        make.centerX.equalTo(@0);
        make.centerY.equalTo(self.vAlert.mas_top).offset(24);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@48);
        make.left.right.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    [_btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lblTitle);
        make.right.equalTo(@-10);
        make.width.height.mas_equalTo(24);
    }];
    [_tbvPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(isIphoneX ? @-74 : @-40);
        make.top.equalTo(self.vLine.mas_bottom);
    }];
    
    self.hidden = YES;
    
    _btnBg.backgroundColor = RGBA(0, 0, 0, 0.2);
    
    _vAlert.backgroundColor = UIColor.whiteColor;
    
    _lblTitle.text = @"选择支付方式";
    _lblTitle.font = [UIFont boldSystemFontOfSize:18];
    
    [_btnClose setImage:IMAGE(@"store_coupone_close_button") forState: UIControlStateNormal];

    _vLine.backgroundColor = RGB(200, 200, 200);
    
    _tbvPay.dataSource = self;
    _tbvPay.delegate = self;
    _tbvPay.backgroundColor=UIColor.clearColor;
    _tbvPay.showsVerticalScrollIndicator = NO;
    _tbvPay.bounces = NO;
    _tbvPay.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_tbvPay registerClass:[FNNewStorePayTypeAlertCell class] forCellReuseIdentifier:@"FNNewStorePayTypeAlertCell"];

    [_btnClose addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_btnBg addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _payTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FNNewStorePayTypeAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNNewStorePayTypeAlertCell"];
    
    FNNewStorePayTypeModel *model = _payTypes[indexPath.row];
    [cell.imgIcon sd_setImageWithURL: URL(model.img)];
    cell.lblTitle.text = model.str;
    cell.lblDesc.text = model.tips;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FNNewStorePayTypeModel *model = _payTypes[indexPath.row];
    if ([_delegate respondsToSelector:@selector(payTypeAlert:didSelected:)]) {
        [_delegate payTypeAlert:self didSelected: model];
    }
    [self dismiss];
}

- (void)show{
    [self layoutIfNeeded];
    self.hidden = NO;
    
    [_vAlert mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(422);
    }];
    [self setNeedsLayout];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)dismiss {
    
    [_vAlert mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.mas_bottom);
        make.height.mas_equalTo(422);
    }];
    [self setNeedsLayout];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        self.hidden = YES;
    }];
}


#pragma mark - Networking

- (FNRequestTool *)apiRequestPayType{
    @weakify(self)
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_suborder&ctrl=pay_type" respondType:(ResponseTypeArray) modelType:@"FNNewStorePayTypeModel" success:^(id respondsObject) {
        self.payTypes = respondsObject;
        [SVProgressHUD dismiss];
        
        [self.tbvPay reloadData];
        
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:YES];
}

@end
