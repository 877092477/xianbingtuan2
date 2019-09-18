//
//  FNConnectionsChatController.m
//  THB
//
//  Created by Weller Zhao on 2019/1/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//
#import <IQKeyboardManager/IQKeyboardManager.h>

#import "FNConnectionsChatController.h"
#import "TZImagePickerController/TZImagePickerController.h"

#import "FNConnectionsChatTextCell.h"
#import "FNConnectionsChatImageCell.h"
#import "FNConnectionsChatRedPackCell.h"
#import "FNConnectionsChatReceiveCell.h"
#import "FNConnectionsChatVoiceCell.h"
#import "FNConnectionsChatTimeHeader.h"
#import "FNChatInputView.h"
#import "FNEmojiInputView.h"
#import "FNChatIconView.h"
#import "FNConnectionsChatGoodsDeCell.h"

#import "FNneckRedPacketNaController.h"
#import "FNhairContactsDeController.h"
#import "FNSomeTimeTeController.h"
#import "FNNewProDetailController.h"
#import "FNdrawRedPacketNaView.h"
#import "FNredPacketExpireView.h"
#import "FNopenRedPacketDeModel.h"
#import "FNChatManager.h"
#import "FNChatModel.h"

#import "FNWebVideoManager.h"
#import "FNWebVoiceManager.h"
#import "FNVideoPlayerController.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "FNAudioAlertView.h"
#import "FNAudioRecordManager.h"
#import "FNCustomeNavigationBar.h"
#import "FNChatIconModel.h"
#import "JCVideoRecordView.h"
#import "Popover.OC/PopoverAction.h"
#import "Popover.OC/PopoverView.h"
#import "FNConnectionsCreateGroupsController.h"
#import "FNConnectionsSettingController.h"
#import "FNConnectionRemarkController.h"

@interface FNConnectionsChatController() <UITableViewDelegate, UITableViewDataSource, FNChatInputViewDelegate, UIGestureRecognizerDelegate, FNEmojiInputViewDelegate, FNChatIconViewDelegate, TZImagePickerControllerDelegate,FNneckRedPacketNaControllerDelegate,FNSomeTimeTeControllerDelegate, FNConnectionsChatCellDelegate, FNhairContactsDeControllerDelegate, FNConnectionRemarkControllerDelegate>


@property (nonatomic, strong) NSMutableArray<FNChatModel*>* chats;

@property (nonatomic, strong) UITableView *tbvChat;

@property (nonatomic, strong) FNChatInputView *vInput;

@property (nonatomic, strong) FNChatIconView *iconsView;
@property (nonatomic, assign) BOOL isIconShow;

@property (nonatomic, strong) FNAudioAlertView *audioAlert;
@property (nonatomic, assign) BOOL isCancle;

@property(nonatomic,strong)FNCustomeNavigationBar *topNaivgationbar;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *moreBtn;

@property (nonatomic, strong) NSMutableArray<FNChatIconModel*> *icons;
@property (nonatomic, strong) JCVideoRecordView *recordView;

@property (nonatomic, strong) NSArray<FNChatSettingModel*> *settings;
@property (nonatomic, strong) NSIndexPath *playingVoiceIndex;

@end

@implementation FNConnectionsChatController

#define IconHeight 250
#define PageNum 30

- (FNAudioAlertView*) audioAlert {
    if (_audioAlert == nil) {
        _audioAlert = [[FNAudioAlertView alloc] init];
        [self.view addSubview:_audioAlert];
        [_audioAlert mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        _audioAlert.hidden = YES;
    }
    return _audioAlert;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _isIconShow = NO;
    _chats = [[NSMutableArray alloc] init];
    _icons = [[NSMutableArray alloc] init];
    [self setTopNavBar];
    [self configUI];
    [self requestIconButtons];
    [self requestSetting];
    
    FNChatModel *top = [FNChatManager.shareInstance searchTopChat:_room];
    @weakify(self)
    [FNChatManager.shareInstance getOfflineMessageFromRoom:_room byTarget:_target afterID:top.ID withBlock:^(NSArray<FNChatModel *> * _Nonnull chats) {
        [self_weak_ loadMore];
    }];
    
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [FNNotificationCenter addObserver:self
                             selector:@selector(newMessage:)
                                 name:@"onNewChatMessage"
                               object:nil];
//    self.title=self.nickname;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self requestCleanUnread];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
    [FNWebVoiceManager.shareInstance stop];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

#pragma mark - 导航栏view
-(void)setTopNavBar{
    
    UIView *topView=[[UIView alloc]init];
    topView.frame=CGRectMake(0, 0, FNDeviceWidth, SafeAreaTopHeight);
    //self.topImg=[[UIImageView alloc]init];
    //[topView addSubview:self.topImg];
    self.topNaivgationbar = [FNCustomeNavigationBar customeNavigationBarWithCustomeView:topView];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,FNDeviceWidth,SafeAreaTopHeight);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:177/255.0 green:101/255.0 blue:251/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:255/255.0 green:59/255.0 blue:153/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0)];
    
    [self.topNaivgationbar.layer addSublayer:gl];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn setImage:[UIImage imageNamed:@"return-white"] forState:UIControlStateNormal];
    [self.leftBtn setTitle:self.nickname forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font=kFONT17;
    [self.leftBtn sizeToFit];
    self.leftBtn.size = CGSizeMake(self.leftBtn.width+10, 30);
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.leftBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10.0f];
    
    self.topNaivgationbar.leftButton = self.leftBtn;
    
    self.moreBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.moreBtn setImage: IMAGE(@"connections_chat_more") forState: UIControlStateNormal];
    [self.moreBtn sizeToFit];
//    self.moreBtn.size = CGSizeMake(self.moreBtn.width+10, 30);
    [self.moreBtn addTarget:self action:@selector(moreBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.moreBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10.0f];
//    self.moreBtn.hidden = YES;
    
    self.topNaivgationbar.rightButton = self.moreBtn;
    
    [self.view addSubview:_topNaivgationbar];
    self.topNaivgationbar.backgroundColor =[UIColor whiteColor];
    
}

