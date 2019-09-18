//
//  FNStoreGoodsSelectManagerController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/16.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreGoodsSelectManagerController.h"
#import "FNStoreManagerGoodsEmptyView.h"
#import "FNStoreManagerCateCell.h"
#import "FNStoreGoodsSelectCell.h"
#import "FNStoreGoodsSelectHeaderView.h"

@interface FNStoreGoodsSelectManagerController()<UITableViewDelegate, UITableViewDataSource, FNStoreGoodsSelectHeaderViewDelegate>

@property (nonatomic, strong) UIView *vHeader;
@property (nonatomic, strong) UILabel *lblHeader;
@property (nonatomic, strong) UISwitch *swtHeader;

@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, strong) UIView *vBottom;
@property (nonatomic, strong) UILabel *lblCount;
@property (nonatomic, strong) UIButton *btnSave;

@property (nonatomic, strong) UITableView *tbvCates;
@property (nonatomic, strong) UITableView *tbvGoods;
@property (nonatomic, strong) FNStoreManagerGoodsEmptyView *emptyView;

@property (nonatomic, assign) NSInteger currentCateIndex;
@property (nonatomic, strong) NSArray<FNStoreManagerCateModel*> *cates;
@property (nonatomic, strong) NSMutableArray<FNStoreManagerGoodsModel*> *goods;

@end

@implementation FNStoreGoodsSelectManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"适用范围";
    
    _goods = [[NSMutableArray alloc] init];
    
    [self configUI];
    [self requestGoods];
}

- (void)configUI {
    _vHeader = [[UIView alloc] init];
    _lblHeader = [[UILabel alloc] init];
    _swtHeader = [[UISwitch alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _vBottom = [[UIView alloc] init];
    _lblCount = [[UILabel alloc] init];
    _btnSave = [[UIButton alloc] init];
    
    [self.view addSubview:_vHeader];
    [_vHeader addSubview:_lblHeader];
    [_vHeader addSubview:_swtHeader];
    [self.view addSubview:_lblTitle];
    [self.view addSubview:_vBottom];
    [_vBottom addSubview:_lblCount];
    [_vBottom addSubview:_btnSave];
    
    [_vHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(44);
    }];
    [_lblHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@26);
        make.centerY.equalTo(@0);
        make.right.lessThanOrEqualTo(self.swtHeader.mas_left).offset(-20);
    }];
    [_swtHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-13);
        make.centerY.equalTo(@0);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.vHeader.mas_bottom).offset(10);
        make.height.mas_equalTo(44);
    }];
    [_vBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.mas_equalTo(isIphoneX ? 84 : 50);
    }];
    [_lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerY.equalTo(self.btnSave);
        make.right.lessThanOrEqualTo(self.btnSave.mas_left).offset(-20);
    }];
    [_btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(@0);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(50);
//        make.bottom.equalTo(isIphoneX ? @-34 : @0);
    }];
    
    self.view.backgroundColor = RGB(250, 250, 250);
    _vHeader.backgroundColor = UIColor.whiteColor;
    
    _lblHeader.textColor = RGB(24, 24, 24);
    _lblHeader.text = @"全场通用";
    _lblHeader.font = kFONT14;
    
    _swtHeader.onTintColor = RGB(255, 102, 102);
    // 设置控件关闭状态填充色
    _swtHeader.tintColor =RGB(240, 240, 240);// [UIColor redColor];
    [_swtHeader addTarget:self action:@selector(switchStateChange) forControlEvents:UIControlEventValueChanged];
    // 设置控件开关按钮颜色
//    _swtHeader.thumbTintColor = RGB(1, 172, 243);// [UIColor orangeColor];
    
    _lblTitle.textColor = RGB(24, 24, 24);
    _lblTitle.font = [UIFont boldSystemFontOfSize:14];
    _lblTitle.textAlignment = NSTextAlignmentCenter;
    _lblTitle.backgroundColor = UIColor.whiteColor;
    _lblTitle.text = @"选择商品";
    
    _vBottom.backgroundColor = UIColor.whiteColor;
    
    _lblCount.textColor = RGB(51, 51, 51);
    _lblCount.font = kFONT14;
    _lblCount.text = @"选择数量：0";
    
    _btnSave.backgroundColor = RGB(255, 181, 76);
    _btnSave.titleLabel.font = kFONT15;
    [_btnSave setTitle:@"保存" forState: UIControlStateNormal];
    [_btnSave setTitleColor:UIColor.whiteColor forState: UIControlStateNormal];
    [_btnSave addTarget:self action:@selector(onSaveClick) forControlEvents:UIControlEventTouchUpInside];
    
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
    [self.tbvGoods registerClass:[FNStoreGoodsSelectCell class] forCellReuseIdentifier:@"FNStoreGoodsSelectCell"];
    [self.view addSubview:self.tbvGoods];
    
    _emptyView = [[FNStoreManagerGoodsEmptyView alloc] init];
