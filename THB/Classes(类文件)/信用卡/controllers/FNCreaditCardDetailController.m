//
//  FNCreaditCardDetailController.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/20.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNCreaditCardDetailController.h"
#import "FNCustomeNavigationBar.h"
#import "FNCreaditCardHeaderCell.h"
#import "FNCreaditCardDetailHeaderView.h"
#import "FNCreaditCardDetailHeaderCell.h"
#import "FNCreaditCardShareController.h"
#import "FNCreditCardHomeController.h"

#import "FNCreaditCardDetailRuleCell.h"

#import "FNCreaditCardModel.h"

@interface FNCreaditCardDetailController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIImageView *imageNav;
@property (nonatomic, strong)UIImageView* backBtn;

@property (nonatomic, strong)UIImageView* imgHeader;

@property (nonatomic, strong)FNCreaditCardDetailHeaderView *headerView;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *btnHome;
@property (nonatomic, strong) UIButton *btnShare;
@property (nonatomic, strong) UIButton *btnBuy;

@property (nonatomic, strong) FNCreaditCardDetailModel *model;

@end

@implementation FNCreaditCardDetailController


- (FNCustomeNavigationBar *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@"信用卡详情"];
        
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
        
//        _navigationView.titleLabel = [[UILabel alloc] init];
//        _navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
//        _navigationView.titleLabel.sd_layout
//        .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
//        [_navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
//        _navigationView.titleLabel.textColor=[UIColor whiteColor];
//        _navigationView.titleLabel.text = @"信用卡详情";
        
    }
    return _navigationView;
}

- (FNCreaditCardDetailHeaderView*)headerView {
    if (_headerView == nil) {
        _headerView = [[FNCreaditCardDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, JMScreenWidth, 340)];
        
    }
    return _headerView;
}

- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configBottom];
    [self configUI];
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
    self.jm_tableview.backgroundColor=RGB(250, 250, 250);
    self.jm_tableview.showsVerticalScrollIndicator = NO;
    [self.jm_tableview removeEmptyCellRows];
    self.jm_tableview.separatorStyle = UITableViewCellEditingStyleNone;
    [self.view addSubview:self.jm_tableview];
    
    [self.jm_tableview registerClass:[FNCreaditCardDetailHeaderCell class]  forHeaderFooterViewReuseIdentifier:@"FNCreaditCardDetailHeaderCell"];
    [self.jm_tableview registerClass:[FNCreaditCardDetailRuleCell class] forCellReuseIdentifier:@"FNCreaditCardDetailRuleCell"];
    
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom);
        //        make.top.equalTo(@0);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    
    self.jm_tableview.tableHeaderView = self.headerView;
    
    [self requestDetail];
}

