//
//  FNMemberPopAmendEvView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNMemberPopAmendEvView.h"

@implementation FNMemberPopAmendEvView

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        [self initializedSubviews];
    } return self;
}
// 准备弹出(初始化弹层位置)
- (void)willPopupContainer:(DSHPopupContainer *)container; {
    CGRect frame = self.frame;
    frame.size = CGSizeMake(FNDeviceWidth-50, 200);
    frame.origin.x = 25;
    frame.origin.y = container.frame.size.height/2-100;
    self.frame = frame;
}

// 已弹出(做弹出动画)
- (void)didPopupContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.6f;//0.6f;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.layer addAnimation:animation forKey:nil];
}

// 将要移除(做移除动画)
- (void)willDismissContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    [UIView animateWithDuration:0.6f animations:^{
        self.transform = (CGAffineTransformMakeScale(0.1, 0.1));
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    } ];
}
- (void)initializedSubviews{
    //self.dataArr=@[@"修改评价",@"取消匿名",@"删除评价",@"取消"];
    self.tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.backgroundColor = [UIColor whiteColor];
    self.tableview.rowHeight = 50;
    self.tableview.sectionHeaderHeight=0;
    self.tableview.sectionFooterHeight=0;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellID"];
    [self addSubview:self.tableview];
    self.tableview.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    self.tableview.showsVerticalScrollIndicator = NO;
    self.tableview.showsHorizontalScrollIndicator = NO;
    
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
} 
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    cell.textLabel.text=self.dataArr[indexPath.row];
    cell.textLabel.font=kFONT15;
    cell.textLabel.textColor=RGB(51, 51, 51);
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(didMemberPopAmendTypeAction:)]) {
        [self.delegate didMemberPopAmendTypeAction:indexPath.row];
    }
}
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr){
        [self.tableview reloadData];
    }
}
@end
