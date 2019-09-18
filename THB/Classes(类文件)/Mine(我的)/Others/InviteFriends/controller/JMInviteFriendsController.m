//
//  JMInviteFriendsController.m
//  THB
//
//  Created by jimmy on 2017/4/11.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMInviteFriendsController.h"
#import "JMInviteRuleController.h"

#import "JMInviteFriendAwardView.h"
#import "JMInviteRecordView.h"
#import "JMInvitedRankingView.h"
#import "JMInvitedSuccessTipsView.h"

//#import "JMHomeAPITool.h"
#import "FNAPIMine.h"
#import "JMInviteFriendModel.h"

#import "FNPosterController.h"

static const CGFloat _jm_invitedHeight = 34.0;
@interface JMInviteFriendsController ()
@property (nonatomic, weak) UIScrollView* mainView;
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, strong)UIView* inviteView;
@property (nonatomic, strong)UILabel* invitedLabel;
@property (nonatomic, strong) UIButton* guideBtn;
@property (nonatomic, strong)UILabel* awardLabel;
@property (nonatomic, strong) JMInviteFriendAwardView* awardView;
@property (nonatomic, strong) JMInviteRecordView* recordView;
@property (nonatomic, strong) JMInvitedRankingView* rankingView;
@property (nonatomic, strong) JMInvitedSuccessTipsView* tipView;
@property (nonatomic, weak) UIView* ruleView;
@property (nonatomic, weak) UILabel* ruleLabel;
@property (nonatomic, strong)JMInviteFriendModel* model;
@property (nonatomic, strong)NSMutableArray<JMInviteFriendRankingModel *>* ranks;

@property (nonatomic, strong) NSLayoutConstraint* imgHeightCons;
@property (nonatomic, strong) NSLayoutConstraint* awardViewHeightCons;
@property (nonatomic, strong) NSLayoutConstraint* recordViewHeightCons;
@property (nonatomic, strong) NSLayoutConstraint* rankingViewHeightCons;
@property (nonatomic, strong) NSLayoutConstraint* ruleViewHeightCons;

@property (nonatomic, copy)NSString* invitedText;
@property (nonatomic, strong)UIView* invitedTextView;
@property (nonatomic, strong)UILabel* invitedTextLabel;

@property (nonatomic, strong) UIButton* invitebtn;

@end

