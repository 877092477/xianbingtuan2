//
//  FNNewFreeProductDetailController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNNewFreeProductDetailController.h"
#import "FNNewFreeProductDetailHeaderView.h"
#import "FNNewFreeProductShareAlertView.h"
#import "FNImageTableViewCell.h"
#import "FNNewFreeProductDetailModel.h"
#import <UMSocialCore/UMSocialCore.h>

@interface FNNewFreeProductDetailController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) FNNewFreeProductDetailHeaderView *headerView;

@property (nonatomic, strong) UITableView *tbvDetail;

@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) NSTimer *rightTimer;

@property (nonatomic, strong) NSMutableArray<UIImage*> *images;

@property (nonatomic, strong) FNNewFreeProductDetailModel *model;

@end

@implementation FNNewFreeProductDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商品详情";
    _images = [[NSMutableArray alloc] init];
    [self configNav];
    [self configUI];
    
    [self apiRequestGoods];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.rightTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(rightTimerAction) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    if (_rightTimer) {
        [_rightTimer invalidate];
    }

}

- (void)configNav {
//    先隐藏右上角分享，因为涉及到分享前状态判断，是否创建订单
//    UIButton *rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
//    [rightbutton setImage:IMAGE(@"free_image_nav_share") forState:UIControlStateNormal];
//    [rightbutton addTarget:self action:@selector(shareProduct) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
}

- (void)configUI {
    
    [self configBottomView];
    
    self.headerView = [[FNNewFreeProductDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenWidth + 150)];
    
    self.tbvDetail = [[UITableView alloc] init];
    [self.view addSubview:self.tbvDetail];
    self.tbvDetail.backgroundColor = FNHomeBackgroundColor;
    self.tbvDetail.tableHeaderView = self.headerView;
    self.tbvDetail.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tbvDetail.delegate = self;
    self.tbvDetail.dataSource = self;
    self.tbvDetail.rowHeight = UITableViewAutomaticDimension;
    self.tbvDetail.estimatedRowHeight = 800;
    self.tbvDetail.estimatedSectionFooterHeight = 0;
    self.tbvDetail.estimatedSectionHeaderHeight = 0;
    [self.tbvDetail registerClass:[FNImageTableViewCell class] forCellReuseIdentifier:@"FNImageTableViewCell"];
    
    if (@available(iOS 11.0, *)) {
        self.tbvDetail.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.tbvDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.bottom.equalTo(_footerView.mas_top);
    }];
    
    
}

- (void)configBottomView {
    self.footerView = [[UIView alloc] init];
    self.leftButton = [[UIButton alloc] init];
    self.rightButton = [[UIButton alloc] init];
    
    [self.view addSubview:self.footerView];
    [self.footerView addSubview:self.leftButton];
    [self.footerView addSubview:self.rightButton];
    
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.mas_equalTo(isIphoneX ? 82 : 50);
    }];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@0);
        make.width.equalTo(self.footerView);
        make.height.mas_equalTo(50);
    }];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(@0);
        make.left.equalTo(self.leftButton.mas_right);
        make.height.mas_equalTo(50);
    }];
    
    self.footerView.backgroundColor = UIColor.whiteColor;
    self.footerView.hidden = YES;
    
    self.leftButton.backgroundColor = RGB(255, 158, 19);
    self.rightButton.backgroundColor = UIColor.redColor;
    
    [self.leftButton setTitleColor:FNWhiteColor forState:UIControlStateNormal];
    self.leftButton.titleLabel.font = kFONT12;
    self.leftButton.titleLabel.numberOfLines = 2;
    self.rightButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.rightButton setTitleColor:FNWhiteColor forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = kFONT12;
    self.rightButton.titleLabel.numberOfLines = 2;
    self.rightButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.leftButton addTarget:self action:@selector(action:)];
    [self.rightButton addTarget:self action:@selector(action:)];
    
}

#pragma UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _images.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FNImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNImageTableViewCell"];
    [cell setImage:_images[indexPath.row]];
    return cell;
}


#pragma mark - Action