- (void)configUI {
    self.tbvChat = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tbvChat];
    
    self.tbvChat.delegate = self;
    self.tbvChat.dataSource = self;
    self.tbvChat.rowHeight = UITableViewAutomaticDimension;
    self.tbvChat.estimatedRowHeight = 200;
    self.tbvChat.estimatedSectionFooterHeight = 0;
    self.tbvChat.estimatedSectionHeaderHeight = 0;
    self.tbvChat.backgroundColor = FNHomeBackgroundColor;
    self.tbvChat.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tbvChat registerClass:[FNConnectionsChatGoodsDeCell class] forCellReuseIdentifier:@"FNConnectionsChatGoodsDeCell"];
    
    [self.tbvChat registerClass:[FNConnectionsChatTextCell class] forCellReuseIdentifier:@"FNConnectionsChatTextCell"];
    [self.tbvChat registerClass:[FNConnectionsChatImageCell class] forCellReuseIdentifier:@"FNConnectionsChatImageCell"];
    [self.tbvChat registerClass:[FNConnectionsChatRedPackCell class] forCellReuseIdentifier:@"FNConnectionsChatRedPackCell"];
    [self.tbvChat registerClass:[FNConnectionsChatReceiveCell class] forCellReuseIdentifier:@"FNConnectionsChatReceiveCell"];
    [self.tbvChat registerClass:[FNConnectionsChatVoiceCell class] forCellReuseIdentifier:@"FNConnectionsChatVoiceCell"];
    
    [self.tbvChat registerClass:[FNConnectionsChatTimeHeader class] forHeaderFooterViewReuseIdentifier:@"FNConnectionsChatTimeHeader"];
    if (@available(iOS 11.0, *)) {
        self.tbvChat.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    @weakify(self)
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self_weak_ loadMore];
        [self_weak_.tbvChat.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tbvChat.mj_header = header;
    
    _vInput = [[FNChatInputView alloc] init];
    _vInput.delegate = self;
    [self.view addSubview:_vInput];
    
    [self.tbvChat mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(@0);
        make.top.equalTo(self_weak_.topNaivgationbar.mas_bottom);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(self_weak_.vInput.mas_top);
    }];
    
    [_vInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0).offset(isIphoneX ? -34 : 0);
    }];

    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard)];
    recognizer.delegate = self;
    [self.tbvChat addGestureRecognizer:recognizer];

    
    
    _iconsView = [[FNChatIconView alloc] init];
    [self.view addSubview:_iconsView];
    [_iconsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0).offset(0);
        make.height.mas_equalTo(0);
    }];
    
    _iconsView.delegate = self;
}

