//
//  FNLiveBroadcastController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveBroadcastController.h"
#import "FNLiveBroadcastGiftView.h"
#import "FNLiveBroadcastLogView.h"
#import "FNLiveBroadcastNoticeView.h"
#import "FNCustomeNavigationBar.h"
#import "FNLiveBroadcastModel.h"
#import "FNHomeFunctionBtn.h"
#import "FNLiveBroadcastGoodsAlert.h"
#import "FNHomeProductSingleRowCell.h"
#import "FNLiveBroadcastLogModel.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "WKWebViewJavascriptBridge.h"
#import <WebKit/WebKit.h>
#import "FNLiveBroadcastGoodsImageCell.h"
#import "FNLiveBroadcastGoodsTextCell.h"
#import "FNLiveBroadcastGoodsCell.h"
#import "FNLiveBroadcastGoodsModel.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface FNLiveBroadcastController ()<UICollectionViewDelegate, UICollectionViewDataSource, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler, UITableViewDelegate, UITableViewDataSource, FNLiveBroadcastGoodsCellDelegate, FNLiveBroadcastGoodsTextCellDelegate, FNLiveBroadcastGoodsImageCellDelegate>

@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIImageView* navigationBg;

@property (nonatomic, strong)UIImageView* backImage;
@property (nonatomic, strong)UIButton* backBtn;
@property (nonatomic, strong)UILabel* lblTitle;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) NSMutableArray<UIView*> *buttons;
@property (nonatomic, strong) NSMutableArray<UILabel*> *labels;

@property (nonatomic, strong) FNLiveBroadcastGiftView *giftView;
@property (nonatomic, strong) FNLiveBroadcastLogView *logView;
@property (nonatomic, strong) FNLiveBroadcastNoticeView *noticeView;

@property (nonatomic, strong) FNLiveBroadcastModel *model;
@property (nonatomic, strong) NSMutableArray<FNBaseProductModel*> *goods;

@property (nonatomic, strong) NSMutableArray<FNLiveBroadcastGoodsModel*> *broadcasts;
@property (nonatomic, assign) NSInteger logIndex;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *goodsTimer;

@property (nonatomic, strong) NSMutableArray<FNLiveBroadcastLogModel*> *logs;

@property (nonatomic, strong) FNLiveBroadcastGoodsAlert *alertView;

@property (nonatomic, strong) NSMutableArray<FNLiveBroadcastGoodsModel*> *queue;

/**
 js交互
 */
@property (nonatomic, strong) WKWebView *webview;
@property (nonatomic, strong) WKWebViewJavascriptBridge *bridge;

@end

@implementation FNLiveBroadcastController

static NSString *CellIdentifier = @"HomeViewGoodsCell";
static NSString *SingleCellId = @"HomeViewGoodsSingleCell";

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
    
    [self startTimer];
    
}

- (void)startTimer {
    double logTime = 3;
    double goodsTime = 5;
    if (self.model && [self.model.live_send_time kr_isNotEmpty]) {
        goodsTime = self.model.live_send_time.doubleValue / 1000.0;
    }
    if (self.model && [self.model.live_user_time kr_isNotEmpty]) {
        logTime = self.model.live_user_time.doubleValue / 1000.0;
    }
    
    [_timer invalidate];
    _timer = [NSTimer timerWithTimeInterval:logTime target:self selector:@selector(showLogs) userInfo:nil repeats:YES];
    
    [_goodsTimer invalidate];
    _goodsTimer = [NSTimer timerWithTimeInterval:goodsTime target:self selector:@selector(rollGoods) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] addTimer:_goodsTimer forMode:NSDefaultRunLoopMode];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [_timer invalidate];
    _timer = nil;
    
    [_goodsTimer invalidate];
    _goodsTimer = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.buttons = [[NSMutableArray alloc] init];
    self.labels = [[NSMutableArray alloc] init];
    self.goods = [[NSMutableArray alloc] init];
    self.logs = [[NSMutableArray alloc] init];
    self.broadcasts = [[NSMutableArray alloc] init];
    self.logs = [[NSMutableArray alloc] init];
    self.queue = [[NSMutableArray alloc] init];
    
    [self configUI];
    [self requestMain];
    [self requestLog:nil];
    [self requestGoods];
    
    if ([[FNBaseSettingModel settingInstance].live_type_onoff isEqualToString:@"1"]) {
        [self requestBroadcast];
    } else {
        [self configWebview];
    }
}


