//
//  FNStoreLocationRedpackListController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/29.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreLocationRedpackListController.h"
#import "FNStoreLocationReceiveInfoCell.h"
#import "FNStoreLocationReceiveInfoModel.h"

@interface FNStoreLocationRedpackListController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) NSMutableArray<FNStoreLocationReceiveInfoModel*> *models;

@end

@implementation FNStoreLocationRedpackListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _models = [[NSMutableArray alloc] init];
    [self configUI];
    [self apiRequestMain];
}

- (void)configUI {
    self.title = @"领取信息";
    
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.backgroundColor=UIColor.whiteColor;
    self.jm_tableview.showsVerticalScrollIndicator = NO;
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.jm_tableview registerClass:[FNStoreLocationReceiveInfoCell class] forCellReuseIdentifier:@"FNStoreLocationReceiveInfoCell"];
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.right.bottom.equalTo(@0);
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _models.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNStoreLocationReceiveInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNStoreLocationReceiveInfoCell"];
    FNStoreLocationReceiveInfoModel *model = _models[indexPath.row];
    [cell.imgHeader sd_setImageWithURL:URL(model.head_img)];
    cell.lblName.text = model.nickname;
    cell.lblTime.text = model.time;
    cell.lblPrice.text = model.money;
    
    return cell;
    
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark - Networking
- (FNRequestTool *)apiRequestMain{

    @weakify(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"lid": _lid, @"p": @(self.jm_page)}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=position_redpacket&ctrl=receive_list" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)

        NSString *str = respondsObject[@"str"];
        NSArray *list = [FNStoreLocationReceiveInfoModel mj_objectArrayWithKeyValuesArray:respondsObject[@"list"]];
        if (self.jm_page == 1) {
            [self.models removeAllObjects];
        }
        [self.models addObjectsFromArray: list];
        [self.jm_tableview reloadData];
        

    } failure:^(NSString *error) {

    } isHideTips:YES];
}


@end
