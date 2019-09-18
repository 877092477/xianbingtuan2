//
//  FNPasteSearchAlertView.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/26.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNPasteSearchAlertView.h"
#import "FNNewProductDetailModel.h"

#import "UIButton+WebCache.h"
#import <POP.h>


@interface FNPasteSearchAlertView ()

@property (nonatomic, strong) UIButton*    closedBtn;
@property (nonatomic, strong) UIView*      BgView;
@property (nonatomic, strong) UIImageView* ImageView;
@property (nonatomic, strong) UILabel*     commodityName;
@property (nonatomic, strong) UIButton*    searchBtn;

@property (nonatomic, strong) UIButton*    seekTBBtn;
@property (nonatomic, strong) UIButton*    seekPDDBtn;
@property (nonatomic, strong) UIButton*    seekJDBtn;
@property (nonatomic, strong) UIButton*    seekWPHBtn;

@end

@implementation FNPasteSearchAlertView


FNPasteSearchAlertView *_SearchAlertView = nil;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [FNBlackColor colorWithAlphaComponent:0.3];
        [self jm_setupViews];
    }
    return self;
}
+ (instancetype)shareInstance{
    if (_SearchAlertView == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _SearchAlertView = [[FNPasteSearchAlertView alloc]initWithFrame:FNKeyWindow.bounds];
        });
    }
    return _SearchAlertView;
}
#pragma mark - initializedSubviews
- (void)jm_setupViews{
    
    _BgView=[UIView new];
    _BgView.backgroundColor=[UIColor whiteColor];
    _BgView.cornerRadius=10;
    [self addSubview:_BgView];
    
    _ImageView = [UIImageView new];
    [_BgView addSubview:_ImageView];
    
    _commodityName=[UILabel new];
    _commodityName.numberOfLines=2;
    _commodityName.textAlignment=NSTextAlignmentCenter;
    _commodityName.font=kFONT12;
    [_BgView addSubview:_commodityName];
    
    _searchBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    _searchBtn.cornerRadius=10;
    _searchBtn.titleLabel.font=kFONT13;
    [_searchBtn setTitle:@"" forState:UIControlStateNormal];
    [_searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_searchBtn addTarget:self action:@selector(storeSearchAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_BgView addSubview:_searchBtn];
    
    UILabel*lineLeft=[UILabel new];
    lineLeft.backgroundColor = RGB(148, 148, 148);
    [_BgView addSubview:lineLeft];
    
    UILabel*restLB=[UILabel new];
    restLB.textAlignment=NSTextAlignmentCenter;
    restLB.font=[UIFont systemFontOfSize:9];
    restLB.textColor = RGB(148, 148, 148);
    restLB.text=@"搜索平台";
    [_BgView addSubview:restLB];
    
    UILabel*lineRight=[UILabel new];
    lineRight.backgroundColor = RGB(148, 148, 148);
    [_BgView addSubview:lineRight];
    
    _closedBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_closedBtn setImage:IMAGE(@"odds_close") forState:UIControlStateNormal];
    [_closedBtn sizeToFit];
    [_closedBtn addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_closedBtn];
    
    [_BgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(@(60));
        make.right.equalTo(@(-60));
        make.height.equalTo(self.ImageView).offset(180);
    }];
    
    [_ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(self.ImageView.mas_width).dividedBy(1.4);
    }];
    
    [_commodityName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ImageView.mas_bottom).offset(10);
        make.left.equalTo(_BgView.mas_left).offset(20);
        make.right.equalTo(_BgView.mas_right).offset(-20);