- (void)loadMore {
    BOOL isFirst = YES;
    if ([_uid kr_isNotEmpty]) {
        NSString *condition = [NSString stringWithFormat:@"(sendee_uid = %@ or send_uid = %@) and target = '%@'", _uid, _uid, _target];
        if (_chats.count > 0) {
            isFirst = NO;
            NSInteger rowid = _chats.lastObject.rowid;
            condition = [NSString stringWithFormat:@"(sendee_uid = %@ or send_uid = %@) and rowid < %ld and target = '%@'", _uid, _uid, rowid, _target];
        }
        NSMutableArray* array = [FNChatModel searchWithWhere:condition orderBy:@"rowid DESC" offset:0 count:PageNum];
        [_chats addObjectsFromArray:array];
        [_tbvChat reloadData];
        for (NSInteger index = _chats.count - array.count; index < _chats.count; index ++) {
            FNChatModel *chat = _chats[index];
            @weakify(self)
            if ([chat.type isEqualToString:@"image"] && (chat.size.width == 0 || chat.size.height == 0)) {
                [[SDWebImageManager sharedManager] downloadImageWithURL:URL(chat.data) options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    chat.size = image.size;
                    chat.coverImage = image;
                    [FNChatModel updateToDB:chat where:nil];
                    [self_weak_.tbvChat reloadData];
                }];
            } else if ([chat.type isEqualToString:@"video"] && (chat.size.width == 0 || chat.size.height == 0)) {
                [[FNWebVideoManager shareInstance] downloadWithUrl:URL(chat.data) completed:^(UIImage * _Nonnull coverImage, NSURL * _Nonnull fileUrl, NSError * _Nonnull error, BOOL finished) {
                    chat.size = coverImage.size;
                    chat.coverImage = coverImage;
                    [FNChatModel updateToDB:chat where:nil];
                    [self_weak_.tbvChat reloadData];
                }];
            } else if ([chat.type isEqualToString:@"audio"] && chat.length == 0) {
                [[FNWebVoiceManager shareInstance] downloadWithUrl:URL(chat.data) completed:^(float length, NSURL * _Nonnull fileUrl, NSError * _Nonnull error, BOOL finished) {
                    chat.length = length;
                    [FNChatModel updateToDB:chat where:nil];
                    [self_weak_.tbvChat reloadData];
                }];
            }
        }
        
        if (isFirst) {
            [self scrollViewToBottom:NO];
        } else if (_chats.count > PageNum) {
            [_tbvChat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:array.count inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
//        return YES;
//    }
//    return NO;
//}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // 首先判断otherGestureRecognizer是不是系统pop手势
    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
        // 再判断系统手势的state是began还是fail，同时判断scrollView的位置是不是正好在最左边
        if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan) {
            return YES;
        }
    }
    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    return NO;
}


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _chats.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //倒序显示
    NSInteger index = _chats.count - indexPath.row - 1;
    FNChatModel *chat = _chats[index];
    int status = chat.status;
    if ([chat.return_str kr_isNotEmpty]) {
        double time = chat.return_str.doubleValue;
        double second = time - [NSString GetNowMillisecond].doubleValue;
        if (status == 1 && second < -ChatOverTime * 1000) {
            status = 2;
        }
    }
    if ([chat.type isEqualToString:@"share_goods"]) {
        FNConnectionsChatGoodsDeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNConnectionsChatGoodsDeCell"];
        [cell setwithHeader:chat.head_img
                     isLeft:[chat.lr isEqualToString:@"l"]
                 withStatus:status];
        cell.model=[FNChatGoodsModel mj_objectWithKeyValues: chat.data];
        cell.delegate = self;
        return cell;
    } else if ([chat.type isEqualToString:@"image"]) {
        FNConnectionsChatImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNConnectionsChatImageCell"];
        [cell setImage:chat.coverImage
                  size:chat.size
            withHeader:chat.head_img
                isLeft:[chat.lr isEqualToString:@"l"]
            withStatus:status
               isVideo:NO];
        cell.delegate = self;
        return cell;
    } else if ([chat.type isEqualToString:@"msg"]) {
        FNConnectionsChatTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNConnectionsChatTextCell"];
        [cell setText:chat.data
           withHeader:chat.head_img
               isLeft:[chat.lr isEqualToString:@"l"]
           withStatus:status];
        cell.delegate = self;
        return cell;
    } else if ([chat.type isEqualToString:@"audio"]) {
        FNConnectionsChatVoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNConnectionsChatVoiceCell"];
        [cell setText:[NSString stringWithFormat:@"%.1f''", chat.length]
           withHeader:chat.head_img
               isLeft:[chat.lr isEqualToString:@"l"]
           withStatus:status];
        cell.delegate = self;
        cell.isPlaying = _playingVoiceIndex == indexPath;
        return cell;
    } else if ([chat.type isEqualToString:@"video"]) {
        FNConnectionsChatImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNConnectionsChatImageCell"];
        [cell setImage:chat.coverImage
                  size:chat.size
            withHeader:chat.head_img
                isLeft:[chat.lr isEqualToString:@"l"]
            withStatus:status
               isVideo:YES];
        cell.delegate = self;
        return cell;
    } else if ([chat.type isEqualToString:@"hongbao"]) {
        FNConnectionsChatRedPackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNConnectionsChatRedPackCell"];
        [cell setText:chat.hb_info
           withHeader:chat.head_img
               isLeft:[chat.lr isEqualToString:@"l"]
               isRead:chat.isRead
           withStatus:status];
        cell.delegate = self;
        return cell;
    } else if ([chat.type isEqualToString:@"hongbao_record"]) {
        NSString *str = @"";
        NSData *data = [chat.data dataUsingEncoding:NSUTF8StringEncoding];
        if (data) {
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            str = [json objectForKey:@"msg"];
        }
        FNConnectionsChatReceiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNConnectionsChatReceiveCell"];
        [cell setText:str];
        return cell;
    }
    
    
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = RED;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc] init];
    footer.backgroundColor = RED;
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"dianji  %ld", indexPath.row);
    [self closeKeyboard];
    
    NSInteger index = _chats.count - indexPath.row - 1;
    FNChatModel *chat = _chats[index];
    if ([chat.type isEqualToString:@"share_goods"]) {
        FNChatGoodsModel *model=[FNChatGoodsModel mj_objectWithKeyValues: chat.data];
        FNNewProDetailController* detail = [FNNewProDetailController new];
        detail.fnuo_id = model.fnuo_id;
        detail.goods_title = @"";
        NSError *error;
        NSData *data = [chat.data dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        detail.data=json;
//        [self.navigationController pushViewController:detail animated:YES];
        [self goProductVCWithModel:model withData:json];
    } else if ([chat.type isEqualToString:@"image"]) {
        [[SDWebImageManager sharedManager] downloadImageWithURL:URL(chat.data) options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (finished) {
                MJPhoto *mjPhoto = [[MJPhoto alloc] init];
                mjPhoto.image = image;
                MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
                browser.photos = @[mjPhoto];
                [browser show];
            }
        }];
        
    } else if ([chat.type isEqualToString:@"msg"]) {
    } else if ([chat.type isEqualToString:@"audio"]) {
        NSURL *url = URL(chat.data);
        if ([chat.fileName kr_isNotEmpty]) {
            url = [FNAudioRecordManager.shareInstance getURLWithFileName:chat.fileName];
        }
        if (url) {
            _playingVoiceIndex = indexPath;
            [self.tbvChat reloadData];
            @weakify(self)
            [FNWebVoiceManager.shareInstance playWithUrl:url completed:^(BOOL finished) {
                self_weak_.playingVoiceIndex = nil;
                [self_weak_.tbvChat reloadData];
            }];
        }
        
    } else if ([chat.type isEqualToString:@"video"]) {
        FNVideoPlayerController *playerController = [[FNVideoPlayerController alloc] init];
        NSURL *url = URL(chat.data);
        if ([chat.fileName kr_isNotEmpty]) {
            url = [NSURL fileURLWithPath:[FNChatManager getVideoPathWithFileName:chat.fileName]];
        }
        if (url) {
            [playerController playVideoWithUrl:url];
            [self presentViewController:playerController animated:YES completion:nil];
        }
    } else if ([chat.type isEqualToString:@"hongbao"]) {
        NSInteger hb_end=[chat.hb_end integerValue];
        NSInteger hb_receive=[chat.hb_receive integerValue];
        NSInteger is_own_send=[chat.is_own_send integerValue];
        if([self.target isEqualToString:@"ren"]){
            @weakify(self);
            if(is_own_send==0 && hb_receive == 0 && hb_end==0){
               [FNdrawRedPacketNaView showWithModel:nil view:self.view purchaseblock:^(id  _Nonnull model) {
                   NSString *type=model;
                   if([type isEqualToString:@"领取"]){
                       chat.hb_receive = @"1";
                       chat.hb_end = @"1";
                      [self_weak_ isSkipRedPacketVC:chat isDelegate:YES isQunData:nil];
                   } 
                }];
            }else{
                 [self isSkipRedPacketVC:chat isDelegate:NO isQunData:nil];
            } 
        }else if([self.target isEqualToString:@"qun"]){
            //红包已领取,已领完,已过期
            if ([chat.hb_receive isEqualToString:@"1"] || [chat.hb_end isEqualToString:@"1"] || chat.is_Expire) {
                [self isQunRedPacketCase:chat];
            } else {
                [FNdrawRedPacketNaView showWithModel:nil view:self.view purchaseblock:^(id  _Nonnull model) {
                    NSString *type=model;
                    if([type isEqualToString:@"领取"]){
                        [self isQunRedPacketCase:chat];
                    }
                }];
            }
        }
        
    } else if ([chat.type isEqualToString:@"hongbao_record"]) {
        
    }
    
}
-(void)isSkipRedPacketVC:(FNChatModel*)chat isDelegate:(BOOL)delegate isQunData:(FNopenRedPacketDeModel*)qunModel{
    FNneckRedPacketNaController *VC=[[FNneckRedPacketNaController alloc]init];
    VC.hb_id=chat.hb_id;
    VC.uid=self.uid;
    VC.target=self.target;
    VC.name=self.nickname;
    VC.hbModel=chat;
    if(delegate==YES){
       VC.delegate=self;
    }
    if([self.target isEqualToString:@"ren"]){
       VC.neckState=1;
    }
    if([self.target isEqualToString:@"qun"]){
        VC.dataModel=qunModel;
        VC.neckState=2;
    }
    if ([chat.is_own_send isEqualToString:@"1"] && [_target isEqualToString:@"ren"]) {
        //自己发的私聊红包不设置已领取状态
    } else {
        chat.isRead = YES;
    }
    [chat updateToDB];
    [self.tbvChat reloadData];
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)isQunRedPacketCase:(FNChatModel*)chat{
    //@weakify(self);
    NSString *urlString=@"mod=appapi&act=lt_hb&ctrl=open_lthb";
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    if([chat.hb_id kr_isNotEmpty]){
        params[@"hb_id"]=chat.hb_id;
        [FNRequestTool requestWithParams:params api:urlString respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
            XYLog(@"群红包情况:%@",respondsObject);
            NSDictionary *dictry=respondsObject[DataKey];
            FNopenRedPacketDeModel *resultModel=[FNopenRedPacketDeModel mj_objectWithKeyValues:dictry];
            NSString *type=resultModel.type;
            chat.isRead = YES;
            if([type isEqualToString:@"已领完"]||[type isEqualToString:@"已过期"]){
                
                FNredPacketExpireView *expireView = [[FNredPacketExpireView alloc]init];
                expireView.nameString=[NSString stringWithFormat:@"%@的红包",resultModel.send_hb_user_nickname];
                expireView.titleLB.text=[NSString stringWithFormat:@"%@的红包",resultModel.send_hb_user_nickname];
                [expireView.headImg setNoPlaceholderUrlImg:resultModel.send_hb_user_head_img];
                if([type isEqualToString:@"已领完"]){
                    expireView.remarkLB.text=resultModel.ylw_str_1;
                    expireView.checkBtn.hidden=NO;
                    chat.hb_end = @"1";
                    @weakify(self);
                    @weakify(expireView);
                    [expireView.checkBtn addJXTouch:^{
                        //XYLog(@"查看列表");
                        [expireView_weak_ dismissAlert];
                        [self_weak_ isSkipRedPacketVC:chat isDelegate:NO isQunData:resultModel];
                    }];
                }
                if([type isEqualToString:@"已过期"]){
                    chat.is_Expire = YES;
                    expireView.remarkLB.text=@"该红包已过期";
                    expireView.checkBtn.hidden=YES;
                }
                [[UIApplication sharedApplication].delegate.window addSubview:expireView];
                
            }else if([type isEqualToString:@"已领取"]){
                chat.isRead = YES;
                chat.hb_receive = @"1";
                [self isSkipRedPacketVC:chat isDelegate:NO isQunData:resultModel];
            }else if([type isEqualToString:@"开红包"]){
                @weakify(self);
                chat.isRead = YES;
                chat.hb_receive = @"1";
                [self_weak_ isSkipRedPacketVC:chat isDelegate:YES isQunData:resultModel];
                [FNChatManager.shareInstance sendOpenRedEnvelopes:type withhb_id:chat.hb_id toUid:self_weak_.uid withTarget:self_weak_.target];
            }
            
            [chat updateToDB];
            [self.tbvChat reloadData];
        } failure:^(NSString *error) {
        } isHideTips:NO isCache:NO];
    }
}
#pragma mark - FNneckRedPacketNaControllerDelegate  刷新
- (void)inReasonWordAlterHb:(FNChatModel*)model{
//    NSInteger hb_end=[model.hb_end integerValue];
//    NSInteger hb_receive=[model.hb_receive integerValue];
//    if(hb_end==1 || hb_receive==1){
//        //XYLog(@"消息修改=%@",model.ID);
//        [self refreshMsgItem:model];
//    }
 
    [self refreshMsgItem:model];
}
#pragma mark - 刷新
-(void)refreshMsgItem:(FNChatModel *)model{
    if([model.ID kr_isNotEmpty]){
        for (FNChatModel *chat in _chats) {
            if([chat.ID isEqualToString:model.ID]){
                chat.hb_end=model.hb_end;
                chat.hb_receive=model.hb_receive;
                chat.isRead=model.isRead;
//                chat.hb_receive = @"1";
//                if([model.type isEqualToString:@"ren"]){
//                    chat.hb_end = @"1";
//                }else{
//                    chat.hb_end = model.hb_end;
//                }
                [chat updateToDB];
                [self.tbvChat reloadData];
            }
        }
    }
}

