//
//  FNIntegralMallAddressController.m
//  THB
//
//  Created by Weller Zhao on 2019/1/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNIntegralMallAddressController.h"
#import "FNAddressModel.h"
#import "FNAddressCell.h"
#import "FNIntegralMallAddressEditController.h"

@interface FNIntegralMallAddressController () <UITableViewDelegate, UITableViewDataSource, FNAddressCellDelegate, FNIntegralMallAddressEditControllerDelegate>

@property (nonatomic, strong) UIButton *btnNew;
@property (nonatomic, strong) NSArray<FNAddressModel*> *address;

@end

@implementation FNIntegralMallAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.address = [[NSArray alloc] init];
    
    [self configUI];
}

- (void)configUI {
    self.title = @"收货地址";
    
    self.jm_tableview = [[UITableView alloc] init];
    self.jm_tableview.delegate = self;
    self.jm_tableview.dataSource = self;
    [self.jm_tableview registerClass:[FNAddressCell class] forCellReuseIdentifier:@"FNAddressCell"];
    self.jm_tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.btnNew = [[UIButton alloc] init];
    [self.view addSubview:_btnNew];
    [_btnNew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@60);
        make.right.equalTo(@-60);
        make.height.mas_equalTo(44);
        make.bottom.equalTo(@-20);
    }];
    _btnNew.cornerRadius = 22;
    _btnNew.backgroundColor = RGB(255, 37, 37);
    [_btnNew setTitle:@"新建地址" forState:UIControlStateNormal];
    [_btnNew setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [_btnNew setImage:IMAGE(@"address_image_add") forState:UIControlStateNormal];
    [_btnNew setImage:IMAGE(@"address_image_add") forState:UIControlStateHighlighted];
    _btnNew.titleLabel.font = [UIFont systemFontOfSize:18];
    [_btnNew layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:15];
    [_btnNew addTarget:self action:@selector(onAddClick)];
    
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.bottom.equalTo(self.btnNew.mas_top).offset(-20);
    }];
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self apiRequestAddress];
}

#pragma mark - Network

- (void)apiRequestAddress {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey: UserAccessToken}];
    @weakify(self);
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=convert_goods&ctrl=address" respondType:(ResponseTypeArray) modelType:@"FNAddressModel" success:^(id respondsObject) {
        @strongify(self);
        self.address = respondsObject;
        [self.jm_tableview reloadData];
        
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:NO isCache:NO];
}

- (void)apiRequestDelete: (NSString*)addressId {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey: UserAccessToken, @"id": addressId}];
    @weakify(self);
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=convert_goods&ctrl=del_address" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        
        [self apiRequestAddress];
        
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:NO isCache:NO];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.address.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FNAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNAddressCell"];
    FNAddressModel *model = self.address[indexPath.row];
    [cell setName:model.name withPhone:model.phone tag:model.label address:model.address isDefault:model.is_acquiesce.boolValue];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(didAddressSelected:)]) {
        [_delegate didAddressSelected:self.address[indexPath.row]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除收货地址" message:@"确认要删除该收货信息？删除后不可恢复" preferredStyle:UIAlertControllerStyleAlert];
        NSString *ID = self.address[indexPath.row].ID;
        @weakify(self)
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            @strongify(self)
            [self apiRequestDelete:ID];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - FNAddressCellDelegate

- (void)didEditClick:(FNAddressCell *)cell {
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    FNAddressModel *model = self.address[indexPath.row];
    FNIntegralMallAddressEditController *vc = [[FNIntegralMallAddressEditController alloc] init];
    vc.model = model;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Action
- (void) onAddClick {
    FNIntegralMallAddressEditController *vc = [[FNIntegralMallAddressEditController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - FNIntegralMallAddressEditControllerDelegate
- (void)onAddressSave:(FNIntegralMallAddressEditController *)controller {
    [self apiRequestAddress];
}

@end
