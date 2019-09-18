//
//  FNDouQuanView.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNDouQuanView.h"
#import "Lottie/Lottie.h"

@interface FNDouQuanButton : UIButton

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *label;


@end

@implementation FNDouQuanButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _image = [[UIImageView alloc] init];
        _label = [[UILabel alloc] init];
        
        [self addSubview:_image];
        [self addSubview:_label];
        
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.greaterThanOrEqualTo(@0);
            make.right.lessThanOrEqualTo(@0);
            make.centerX.equalTo(@0);
        }];
        
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.greaterThanOrEqualTo(@0);
            make.right.bottom.lessThanOrEqualTo(@0);
            make.top.equalTo(self.image.mas_bottom).offset(10);
            make.height.mas_equalTo(14);
            make.centerX.equalTo(@0);
        }];
        
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = kFONT12;
        _label.textColor = UIColor.whiteColor;
    }
    return self;
}

@end

@interface FNDouQuanView()

@property (nonatomic, strong) FNDouQuanModel *model;

@property (nonatomic, strong) UIImageView *imgBackground;

@property (nonatomic, strong) UIImageView *imgPrice;
@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UIImageView *imgQuan1;
@property (nonatomic, strong) UIImageView *imgQuan2;
@property (nonatomic, strong) UILabel *lblQuan;

@property (nonatomic, strong) UILabel *lblDesc;

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblCount;

@property (nonatomic, strong) FNDouQuanButton *btnBuy;
@property (nonatomic, strong) FNDouQuanButton *btnCollection;
@property (nonatomic, strong) LOTAnimationView *collectionShowView;
@property (nonatomic, strong) LOTAnimationView *collectionDismissView;
@property (nonatomic, strong) FNDouQuanButton *btnShare;
@property (nonatomic, strong) FNDouQuanButton *btnDownload;

@property (nonatomic, strong)UIImageView *shareImage;
@property (nonatomic, strong)UIImageView *supgradeImage;
//分享
@property (nonatomic, strong)UILabel *shareAddLb;
//升级
@property (nonatomic, strong)UILabel *supgradeAddLb;
//分享View
@property (nonatomic, strong)UIImageView *shareView;
//升级View
@property (nonatomic, strong)UIImageView *supgradeView;

@property (nonatomic, assign) BOOL isAnimating;

@end

@implementation FNDouQuanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (LOTAnimationView*)collectionShowView {
    if (_collectionShowView == nil) {
        _collectionShowView = [[LOTAnimationView alloc] init];
        NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"loittlelove.json" ofType:nil];
        _collectionShowView = [[LOTAnimationView alloc] initWithModel:( [LOTComposition animationWithFilePath: dataPath]) inBundle:NSBundle.mainBundle];
        //        animationView.frame = self.btnCollection.image.frame;
        NSLog(@"%f %f", self.btnCollection.image.frame.size.width, self.btnCollection.image.frame.size.height);
        _collectionShowView.frame = CGRectMake(0, 0, 50, 50);
        _collectionShowView.hidden = YES;
    }
    
    return _collectionShowView;
}

- (LOTAnimationView*)collectionDismissView {
    if (_collectionDismissView == nil) {
        _collectionDismissView = [[LOTAnimationView alloc] init];
        NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"datawhite.json" ofType:nil];
        _collectionDismissView = [[LOTAnimationView alloc] initWithModel:( [LOTComposition animationWithFilePath: dataPath]) inBundle:NSBundle.mainBundle];
        //        animationView.frame = self.btnCollection.image.frame;
        NSLog(@"%f %f", self.btnCollection.image.frame.size.width, self.btnCollection.image.frame.size.height);
        _collectionDismissView.frame = CGRectMake(0, 0, 50, 50);
        _collectionDismissView.hidden = YES;
    }
    
    return _collectionDismissView;
}

#pragma mark -  top分享 && 升级赚
-(void)shareAndUpgradeUI{
    
    //分享
    self.shareView=[UIImageView new];
    self.shareView.hidden=YES;
    self.shareView.image=IMAGE(@"dshare_bj");
    [self addSubview:self.shareView];
//    self.shareView.sd_layout
//    .rightEqualToView(self).topSpaceToView(self, XYScreenWidth - 100).heightIs(30).widthRatioToView(self, 0.25);
    [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.bottom.equalTo(self.btnBuy.mas_top).offset(-40);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30 * 218 / 84);
        make.top.equalTo(@200);
    }];
    
    //分享图片
    _shareImage = [UIImageView new];
    _shareImage.cornerRadius=10;
