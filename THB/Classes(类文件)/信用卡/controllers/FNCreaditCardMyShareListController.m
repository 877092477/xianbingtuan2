//
//  FNCreaditCardMyShareListController.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/21.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNCreaditCardMyShareListController.h"
#import "FNCreaditCardMyShareCell.h"
#import "FNCreaditCardMyShareModel.h"

@interface FNCreaditCardMyShareListController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<FNCreaditCardMyShareItemModel*> *shares;

@property (nonatomic, strong) UIView *vEmpty;
@property (nonatomic, strong) UIImageView *imgEmpty;
@property (nonatomic, strong) UILabel *lblEmpty;

@end

@implementation FNCreaditCardMyShareListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _shares = [[NSMutableArray alloc] init];
    [self configUI];
    
    self.jm_page = 1;
    [self requestDatas];
}

- (void)configUI {
    
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.backgroundColor=RGB(250, 250, 250);
    self.jm_tableview.showsVerticalScrollIndicator = NO;
    [self.jm_tableview removeEmptyCellRows];
    [self.view addSubview:self.jm_tableview];
    
//    [self.jm_tableview registerClass:[FNCreaditCardDetailHeaderCell class]  forHeaderFooterViewReuseIdentifier:@"FNCreaditCardDetailHeaderCell"];
        [self.jm_tableview registerClass:[FNCreaditCardMyShareCell class] forCellReuseIdentifier:@"FNCreaditCardMyShareCell"];
    
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    _vEmpty = [[UIView alloc] init];
    [self.view addSubview: _vEmpty];
    _imgEmpty = [[UIImageView alloc] init];
    [_vEmpty addSubview: _imgEmpty];
    _lblEmpty = [[UILabel alloc] init];
    [_vEmpty addSubview: _lblEmpty];
    [_vEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.jm_tableview);
    }];
    [_imgEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(@0);
        make.top.equalTo(@0);
        make.centerX.equalTo(@0);
    }];
    [_lblEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(@0);
        make.top.equalTo(self.imgEmpty.mas_bottom).offset(35);
        make.bottom.equalTo(@0);
        make.centerX.equalTo(@0);
    }];
    
    _imgEmpty.image = IMAGE(@"creaditcard_image_empty");
    _lblEmpty.text = @"暂时还没有数据哦~";
    _lblEmpty.font = kFONT14;
    _lblEmpty.textColor = RGB(153, 153, 153);
    _vEmpty.hidden = YES;
    
}

#pragma mark -  UITableViewDelegate && UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    _vEmpty.hidden = self.shares.count > 0;
    return self.shares.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNCreaditCardMyShareItemModel *share = self.shares[indexPath.row];
    FNCreaditCardMyShareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNCreaditCardMyShareCell"];
    cell.lblTitle.text = share.name;
    cell.lblName.text = share.apply_str;
    cell.lblCommission.text = share.commission_str;
    cell.lblTime.text = share.time;
    [cell setTags: share.rights withColor: [UIColor colorWithHexString: share.rights_color] andBg: share.rights_bg];
    [cell.imgHeader sd_setImageWithURL: URL(share.img)];
    [cell setState: share.state_icon];
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 114;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}


#pragma mark - Networking

- (FNRequestTool*) requestDatas {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"p": @(self.jm_page)}];
    if (_type) {
        params[@"type"] = _type;
    }
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=credit_card&ctrl=my_extend" respondType:(ResponseTypeArray) modelType:@"FNCreaditCardMyShareItemModel" success:^(id respondsObject) {
        @strongify(self);
        
        NSArray *array = respondsObject;
        if (self.jm_page == 1) {
            [self.shares removeAllObjects];
        }
        if (array.count == 0) {
            self.jm_tableview.mj_footer = nil;
        } else {
            self.jm_page ++;
            self.jm_tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestDatas)];
        }
        [self.shares addObjectsFromArray:array];
        
        
        [self.jm_tableview.mj_footer endRefreshing];
        [self.jm_tableview.mj_header endRefreshing];
        [self.jm_tableview reloadData];
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache:NO];
}

@end
