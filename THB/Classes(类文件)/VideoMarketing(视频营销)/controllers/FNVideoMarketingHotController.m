//
//  FNVideoMarketingHotController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNVideoMarketingHotController.h"
#import "FNVideoHotCell.h"
#import "FNVideoMarketingModel.h"
#import "FNVideoWebController.h"
#import "FNVideoMarketingPlayerController.h"

@interface FNVideoMarketingHotController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<FNVideoMarketingItemModel*> *dataArray;

@end

@implementation FNVideoMarketingHotController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc] init];
    self.title = @"热门推荐";
    [self configUI];
    [self requestMain];
}

- (void)configUI {
    self.jm_tableview = [[UITableView alloc] init];
    [self.view addSubview:self.jm_tableview];
    self.jm_tableview.backgroundColor = FNHomeBackgroundColor;
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jm_tableview.delegate = self;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.estimatedSectionFooterHeight = 0;
    self.jm_tableview.estimatedSectionHeaderHeight = 0;
    [self.jm_tableview registerClass:[FNVideoHotCell class] forCellReuseIdentifier:@"FNVideoHotCell"];
    
    @weakify(self)
    self.jm_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.jm_page = 1;
        [self requestMain];
    }];
    self.jm_tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMain)];
    
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
}

#pragma UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FNVideoHotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNVideoHotCell"];
    FNVideoMarketingItemModel *item = self.dataArray[indexPath.row];
    [cell.imgHeader sd_setImageWithURL:URL(item.img)];
    cell.lblTitle.text = item.name;
    cell.lblDesc.text = item.info1;
    cell.lblActor.text = item.info2;
    cell.lblHot.text = [NSString stringWithFormat:@"热度 %@", item.hot];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FNVideoMarketingItemModel *item = self.dataArray[indexPath.row];
    if ([item.is_visit isEqualToString:@"1"]) {
        if ([item.show_type isEqualToString:@"1"]) {
            FNVideoWebController *vc = [[FNVideoWebController alloc] init];
            vc.url = item.movie_url;
            vc.title = item.name;
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            FNVideoMarketingPlayerController *vc = [[FNVideoMarketingPlayerController alloc] init];
            vc.model = item;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
        [self showAlert:item.visit_str];
    }
}

- (void)showAlert: (NSString*)str {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message: str preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Networking
- (FNRequestTool*) requestMain {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"p": @(self.jm_page)}];
    [SVProgressHUD show];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=app_movie&ctrl=hot_movie" respondType:(ResponseTypeArray) modelType:@"FNVideoMarketingItemModel" success:^(id respondsObject) {
        @strongify(self);
        
        if (self.jm_page == 1) {
            [self.dataArray removeAllObjects];
        }
        NSArray* array = respondsObject;
        if (array.count > 0)
            self.jm_page ++;
        self.jm_tableview.mj_footer.hidden = array.count <= 0;
        
        [self.dataArray addObjectsFromArray:respondsObject];
        [self.jm_tableview reloadData];
        [SVProgressHUD dismiss];
        [self.jm_tableview.mj_footer endRefreshing];
        [self.jm_tableview.mj_header endRefreshing];
    } failure:^(NSString *error) {
        
        [SVProgressHUD dismiss];
    } isHideTips:YES isCache:NO];
}


@end
