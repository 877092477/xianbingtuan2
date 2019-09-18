//
//  FNMCAgentApplyController.m
//  THB
//
//  Created by jimmy on 2017/7/27.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNMCAgentApplyController.h"
#import "SDCycleScrollView.h"
#import "FNCustomeTextView.h"
#import "FNHLFPayView.h"
#import "FNMCAgentApplyShowModel.h"
#import <AlipaySDK/AlipaySDK.h>
#import "FNMCAgentListView.h"
#import "FNPopUpTool.h"
@interface FNMCAgentApplyController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView* mainView;

@property (nonatomic, strong)SDCycleScrollView* bannerView;

@property (nonatomic, strong)FNCustomeTextView* textView;

@property (nonatomic, strong) UITextField* nametextfield;

@property (nonatomic, strong) UITextField* phoentextfield;

@property (nonatomic, strong) UIView* resultView;
@property (nonatomic, strong)UILabel* titlelabel;
@property (nonatomic, strong) UILabel* subLabel;
@property (nonatomic, strong) UIImageView* staustIconImgView;

@property (nonatomic, strong)FNMCAgentApplyShowModel* showModel;

@property (nonatomic, strong)UIView* contentView;
@property (nonatomic, strong)UIView* topview;
@property (nonatomic, strong)UILabel* top_title_label;
@property (nonatomic, strong)UILabel* top_tilte_enlabel;

@property (nonatomic, strong)UIImageView* ruleImgView;
@property (nonatomic, strong)NSLayoutConstraint* ruleimgConsH;
@property (nonatomic, strong)UILabel* aliasLabel;
@property (nonatomic, strong)UILabel* needKnowLabel;
@property (nonatomic, strong)UILabel* ruleLabel;

@property (nonatomic, weak)UIButton* updateBtn;
@property (nonatomic, strong)FNMCAgentListView* listview;

@property (nonatomic, strong)NSArray* subtexts;

@property (nonatomic, strong)NSArray* images;


@end

@implementation FNMCAgentApplyController
- (void)setIsNotHome:(BOOL)isNotHome{
    [super setIsNotHome:isNotHome];
    if (self.isNotHome) {
        self.btmcons.constant = 0;
    }else{
        self.btmcons.constant = XYTabBarHeight;
    }
    [self.view layoutIfNeeded];
}
- (NSArray *)subtexts{
    if (_subtexts == nil) {
        _subtexts = @[@"请您耐心等待，1-7个工作日将会给您答复。",@"请您耐心等待，1-7个工作日将会给您答复。",@"抱歉，您的信息错误，请再次尝试",@""];
    }
    return _subtexts;
}
- (NSArray *)images{
    if (_images == nil) {
        _images  = @[@"apply_time",@"real_complete",@"apply_fail",@"apply_fail"];
    }
    return _images;
}
- (FNMCAgentListView *)listview{
    if (_listview == nil) {
        _listview = [[FNMCAgentListView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 0))];
        _listview.backgroundColor = FNWhiteColor;
        @WeakObj(self);
        _listview.updateBtnBlock = ^(NSInteger index) {
            //
            if (index<=selfWeak.showModel.dl_list.count-1) {
                [SVProgressHUD show];
                [selfWeak apiRequestApply:selfWeak.showModel.dl_list[index].ID];
                [FNPopUpTool hiddenAnimated:YES];
            }
        };
    }
    return _listview;
}
- (UILabel *)top_tilte_enlabel{
    if (_top_tilte_enlabel == nil) {
        _top_tilte_enlabel = [UILabel new];
        _top_tilte_enlabel.font = kFONT14;
        _top_tilte_enlabel.text = @"PRIVILEGES";
        _top_tilte_enlabel.textColor = FNWhiteColor;
        _top_tilte_enlabel.textAlignment = NSTextAlignmentCenter;
    }
    return _top_tilte_enlabel;
}
- (UILabel *)top_title_label{
    if (_top_title_label == nil) {
        _top_title_label = [UILabel new];
        _top_title_label.font = [UIFont boldSystemFontOfSize:15];
        _top_title_label.textColor = FNWhiteColor;
        _top_title_label.text = [NSString stringWithFormat:@"%@会员特权",[FNBaseSettingModel settingInstance].AppDisplayName];
        _top_title_label.textAlignment = NSTextAlignmentCenter;
    }
    return _top_title_label;
}
- (UIView *)topview{
    if (_topview == nil) {
        _topview = [UIView new];
        [_topview addSubview:self.top_title_label];
        [self.top_title_label autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_margin10];
        [self.top_title_label autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_margin10];
        [self.top_title_label autoConstrainAttribute:ALEdgeBottom toAttribute:ALAxisHorizontal ofView:_topview withOffset:-5];
        
        [_topview addSubview:self.top_tilte_enlabel];
        [self.top_tilte_enlabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_margin10];
        [self.top_tilte_enlabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_margin10];
        [self.top_tilte_enlabel autoConstrainAttribute:ALEdgeTop toAttribute:ALAxisHorizontal ofView:_topview withOffset:5];
        
    }
    return _topview;
}
- (UIImageView *)ruleImgView{
    if (_ruleImgView == nil) {
        _ruleImgView = [UIImageView new];
    }
    return _ruleImgView;
}
- (UILabel *)aliasLabel{
    if (_aliasLabel == nil) {
        _aliasLabel = [UILabel new];
        _aliasLabel.font = kFONT10;
        _aliasLabel.textColor = FNWhiteColor;
        _aliasLabel.textAlignment = NSTextAlignmentRight;
    }
    return _aliasLabel;
}

