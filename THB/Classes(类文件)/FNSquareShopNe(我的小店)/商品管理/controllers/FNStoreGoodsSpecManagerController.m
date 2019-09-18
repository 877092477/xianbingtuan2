//
//  FNStoreGoodsSpecManagerController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreGoodsSpecManagerController.h"
#import "FNCustomeNavigationBar.h"
#import "FNStoreGoodsSpecHeaderCell.h"
#import "FNStoreGoodsSpecHeaderView.h"
#import "FNStoreGoodsSpecAddCell.h"
#import "FNStoreGoodsSpecManagerModel.h"
#import "FNStoreGoodsModel.h"
#import "FNStoreManagerGoodsFooterView.h"

@interface FNStoreGoodsSpecManagerController ()<FNStoreGoodsSpecHeaderViewDelegate, UITableViewDelegate, UITableViewDataSource, FNStoreGoodsSpecHeaderCellDelegate, FNStoreManagerGoodsFooterViewDelegate, FNStoreGoodsSpecAddCellDelegate>

@property (nonatomic, strong) FNCustomeNavigationBar *navigationView;
@property (nonatomic, strong) UITableView *tbvSpec;
@property (nonatomic, strong) NSArray<FNStoreGoodsSpecManagerModel*> *specs;

@property (nonatomic, strong) FNStoreGoodsSpecHeaderCell *headerCell;
@property (nonatomic, strong) UIView *vBottom;
@property (nonatomic, strong) UIButton *btnSave;

//@property (nonatomic, assign) NSInteger currentSpec;//-1代表新建，-2，初始值，既不是新建也不是选择状态
@property (nonatomic, strong) FNStoreGoodsSpecManagerModel *editSpec;

@end

@implementation FNStoreGoodsSpecManagerController


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
        _navigationView.titleLabel.text=@"商品规格";
        
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
//    _currentSpec = -2;
    
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
    [self.tbvSpec registerClass:[FNStoreGoodsSpecHeaderCell class] forCellReuseIdentifier:@"FNStoreGoodsSpecHeaderCell"];
    [self.tbvSpec registerClass:[FNStoreGoodsSpecAddCell class] forCellReuseIdentifier:@"FNStoreGoodsSpecAddCell"];
    
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

    _headerCell = [self.tbvSpec dequeueReusableCellWithIdentifier:@"FNStoreGoodsSpecHeaderCell"];
    [_headerCell setSpecs:_specs];
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
    if (section == 0) {
        return 1;
    }
    
    if (_editSpec == nil) {
        return 0;
    } else {
        return _editSpec.list.count;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return _headerCell;
    } else {
        FNStoreGoodsSpecAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNStoreGoodsSpecAddCell"];

        FNStoreGoodsSpecDataModel* model = _editSpec.list[indexPath.row];
        [cell setModel: model];
        cell.btnDelete.hidden = _editSpec.list.count <= 1;

        
        cell.delegate = self;
        return cell;
    }
    
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGFloat height = 120;
        if (_specs.count > 0) {
            height += ((_specs.count - 1) / 3 + 1) * 46;
        }
        return height;
    }
    return 65;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        if (_editSpec != nil) {
            return 50;
        }
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        if (_editSpec != nil) {
            return 36;
        }
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        FNStoreGoodsSpecHeaderView* headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FNStoreGoodsSpecHeaderView"];
        if (headerView == nil) {
            headerView = [[FNStoreGoodsSpecHeaderView alloc]initWithReuseIdentifier:@"FNStoreGoodsSpecHeaderView"];
        }
        headerView.delegate = self;
        
//        if (_currentSpec == -1) {
            [headerView setModel: _editSpec];
//        } else {
//            [headerView setModel: _specs[_currentSpec]];
//        }
        
        return headerView;
    }
    return [[UIView alloc] init];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        FNStoreManagerGoodsFooterView* footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FNStoreManagerGoodsFooterView"];
        if (footerView == nil) {
            footerView = [[FNStoreManagerGoodsFooterView alloc]initWithReuseIdentifier:@"FNStoreManagerGoodsFooterView"];
        }
        footerView.delegate = self;
        [footerView.btnAdd setTitle: @"新建规格选项" forState: UIControlStateNormal];
        return footerView;
    }
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark - Action
- (void)onSaveClick {
    
    if ([_delegate respondsToSelector:@selector(goodsSpec:didSelected:)]) {
        
            if (![_editSpec.name kr_isNotEmpty]) {
                [FNTipsView showTips: @"请输入分类名称"];
                return;
            }
            
            for (FNStoreGoodsSpecDataModel *model in _editSpec.list) {
                if (![model.name kr_isNotEmpty] || ![model.price kr_isNotEmpty]){
                    [FNTipsView showTips:@"请输入规格选项和价格"];
                    return;
                }
            }
            [_delegate goodsSpec:self didSelected: _editSpec];
        
    }
}

