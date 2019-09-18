//
//  COFSelectivityView.m
//  THB
//
//  Created by Jimmy on 2018/8/29.
//  Copyright © 2018年 方诺科技. All rights reserved.
//
#define kScreen_Width   [[UIScreen mainScreen] bounds].size.width
#define kScreen_Height  [[UIScreen mainScreen] bounds].size.height
#import "COFSelectivityView.h"
#import "COFSelectlectivityCell.h"

@interface COFSelectivityView ()
{
    CGFloat alertViewHeight;//弹框整体高度，默认250
    CGFloat buttonHeight;//按钮高度，默认40
}

@property (nonatomic, strong) NSArray *datas;//数据源
@property (nonatomic, assign) BOOL ifSupportMultiple;//是否支持多选功能
@property (nonatomic, strong) UILabel *titleLabel;//标题label
@property (nonatomic, strong) UIView *alertView;//弹框视图
@property (nonatomic, strong) UITableView *selectTableView;//选择列表
@property (nonatomic, strong) UIButton *confirmButton;//确定按钮
@property (nonatomic, strong) UIButton *cancelButton;//取消按钮

@property (nonatomic, assign) NSIndexPath *selectIndexPath;//选择项的下标(单选)
@property (nonatomic, strong) NSMutableArray *selectArray;//选择项的下标数组(多选)


@end

@implementation COFSelectivityView

-(instancetype)initWithTitle:(NSString *)title
                       datas:(NSArray *)datas
           ifSupportMultiple:(BOOL)ifSupportMultiple{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
        alertViewHeight = 250;
        buttonHeight = 40;
        self.selectArray = [NSMutableArray array];
        
        self.alertView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreen_Height/2.0-40, kScreen_Width, kScreen_Height/2.0+40)];
        self.alertView.backgroundColor = FNColor(246,246,246);
        //self.alertView.layer.cornerRadius = 8;
        //self.alertView.layer.masksToBounds = YES;
        [self addSubview:self.alertView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, self.alertView.frame.size.width-100, buttonHeight+10)];
        self.titleLabel.text = title;
        self.titleLabel.backgroundColor = FNColor(246,246,246);
        self.titleLabel.textColor = [UIColor grayColor];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.alertView addSubview:self.titleLabel];
        
        //取消
       self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
       self.cancelButton.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+25,17.5, 15, 15);
       //self.cancelButton.backgroundColor = [UIColor whiteColor];
        //[self.cancelButton setBackgroundImage:[UIImage imageNamed:@"issue_close"] forState:UIControlStateNormal];
        [self.cancelButton setImage:[UIImage imageNamed:@"issue_close"] forState:UIControlStateNormal];
       //[self.cancelButton setTitle:@"✖️" forState:UIControlStateNormal];
       //[self.cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
       //self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
       [self.cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
       [self.alertView addSubview:self.cancelButton];
        
        self.selectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), kScreen_Width, self.alertView.bounds.size.height-buttonHeight*3-15) style:UITableViewStylePlain];
        self.selectTableView.delegate = self;
        self.selectTableView.dataSource = self;
        self.datas = datas;
        self.ifSupportMultiple = ifSupportMultiple;
        [self.alertView addSubview:self.selectTableView];
        
        if (self.ifSupportMultiple == YES){
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
            [self.selectTableView addGestureRecognizer:tap];
            [tap addTarget:self action:@selector(clickTableView:)];
        }
        
        self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.confirmButton.cornerRadius=5;
        self.confirmButton.frame = CGRectMake(20,CGRectGetMaxY(self.selectTableView.frame)+30, self.alertView.frame.size.width-40, buttonHeight+5);
        self.confirmButton.backgroundColor = FNColor(249, 67, 124);
        [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        self.confirmButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.confirmButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:self.confirmButton];
        

        
    }
    return self;
}

-(void)show{
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.alertView.alpha = 0.0;
    [UIView animateWithDuration:0.05 animations:^{
        self.alertView.alpha = 1;
    }];
}

//手势事件
- (void)clickTableView:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self.selectTableView];
    NSIndexPath *indexPath = [self.selectTableView indexPathForRowAtPoint:point];
    if (indexPath == nil) {
        return;
    }
    
    if ([self.selectArray containsObject:@(indexPath.row)]) {
        [self.selectArray removeObject:@(indexPath.row)];
    }else {
        [self.selectArray addObject:@(indexPath.row)];
    }
    
    //按照数据源下标顺序排列
    [self.selectArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    [self.selectTableView reloadData];
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    COFSelectlectivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDYSelectivityTableViewCell"];
    if (cell == nil) {
        cell = [[COFSelectlectivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LDYSelectivityTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.ifSupportMultiple == NO) {
        if (self.selectIndexPath == indexPath) {
            cell.selectIV.image = [UIImage imageNamed:@"issue_yes"];
        }else{
            cell.selectIV.image = [UIImage imageNamed:@""];
        }
    }else{
        if ([self.selectArray containsObject:@(indexPath.row)]) {
            cell.selectIV.image = [UIImage imageNamed:@"issue_yes"];
        }else {
            cell.selectIV.image = [UIImage imageNamed:@""];
        }
    }
    cell.titleLabel.text = _datas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    COFSelectlectivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDYSelectivityTableViewCell"];
    if (self.ifSupportMultiple == NO) {
        self.selectIndexPath = indexPath;
        [tableView reloadData];
    }else{
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

//点击空白处
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    if (!CGRectContainsPoint([self.alertView frame], pt)) {
        [self cancelAction];
    }
}

//点击确定
- (void)confirmAction{
    if (self.ifSupportMultiple == NO) {
        NSString *data = self.datas[self.selectIndexPath.row];
        if (_delegate && [_delegate respondsToSelector:@selector(singleChoiceBlockData:withRow:)])
        {
            [_delegate singleChoiceBlockData:data withRow:self.selectIndexPath.row];
        }
    }else{
        NSMutableArray *dataAr = [NSMutableArray array];
        [self.selectArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSNumber *data = obj;
            int row = [data intValue];
            [dataAr addObject:self.datas[row]];
        }];
        
        NSArray *datas = [NSArray arrayWithArray:dataAr];
        if (_delegate && [_delegate respondsToSelector:@selector(multipleChoiceBlockDatas:)])
        {
            [_delegate multipleChoiceBlockDatas:datas];
        }
    }
    [self cancelAction];
}

//点击取消
- (void)cancelAction {
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