#pragma mark - Keyboard
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    [self setIsIconShow:NO];
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    [self showKeyboardWithAnimation:height];
}

- (void)scrollViewToBottom:(BOOL)animated
{
    
    [self.view layoutIfNeeded];
    [self.tbvChat layoutIfNeeded];
    if (self.chats.count > 0) {
        @weakify(self)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self_weak_.chats.count - 1 inSection:0];
            [self_weak_.tbvChat scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
        });
        
    }
    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
    [self hideKeyboardWithAnimation];
}

#pragma mark - Networking

- (FNRequestTool*) requestCleanUnread {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"room": _room, @"target": _target}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=lt&ctrl=clean_unread" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache:NO];
}

- (FNRequestTool*) requestIconButtons {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection_index&ctrl=send_type" respondType:(ResponseTypeArray) modelType:@"FNChatIconModel" success:^(id respondsObject) {
        @strongify(self);
        [self.icons removeAllObjects];
        for (FNChatIconModel* model in respondsObject) {
            if ([model.type isEqualToString:@"red_packet"] && [FNCurrentVersion isEqualToString:Setting_checkVersion]) {
                continue;
            }
            [self.icons addObject:model];
        }
//        [self.icons addObjectsFromArray:respondsObject];
        NSMutableArray<NSString*> *titles = [[NSMutableArray alloc] init];
        NSMutableArray<UIColor*> *colors = [[NSMutableArray alloc] init];
        NSMutableArray<NSString*> *images = [[NSMutableArray alloc] init];
        for (FNChatIconModel *icon in self.icons) {
            [titles addObject:icon.str];
            [images addObject:icon.img];
            [colors addObject:[UIColor colorWithHexString:icon.color]];
        }
        
        [self.iconsView setIcons:images withTitles:titles andTextColors:colors];
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache:YES];
}