- (void) action: (UITapGestureRecognizer*)sender {
    
    [FNNewFreeProductShareAlertView dismiss];
    NSString *type = @"";
    if ([sender.view isEqual:self.leftButton]) {
        type = self.model.btn_list[0].type;
    } else if ([sender.view isEqual:self.rightButton]) {
        type = self.model.btn_list[1].type;
    } else {
        return;
    }
    
    if ([type isEqualToString:@"buy"]) {
        //原价购买
        if ([self.model.SkipUIIdentifier isEqualToString:@"buy_taobao"]) {
            [self goToProductDetailsWithModel:self.model];
        } else if ([self.model.SkipUIIdentifier isEqualToString:@"buy_jingdong"]) {
//            [self goToJDProductDetailsWithModel: self.model];
            [self goToJDProductDetailsWithURL: self.model.old_url];
        } else if ([self.model.SkipUIIdentifier isEqualToString:@"buy_pinduoduo"]) {
            [self goWebDetailWithWebType:@"0" URL:self.model.old_url];
        } else if ([self.model.SkipUIIdentifier isEqualToString:@"pub_wph_goods"]) {
            if ([self.model.yhq_url hasPrefix:@"vipshop://"]) {
                BOOL wphCheck=[[UIApplication sharedApplication] canOpenURL:URL(self.model.old_url)];
                if (wphCheck) {
                    [[UIApplication sharedApplication] openURL:URL(self.model.old_url)];
                } else {
                    [self goWebDetailWithWebType:@"0" URL:self.model.old_h5_url];
                }
            } else {
                [self goWebDetailWithWebType:@"0" URL:self.model.old_url];
            }
        }
    } else if ([type isEqualToString:@"share"]){
        [((UIButton*)sender.view) setEnabled:NO];
        [self createOrder:^{
            [((UIButton*)sender.view) setEnabled:YES];
            
            [self shareProduct];
        }];
    } else if ([type isEqualToString:@"share_continue"]) {
        [self shareProduct];
    } else if ([type isEqualToString:@"share_buy"]) {
//        [self goToProductDetailsWithModel:self.model];
        if ([NSString isEmpty:UserAccessToken]) {
            [self gologin];
            return;
        }
        if ([self.model.SkipUIIdentifier isEqualToString:@"buy_taobao"]) {
            [self openDetailWithID:self.model.fnuo_id withPid:self.model.tb_pid adzoneId:self.model.APP_adzoneId APP_alliance_appkey:self.model.APP_alliance_appkey];
        } else if ([self.model.SkipUIIdentifier isEqualToString:@"buy_jingdong"]) {
            [self goToJDProductDetailsWithModel: self.model];
        } else if ([self.model.SkipUIIdentifier isEqualToString:@"buy_pinduoduo"]) {
            [self goWebDetailWithWebType:@"0" URL:self.model.yhq_url];
        } else if ([self.model.SkipUIIdentifier isEqualToString:@"pub_wph_goods"]) {
            if ([self.model.yhq_url hasPrefix:@"vipshop://"]) {
                BOOL wphCheck=[[UIApplication sharedApplication] canOpenURL:URL(self.model.yhq_url)];
                if (wphCheck) {
                    [[UIApplication sharedApplication] openURL:URL(self.model.yhq_url)];
                } else {
                    [self goWebDetailWithWebType:@"0" URL:self.model.h5_url];
                }
            } else {
                [self goWebDetailWithWebType:@"0" URL:self.model.yhq_url];
            }
        }
    }
}

- (void) createOrder: (void(^)())callback {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token":UserAccessToken, @"fnuo_id": _fnuo_id}];
    [SVProgressHUD show];
    @weakify(self)
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=bargainDoing&ctrl=createOrder" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        [SVProgressHUD dismiss];
        callback();
        [self apiRequestGoods];
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
        
    } isHideTips:NO];
}

- (void) shareProduct {
    NSMutableArray *images = [[NSMutableArray alloc] init];
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (FNNewFreeProductDetailShareModel *share in self.model.share_list) {
        [images addObject:share.img];
        [titles addObject:share.name];
    }
    @weakify(self)
    [FNNewFreeProductShareAlertView showImages:images withTitles:titles bottomOffset:50 onClick:^(NSInteger index) {
        @strongify(self)
        
        [FNNewFreeProductShareAlertView dismiss];
        FNNewFreeProductDetailShareModel *share = self.model.share_list[index];
        
        UMSocialPlatformType type = 0;
        if ([share.type isEqualToString:@"wechat"]) {
            type = UMSocialPlatformType_WechatSession;
        } else if ([share.type isEqualToString:@"friendcircle"]) {
            type = UMSocialPlatformType_WechatTimeLine;
        } else if ([share.type isEqualToString:@"qq"]) {
            type = UMSocialPlatformType_QQ;
        } else if ([share.type isEqualToString:@"microblog"]) {
            type = UMSocialPlatformType_Sina;
        }
        
        [XYNetworkAPI downloadImages:@[self.model.share_img] withFinishedBlock:^(NSArray<UIImage *> *images) {
            //创建分享消息对象
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            //创建网页内容对象
            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.model.share_title descr:self.model.share_content thumImage:images.firstObject];
            //设置网页地址
            shareObject.webpageUrl = self.model.share_url;
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject;
            //调用分享接口
            [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                if (error) {
                    NSLog(@"************Share fail with error %@*********",error);
                }else{
                    NSLog(@"response data is %@",data);
                }
            }];
        }];
        
        
        
    }];
}

