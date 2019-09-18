//
//  FNMyVideoCardListController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNMyVideoCardListController.h"
#import "FNMyVideoCardModel.h"
#import "FNMyVideoCardTableViewCell.h"
#import "FNMyVideoCardBuyController.h"
#import "FNMyVideoCardDetailController.h"

@interface FNMyVideoCardListController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<FNMyVideoCardModel*>* dataArray;
@property (nonatomic, strong) UIButton *btnBuy;

@end

@implementation FNMyVideoCardListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = FNHomeBackgroundColor;
    
    _dataArray = [[NSMutableArray alloc] init];
    self.jm_page = 1;
    [self configUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.jm_page = 1;
    [self requestMain];
}

- (void)configUI {
    self.jm_tableview = [[UITableView alloc] init];
    [self.view addSubview:self.jm_tableview];
    self.jm_tableview.backgroundColor = FNHomeBackgroundColor;
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jm_tableview.delegate = self;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.estimatedSectionFooterHeight = 0;
    self.jm_tableview.estimatedSectionHeaderHeight = 0;
    [self.jm_tableview registerClass:[FNMyVideoCardTableViewCell class] forCellReuseIdentifier:@"FNMyVideoCardTableViewCell"];
    
    @weakify(self)
    self.jm_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.jm_page = 1;
        [self requestMain];
    }];
    self.jm_tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMain)];
    
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.bottom.equalTo(@(-SafeAreaTopHeight));
    }];
    
    _btnBuy = [[UIButton alloc] init];
    [self.view addSubview:_btnBuy];
    [_btnBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@100);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(200);
    }];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"暂时没有卡密哦！\n" attributes:@{NSForegroundColorAttributeName: RGB(153, 153, 153)}];
    [str appendAttributedString:[[NSAttributedString alloc] initWithString:@"点这里" attributes:@{NSForegroundColorAttributeName: RGB(249, 104, 70)}]];
    [str appendAttributedString:[[NSAttributedString alloc] initWithString:@"前往购买" attributes:@{NSForegroundColorAttributeName: RGB(153, 153, 153)}]];
    [_btnBuy setAttributedTitle:str forState:UIControlStateNormal];
    [_btnBuy setImage:IMAGE(@"video_card_package") forState:UIControlStateNormal];
    _btnBuy.titleLabel.font = kFONT14;
    _btnBuy.titleLabel.numberOfLines = 0;
    _btnBuy.hidden = YES;
    [_btnBuy layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyleTop) imageTitleSpace:10];
    [_btnBuy addTarget:self action:@selector(goBuyCard)];
}

-(void)goBuyCard{
    FNMyVideoCardBuyController *vc = [[FNMyVideoCardBuyController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    _btnBuy.hidden = self.dataArray.count > 0;
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FNMyVideoCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNMyVideoCardTableViewCell"];
    FNMyVideoCardModel *model = self.dataArray[indexPath.row];
    [cell setLeftImage:model.img withRightImage:model.list_bjimg];
    cell.lblType.text = model.title;
    cell.lblTitle.text = model.content;
    cell.lblTime.text = model.time_str;
    [cell.imgCode sd_setImageWithURL:URL(model.qrcode_ico)];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 111;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FNMyVideoCardModel *model = self.dataArray[indexPath.row];
    FNMyVideoCardDetailController *vc = [[FNMyVideoCardDetailController alloc] init];
    vc.cardId = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Networking
- (FNRequestTool*) requestMain {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"p": @(self.jm_page), @"type": _type}];
    [SVProgressHUD show];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=app_movie_order&ctrl=index" respondType:(ResponseTypeArray) modelType:@"FNMyVideoCardModel" success:^(id respondsObject) {
        @strongify(self);
        
        if (self.jm_page == 1) {
            [self.dataArray removeAllObjects];
        }
        NSArray* array = respondsObject;
        if (array.count > 0)
            self.jm_page ++;
        self.jm_tableview.mj_footer.hidden = array.count <= 0;
        
        [self.dataArray addObjectsFromArray:respondsObject];
        [self.jm_tableview reloadData];
        [SVProgressHUD dismiss];
        [self.jm_tableview.mj_footer endRefreshing];
        [self.jm_tableview.mj_header endRefreshing];
    } failure:^(NSString *error) {
        
        [SVProgressHUD dismiss];
    } isHideTips:YES isCache:NO];
}

@end
