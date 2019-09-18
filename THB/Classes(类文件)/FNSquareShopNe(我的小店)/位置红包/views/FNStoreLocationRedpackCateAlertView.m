//
//  FNStoreLocationRedpackCateAlertView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/23.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreLocationRedpackCateAlertView.h"
#import "FNStoreLocationRepackCateCell.h"
#import "FNNetCouponeRechargeHeaderCell.h"

@interface FNStoreLocationRedpackCateAlertView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *btnBg;
@property (nonatomic, strong) UITableView *tbvCate;
@property (nonatomic, strong) NSArray<FNStoreLocationRepackCateModel*>* cates;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation FNStoreLocationRedpackCateAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _btnBg = [[UIButton alloc] init];
    _tbvCate = [[UITableView alloc] init];
    
    [self addSubview:_btnBg];
    [self addSubview:_tbvCate];
    
    [_btnBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_tbvCate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@60);
        make.right.equalTo(@-13);
        make.width.mas_equalTo(140);
    }];
    
    _btnBg.backgroundColor = RGBA(51, 51, 51, 0.2);
    [_btnBg addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    _tbvCate.backgroundColor = UIColor.whiteColor;
    _tbvCate.dataSource = self;
    _tbvCate.delegate = self;
    _tbvCate.showsVerticalScrollIndicator = NO;
    _tbvCate.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tbvCate.cornerRadius = 5;
    [_tbvCate registerClass:[FNStoreLocationRepackCateCell class] forCellReuseIdentifier:@"FNStoreLocationRepackCateCell"];
    [_tbvCate registerClass:[FNNetCouponeRechargeHeaderCell class]  forHeaderFooterViewReuseIdentifier:@"FNNetCouponeRechargeHeaderCell"];
    
    self.hidden = YES;
}

- (void)show: (NSArray<FNStoreLocationRepackCateModel*>*)cates above: (UIView*)sender {
    [_tbvCate mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@60);
        make.right.equalTo(@-13);
        make.width.mas_equalTo(140);
        make.bottom.equalTo(sender.mas_top).offset(-10);
    }];
    _cates = cates;
    [_tbvCate reloadData];
    self.hidden = NO;
}

- (void)dismiss {
    self.hidden = YES;
}

- (void)closeAction {
    [self dismiss];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cates.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNStoreLocationRepackCateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNStoreLocationRepackCateCell"];
    FNStoreLocationRepackCateModel *cate = _cates[indexPath.row];
    
    [cell setModel: cate];
    [cell setIsSelected: indexPath.row == _currentIndex ];
    
    return cell;
    
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    FNNetCouponeRechargeHeaderCell *headerView = [[FNNetCouponeRechargeHeaderCell alloc]initWithReuseIdentifier:@"FNNetCouponeRechargeHeaderCell"];
    headerView.lblTitle.text = @"分类";
    headerView.lblTitle.textColor = RGB(51, 51, 51);
    headerView.lblTitle.font = [UIFont boldSystemFontOfSize:15];
    return headerView;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegate respondsToSelector:@selector(alertView:didItemSelectedAt:)]) {
        [_delegate alertView:self didItemSelectedAt: indexPath.row];
    }
    _currentIndex = indexPath.row;
}


@end
