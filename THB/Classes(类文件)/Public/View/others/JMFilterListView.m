//
//  JMFilterListView.m
//  Two_Code
//
//  Created by jimmy on 2017/2/13.
//  Copyright © 2017年 Jimmy_Ng. All rights reserved.
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
#import "JMFilterListView.h"

@interface JMFilterListView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView* tableView;
@end
@implementation JMFilterListView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView removeEmptyCellRows];
    [self addSubview:_tableView];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
}
- (void)setList:(NSArray *)list{
    _list = list;
    @WeakObj(self);
    if (_list.count > 0) {
        CGFloat height = FNDeviceHeight*0.5;
        if (_list.count*44 <= height) {
            height = _list.count * 44;
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            selfWeak.height = height;
        }completion:^(BOOL finished) {
            selfWeak.hidden = NO;
            [selfWeak.tableView reloadData];
        }];
        
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            selfWeak.height = 0;
        }completion:^(BOOL finished) {
            selfWeak.hidden = YES;
        }];
        
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* reuseID = @"normal cell";
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseID];
        cell.textLabel.font = kFONT14;
    }
    if (self.currentindex == indexPath.row) {
        cell.textLabel.textColor = RED;
    }else{
        cell.textLabel.textColor = FNBlackColor;
    }
    cell.textLabel.text = _list[indexPath.row];
    return cell;
}
#pragma mark - Tabel view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.selectedAtIndexpath) {
        self.currentindex = indexPath.row;
        self.selectedAtIndexpath(indexPath,_list[indexPath.row]);
        [tableView reloadData];
    }
}
@end
