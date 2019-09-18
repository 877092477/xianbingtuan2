//
//  FNDouQuanController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/10.
//  Copyright © 2019 方诺科技. All rights reserved.
// 看着买

#import "FNDouQuanController.h"
#import "FNCustomeNavigationBar.h"
#import "FNDouQuanVideoCell.h"
#import "JPVideoPlayer/JPVideoPlayerKit.h"
#import "FNDouQuanModel.h"
#import "FNDouQuanView.h"
#import "Lottie/Lottie.h"
#import "FNWebVideoManager.h"

@interface FNDouQuanController ()<UITableViewDelegate, UITableViewDataSource, JPTableViewPlayVideoDelegate, FNDouQuanViewDelegate>

@property (nonatomic, strong) FNCustomeNavigationBar *navigationView;
@property (nonatomic, strong) UIImageView *backBtn;
@property (nonatomic, strong) UILabel *titleBtn;
@property (nonatomic, strong) UIButton *muteBtn;

@property (nonatomic, strong) NSMutableArray<FNDouQuanModel*> *douQuans;
@property (nonatomic, strong) FNDouQuanView *douquanView;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) JPVideoPlayerProgressView *progressView;

@property (nonatomic, assign) BOOL isLoading;

@end

@implementation FNDouQuanController

- (FNDouQuanView*)douquanView {
    if (_douquanView == nil) {
        _douquanView = [[FNDouQuanView alloc] init];
        _douquanView.delegate = self;
    }
    return _douquanView;
}

- (FNCustomeNavigationBar *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
        
        UIButton* leftView = [UIButton new];
        self.backBtn = [[UIImageView alloc] init];
        self.backBtn.size = CGSizeMake(6, 12);
        [leftView addSubview:self.backBtn];
        
        self.titleBtn = [[UILabel alloc] init];
        self.titleBtn.size = CGSizeMake(XYScreenWidth - 120, 20);
        self.titleBtn.textColor = UIColor.whiteColor;
        [leftView addSubview:self.titleBtn];
        leftView.frame = CGRectMake(0, 0, self.backBtn.width+self.titleBtn.width+15, 20);
        [leftView addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.backBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.backBtn autoSetDimensionsToSize:self.backBtn.size];
        [self.backBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        
        [self.titleBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.titleBtn autoSetDimensionsToSize:self.titleBtn.size];
        [self.titleBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        
        _navigationView.leftButton = leftView;
        
        self.muteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [self.muteBtn setImage:IMAGE(@"douquan_button_voice_normal") forState:UIControlStateNormal];
        [self.muteBtn setImage:IMAGE(@"douquan_button_voice_selected") forState:UIControlStateSelected];
        _navigationView.rightButton = self.muteBtn;
        [self.muteBtn addTarget:self action:@selector(muteBtnAction)];
        
        self.muteBtn.selected = [[NSUserDefaults standardUserDefaults] boolForKey:XYVoiceMute];
        
        if ([self isEqual:self.navigationController.viewControllers.firstObject]) {
            _backBtn.hidden = YES;
            leftView.enabled = NO;
            _titleBtn.enabled = NO;
        }
        
        self.titleBtn.text = @"抖券";
        self.backBtn.image = IMAGE(@"connection_button_back");
        
    }
    return _navigationView;
}

- (BOOL)isFullScreenShow {
    return YES;
}

- (void)dealloc {
    if (self.jm_tableview.jp_playingVideoCell) {
        [self.jm_tableview.jp_playingVideoCell.jp_videoPlayView jp_stopPlay];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.jm_tableview jp_handleCellUnreachableTypeInVisibleCellsAfterReloadData];
    [self.jm_tableview jp_playVideoInVisibleCellsIfNeed];
    // 用来防止选中 cell push 到下个控制器时, scrollView 再次调用 scrollViewDidScroll 方法, 造成 playingVideoCell 被置空.
    self.jm_tableview.delegate = self;
    
    [self resume];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // 用来防止选中 cell push 到下个控制器时, scrollView 再次调用 scrollViewDidScroll 方法, 造成 playingVideoCell 被置空.
    self.jm_tableview.delegate = nil;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if (self.index < self.douQuans.count) {
        UITableViewCell *cell = [self.jm_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.index inSection:0]];
        if (cell) {
            [cell.jp_videoPlayView jp_pause];
        }
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect tableViewFrame = self.jm_tableview.frame;
//    tableViewFrame.size.height -= self.tabBarController.tabBar.bounds.size.height;
    self.jm_tableview.jp_tableViewVisibleFrame = tableViewFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _progressView = [[JPVideoPlayerProgressView alloc] init];
    _progressView.elapsedProgressView.progressTintColor = RGB(254, 60, 24);
    
    _douQuans = [[NSMutableArray alloc] init];
    self.jm_tableview = [[UITableView alloc] init];
    
    self.jm_tableview.delegate = self;
    self.jm_tableview.dataSource = self;
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    self.jm_tableview.pagingEnabled = YES;
    [self.jm_tableview registerClass:[FNDouQuanVideoCell class] forCellReuseIdentifier:@"FNDouQuanVideoCell"];
    
    self.jm_tableview.estimatedRowHeight = 0;
    self.jm_tableview.estimatedSectionHeaderHeight = 0;
    self.jm_tableview.estimatedSectionFooterHeight = 0;
    self.jm_tableview.backgroundColor = UIColor.blackColor;
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
    }
    
    self.jm_tableview.jp_delegate = self;
    self.jm_tableview.jp_scrollPlayStrategyType = JPScrollPlayStrategyTypeBestVideoView;
    
    [self.view addSubview:self.douquanView];
    [self.douquanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    UITapGestureRecognizer *doubleTabGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTabGesture setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTabGesture];
    
    [self.view addSubview:self.navigationView];
    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:self.navigationView.height];
    
    self.jm_page = 1;
    [SVProgressHUD show];
    [self requestMain];
}

- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)muteBtnAction {
    self.muteBtn.selected = !self.muteBtn.selected;
    
    [[NSUserDefaults standardUserDefaults] setBool:self.muteBtn.selected forKey:XYVoiceMute];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UITableViewCell *cell = [self.jm_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.index inSection:0]];
    if (cell) {
        [self tableView:self.jm_tableview willPlayVideoOnCell:cell];
    }
}

- (void)resume {
    if (self.index < self.douQuans.count) {
        UITableViewCell *cell = [self.jm_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.index inSection:0]];
        if (cell) {
            [cell.jp_videoPlayView jp_resume];
        }
    }
}


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _douQuans.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FNDouQuanVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNDouQuanVideoCell"];
    FNDouQuanModel *model = _douQuans[indexPath.row];
    cell.jp_videoURL = URL(model.video);
    [cell.videoPlayView sd_setImageWithURL:URL(model.goods_img)];
    cell.jp_videoPlayView = cell.videoPlayView;
    [tableView jp_handleCellUnreachableTypeForCell:cell
                                       atIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return XYScreenHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [cell.jp_videoPlayView jp_pause];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.progressView.hidden = YES;
}

/**
 * Called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
 * 松手时已经静止, 只会调用scrollViewDidEndDragging
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.jm_tableview jp_scrollViewDidEndDraggingWillDecelerate:decelerate];
}

/**
 * Called on tableView is static after finger up if the user dragged and tableView is scrolling.
 * 松手时还在运动, 先调用scrollViewDidEndDragging, 再调用scrollViewDidEndDecelerating
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.jm_tableview jp_scrollViewDidEndDecelerating];
    self.progressView.hidden = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.jm_tableview jp_scrollViewDidScroll];
    
    int page = scrollView.contentOffset.y / scrollView.frame.size.height;
    
    if (page >= self.douQuans.count - 2) {
        [self requestMain];
    }
    if (page >= 0 && page < self.douQuans.count) {
        self.index = page;
        [self.douquanView setModel:self.douQuans[page]];
    }
}


#pragma mark - JPTableViewPlayVideoDelegate
- (void)tableView:(UITableView *)tableView willPlayVideoOnCell:(UITableViewCell *)cell {
    if (self.muteBtn.isSelected) {
        [cell.jp_videoPlayView jp_resumeMutePlayWithURL:cell.jp_videoURL
                     bufferingIndicator:[[UIView alloc] init]
                           progressView:_progressView
                          configuration:nil];
    } else {
        [cell.jp_videoPlayView jp_resumePlayWithURL:cell.jp_videoURL
                 bufferingIndicator:[[UIView alloc] init]
                        controlView:[[UIView alloc] init]
                       progressView:_progressView
                      configuration:nil];
    }
}

#pragma mark - Networking
- (void) requestMain {
    
    if (_isLoading) {
        return;
    }
    
    _isLoading = YES;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, PageNumber: @(self.jm_page)}];
    @weakify(self);
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=shakeCouponGoods&ctrl=getGoods" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        
        self.isLoading = NO;
        NSArray* dicts = respondsObject[DataKey];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in dicts) {
            FNDouQuanModel *model = [FNDouQuanModel mj_objectWithKeyValues:dic];
            model.data = dic;
            [array addObject:model];
        }
        
        if (self.jm_page == 1) {
            [self.douQuans removeAllObjects];
            [self.douquanView setModel:array[0]];
        }
        if (array.count > 0)
            self.jm_page ++;
        
        [self.douQuans addObjectsFromArray:array];

        [self.jm_tableview reloadData];
        [self.jm_tableview jp_playVideoInVisibleCellsIfNeed];
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        self.isLoading = NO;
        [XYNetworkAPI cancelAllRequest];
        [SVProgressHUD dismiss];
    } isHideTips:YES isCache:NO];
}

#pragma mark - DownloadVideo

//videoPath为视频下载到本地之后的本地路径
- (void)saveVideo:(NSString *)videoPath{
    
    [FNTipsView showTips:@"视频下载开始"];
    if (videoPath) {
        [[FNWebVideoManager shareInstance] downloadWithUrl:URL(videoPath) completed:^(UIImage * _Nonnull coverImage, NSURL * _Nonnull fileUrl, NSError * _Nonnull error, BOOL finished) {
            BOOL compatible = UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(fileUrl.path);
            if (compatible)
            {
                //保存相册核心代码
                UISaveVideoAtPathToSavedPhotosAlbum(fileUrl.path, self, @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:), nil);
            }
        }];
    }
}


//保存视频完成之后的回调
- (void) savedPhotoImage:(UIImage*)image didFinishSavingWithError: (NSError *)error contextInfo: (void *)contextInfo {
    if (error) {
        NSLog(@"保存视频失败%@", error.localizedDescription);
        
        [FNTipsView showTips:@"视频保存失败"];
    }
    else {
        NSLog(@"保存视频成功");
        [FNTipsView showTips:@"视频保存成功"];
    }
}

#pragma mark - FNDouQuanViewDelegate

- (void)didProductClick {
    if (self.douQuans && self.index < self.douQuans.count) {
        FNDouQuanModel *model = self.douQuans[self.index];
        [self goProductVCWithModel:model withData:model.data];
    }
}
- (void)didCollectionClick {
    
}
- (void)didShareClick {
    if (self.douQuans && self.index < self.douQuans.count) {
        FNDouQuanModel *model = self.douQuans[self.index];
        [self shareProductWithModel:model];
    }
}
- (void)didDownloadClick {
    if (self.douQuans && self.index < self.douQuans.count) {
        FNDouQuanModel *model = self.douQuans[self.index];
        [self saveVideo: model.video];
        
    }
}

- (void)didSjzClick {
    [self loadMembershipUpgradeViewController];
}
- (void)didFxzClick {
    if (self.douQuans && self.index < self.douQuans.count) {
        FNDouQuanModel *model = self.douQuans[self.index];
        if([model.fnuo_id kr_isNotEmpty]){
            [self shareProductWithModel:model];
        }
    }
}

- (void)didDescClick {
    if (self.douQuans && self.index < self.douQuans.count) {
        FNDouQuanModel *model = self.douQuans[self.index];
        [self goProductVCWithModel:model withData:model.data];
    }
}

- (void)handleDoubleTap: (UITapGestureRecognizer*)tapRecognizer {
    
    [self.douquanView doLike];
    
    CGPoint touchPoint = [tapRecognizer locationInView: self.view];
    
    NSLog(@"%f %f", touchPoint.x, touchPoint.y);
    
    CGSize size = CGSizeMake(300, 300);
    
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"foever_love.json" ofType:nil];
    LOTAnimationView *collectionShowView = [[LOTAnimationView alloc] initWithModel:( [LOTComposition animationWithFilePath: dataPath]) inBundle:NSBundle.mainBundle];
    collectionShowView.frame = CGRectMake(touchPoint.x - size.width / 2, touchPoint.y - size.height, size.width, size.height);
    int ranAngle = arc4random() % 60 - 30;
    double rad = ranAngle / 180.0 * M_PI_2;
    collectionShowView.transform = CGAffineTransformMakeRotation(rad);
    [self.view addSubview:collectionShowView];
    [collectionShowView playWithCompletion:^(BOOL animationFinished) {
        [collectionShowView removeFromSuperview];
    }];
}

@end