- (void)configUI {
    
    self.jm_tableview = [[UITableView alloc] init];
    [self.view addSubview:self.jm_tableview];
    
    self.jm_tableview.delegate = self;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.rowHeight = UITableViewAutomaticDimension;
    self.jm_tableview.estimatedRowHeight = 200;
    self.jm_tableview.estimatedSectionFooterHeight = 0;
    self.jm_tableview.estimatedSectionHeaderHeight = 0;
//    self.jm_tableview.backgroundColor = FNHomeBackgroundColor;
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.jm_tableview registerClass:[FNLiveBroadcastGoodsImageCell class] forCellReuseIdentifier:@"FNLiveBroadcastGoodsImageCell"];
    [self.jm_tableview registerClass:[FNLiveBroadcastGoodsTextCell class] forCellReuseIdentifier:@"FNLiveBroadcastGoodsTextCell"];
    [self.jm_tableview registerClass:[FNLiveBroadcastGoodsCell class] forCellReuseIdentifier:@"FNLiveBroadcastGoodsCell"];
    
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _giftView = [[FNLiveBroadcastGiftView alloc] init];
    _giftView.userInteractionEnabled = NO;
    [self.view addSubview:_giftView];
    
    _logView = [[FNLiveBroadcastLogView alloc] init];
    _logView.userInteractionEnabled = NO;
    [self.view addSubview:_logView];
    _noticeView = [[FNLiveBroadcastNoticeView alloc] init];
    [self.view addSubview:_noticeView];
    
    _bottomView = [[UIView alloc] init];
    [self.view addSubview:_bottomView];
    
    _alertView = [[FNLiveBroadcastGoodsAlert alloc] init];
    _alertView.covGoods.dataSource = self;
    _alertView.covGoods.delegate = self;
//    [_alertView.covGoods registerClass:[FNHomeProductCell class] forCellWithReuseIdentifier:CellIdentifier];
    [_alertView.covGoods registerClass:[FNHomeProductSingleRowCell class] forCellWithReuseIdentifier:SingleCellId];
    _alertView.covGoods.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestGoods)];
    
    [self.view addSubview:self.navigationView];
    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:self.navigationView.height];
    [self.navigationView autoSetDimension:(ALDimensionWidth) toSize:XYScreenWidth];
    
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.navigationView.mas_bottom);
        make.bottom.equalTo(self.understand ? @-50 : @0);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.bottom.equalTo(self.understand ? @-120 : @-60);
    }];
    
    
    [_giftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bottomView);
        make.bottom.equalTo(self.bottomView.mas_top).offset(24);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(200);
    }];
    
    [_logView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(self.understand ? @-80 : @-20);
        make.right.equalTo(@-100);
        make.height.mas_equalTo(140);
    }];
    
    [_noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_right);
        make.top.equalTo(self.navigationView.mas_bottom).offset(40);
    }];
    
}

- (void)configButtons {
    
    for (UIButton *button in self.buttons) {
        [button removeFromSuperview];
    }
    [self.buttons removeAllObjects];
    
    for (NSInteger index = 0; index < self.model.ico_list.count; index++ ) {
        FNLiveBroadcastButtonModel *icon = self.model.ico_list[index];
        
        UIButton *button = [[UIButton alloc] init];

        [button sd_setBackgroundImageWithURL:URL(icon.img) forState:UIControlStateNormal];
//        [button sd_setBackgroundImageWithURL:URL(icon.check_img) forState:UIControlStateHighlighted];
        [button sd_setBackgroundImageWithURL:URL(icon.check_img) forState:UIControlStateSelected];
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor colorWithHexString:icon.color];
        label.text = icon.str;
        label.font = kFONT12;
        
        [self.bottomView addSubview:button];
        [self.buttons addObject:button];
        [self.bottomView addSubview:label];
        [self.labels addObject:label];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.width.height.mas_equalTo(48);
            if (index == 0) {
                make.top.equalTo(@0);
            } else {
                make.top.equalTo(self.labels[index - 1].mas_bottom).offset(10);
            }
            make.bottom.lessThanOrEqualTo(@0);
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(button);
            make.top.equalTo(button.mas_bottom).offset(8);
        }];
        
        [button addTarget:self action:@selector(onButtonAction:)];
        
    }
}