//        make.height.equalTo(@50);
    }];
    [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commodityName.mas_bottom).offset(10);
        make.left.equalTo(_BgView.mas_left).offset(48);
        make.right.equalTo(_BgView.mas_right).offset(-48);
        make.height.mas_equalTo(22);
    }];
    [restLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_BgView.mas_centerX);
        make.top.equalTo(_searchBtn.mas_bottom).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@60);
    }];
    [lineLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(restLB.mas_centerY);
        make.right.equalTo(restLB.mas_left).offset(-10);
        make.height.equalTo(@1);
        make.width.equalTo(@60);
    }];
    
    [lineRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(restLB.mas_centerY);
        make.left.equalTo(restLB.mas_right).offset(10);
        make.height.equalTo(@1);
        make.width.equalTo(@60);
    }];
    
    [_closedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_BgView.mas_top).offset(-50);
        make.right.equalTo(_BgView.mas_right).offset(20);
    }];
    
    _seekTBBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _seekTBBtn.tag=1;
    _seekTBBtn.titleLabel.font=kFONT12;
    _seekTBBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [_seekTBBtn setImage:IMAGE(@"title_pdd") forState:UIControlStateNormal];
    [_seekTBBtn setTitle:@"淘宝" forState:UIControlStateNormal];
    [_seekTBBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_seekTBBtn addTarget:self action:@selector(storeTBAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_BgView addSubview:_seekTBBtn];
    [_seekTBBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:4];
    
    _seekPDDBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _seekPDDBtn.tag=2;
    _seekPDDBtn.titleLabel.font=kFONT12;
    _seekPDDBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [_seekPDDBtn setImage:IMAGE(@"title_pdd") forState:UIControlStateNormal];
    [_seekPDDBtn setTitle:@"拼多多" forState:UIControlStateNormal];
    [_seekPDDBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_seekPDDBtn addTarget:self action:@selector(storePddAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_seekPDDBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:4];
    
    _seekJDBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _seekJDBtn.tag=3;
    _seekJDBtn.titleLabel.font=kFONT12;
    _seekJDBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [_seekJDBtn setImage:IMAGE(@"title_jd") forState:UIControlStateNormal];
    [_seekJDBtn setTitle:@"京东" forState:UIControlStateNormal];
    [_seekJDBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_seekJDBtn addTarget:self action:@selector(storeJDAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_seekJDBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:4];
    
    _seekWPHBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _seekWPHBtn.tag=4;
    _seekWPHBtn.titleLabel.font=kFONT12;
    _seekWPHBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [_seekWPHBtn setImage:IMAGE(@"title_jd") forState:UIControlStateNormal];
    [_seekWPHBtn setTitle:@"唯品会" forState:UIControlStateNormal];
    [_seekWPHBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_seekWPHBtn addTarget:self action:@selector(storeWPHAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_seekWPHBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:4];
    
    XYLog(@"buy_jingdong_onoff:%@",[FNBaseSettingModel settingInstance].buy_jingdong_onoff);
    XYLog(@"buy_pinduoduo_onoff:%@",[FNBaseSettingModel settingInstance].buy_pinduoduo_onoff);
    NSMutableArray <UIButton*> *array = [[NSMutableArray alloc] init];
    [array addObject: _seekTBBtn];
    if ([[FNBaseSettingModel settingInstance].buy_pinduoduo_onoff isEqualToString:@"1"]) {
        [array addObject: _seekPDDBtn];
        [_BgView addSubview:_seekPDDBtn];
    }
    if ([[FNBaseSettingModel settingInstance].buy_jingdong_onoff isEqualToString:@"1"]) {
        [array addObject: _seekJDBtn];
        [_BgView addSubview:_seekJDBtn];
    }
    if ([[FNBaseSettingModel settingInstance].pub_wph_goods_onoff isEqualToString:@"1"]) {
        [array addObject: _seekWPHBtn];
        [_BgView addSubview:_seekWPHBtn];
    }
    
    for (NSInteger index = 0; index < array.count; index ++) {
        UIButton *button = array[index];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (index == 0) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(array[index - 1].mas_right).equalTo(@0);
                make.width.equalTo(array[index - 1]);
            }
            if (index == array.count - 1) {
                make.right.equalTo(@0);
            }
//            make.width.mas_equalTo(50);
            make.height.mas_equalTo(60);
            make.top.equalTo(lineLeft.mas_bottom).offset(10);
        }];
        
        button.imageView.sd_layout.topSpaceToView(button, 10).centerXEqualToView(button).widthIs(34).heightIs(34);
        button.titleLabel.sd_layout.leftSpaceToView(button, 0).topSpaceToView(button.imageView, 5).heightIs(15).rightSpaceToView(button, 0);
    }
    [array removeAllObjects];
    
    NSString *BgImageString=[FNBaseSettingModel settingInstance].apptip_search_img;
    NSString *taobaoImageString=[FNBaseSettingModel settingInstance].apptip_taobao_img;
    NSString *pddImageString=[FNBaseSettingModel settingInstance].apptip_pdd_img;
    NSString *JDImageString=[FNBaseSettingModel settingInstance].apptip_jd_img;
    NSString *TBImageString=[FNBaseSettingModel settingInstance].apptip_tb_ico;
    NSString *WPHImageString=[FNBaseSettingModel settingInstance].apptip_wph_img;
    [_ImageView setUrlImg:BgImageString];
    [_searchBtn sd_setBackgroundImageWithURL:URL(taobaoImageString) forState:UIControlStateNormal];
    
    
//    _seekPDDBtn.imageView.sd_layout.topSpaceToView(_seekPDDBtn, 10).centerXEqualToView(_seekPDDBtn).widthIs(34).heightIs(34);
//    _seekPDDBtn.titleLabel.sd_layout.leftSpaceToView(_seekPDDBtn, 0).topSpaceToView(_seekPDDBtn.imageView, 5).heightIs(15).rightSpaceToView(_seekPDDBtn, 0);
//
//    _seekJDBtn.imageView.sd_layout.topSpaceToView(_seekJDBtn, 10).centerXEqualToView(_seekJDBtn).widthIs(34).heightIs(34);
//    _seekJDBtn.titleLabel.sd_layout.leftSpaceToView(_seekJDBtn, 0).topSpaceToView(_seekJDBtn.imageView, 5).heightIs(15).rightSpaceToView(_seekJDBtn, 0);
//
//    _seekTBBtn.imageView.sd_layout.topSpaceToView(_seekTBBtn, 10).centerXEqualToView(_seekTBBtn).widthIs(34).heightIs(34);
//    _seekTBBtn.titleLabel.sd_layout.leftSpaceToView(_seekTBBtn, 0).topSpaceToView(_seekTBBtn.imageView, 5).heightIs(15).rightSpaceToView(_seekTBBtn, 0);
    
    [_seekPDDBtn sd_setImageWithURL:URL(pddImageString) forState:UIControlStateNormal];
    [_seekJDBtn sd_setImageWithURL:URL(JDImageString) forState:UIControlStateNormal];
    [_seekTBBtn sd_setImageWithURL:URL(TBImageString) forState:UIControlStateNormal];
    [_seekWPHBtn sd_setImageWithURL:URL(WPHImageString) forState:UIControlStateNormal];
    
}
- (void)setPrasestring:(NSString *)prasestring{
    _prasestring = prasestring;
    if ([prasestring kr_isNotEmpty]){
        _commodityName.text = _prasestring;
    }else{
        _commodityName.text=@"";
    }
    
}
-(void)setFnIDstring:(NSString *)fnIDstring{
    _fnIDstring=fnIDstring;
    
//    [_searchBtn setTitle:@"去详情" forState:UIControlStateNormal];
    _searchBtn.hidden = ![fnIDstring kr_isNotEmpty];
}
-(void)storeSearchAction{
    NSString *content=@"";
    if([_prasestring kr_isNotEmpty]){
        content=_prasestring;
    }
    if (self.storeTypeBlock) {
        self.storeTypeBlock(Detail, content,_model);
    }
    [self dismiss];
}
-(void)storeTBAction{
    NSString *content=@"";
    if([_prasestring kr_isNotEmpty]){
        content=_prasestring;
    }
    if (self.storeTypeBlock) {
        self.storeTypeBlock(TaoBao, content,_model);
    }
    [self dismiss];
}
-(void)storePddAction{
    NSString *content=@"";
    if([_prasestring kr_isNotEmpty]){
        content=_prasestring;
    }
    if (self.storeTypeBlock) {
        self.storeTypeBlock(PDD, content,_model);
    }
    [self dismiss];
}
-(void)storeJDAction{
    NSString *content=@"";
    if([_prasestring kr_isNotEmpty]){
        content=_prasestring;
    }
    if (self.storeTypeBlock) {
        self.storeTypeBlock(JD, content,_model);
    }
    [self dismiss];
}