- (void)requestSetting {
    if ([_target isEqualToString:@"qun"]) {
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"qid": _uid}];
        @weakify(self);
        [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection_set&ctrl=set_list" respondType:(ResponseTypeArray) modelType:@"FNChatSettingModel" success:^(id respondsObject) {
            @strongify(self);
            // 隐藏设置头像选项
            NSArray<FNChatSettingModel*> *models = respondsObject;
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (FNChatSettingModel* model in models) {
                if (![model.SkipUIIdentifier isEqualToString:@"set_headimg"]) {
                    [array addObject:model];
                }
            }
            self.settings = array;
//            self.moreBtn.hidden = self.settings.count <= 0;
            
        } failure:^(NSString *error) {
            //
        } isHideTips:YES isCache:YES];
    }
}

- (void)requestModifyName: (NSString*)name {
    if ([_target isEqualToString:@"qun"]) {
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"qid": _uid, @"nickname": name}];
        @weakify(self);
        [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection_set&ctrl=set_nickname" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
            @strongify(self);
            NSString *name = respondsObject[@"name"];
            [self.leftBtn setTitle:name forState:UIControlStateNormal];
            [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.leftBtn sizeToFit];
            self.leftBtn.size = CGSizeMake(self.leftBtn.width+10, 30);
            if ([self.delegate respondsToSelector:@selector(didChatUpdate)]) {
                [self.delegate didChatUpdate];
            }
            
        } failure:^(NSString *error) {
            //
        } isHideTips:NO isCache:YES];
    }
}

- (void)requestDeleteQun {
    if ([_target isEqualToString:@"qun"]) {
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"qid": _uid}];
        @weakify(self);
        [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection_set&ctrl=del_qun" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(didChatUpdate)]) {
                [self.delegate didChatUpdate];
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSString *error) {
            //
        } isHideTips:NO isCache:YES];
    }
}

#pragma mark - Notifiaction

- (void)newMessage: (NSNotification*)noti {
    FNChatModel *chat = noti.userInfo[@"chat"];
    if (([chat.sendee_uid isEqualToString:_uid] || [chat.send_uid isEqualToString:_uid])
        && [chat.target isEqualToString:_target]) {
        
        [self requestCleanUnread];
        
        [self updateChat:chat];
        [self scrollViewToBottom:YES];
        
        @weakify(self)
        if ([chat.type isEqualToString:@"image"]) {
            [[SDWebImageManager sharedManager] downloadImageWithURL:URL(chat.data) options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                chat.size = image.size;
                chat.coverImage = image;
                [FNChatModel updateToDB:chat where:nil];
                [self_weak_.tbvChat reloadData];
                [self_weak_ scrollViewToBottom:YES];
            }];
        } else if ([chat.type isEqualToString:@"video"] ) {
            [[FNWebVideoManager shareInstance] downloadWithUrl:URL(chat.data) completed:^(UIImage * _Nonnull coverImage, NSURL * _Nonnull fileUrl, NSError * _Nonnull error, BOOL finished) {
                chat.size = coverImage.size;
                chat.coverImage = coverImage;
                [FNChatModel updateToDB:chat where:nil];
                [self_weak_.tbvChat reloadData];
                [self_weak_ scrollViewToBottom:YES];
            }];
        } else if ([chat.type isEqualToString:@"audio"]) {
            [[FNWebVoiceManager shareInstance] downloadWithUrl:URL(chat.data) completed:^(float length, NSURL * _Nonnull fileUrl, NSError * _Nonnull error, BOOL finished) {
                chat.length = length;
                [FNChatModel updateToDB:chat where:nil];
                [self_weak_.tbvChat reloadData];
                [self_weak_ scrollViewToBottom:YES];
            }];
 
        }else if ([chat.type isEqualToString:@"hongbao_record"]) {
            [self refreshMsgItem:chat];
 
        }
    }
}

- (void)updateChat: (FNChatModel*)model {
    //更新列表
    if ([model.return_str kr_isNotEmpty]) {
        NSInteger index = 0;
        for (; index < self.chats.count; index ++) {
            FNChatModel *chat = self.chats[index];
            if ([chat.return_str isEqualToString:model.return_str]) {
                model.status = 0;
                self.chats[index] = model;
                break;
            }
        }
        if (index >= self.chats.count)
            [self.chats insertObject:model atIndex:0];
    } else {
        [self.chats insertObject:model atIndex:0];
    }
    
    [self.tbvChat reloadData];
}

