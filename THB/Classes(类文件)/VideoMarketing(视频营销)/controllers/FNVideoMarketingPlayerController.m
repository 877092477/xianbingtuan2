//
//  FNVideoMarketingPlayerController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/1.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNVideoMarketingPlayerController.h"
#import "JPVideoPlayer/JPVideoPlayerKit.h"
#import "FNVideoModel.h"

@interface FNVideoMarketingPlayerController ()

@property (nonatomic, strong) FNVideoModel *detailModel;

@property (nonatomic, strong) JPVideoPlayerControlView *playerView;
@property (nonatomic, strong) UIView *vPlayer;

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblSorce;
@property (nonatomic, strong) UIImageView *imgHot;
@property (nonatomic, strong) UILabel *lblHot;
@property (nonatomic, strong) UILabel *lblDesc;

@property (nonatomic, strong) UIView *vLine;
@property (nonatomic, strong) UILabel *lblLineTitle;
@property (nonatomic, strong) NSMutableArray<UIButton*> *lineButtons;

@end

@implementation FNVideoMarketingPlayerController

#define Column 4

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _model.name;
    _lineButtons = [[NSMutableArray alloc] init];
    [self configUI];
    [self apiRequestMovie];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self play];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopPlaying];
}

- (void)configUI {
    self.view.backgroundColor = UIColor.whiteColor;
    
    _playerView = [[JPVideoPlayerControlView alloc] initWithControlBar:nil blurImage:nil];
    _vPlayer = [[UIView alloc] init];
    [self.view addSubview: _vPlayer];
    _vPlayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width * 9 / 16 );
    _vPlayer.backgroundColor = UIColor.blackColor;
    [_vPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@0);
        make.width.mas_equalTo(XYScreenWidth);
        make.height.mas_equalTo(XYScreenWidth * 9 / 16);
    }];
    
    
    _lblTitle = [[UILabel alloc] init];
    _lblSorce = [[UILabel alloc] init];
    _imgHot = [[UIImageView alloc] init];
    _lblHot = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _vLine = [[UIView alloc] init];
    _lblLineTitle = [[UILabel alloc] init];
    
    [self.view addSubview:_lblTitle];
    [self.view addSubview:_lblSorce];
    [self.view addSubview:_imgHot];
    [self.view addSubview:_lblHot];
    [self.view addSubview:_lblDesc];
    [self.view addSubview:_vLine];
    [_vLine addSubview:_lblLineTitle];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.equalTo(self.vPlayer.mas_bottom).offset(12);
    }];
    [_lblSorce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblTitle.mas_right).offset(10);
        make.bottom.equalTo(self.lblTitle);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [_imgHot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(12);
        make.width.height.mas_equalTo(12);
    }];
    [_lblHot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHot.mas_right).offset(10);
        make.right.lessThanOrEqualTo(@-30);
        make.centerY.equalTo(self.imgHot);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHot.mas_right).offset(10);
        make.top.equalTo(self.imgHot.mas_bottom).offset(10);
        make.right.lessThanOrEqualTo(@-30);
    }];
    
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.lblDesc.mas_bottom).offset(26);
        make.bottom.lessThanOrEqualTo(@-20);
    }];
    
    [_lblLineTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.equalTo(@0);
        make.right.lessThanOrEqualTo(@-30);
    }];
    
    
    _lblTitle.font = [UIFont systemFontOfSize:18];
    _lblTitle.textColor = RGB(51, 51, 51);
    
    _lblSorce.font = [UIFont systemFontOfSize:18];
    _lblSorce.textColor = RGB(250, 77, 57);
    
    _imgHot.contentMode = UIViewContentModeScaleAspectFit;
    
    _lblHot.textColor = RGB(153, 153, 153);
    _lblHot.font = [UIFont systemFontOfSize:14];
    
    _lblDesc.textColor = RGB(153, 153, 153);
    _lblDesc.font = [UIFont systemFontOfSize:12];
    _lblDesc.numberOfLines = 0;
    
    _lblLineTitle.textColor = RGB(51, 51, 51);
    _lblLineTitle.font = [UIFont systemFontOfSize:15];
    _lblLineTitle.text = @"线路";
    
    _vLine.hidden = YES;
}

- (void)play {
    if (self.model && [self.model.old_url kr_isNotEmpty]) {
        [self.vPlayer jp_playVideoWithURL:URL(self.model.movie_url) bufferingIndicator:nil controlView:nil progressView:nil configuration:nil];
    }
}

- (void)stopPlaying {
    [self.vPlayer jp_stopPlay];
}

- (void)pausePlaying {
    [self.vPlayer jp_pause];
}

- (void)configLines {
    for (UIButton *btn in self.lineButtons) {
        [btn removeFromSuperview];
    }
    [self.lineButtons removeAllObjects];
    
    _vLine.hidden = self.detailModel.list.count <= 0;
    for (NSInteger index = 0; index < self.detailModel.list.count; index ++) {
        FNVideoLineModel *line = self.detailModel.list[index];
        
        UIButton *button = [[UIButton alloc] init];
        [self.vLine addSubview:button];
        [self.lineButtons addObject:button];
        
        [button setTitle:line.str forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor colorWithHexString:line.color] forState:UIControlStateNormal];
        [button sd_setBackgroundImageWithURL:URL(line.check_img) forState:(UIControlStateSelected)];
        [button sd_setBackgroundImageWithURL:URL(line.img) forState:(UIControlStateNormal)];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        NSInteger column = index % Column;
        NSInteger row = index / Column;
        
        CGFloat padding = 6;
        CGFloat width = ((XYScreenWidth - 32) - (Column - 1) * padding) / Column;
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (column == 0) {
                make.left.equalTo(@12);
            } else {
                make.left.equalTo(self.lineButtons[index - 1].mas_right).offset(padding);
            }
            
            make.width.mas_equalTo(width);
            
            if (row == 0) {
                make.top.equalTo(@30);
            } else {
                make.top.equalTo(self.lineButtons[index - Column].mas_bottom).offset(padding);
            }
            
            if (column == Column - 1) {
                make.right.equalTo(@-20);
            }
            make.height.mas_equalTo(40);
        }];
        
    }
}

- (void)onLineButtonClick: (UIGestureRecognizer*) recognizer {
    UIButton *button = (UIButton*)recognizer.view;
    NSInteger index = [self.lineButtons indexOfObject:button];
    // 切换路线
    
    for (UIButton *btn in self.lineButtons) {
        btn.selected = [btn isEqual:button];
    }
}

- (FNRequestTool *)apiRequestMovie{
    @weakify(self)
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes], @"id": _model.ID}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=app_movie&ctrl=movie_detail" respondType:(ResponseTypeModel) modelType:@"FNVideoModel" success:^(id respondsObject) {
        @strongify(self)
        self.detailModel = respondsObject;
        
        self.title = self.detailModel.name;
        self.lblTitle.text = self.detailModel.name;
        self.lblSorce.text = self.detailModel.score_str;
        [self.imgHot sd_setImageWithURL:URL(self.detailModel.hot_img)];
        self.lblHot.text = self.detailModel.hot_str;
        self.lblDesc.text = self.detailModel.info;
        
        [self configLines];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}


@end
