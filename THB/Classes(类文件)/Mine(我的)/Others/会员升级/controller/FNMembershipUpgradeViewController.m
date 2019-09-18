//
//  FNMembershipUpgradeViewController.m
//  嗨如意
//
//  Created by Fnuo-iOS on 2018/4/20.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNMembershipUpgradeViewController.h"
#import "FNUpgradeGoodsNController.h"
#import "FNNewUpgradeGoodsNController.h"

#import <UMSocialCore/UMSocialCore.h>
#import "WechatOpenSDK/WXApiObject.h"
#import "WechatOpenSDK/WXApi.h"

@interface FNMembershipUpgradeViewController ()

@end

@implementation FNMembershipUpgradeViewController{
    CGFloat TopViewHeight;
    CGFloat MidImageViewHeight;
    CGFloat ruleLabelHeight;
    NSInteger _is_xufei;
    NSString *tishi1;
    NSString *tishi2;
}

-(NSArray *)showArr1{
    if (_showArr1==nil) {
        _showArr1=[NSArray new];
    }
    return _showArr1;
}

-(NSArray *)showArr2{
    if (_showArr2==nil) {
        _showArr2=[NSArray new];
    }
    return _showArr2;
}

//头部
-(FNMembershipUpgradeTopView *)TopView{
    if (_TopView==nil) {
        _TopView=[FNMembershipUpgradeTopView new];
    }
    return _TopView;
}

- (FNMCAgentListView *)listview{
    if (_listview == nil) {
        _listview = [[FNMCAgentListView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 0))];
        _listview.backgroundColor = FNWhiteColor;
        @WeakObj(self);
        _listview.updateBtnBlock = ^(NSInteger index) {
            [SVProgressHUD show];
            if (_is_xufei==0) {
                MembershipUpgradeShowModel *showModel=selfWeak.showArr1[index];
                [selfWeak apiRequestApply:showModel.id];
            }else{
                MembershipUpgradeShowModel *showModel=selfWeak.showArr2[index];
                [selfWeak apiRequestApply:showModel.id];
            }
            [FNPopUpTool hiddenAnimated:YES];
        };
    }
    return _listview;
}

- (BOOL)isFullScreenShow {
    return YES;
}

- (BOOL)needLogin {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"会员升级";
    if ([NSString isEmpty:UserAccessToken]) {
        [self gologin];
    }
    if (![NSString isEmpty:UserAccessToken]) {
        TopViewHeight=(JMScreenWidth-20)*0.6+50;
        MidImageViewHeight=0;
        ruleLabelHeight=0;
        
        [self initializedSubviews];
        
        [SVProgressHUD show];
        [self apiRequestData];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onWxSuccess) name:@"Wx_Resp_Success" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    if ([NSString isEmpty:UserAccessToken]) {
//        [self gologin];
//        return;
//    }
}

#pragma mark - initializedSubviews
-(void)initializedSubviews{
    UIScrollView *bgView=[UIScrollView new];
    bgView.hidden=YES;
    bgView.backgroundColor=FNHomeBackgroundColor;
    bgView.delegate = self;
    bgView.showsHorizontalScrollIndicator = NO;
    bgView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        if (self.navigationController.viewControllers.count>=2) {
            make.bottom.equalTo(@0);
        }else{
            make.bottom.equalTo(@(-TABBAR_H));
        }
    }];
    self.bgView=bgView;
    
    [bgView addSubview:self.TopView];
    [self.TopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView.mas_centerX);
        make.left.right.top.equalTo(@0);
        make.height.equalTo(@(TopViewHeight));
    }];
    [self.TopView.caozuoBtn1 addTarget:self action:@selector(caozuoBtn1Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.TopView.caozuoBtn2 addTarget:self action:@selector(caozuoBtn2Action:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *MidImageView=[UIImageView new];
    [bgView addSubview:MidImageView];
    [MidImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView.mas_centerX);
        make.left.right.equalTo(@0);
        make.top.equalTo(self.TopView.mas_bottom).offset(0);
    }];
    self.MidImageView=MidImageView;
    
    UIImageView *BottomImageView=[UIImageView new];
    BottomImageView.contentMode = UIViewContentModeScaleAspectFit;
    [bgView addSubview:BottomImageView];
    [BottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView.mas_centerX);
        make.top.equalTo(MidImageView.mas_bottom).offset(20);
        make.height.equalTo(@30);
    }];
    self.BottomImageView=BottomImageView;
    
    UILabel *ruleLabel=[[UILabel alloc]init];
    ruleLabel.font=kFONT15;
    ruleLabel.textColor=FNBlackColor;
    ruleLabel.numberOfLines=0;
    [bgView addSubview:ruleLabel];
    [ruleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView.mas_centerX);
        make.top.equalTo(BottomImageView.mas_bottom).offset(20);
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
    }];
    self.ruleLabel=ruleLabel;
}

