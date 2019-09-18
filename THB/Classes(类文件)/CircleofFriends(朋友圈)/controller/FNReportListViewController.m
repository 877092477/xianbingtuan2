//
//  FNReportListViewController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/5/6.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNReportListViewController.h"

static NSString *reusreIdentifier = @"UITableViewCellStyleDefault";

@interface FNReportListViewController ()
@property (nonatomic, copy) NSArray *dataSourceArray;
@end

@implementation FNReportListViewController
#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:reusreIdentifier];
    //    self.tableView.tableFooterView  = [UIView new];
    self.tableView.scrollEnabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Custom Accessors

- (NSArray *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = @[@"举报",@"屏蔽此条动态",@"屏蔽TA的动态"];
    }
    return _dataSourceArray;
}

#pragma mark - Private
#pragma mark 重写 preferredContentSize, 返回 popover 的大小
/**
 *  此方法会返回一个由 UIKit 子类调用后得到的Size ,此size即是完美适应调用此方法的UIKit子类的size
 *  得到此size后, 可以调用 调整弹框大小的方法 **preferredContentSize** 配合使用
 *  重置本控制器的大小
 */
- (CGSize)preferredContentSize {
    if (self.presentingViewController && self.tableView) {
        CGSize tempSize = self.presentingViewController.view.bounds.size;
        tempSize.width = 150;//
        // 返回一个完美适应tableView的大小的 size;
        // sizeThatFits 返回的是最合适的尺寸, 但不会改变控件的大小
        CGSize size = [self.tableView sizeThatFits:tempSize];
        return size;
    }else{
        return [self preferredContentSize];
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:reusreIdentifier
                                    forIndexPath:indexPath];
//    cell.textLabel.textColor = [UIColor blueColor];
    cell.textLabel.text = self.dataSourceArray[indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"selected the row of %ld",indexPath.row);
    if ([_delegate respondsToSelector:@selector(onItemClick:)]) {
        [_delegate onItemClick:indexPath.row];
    }
}


@end
