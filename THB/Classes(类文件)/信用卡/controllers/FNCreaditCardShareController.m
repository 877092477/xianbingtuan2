//
//  FNCreaditCardShareController.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/21.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNCreaditCardShareController.h"
#import "FNCustomeNavigationBar.h"
#import "FNCreaditCardHeaderCell.h"
#import "FNCreaditCardShareHeaderView.h"
#import "FNCreaditCardDetailHeaderCell.h"
#import "FNCreaditCardShareController.h"
#import "FNCreaditCardDetailRuleCell.h"

#import "FNCreaditCardModel.h"

@interface FNCreaditCardShareController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIImageView *imageNav;
@property (nonatomic, strong)UIImageView* backBtn;


@property (nonatomic, strong)UIImageView* imgHeader;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) NSMutableArray<UIButton*> *iconButtons;

@property (nonatomic, strong) FNCreaditCardShareHeaderView *headerView;


@property (nonatomic, strong) FNCreaditCardShareModel *model;


@end

@implementation FNCreaditCardShareController


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
        
//        _navigationView.titleLabel = [[UILabel alloc] init];
//        _navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
//        _navigationView.titleLabel.sd_layout
//        .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
//        [_navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
//        _navigationView.titleLabel.textColor=[UIColor whiteColor];
//        _navigationView.titleLabel.text = @"信用卡分享";
        
    }
    return _navigationView;
}

- (FNCreaditCardShareHeaderView*)headerView {
    if (_headerView == nil) {
        _headerView = [[FNCreaditCardShareHeaderView alloc] initWithFrame:CGRectMake(0, 0, JMScreenWidth, 267)];
        
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
    [self requestDetail];
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
    
    _iconButtons = [[NSMutableArray alloc] init];
    
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
}

- (void)configBottom {
    _bottomView = [[UIView alloc] init];
    
    
    [self.view addSubview:_bottomView];
    
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(isIphoneX ? @-34 : @0);
        make.height.mas_equalTo(124);
    }];
    
    
    _bottomView.backgroundColor = UIColor.whiteColor;
    
    UIView *vLine = [[UIView alloc] init];
    [_bottomView addSubview: vLine];
    [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@13);
        make.right.equalTo(@-13);
        make.top.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    
}

- (void)configShareIcon {
    if (self.model == nil) {
        return;
    }
    
    for (UIView *v in _iconButtons) {
        [v removeFromSuperview];
    }
    [_iconButtons removeAllObjects];
    
    
    NSInteger count = self.model.shar_btn.count;
    for (NSInteger index = 0; index < count; index++) {
        UIButton *btnIcon = [[UIButton alloc] init];
        
        [_iconButtons addObject: btnIcon];
        [self.bottomView addSubview: btnIcon];
        
        [btnIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            if (index == 0) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(self.iconButtons[index - 1].mas_right);
                make.width.equalTo(self.iconButtons[0]);
            }
            
            if (index == count - 1)
                make.right.equalTo(@0);
            
            make.top.bottom.equalTo(@0);
        }];
        
        [btnIcon addTarget:self action:@selector(clickIcons:) forControlEvents:(UIControlEventTouchUpInside)];
        
        UIImageView *imgIcon = [[UIImageView alloc] init];
        [btnIcon addSubview:imgIcon];
        [imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.centerY.equalTo(@0);
            make.width.height.mas_equalTo(50);
        }];
        [imgIcon sd_setImageWithURL:URL(self.model.shar_btn[index].icon)];
        
        UILabel *lblName = [[UILabel alloc] init];
        [btnIcon addSubview:lblName];
        [lblName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.greaterThanOrEqualTo(@0);
            make.right.lessThanOrEqualTo(@0);
            make.centerX.equalTo(@0);
            make.top.equalTo(imgIcon.mas_bottom).offset(8);
        }];
        
        lblName.text = self.model.shar_btn[index].str;
        lblName.textColor = RGB(51, 51, 51);
        lblName.font = kFONT14;
        
    }
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
    
    [self.headerView.imgHeader sd_setImageWithURL: URL(self.model.img)];
    
    self.headerView.lblTitle.text = self.model.card_name;
    
    self.headerView.lblBuy.text = self.model.zgz_str;
    self.headerView.lblBuy.textColor = [UIColor colorWithHexString: self.model.zgz_color];
    [self.headerView.btnBuy sd_setBackgroundImageWithURL:URL(self.model.zgz_bg) forState:UIControlStateNormal];
    
    self.headerView.lblShare.text = self.model.fxz_str;
    self.headerView.lblShare.textColor = [UIColor colorWithHexString: self.model.fxz_color];
    [self.headerView.btnShare sd_setBackgroundImageWithURL:URL(self.model.fxz_bg) forState:UIControlStateNormal];
    
    
