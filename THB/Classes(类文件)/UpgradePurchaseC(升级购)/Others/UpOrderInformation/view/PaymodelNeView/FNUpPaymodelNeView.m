//
//  FNUpPaymodelNeView.m
//  THB
//
//  Created by Jimmy on 2018/9/28.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpPaymodelNeView.h"
#import "FNUpPaymodelItemNeCell.h"
#import "FNUpOrderinformationNModel.h"
@interface FNUpPaymodelNeView () {
    CGFloat alertHeight;//弹框整体高度，默认250
    CGFloat buttonHeight;//按钮高度，默认40
}


//@property (nonatomic, assign) BOOL showCloseButton;//是否显示关闭按钮
@property (nonatomic, strong) UIView *alertView;//弹框视图
@property (nonatomic, strong) UITableView *selectTableView;//选择列表
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation FNUpPaymodelNeView


+ (FNUpPaymodelNeView *)showWithTitles:(NSArray *)titles selectIndex:(SelectIndex)selectIndex{
    FNUpPaymodelNeView *alert = [[FNUpPaymodelNeView alloc] initWithTitles:titles selectIndex:selectIndex];
    return alert;
}
- (instancetype)initWithTitles:(NSArray *)titles selectIndex:(SelectIndex)selectIndex{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
        alertHeight = 70 * titles.count + 60;
        
        buttonHeight = 50;
        
        _titles = titles;
        
        _selectIndex = [selectIndex copy];
        
        [self addSubview:self.alertView];
        [self.alertView addSubview:self.titleLabel];
        [self.alertView addSubview:self.closeButton];
        [self.alertView addSubview:self.selectTableView];
        
        [self initUI];

        [self show];
    }
    return self;
}
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 8;
        _alertView.layer.masksToBounds = YES;
    }
    return _alertView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text=@"选择支付方式";
        _titleLabel.backgroundColor =[UIColor whiteColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = kFONT16;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"btn_details_colse"] forState:0];
        [_closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}
- (UITableView *)selectTableView {
    if (!_selectTableView) {
        _selectTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _selectTableView.delegate = self;
        _selectTableView.dataSource = self;
        _selectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _selectTableView;
}
- (void)show {
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.alertView.alpha = 0.0;
    [UIView animateWithDuration:0.05 animations:^{
        self.alertView.alpha = 1;
    }];
}

- (void)initUI {
    self.alertView.frame = CGRectMake(10, (FNDeviceHeight-alertHeight)/2.0-30,FNDeviceWidth-20, alertHeight);
    self.titleLabel.frame = CGRectMake(40, 0, _alertView.frame.size.width-80, buttonHeight);
    self.closeButton.frame = CGRectMake(_alertView.frame.size.width-30, 15, 20, 20);
    CGFloat reduceHeight = buttonHeight;
    self.selectTableView.frame = CGRectMake(0, buttonHeight+1, _alertView.frame.size.width, _alertView.frame.size.height-reduceHeight-1);
}
#pragma UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FNUpPaymodelItemNeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectcell"];
    if (cell == nil) {
        cell = [[FNUpPaymodelItemNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectcell"];
    }
    [self configCell:cell data:self.titles[indexPath.row] indexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectIndex) {
        self.selectIndex(indexPath.row);
    }
    self.currentIndex=indexPath.row;
    FNUpPaymodelItemNeCell* cell = (FNUpPaymodelItemNeCell *)[_selectTableView cellForRowAtIndexPath:indexPath];
    cell.stateView.image =  [UIImage imageNamed:@"APP底图"];
    [self closeAction];
}

- (void)configCell:(FNUpPaymodelItemNeCell *)cell data:(id)data indexPath:(NSIndexPath *)indexPath{
    FNUpOrderAlipayNModel *model=[FNUpOrderAlipayNModel mj_objectWithKeyValues:data];
    cell.iconImgView.image = [UIImage imageNamed:data[@"pic"]];
    [cell.iconImgView setUrlImg:model.img];
    
    cell.titleLabel.text = model.str;
    NSInteger is_not_pay=[model.is_not_pay integerValue];
    if(is_not_pay==1){
       cell.desLabel.text = [NSString stringWithFormat:@"%@元",model.is_not_pay];
    }
    
   
    //cell.stateView.image =  [UIImage imageNamed:@"APP底图"];
    
   

}
- (void)closeAction {
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