- (void)configBottom {
    _bottomView = [[UIView alloc] init];
    _btnHome = [[UIButton alloc] init];
    _btnShare = [[UIButton alloc] init];
    _btnBuy = [[UIButton alloc] init];
    
    [self.view addSubview:_bottomView];
    [_bottomView addSubview:_btnHome];
    [_bottomView addSubview:_btnShare];
    [_bottomView addSubview:_btnBuy];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(isIphoneX ? @-34 : @0);
        make.height.mas_equalTo(50);
    }];
    [_btnHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.height.mas_equalTo(40);
        make.centerY.equalTo(@0);
    }];
    [_btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnHome.mas_right).offset(10);
        make.height.mas_equalTo(40);
        make.centerY.equalTo(@0);
        make.width.equalTo(self.btnHome);
    }];
    [_btnBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnShare.mas_right).offset(10);
        make.height.mas_equalTo(40);
        make.centerY.equalTo(@0);
        make.width.equalTo(self.btnShare);
        make.right.equalTo(@-10);
    }];
    
    _bottomView.backgroundColor = UIColor.whiteColor;
    
    [_btnHome addTarget:self action:@selector(onHomeClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    [_btnShare setTitleColor: UIColor.whiteColor forState: UIControlStateNormal];
    _btnShare.titleLabel.font = kFONT16;
    _btnShare.titleLabel.numberOfLines = 0;
    _btnShare.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_btnShare addTarget:self action:@selector(onShareClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    [_btnBuy setTitleColor: UIColor.whiteColor forState: UIControlStateNormal];
    _btnBuy.titleLabel.numberOfLines = 0;
    _btnBuy.titleLabel.font = kFONT16;
    _btnBuy.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_btnBuy addTarget:self action:@selector(onBuyClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    
}

- (void)configHeader {
    if (self.model == nil) {
        return;
    }
    
    self.navigationView.titleLabel.frame = CGRectMake(0, 0, 200, 20);
    self.navigationView.titleLabel.text = self.model.title;
    self.navigationView.titleLabel.textColor = [UIColor colorWithHexString: self.model.top_color];
    [self.navigationView.titleLabel sizeToFit];
    [self.navigationView.titleLabel mas_makeConstraints:  ^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(self.navigationView.leftButton);
    }];
    
    [self.headerView.imgBanner sd_setImageWithURL: URL(self.model.img)];
    
    self.headerView.lblTitle.text = self.model.name;
    
    self.headerView.lblBuy.text = self.model.zgz_str;
    self.headerView.lblBuy.textColor = [UIColor colorWithHexString: self.model.zgz_color];
    [self.headerView.btnBuy sd_setBackgroundImageWithURL:URL(self.model.zgz_bg) forState:UIControlStateNormal];
    
    self.headerView.lblShare.text = self.model.fxz_str;
    self.headerView.lblShare.textColor = [UIColor colorWithHexString: self.model.fxz_color];
    [self.headerView.btnShare sd_setBackgroundImageWithURL:URL(self.model.fxz_bg) forState:UIControlStateNormal];
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:self.model.fxz_str1 attributes:@{NSFontAttributeName:kFONT16, NSForegroundColorAttributeName: UIColor.whiteColor}];
    [att appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat: @"\n%@", self.model.fxz_str2] attributes:@{NSFontAttributeName:kFONT12, NSForegroundColorAttributeName: UIColor.whiteColor}]];
    [_btnShare setAttributedTitle:att forState:UIControlStateNormal];
    [_btnShare sd_setBackgroundImageWithURL:URL(self.model.fxz_bg) forState:UIControlStateNormal];
    
    
    NSMutableAttributedString *att2 = [[NSMutableAttributedString alloc]initWithString:self.model.zgz_str1 attributes:@{NSFontAttributeName:kFONT16, NSForegroundColorAttributeName: UIColor.whiteColor}];
    [att2 appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat: @"\n%@", self.model.zgz_str2] attributes:@{NSFontAttributeName:kFONT12, NSForegroundColorAttributeName: UIColor.whiteColor}]];
    [_btnBuy setAttributedTitle:att2 forState:UIControlStateNormal];
    [_btnBuy sd_setBackgroundImageWithURL:URL(self.model.zgz_bg) forState:UIControlStateNormal];
    
    [_btnHome sd_setImageWithURL:URL(self.model.index_icon) forState:UIControlStateNormal];
    
    [self.backBtn sd_setImageWithURL: URL(self.model.back)];
    @weakify(self)
    [_imgHeader sd_setImageWithURL:[NSURL URLWithString:self.model.top_bg] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (image) {
            
            [self.imgHeader mas_updateConstraints: ^(MASConstraintMaker *make) {
                make.height.mas_equalTo(XYScreenWidth * image.size.height / image.size.width);
            }];
            [self.view layoutIfNeeded];
        }
    }];
}

#pragma mark -  UITableViewDelegate && UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0)
        return self.model.rights.count;
    else
        return self.model.rule.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FNCreaditCardDetailRuleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNCreaditCardDetailRuleCell"];
    if (indexPath.section == 0) {
        cell.lblTitle.text = self.model.rights[indexPath.row];
        [cell setIsLast: indexPath.row == self.model.rights.count - 1];
    } else {
        cell.lblTitle.text = self.model.rule[indexPath.row];
        [cell setIsLast: indexPath.row == self.model.rule.count - 1];
    }
    
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    FNCreaditCardDetailHeaderCell *v = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FNCreaditCardDetailHeaderCell"];
    if (section == 0)
        v.lblTitle.text = self.model.str1;
    else
        v.lblTitle.text = self.model.str2;
    return v;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
#pragma mark - Table view delegate
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 60;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 60;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}

#pragma mark - Action

- (void)onHomeClick {
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[FNCreditCardHomeController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}

- (void)onBuyClick {
    [self goWebWithUrl: self.model.zgz_url];
}

- (void)onShareClick {
    FNCreaditCardShareController *vc = [[FNCreaditCardShareController alloc] init];
    vc.ID = self.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Networking

- (FNRequestTool*) requestDetail {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"id": self.ID}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=credit_card&ctrl=card_detail" respondType:(ResponseTypeModel) modelType:@"FNCreaditCardDetailModel" success:^(id respondsObject) {
        @strongify(self);
        
        self.model = respondsObject;
        
        [self configHeader];
        
        [self.jm_tableview.mj_footer endRefreshing];
        [self.jm_tableview.mj_header endRefreshing];
        [self.jm_tableview reloadData];
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache:NO];
}


@end
