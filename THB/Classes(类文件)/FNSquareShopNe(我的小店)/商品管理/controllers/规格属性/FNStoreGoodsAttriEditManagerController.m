//
//  FNStoreGoodsAttriEditManagerController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/15.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreGoodsAttriEditManagerController.h"
#import "FNCustomeNavigationBar.h"
#import "FNStoreGoodsSpecHeaderView.h"
#import "FNStoreGoodsSpecAddCell.h"
#import "FNStoreGoodsSpecManagerModel.h"
#import "FNStoreGoodsModel.h"
#import "FNStoreManagerGoodsFooterView.h"
#import "FNStoreGoodsAttriAddCell.h"
#import "FNStoreGoodsAttriHeaderView.h"
#import "FNStoreGoodsSpecHeaderCell.h"

@interface FNStoreGoodsAttriEditManagerController ()<FNStoreGoodsSpecHeaderViewDelegate, UITableViewDelegate, UITableViewDataSource, FNStoreManagerGoodsFooterViewDelegate, FNStoreGoodsSpecAddCellDelegate, FNStoreGoodsAttriAddCellDelegate>

@property (nonatomic, strong) FNCustomeNavigationBar *navigationView;
@property (nonatomic, strong) UITableView *tbvSpec;
@property (nonatomic, strong) NSArray<FNStoreGoodsSpecManagerModel*> *specs;

@property (nonatomic, strong) FNStoreGoodsSpecHeaderCell *headerCell;
@property (nonatomic, strong) UIView *vBottom;
@property (nonatomic, strong) UIButton *btnSave;

@property (nonatomic, strong) NSMutableArray<FNStoreGoodsSpecManagerModel*> *selectAttris;

@end

@implementation FNStoreGoodsAttriEditManagerController


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
        
        _navigationView.leftButton = leftView;
        
        self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
        self.navigationView.titleLabel.sd_layout
        .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
        [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
        _navigationView.titleLabel.text=@"商品属性";
        
        if(self.understand==YES){
            _navigationView.leftButton.hidden=YES;
        }
        
        
    }
    return _navigationView;
}

- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
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
    _selectAttris = [[NSMutableArray alloc] init];
    
    [self configUI];
    [self requestSpecs];
}