#pragma mark - Action

- (void)showKeyboardWithAnimation: (CGFloat)height {
    @weakify(self)
    [UIView animateWithDuration:0.2 animations:^{
        [self_weak_.vInput mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0).offset(-height);
        }];
        [self_weak_.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            [self_weak_ scrollViewToBottom:YES];
        }
    }];
}

- (void)hideKeyboardWithAnimation {
    @weakify(self)
    [UIView animateWithDuration:0.2 animations:^{
        
        [self_weak_.vInput mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0).offset((isIphoneX ? -34 : 0) + (self_weak_.isIconShow ? -IconHeight : 0));
        }];
        [self_weak_.view layoutIfNeeded];
    }];
}

- (void)leftBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtnAction {
    if ([_target isEqualToString:@"qun"]) {
        FNConnectionsSettingController *settingController = [[FNConnectionsSettingController alloc] init];
        settingController.room = _room;
        settingController.uid = _uid;
        settingController.target = _target;
        settingController.nickname = _nickname;
        [self.navigationController pushViewController:settingController animated:YES];
    } else if ([_target isEqualToString:@"ren"]) {
        FNConnectionRemarkController *remarkController = [[FNConnectionRemarkController alloc] init];
        remarkController.room = _room;
        remarkController.uid = _uid;
        remarkController.target = _target;
        remarkController.nickname = _nickname;
        remarkController.delegate = self;
        [self.navigationController pushViewController:remarkController animated:YES];
    }
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    for (FNChatSettingModel *setting in self.settings) {
//        PopoverAction *action1 = [PopoverAction actionWithTitle:setting.name handler:^(PopoverAction *action) {
//            // 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.
//            [self modify:setting.SkipUIIdentifier];
//        }];
//        [array addObject:action1];
//    }
//
//    PopoverView *popoverView = [PopoverView popoverView];
//    [popoverView showToView:self.moreBtn withActions:array];
}

- (void)modify: (NSString*)SkipUIIdentifier {
    if ([SkipUIIdentifier isEqualToString:@"set_nickname"]) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"修改群名"
                                                                       message:@""
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        @weakify(self);
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             @strongify(self);
                                                             if (alert.textFields.count > 0) {
                                                                 NSString *name = alert.textFields.firstObject.text;
                                                                 [self requestModifyName:name];
                                                             }
                                                         }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * action) {
                                                             }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"请输入需要修改的群名";
        }];
        
        [alert addAction:okAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else if ([SkipUIIdentifier isEqualToString:@"invite_qun"]) {
        if ([_target isEqualToString:@"qun"]) {
            FNConnectionsCreateGroupsController *vc = [[FNConnectionsCreateGroupsController alloc] init];
            vc.qid = _uid;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if ([SkipUIIdentifier isEqualToString:@"set_headimg"]) {
    }
    else if ([SkipUIIdentifier isEqualToString:@"del_qun"]) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"解散群"
                                                                       message:@"解散群之后无法恢复，是否确定继续解散群？"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        @weakify(self);
        UIAlertAction* okAction =
        [UIAlertAction actionWithTitle:@"确定"
                                 style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   @strongify(self);
                                   [self requestDeleteQun];
                               }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * action) {
                                                             }];
        
        [alert addAction:okAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

#pragma mark - gesture actions 手势

- (void)closeKeyboard:(UITapGestureRecognizer *)recognizer {
    //[self.view endEditing:YES];
    //[self setIsIconShow:NO];

}
- (void)closeKeyboard {
    [self.view endEditing:YES];
    [self setIsIconShow:NO];

}


#pragma mark - FNChatInputViewDelegate 输入框代理
- (void)inputView:(FNChatInputView *)inputView didKeyboardButtonClick:(id)sender {
    inputView.txvInput.inputView = nil;
//    [self.view endEditing:YES];
    [inputView.txvInput reloadInputViews];
    [inputView beginEdit];
}

- (void)inputView:(FNChatInputView *)inputView didVoiceButtonClick:(id)sender {
//    [self.view endEditing:YES];
//    [inputView beginEdit];
    [self closeKeyboard];
}

- (void)inputView:(FNChatInputView *)inputView didEmojiButtonClick:(id)sender {
//    [self.view endEditing:YES];
    FNEmojiInputView *emoji = [[FNEmojiInputView alloc] initWithFrame:CGRectMake(0, 0, XYScreenWidth, 250)];
    inputView.txvInput.inputView = emoji;
    emoji.delegate = self;
//    [self.view endEditing:YES];
    [inputView.txvInput reloadInputViews];
    [inputView beginEdit];
}

- (void)setIsIconShow: (BOOL)isIconShow {
    _isIconShow = isIconShow;
    if (isIconShow) {
        [self.view endEditing:YES];
        [UIView animateWithDuration:0.2 animations:^{
            [self.iconsView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(IconHeight);
            }];
            
            [self.view layoutIfNeeded];
        }];
        [self showKeyboardWithAnimation:IconHeight];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            [self.iconsView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
            }];
            
            [self.view layoutIfNeeded];
        }];
        [self hideKeyboardWithAnimation];
    }
}

- (void)inputView:(FNChatInputView *)inputView didAddButtonClick:(id)sender {
    [self setIsIconShow:YES];
}

- (void)inputView:(FNChatInputView *)inputView didSendButtonClick:(id)sender {
    if ([inputView.txvInput.text kr_isNotEmpty]) {
        [FNChatManager.shareInstance sendMessage:inputView.txvInput.text toUid:_uid withTarget:_target block:^(FNChatModel * _Nonnull chat) {
            [self.chats insertObject:chat atIndex:0];
            [self.tbvChat reloadData];
            [self scrollViewToBottom: YES];
        }];
        [inputView clearText];
    }
}