//    shareImage.image = IMAGE(@"detail_shareNew");
    [self.shareView addSubview:_shareImage];
    _shareImage.contentMode = UIViewContentModeScaleAspectFill;
//    _shareImage.sd_layout
//    .leftSpaceToView(self.shareView, 0).centerYEqualToView(self.shareView).heightIs(30).widthIs(30);
    [self.shareImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.shareView);
    }];
    //分享文字
    self.shareAddLb=[UILabel new];
    self.shareAddLb.textColor=[UIColor whiteColor];
    self.shareAddLb.numberOfLines=2;
    self.shareAddLb.font=kFONT10;
    [self.shareView addSubview:self.shareAddLb];
//    self.shareAddLb.sd_layout
//    .leftSpaceToView(_shareImage, 10).rightSpaceToView(self.shareView, 5).heightIs(30);
    [self.shareAddLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shareView).offset(35);
        make.right.lessThanOrEqualTo(self.shareView).offset(-5);
        make.centerY.height.equalTo(self.shareView);
    }];
    [self bringSubviewToFront:self.shareView];
    self.shareView.userInteractionEnabled = YES;
    [self.shareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareAction)]];
    
    //升级
    self.supgradeView=[UIImageView new];
    self.supgradeView.hidden=YES;
//    self.supgradeView.image=IMAGE(@"dshare_bj");
    [self addSubview:self.supgradeView];
//    self.supgradeView.sd_layout
//    .rightEqualToView(self).bottomSpaceToView(self.shareView, 10).heightIs(30).widthRatioToView(self, 0.25);
    [self.supgradeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.bottom.equalTo(self.shareView.mas_top).offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30 * 218 / 84);
    }];
    
    
    //升级图片
    _supgradeImage = [UIImageView new];
    _supgradeImage.cornerRadius=15;
//    supgradeImage.image = IMAGE(@"detail_up");
    [self.supgradeView addSubview:_supgradeImage];
    _supgradeImage.contentMode = UIViewContentModeScaleAspectFill;
//    _supgradeImage.sd_layout
//    .leftSpaceToView(self.supgradeView, 0).centerYEqualToView(self.supgradeView).heightIs(30).widthIs(30);
    [self.supgradeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.supgradeView);
    }];
    //升级文字
    self.supgradeAddLb=[UILabel new];
    self.supgradeAddLb.textColor=[UIColor whiteColor];
    self.supgradeAddLb.numberOfLines=2;
    self.supgradeAddLb.font=kFONT10;
    [self.supgradeView addSubview:self.supgradeAddLb];
//    self.supgradeAddLb.sd_layout
//    .leftSpaceToView(_supgradeImage, 10).rightSpaceToView(self.supgradeView, 5).heightIs(30);
    [self.supgradeAddLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.supgradeView).offset(35);
        make.right.lessThanOrEqualTo(self.supgradeView).offset(-5);
        make.centerY.height.equalTo(self.supgradeView);
    }];
    [self bringSubviewToFront:self.supgradeView];
    self.supgradeView.userInteractionEnabled = YES;
    [self.supgradeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(supgradeAction)]];
}
//分享
-(void)shareAction{
    if ([_delegate respondsToSelector:@selector(didFxzClick)]) {
        [_delegate didFxzClick];
    }
}
//升级
-(void)supgradeAction{
    if ([_delegate respondsToSelector:@selector(didSjzClick)]) {
        [_delegate didSjzClick];
    }
}

- (void)configUI {
    _imgBackground = [[UIImageView alloc] init];
    _imgPrice = [[UIImageView alloc] init];
    _lblPrice = [[UILabel alloc] init];
    _imgQuan1 = [[UIImageView alloc] init];
    _imgQuan2 = [[UIImageView alloc] init];
    _lblQuan = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblCount = [[UILabel alloc] init];
    
    [self addSubview:_imgBackground];
    [self addSubview:_imgPrice];
    [self addSubview:_lblPrice];
    [self addSubview:_imgQuan1];
    [self addSubview:_imgQuan2];
    [self addSubview:_lblQuan];
    [self addSubview:_lblDesc];
    [self addSubview:_lblTitle];
    [self addSubview:_lblCount];
    
    [_imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.mas_equalTo(140);
    }];
    [_imgPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblDesc);
        make.top.equalTo(self.lblDesc).offset(-4);
        make.height.mas_equalTo(20);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.imgPrice);
        make.left.greaterThanOrEqualTo(self.imgPrice).offset(10);
        make.right.lessThanOrEqualTo(self.imgPrice).offset(-10);
    }];
    [_imgQuan1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgPrice.mas_right).offset(4);
