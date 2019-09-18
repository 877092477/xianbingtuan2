//
//  FNStoreGoodsAttriListManagerController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/15.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreGoodsAttriListManagerController.h"
#import "FNStoreManagerGoodsEmptyView.h"
#import "FNStoreGoodsSpecManagerModel.h"
#import "FNStoreManagerGoodsHeaderView.h"
#import "FNStoreManagerCateEditCell.h"
#import "FNStoreGoodsSpecManagerController.h"
#import "FNStoreGoodsAttriEditManagerController.h"

@interface FNStoreGoodsAttriListManagerController()<UITableViewDelegate, UITableViewDataSource, FNStoreManagerGoodsEmptyViewDelegate, FNStoreManagerCateEditCellDelegate, FNStoreGoodsSpecManagerControllerDelegate, FNStoreGoodsAttriEditManagerControllerDelegate>

@property (nonatomic, strong)FNStoreManagerGoodsEmptyView *emptyView;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, strong) NSArray<FNStoreGoodsSpecManagerModel*> *specs;


@end

@implementation FNStoreGoodsAttriListManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _specs = [[NSMutableArray alloc] init];
    _isEditing = NO;
    [self configUI];
    [self requestspecs];
}

- (void)configUI {
    
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.backgroundColor=RGB(255, 255, 255);
    self.jm_tableview.showsVerticalScrollIndicator = NO;
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.jm_tableview registerClass:[FNStoreManagerCateEditCell class] forCellReuseIdentifier:@"FNStoreManagerCateEditCell"];
    [self.view addSubview:self.jm_tableview];
    
    _emptyView = [[FNStoreManagerGoodsEmptyView alloc] init];
    
    if ([_type isEqualToString:@"1"]) {
        _emptyView.lblEmpty.text = @"还没有规格哦，马上添加";
        [_emptyView.btnAdd setTitle:@"添加规格" forState: UIControlStateNormal];
    } else {
        _emptyView.lblEmpty.text = @"还没有属性哦，马上添加";
        [_emptyView.btnAdd setTitle:@"添加属性" forState: UIControlStateNormal];
    }
    _emptyView.delegate = self;
    [self.view addSubview:_emptyView];
    
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.right.left.bottom.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.jm_tableview);
    }];
}

#pragma mark - Action

- (void) create {
    if ([_type isEqualToString: @"1"]) {
        FNStoreGoodsSpecManagerController *vc = [[FNStoreGoodsSpecManagerController alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        
        FNStoreGoodsAttriEditManagerController *vc = [[FNStoreGoodsAttriEditManagerController alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    _emptyView.hidden = _specs.count > 0;
    return _specs.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNStoreManagerCateEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNStoreManagerCateEditCell"];
    FNStoreGoodsSpecManagerModel *model = _specs[indexPath.row];
    cell.lblTitle.text = model.name;
    cell.delegate = self;
    [cell setEditable: !_isEditing upable: indexPath.row != 0 downable: indexPath.row != _specs.count - 1];
    return cell;
    
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark - Networking
- (void)requestspecs{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{@"type":_type}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods_specs&ctrl=spesc_detail" respondType:(ResponseTypeArray) modelType:@"FNStoreGoodsSpecManagerModel" success:^(id respondsObject) {
        @strongify(self)
        
        self.specs = respondsObject;
        
        [self.jm_tableview reloadData];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}


- (void)requestAddOrEdit: (NSString*)ID withName: (NSString*)name{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{@"name": name}];
    if ([ID kr_isNotEmpty]) {
        params[@"id"] = ID;
    }
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods_cate&ctrl=add" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        
        [self requestspecs];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

- (void)requestDelete: (NSString*)ID{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{@"id":ID}];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods_specs&ctrl=del_spesc" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        
        @strongify(self)
        [self requestspecs];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

#pragma mark - FNStoreManagerGoodsEmptyViewDelegate

- (void)didAddClick: (FNStoreManagerGoodsEmptyView*)view {
    
    [self create];
}

#pragma mark - FNStoreManagerCateEditCellDelegate
- (void) cellDidDeleteClick: (FNStoreManagerCateEditCell*)cell {
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    FNStoreGoodsSpecManagerModel* model = self.specs[indexPath.row];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"确定删除【%@】吗？", model.name]
                                                                   message:@"删除后，该设置将全部删除"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    @weakify(self);
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         @strongify(self);
                                                         [self requestDelete:model.id];
                                                     }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                         }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void) cellDidEditClick: (FNStoreManagerCateEditCell*)cell {
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    
    FNStoreGoodsSpecManagerModel *spec = self.specs[indexPath.row];
    
    if ([_type isEqualToString: @"1"]) {
        FNStoreGoodsSpecManagerController *vc = [[FNStoreGoodsSpecManagerController alloc] init];
        vc.delegate = self;
        vc.baseSpec = spec;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        
        FNStoreGoodsAttriEditManagerController *vc = [[FNStoreGoodsAttriEditManagerController alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}


#pragma mark - FNStoreGoodsSpecManagerControllerDelegate
- (void)goodsSpec: (FNStoreGoodsSpecManagerController*)vc didSelected: (FNStoreGoodsSpecManagerModel*) spec {
    
    [self requestspecs];
    [self.navigationController popViewControllerAnimated: YES];
}

#pragma mark - FNStoreGoodsAttriEditManagerControllerDelegate

- (void)onSave:(FNStoreGoodsAttriEditManagerController*)vc {
    
    [self requestspecs];
    [self.navigationController popViewControllerAnimated: YES];
}

@end