- (void)configUI {
    
    [self.view addSubview:self.navigationView];
    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:self.navigationView.height];
    
    _tbvSpec = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
    _tbvSpec.dataSource = self;
    _tbvSpec.delegate = self;
    _tbvSpec.backgroundColor=RGB(250, 250, 250);
    _tbvSpec.showsVerticalScrollIndicator = NO;
    _tbvSpec.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tbvSpec registerClass:[FNStoreGoodsAttriAddCell class] forCellReuseIdentifier:@"FNStoreGoodsAttriAddCell"];
    
    [self.view addSubview:self.tbvSpec];
    
    
    _vBottom = [[UIView alloc] init];
    _btnSave = [[UIButton alloc] init];
    
    [self.view addSubview:_vBottom];
    [_vBottom addSubview:_btnSave];
    
    [self.tbvSpec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom);
        make.right.left.equalTo(@0);
        make.bottom.equalTo(self.vBottom.mas_top);
    }];
    
    //    _headerCell = [self.tbvSpec dequeueReusableCellWithIdentifier:@"FNStoreGoodsAttriAddCell"];
    _headerCell = [[FNStoreGoodsSpecHeaderCell alloc] init];
    
    _headerCell.lblTitle.text = @"新建的商品属性";
    _headerCell.lblTitle.font = kFONT14;
    _headerCell.lblTitle.textColor = RGB(51, 51, 51);
    _headerCell.lblDesc.text = @"如辣度、甜度，属性与价格、库存无关";
    
    _headerCell.delegate = self;
    
    [_vBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
    }];
    [_btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.bottom.equalTo(isIphoneX ? @-54 : @-20);
        make.height.mas_equalTo(50);
    }];
    
    _vBottom.backgroundColor = UIColor.whiteColor;
    _btnSave.backgroundColor = RGB(255, 102, 102);
    _btnSave.cornerRadius = 5;
    _btnSave.titleLabel.font = kFONT16;
    [_btnSave setTitle:@"确认保存" forState: UIControlStateNormal];
    [_btnSave setTitleColor: UIColor.whiteColor forState: UIControlStateNormal];
    [_btnSave addTarget:self action:@selector(onSaveClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _selectAttris.count + 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
//        NSMutableArray *array = [[NSMutableArray alloc] init];
//        for (FNStoreGoodsSpecManagerModel *model in _specs) {
//            [array addObject: model.isSelected ? @"1" : @"0"];
//        }
//        [_headerCell setSelections: array];
        return _headerCell;
        
    } else {
        FNStoreGoodsAttriAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNStoreGoodsAttriAddCell"];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSMutableArray *selects = [[NSMutableArray alloc] init];
        for (FNStoreGoodsSpecDataModel* spec in _selectAttris[indexPath.section - 1].list) {
            [array addObject:spec.name];
            [selects addObject: spec.isSelected ? @"1" : @"0"];
        }
        
        [cell setTitles: array];
        [cell setSelections: selects];
        
        cell.delegate = self;
        return cell;
    }
    return [[UITableViewCell alloc] init];
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGFloat height = 120;
        if (_specs.count > 0) {
            height += ((_specs.count - 1) / 3 + 1) * 46;
        }
        return height;
    } else {
        FNStoreGoodsSpecManagerModel *spec = _selectAttris[indexPath.section - 1];
        CGFloat height = 74;
        if (spec.list.count > 0) {
            height += ((spec.list.count - 1) / 3 + 1) * 46;
        }
        return height;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section >= 1) {
        return 36;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [[UIView alloc] init];
    }
    if (section >= 1) {
        FNStoreGoodsSpecHeaderView* headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FNStoreGoodsSpecHeaderView"];
        if (headerView == nil) {
            headerView = [[FNStoreGoodsSpecHeaderView alloc]initWithReuseIdentifier:@"FNStoreGoodsSpecHeaderView"];
        }
        headerView.tag = section;
        headerView.delegate = self;
//        headerView.txfName.text = _selectAttris[section - 1].name;
        [headerView setModel: _selectAttris[section - 1]];
        return headerView;
    }
    return [[UIView alloc] init];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section >= 1) {
        FNStoreManagerGoodsFooterView* footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FNStoreManagerGoodsFooterView"];
        if (footerView == nil) {
            footerView = [[FNStoreManagerGoodsFooterView alloc]initWithReuseIdentifier:@"FNStoreManagerGoodsFooterView"];
        }
        footerView.delegate = self;
        [footerView.btnAdd setImage: IMAGE(@"store_manager_button_delete_red") forState: UIControlStateNormal];
        [footerView.btnAdd setTitle: @"点击删除该属性" forState: UIControlStateNormal];
        footerView.tag = section;
        return footerView;
    }
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - Action
- (void)onSaveClick {
    
    if (_selectAttris.count > 0) {
        [self save: 0];
        return;
    }
    
    if ([_delegate respondsToSelector:@selector(onSave:)]) {
        [_delegate onSave:self];
    }
}

#pragma mark - Networking
- (void)requestSpecs{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"type": @"2"}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods_specs&ctrl=spesc_detail" respondType:(ResponseTypeArray) modelType:@"FNStoreGoodsSpecManagerModel" success:^(id respondsObject) {
        @strongify(self)
        
        self.specs = respondsObject;
        [_selectAttris removeAllObjects];
        
        [self.headerCell setSpecs: respondsObject];
        //        [self.headerCell setSpecs:self.specs];
        [self.tbvSpec reloadData];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

- (void)requestDeleteSpecs: (FNStoreGoodsSpecManagerModel*)attri{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"id": attri.id}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods_specs&ctrl=del_spesc" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        
        [self requestSpecs];
        
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

