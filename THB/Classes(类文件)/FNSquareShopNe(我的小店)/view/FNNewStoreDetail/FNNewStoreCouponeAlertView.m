//
//  FNNewStoreCouponeAlertView.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/26.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStoreCouponeAlertView.h"
#import "FNNewStoreCouponeAlertCell.h"

@interface FNNewStoreCouponeAlertView() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *btnBg;
@property (nonatomic, strong) UIView *vAlert;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIButton *btnClose;

@property (nonatomic, strong) UILabel *lblDesc;
@property (nonatomic, strong) UITableView *tbvCoupone;

@property (nonatomic, strong) NSArray<FNstoreCouponeModel*>* coupones;

@end

@implementation FNNewStoreCouponeAlertView

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
    _lblDesc = [[UILabel alloc] init];;
    _tbvCoupone = [[UITableView alloc] init];;
    
    [self addSubview:_btnBg];
    [self addSubview:_vAlert];
    [_vAlert addSubview:_lblTitle];
    [_vAlert addSubview:_btnClose];
    [_vAlert addSubview:_lblDesc];
    [_vAlert addSubview:_tbvCoupone];
    
    [_btnBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_vAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@-20);
        make.height.mas_equalTo(0);
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
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.equalTo(@70);
    }];
    [_tbvCoupone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.lblDesc.mas_bottom).offset(10);
        make.bottom.equalTo(@-20);
    }];
    
    _btnBg.backgroundColor = RGBA(0, 0, 0, 0.2);
    
    _vAlert.layer.backgroundColor = UIColor.whiteColor.CGColor;
    _vAlert.layer.cornerRadius = 13;
    
    _lblTitle.text = @"优惠券";
    _lblTitle.font = [UIFont boldSystemFontOfSize:15];
    
    [_btnClose setImage:IMAGE(@"store_coupone_close_button") forState: UIControlStateNormal];
    
    _lblDesc.text = @"可领取优惠券";
    _lblDesc.textColor = RGB(51, 51, 51);
    _lblDesc.font = kFONT15;
    
    _tbvCoupone.delegate = self;
    _tbvCoupone.dataSource = self;
    _tbvCoupone.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tbvCoupone.showsVerticalScrollIndicator = NO;
    [_tbvCoupone registerClass:[FNNewStoreCouponeAlertCell class] forCellReuseIdentifier:@"FNNewStoreCouponeAlertCell"];
    
    
    [_btnClose addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_btnBg addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _coupones.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNNewStoreCouponeAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNNewStoreCouponeAlertCell"];
    [cell setModel:_coupones[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegate respondsToSelector:@selector(onCouponeClickAt:)]) {
        [_delegate onCouponeClickAt:indexPath.row];
    }
}

- (void)setCoupones: (NSArray<FNstoreCouponeModel*>*) coupones {
    _coupones = coupones;
    [self.tbvCoupone reloadData];
}

- (void)show {
    [self layoutIfNeeded];
    self.hidden = NO;
    
    [_vAlert mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(556);
    }];
    [self setNeedsLayout];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)dismiss {
    
    [_vAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    [self setNeedsLayout];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        self.hidden = YES;
    }];
}

@end
