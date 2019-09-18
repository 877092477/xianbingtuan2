//
//  FNStoreGoodsManagerController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/8.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreGoodsManagerController.h"
#import "SliderControl.h"
#import "FNStoreManagerGoodsModel.h"
#import "FNStoreManagerCateCell.h"
#import "FNStoreManagerGoodsEmptyView.h"
#import "FNStoreManagerGoodsCell.h"
#import "FNStoreManagerGoodsHeaderView.h"
#import "FNStoreGoodsCateManagerController.h"
#import "FNCustomeNavigationBar.h"
#import "FNStoreGoodsManagerAddController.h"
#import "FNStoreManagerGoodsFooterView.h"
#import "FNStoreGoodsAttriSpecManagerController.h"

@interface FNStoreGoodsManagerController ()<UITableViewDelegate, UITableViewDataSource,SliderControlDelegate, FNStoreManagerGoodsHeaderViewDelegate, FNStoreManagerGoodsCellDelegate, FNStoreManagerGoodsFooterViewDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong) SliderControl *slider;
@property (nonatomic, strong) UITableView *tbvCates;
@property (nonatomic, strong) UITableView *tbvGoods;
@property (nonatomic, strong) FNStoreManagerGoodsEmptyView *emptyView;

@property (nonatomic, strong) UIButton *btnCate;
@property (nonatomic, strong) UIButton *btnSpec;

@property (nonatomic, strong) NSArray<FNStoreManagerCateModel*> *cates;
@property (nonatomic, strong) NSMutableArray<FNStoreManagerGoodsModel*> *goods;

@property (nonatomic, assign) NSInteger currentCateIndex;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, assign) BOOL isEditing;

@end

@implementation FNStoreGoodsManagerController

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
        _navigationView.titleLabel.text=@"商品管理";
        
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
    
    [self requestGoods];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _goods = [[NSMutableArray alloc] init];
    _status = @"on_sale";
    _isEditing = NO;
    
    [self configUI];
}