//    [_btnShare setTitle:[NSString stringWithFormat: @"%@\n%@", self.model.fxz_str1, self.model.fxz_str2] forState: UIControlStateNormal];
//    [_btnShare sd_setBackgroundImageWithURL:URL(self.model.fxz_bg) forState:UIControlStateNormal];
//    
//    [_btnBuy setTitle:[NSString stringWithFormat: @"%@\n%@", self.model.zgz_str1, self.model.zgz_str2] forState: UIControlStateNormal];
//    [_btnBuy sd_setBackgroundImageWithURL:URL(self.model.zgz_bg) forState:UIControlStateNormal];
//    
//    [_btnHome sd_setImageWithURL:URL(self.model.index_icon) forState:UIControlStateNormal];
    
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
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FNCreaditCardDetailRuleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNCreaditCardDetailRuleCell"];
    cell.lblTitle.text = self.model.copywriting;
    [cell setIsLast: YES];
    [cell isShowContent: YES];
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

        
    FNCreaditCardDetailHeaderCell *v = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FNCreaditCardDetailHeaderCell"];
    v.lblTitle.text = @"分享文案";

    return v;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 60;

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}

#pragma mark - Action

- (void)clickIcons: (UIButton*)sender {
    
    NSInteger index = [self.iconButtons indexOfObject: sender];
    NSString *type = self.model.shar_btn[index].type;
    
    if ([type isEqualToString: @"copy"]) {
        UIPasteboard *pab = [UIPasteboard generalPasteboard];
        [pab setString:self.model.copywriting];
        if (pab == nil) {
            [FNTipsView showTips:@"复制失败"];
        }else{
            [FNTipsView showTips:@"复制成功"];
        }
    } else {
        
//        self umengShareWithURL
        
        
        UMSocialPlatformType pType = 0;
        if ([type isEqualToString:@"wechat"]) {
//            pType = UMSocialWXMessageTypeImage;
        } else if ([type isEqualToString:@"circle_friend"]) {
            pType = UMSocialPlatformType_WechatTimeLine;
        }
        
        @weakify(self)
        [SDWebImageManager.sharedManager downloadImageWithURL:URL(self.model.share_img) options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            @strongify(self)
            if(error){
                [FNTipsView showTips:@"图片分享失败"];
            }else if (finished) {
                [self umengShareWithURL:nil image:self.model.share_img shareTitle:nil andInfo:nil];
                
                UIPasteboard *pab = [UIPasteboard generalPasteboard];
                [pab setString:self.model.copywriting];
                if (pab) {
                    [FNTipsView showTips:@"文案复制成功"];
                }
            }
        }];
        
    }
}

#pragma mark - Networking

- (FNRequestTool*) requestDetail {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"id": self.ID}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=credit_card&ctrl=share" respondType:(ResponseTypeModel) modelType:@"FNCreaditCardShareModel" success:^(id respondsObject) {
        @strongify(self);
        
        self.model = respondsObject;
        
        [self configHeader];
        [self configShareIcon];
        
        [self.jm_tableview.mj_footer endRefreshing];
        [self.jm_tableview.mj_header endRefreshing];
        [self.jm_tableview reloadData];
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache:NO];
}

@end