- (void)configNavImage {
    UIView *rightView = [[UIView alloc] init];
    [self.navigationView addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.navigationView.leftButton);
        make.right.equalTo(@-10);
    }];
    for (NSInteger index = 0; index < self.model.img_list.count; index ++) {
        UIImageView *imgHeader = [[UIImageView alloc] init];
        [rightView insertSubview:imgHeader atIndex:0];
        [imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-index * 20));
            make.width.height.mas_equalTo(34);
            make.centerY.equalTo(@0);
        }];
        [imgHeader sd_setImageWithURL:URL(self.model.img_list[index])];
        imgHeader.cornerRadius = 17;
        imgHeader.borderColor = RGB(250, 250, 0);
        imgHeader.borderWidth = 1;
    }
}

- (FNCustomeNavigationBar *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
        
        _navigationBg = [[UIImageView alloc] init];
//        [_navigationView addSubview:_navigationBg];
        [_navigationView insertSubview:_navigationBg atIndex:0];
//        _navigationBg.image = IMAGE(@"live_broadcast_nav_bg");
        [_navigationBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        
        UIView *leftView = [[UIView alloc] init];
        leftView.frame = CGRectMake(0, 0, 25, 25);
        
        self.backImage = [[UIImageView alloc] init];
        self.backImage.contentMode = UIViewContentModeScaleAspectFit;
        self.backImage.frame = CGRectMake(0, 0, 20, 20);
        
        self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.backBtn.frame=CGRectMake(0, 0, 25, 25);
        [leftView addSubview:self.backImage];
        [leftView addSubview:self.backBtn];
        
        
        _navigationView.leftButton = leftView;
        
        _navigationView.titleLabel.text = self.title;
        _navigationView.titleLabel.sd_layout
        .centerYEqualToView(_navigationView.leftButton).centerXEqualToView(_navigationView).heightIs(20);
        [_navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
        
    }
    return _navigationView;
}

- (void)onButtonAction: (UITapGestureRecognizer*)sender {
    UIButton *button = (UIButton*)sender.view;
    NSInteger index = [self.buttons indexOfObject:button];
    if (index < 0 || index >= self.model.ico_list.count) {
        return ;
    }
    
    FNLiveBroadcastButtonModel *model = self.model.ico_list[index];
    if ([model.type isEqualToString:@"like"]) {
        if (!button.selected) {
            button.selected = YES;
            [self requestLike];
        }
        [_giftView randomGift];
    } else if ([model.type isEqualToString:@"hide"]) {
        
        button.selected = !button.selected;
        
        for (NSInteger index = 0; index < self.model.ico_list.count; index ++) {
            FNLiveBroadcastButtonModel *model = self.model.ico_list[index];
            if ([model.type isEqualToString:@"like"]) {
                self.buttons[index].hidden = button.selected;
                self.labels[index].hidden = button.selected;
            }
        }
        self.logView.hidden = button.selected;
        self.noticeView.hidden = button.selected;
        
    } else if ([model.type isEqualToString:@"live_list"]) {
        [self.view addSubview:_alertView];
        self.jm_page = 1;
        [self.goods removeAllObjects];
        [self.alertView.covGoods reloadData];
        [self requestGoods];
        [_alertView show];
    }
}

- (void)configWebview {
    //1、该对象提供了通过js向web view发送消息的途径
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    //添加在js中操作的对象名称，通过该对象来向web view发送消息
    [userContentController addScriptMessageHandler:self name:@"WebViewJavascriptBridge"];
    
    //2、
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    config.userContentController = userContentController;
    
    self.webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight) configuration:config];
    [self.view insertSubview:self.webview atIndex:0];
    self.webview.hidden = YES;
    
    NSString *url =[NSString stringWithFormat:@"%@%@%@",IP,_api_showorder_WirteCache,UserAccessToken];
    NSURL *webUrl = [NSURL URLWithString:url];
    NSURLRequest *request =[NSURLRequest requestWithURL:webUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    [self.webview loadRequest:request];
    self.webview.UIDelegate = self;
    self.webview.navigationDelegate = self;
}

- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showNotice {
    [_noticeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_right).offset(100);
        make.top.equalTo(self.navigationView.mas_bottom).offset(40);
    }];

    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    
    [self.noticeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_left).offset(-100);
        make.top.equalTo(self.navigationView.mas_bottom).offset(40);
    }];
    
    [self.view setNeedsLayout];
    [UIView animateWithDuration:15 delay:0 options:(UIViewAnimationOptionRepeat | UIViewAnimationCurveLinear) animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showLogs {
    
//    [self randomGoods];
    
    if (self.logs.count <= 0) {
        return;
    }
    _logIndex = _logIndex % self.logs.count;
    FNLiveBroadcastLogModel *log = self.logs[_logIndex];
//    [_logView appendLog:log.msg withImage:log.img];
    [_logView appendLog:log.msg
              withImage:([log.type isEqualToString:@"like"] ?  @"" : log.img)
                   icon:([log.type isEqualToString:@"like"] ? log.img : @"")];
    _logIndex ++;
    if (_logIndex >= self.logs.count - 1) {
        [self requestLog:self.logs.lastObject.ID];
    }
}

- (void)rollGoods {
    if (self.queue.count <= 0) {
        return;
    }
    
    
    FNLiveBroadcastGoodsModel *model = self.queue[0];
    [self.queue removeObjectAtIndex:0];
    
    bool isBottom = NO;
    UITableViewCell *cell = self.jm_tableview.visibleCells.lastObject;
    if (cell) {
        NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
        
        if (indexPath.row == self.broadcasts.count - 1) {
            isBottom = YES;
        }
    }
    
    if ([model.type isEqualToString:@"image"]) {
        
        @weakify(self)
        [XYNetworkAPI downloadImages:@[model.data] withFinishedBlock:^(NSArray<UIImage *> *images) {
            @strongify(self)
            model.image = images.firstObject;
            [self.broadcasts addObject:model];
            
            [self.jm_tableview reloadData];
            
            if (isBottom) {
                [self.jm_tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.broadcasts.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
        }];
        
    } else {
        [self.broadcasts addObject:model];
        [self.jm_tableview reloadData];
        
        if (isBottom) {
            [self.jm_tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.broadcasts.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }
    
    
    
    if ([[FNBaseSettingModel settingInstance].live_type_onoff isEqualToString:@"1"]) {
        if (_queue.count <= 0) {
            [self requestBroadcast];
        }
    }
}

- (void)showGood: (FNLiveBroadcastGoodsModel*) model {
    
    [self.queue addObject:model];
}

#pragma mark - Networking

- (FNRequestTool*) requestMain {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, PageNumber: @(self.jm_page)}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=liveStream&ctrl=index" respondType:(ResponseTypeModel) modelType:@"FNLiveBroadcastModel" success:^(id respondsObject) {
        @strongify(self);
        
        self.model = respondsObject;
        
        [self startTimer];
//        [self.backBtn sd_setImageWithURL:URL(self.model.return_img) forState:UIControlStateNormal];
        [self.backImage sd_setImageWithURL:URL(self.model.return_img)];
        [self.navigationBg sd_setImageWithURL:URL(self.model.top_img) placeholderImage:IMAGE(@"live_broadcast_nav_bg")];
        self.navigationView.titleLabel.textColor = [UIColor colorWithHexString:self.model.top_fontcolor];
        self.navigationView.leftButton.hidden = self.understand;

        self.noticeView.lblLeft.text = self.model.affiche.left_str;
        self.noticeView.lblLeft.textColor = [UIColor colorWithHexString:self.model.affiche.left_color];
        self.noticeView.lblRight.text = self.model.affiche.right_str;
        self.noticeView.lblRight.textColor = [UIColor colorWithHexString:self.model.affiche.right_color];
        self.noticeView.hidden = ![self.model.affiche.is_show isEqualToString:@"1"];
        [self showNotice];
        [self configButtons];
        [self configNavImage];
        
    } failure:^(NSString *error) {
        @strongify(self);
            [XYNetworkAPI cancelAllRequest];
            [SVProgressHUD dismiss];
    } isHideTips:YES isCache:YES];
}

- (FNRequestTool*) requestBroadcast {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"p": @(self.jm_page)}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=liveStream&ctrl=auto_list" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        
        if (self.jm_page == 1) {
            [self.broadcasts removeAllObjects];
        }
        self.jm_page ++;
        
        for (NSDictionary* dic in respondsObject) {
            FNLiveBroadcastGoodsModel *model = [self parse:dic];
            [self showGood:model];
        }
        
    } failure:^(NSString *error) {
        @strongify(self);
            [XYNetworkAPI cancelAllRequest];
            [SVProgressHUD dismiss];
    } isHideTips:YES isCache:NO];
}