- (void)configUI {
    
    [self.view addSubview:self.navigationView];
    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:self.navigationView.height];
    
    self.title = @"商品管理";
    
    self.slider = [[SliderControl alloc] init];
    self.slider.backgroundColor = RGB(248, 248, 248);
    self.slider.font = kFONT12;
    self.slider.hightlightFont = [UIFont boldSystemFontOfSize:12];
    self.slider.textColor = RGB(204, 204, 204);
    self.slider.textHighlightColor = RGB(51, 51, 51);
    self.slider.highlightColor = RGB(255, 98, 4);
    self.slider.autoSize = NO;
    self.slider.delegate = self;
    [self.slider setTitles: @[@"出售中", @"已售罄", @"未上架"]];
    [self.view addSubview:self.slider];
    
    self.tbvCates = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.tbvCates.dataSource = self;
    self.tbvCates.delegate = self;
    self.tbvCates.backgroundColor=RGB(248, 248, 248);
    self.tbvCates.showsVerticalScrollIndicator = NO;
    self.tbvCates.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tbvCates registerClass:[FNStoreManagerCateCell class] forCellReuseIdentifier:@"FNStoreManagerCateCell"];
    [self.view addSubview:self.tbvCates];
    
    
    self.tbvGoods = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.tbvGoods.dataSource = self;
    self.tbvGoods.delegate = self;
    self.tbvGoods.backgroundColor=RGB(255, 255, 255);
    self.tbvGoods.showsVerticalScrollIndicator = NO;
    self.tbvGoods.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tbvGoods registerClass:[FNStoreManagerGoodsCell class] forCellReuseIdentifier:@"FNStoreManagerGoodsCell"];
    [self.view addSubview:self.tbvGoods];
    
    _emptyView = [[FNStoreManagerGoodsEmptyView alloc] init];
    _emptyView.delegate = self;
    [self.view addSubview:_emptyView];
    
    _btnCate = [[UIButton alloc] init];
    _btnSpec = [[UIButton alloc] init];
    [self.view addSubview:_btnCate];
    [self.view addSubview:_btnSpec];
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom);
        make.right.equalTo(@0);
        make.left.equalTo(self.tbvCates.mas_right);
        make.height.mas_equalTo(32);
    }];
    [self.tbvCates mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom);
        make.left.equalTo(@0);
        make.width.mas_equalTo(90);
        make.bottom.equalTo(self.btnCate.mas_top);
    }];
    [self.tbvGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.slider.mas_bottom);
        make.right.bottom.equalTo(@0);
        make.left.equalTo(self.tbvCates.mas_right);
        make.bottom.equalTo(@0);
    }];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.tbvGoods);
    }];
    [self.btnCate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tbvCates);
        make.bottom.equalTo(self.btnSpec.mas_top);
        make.height.mas_equalTo(60);
    }];
    [self.btnSpec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tbvCates);
        make.bottom.equalTo(isIphoneX ? @-34 : @0);
        make.height.mas_equalTo(60);
    }];
    [self.btnCate setTitle:@"分类设置" forState: UIControlStateNormal];
    [self.btnCate setTitleColor:RGB(51, 51, 51) forState: UIControlStateNormal];
    self.btnCate.titleLabel.font = kFONT14;

    [self.btnSpec setTitle:@"规格设置" forState: UIControlStateNormal];
    [self.btnSpec setTitleColor:RGB(51, 51, 51) forState: UIControlStateNormal];
    self.btnSpec.titleLabel.font = kFONT14;
    [self.btnCate addTarget:self action:@selector(cateClick) forControlEvents:UIControlEventTouchUpInside];
    [self.btnSpec addTarget:self action:@selector(specClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual: _tbvCates]) {
        if (self.cates) {
            return self.cates.count;
        }
        return 2;
    } else {
        self.emptyView.hidden = self.goods.count != 0;
        
        return self.goods.count;
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual: _tbvCates]) {
        FNStoreManagerCateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNStoreManagerCateCell"];
        cell.lblTitle.text = self.cates[indexPath.row].name;
        [cell setIsSelected:indexPath.row == _currentCateIndex];
        return cell;
    } else {
        FNStoreManagerGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNStoreManagerGoodsCell"];
        cell.delegate = self;
        [cell setModel: _goods[indexPath.row]];
        [cell setEditable: !_isEditing upable: indexPath.row != 0 downable: indexPath.row != _goods.count - 1];
        return cell;
    }
    
    return [[UITableViewCell alloc] init];
    
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual: _tbvCates]) {
        return 60;
    }
    return 84;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual: _tbvGoods]) {
        return 36;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([tableView isEqual: _tbvGoods]) {
        return 44;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual: _tbvGoods]) {
        FNStoreManagerGoodsHeaderView* headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FNStoreManagerGoodsHeaderView"];
        if (headerView == nil) {
            headerView = [[FNStoreManagerGoodsHeaderView alloc]initWithReuseIdentifier:@"RushRelationStoreFooterID"];
        }
        headerView.lblTitle.text = self.cates[_currentCateIndex].name;
        [headerView.btnSort setTitle:_isEditing ? @"保存" : @"排序" forState: UIControlStateNormal];
        [headerView.btnSort setTitleColor:_isEditing ? RGB(51, 51, 51) : RGB(255, 102, 102) forState: UIControlStateNormal];
        headerView.delegate = self;
        return headerView;
    }else{
        return [UIView new];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([tableView isEqual: _tbvGoods]) {
        
        FNStoreManagerGoodsFooterView* headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FNStoreManagerGoodsFooterView"];
        if (headerView == nil) {
            headerView = [[FNStoreManagerGoodsFooterView alloc]initWithReuseIdentifier:@"FNStoreManagerGoodsFooterView"];
        }
        headerView.delegate = self;
        return headerView;
        
    }
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual: _tbvCates]) {
        NSInteger index = indexPath.row ;
        if (self.cates && indexPath.row < self.cates.count) {
            _currentCateIndex = indexPath.row;
            [self filterGoods];
            [self.tbvCates reloadData];
            return;
        }
    } else {
        FNStoreGoodsManagerAddController *vc = [[FNStoreGoodsManagerAddController alloc] init];
        
        vc.cateId = self.cates[_currentCateIndex].id;
        vc.cateName = self.cates[_currentCateIndex].name;
        vc.goods_id = _goods[indexPath.row].id;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - Action
- (void)onAddClick {
    FNStoreGoodsManagerAddController *vc = [[FNStoreGoodsManagerAddController alloc] init];
    
    vc.cateId = self.cates[_currentCateIndex].id;
    vc.cateName = self.cates[_currentCateIndex].name;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)filterGoods {
    [_goods removeAllObjects];
    for (FNStoreManagerGoodsModel *goods in self.cates[_currentCateIndex].goods) {
        if ([goods.status isEqualToString: _status]) {
            [_goods addObject: goods];
        }
    }
    [self.tbvGoods reloadData];
}

- (void)cateClick {
    
    FNStoreGoodsCateManagerController *vc = [[FNStoreGoodsCateManagerController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)specClick {
    FNStoreGoodsAttriSpecManagerController *vc = [[FNStoreGoodsAttriSpecManagerController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Networking

- (void)requestGoods{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods_admin&ctrl=goods_list" respondType:(ResponseTypeArray) modelType:@"FNStoreManagerCateModel" success:^(id respondsObject) {
        @strongify(self)
        self.cates = respondsObject;
        if (self.currentCateIndex >= self.cates.count) {
            self.currentCateIndex = 0;
        }
        [self.tbvCates reloadData];
        [self filterGoods];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

- (void)requestSort{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    NSMutableString *ids = [[NSMutableString alloc] init];
    BOOL isFirst = YES;
    for (FNStoreManagerGoodsModel *goods in self.goods) {
        if (isFirst)
            [ids appendString:goods.id];
        else
            [ids appendString:[NSString stringWithFormat:@",%@", goods.id]];
        isFirst = NO;
    }
    params[@"ids"] = ids;
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_goods_admin&ctrl=sort" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        self.isEditing = NO;
        [self.tbvGoods reloadData];

    } failure:^(NSString *error) {


    } isHideTips:NO isCache: NO];
    
}

#pragma mark - SliderControlDelegate
- (void)sliderControl: (SliderControl*) slider didCellSelectedAtIndex: (NSInteger) index {
    if (index == 0) {
        _status = @"on_sale";
    } else if (index == 1) {
        _status = @"no_stock";
    } else if (index == 2) {
        _status = @"no_shelves";
    }
    [self filterGoods];
}


#pragma mark - FNStoreManagerGoodsHeaderViewDelegate

- (void)headerViewDidSortClick: (FNStoreManagerGoodsHeaderView*)headerView {
    if (_isEditing) {
        
//        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"确定保存吗"
//                                                                       message:nil
//                                                                preferredStyle:UIAlertControllerStyleAlert];
//
//        @weakify(self);
//        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
//                                                         handler:^(UIAlertAction * action) {
//                                                             @strongify(self);
        
                                                             [self requestSort];
//                                                         }];
//        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
//                                                             handler:^(UIAlertAction * action) {
//                                                             }];
//
//        [alert addAction:okAction];
//        [alert addAction:cancelAction];
//        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        _isEditing = YES;
    }
//    _isEditing = !_isEditing;
    [self.tbvGoods reloadData];
}

#pragma mark -  FNStoreManagerGoodsCellDelegate

- (void) cellDidEditClick: (FNStoreManagerGoodsCell*)cell{
    
}
- (void) cellDidUpClick: (FNStoreManagerGoodsCell*)cell{
    NSIndexPath *indexPath = [self.tbvGoods indexPathForCell:cell];
    
    if (indexPath.row <= 0) {
        return;
    }
    
    FNStoreManagerGoodsModel *model = self.goods[indexPath.row];
    self.goods[indexPath.row] = self.goods[indexPath.row - 1];
    self.goods[indexPath.row - 1] = model;
    
    [self.tbvGoods reloadData];
    
}
- (void) cellDidDownClick: (FNStoreManagerGoodsCell*)cell{
    NSIndexPath *indexPath = [self.tbvGoods indexPathForCell:cell];
    if (indexPath.row >= self.goods.count - 1) {
        return;
    }
    
    FNStoreManagerGoodsModel *model = self.goods[indexPath.row];
    self.goods[indexPath.row] = self.goods[indexPath.row + 1];
    self.goods[indexPath.row + 1] = model;
    
    [self.tbvGoods reloadData];
}

#pragma mark - FNStoreManagerGoodsEmptyViewDelegate

- (void)didAddClick: (FNStoreManagerGoodsEmptyView*)view {
    [self onAddClick];
}

#pragma mark - FNStoreManagerGoodsFooterViewDelegate

- (void)footerViewDidAddClick: (FNStoreManagerGoodsFooterView*)headerView {
    [self onAddClick];
}

@end