//    _emptyView.delegate = self;
    _emptyView.btnAdd.hidden = YES;
    _emptyView.lblEmpty.text = @"还没有商品哦~";
    [self.view addSubview:_emptyView];
    
    [self.tbvCates mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblTitle.mas_bottom).offset(1);
        make.left.equalTo(@0);
        make.width.mas_equalTo(90);
        make.bottom.equalTo(self.vBottom.mas_top);
    }];
    [self.tbvGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblTitle.mas_bottom).offset(1);
        make.right.equalTo(@0);
        make.left.equalTo(self.tbvCates.mas_right);
        make.bottom.equalTo(self.vBottom.mas_top);
    }];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.tbvGoods);
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual: _tbvCates]) {
        if (self.cates) {
            return self.cates.count;
        }
        return 0;
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
        
        int count = 0;
        for (FNStoreManagerGoodsModel *model in self.cates[indexPath.row].goods) {
            if (model.isSelected)
                count ++;
        }
        [cell setCount: count];
        
        return cell;
    } else {
        FNStoreGoodsSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNStoreGoodsSelectCell"];
        [cell setModel: _goods[indexPath.row]];
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
        
        FNStoreGoodsSelectHeaderView* headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FNStoreGoodsSelectHeaderView"];
        if (headerView == nil) {
            headerView = [[FNStoreGoodsSelectHeaderView alloc]initWithReuseIdentifier:@"FNStoreGoodsSelectHeaderView"];
        }
        headerView.delegate = self;
        BOOL isSelected = YES;
        for (FNStoreManagerGoodsModel *model in _goods) {
            if (!model.isSelected) {
                isSelected = NO;
                break;
            }
        }
        headerView.lblTitle.text = self.cates[_currentCateIndex].name;
        [headerView setIsSelected: isSelected];
        
        return headerView;
        
    }else{
        return [UIView new];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual: _tbvCates]) {
        NSInteger index = indexPath.row ;
        _currentCateIndex = indexPath.row;
        [self filterGoods];
    } else {
        FNStoreManagerGoodsModel *goods = _goods[indexPath.row];
        goods.isSelected = !goods.isSelected;
        [self updateCount];
        [self.tbvGoods reloadData];
        [self.tbvCates reloadData];
    }
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
        [self filterGoods];
        [self.tbvCates reloadData];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

- (void)filterGoods {
    [_goods removeAllObjects];
    for (FNStoreManagerGoodsModel *goods in self.cates[_currentCateIndex].goods) {
        [_goods addObject: goods];
    }
    [self.tbvGoods reloadData];
    [self.tbvCates reloadData];
}

- (void)updateCount {
    NSInteger count = 0;
    for (FNStoreManagerCateModel *cate in self.cates) {
        for (FNStoreManagerGoodsModel *model in cate.goods) {
            if (model.isSelected)
                count ++;
        }
    }
    _lblCount.text = [NSString stringWithFormat:@"选择数量：%ld", count];
}

#pragma mark - FNStoreGoodsSelectHeaderViewDelegate

- (void)didAllClick: (FNStoreGoodsSelectHeaderView*)headerView {
    BOOL isSelected = YES;
    for (FNStoreManagerGoodsModel *model in _goods) {
        if (!model.isSelected) {
            isSelected = NO;
            break;
        }
    }
    [headerView setIsSelected: !isSelected];
    
    for (FNStoreManagerGoodsModel *model in _goods) {
        model.isSelected = !isSelected;
    }
    
    [self updateCount];
    [self.tbvGoods reloadData];
    [self.tbvCates reloadData];
}

#pragma mark - Action

- (void)onSaveClick {
    
    if ([_delegate respondsToSelector:@selector(goodsSelectController:cates:isAll:)]) {
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (FNStoreManagerCateModel* cate in _cates) {
            NSMutableArray *goods = [[NSMutableArray alloc] init];
            for (FNStoreManagerGoodsModel *model in cate.goods) {
                if (model.isSelected)
                    [goods addObject: model];
            }
            if (goods.count > 0) {
                cate.goods = goods;
                [array addObject: cate];
            }
            
        }
        
        [_delegate goodsSelectController: self cates:array isAll: _swtHeader.isOn];
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)switchStateChange {
    
    for (FNStoreManagerCateModel *cate in self.cates) {
        for (FNStoreManagerGoodsModel *model in cate.goods) {
            model.isSelected = _swtHeader.isOn;
        }
    }
    [self updateCount];
    
    [self.tbvGoods reloadData];
    [self.tbvCates reloadData];
    
}

@end
