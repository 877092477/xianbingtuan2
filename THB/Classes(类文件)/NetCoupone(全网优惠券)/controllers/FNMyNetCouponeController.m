//
//  FNMyNetCouponeController.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/10.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNMyNetCouponeController.h"
#import "FNMyNetCouponeCateModel.h"
#import "FNMyNetCouponeModel.h"
#import "FNMyNetCouponeCell.h"
#import "FNMyNetCouponeDetailController.h"

@interface FNMyNetCouponeController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *vHeader;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSArray<FNMyNetCouponeCateModel*> *cates;

@property (nonatomic, copy) NSString* type;

@property (nonatomic, strong) NSMutableArray<FNMyNetCouponeModel*> *coupones;

@end

@implementation FNMyNetCouponeController

- (void)viewDidLoad {
    [super viewDidLoad];
    _coupones = [[NSMutableArray alloc] init];
    [self requestCate];
    [self configUI];
}

- (BOOL)needLogin {
    return YES;
}

- (void)updateView {
    if (self.cates == nil || self.cates.count <= 0) {
        return ;
    }
    
    for (FNMyNetCouponeCateModel *cate in self.cates) {
       
        [_segmentedControl insertSegmentWithTitle:cate.name atIndex:0 animated:YES];//添加分页,并设置标题
        _segmentedControl.selectedSegmentIndex = 0;//选中第几个segment 一般用于初始化时选中
    }
    FNMyNetCouponeCateModel *cate = _cates[0];
    
    [_segmentedControl setTintColor:[UIColor colorWithHexString:cate.color]];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:cate.check_color],UITextAttributeTextColor,nil];
    [_segmentedControl setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    _type = cate.type;
    self.jm_page = 1;
    [self requestCards];
}

- (void)configUI {
    _vHeader = [[UIView alloc] init];
    _segmentedControl = [[UISegmentedControl alloc] init];
    
    [self.view addSubview: _vHeader];
    [_vHeader addSubview: _segmentedControl];
    
    [_vHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.mas_equalTo(40);
    }];
    
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(30);
        make.centerY.equalTo(@0);
    }];
    
    [_segmentedControl addTarget:self action:@selector(selected:) forControlEvents:UIControlEventValueChanged];
    
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.backgroundColor=RGB(238, 238, 238);
    self.jm_tableview.showsVerticalScrollIndicator = NO;
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.jm_tableview registerClass:[FNMyNetCouponeCell class] forCellReuseIdentifier:@"FNMyNetCouponeCell"];
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vHeader.mas_bottom);
        make.left.right.bottom.equalTo(@0);
    }];
}

#pragma mark - Networking
- (void)requestCate{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=coupon_exchange_userlist&ctrl=cate" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        NSString *title = respondsObject[@"top_title"];
        NSDictionary *cate = respondsObject[@"cate"];
        self.cates = [FNMyNetCouponeCateModel mj_objectArrayWithKeyValuesArray:cate];
        self.title = title;
        [self updateView];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:YES];
    
}

- (void)requestCards{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"p": @(self.jm_page)}];
    if ([_type kr_isNotEmpty]) {
        params[@"type"] = _type;
    }
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=coupon_exchange_userlist&ctrl=index" respondType:(ResponseTypeArray) modelType:@"FNMyNetCouponeModel" success:^(id respondsObject) {
        @strongify(self)
        NSArray *array = respondsObject;
        if (self.jm_page == 1) {
            [self.coupones removeAllObjects];
        }
        self.jm_page ++;
        [self.coupones addObjectsFromArray: respondsObject];
        if (array.count == 0) {
            self.jm_tableview.mj_footer = nil;
        } else {
            self.jm_tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestCards)];
        }
        
        [self.jm_tableview reloadData];
        [self.jm_tableview.mj_footer endRefreshing];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:YES];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _coupones.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNMyNetCouponeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNMyNetCouponeCell"];
    FNMyNetCouponeModel *coupone = _coupones[indexPath.section];
    
    [cell.imgBg sd_setImageWithURL:URL(coupone.bjimg)];
    cell.lblTitle.text = coupone.info;
    cell.lblTitle.textColor = [UIColor colorWithHexString: coupone.info_color];
    cell.lblPrice.text = coupone.yhq_price;
    cell.lblPrice.textColor = [UIColor colorWithHexString: coupone.yhq_price_color];
    cell.lblTime.text = coupone.valid_str;
    [cell.btnExchange sd_setImageWithURL: URL(coupone.btnimg)];
    cell.btnView.text = coupone.btn_str;
    
    return cell;
    
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FNMyNetCouponeModel *coupone = _coupones[indexPath.section];
    FNMyNetCouponeDetailController *vc = [[FNMyNetCouponeDetailController alloc] init];
    vc.cardID = coupone.id;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Action
-(void)selected:(id)sender{
    UISegmentedControl* control = (UISegmentedControl*)sender;
    NSLog(@"%ld", control.selectedSegmentIndex);
    
    _type = _cates[control.selectedSegmentIndex].type;
    self.jm_page = 1;
    [self requestCards];
}

@end
