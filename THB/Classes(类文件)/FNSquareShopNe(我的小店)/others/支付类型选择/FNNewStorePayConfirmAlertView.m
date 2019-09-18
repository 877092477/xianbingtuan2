//
//  FNNewStorePayConfirmAlertView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/1.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStorePayConfirmAlertView.h"
#import "FNrushPurchaseNeModel.h"
#import "FNNewStorePayConfirmCell.h"

@interface FNNewStorePayConfirmAlertView() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *btnBg;
@property (nonatomic, strong) UIView *vAlert;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIButton *btnClose;

@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UITableView *tbvCoupone;

@property (nonatomic, strong) UIView *vBottom;
@property (nonatomic, strong) UIView *vLeft;
@property (nonatomic, strong) UIButton *btnPay;
@property (nonatomic, strong) UILabel *lblBottomPrice;
@property (nonatomic, strong) UILabel *lblCommission;
@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, copy) NSString *payType;
@property (nonatomic, strong) FNrushPurchaseNeModel *model;

@end

@implementation FNNewStorePayConfirmAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _btnBg = [[UIButton alloc] init];;
    _vAlert = [[UIView alloc] init];;
    _lblTitle = [[UILabel alloc] init];;
    _btnClose = [[UIButton alloc] init];;
    _lblPrice = [[UILabel alloc] init];;
    _tbvCoupone = [[UITableView alloc] init];;
    _vLine = [[UIView alloc] init];;
    
    _vBottom = [[UIButton alloc] init];
    _vLeft = [[UIView alloc] init];
    _btnPay = [[UIButton alloc] init];
    _lblBottomPrice = [[UILabel alloc] init];
    _lblCommission = [[UILabel alloc] init];
    
    [self addSubview:_btnBg];
    [self addSubview:_vAlert];
    [_vAlert addSubview:_lblTitle];
    [_vAlert addSubview:_btnClose];
    [_vAlert addSubview:_lblPrice];
    [_vAlert addSubview:_tbvCoupone];
    
    [_vAlert addSubview:_vBottom];
    [_vBottom addSubview:_vLeft];
    [_vBottom addSubview:_btnPay];
    [_vLeft addSubview:_lblBottomPrice];
    [_vLeft addSubview:_lblCommission];
    [_vLeft addSubview:_vLine];
    
    [_btnBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_vAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.mas_bottom);
        make.height.mas_equalTo(400);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@18);
    }];
    [_btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lblTitle);
        make.right.equalTo(@-10);
        make.width.height.mas_equalTo(24);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
        make.top.equalTo(@70);
    }];
    [_tbvCoupone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.lblPrice.mas_bottom).offset(10);
        make.bottom.equalTo(@-20);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.vBottom);
        make.height.mas_equalTo(1);
    }];
    [_vBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(isIphoneX ? @-34 : @0);
        make.height.mas_equalTo(50);
    }];
    [_vLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(@0);
        make.right.equalTo(self.btnPay.mas_left);
    }];
    [_btnPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(@0);
        make.width.mas_equalTo(145);
    }];
    [_lblBottomPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@24);
        make.right.equalTo(@-24);
        make.top.equalTo(@7);
    }];
    [_lblCommission mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@24);
        make.right.equalTo(@-24);
        make.top.equalTo(self.lblBottomPrice.mas_bottom).offset(0);
    }];
    
    _btnBg.backgroundColor = RGBA(0, 0, 0, 0.2);
    
    _vAlert.layer.backgroundColor = UIColor.whiteColor.CGColor;
    _vAlert.layer.cornerRadius = 13;
    
    _lblTitle.text = @"确认付款";
    _lblTitle.font = [UIFont boldSystemFontOfSize:15];
    
    [_btnClose setImage:IMAGE(@"store_coupone_close_button") forState: UIControlStateNormal];
    
    _lblPrice.textColor = RGB(1, 1, 1);
    _lblPrice.font = [UIFont systemFontOfSize:34];
    
    _tbvCoupone.delegate = self;
    _tbvCoupone.dataSource = self;
    _tbvCoupone.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tbvCoupone.showsVerticalScrollIndicator = NO;
    [_tbvCoupone registerClass:[FNNewStorePayConfirmCell class] forCellReuseIdentifier:@"FNNewStorePayConfirmCell"];
    
    
    [_btnClose addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_btnBg addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    
    _lblBottomPrice.font = [UIFont boldSystemFontOfSize:24];
    _lblBottomPrice.textColor = RGB(255, 155, 48);
 
    _lblCommission.font = kFONT12;
    _lblCommission.textColor = RGB(200, 200, 200);
    
    _vLine.backgroundColor = RGB(232, 232, 232);
    
    _btnPay.backgroundColor = RGB(244, 47, 25);
    [_btnPay setTitleColor: UIColor.whiteColor forState: UIControlStateNormal];
    _btnPay.titleLabel.font = kFONT14;
    [_btnPay addTarget:self action:@selector(onPayClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNNewStorePayConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNNewStorePayConfirmCell"];
    if (indexPath.row == 0) {
        cell.lblTitle.text = @"店铺信息";
        cell.lblDesc.text = self.model.storename;
    } else if (indexPath.row == 1) {
        cell.lblTitle.text = @"付款方式";
        cell.lblDesc.text = _payType;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)show {
    [self layoutIfNeeded];
    self.hidden = NO;
    
    [_vAlert mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(400);
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
        make.height.mas_equalTo(400);
    }];
    [self setNeedsLayout];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        self.hidden = YES;
    }];
}

- (void)setModel: (FNrushPurchaseNeModel*) model payType: (NSString*)payType {
    _payType = payType;
    _model = model;
    
    _lblPrice.text = [NSString stringWithFormat: @"￥%@", model.sum];
    _lblBottomPrice.text = [NSString stringWithFormat: @"￥%@", model.sum];
    _lblCommission.text = model.str;
    [_btnPay setTitle: model.str1 forState: UIControlStateNormal];
    
    [self.tbvCoupone reloadData];
}

- (void)onPayClick {
    if ([_delegate respondsToSelector:@selector(didPayClick:)]) {
        [_delegate didPayClick:self];
    }
}

@end