-(void)storeWPHAction{
    NSString *content=@"";
    if([_prasestring kr_isNotEmpty]){
        content=_prasestring;
    }
    if (self.storeTypeBlock) {
        self.storeTypeBlock(WPH, content,_model);
    }
    [self dismiss];
}
- (void)showAnimation{
    _SearchAlertView.BgView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.25f animations:^{
        _SearchAlertView.BgView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)dismiss{
    
    [UIView animateWithDuration:0.25f animations:^{
        _SearchAlertView.BgView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

+ (void)showWithModel:(id)model view:(UIView *)view storeTypeblock:(StoreTypeBlock)Typeblock{
    _SearchAlertView = [FNPasteSearchAlertView shareInstance];
    //    _SearchAlertView.storeTypeBlock=Typeblock;
    _SearchAlertView.prasestring=model;
    [view addSubview:_SearchAlertView];
    [_SearchAlertView showAnimation];
}
+ (void)showWithContent:(NSString*)content view:(UIView *)view withfnID:(NSString*)fuID type: (FNIntelligentSearchType)type yhq_url: (NSString*)yhq_url storeTypeblock:(StoreTypeBlock)Typeblock{
    
    if (fuID == nil || [fuID isEqualToString:@""]) {
        _SearchAlertView = [FNPasteSearchAlertView shareInstance];
        _SearchAlertView.storeTypeBlock=Typeblock;
        _SearchAlertView.prasestring=content;
        _SearchAlertView.fnIDstring = @"";
        _SearchAlertView.model=nil;
        [view addSubview:_SearchAlertView];
        [_SearchAlertView showAnimation];
        return;
    }
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    NSString *APIUrl=@"mod=appapi&act=newgoods_detail&ctrl=index";
    if (type == PDD) {
        APIUrl=@"mod=appapi&act=appPddGoodsDetail&ctrl=pddIndex";
    }else if (type == JD){
        APIUrl=@"mod=appapi&act=appJdGoodsDetail&ctrl=jdIndex";
        params[@"yhq_url"] = yhq_url;
    } else if (type == WPH) {
        APIUrl=@"mod=appapi&act=wph_detail&ctrl=index";
    }
    params[@"fnuo_id"] = fuID;
    
    [FNRequestTool requestWithParams:params api:APIUrl respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        FNNewProductDetailModel *model = [FNNewProductDetailModel mj_objectWithKeyValues:respondsObject];
        model.data = respondsObject;
        
        _SearchAlertView = [FNPasteSearchAlertView shareInstance];
        _SearchAlertView.storeTypeBlock=Typeblock;
        _SearchAlertView.fnIDstring=@"";
        _SearchAlertView.prasestring=content;
        _SearchAlertView.model=nil;
        if ([model.goods_title kr_isNotEmpty])
            _SearchAlertView.prasestring=model.goods_title;
        if ([model.goods_title kr_isNotEmpty]) {
            _SearchAlertView.fnIDstring=fuID;
            _SearchAlertView.model=model;
        }
        
        [view addSubview:_SearchAlertView];
        [_SearchAlertView showAnimation];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

+ (void)dismiss {
    [[FNPasteSearchAlertView shareInstance] removeFromSuperview];
}

@end