//        make.top.equalTo(self.imgPrice);
        make.centerY.equalTo(self.imgPrice);
        make.height.mas_equalTo(20);
        make.width.mas_offset(25);
    }];
    [_imgQuan2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgQuan1.mas_right);
        make.top.equalTo(self.imgQuan1);
        make.height.equalTo(self.imgQuan1);
    }];
    [_lblQuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.imgQuan2);
        make.left.greaterThanOrEqualTo(self.imgQuan2).offset(10);
        make.right.lessThanOrEqualTo(self.imgQuan2).offset(-10);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.lessThanOrEqualTo(@-10);
        make.bottom.lessThanOrEqualTo(isIphoneX ? @-54: @-20);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.lessThanOrEqualTo(self.lblCount.mas_left).offset(-10);
        make.bottom.equalTo(self.lblDesc.mas_top).offset(-16);
    }];
    [_lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.bottom.equalTo(self.lblTitle);
    }];
    [_lblCount contentHuggingPriorityForAxis:(UILayoutConstraintAxisHorizontal)];
    [_lblCount setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    [_lblCount contentCompressionResistancePriorityForAxis:(UILayoutConstraintAxisHorizontal)];
    [_lblCount setContentCompressionResistancePriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    
//    self.userInteractionEnabled = NO;
    
    _btnBuy = [[FNDouQuanButton alloc] init];
    _btnCollection = [[FNDouQuanButton alloc] init];
    _btnShare = [[FNDouQuanButton alloc] init];
    _btnDownload = [[FNDouQuanButton alloc] init];
    
    [self addSubview:_btnBuy];
    [self addSubview:_btnCollection];
    [self addSubview:_btnShare];
    [self addSubview:_btnDownload];
    
    [_btnBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.bottom.equalTo(self.btnCollection.mas_top).offset(-40);
        make.width.height.mas_equalTo(60);
    }];
    [_btnBuy.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(28);
    }];
    [_btnCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.bottom.equalTo(self.btnShare.mas_top).offset(-40);
        make.width.height.mas_equalTo(60);
    }];
    [_btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
//        make.bottom.equalTo(@-250);
        make.width.height.mas_equalTo(60);
    }];
    
    [_btnDownload mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        //        make.bottom.equalTo(@-250);
        make.width.height.mas_equalTo(60);
        make.top.equalTo(self.btnShare.mas_bottom).offset(40);
    }];
    
    _imgBackground.image = IMAGE(@"douquan_bg");
    @weakify(self)
    [_imgBackground addJXTouch:^{
        @strongify(self)
        if ([self.delegate respondsToSelector:@selector(didDescClick)]) {
            [self.delegate didDescClick];
        }
    }];
    
    _lblTitle.textColor = UIColor.whiteColor;
    _lblTitle.font = [UIFont systemFontOfSize:18];
    
    _lblCount.textColor = RGB(213, 45, 96);
    _lblCount.font = kFONT15;
    
    _lblPrice.textColor = UIColor.whiteColor;
    _lblPrice.font = kFONT13;
    
    _lblDesc.textColor = UIColor.whiteColor;
    _lblDesc.font = kFONT13;
    _lblDesc.numberOfLines = 2;
    
    _lblQuan.textColor = UIColor.whiteColor;
    _lblQuan.font = kFONT13;
    
//    _btnBuy.image.image = IMAGE(@"douquan_button_collection_selected");
    _btnBuy.label.text = @"去购买";
    _btnBuy.image.cornerRadius = 14;
    _btnBuy.contentMode = UIViewContentModeScaleAspectFill;
    [_btnBuy addTarget:self action:@selector(onBuyAction)];
    
    _btnCollection.image.image = IMAGE(@"douquan_button_collection_normal");
    _btnCollection.label.text = @"收藏";
    [_btnCollection addTarget:self action:@selector(onCollectionAction)];

    
    _btnShare.image.image = IMAGE(@"douquan_button_share_normal");
    _btnShare.label.text = @"分享";
    [_btnShare addTarget:self action:@selector(onShareAction)];
    
    _btnDownload.image.image = IMAGE(@"douquan_button_download_normal");
    _btnDownload.label.text = @"下载";
    [_btnDownload addTarget:self action:@selector(onDownloadAction)];
    
    [self.btnCollection addSubview: self.collectionDismissView];
    [self.btnCollection addSubview: self.collectionShowView];
    self.collectionDismissView.hidden = YES;
    self.collectionShowView.hidden = YES;
    
    [self shareAndUpgradeUI];
    
    
}