- (UILabel *)needKnowLabel{
    if (_needKnowLabel == nil) {
        _needKnowLabel = [UILabel new];
        _needKnowLabel.font = kFONT14;
        _needKnowLabel.textColor = FNWhiteColor;
        _needKnowLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _needKnowLabel;
}
- (UILabel *)ruleLabel{
    if (_ruleLabel == nil) {
        _ruleLabel = [UILabel new];
        _ruleLabel.font = kFONT12;
        _ruleLabel.textColor = FNWhiteColor;
        _ruleLabel.numberOfLines = 0;
        _ruleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _ruleLabel;
}
- (UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [UIView new];
        _contentView.backgroundColor = RGB(249, 106, 126);
        
        [_contentView addSubview:self.topview];
        [_topview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
        [_topview autoSetDimension:(ALDimensionHeight) toSize:64];
        
        [_contentView addSubview:self.ruleImgView];
        [self.ruleImgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [self.ruleImgView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        [self.ruleImgView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.topview];
        self.ruleimgConsH = [self.ruleImgView autoSetDimension:(ALDimensionHeight) toSize:0];
        
        [_contentView addSubview:self.aliasLabel];
        [self.aliasLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:5];
        [self.aliasLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_margin10];
        [self.aliasLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.ruleImgView withOffset:_jm_margin10];
        
        [_contentView addSubview:self.needKnowLabel];
        [self.needKnowLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_margin10];
        [self.needKnowLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_margin10];
        [self.needKnowLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.aliasLabel withOffset:_jm_leftMargin*2];
        
        [_contentView addSubview:self.ruleLabel];
        [self.ruleLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.needKnowLabel withOffset:_jm_margin10];
        [self.ruleLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self.needKnowLabel];
           [self.ruleLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.needKnowLabel];
        
        UIButton* updateBtn = [UIButton buttonWithTitle:@"升级" titleColor:FNWhiteColor font:[UIFont boldSystemFontOfSize:14] target:self action:@selector(updatebtnAction)];
        updateBtn.backgroundColor = RGB(215, 40, 85);
        [_contentView addSubview:updateBtn];
        [updateBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [updateBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        [updateBtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.ruleLabel withOffset:_jm_leftMargin*2];
        [updateBtn autoSetDimension:(ALDimensionHeight) toSize:44];
        _updateBtn = updateBtn;
    }
    return _contentView;
}

- (void)setShowModel:(FNMCAgentApplyShowModel *)showModel{
    _showModel = showModel;
    if (_showModel) {
        if (_showModel.dl_bjt) {
            _bannerView.imageURLStringsGroup = @[_showModel.dl_bjt];
            _bannerView.autoScroll = NO;
        }
        self.aliasLabel.text = self.showModel.zhushi;
        self.needKnowLabel.text = self.showModel.dl_hy_title;
        self.ruleLabel.text = self.showModel.dl_hy_xz;
        [self.ruleImgView sd_setImageWithURL:URL(self.showModel.dl_zdjs) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                CGFloat rate = image.size.height/image.size.width;
                self.ruleimgConsH.constant  = rate*FNDeviceWidth;
                [self.contentView layoutIfNeeded];
//                self.mainView.contentSize = CGSizeMake(self.mainView.contentSize.width, self.mainView.height+self.ruleimgConsH.constant);
                [self.mainView layoutIfNeeded];
            }
        }];
        if (self.showModel.dl_list.count>=1) {
            NSMutableArray* titles = [NSMutableArray new];
            [self.showModel.dl_list enumerateObjectsUsingBlock:^(FNAgentListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [titles addObject:obj.title];
            }];
            self.listview.list = titles;
        }
        
        
    }
}
- (void)updatebtnAction{
    [FNPopUpTool showViewWithContentView:self.listview withDirection:(FMPopupAnimationDirectionBottom) finished:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupviews];
    
    
    if (self.agentType == MCAgentTypeNone) {
        [self apiRequestApplyShow];
        [UIView animateWithDuration:0.3 animations:^{
            _mainView.alpha = 1.0;
        }];
    }else{
        [self setupResultview];
        [UIView animateWithDuration:0.3 animations:^{
            _resultView.alpha = 1.0;
        }];
        if (self.agentType == MCAgentTypeAppliedSuccess) {
            UIBarButtonItem *backToLastPage = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnAction)];
            self.navigationItem.leftBarButtonItem = backToLastPage;
        }
    }
    
    
    
}
- (void)backBtnAction{
    NSInteger num = self.navigationController.viewControllers.count;
    if (num >= 3) {
        UIViewController *popVC =    self.navigationController.viewControllers[num - 3];
        [self.navigationController popToViewController:popVC animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (CGRectGetMaxY(_contentView.frame) +10> FNDeviceHeight-64) {
        _mainView.contentSize = CGSizeMake(FNDeviceWidth, CGRectGetMaxY(_contentView.frame) );
    }
}
#pragma mark - api request
- (void)apiRequestApplyShow{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    [FNRequestTool requestWithParams:params api:@"mod=new_share&act=agency&ctrl=index" respondType:(ResponseTypeModel) modelType:@"FNMCAgentApplyShowModel" success:^(id respondsObject) {
        //
        selfWeak.showModel = respondsObject;
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
- (void)apiRequestApply:(id)type{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"id":type}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dg_payment&ctrl=payment_dl" respondType:(ResponseTypeNone) modelType:nil success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        BOOL __block isFree = NO;
        NSString* code = respondsObject[DataKey][@"code"];
        if (code &&[code containsString:@"免费"]) {
            isFree = YES;
        }
        if (isFree) {
            FNMCAgentApplyController* apply = [FNMCAgentApplyController new];
            apply.title = @"申请代理";
            apply.agentType = MCAgentTypeAppliedSuccess;
            [selfWeak.navigationController pushViewController:apply animated:YES];
        }else{
            [[AlipaySDK defaultService] payOrder:respondsObject[DataKey][@"code"] fromScheme:AlisdkSchemes callback:^(NSDictionary *resultDic) {
                if ([NSString checkIsSuccess:resultDic[@"resultStatus"] andElement:@"9000"] ) {
                    [FNTipsView showTips:ResultStatusDict[@"9000"]];
                    FNMCAgentApplyController* apply = [FNMCAgentApplyController new];
                    apply.title = @"申请代理";
                    apply.agentType = MCAgentTypeAppliedSuccess;
                    [selfWeak.navigationController pushViewController:apply animated:YES];
                }else{
                    [FNTipsView showTips:ResultStatusDict[resultDic[@"resultStatus"] ] withDuration:2.0];
                }
                
            }];
        }
        

    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
#pragma mark - initializedSubviews
- (void)setupviews
{
    _mainView = [UIScrollView new];
    _mainView.backgroundColor = [FNHomeBackgroundColor colorWithAlphaComponent:0.8];
    _mainView.delegate = self;
    _mainView.alpha = 0.0;
    [self.view addSubview:_mainView];
    [_mainView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    self.btmcons = [self.mainView autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:self.isNotHome?0:XYTabBarHeight];
    
    _bannerView = [[SDCycleScrollView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 0))];
    [_mainView addSubview:_bannerView];
    [_bannerView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
    [_bannerView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [_bannerView autoSetDimensionsToSize:(CGSizeMake(FNDeviceWidth, 0.35*FNDeviceWidth))];
    
    CGFloat leftmargin = 10;
    CGFloat texth = 0.53*(FNDeviceWidth-leftmargin*2);
//    _textView = [[FNCustomeTextView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, texth))];
//    _textView.placeholder = @"请描述一下您的申请代理的意向";
//    _textView.placeHolderLabel.font = kFONT14;
//    _textView.backgroundColor = FNWhiteColor;
//    _textView.placeHolderLabel.textColor = FNGlobalTextGrayColor;
//    _textView.cornerRadius = 5;
//    _textView.borderColor = FNHomeBackgroundColor;
//    _textView.borderWidth = 1.0;
//    [_mainView addSubview:_textView];
//    [_textView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:leftmargin];
//    [_textView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_bannerView withOffset:_jm_leftMargin];
//    [_textView autoSetDimensionsToSize:(CGSizeMake(FNDeviceWidth-leftmargin*2, texth))];
//    
//    CGFloat textFieldH = 40;
//    _nametextfield = [[UITextField alloc]init];
//    _nametextfield.placeholder = @"请填写您的名字";
//    _nametextfield.borderStyle = UITextBorderStyleRoundedRect;
//    [_mainView addSubview:_nametextfield];
//    [_nametextfield autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:leftmargin];
//    [_nametextfield autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_textView withOffset:_jm_leftMargin];
//    [_nametextfield autoSetDimensionsToSize:(CGSizeMake(FNDeviceWidth-leftmargin*2, textFieldH))];
//    
//    _phoentextfield = [[UITextField alloc]init];
//    _phoentextfield.placeholder = @"请填写您的手机号";
//    _phoentextfield.keyboardType = UIKeyboardTypePhonePad;
//    _phoentextfield.borderStyle = UITextBorderStyleRoundedRect;
//    [_mainView addSubview:_phoentextfield];
//    [_phoentextfield autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:leftmargin];
//    [_phoentextfield autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_nametextfield withOffset:_jm_leftMargin];
//    [_phoentextfield autoSetDimensionsToSize:(CGSizeMake(FNDeviceWidth-leftmargin*2, textFieldH))];
//    
//    UIButton* ruleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [ruleBtn setImage:IMAGE(@"apply_warn") forState:(UIControlStateNormal)];
//    [ruleBtn setTitle:@"成为代理必看" forState:(UIControlStateNormal)];
//    [ruleBtn setTitleColor:FNMainGobalTextColor forState:(UIControlStateNormal)];
//    [ruleBtn.titleLabel addSingleAttributed:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)} ofRange:NSMakeRange(0, ruleBtn.currentTitle.length)];
//    ruleBtn.titleLabel.font = kFONT14;
//    [ruleBtn sizeToFit];
//    [ruleBtn addTarget:self action:@selector(becomeAgentProxy) forControlEvents:UIControlEventTouchUpInside];
//    [_mainView addSubview:ruleBtn];
//    [ruleBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:leftmargin];
//    [ruleBtn autoSetDimensionsToSize:ruleBtn.size];
//    [ruleBtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_phoentextfield withOffset:_jm_leftMargin];
//    
//    UIButton* submitBtn = [UIButton buttonWithTitle:@"提交付费" titleColor:FNWhiteColor font:kFONT14 target:self action:@selector(submitBtnAction)];
//    submitBtn.backgroundColor = FNMainGobalTextColor;
//    submitBtn.cornerRadius = 5;
//    [_mainView addSubview:submitBtn];
//    [submitBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:leftmargin];
//    [submitBtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:ruleBtn withOffset:_jm_leftMargin];
//    [submitBtn autoSetDimensionsToSize:(CGSizeMake(FNDeviceWidth-leftmargin*2, 40))];
    
    [self.mainView addSubview:self.contentView];
    [self.contentView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.bannerView];
    [self.contentView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.contentView autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self.bannerView];
    
    [self.contentView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.updateBtn];
    
    [self.mainView layoutIfNeeded];
    if (CGRectGetMaxY(_contentView.frame) +leftmargin> FNDeviceHeight-64) {
        _mainView.contentSize = CGSizeMake(FNDeviceWidth, CGRectGetMaxY(_contentView.frame) );
    }
}

- (void)setupResultview{
    NSArray* images = @[@"apply_time",@"real_complete",@"apply_fail"];
    NSArray* des = @[@"正在审核中.....",[NSString stringWithFormat:@"%@申请发送成功！",[FNBaseSettingModel settingInstance].agent_name_str],@"审核失败！",@"apply_fail"];

    _resultView = [UIView new];
    _resultView.alpha = 0;
    [self.view addSubview:_resultView];
    [_resultView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
    UIButton* confirmbtn = [UIButton buttonWithTitle:@"确定" titleColor:FNWhiteColor font:kFONT14 target:self action:@selector(confirmBtnAction)];
    confirmbtn.cornerRadius = 5;
    confirmbtn.backgroundColor = FNMainGobalControlsColor;
    [_resultView addSubview:confirmbtn];
    [confirmbtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_margin10];
    [confirmbtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_margin10];
    [confirmbtn autoConstrainAttribute:ALEdgeTop toAttribute:ALAxisHorizontal ofView:_resultView];
    [confirmbtn autoSetDimension:(ALDimensionHeight) toSize:50];
    
    _subLabel  = [UILabel new];
    _subLabel.font = kFONT14;
    _subLabel.text = self.subtexts[self.agentType];
    _subLabel.textColor = FNGlobalTextGrayColor;
    _subLabel.textAlignment = NSTextAlignmentCenter;
    [_resultView addSubview:_subLabel];
    [_subLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_margin10];
    [_subLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_margin10];
    [_subLabel autoConstrainAttribute:ALEdgeBottom toAttribute:ALAxisHorizontal ofView:_resultView withOffset:-30];
    
    _titlelabel  = [UILabel new];
    _titlelabel.font = [UIFont boldSystemFontOfSize:25];
    _titlelabel.text = des[self.agentType];
    _titlelabel.textAlignment = NSTextAlignmentCenter;
    [_resultView addSubview:_titlelabel];
    [_titlelabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_margin10];
    [_titlelabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_margin10];
    [_titlelabel autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:_subLabel withOffset: -_jm_leftMargin];
    
    _staustIconImgView = [UIImageView new];
    _staustIconImgView.image = IMAGE(images[self.agentType]);
    [_staustIconImgView sizeToFit];
    _staustIconImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.resultView addSubview:_staustIconImgView];
    [_staustIconImgView autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    [_staustIconImgView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:_titlelabel withOffset:-_jm_leftMargin*2];
    [_staustIconImgView autoSetDimensionsToSize:_staustIconImgView.size];
    
    
    
    
}
- (void)submitBtnAction{
    [self.view endEditing:YES];
    if (![self.textView.textView.text kr_isNotEmpty]) {
        [FNTipsView showTips:self.textView.placeholder];
        return;
    }
    if (![self.nametextfield.text kr_isNotEmpty]) {
        [FNTipsView showTips:self.nametextfield.placeholder];
        return;
    }
    if (![self.phoentextfield.text kr_isNotEmpty]) {
        [FNTipsView showTips:self.phoentextfield.placeholder];
        return;
    }
    @WeakObj(self);
    FNHLFPayView *pay = [[FNHLFPayView alloc]initWithFrame:CGRectZero];
    pay.name = @"共计";
    pay.mvalue = self.showModel.dl_price;
    pay.balance = @"3344";
    [pay showWihtBlock:^(NSInteger index) {
//        selfWeak.payType =selfWeak.model.zftype[index].type;
        
//        [selfWeak apiRequestPay];
//        [selfWeak apiRequestApply:selfWeak.showModel.zfArr[index].type];
    }];
    
}
- (void)confirmBtnAction{
    [self.view endEditing:YES];
    if (self.agentType == MCAgentTypeAppliedSuccess) {
        NSInteger num = self.navigationController.viewControllers.count;
        if (num >= 3) {
            UIViewController *popVC =    self.navigationController.viewControllers[num - 3];
            [self.navigationController popToViewController:popVC animated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)becomeAgentProxy{
    [self.view endEditing:YES];
    if (self.showModel) {
        [self goWebWithUrl:self.showModel.dl_url];
    }
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self.view endEditing:YES];
//}
@end
