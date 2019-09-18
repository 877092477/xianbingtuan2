//
//  FNMyVideoCardUseController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNMyVideoCardUseController.h"
#import "FNVideoCardUseModel.h"
#import "FNMyVideoCardBuyController.h"
#import "lhScanQCodeViewController.h"

@interface FNMyVideoCardUseController ()<lhScanQCodeViewControllerDelegate>
@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UIButton *rightBtn;
@property (nonatomic, strong) FNVideoCardUseModel *model;

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UIView *vContent;

@property (nonatomic, strong) UIImageView *imgHeader;
@property (nonatomic, strong) UIImageView *imgLock;
@property (nonatomic, strong) UITextField *txfCode;
@property (nonatomic, strong) UIButton *btnScan;
@property (nonatomic, strong) UIButton *btnUse;

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;


@property (nonatomic, strong) UIView *vAlert;
@property (nonatomic, strong) UIImageView *imgAlertBackground;
@property (nonatomic, strong) UILabel *lblAlertTitle;
@property (nonatomic, strong) UILabel *lblAlertTime;
@property (nonatomic, strong) UIButton *btnClose;

@end

@implementation FNMyVideoCardUseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self configUI];
    [self configAlert];
    [self requestMain];
}

- (void)configUI {
    _scrollview = [[UIScrollView alloc] init];
    _vContent = [[UIView alloc] init];
    _imgHeader = [[UIImageView alloc] init];
    _imgLock = [[UIImageView alloc] init];
    _txfCode = [[UITextField alloc] init];
    _btnScan = [[UIButton alloc] init];
    _btnUse = [[UIButton alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    
    [self.view addSubview: _scrollview];
    [_scrollview addSubview: _vContent];
    [_vContent addSubview: _imgHeader];
    [_vContent addSubview: _imgLock];
    [_vContent addSubview: _txfCode];
    [_vContent addSubview: _btnScan];
    [_vContent addSubview: _btnUse];
    [_vContent addSubview: _lblTitle];
    [_vContent addSubview: _lblDesc];
    
    [_scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        make.width.equalTo(self.view);
    }];
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
        make.top.equalTo(@12);
        make.height.mas_equalTo(182);
    }];
    [_txfCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgLock.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.btnScan.mas_left).offset(-10);
        make.top.equalTo(self.imgHeader.mas_bottom).offset(36);
    }];
    [_imgLock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@22);
        make.width.height.mas_equalTo(20);
        make.centerY.equalTo(self.txfCode);
    }];
    [_btnScan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-26);
        make.width.height.mas_equalTo(20);
        make.centerY.equalTo(self.txfCode);
    }];
    [_btnUse mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnScan.mas_bottom).offset(20);
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.height.mas_equalTo(56);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnUse.mas_bottom).offset(20);
        make.left.equalTo(@34);
        make.right.lessThanOrEqualTo(@-34);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblTitle.mas_bottom).offset(13);
        make.left.equalTo(@34);
        make.right.lessThanOrEqualTo(@-34);
        make.bottom.lessThanOrEqualTo(@-40);
    }];
    
    _imgHeader.contentMode = UIViewContentModeScaleAspectFit;
    
    _imgLock.contentMode = UIViewContentModeScaleAspectFit;
    
    _txfCode.font = kFONT16;
    
    [_btnScan addTarget:self action:@selector(scanAction)];
    
    [_btnUse setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    _btnUse.titleLabel.font = [UIFont systemFontOfSize:18];
    [_btnUse addTarget:self action:@selector(useCard)];
    
    _lblTitle.font = kFONT14;
    _lblTitle.textColor = RGB(153, 153, 153);
    
    _lblDesc.font = kFONT15;
    _lblDesc.textColor = RGB(51, 51, 51);
    _lblDesc.numberOfLines = 0;
    
    UIView *line = [[UIView alloc] init];
    [_vContent addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@22);
        make.right.equalTo(@-22);
        make.bottom.equalTo(self.txfCode).offset(4);
        make.height.mas_equalTo(1);
    }];
    line.backgroundColor = RGB(235, 235, 235);
}