#pragma mark - Networking
- (void)requestSpecs{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"type": @"1"}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods_specs&ctrl=spesc_detail" respondType:(ResponseTypeArray) modelType:@"FNStoreGoodsSpecManagerModel" success:^(id respondsObject) {
        @strongify(self)
        
        self.specs = respondsObject;
        [self.headerCell setSpecs:self.specs];
        
        _editSpec = _baseSpec;
//        if ([self.specId kr_isNotEmpty]) {
//            for (NSInteger index = 0; index < self.specs.count; index++) {
//                FNStoreGoodsSpecManagerModel *spec = self.specs[index];
//                if ([spec.id isEqualToString:self.specId]) {
//                    self.currentSpec = index;
//                    
//                    self.editSpec = [[FNStoreGoodsSpecManagerModel alloc] init];
//                    self.editSpec.id = spec.id;
//                    self.editSpec.name = spec.name;
//                    self.editSpec.type = spec.type;
//                    self.editSpec.list = [[NSArray alloc] initWithArray:spec.list];
//
//                    [self.headerCell setSelectAt: index];
//                    
//                    break;
//                }
//            }
//        }
        
        [self.tbvSpec reloadData];
        
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}
- (void)requestSaveSpecs: (NSString*)name{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{@"name": name, @"type": @"1"}];
    
    if ([_editSpec.id kr_isNotEmpty]) {
        params[@"id"] = _editSpec.id;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (FNStoreGoodsSpecDataModel *model in _editSpec.list) {
        [array addObject: model.keyValues];
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:kNilOptions error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    
    params[@"data"] = jsonString;
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods_specs&ctrl=add_spesc" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
                   
        [self clearEdit];
                   
        [self requestSpecs];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}


#pragma mark - FNStoreGoodsSpecHeaderViewDelegate

- (void)didSpecHeaderClick: (FNStoreGoodsSpecHeaderView*)headerView {
    if (![_editSpec.name kr_isNotEmpty]) {
        [FNTipsView showTips: @"请输入分类名称"];
        return;
    }
    
    for (FNStoreGoodsSpecDataModel *model in _editSpec.list) {
        if (![model.name kr_isNotEmpty] || ![model.price kr_isNotEmpty]){
            [FNTipsView showTips:@"请输入规格选项和价格"];
            return;
        }
    }
    [self requestSaveSpecs: _editSpec.name];
}

#pragma mark - FNStoreGoodsSpecHeaderCellDelegate

- (void)cell: (FNStoreGoodsSpecHeaderCell*)cell didSpecClickAt: (NSInteger)index {
//    if (_currentSpec == index) {
//        return ;
//    }
//    _currentSpec = index;
    
    _editSpec = [[FNStoreGoodsSpecManagerModel alloc] init];
    _editSpec.id = _specs[index].id;
    _editSpec.name = _specs[index].name;
    _editSpec.type = _specs[index].type;
    _editSpec.list = [[NSArray alloc] initWithArray:_specs[index].list];
    
    [self.tbvSpec reloadData];
}
- (void)didAddClick: (FNStoreGoodsSpecHeaderCell*)cell {
//    if (_currentSpec == -1) {
//        return;
//    }
    [self clearEdit];
}

- (void)clearEdit {
//    _currentSpec = -1;
    _editSpec = [[FNStoreGoodsSpecManagerModel alloc] init];
    _editSpec.id = @"";
    _editSpec.name = @"";
    _editSpec.type = @"";
    _editSpec.list = @[([[FNStoreGoodsSpecDataModel alloc] init])];
    
    [self.tbvSpec reloadData];
}

#pragma mark - FNStoreManagerGoodsFooterViewDelegate

- (void)footerViewDidAddClick: (FNStoreManagerGoodsFooterView*)headerView {
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:_editSpec.list];
    [array addObject: [[FNStoreGoodsSpecDataModel alloc] init]];
    _editSpec.list = array;

    [self.tbvSpec reloadData];
}


#pragma mark - FNStoreGoodsSpecAddCellDelegate

- (void)cellDidDeleteClick: (FNStoreGoodsSpecAddCell*)cell {
    NSIndexPath *indexPath = [_tbvSpec indexPathForCell:cell];

    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:_editSpec.list];
    [array removeObjectAtIndex:indexPath.row];
    _editSpec.list = array;

    [self.tbvSpec reloadData];
}


@end