@implementation JMInviteFriendsController
- (JMInvitedRankingView *)rankingView{
    if (_rankingView == nil) {
        _rankingView = [[JMInvitedRankingView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth-_jm_leftMargin*2, 0))];
        @weakify(self);
        _rankingView.changeHeight = ^(CGFloat height) {
            @strongify(self);
            self.rankingViewHeightCons.constant = height;
            if (height == 0) {
                self.rankingView.hidden = YES;
            }else{
                self.rankingView.hidden = NO;
            }
        };
    }
    return _rankingView;
}
- (NSMutableArray<JMInviteFriendRankingModel *> *)ranks{
    if (_ranks == nil) {
        _ranks = [NSMutableArray new];
    }
    return _ranks;
}
- (void)setInvitedText:(NSString *)invitedText{
    _invitedText = invitedText;
    _invitedTextLabel.text = _invitedText;
    [_invitedTextView layoutIfNeeded];
    [self show];
}
- (UIButton *)guideBtn{
    if (_guideBtn == nil) {
        _guideBtn = [UIButton buttonWithTitle:[NSString stringWithFormat:@"%@ >", self.model.intvite_get_btn1] titleColor:FNWhiteColor font:kFONT13 target:self action:@selector(guideBtnAction)];
        [_guideBtn sizeToFit];
    }
    return _guideBtn;
}
- (UILabel *)invitedLabel{
    if (_invitedLabel == nil) {
        _invitedLabel = [UILabel new];
        _invitedLabel.font = [UIFont boldSystemFontOfSize:30];
        _invitedLabel.textColor = RGB(76, 77, 78);
        _invitedLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _invitedLabel;
}
- (UIView *)inviteView{
    if (_inviteView == nil) {
        _inviteView = [UIView new];
        
        UIImageView* bgimgview = [[UIImageView alloc]initWithImage:IMAGE(@"invite_my_bj")];
        CGFloat rate =IMAGE(@"invite_my_bj").size.height/IMAGE(@"invite_my_bj").size.width;
        bgimgview.userInteractionEnabled = YES;
        [_inviteView addSubview:bgimgview];
        [bgimgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, JMScreenWidth*0.1, 0, JMScreenWidth*0.1))excludingEdge:(ALEdgeTop)];
        [bgimgview autoSetDimension:(ALDimensionHeight) toSize:rate* (JMScreenWidth-JMScreenWidth*0.1*2)];
        _inviteView.height = rate*(JMScreenWidth-JMScreenWidth*0.1*2);
        
        UIView* bgview = [UIView new];
        [bgimgview addSubview:bgview];
        [bgview autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [bgview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [bgview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        
        UILabel* topLabel = [UILabel new];
        topLabel.text = @"我的专属邀请码";
        topLabel.font = kFONT14;
        topLabel.textAlignment = NSTextAlignmentCenter;
        [bgview addSubview:topLabel];
        [topLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, _jmsize_10, _jmsize_10, _jmsize_10)) excludingEdge:(ALEdgeBottom)];
        
        [bgview addSubview:self.invitedLabel];
        [self.invitedLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
        [self.invitedLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        [self.invitedLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:topLabel withOffset:_jmsize_10];
        
        _invitebtn = [UIButton buttonWithTitle:[NSString stringWithFormat:@"%@%@", self.model.intvite_get_btn, self.model.mon_str] titleColor:FNWhiteColor font:kFONT14 target:self action:@selector(umengShare)];
        _invitebtn.backgroundColor = RGB(250, 72, 84);
        [_invitebtn sizeToFit];
        _invitebtn.size = CGSizeMake(_invitebtn.width+_jmsize_10*4, 34);
        _invitebtn.cornerRadius = _invitebtn.height*0.5;
        [bgview addSubview:_invitebtn];
        [_invitebtn autoSetDimensionsToSize:_invitebtn.size];
        [_invitebtn autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
        [_invitebtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.invitedLabel withOffset:_jmsize_10];
        
        [bgview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_invitebtn];
    }
    return _inviteView;
}
-(UILabel *)awardLabel{
    if (_awardLabel == nil) {
        _awardLabel = [UILabel new];
        _awardLabel.font = kFONT16;
        _awardLabel.textAlignment = NSTextAlignmentCenter;
//        _awardLabel.textColor = FNWhiteColor;
    }
    return _awardLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [SVProgressHUD show];
    [self apiRequestModel];
    [self setUpInvitedView];

    [self apiRequestInviteTest];
    
}
- (void)viewDidUnload{
    [super viewDidUnload];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -  api request
- (void)apiRequestModel{
    @weakify(self);
    [FNRequestTool startWithRequests:@[[self requestPage],[self requestRank]] withFinishedBlock:^(NSArray *erros) {
        @strongify(self);
        [SVProgressHUD dismiss];
        self.model.phb = self.ranks;
        [self initializedSubviews];
    }];
}
- (FNRequestTool *)requestPage{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=yqhy&ctrl=yqFriend" respondType:(ResponseTypeModel) modelType:@"JMInviteFriendModel" success:^(id respondsObject) {
        //
        self.model = respondsObject;
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
}
- (FNRequestTool *)requestRank{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"p":@(self.jm_page)}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=yqhy&ctrl=phb" respondType:(ResponseTypeArray) modelType:@"JMInviteFriendRankingModel" success:^(NSArray* respondsObject) {
        //
        if (self.jm_page == 1) {
            [self.ranks removeAllObjects];
            [self.ranks addObjectsFromArray:respondsObject];
            if (respondsObject.count>=_jm_pageszie) {
                //
                self.rankingView.listTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.jm_page ++;
                    [self requestRank];
                }];
            }else{
                self.rankingView.listTableView.mj_footer = nil;
            }
        }else{
            [self.ranks addObjectsFromArray:respondsObject];
            if (respondsObject.count>=_jm_pageszie) {
                //
                [self.rankingView.listTableView.mj_footer endRefreshing];
            }else{
                [self.rankingView.listTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
    } failure:^(NSString *error) {
        //
        [self.rankingView.listTableView.mj_footer endRefreshing];
    } isHideTips:YES];
}
- (void)apiRequestInviteTest{
  
    @WeakObj(self);
    [FNAPIMine apiMineRequestInvitedTestWithParams:nil success:^(id respondsObject) {
        NSString *other = respondsObject;
        if (other.length != 0) {
            selfWeak.invitedText = respondsObject;
        }else{
            if (selfWeak.invitedText.length != 0) {
                [selfWeak show];
            }
            
        }

    } failure:^(NSString *error) {
        
    } isHidden:YES];
    __weak typeof(self) weakSelf = self;
    double delayInSeconds = 5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf apiRequestInviteTest];
    });

}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    self.title = self.title?self.title:@"邀请好友";
    UIScrollView * mainView = [[UIScrollView alloc]init];
