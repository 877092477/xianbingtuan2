//
//  FNNewStoreCarAlertView.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/27.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStoreCarAlertView.h"
#import "FNNewStoreCarAlertCell.h"

@interface FNNewStoreCarAlertView()<UITableViewDelegate, UITableViewDataSource, FNNewStoreCarAlertCellDelegate>

@property (nonatomic, strong) UIButton *btnBg;
@property (nonatomic, strong) UIView *vAlert;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIButton *btnClear;

@property (nonatomic, strong) UITableView *tbvCar;

@property (nonatomic, strong) NSArray<FNStoreCarModel*> *cars;

@end

@implementation FNNewStoreCarAlertView

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
    _btnClear = [[UIButton alloc] init];;
    _tbvCar = [[UITableView alloc] init];;
    
    [self addSubview:_btnBg];
    [self addSubview:_vAlert];
    [_vAlert addSubview:_lblTitle];
    [_vAlert addSubview:_btnClear];
    [_vAlert addSubview:_tbvCar];
    
    [_btnBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_vAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.mas_equalTo(0);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@13);
        make.top.equalTo(@10);
    }];
    [_btnClear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lblTitle);
        make.right.equalTo(@-10);
    }];
    [_tbvCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(10);
        make.bottom.equalTo(@-20);
    }];
    
    _btnBg.backgroundColor = RGBA(0, 0, 0, 0.2);
    
    _vAlert.layer.backgroundColor = UIColor.whiteColor.CGColor;
//    _vAlert.layer.cornerRadius = 13;
    
    _lblTitle.text = @"已选商品";
    _lblTitle.font = kFONT15;
    
    [_btnClear setTitle: @"清空" forState: UIControlStateNormal];
    [_btnClear setTitleColor: RGB(102, 102, 102) forState: UIControlStateNormal];
    _btnClear.titleLabel.font = kFONT12;
    [_btnClear layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5.0f];
    [_btnClear setImage:IMAGE(@"store_goods_car_clear") forState: UIControlStateNormal];
    
    _tbvCar.delegate = self;
    _tbvCar.dataSource = self;
    _tbvCar.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tbvCar.showsVerticalScrollIndicator = NO;
    [_tbvCar registerClass:[FNNewStoreCarAlertCell class] forCellReuseIdentifier:@"FNNewStoreCarAlertCell"];
    
    
    [_btnClear addTarget:self action:@selector(onClearClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnBg addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    self.hidden = YES;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cars.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNNewStoreCarAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNNewStoreCarAlertCell"];
    [cell setModel:_cars[indexPath.row]];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ([_delegate respondsToSelector:@selector(onCouponeClickAt:)]) {
//        [_delegate onCouponeClickAt:indexPath.row];
//    }
}

- (void)setCars: (NSArray<FNStoreCarModel*>*) cars {
    _cars = cars;
    [self.tbvCar reloadData];
}

- (void)show {
    [self layoutIfNeeded];
    self.hidden = NO;
    
    [_vAlert mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(300);
    }];
    [self setNeedsLayout];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)dismiss {
    
    [_vAlert mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    [self setNeedsLayout];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        self.hidden = YES;
    }];
}

#pragma mark - FNNewStoreCarAlertCellDelegate

- (void)didSubClick: (FNNewStoreCarAlertCell*)cell{
    NSIndexPath *indexPath = [_tbvCar indexPathForCell:cell];
    if ([_delegate respondsToSelector:@selector(didSubClick:atIndex:)]) {
        [_delegate didSubClick:self atIndex: indexPath.row];
    }
}
- (void)didAddClick: (FNNewStoreCarAlertCell*)cell{
    NSIndexPath *indexPath = [_tbvCar indexPathForCell:cell];
    if ([_delegate respondsToSelector:@selector(didAddClick:atIndex:)]) {
        [_delegate didAddClick:self atIndex: indexPath.row];
    }
}

- (void)onClearClick {
    if ([_delegate respondsToSelector:@selector(didClearClick:)]) {
        [_delegate didClearClick:self];
    }
}

- (void)reloadData {
    [self.tbvCar reloadData];
}

@end
