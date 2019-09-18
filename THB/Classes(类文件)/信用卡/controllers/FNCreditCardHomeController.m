//
//  FNCreditCardHomeController.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/20.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNCreditCardHomeController.h"
#import "FNCustomeNavigationBar.h"
#import "FNCreaditCardHeaderView.h"
#import "FNCreaditCardHeaderCell.h"
#import "FNCreaditCardCell.h"
#import "FNCreaditCardBankController.h"
#import "FNCreaditCardDetailController.h"
#import "FNCreaditCardMyShareController.h"

#import "FNCreaditCardTopModel.h"
#import "FNCreaditCardModel.h"

@interface FNCreditCardHomeController()<UITableViewDelegate, UITableViewDataSource, FNCreaditCardHeaderViewDelegate>

@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIImageView *imageNav;
@property (nonatomic, strong)UIButton* settingBtn;
@property (nonatomic, strong)UIImageView* backBtn;

@property (nonatomic, strong)UIImageView* imgHeader;

@property (nonatomic, strong) FNCreaditCardHeaderView *headerView;

@property (nonatomic, strong) FNCreaditCardTopModel* topModel;
@property (nonatomic, strong) NSMutableArray<FNCreaditCardModel*> *cards;

@end

@implementation FNCreditCardHomeController

- (FNCreaditCardHeaderView*)headerView {
    if (_headerView == nil) {
        _headerView = [[FNCreaditCardHeaderView alloc] initWithFrame:CGRectMake(0, 0, JMScreenWidth, 220)];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (FNCustomeNavigationBar *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
        
        _imageNav = [[UIImageView alloc] init];
        //        [_navigationView addSubview:_imageNav];
        [_navigationView insertSubview:_imageNav atIndex:0];
        [_imageNav mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        _imageNav.contentMode = UIViewContentModeScaleAspectFill;
        _imageNav.layer.masksToBounds = YES;
        
        UIButton* leftView = [UIButton new];
        self.backBtn = [[UIImageView alloc] init];
        self.backBtn.size = CGSizeMake(9, 15);
        [leftView addSubview:self.backBtn];
        leftView.frame = CGRectMake(0, 0, 20, 20);
        [leftView addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        
        _navigationView.leftButton = leftView;
        
        if(self.understand==YES){
            self.backBtn.hidden=YES;
        }
        
        
    }
    return _navigationView;
}

- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)settingBtnAction {
    FNCreaditCardMyShareController *vc = [[FNCreaditCardMyShareController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - system
- (void)viewDidLoad {
    
    _cards = [[NSMutableArray alloc] init];
    
    [super viewDidLoad];
    
    [self configUI];
    
    self.jm_page = 1;
    [self requestTop];
    [self requestHot];
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

- (void)configUI {
    
    self.view.backgroundColor=RGB(250, 250, 250);
    
    _imgHeader = [[UIImageView alloc] init];
    [self.view addSubview: _imgHeader];
    [_imgHeader mas_makeConstraints: ^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.mas_equalTo(0);
    }];
    
    [self.view addSubview:self.navigationView];
    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:self.navigationView.height];
    
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.backgroundColor=UIColor.clearColor;
    self.jm_tableview.showsVerticalScrollIndicator = NO;
//    self.jm_tableview.hidden = YES;
    [self.jm_tableview removeEmptyCellRows];
    [self.view addSubview:self.jm_tableview];
    
    [self.jm_tableview registerClass:[FNCreaditCardHeaderCell class]  forHeaderFooterViewReuseIdentifier:@"FNCreaditCardHeaderCell"];
    [self.jm_tableview registerClass:[FNCreaditCardCell class] forCellReuseIdentifier:@"FNCreaditCardCell"];
    self.jm_tableview.separatorStyle = UITableViewCellEditingStyleNone;
    
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom);
//        make.top.equalTo(@0);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(self.understand ? @(-XYTabBarHeight) : (isIphoneX ? @-34 : @0));
    }];
    // 上拉加载
    @weakify(self)
    self.jm_tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        [self requestHot];
    }];
    
    
    self.jm_tableview.tableHeaderView = self.headerView;
}