#pragma mark - Networking

- (void)requestImages: (NSArray<NSString*>*)imageUrls {
    [_images removeAllObjects];
    @weakify(self)
    [XYNetworkAPI downloadImages:imageUrls
                  withIndexBlock:^(UIImage *image, NSInteger index) {
                      @strongify(self)
                      [self.images addObject:image];
                      [self.tbvDetail reloadData];

    } failureBlock:^(NSError *error) {

    }];

}

- (FNRequestTool *)apiRequestGoods{
    @weakify(self)
    
    NSError *error = nil;
    NSData * JSONData = [NSJSONSerialization dataWithJSONObject:_data options:kNilOptions error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken, @"data": jsonString, @"fnuo_id": _fnuo_id}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=bargainList&ctrl=detail" respondType:(ResponseTypeModel) modelType:@"FNNewFreeProductDetailModel" success:^(id respondsObject) {
        @strongify(self)
        self.model = respondsObject;
        
        [self.headerView setImages:self.model.imgArr];
        self.headerView.lblTitle.text = self.model.goods_title;
        self.headerView.lblMsg.text = self.model.explain_str;
        self.headerView.lblMsg.textColor = [UIColor colorWithHexString:self.model.explain_font_color];
        self.headerView.vMsg.backgroundColor = [UIColor colorWithHexString:self.model.explain_color];
        self.headerView.lblPrice.text = self.model.price_str;
        self.headerView.lblPrice.textColor = [UIColor colorWithHexString:self.model.price_color];
        self.headerView.lblPeople.text = self.model.sales_str;
        self.headerView.lblCount.text = self.model.stock_str;
        if (self.model.btn_list.count >= 1) {
            FNNewFreeProductDetailButtonModel *left = self.model.btn_list[0];
            NSString *str = [NSString stringWithFormat:@"%@%@%@", left.top_str, ([left.top_str kr_isNotEmpty] && [left.btm_str kr_isNotEmpty] ? @"\n" : @""), left.btm_str];
            [self.leftButton setTitle:str forState:UIControlStateNormal];
            [self.leftButton setTitleColor:[UIColor colorWithHexString:left.font_color] forState:UIControlStateNormal];
            self.leftButton.backgroundColor = [UIColor colorWithHexString:left.bj_color];
            
            [self.leftButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self.footerView);
            }];
        }
        if (self.model.btn_list.count == 2) {
            FNNewFreeProductDetailButtonModel *right = self.model.btn_list[1];
            NSString *str = [NSString stringWithFormat:@"%@%@%@", right.top_str, ([right.top_str kr_isNotEmpty] && [right.btm_str kr_isNotEmpty] ? @"\n" : @""), right.btm_str];
            [self.rightButton setTitle:str forState:UIControlStateNormal];
            [self.rightButton setTitleColor:[UIColor colorWithHexString:right.font_color] forState:UIControlStateNormal];
            self.rightButton.backgroundColor = [UIColor colorWithHexString:right.bj_color];
            [self.leftButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self.footerView).multipliedBy(0.4);
            }];
            if ([right.over_time kr_isNotEmpty]) {
                [self.rightTimer invalidate];
                self.rightTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(rightTimerAction) userInfo:nil repeats:YES];
            }
        }
        self.footerView.hidden = self.model.btn_list.count == 0;
        [self.footerView layoutIfNeeded];
        
        [self requestImages:self.model.detailArr];
        
        [self.tbvDetail reloadData];
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache:NO];
}

#pragma mark - Timer
- (void)rightTimerAction {
    if (self.model.btn_list.count == 2) {
        FNNewFreeProductDetailButtonModel *right = self.model.btn_list[1];
        if ([right.over_time kr_isNotEmpty]) {
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:right.over_time.doubleValue];
            NSInteger time = [date timeIntervalSinceDate:[NSDate dateWithTimeIntervalSinceNow:0]];
            if (time <= 0) {
                [_rightTimer invalidate];
                _rightTimer = nil;
            }
            NSInteger h = time / 3600;
            NSInteger m = (time % 3600) / 60;
            NSInteger s = time % 60;
            
            NSString *str = [NSString stringWithFormat:@"%@ %2ld:%2ld:%2ld%@%@", right.top_str, (long)h, m, s, ([right.top_str kr_isNotEmpty] && [right.btm_str kr_isNotEmpty] ? @"\n" : @""), right.btm_str];
            [self.rightButton setTitle:str forState:UIControlStateNormal];
        }
    } else {
        [_rightTimer invalidate];
        _rightTimer = nil;
    }
}

@end