#pragma mark - Action
-(void)caozuoBtn1Action:(UIButton *)sender{
    _is_xufei=0;
    
    if ([[FNBaseSettingModel settingInstance].update_tbauthorization_onoff isEqualToString: @"0"]) {
         [self goCaozuo1];
        return;
    }
    
    @weakify(self)
    [self refreshSetting:YES block:^{
        @strongify(self)
        @weakify(self)
        if ([self showNeedSwitchAccount:^(BOOL result) {
            @strongify(self)
            [self caozuoBtn1Action:sender];
        }]) {
            return ;
        }
        if ([self showNeedAuth:^(BOOL result) {
            @strongify(self)
            [self caozuoBtn1Action:sender];
        }]) {
            return;
        }
        
        if (self.showArr1.count>=1) {
            [self goCaozuo1];
            
        }else{
            [FNTipsView showTips:tishi1];
        }
    }];
}
- (void) goCaozuo1 {
    NSInteger iupdate_goods_onoffInt=[[FNBaseSettingModel settingInstance].update_goods_onoff integerValue];
    if(iupdate_goods_onoffInt==0){
        NSMutableArray* titles = [NSMutableArray new];
        [self.showArr1 enumerateObjectsUsingBlock:^(MembershipUpgradeShowModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [titles addObject:obj.title];
        }];
        self.listview.list = titles;
        [self.listview.updateBtn setTitle:@"升级" forState:UIControlStateNormal];
        [FNPopUpTool showViewWithContentView:self.listview withDirection:(FMPopupAnimationDirectionBottom) finished:nil];
    }else if (iupdate_goods_onoffInt==1){
        [FNTipsView showTips:@"升级购"];
        FNUpgradeGoodsNController *goodsVC=[[FNUpgradeGoodsNController alloc]init];
        [self.navigationController pushViewController:goodsVC animated:YES];
        
    } else if (iupdate_goods_onoffInt==2 || iupdate_goods_onoffInt==3) {
        
        FNNewUpgradeGoodsNController *goodsVC=[[FNNewUpgradeGoodsNController alloc]init];
        [self.navigationController pushViewController:goodsVC animated:YES];
    }
}

-(void)caozuoBtn2Action:(UIButton *)sender{
    _is_xufei=1;
    
    if ([[FNBaseSettingModel settingInstance].update_tbauthorization_onoff isEqualToString: @"0"]) {
        [self goCaozuo2];
        return;
    }
    @weakify(self)
    [self refreshSetting:YES block:^{
        @strongify(self)
        @weakify(self)
        if ([self showNeedSwitchAccount:^(BOOL result) {
            @strongify(self)
            [self caozuoBtn2Action:sender];
        }]) {
            return ;
        }
        if ([self showNeedAuth:^(BOOL result) {
            @strongify(self)
            [self caozuoBtn2Action:sender];
        }]) {
            return;
        }
        
        if (self.showArr2.count>=1) {
            [self goCaozuo2];
        }else{
            [FNTipsView showTips:tishi2];
        }
    }];
}

- (void)goCaozuo2 {
    NSMutableArray* titles = [NSMutableArray new];
    [self.showArr2 enumerateObjectsUsingBlock:^(MembershipUpgradeShowModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [titles addObject:obj.title];
    }];
    self.listview.list = titles;
    [self.listview.updateBtn setTitle:@"续费" forState:UIControlStateNormal];
    [FNPopUpTool showViewWithContentView:self.listview withDirection:(FMPopupAnimationDirectionBottom) finished:nil];
}