// 录音长按
- (void)inputView: (FNChatInputView*)inputView didVoicePressBegan: (id)sender {
    self.audioAlert.hidden = NO;
    _isCancle = NO;
    [self.audioAlert setVoiceWithLevel:1];
    @weakify(self)
    [FNAudioRecordManager.shareInstance startRecordWithVolume:^(float volume) {
        @strongify(self)
        if (!_isCancle)
            [self.audioAlert setVoiceWithLevel:volume * 6];
        
    } completed:^(NSURL * _Nonnull fileUrl, NSError * _Nonnull error, BOOL finished) {
        @strongify(self)
        if (finished) {
            @weakify(self)
//            NSData *data = [NSData dataWithContentsOfURL:fileUrl];
            [[FNChatManager shareInstance] sendAudio:fileUrl toUid:_uid withTarget:_target block:^(FNChatModel * _Nonnull chat) {
                @strongify(self)
                [self.chats insertObject:chat atIndex:0];
                [self.tbvChat reloadData];
                [self scrollViewToBottom: YES];
            }];
        }
    }];
}
// 录音结束
- (void)inputView: (FNChatInputView*)inputView didVoicePressEnded: (id)sender {
    self.audioAlert.hidden = YES;
    if (_isCancle) {
        [FNAudioRecordManager.shareInstance cancle];
    } else {
        [FNAudioRecordManager.shareInstance stopRecord];
    }
}
// 上滑
- (void)inputView: (FNChatInputView*)inputView didVoicePressUp: (id)sender {
    [self.audioAlert setRelease];
    _isCancle = YES;
}
// 手势复位
- (void)inputView: (FNChatInputView*)inputView didVoicePressReset: (id)sender {
//    [self.audioAlert setVoiceWithLevel:1];
    _isCancle = NO;
}

#pragma mark - FNEmojiInputViewDelegate Emoji键盘代理

- (void)didSendClick: (FNEmojiInputView*)inputView {
    
    if ([self.vInput.txvInput.text kr_isNotEmpty]) {
        [FNChatManager.shareInstance sendMessage:self.vInput.txvInput.text toUid:_uid withTarget:_target block:^(FNChatModel * _Nonnull chat) {
            [self.chats insertObject:chat atIndex:0];
            [self.tbvChat reloadData];
            [self scrollViewToBottom: YES];
        }];
        [self.vInput clearText];
//        for (NSInteger index = 0; index < 10; index ++) {
//            NSString *text = [NSString stringWithFormat:@"%@ : %d", self.vInput.txvInput.text, index];
//            [FNChatManager.shareInstance sendMessage:text toUid:_uid withTarget:_target block:^(FNChatModel * _Nonnull chat) {
//                [self.chats insertObject:chat atIndex:0];
//
//            }];
//        }
//        [self.tbvChat reloadData];
//        [self scrollViewToBottom: YES];
//        [self.vInput clearText];
        
    }
}
- (void)inputView: (FNEmojiInputView*)inputView didEmojiClick: (NSString*)emoji {
    [self.vInput insertString:emoji];
}
- (void)didDeleteClick: (FNEmojiInputView*)inputView {
    [self.vInput deleteString];
}

#pragma mark - FNChatIconViewDelegate

