//
//  FNStoreGoodsCateManagerController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/9.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreGoodsCateManagerController.h"
#import "FNCustomeNavigationBar.h"
#import "FNStoreManagerGoodsEmptyView.h"
#import "FNStoreManagerGoodsHeaderView.h"
#import "FNStoreManagerCateEditCell.h"

@interface FNStoreGoodsCateManagerController()<UITableViewDelegate, UITableViewDataSource, FNStoreManagerGoodsHeaderViewDelegate, FNStoreManagerGoodsEmptyViewDelegate, FNStoreManagerCateEditCellDelegate>

@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)FNStoreManagerGoodsEmptyView *emptyView;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, strong) NSMutableArray *cates;

@end

@implementation FNStoreGoodsCateManagerController

- (FNCustomeNavigationBar *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
        _navigationView.backgroundColor = RGB(255, 102, 102);
        
        UIButton* leftView = [UIButton new];
        UIImageView *imgBack = [[UIImageView alloc] init];
        imgBack.size = CGSizeMake(9, 15);
        imgBack.image = IMAGE(@"connection_button_back");
        [leftView addSubview:imgBack];
        leftView.frame = CGRectMake(10, 0, 20, 20);
        [leftView addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        
        UIButton* rightView = [UIButton new];
        UIImageView *imgAdd = [[UIImageView alloc] init];
        imgAdd.size = CGSizeMake(18, 18);
        imgAdd.image = IMAGE(@"store_manager_button_add");
        [rightView addSubview:imgAdd];
        rightView.frame = CGRectMake(10, 0, 20, 20);
        [rightView addTarget:self action:@selector(addBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        
        _navigationView.leftButton = leftView;
        _navigationView.rightButton = rightView;
        
        self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
        self.navigationView.titleLabel.sd_layout
        .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
        [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
        _navigationView.titleLabel.text=@"分类设置";
        
        if(self.understand==YES){
            _navigationView.leftButton.hidden=YES;
        }
        
        
    }
    return _navigationView;
}

- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addBtnAction {
    [self addCate];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:self.isPop.boolValue];
    
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _cates = [[NSMutableArray alloc] init];
    _isEditing = NO;
    [self configUI];
    [self requestCates];
}

- (void)configUI {
    
    [self.view addSubview:self.navigationView];
    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:self.navigationView.height];
    
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.backgroundColor=RGB(255, 255, 255);
    self.jm_tableview.showsVerticalScrollIndicator = NO;
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.jm_tableview registerClass:[FNStoreManagerCateEditCell class] forCellReuseIdentifier:@"FNStoreManagerCateEditCell"];
    [self.view addSubview:self.jm_tableview];
    
    _emptyView = [[FNStoreManagerGoodsEmptyView alloc] init];
    _emptyView.delegate = self;
    [self.view addSubview:_emptyView];
    
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom);
        make.right.left.bottom.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.jm_tableview);
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    _emptyView.hidden = _cates.count > 0;
    return _cates.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNStoreManagerCateEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNStoreManagerCateEditCell"];
    NSDictionary *dic = _cates[indexPath.row];
    cell.lblTitle.text = dic[@"name"];
    cell.delegate = self;
    [cell setEditable: !_isEditing upable: indexPath.row != 0 downable: indexPath.row != _cates.count - 1];
    return cell;
    
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    FNStoreManagerGoodsHeaderView* headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FNStoreManagerGoodsHeaderView"];
    if (headerView == nil) {
        headerView = [[FNStoreManagerGoodsHeaderView alloc]initWithReuseIdentifier:@"RushRelationStoreFooterID"];
    }
    headerView.lblTitle.text = @"分类名称";
    headerView.lblTitle.textColor = RGB(102, 102, 102);
    headerView.lblTitle.font = kFONT12;
    headerView.btnSort.titleLabel.font = kFONT12;
    [headerView.btnSort setTitle:_isEditing ? @"保存" : @"排序" forState: UIControlStateNormal];
    [headerView.btnSort setTitleColor:_isEditing ? RGB(51, 51, 51) : RGB(255, 102, 102) forState: UIControlStateNormal];
    headerView.delegate = self;
    return headerView;

}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegate respondsToSelector:@selector(goodsCate:didSelected:)]) {
        [_delegate goodsCate: self didSelected:self.cates[indexPath.row]];
    }
}

