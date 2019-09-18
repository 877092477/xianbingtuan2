//
//  FNStoreMyCouponeController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/2.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreMyCouponeController.h"
#import "FNStoreMyCouponeModel.h"
#import "FNStoreMyCouponeCell.h"
#import "FNNewStoreDetailController.h"

@interface FNStoreMyCouponeController()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray<FNStoreMyCouponeModel*> *coupones;

@end

@implementation FNStoreMyCouponeController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    
    self.jm_page = 1;
    [self requestList];
}

- (void)configUI {
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.backgroundColor=RGB(238, 238, 238);
    self.jm_tableview.showsVerticalScrollIndicator = NO;
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.jm_tableview registerClass:[FNStoreMyCouponeCell class] forCellReuseIdentifier:@"FNStoreMyCouponeCell"];
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.right.bottom.equalTo(@0);
    }];
}

- (void) setCoupones:(NSArray<FNStoreMyCouponeModel*>*) coupones {
    _coupones = coupones;
    [self.jm_tableview reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _coupones.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNStoreMyCouponeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNStoreMyCouponeCell"];
    FNStoreMyCouponeModel *coupone = _coupones[indexPath.row];
    cell.lblPrice.text = [NSString stringWithFormat:@"￥%@", coupone.money];
    cell.lblCondition.text = coupone.tips;
    cell.lblTitle.text = coupone.name;
    cell.lblTime.text = coupone.str;
    
    return cell;
    
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FNStoreMyCouponeModel *coupone = _coupones[indexPath.row];
    
    if ([_cate_type kr_isNotEmpty]) {
        
        FNNewStoreDetailController *vc = [[FNNewStoreDetailController alloc] init];
        vc.storeID = coupone.store_id;
        vc.storeName = coupone.name;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if ([_delegate respondsToSelector:@selector(couponeVc:didSelected:)]) {
        [_delegate couponeVc:self didSelected:coupone];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma - mark Networking

- (void)requestList {
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    
    if (![_cate_type kr_isNotEmpty]) {
        return;
    }
    params[@"type"] = _cate_type;
    params[@"p"] = @(self.jm_page);
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_red_packet&ctrl=my_card_list" respondType:(ResponseTypeArray) modelType:@"FNStoreMyCouponeModel" success:^(id respondsObject) {
        @strongify(self)
        NSArray *ans = respondsObject;
        NSMutableArray *array = [[NSMutableArray alloc] init];
        if (self.jm_page > 1 && self.coupones.count > 0) {
            [array addObjectsFromArray: self.coupones];
        }
        if (ans.count > 0) {
            self.jm_page ++;
            self.jm_tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestList)];
        } else {
            self.jm_tableview.mj_footer = nil;
        }
        [array addObjectsFromArray: respondsObject];
        self.coupones = array;
        [self.jm_tableview reloadData];
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO];
    
}

@end
