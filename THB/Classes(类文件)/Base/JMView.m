//
//  JMView.m
//  SuperMode
//
//  Created by jimmy on 2017/6/8.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMView.h"

@implementation JMView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self jm_setupViews];
        [self jm_bindViewModel];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self jm_setupViews];
        [self jm_bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<JMViewModelProtocol>)viewModel{
    self = [super init];
    if (self) {
     
    }
    return self;
}
- (void)jm_bindViewModel {
    
}

- (void)jm_setupViews {
}

- (void)jm_addReturnKeyBoard {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.window endEditing:YES];
    }];
    [self addGestureRecognizer:tap];
}

#pragma mark - setter && getter
- (UITableView *)jm_tableview{
    if (_jm_tableview == nil) {
        _jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
        _jm_tableview.dataSource = self;
        _jm_tableview.delegate = self;
        _jm_tableview.backgroundColor = FNHomeBackgroundColor;
        _jm_tableview.emptyDataSetSource = self;
        _jm_tableview.emptyDataSetDelegate = self;
        [_jm_tableview removeEmptyCellRows];
    }
    return _jm_tableview;
}

- (void)setJm_collectionview:(UICollectionView *)jm_collectionview{
    _jm_collectionview = jm_collectionview;
    _jm_collectionview.emptyDataSetDelegate = self;
    _jm_collectionview.emptyDataSetSource = self;
    _jm_collectionview.backgroundColor = FNWhiteColor;
}
#pragma mark - DZNEmptyDataSetSource
- (nullable NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSAttributedString *att = [[NSAttributedString alloc]initWithString:@"暂无数据" attributes:@{NSFontAttributeName:kFONT14,NSForegroundColorAttributeName:FNGlobalTextGrayColor}];
    return att;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"pcresults_empty"];
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{
    return YES;
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
@end