//    mainView.backgroundColor = FNColor(254, 215, 86);
    [self.view insertSubview:mainView atIndex:0];
    _mainView = mainView;
    
    
    [_mainView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
    UIImageView *imgBg = [[UIImageView alloc] init];
    [_mainView addSubview:imgBg];
//    [imgBg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(@0);
//    }];
    imgBg.contentMode = UIViewContentModeScaleAspectFill;
    [imgBg sd_setImageWithURL:URL(self.model.next_invite_bj)];
    
    @WeakObj(self);
    // header image view
    _imageView = [[UIImageView alloc]initWithFrame:(CGRectZero)];
    _imageView.userInteractionEnabled = YES;
    [_mainView addSubview:_imageView];
    [_mainView addSubview:self.inviteView];
    
    if ([IP isEqualToString:@"http://123.szs6868.com/?"]) {
        [self.inviteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.height.mas_equalTo(self.inviteView.height);
            make.top.equalTo(self.imageView.mas_bottom);
        }];
    } else {
//        [self.inviteView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeTop)];
//        [self.inviteView autoSetDimension:(ALDimensionHeight) toSize:self.inviteView.height];
        [self.inviteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.height.mas_equalTo(self.inviteView.height);
            make.bottom.equalTo(self.imageView.mas_bottom);
        }];
    }
    
    
    [imgBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.inviteView.mas_bottom);
        make.height.mas_equalTo(@0);
    }];
    
    self.invitedLabel.text = self.model.tgid;
    