- (void) requestLog: (NSString*)ID {
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    if ([ID kr_isNotEmpty]) {
        params[@"id"] = ID;
    }
    @weakify(self);
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=liveStream&ctrl=user_msg" respondType:(ResponseTypeArray) modelType:@"FNLiveBroadcastLogModel" success:^(id respondsObject) {
        @strongify(self);
        NSArray *array = respondsObject;
        [self.logs addObjectsFromArray: array];
        
//        [self showLogs];
    } failure:^(NSString *error) {
        @strongify(self);
        [XYNetworkAPI cancelAllRequest];
        [SVProgressHUD dismiss];
    } isHideTips:YES isCache:NO];
}

- (FNRequestTool*) requestGoods {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"p": @(self.jm_page)}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=liveStream&ctrl=goods" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        [self.alertView.covGoods.mj_footer endRefreshing];
        NSArray* array = respondsObject;
        [SVProgressHUD dismiss];
        if (self.jm_page == 1) {
            [self.goods removeAllObjects];
        }
        if (array.count > 0) {
            self.jm_page++;
        }

        for (NSDictionary *dic in array) {
            FNBaseProductModel *model = [FNBaseProductModel mj_objectWithKeyValues:dic];
            model.data = dic;
            [self.goods addObject:model];
        }

        [self.alertView.covGoods reloadData];

    } failure:^(NSString *error) {
        [XYNetworkAPI cancelAllRequest];
        [SVProgressHUD dismiss];
    } isHideTips:YES isCache:NO];
}

- (FNRequestTool*) requestLike {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=liveStream&ctrl=addlike" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        
        
    } failure:^(NSString *error) {

        [XYNetworkAPI cancelAllRequest];
        [SVProgressHUD dismiss];
    } isHideTips:YES isCache:NO];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.alertView.loading.hidden = self.goods.count > 0;
    if (self.goods.count > 0) {
        [self.alertView.loading stopAnimating];
    } else {
        [self.alertView.loading startAnimating];
    }
    return self.goods.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FNBaseProductModel *model = self.goods[indexPath.row];
    FNHomeProductSingleRowCell *cell = [FNHomeProductSingleRowCell cellWithCollectionView:collectionView atIndexPath:indexPath];
    cell.model = model;
    cell.backgroundColor=[UIColor whiteColor];
    @weakify(self)
    cell.sharerightNow = ^(FNBaseProductModel *mod) {
        @strongify(self)
        [self shareProductWithModel:mod];
    };
    cell.clipsToBounds = YES;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(FNDeviceWidth,  140);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FNBaseProductModel *model = self.goods[indexPath.row];
    [self goProductVCWithModel:model withData:model.data isLive:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == self.broadcasts.count - 1) {
        //缩放
        cell.layer.transform = CATransform3DMakeScale(0.6, 0.6, 1);
        [UIView animateWithDuration:1 animations:^{
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
            
        }];
    }
}
    

#pragma mark - Web view delegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}
// 当内容开始到达时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSString *currentURL = webView.URL.absoluteString;
    if ([currentURL containsString:_api_showorder_WirteCache]) {
        NSLog(@"缓存写入成功");
        
        NSString *url = @"mod=appapi&act=liveStream&ctrl=html";
        NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        urlStr = [[NSMutableString stringWithString:IP] stringByAppendingFormat:@"%@",url];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                        [NSURL URLWithString: urlStr]];
        [self.webview loadRequest:request];
        
        return;
    }
    
    if ([currentURL containsString:@"mod=appapi&act=liveStream&ctrl=html"]) {
        self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webview];
        [self.bridge setWebViewDelegate:self];
        @weakify(self)
        [self.bridge registerHandler:@"WebViewJavascriptBridge" handler:^(id data, WVJBResponseCallback responseCallback) {
            @strongify(self)
            
            NSString *identifier = [data objectForKey:@"identifier"];
            if ([identifier isEqualToString:@"live_doing"]) {
                id content = [data objectForKey:@"comFrom"];
                NSLog(@"%@", content);
                FNLiveBroadcastGoodsModel *model = [self parse:content];
                
                [self showGood:model];
            }
        }];
    }
}