- (void)setModel:(FNDouQuanModel *)model {
    _model = model;
    
    self.lblTitle.text = self.model.goods_title;
    if([self.model.goods_title kr_isNotEmpty]){
        [self.lblTitle HttpLabelLeftImage:self.model.shop_img label:self.lblTitle imageX:0 imageY:-1.5 imageH:15 atIndex:0];
    }
    
    self.lblCount.text = [NSString stringWithFormat:@"%@已抢", self.model.goods_sales];
    self.lblCount.textColor = [UIColor colorWithHexString:self.model.goods_sales_color];
    if([self.model.goods_sales_ico kr_isNotEmpty]){
        [self.lblCount HttpLabelLeftImage:self.model.goods_sales_ico label:self.lblCount imageX:0 imageY:-1.5 imageH:15 atIndex:0];
    }
    
    [self.imgPrice sd_setImageWithURL:URL(self.model.goods_price_bjimg)];
    self.lblPrice.text = [NSString stringWithFormat:@"券后价：%@", self.model.price_str];
    self.lblPrice.textColor = [UIColor colorWithHexString:self.model.goods_price_color];
    
    [self.imgQuan1 sd_setImageWithURL:URL(self.model.goods_quanfont_bjimg)];
    [self.imgQuan2 sd_setImageWithURL:URL(self.model.goods_quanbj_bjimg)];
    self.lblQuan.text = self.model.yhq_span;
    self.lblQuan.textColor = [UIColor colorWithHexString:self.model.goodsyhqstr_color];
    
    [self.btnBuy.image sd_setImageWithURL:URL(self.model.goods_img)];
    
    _btnCollection.selected = self.model.is_collect.boolValue;
    
    self.collectionDismissView.hidden = _btnCollection.selected;
    self.collectionShowView.hidden = !_btnCollection.selected;
    [self.collectionDismissView playFromProgress:1 toProgress:1 withCompletion:^(BOOL animationFinished) {
        
    }];
//    if (!self.model.is_collect.boolValue) {
//        [_btnCollection addSubview:self.collectionShowView];
//    } else {
//        [_btnCollection addSubview:self.collectionDismissView];
//    }
    
    NSDictionary *img_sjzDic=self.model.img_sjz;
    NSInteger sjShow=[img_sjzDic[@"is_show"] integerValue] && ![FNCurrentVersion isEqualToString:Setting_checkVersion];
    if(sjShow==0){
        self.supgradeView.hidden=YES;
    }else{
        self.supgradeView.hidden=NO;
        NSString *sjString=[NSString stringWithFormat:@"%@\n%@",img_sjzDic[@"str"],img_sjzDic[@"bili"]];
        self.supgradeAddLb.text=sjString;
        [self.supgradeImage sd_setImageWithURL:URL(img_sjzDic[@"img"])];
    }
    
    NSDictionary *img_fxz=self.model.img_fxz;
    NSInteger fxShow=[img_fxz[@"is_show"] integerValue];
    if(fxShow==0){
        self.shareView.hidden=YES;
    }else{
        self.shareView.hidden=NO;
        NSString *fxString=[NSString stringWithFormat:@"%@\n%@",img_fxz[@"str"],img_fxz[@"bili"]];
        self.shareAddLb.text=fxString;
        [self.shareImage sd_setImageWithURL:URL(img_fxz[@"img"])];
    }
    
    
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    self.collectionShowView.center = self.btnCollection.image.center;
    self.collectionDismissView.center = self.btnCollection.image.center;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //行间距
    paragraphStyle.lineSpacing = 4;
    //首行缩进
    paragraphStyle.firstLineHeadIndent = self.imgPrice.width + self.imgQuan1.width + self.imgQuan2.width + 8;
    //富文本样式
    NSDictionary *attributeDic = @{NSParagraphStyleAttributeName : paragraphStyle};
    if ([self.model.goods_description kr_isNotEmpty]) {
        self.lblDesc.attributedText = [[NSAttributedString alloc] initWithString:self.model.goods_description attributes:attributeDic];
    } else {
        self.lblDesc.text = @"";
    }
}


#pragma mark - Action
- (void) onBuyAction {
    if ([_delegate respondsToSelector:@selector(didProductClick)]) {
        [_delegate didProductClick];
    }
}