#pragma mark - api request
- (void)apiRequestData{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appHhr02&ctrl=index" respondType:(ResponseTypeModel) modelType:@"MembershipUpgradeModel" success:^(id respondsObject) {
        //
        [SVProgressHUD dismiss];
        selfWeak.Model = respondsObject;
        [selfWeak apiRequestApplyShow:@"0"];
        [selfWeak apiRequestApplyShow:@"1"];
        [selfWeak setData];
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}

#pragma mark - api request
- (void)apiRequestApplyShow:(NSString *)is_xufei{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"is_xufei":is_xufei}];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appHhr02&ctrl=level" respondType:(ResponseTypeArray) modelType:@"MembershipUpgradeShowModel" success:^(NSArray *respondsObject) {
        //
        if (is_xufei.integerValue==0) {
            selfWeak.showArr1 = respondsObject;
        }else{
            selfWeak.showArr2 = respondsObject;
        }
    } failure:^(NSString *error) {
        //
        if (is_xufei.integerValue==0) {
            tishi1=error;
        }else{
            tishi2=error;
        }
    } isHideTips:YES];
}
//判断是否免费
- (void)apiRequestApply:(NSString *)ID{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"id":ID,@"is_xufei":@(_is_xufei),@"is_checks":@"1"}];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dg_payment&ctrl=payment_dl" respondType:(ResponseTypeNone) modelType:nil success:^(id respondsObject) {
        //
        NSString* code = respondsObject[DataKey][@"code"];
        if ([code isEqualToString:@"免费"]) {
            [self goToFNMCAgentApplyController];
        }else{
            FNPayTypeChooseViewController *chooseVC=[FNPayTypeChooseViewController new];
            chooseVC.successCheckBlock = ^(NSString *PayType) {
                [SVProgressHUD show];
                [selfWeak apiRequestApply:ID PayType:PayType];
            };
            [selfWeak.navigationController pushViewController:chooseVC animated:YES];
        }
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
//不免费情况下调用相同接口传不同数据
- (void)apiRequestApply:(NSString *)ID PayType:(NSString *)PayType{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"id":ID,@"is_xufei":@(_is_xufei),@"type":PayType,@"is_checks":@"0"}];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dg_payment&ctrl=payment_dl" respondType:(ResponseTypeNone) modelType:nil success:^(id respondsObject) {
        //
        NSString* code = respondsObject[DataKey][@"code"];
        if ([PayType isEqualToString:@"yue"]) {
            [self goToFNMCAgentApplyController];
        }
        else if ([PayType isEqualToString:@"wx"]) {
            [selfWeak reqeustBaseSetting];
            
            NSString *partnerid = respondsObject[DataKey][@"partnerid"];
            NSString *nonce_str = respondsObject[DataKey][@"noncestr"];
            NSString *prepay_id = respondsObject[DataKey][@"prepayid"];
            NSString *sign = respondsObject[DataKey][@"sign"];
            NSString *timeStamp = respondsObject[DataKey][@"timestamp"];
            
            PayReq *request = [[PayReq alloc] init];
            request.partnerId = partnerid;
            request.prepayId= prepay_id;
            request.package = @"Sign=WXPay";
            request.nonceStr= nonce_str;
            request.timeStamp= timeStamp.intValue;
            
            request.sign= sign;
            [WXApi sendReq: request];
            
        } else {
            [selfWeak reqeustBaseSetting];
            [[AlipaySDK defaultService] payOrder:code fromScheme:AlisdkSchemes callback:^(NSDictionary *resultDic) {
                if ([NSString checkIsSuccess:resultDic[@"resultStatus"] andElement:@"9000"] ) {
                    [FNTipsView showTips:ResultStatusDict[@"9000"]];
                    [self goToFNMCAgentApplyController];
                }else{
                    [SVProgressHUD dismiss];
                    [FNTipsView showTips:ResultStatusDict[resultDic[@"resultStatus"] ] withDuration:2.0];
                }
            }];
        }
    } failure:^(NSString *error) {
        //
    } isHideTips:NO isCache:NO];
}