#pragma mark - Networking
- (void)requestCates{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods_cate&ctrl=cate_list" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        [self.cates removeAllObjects];
        [self.cates addObjectsFromArray: respondsObject];
        
        [self.jm_tableview reloadData];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

- (void)requestSort{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    NSMutableString *ids = [[NSMutableString alloc] init];
    BOOL isFirst = YES;
    for (NSDictionary *dict in self.cates) {
        if (isFirst)
            [ids appendString:dict[@"id"]];
        else
            [ids appendString:[NSString stringWithFormat:@",%@", dict[@"id"]]];
        isFirst = NO;
    }
    params[@"ids"] = ids;
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods_cate&ctrl=sort" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        self.isEditing = NO;
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
                   
        [self requestCates];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

- (void)requestDelete: (NSString*)ID{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{@"id":ID}];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods_cate&ctrl=del" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        [self requestCates];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}


#pragma mark - FNStoreManagerGoodsHeaderViewDelegate

- (void)headerViewDidSortClick: (FNStoreManagerGoodsHeaderView*)headerView {
    if (_isEditing) {
        [self requestSort];
    } else {
        _isEditing = YES;
    }
    [self.jm_tableview reloadData];
}


#pragma mark - FNStoreManagerGoodsEmptyViewDelegate

- (void)didAddClick: (FNStoreManagerGoodsEmptyView*)view {
    [self addCate];
}

#pragma mark - Action

- (void)addCate {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"请输入分类名称"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    @weakify(self);
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         @strongify(self);
                                                         if (alert.textFields.count > 0) {
                                                             NSString *name = alert.textFields.firstObject.text;
                                                             [self requestAddOrEdit: nil withName: name];
                                                         }
                                                     }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                         }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {

    }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - FNStoreManagerCateEditCellDelegate
- (void) cellDidDeleteClick: (FNStoreManagerCateEditCell*)cell {
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    NSDictionary* model = self.cates[indexPath.row];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"确定删除分类"
                                                                   message:@"删除后，该分类下的商品将保留至未分类中"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    @weakify(self);
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         @strongify(self);
                                                         [self requestDelete:model[@"id"]];
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
    NSDictionary* model = self.cates[indexPath.row];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"请输入修改后的分类名称"
                                                                   message:[NSString stringWithFormat:@"原分类名：%@", model[@"name"]]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    @weakify(self);
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         @strongify(self);
                                                         if (alert.textFields.count > 0) {
                                                             NSString *name = alert.textFields.firstObject.text;
                                                             [self requestAddOrEdit: model[@"id"] withName: name];
                                                         }
                                                     }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                         }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.placeholder = @"填写邀请码";
    }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void) cellDidUpClick: (FNStoreManagerCateEditCell*)cell {
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    
    if (indexPath.row <= 0) {
        return;
    }
    
    id model = self.cates[indexPath.row];
    self.cates[indexPath.row] = self.cates[indexPath.row - 1];
    self.cates[indexPath.row - 1] = model;
    
    [self.jm_tableview reloadData];
}
- (void) cellDidDownClick: (FNStoreManagerCateEditCell*)cell {
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    if (indexPath.row >= self.cates.count - 1) {
        return;
    }
    
    id model = self.cates[indexPath.row];
    self.cates[indexPath.row] = self.cates[indexPath.row + 1];
    self.cates[indexPath.row + 1] = model;
    
    [self.jm_tableview reloadData];
}

@end