- (void)showDismissCollectionAni {
    _isAnimating = YES;
    self.collectionShowView.hidden = YES;
    self.collectionDismissView.center = self.btnCollection.image.center;
    self.collectionDismissView.hidden = NO;
    self.btnCollection.image.hidden = YES;
    @weakify(self)
    [_collectionDismissView playWithCompletion:^(BOOL animationFinished) {
        @strongify(self)
        self.collectionShowView.center = self.btnCollection.image.center;
        self.isAnimating = NO;
    }];
}

- (void)showCollectionAni {
    _isAnimating = YES;
    self.collectionDismissView.hidden = YES;
    self.collectionShowView.center = self.btnCollection.image.center;
    self.collectionShowView.hidden = NO;
    self.btnCollection.image.hidden = YES;
    @weakify(self)
    [self.collectionShowView playWithCompletion:^(BOOL animationFinished) {
        @strongify(self)
        self.collectionDismissView.center = self.btnCollection.image.center;
        self.isAnimating = NO;
    }];
}

- (void) onCollectionAction {
    NSLog(@"onCollectionAction");
    
    if ([_delegate respondsToSelector:@selector(didCollectionClick)]) {
        [_delegate didCollectionClick];
    }
    
    if (![UserAccessToken kr_isNotEmpty]) {
        //warn user to login
        [FNTipsView showTips:@"登录之后才可以收藏商品"];
    }else{
        
        _btnCollection.selected = self.model.is_collect.boolValue;
        if (_btnCollection.selected) {
            [self deleteMyLikeMethod:self.model.ID];
        } else {
            [self addMyLikeMethod:self.model.ID];
        }
    }
}

- (void)doLike {
    if (_model == nil)
        return;
    if (![UserAccessToken kr_isNotEmpty]) {
        //warn user to login
        [FNTipsView showTips:@"登录之后才可以收藏商品"];
    }else{
        if (!_btnCollection.selected) {
            [self addMyLikeMethod:self.model.ID];
            _btnCollection.selected = YES;
        }
    }
}

- (void)doUnlike {
    if (_model == nil)
        return;
    if (![UserAccessToken kr_isNotEmpty]) {
        //warn user to login
        [FNTipsView showTips:@"登录之后才可以收藏商品"];
    }else{
        if (_btnCollection.selected) {
            [self deleteMyLikeMethod:self.model.ID];
            _btnCollection.selected = NO;
        }
    }
}

- (void) onShareAction {
    if ([_delegate respondsToSelector:@selector(didShareClick)]) {
        [_delegate didShareClick];
    }
}

- (void) onDownloadAction {
    if ([_delegate respondsToSelector:@selector(didDownloadClick)]) {
        [_delegate didDownloadClick];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self)
    {
        return nil;
    }
    else
    {
        return hitView;
    }
}
#pragma mark - request
-(void)deleteMyLikeMethod:(NSString *)goodsId{
    @WeakObj(self);
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{                                                                                  @"time":[NSString GetNowTimes],
                                                                                                                                                                    @"goodsid":goodsId,
                                                                                                                                                                    @"token":UserAccessToken}];
    params[SignKey] = [NSString getSignStringWithDictionary:params];
//    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_home_deletemylike isCache: NO successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            selfWeak.model.is_collect = @"0";
            selfWeak.btnCollection.selected =selfWeak.model.is_collect.boolValue;
            [selfWeak showDismissCollectionAni];
//            [FNTipsView showTips:XYDeleteLikeMsg];
        }else {
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        [SVProgressHUD dismiss];
    } failureBlock:^(NSString *error) {
        [XYNetworkAPI cancelAllRequest];
        [SVProgressHUD dismiss];
    }];
    
}
-(void)addMyLikeMethod:(NSString *)goodsId{
    @WeakObj(self);
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{                                                                                  @"time":[NSString GetNowTimes],
                                                                                                                                                                    @"goodsid":goodsId,
                                                                                                                                                                    @"token":UserAccessToken}];
    params[SignKey] = [NSString getSignStringWithDictionary:params];
    
//    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_home_addmylike isCache: NO successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            selfWeak.model.is_collect = @"1";
            //            selfWeak.leftbtns[self.collectioIndex].button.selected =selfWeak.model.is_collect.boolValue;
            selfWeak.btnCollection.selected =selfWeak.model.is_collect.boolValue;
            [selfWeak showCollectionAni];
//            [FNTipsView showTips:XYAddLikeMsg];
        }else {
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        [SVProgressHUD dismiss];
    } failureBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
        [XYNetworkAPI cancelAllRequest];
    }];
    
}

@end