- (void)iconView:(FNChatIconView *)iconView didSelectAt:(NSInteger)index {
    
    FNChatIconModel *icon = self.icons[index];
    
    if ([icon.type isEqualToString:@"photo"]) {
        //相册
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
        imagePickerVc.allowPickingOriginalPhoto = NO;
        imagePickerVc.allowPickingVideo = YES;
        imagePickerVc.allowPickingImage = YES;
        imagePickerVc.allowTakePicture = NO;
        imagePickerVc.allowTakeVideo = NO;
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    } else if ([icon.type isEqualToString:@"photo_video"]) {
        //拍摄
        _recordView = [[JCVideoRecordView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        @weakify(self)
        _recordView.cancelBlock = ^{
            
        };
        _recordView.completionBlock = ^(NSURL *fileUrl) {
            AVURLAsset *asset = [AVURLAsset URLAssetWithURL:fileUrl options:nil];
            @strongify(self)
            @weakify(self)
            [[FNChatManager shareInstance] sendVideoWithURLAsset:asset toUid:self.uid withTarget:self.target block:^(FNChatModel * _Nonnull chat) {
                @strongify(self)
                [self.chats insertObject:chat atIndex:0];
                [self.tbvChat reloadData];
                [self scrollViewToBottom: YES];
            }];
        };
        _recordView.completionImageBlock = ^(UIImage *image) {
            @strongify(self)
            @weakify(self)
            [[FNChatManager shareInstance] sendImage:image toUid:self.uid withTarget:self.target block:^(FNChatModel * _Nonnull chat) {
                @strongify(self)
                [self.chats insertObject:chat atIndex:0];
                [self.tbvChat reloadData];
                [self scrollViewToBottom: YES];
            }];
        };
        [_recordView present];
    } else if ([icon.type isEqualToString:@"red_packet"]) {
        //红包
        FNhairContactsDeController *vc=[[FNhairContactsDeController alloc]init];
        vc.uid=self.uid;
        vc.room=self.room;
        if([self.target isEqualToString:@"ren"]){
            vc.statePacket=1;
        }else if([self.target isEqualToString:@"qun"]){
            vc.statePacket=2;
        }
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([icon.type isEqualToString:@"goods"]) {
        //宝贝
        FNSomeTimeTeController *vc=[[FNSomeTimeTeController alloc]init];
        vc.delegate=self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    
    @weakify(self)
    [[FNChatManager shareInstance] sendVideoWithAsset:asset toUid:_uid withTarget:_target block:^(FNChatModel * _Nonnull chat) {
        @strongify(self)
        [self.chats insertObject:chat atIndex:0];
        [self.tbvChat reloadData];
        [self scrollViewToBottom: YES];
    }];
}


- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    @weakify(self)
    for (UIImage *image in photos) {
        [[FNChatManager shareInstance] sendImage:image toUid:_uid withTarget:_target block:^(FNChatModel * _Nonnull chat) {
            @strongify(self)
            [self.chats insertObject:chat atIndex:0];
            [self.tbvChat reloadData];
            [self scrollViewToBottom: YES];
        }];
    }
}
#pragma mark - FNSomeTimeTeControllerDelegate 宝贝分享
- (void)someTimeDoteyList:(NSMutableArray*)list{
    if(list.count>0){
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        for (FNBaseProductModel *model in list) {
            NSString *fnuo_id=@"";
            NSString *goods_title=@"";
            NSString *commission=@"";
            NSString *yhq_price=@"";
            NSString *goods_img=@"";
            NSString *goods_sales=@"";
            NSString *goods_price=@"";
            NSString *shop_id=@"";
            NSString *goods_cost_price=@"";
            NSString *jd=@"";
            NSString *pdd=@"";
            NSString *shop_img=@"";
            NSString *fnuo_url=@"";
            NSString *fcommission_str=@"";
            if([model.fnuo_id kr_isNotEmpty]){
                fnuo_id=model.fnuo_id;
            }
            if([model.goods_title kr_isNotEmpty]){
                goods_title=model.goods_title;
            }
            if([model.commission kr_isNotEmpty]){
                commission=model.commission;
            }
            if([model.yhq_price kr_isNotEmpty]){
                yhq_price=model.yhq_price;
            }
            if([model.goods_img kr_isNotEmpty]){
                goods_img=model.goods_img;
            }
            if([model.goods_sales kr_isNotEmpty]){
                goods_sales=model.goods_sales;
            }
            if([model.goods_price kr_isNotEmpty]){
                goods_price=model.goods_price;
            }
            if([model.shop_id kr_isNotEmpty]){
                shop_id=model.shop_id;
            }
            if([model.goods_cost_price kr_isNotEmpty]){
                goods_cost_price=model.goods_cost_price;
            }
            if([model.jd kr_isNotEmpty]){
                jd=model.jd;
            }
            if([model.pdd kr_isNotEmpty]){
                pdd=model.pdd;
            }
            if([model.shop_img kr_isNotEmpty]){
                shop_img=model.shop_img;
            }
            if([model.fnuo_url kr_isNotEmpty]){
                fnuo_url=model.fnuo_url;
            }
            if([model.fcommission_str kr_isNotEmpty]){
                fcommission_str=model.fcommission_str;
            }
            NSDictionary *dictry=@{@"fnuo_id":fnuo_id,@"goods_title":goods_title,@"commission":commission,@"yhq_price":yhq_price,@"goods_img":goods_img,@"goods_sales":goods_sales,@"goods_price":goods_price,@"goods_cost_price":goods_cost_price,@"jd":jd,@"shop_id":shop_id,@"pdd":pdd,@"shop_img":shop_img,@"fnuo_url":fnuo_url,@"fcommission_str":fcommission_str};
            [arrM addObject:dictry];
        }
        [self apiRequestsArr:arrM];
    }
}
#pragma mark - 人脉商品库分享商品操作
-(void)apiRequestsArr:(NSMutableArray *)arr{
    if(arr.count>0){
        //NSString *urlString=@"mod=appapi&act=appGoodsBankShare&ctrl=index";
        for (NSDictionary * dictry in arr) {
            [FNChatManager.shareInstance sendGoodsDictry:dictry toUid:self.uid withTarget:self.target block:^(FNChatModel * _Nonnull chat) {
                [self.chats insertObject:chat atIndex:0];
                [self.tbvChat reloadData];
                [self scrollViewToBottom: YES];
            }];
//             NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{}];
//             NSString *jointStr=[self dictryTransitionString:dictry];
//             NSString *msgString=[self removeSpaceAndNewline:jointStr];
//             params[@"data"]=msgString;
//             params[@"time"]=[NSString GetNowTimes];
//             params[@"token"]=UserAccessToken;
//             [FNRequestTool requestWithParams:params api:urlString respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
//                [FNChatManager.shareInstance sendMessage:msgString toUid:self.uid withType:@"share_goods" andTarget:self.target];
//             } failure:^(NSString *error) {
//                [FNTipsView showTips:error];
//             } isHideTips:YES];
        }
    }
}
//去除空格

- (NSString *)removeSpaceAndNewline:(NSString *)str{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}
-(NSString *)dictryTransitionString:(NSDictionary*)dictry{
    NSData *data=[NSJSONSerialization dataWithJSONObject:dictry options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return jsonStr;
}

#pragma mark - FNConnectionsChatCellDelegate

- (void) didchatCellResendSelect: (UITableViewCell*)cell {
    //倒序
    NSIndexPath *indexPath = [self.tbvChat indexPathForCell:cell];
    if (indexPath == nil)
        return;
    NSInteger index = _chats.count - indexPath.row - 1;
    FNChatModel *chat = _chats[index];
    @weakify(self)
    UIAlertController *resend = [UIAlertController alertControllerWithTitle:@"" message:@"重发该消息？" preferredStyle:UIAlertControllerStyleAlert];
    [resend addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [resend addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self)
        [FNChatManager.shareInstance reSend:chat];
        [self.tbvChat reloadData];
    }]];
    [self presentViewController:resend animated:YES completion:nil];
    
}

#pragma mark - FNhairContactsDeController

- (void)didRedPackCreate:(FNChatModel *)model {
    if (model == nil) {
        return;
    }
    [self.chats insertObject:model atIndex:0];
    [self.tbvChat reloadData];
    [self scrollViewToBottom: YES];
}

#pragma mark - NotificationCenter
- (void)didChatDelete {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - FNConnectionRemarkControllerDelegate
- (void)didNameChange:(NSString *)name {
    _nickname = name;
    [self.leftBtn setTitle:self.nickname forState:UIControlStateNormal];
    [self.leftBtn sizeToFit];
    self.leftBtn.size = CGSizeMake(self.leftBtn.width+10, 30);
}

@end