- (FNLiveBroadcastGoodsModel*) parse: (NSDictionary*)dict {
    FNLiveBroadcastGoodsModel *model = [FNLiveBroadcastGoodsModel mj_objectWithKeyValues: dict];
    if ([model.type isEqualToString:@"share_goods"]) {
        NSError *error = nil;
        id json = [NSJSONSerialization JSONObjectWithData:[model.data dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
        model.product = [FNBaseProductModel mj_objectWithKeyValues: json];
        model.product.data = json;
    }
    
    return model;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _broadcasts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FNLiveBroadcastGoodsModel *model = _broadcasts[indexPath.row];
    if ([model.type isEqualToString:@"msg"]) {
        
        FNLiveBroadcastGoodsTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNLiveBroadcastGoodsTextCell"];
        [cell.imgHeader sd_setImageWithURL:URL(model.head_img)];
        cell.lblContent.text = model.data;
        cell.delegate = self;
        return cell;
        
    } else if ([model.type isEqualToString:@"image"]) {
        FNLiveBroadcastGoodsImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNLiveBroadcastGoodsImageCell"];
        [cell.imgHeader sd_setImageWithURL:URL(model.head_img)];
        [cell setContentImage: model.image];
        cell.delegate = self;
        return cell;
        
    } else if ([model.type isEqualToString:@"share_goods"]) {
        FNLiveBroadcastGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNLiveBroadcastGoodsCell"];
        [cell.imgHeader sd_setImageWithURL:URL(model.head_img)];
        cell.lblTitle.text = model.product.goods_title;
        if([model.product.goods_title kr_isNotEmpty]){
            [cell.lblTitle HttpLabelLeftImage:model.product.shop_img label:cell.lblTitle imageX:0 imageY:-1.5 imageH:13 atIndex:0];
        }
        cell.lblDesc.text = model.product.goods_description;
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"券后价" attributes:@{NSFontAttributeName: kFONT13}];
        [string appendAttributedString: [[NSMutableAttributedString alloc] initWithString:model.product.goods_price attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18]}]];

        cell.lblPrice.attributedText = string;

        [cell.btnBuy sd_setBackgroundImageWithURL:URL(model.product.btn_img) forState:UIControlStateNormal];
        [cell.btnBuy setTitle:model.product.str forState:UIControlStateNormal];
        [cell.btnBuy setTitleColor:[UIColor colorWithHexString:model.product.str_color] forState:UIControlStateNormal];

        [cell.imgQuan1 sd_setImageWithURL:URL(model.product.goods_quanfont_bjimg)];
        [cell.imgQuan2 sd_setImageWithURL:URL(model.product.goods_quanbj_bjimg)];
        cell.lblQuan.text = model.product.yhq_span;
        cell.lblQuan.textColor = [UIColor colorWithHexString:model.product.goodsyhqstr_color];
        cell.delegate = self;
        return cell;
    }
    
    return [[UITableViewCell alloc] init];
}

#pragma mark - FNLiveBroadcastGoodsCellDelegate

- (void)didBuyClick:(FNLiveBroadcastGoodsCell *)cell {
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    FNLiveBroadcastGoodsModel *model = self.broadcasts[indexPath.row];
    
    [self goProductVCWithModel:model.product withData:model.product.data isLive:YES];
}

#pragma mark - FNLiveBroadcastGoodsTextCellDelegate

- (void)didLongPress:(FNLiveBroadcastGoodsTextCell *)cell {
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    FNLiveBroadcastGoodsModel *model = self.broadcasts[indexPath.row];
    [FNTipsView showTips:@"复制成功"];
    [[UIPasteboard generalPasteboard] setString:model.data];
}

#pragma mark - FNLiveBroadcastGoodsImageCellDelegate
- (void)onCell:(UITableViewCell *)cell imageClick:(UIImageView *)imageView {
    NSIndexPath *indexPath = [self.jm_tableview indexPathForCell:cell];
    FNLiveBroadcastGoodsModel *model = self.broadcasts[indexPath.row];
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
    // 弹出相册时显示的第一张图片是点击的图片
    browser.currentPhotoIndex = 0;
    NSMutableArray *photos = [NSMutableArray array];
    NSArray *imgs = @[model.data];
    [imgs enumerateObjectsUsingBlock:^(id  _Nonnull sobj, NSUInteger idx, BOOL * _Nonnull stop) {
        MJPhoto *mjPhoto = [[MJPhoto alloc] init];
        
        mjPhoto.url = [NSURL URLWithString:sobj];
        
        mjPhoto.srcImageView = imageView;
        
        [photos addObject:mjPhoto];
    }];
    
    // 设置所有的图片。photos是一个包含所有图片的数组。
    browser.photos = photos;
    [browser show];
}

@end
