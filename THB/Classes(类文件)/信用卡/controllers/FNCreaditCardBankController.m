//
//  FNCreaditCardBankController.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/20.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNCreaditCardBankController.h"
#import "FNCustomeNavigationBar.h"
#import "FNCreaditCardHeaderView.h"
#import "FNCreaditCardHeaderCell.h"
#import "FNCreaditCardCell.h"
#import "FNCreaditCardModel.h"
#import "FNCreaditCardDetailController.h"

@interface FNCreaditCardBankController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIImageView *imageNav;
@property (nonatomic, strong)UIImageView* backBtn;

@property (nonatomic, strong)UIImageView* imgHeader;
@property (nonatomic, strong) NSMutableArray<FNCreaditCardModel*> *cards;

@property (nonatomic, strong) UIView *vEmpty;
@property (nonatomic, strong) UIImageView *imgEmpty;
@property (nonatomic, strong) UILabel *lblEmpty;

@end

@implementation FNCreaditCardBankController

- (FNCustomeNavigationBar *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:_name];
        
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
//        _navigationView.titleLabel.text = _name;
        
    }
    return _navigationView;
}

- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - system
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    
    self.cards = [[NSMutableArray alloc] init];
    self.jm_page = 1;
    [self requestCards];
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
    //    self.jm_tableview.hidden = YES;
    [self.jm_tableview removeEmptyCellRows];
    [self.view addSubview:self.jm_tableview];
    
    [self.jm_tableview registerClass:[FNCreaditCardHeaderCell class]  forHeaderFooterViewReuseIdentifier:@"FNCreaditCardHeaderCell"];
    [self.jm_tableview registerClass:[FNCreaditCardCell class] forCellReuseIdentifier:@"FNCreaditCardCell"];
    
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom);
        //        make.top.equalTo(@0);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(isIphoneX ? @-34 : @0);
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
    _vEmpty.hidden = self.cards.count > 0;
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

    return [UIView new];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 108;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
    
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

- (FNRequestTool*) requestCards {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"p": @(self.jm_page)}];
    if (_ID) {
        params[@"id"] = _ID;
    }
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=credit_card&ctrl=card_list" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        
        NSString *top_bg = [respondsObject valueForKey:@"top_bg"];
        NSString *back = [respondsObject valueForKey:@"back"];
        NSString *top_color = [respondsObject valueForKey:@"top_color"];
        self.navigationView.titleLabel.textColor=[UIColor colorWithHexString: top_color];
        if (self.jm_page == 1) {
            [self.cards removeAllObjects];
        }
        NSArray *array = [respondsObject valueForKey:@"lists"];
        for (NSDictionary *dic in array) {
            FNCreaditCardModel *model = [FNCreaditCardModel mj_objectWithKeyValues:dic];
            [self.cards addObject: model];
        }
        
        if (array.count == 0) {
            self.jm_tableview.mj_footer = nil;
        } else {
            self.jm_page ++;
            self.jm_tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestCards)];
        }
        
        [self.backBtn sd_setImageWithURL: URL(back)];
        @weakify(self)
        [_imgHeader sd_setImageWithURL:[NSURL URLWithString:top_bg] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            @strongify(self)
            if (image) {
                
                [self.imgHeader mas_updateConstraints: ^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(XYScreenWidth * image.size.height / image.size.width);
                }];
                [self.view layoutIfNeeded];
            }
        }];
        
        
        
        [self.jm_tableview.mj_footer endRefreshing];
        [self.jm_tableview.mj_header endRefreshing];
        [self.jm_tableview reloadData];
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache:NO];
}

@end