- (void)requestSave:(NSString*)name spec: (FNStoreGoodsSpecManagerModel*) spec {
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{@"name": name, @"type": @"2"}];
    
    if ([spec.id kr_isNotEmpty]) {
        params[@"id"] = spec.id;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (FNStoreGoodsSpecDataModel *model in spec.list) {
        [array addObject: model.name];
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:kNilOptions error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    params[@"data"] = jsonString;
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods_specs&ctrl=add_spesc" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        
        //        [self clearEdit];
        
        [self.selectAttris removeObject: spec];
        
        [self requestSpecs];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}


#pragma mark - FNStoreGoodsSpecHeaderViewDelegate

- (void)didSpecHeaderClick: (FNStoreGoodsSpecHeaderView*)headerView {
    
    
    NSInteger index = headerView.tag;
    [self save: index - 1];
    
}

- (void) save: (NSInteger)index {
    FNStoreGoodsSpecManagerModel *model = _selectAttris[index];
    if (![model.name kr_isNotEmpty]) {
        [FNTipsView showTips: @"请输入分类名称"];
        return;
    }
    if (model.list.count <= 0) {
        [FNTipsView showTips: @"请添加属性"];
        return;
    }
    [self requestSave:model.name spec: model];
}


#pragma mark - FNStoreManagerGoodsFooterViewDelegate

- (void)footerViewDidAddClick: (FNStoreManagerGoodsFooterView*)headerView {
    NSInteger index = headerView.tag;
    FNStoreGoodsSpecManagerModel *model = _selectAttris[index - 1];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"确定删除该属性吗？"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    @weakify(self);
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         @strongify(self);
                                                         if ([model.id kr_isNotEmpty])
                                                             [self requestDeleteSpecs:model];
                                                         else {
                                                             [self.selectAttris removeObjectAtIndex: index - 1];
                                                             [self.tbvSpec reloadData];
                                                         }
                                                     }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                         }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark - FNStoreGoodsSpecHeaderCellDelegate

- (void)cell: (FNStoreGoodsSpecHeaderCell*)cell didSpecClickAt: (NSInteger)index {
    FNStoreGoodsSpecManagerModel *spec = _specs[index];
    for (FNStoreGoodsSpecManagerModel* model in _specs) {
        model.isSelected = NO;
    }
    spec.isSelected = YES;
    [self.selectAttris removeAllObjects];
    [_selectAttris addObject:spec];

    [self.tbvSpec reloadData];
    
}
- (void)didAddClick: (FNStoreGoodsSpecHeaderCell*)cell {
    
    [self.selectAttris removeAllObjects];
    FNStoreGoodsSpecManagerModel *spec = [[FNStoreGoodsSpecManagerModel alloc] init];
    [_selectAttris addObject: spec];
    
    [self.tbvSpec reloadData];
}


#pragma mark -  FNStoreGoodsAttriAddCellDelegate

- (void)cell: (FNStoreGoodsAttriAddCell*)cell didAttriClickAt: (NSInteger)index {
    NSIndexPath *indexPath = [_tbvSpec indexPathForCell:cell];
    if (indexPath.section == 0) {
//        FNStoreGoodsSpecManagerModel *spec = _specs[index];
//        spec.isSelected = !spec.isSelected;
//        if ([_selectAttris containsObject: spec]) {
//            [_selectAttris removeObject:spec];
//        } else {
//            [_selectAttris addObject:spec];
//        }
//
//        [self.tbvSpec reloadData];
    } else {
        FNStoreGoodsSpecDataModel *data = _selectAttris[indexPath.section - 1].list[index];
        data.isSelected = !data.isSelected;
        [self.tbvSpec reloadData];
    }
}
- (void)didAddAttriClick: (FNStoreGoodsAttriAddCell*)cell {
    NSIndexPath *indexPath = [_tbvSpec indexPathForCell:cell];
    if (indexPath.section == 0) {
//        FNStoreGoodsSpecManagerModel *spec = [[FNStoreGoodsSpecManagerModel alloc] init];
//
//
//        [_selectAttris addObject: spec];
    } else {
        
        FNStoreGoodsSpecManagerModel *model = _selectAttris[indexPath.section - 1];
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"请输入商品选项"
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        @weakify(self);
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             @strongify(self);
                                                             NSString *name = alert.textFields.firstObject.text;
                                                             //                                                             [self requestSave:name spec: model];
                                                             NSMutableArray *array = [[NSMutableArray alloc] initWithArray:model.list];
                                                             FNStoreGoodsSpecDataModel *spec = [[FNStoreGoodsSpecDataModel alloc] init];
                                                             spec.name = name;
                                                             [array addObject: spec];
                                                             model.list =array;
                                                             [self.tbvSpec reloadData];
                                                         }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * action) {
                                                             }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"请输入商品选项";
        }];
        
        [alert addAction:okAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    [self.tbvSpec reloadData];
}


@end
