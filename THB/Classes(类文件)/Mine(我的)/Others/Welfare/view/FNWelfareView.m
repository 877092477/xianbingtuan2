//
//  FNWelfareView.m
//  THB
//
//  Created by Jimmy on 2018/1/15.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNWelfareView.h"
#import "FNWelfareViewModel.h"
#import "FNImageTableViewCell.h"

@interface FNWelfareView()
@property (nonatomic, strong)FNWelfareViewModel* viewmodel;
@property (nonatomic, strong)NSMutableArray *heights;
@end
@implementation FNWelfareView

- (instancetype)initWithViewModel:(id<JMViewModelProtocol>)viewModel{
    self.viewmodel = (FNWelfareViewModel*) viewModel;
    return [super initWithViewModel:viewModel];
}
- (void)jm_setupViews{
    _heights = [[NSMutableArray alloc] init];
    self.backgroundColor = FNHomeBackgroundColor;
    self.jm_tableview.alpha = 0;
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.jm_tableview];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.showsVerticalScrollIndicator = NO;
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, 10, 0, 10))];
//    self.jm_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self.viewmodel.refreshDataCommand execute:nil];
//    }];
}
- (void)jm_bindViewModel{
    [SVProgressHUD show];
    [self.viewmodel.refreshDataCommand execute:nil];
    [[self.viewmodel.refreshUI takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
//        [self.jm_tableview reloadData];
        [self loadImages];
        [UIView animateWithDuration:0.5 animations:^{
            self.jm_tableview.alpha = 1;
        }];
    }];
}

- (void)loadImages {
    [_heights removeAllObjects];
//    self.viewmodel.list[indexPath.section].img
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (MenuModel* model in self.viewmodel.list) {
        [images addObject:model.img];
        [_heights addObject:@(0)];
    }
    [self.jm_tableview reloadData];
    @weakify(self)
    [XYNetworkAPI downloadImages:images withIndexBlock:^(UIImage *image, NSInteger index) {
        @strongify(self)
        CGFloat height = image.size.height/image.size.width*(JMScreenWidth - 20);
        
        NSLog(@"%f  %f  %f  %f", height, image.size.height, image.size.width, JMScreenWidth);
        self.heights[index] = @(height);
        [self.jm_tableview reloadData];
    } failureBlock:^(NSError *error) {
        
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewmodel.list.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* reuseID = @"imagecell";
    FNImageTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (cell == nil) {
        cell = [[FNImageTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseID];
        cell.imageView.backgroundColor =[UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [SDWebImageManager.sharedManager downloadImageWithURL:URL(self.viewmodel.list[indexPath.section].img) options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (finished) {
            [cell setImage: image];
        }
    }];
//    [cell.imageView setUrlImg:self.viewmodel.list[indexPath.section].img];
//    [cell.imageView sd_setImageWithURL:URL(self.viewmodel.list[indexPath.section].img)];
//    [cell.imageView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
//    [cell.imageView addJXTouchWithObject:^(UIImageView* obj) {
//        NSInteger tag = obj.tag-100;
//        [self.viewmodel.cellClickSubject sendNext:self.viewmodel.list[tag]];
//    }];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL:URL(self.viewmodel.list[indexPath.section].img)]];
//
//    CGFloat height = image.size.height/image.size.width*(JMScreenWidth-_jmsize_10*2);
//    return height;
    return [_heights[indexPath.section] floatValue];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 10;
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat height = 0.01;
    return height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.viewmodel.cellClickSubject sendNext:self.viewmodel.list[indexPath.section]];
}
@end