-(NSString *)createMD5SingForPayWithAppID:(NSString *)appid_key partnerid:(NSString *)partnerid_key prepayid:(NSString *)prepayid_key package:(NSString *)package_key noncestr:(NSString *)noncestr_key timestamp:(UInt32)timestamp_key{
    NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
    [signParams setObject:appid_key forKey:@"appid"];//微信appid 例如wxfb132134e5342
    [signParams setObject:noncestr_key forKey:@"noncestr"];//随机字符串
    [signParams setObject:package_key forKey:@"package"];//扩展字段  参数为 Sign=WXPay
    [signParams setObject:partnerid_key forKey:@"partnerid"];//商户账号
    [signParams setObject:prepayid_key forKey:@"prepayid"];//此处为统一下单接口返回的预支付订单号
    [signParams setObject:[NSString stringWithFormat:@"%u",timestamp_key] forKey:@"timestamp"];//时间戳
    
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [signParams allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (   ![[signParams objectForKey:categoryId] isEqualToString:@""]
            && ![[signParams objectForKey:categoryId] isEqualToString:@"sign"]
            && ![[signParams objectForKey:categoryId] isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [signParams objectForKey:categoryId]];
        }
    }
    //添加商户密钥key字段  API 密钥
    [contentString appendFormat:@"key=%@", @"FNUO123COMhairuyiizhimxxxxxxxxxx"];
//    NSString *result = [contentString md5String];//md5加密
    NSLog(@"%@", contentString);
    NSString *result = [NSString md5:contentString];
    return result;
}

- (FNRequestTool *)reqeustBaseSetting{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:_api_others_getset respondType:(ResponseTypeModel) modelType:@"FNBaseSettingModel" success:^(id respondsObject) {
        //
        FNBaseSettingModel* defaultModel = [FNBaseSettingModel settingInstance];
        FNBaseSettingModel* model = respondsObject;
//        model.tabs = defaultModel.tabs;
        model.ksrk = defaultModel.ksrk;
        model.tw = defaultModel.tw;
        [FNBaseSettingModel saveSetting:model];
        [[NSUserDefaults standardUserDefaults] setValue:model.extendreg forKey:XYextendreg];
        [[NSUserDefaults standardUserDefaults] setValue:model.appopentaobao_onoff forKey:XYappopentaobao_onoff];
        [[NSUserDefaults standardUserDefaults] setValue:model.WeChatAppSecret forKey:XYWeChatAppSecret];
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache: NO];
}

-(void)goToFNMCAgentApplyController{
    [FNRequestTool startWithRequests:@[[self reqeustBaseSetting]] withFinishedBlock:^(NSArray *erros) {
        FNMCAgentApplyController* apply = [FNMCAgentApplyController new];
        apply.title = @"申请代理";
        apply.agentType = MCAgentTypeAppliedSuccess;
        [self.navigationController pushViewController:apply animated:YES];
        [SVProgressHUD dismiss];
    }];
}

-(void)setData{
    self.TopView.Model=self.Model;
    
    [self.BottomImageView setNoPlaceholderUrlImg:self.Model.ruleImg];
    
    self.ruleLabel.text=self.Model.rule;
    ruleLabelHeight=[self calculateRowHeight:self.ruleLabel.text width:JMScreenWidth-30 fontSize:15];
    
    [self.MidImageView sd_setImageWithURL:URL(self.Model.tqImg) placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType == SDImageCacheTypeNone || cacheType == SDImageCacheTypeDisk) {
            self.MidImageView.image = image;
            self.MidImageView.alpha = 0;
            [UIView animateWithDuration:1 animations:^{
                self.MidImageView.alpha = 1.f;
            }];
        } else {
            self.MidImageView.image = image;
            self.MidImageView.alpha = 1.f;
        }
        
        MidImageViewHeight=image.size.height/image.size.width*JMScreenWidth;
        [self.MidImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(MidImageViewHeight));
        }];
        self.bgView.contentSize = CGSizeMake(JMScreenWidth, XYNavBarHeigth+TopViewHeight+MidImageViewHeight+ruleLabelHeight+100);
        self.bgView.hidden=NO;
    }];
}

/*计算高度*/
- (CGFloat)calculateRowHeight:(NSString *)string width:(CGFloat)width fontSize:(NSInteger)fontSize{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};//指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.height;
}

// 微信事件
- (void)onWxSuccess {
    [self goToFNMCAgentApplyController];
}

@end