//    [self.guideBtn setTitle:[NSString stringWithFormat: @"%@ >", self.model.intvite_get_btn1] forState:UIControlStateNormal];
    
    [_imageView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
    [_imageView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [_imageView autoSetDimension:(ALDimensionWidth) toSize:FNDeviceWidth];
    _imgHeightCons = [_imageView autoSetDimension:(ALDimensionHeight) toSize:0];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:self.model.invite_bj] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            selfWeak.imgHeightCons.constant = image.size.height*FNDeviceWidth/image.size.width;
            [selfWeak.mainView layoutIfNeeded];
        }
        
    }];
    [_imageView addSubview:self.guideBtn];
    [self.guideBtn autoSetDimensionsToSize:self.guideBtn.size];
    [self.guideBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
    [self.guideBtn autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:_jmsize_10];
    
    self.awardLabel.text = self.model.str4;
    [_mainView addSubview:self.awardLabel];
    [self.awardLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
    [self.awardLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
    [self.awardLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_inviteView withOffset:_jmsize_10*2];
    [self.awardLabel autoSetDimension:(ALDimensionWidth) toSize:JMScreenWidth-20];
    if( [self.awardLabel.text kr_isNotEmpty]){
        NSMutableAttributedString* mstring = [[NSMutableAttributedString alloc]initWithString:self.awardLabel.text];
        if ([self.awardLabel.text containsString:self.model.xr_hb]) {
            [mstring addAttribute:NSForegroundColorAttributeName value:FNMainGobalControlsColor range:[self.awardLabel.text rangeOfString:self.model.xr_hb]];
        }
        NSTextAttachment* attchment = [NSTextAttachment new];
        attchment.image = IMAGE(@"invite_coin");
        CGRect rect = CGRectMake(0, -3, 15, 15);
        attchment.bounds = rect;
        NSAttributedString *att = [NSAttributedString attributedStringWithAttachment:attchment];
        [mstring insertAttributedString:att atIndex:0];
        self.awardLabel.attributedText = mstring;
    } 
    
    //record view
    _recordView = [[JMInviteRecordView alloc] initWithFrame:(CGRectMake(0, 0, FNDeviceWidth-_jm_leftMargin*2, 0))];
    _recordView.model = self.model;
    [_mainView addSubview:_recordView];
    
    [_recordView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_leftMargin];
    [_recordView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.awardLabel withOffset:15];
    [_recordView autoSetDimension:(ALDimensionWidth) toSize:FNDeviceWidth-_jm_leftMargin*2];
    self.recordViewHeightCons = [_recordView autoSetDimension:(ALDimensionHeight) toSize:_recordView.viewHeight];
    
    //ranking view
    
    self.rankingView.model = self.model;
    [_mainView addSubview:_rankingView];
    
    [_rankingView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_leftMargin];
    [_rankingView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_recordView withOffset:_jm_leftMargin];
    [_rankingView autoSetDimension:(ALDimensionWidth) toSize:FNDeviceWidth-_jm_leftMargin*2];
    [_rankingView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_mainView withOffset:_jmsize_10];
    self.rankingViewHeightCons = [_rankingView autoSetDimension:(ALDimensionHeight) toSize:_rankingView.viewHeight];
    
    [self.mainView layoutIfNeeded];
    
    CGFloat height = _imgHeightCons.constant+_awardViewHeightCons.constant + _recordViewHeightCons.constant + _rankingViewHeightCons.constant +_jm_leftMargin*3 + 100;
//    if (height > self.view.height) {
//        self.mainView.contentSize = CGSizeMake(FNDeviceWidth, height);
//    }
//    imgBg.frame = CGRectMake(0, 0, FNDeviceWidth, self.view.height);
    [imgBg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];


    //tips view
    _tipView  = [[JMInvitedSuccessTipsView alloc] initWithFrame:(CGRectMake(-FNDeviceWidth, 10, FNDeviceWidth, 40))];
    _tipView.hidden = YES;
    [self.view addSubview:_tipView];
    
    //rule
    UIView* ruleView = [UIView new];
//    ruleView.backgroundColor = FNGlobalTextGrayColor;
    [self.mainView addSubview:ruleView];
    _ruleView = ruleView;
    
    UILabel* titleLabel = [UILabel new];
    titleLabel.font = [UIFont boldSystemFontOfSize:25];
    titleLabel.text=  @"活动规则";
    titleLabel.textColor = FNWhiteColor;
    [self.ruleView addSubview:titleLabel];
    
    UILabel* ruleLabel = [UILabel new];
    ruleLabel.textColor = FNWhiteColor;
    ruleLabel.text=  self.model.yqrule;
    ruleLabel.font = kFONT14;
    ruleLabel.numberOfLines = 0;
    [self.ruleView addSubview:ruleLabel];
    
    [_ruleView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_leftMargin];
    [_ruleView autoSetDimension:(ALDimensionWidth) toSize:FNDeviceWidth-_jm_leftMargin*2];
    [_ruleView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_rankingView withOffset:_jm_leftMargin];
    
    [titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
    [titleLabel autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    
    [ruleLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:titleLabel withOffset:_jm_margin10];
    [ruleLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [ruleLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];

    [_ruleView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:ruleLabel withOffset:_jm_leftMargin];
    [_ruleView layoutIfNeeded];
    if ([NSString isEmpty:self.model.yqrule]) {
        self.ruleView.hidden = YES;
    }else{
        self.ruleView.hidden = NO;
    }
    [self.mainView layoutIfNeeded];

    
}
- (void)setUpInvitedView{
    _invitedTextView = [UIView new];
    _invitedTextView.cornerRadius = _jm_invitedHeight*0.5;
    _invitedTextView.backgroundColor = [UIColor clearColor];
    _invitedTextView.hidden = YES;
    [self.view addSubview:_invitedTextView];
    
    [_invitedTextView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:_jm_leftMargin];
    [_invitedTextView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_leftMargin];
    [_invitedTextView autoSetDimension:(ALDimensionHeight) toSize:_jm_invitedHeight];
    [_invitedTextView autoSetDimension:(ALDimensionWidth) toSize:FNDeviceWidth-_jm_leftMargin*2];
    
    UIImageView* imgView = [UIImageView new];
    imgView.image = IMAGE(@"invite_people_head");
    imgView.cornerRadius = _jm_invitedHeight *0.5;
    [_invitedTextView addSubview:imgView];
    
    [imgView autoSetDimensionsToSize:(CGSizeMake(_jm_invitedHeight, _jm_invitedHeight))];
    [imgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [imgView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    _invitedTextLabel = [UILabel new];
    _invitedTextLabel.font = kFONT14;
    _invitedTextLabel.textColor  =FNWhiteColor;
    [_invitedTextView addSubview:_invitedTextLabel];
    [_invitedTextLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:imgView withOffset:_jm_margin10];
    [_invitedTextLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_invitedTextLabel autoSetDimension:(ALDimensionWidth) toSize:FNDeviceWidth-(_jm_invitedHeight*1.5+10+_jm_leftMargin) relation:(NSLayoutRelationLessThanOrEqual)] ;
    
    UIView* bgview = [UIView new];
    bgview.cornerRadius = _jm_invitedHeight*0.5;
    bgview.backgroundColor = [FNBlackColor colorWithAlphaComponent:0.4];
    [_invitedTextView insertSubview:bgview atIndex:0];
    
    [bgview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [bgview autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
    [bgview autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];
    [bgview autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:_invitedTextLabel withOffset:_jm_invitedHeight*0.5];
    
    
}
#pragma mark - show or hide invited view
-(void)show{
    _invitedTextView.x = -FNDeviceWidth;
    _invitedTextView.hidden = NO;
    @WeakObj(self);
    [UIView animateWithDuration:IMGDuration animations:^{
        selfWeak.invitedTextView.x =  _jm_leftMargin;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:IMGDuration delay:3.0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            selfWeak.invitedTextView.x = -FNDeviceWidth;
        } completion:^(BOOL finished) {
            selfWeak.invitedTextView.hidden = YES;
        }];
    }];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//    CGFloat height = _imgHeightCons.constant+_awardViewHeightCons.constant + _recordViewHeightCons.constant + _rankingViewHeightCons.constant +_jm_leftMargin*4 + _ruleView.height;
//
//    if (height > self.view.height) {
//        self.mainView.contentSize = CGSizeMake(FNDeviceWidth, height);
//    }

}
#pragma mark - action
-(void)inviteButtonAction{
    //邀请好友
}
-(void)receivedRecordBtnAction{
    
}
-(void)umengShare{
    //只有《达人优惠》点击时需要跳转到海报
    //用IP判断防止应用改名，改包名导致失效
    if ([IP isEqualToString:@"http://123.szs6868.com/?"]) {
        FNPosterController *vc = [[FNPosterController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        if (self.model.invite_model_onoff.integerValue==0) {
            NSString *shareText = self.model.ml_shareInfo_two;             //分享内嵌文字
            NSString *shareUrl = [NSString encodeToPercentEscapeString:self.model.tgurl];
            [self umengShareWithURL:shareUrl image:self.model.shareImg shareTitle:self.model.shareInfo andInfo:shareText];
        }else{
            [self umengShareWithURL:nil image:self.model.hc_img shareTitle:nil andInfo:nil];
        }
    }
}
- (void)guideBtnAction{
    [self goWebWithUrl:self.model.zq_url];
}
@end
