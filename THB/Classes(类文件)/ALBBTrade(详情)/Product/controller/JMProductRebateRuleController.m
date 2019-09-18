//
//  JMProductRebateRuleController.m
//  THB
//
//  Created by jimmy on 2017/4/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMProductRebateRuleController.h"
#import "JMProductRebateRuleCell.h"
#import "JMProductDetailModel.h"
const CGFloat _product_headerHeight = 80;
@interface JMProductRebateRuleController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIView* headerView;
@end

@implementation JMProductRebateRuleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializedSubviews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    
    [self setupheaderView];
    
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.jm_tableview.dataSource =self;
    self.jm_tableview.delegate = self;
    [self.jm_tableview removeEmptyCellRows];
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [self.jm_tableview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.headerView];
    
    
}
- (void)setupheaderView{
    _headerView  = [UIView new];
    [self.view addSubview:_headerView];
    [_headerView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [_headerView autoSetDimension:(ALDimensionHeight) toSize:_product_headerHeight];
    UILabel* titleLabel = [UILabel new];
    titleLabel.font = kFONT17;
    titleLabel.text = @"购买本商品";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:titleLabel];
    
    UILabel* rebateLabel = [UILabel new];
    rebateLabel.font = kFONT17;
    rebateLabel.text = [NSString stringWithFormat:@"可获得%@的返利",self.commission];
    rebateLabel.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:rebateLabel];
    [rebateLabel addSingleAttributed:@{NSForegroundColorAttributeName:RED} ofRange:[rebateLabel.text rangeOfString:self.commission]];
    
    UIButton* closeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [closeBtn setImage:IMAGE(@"good_detail_close") forState:UIControlStateNormal];
    [closeBtn sizeToFit];
    [closeBtn addTarget:self action:@selector(closeButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.headerView addSubview:closeBtn];
    
    
    [closeBtn autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
    [closeBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:8];
    [closeBtn autoSetDimensionsToSize:CGSizeMake(closeBtn.width+10, closeBtn.height+10)];
    
    [titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_leftMargin];
    [titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_leftMargin];
    [titleLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:closeBtn];
    
    [rebateLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_leftMargin];
    [rebateLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_leftMargin];
    [rebateLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:titleLabel withOffset:_jm_margin10];
    
    
    
    
}
- (void)closeButtonAction{
    if (self.closeButtonBlock) {
        self.closeButtonBlock();
    }
}
#pragma mark -  Table view  data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JMProductRebateRuleCell* cell = [JMProductRebateRuleCell cellWithTableView:tableView atIndexPath:indexPath];
    cell.questionLabel.text = self.list[indexPath.row].title;
    cell.answerLabel.text  = self.list[indexPath.row].content;
    return cell;
}

#pragma mark -  Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = self.list[indexPath.row].height;
    return height;
}
@end
