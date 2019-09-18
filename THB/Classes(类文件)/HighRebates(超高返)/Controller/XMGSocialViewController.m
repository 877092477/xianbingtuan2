//
//  XMGSocialViewController.m
//  02-网易新闻首页
//
//  Created by xiaomage on 15/7/6.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGSocialViewController.h"
#import "XYConst.h"

@interface XMGSocialViewController ()

@end

@implementation XMGSocialViewController

static NSString *ID = @"social";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    NSLog(@"XMGSocialViewController - %f %f %f", XMGRed, XMGGreen, XMGBlue);
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %zd", self.title, indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"di %ld",(long)indexPath.row);
}
@end