- (void)configHeader {
    if (self.topModel == nil) {
        return;
    }
    self.navigationView.titleLabel.frame = CGRectMake(0, 0, 200, 20);
    self.navigationView.titleLabel.text = self.topModel.title;
    self.navigationView.titleLabel.textColor = [UIColor colorWithHexString: self.topModel.color];
    [self.navigationView.titleLabel sizeToFit];
    [self.navigationView.titleLabel mas_makeConstraints:  ^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(self.navigationView.leftButton);
    }];
    
    self.settingBtn = [UIButton buttonWithTitle:self.topModel.extend titleColor:[UIColor colorWithHexString: self.topModel.color] font:kFONT14 target:self action:@selector(settingBtnAction)];
    NSLog(@"%f  %f", self.settingBtn.width, self.settingBtn.height);
    self.settingBtn.frame = CGRectMake(0, 0, 80, 20);
    
    _navigationView.rightButton = self.settingBtn;
    
    [self.settingBtn autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:_navigationView.titleLabel withOffset:0];
    [self.settingBtn autoSetDimensionsToSize:self.settingBtn.size];
    [self.settingBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    NSMutableArray *names = [[NSMutableArray alloc] init];
    for (FNCreaditCardTopIconModel *icon in self.topModel.list) {
//        -(void)setImages:(NSArray *)images names: (NSArray*)names
        [images addObject: icon.logo];
        [names addObject: icon.name];
    }
    [self.headerView setImages: images names: names];
    
    [self.backBtn sd_setImageWithURL: URL(self.topModel.back)];
    @weakify(self)
    [_imgHeader sd_setImageWithURL:[NSURL URLWithString:_topModel.bg] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (image) {
            
            [self.imgHeader mas_updateConstraints: ^(MASConstraintMaker *make) {
                make.height.mas_equalTo(XYScreenWidth * self.topModel.bili.floatValue);
            }];
            [self.view layoutIfNeeded];
        }
    }];
}

#pragma mark -  UITableViewDelegate && UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cards.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FNCreaditCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNCreaditCardCell"];
    
    FNCreaditCardModel *model = self.cards[indexPath.row];
    
    [cell.imgCard sd_setImageWithURL: URL(model.img)];
    cell.lblTitle.text = model.name;
//    cell.lblCount.text = @"申请人数：9061";
    
    cell.lblBuy.text = model.zgz_str;
    cell.lblBuy.textColor = [UIColor colorWithHexString: model.zgz_color];
    [cell.btnBuy sd_setBackgroundImageWithURL:URL(model.zgz_bg) forState:UIControlStateNormal];
    
    cell.lblShare.text = model.fxz_str;
    cell.lblShare.textColor = [UIColor colorWithHexString: model.fxz_color];
    [cell.btnShare sd_setBackgroundImageWithURL:URL(model.fxz_bg) forState:UIControlStateNormal];
    
    [cell setTags: model.rights withColor: [UIColor colorWithHexString: model.rights_color] andBg: model.rights_bg];
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    FNCreaditCardHeaderCell *v = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FNCreaditCardHeaderCell"];
    if (self.topModel) {
        v.lblTitle.text = self.topModel.recommend;
        [v.imgIcon sd_setImageWithURL: URL(self.topModel.recommend_icon)];
    }
    return v;

}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 108;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 36;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FNCreaditCardDetailController *vc = [[FNCreaditCardDetailController alloc] init];
    FNCreaditCardModel *model = self.cards[indexPath.row];
    vc.ID = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Networking

- (FNRequestTool*) requestTop {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=credit_card&ctrl=top" respondType:(ResponseTypeModel) modelType:@"FNCreaditCardTopModel" success:^(id respondsObject) {
        @strongify(self);

        self.topModel = respondsObject;


        [self.jm_tableview.mj_footer endRefreshing];
        [self.jm_tableview.mj_header endRefreshing];
        [self.jm_tableview reloadData];
        [self configHeader];

    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache:NO];
}

- (FNRequestTool*) requestHot {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"p": @(self.jm_page)}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=credit_card&ctrl=my_recommend" respondType:(ResponseTypeArray) modelType:@"FNCreaditCardModel" success:^(id respondsObject) {
        @strongify(self);
        
        if (self.jm_page == 1) {
            [self.cards removeAllObjects];
        }
        self.jm_page ++;
        [self.cards addObjectsFromArray:respondsObject];
        
        
        [self.jm_tableview.mj_footer endRefreshing];
        [self.jm_tableview.mj_header endRefreshing];
        [self.jm_tableview reloadData];
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache:NO];
}

#pragma mark - FNCreaditCardHeaderViewDelegate

- (void)didIconClick: (NSInteger) index {
    if (index < 0 || index > self.topModel.list.count) {
        return;
    }
    FNCreaditCardTopIconModel *icon = self.topModel.list[index];
    
    FNCreaditCardBankController *vc = [[FNCreaditCardBankController alloc] init];
    vc.name = icon.name;
    vc.ID = icon.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