-(void)setupNav{
    UIButton *leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [leftBtn setTitleColor:FNBlackColor forState:UIControlStateNormal];
    [leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    [leftBtn sizeToFit];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.size=CGSizeMake(30,  30);
    self.leftBtn=leftBtn;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    UIButton *rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    //    [rightbutton setTitle:@"我的免单" forState:UIControlStateNormal];
    rightbutton.titleLabel.font = kFONT12;
    [rightbutton setTitleColor:RGB(60, 60, 60) forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn=rightbutton;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    if(self.understand==YES){
        self.leftBtn.hidden=YES;
    }
    
}

- (void)configAlert {
    _vAlert = [[UIView alloc] init];
    _imgAlertBackground = [[UIImageView alloc] init];
    _lblAlertTitle = [[UILabel alloc] init];
    _lblAlertTime = [[UILabel alloc] init];
    _btnClose = [[UIButton alloc] init];
    
//    _vAlert;
    [_vAlert addSubview:_imgAlertBackground];
    [_vAlert addSubview:_lblAlertTitle];
    [_vAlert addSubview:_lblAlertTime];
    [_vAlert addSubview:_btnClose];
    
//    _vAlert;
    [_imgAlertBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.width.mas_equalTo(300);
        make.height.equalTo(self.imgAlertBackground.mas_height).dividedBy(1);
        make.top.equalTo(@166);
    }];
    [_lblAlertTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imgAlertBackground);
        make.top.equalTo(self.imgAlertBackground).offset(80);
        make.left.greaterThanOrEqualTo(self.imgAlertBackground).offset(20);
        make.right.lessThanOrEqualTo(self.imgAlertBackground).offset(-20);
    }];
    [_lblAlertTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imgAlertBackground);
        make.left.greaterThanOrEqualTo(self.imgAlertBackground).offset(20);
        make.right.lessThanOrEqualTo(self.imgAlertBackground).offset(-20);
        make.top.equalTo(self.lblAlertTitle).offset(18);
    }];
    [_btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.imgAlertBackground);
    }];
    
    _vAlert.backgroundColor = RGBA(0, 0, 0, 0.3);
    
    _lblAlertTitle.font = kFONT15;
    _lblAlertTitle.textColor = RGB(51, 51, 51);
    
    _lblAlertTime.font = kFONT13;
    _lblAlertTime.textColor = RGB(153, 153, 153);
    
    [_btnClose setImage:IMAGE(@"video_card_alert_close") forState:UIControlStateNormal];
    [_btnClose addTarget:self action:@selector(close)];
}

-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightBtnAction{
    FNMyVideoCardBuyController *vc = [[FNMyVideoCardBuyController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scanAction{
    lhScanQCodeViewController *vc = [[lhScanQCodeViewController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)useCard {
    
//    [self showAlert:@"兑换成功！快来看视频吧！！" withTime:@"有效期至2019-05-03" withBackground:@"http://www.hairuyi.com/View/index/img/appapi/comm/code_act_succ_img.png?time=1554260875"];
    if ([_txfCode.text kr_isNotEmpty]) {
        [self requestUse:_txfCode.text];
    }
}

- (void)close {
    [self.vAlert removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showAlert: (NSString*)title withTime: (NSString*)time withBackground: (NSString*)bgURL{
    _lblAlertTitle.text = title;
    _lblAlertTime.text = time;
    @weakify(self)
    [_imgAlertBackground sd_setImageWithURL:URL(bgURL) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (error == nil && image) {
            [self.imgAlertBackground mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(self.imgAlertBackground.mas_width).dividedBy(image.size.width / image.size.height);
            }];
        }
    }];
    
    [FNKeyWindow addSubview:_vAlert];
    [_vAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

#pragma mark - Networking

- (FNRequestTool*) requestMain {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=app_movie_order&ctrl=code_index" respondType:(ResponseTypeModel) modelType:@"FNVideoCardUseModel" success:^(id respondsObject) {
        @strongify(self);
        self.model = respondsObject;
        
        self.title = self.model.title;
        [self.rightBtn setTitle:self.model.right_title forState:UIControlStateNormal];
        
        [self.imgHeader sd_setImageWithURL:URL(self.model.logo)];
        [self.imgLock sd_setImageWithURL:URL(self.model.lock_img)];
        self.txfCode.placeholder = self.model.input_str;
        [self.btnScan sd_setImageWithURL:URL(self.model.qrcode_img) forState:UIControlStateNormal];
        [self.btnUse sd_setBackgroundImageWithURL:URL(self.model.btn_img) forState:UIControlStateNormal];
        [self.btnUse setTitle:self.model.btn_str forState:UIControlStateNormal];
        [self.btnUse setTitleColor:[UIColor colorWithHexString:self.model.btn_color] forState:UIControlStateNormal];
        self.lblTitle.text = self.model.info;
        NSMutableString *desc = [[NSMutableString alloc] init];
        for (NSInteger index = 0; index < self.model.rule.count; index++) {
            if (index != 0) {
                [desc appendString:@"\n\n"];
            }
            FNVideoCardUseRuleModel *rule = self.model.rule[index];
            [desc appendFormat:@"%@\n", rule.code_rule_title];
            [desc appendFormat:@"%@\n", rule.code_rule_content];
        }
        self.lblDesc.text = desc;
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache:NO];
}

- (FNRequestTool*) requestUse: (NSString*)code {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"code": code}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=app_movie_order&ctrl=act_doing" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSString *str = respondsObject[@"str"];
        NSString *img = respondsObject[@"img"];
        NSString *str1 = respondsObject[@"str1"];
        
        [self showAlert:str withTime:str1 withBackground:img];
        
        [NSNotificationCenter.defaultCenter postNotificationName:@"MY_VIDEO_CARD_USE" object:nil];
        
    } failure:^(NSString *error) {
        
    } isHideTips:NO isCache:NO];
}

#pragma mark - lhScanQCodeViewControllerDelegate

- (void)didCodeScan:(NSString*)result {
    self.txfCode.text = result;
}

@end
