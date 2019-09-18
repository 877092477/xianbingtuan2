//
//  FNIntergralMallDetailHeaderView.m
//  THB
//
//  Created by Weller Zhao on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNIntergralMallDetailHeaderView.h"
#import "SDCycleScrollView/SDCycleScrollView.h"
#import "FNIntegralMallDetailModel.h"

@interface FNIntergralMallDetailHeaderView()

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) UIView *vImage;

@property (nonatomic, strong) UIView *vLine;

//分享
@property (nonatomic, strong)UILabel *shareAddLb;
//升级
@property (nonatomic, strong)UILabel *supgradeAddLb;
//分享View
@property (nonatomic, strong)UIImageView *shareView;
//升级View
@property (nonatomic, strong)UIImageView *supgradeView;

@property (nonatomic, strong) UIImageView *imgFan;
@property (nonatomic, strong) UILabel *lblFan;

@property (nonatomic, strong)UIView* upgradeView;
@property (nonatomic, strong)UIImageView* imgUpgradeBG;
@property (nonatomic, strong)UIImageView* imgUpgrade;
@property (nonatomic, strong)UILabel* lblUpgrade;
@property (nonatomic, strong)UIButton* btnUpgrade;

@end

@implementation FNIntergralMallDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        [self shareAndUpgradeUI];
    }
    return self;
}


- (void)configUI {
    self.vImage = [[UIView alloc] init];
//    self.cycleScrollView = [[UILabel alloc] init];
    self.lblTitle = [[UILabel alloc] init];
    self.lblPrice = [[UILabel alloc] init];
    self.lblDesc = [[UILabel alloc] init];
    self.lblCount = [[UILabel alloc] init];
    self.vLine = [[UIView alloc] init];
    
    self.imgFan = [[UIImageView alloc] init];
    self.lblFan = [[UILabel alloc] init];
    
    [self.contentView addSubview:self.vImage];
    [self.contentView addSubview:self.lblTitle];
    [self.contentView addSubview:self.lblPrice];
    [self.contentView addSubview:self.lblDesc];
    [self.contentView addSubview:self.lblCount];
    [self.contentView addSubview:self.vLine];
    [self.contentView addSubview:self.imgFan];
    [self.contentView addSubview:self.lblFan];
    
    [self.contentView addSubview:self.upgradeView];
    
    [self.vImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.width.mas_equalTo(XYScreenWidth);
        make.height.equalTo(self.vImage.mas_width);
    }];
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self.vImage.mas_bottom).offset(10);
        make.right.lessThanOrEqualTo(@-10);
    }];
    
    [self.imgFan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(8);
        make.right.lessThanOrEqualTo(@-10);
        make.height.mas_equalTo(15);
    }];
    
    [self.lblFan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgFan).offset(4);
        make.right.equalTo(self.imgFan).offset(-4);
        make.center.equalTo(self.imgFan);
    }];
    
    [self.lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self.imgFan.mas_bottom).offset(14);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [self.lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self.lblPrice.mas_bottom).offset(10);
        make.right.lessThanOrEqualTo(self.lblCount.mas_left).offset(-10);
    }];
    [self.lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lblDesc);
        make.right.equalTo(@-16);
    }];
    [self.lblCount setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.upgradeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(24);
//        make.top.equalTo(self.lblDesc.mas_bottom).offset(10);
//        make.bottom.equalTo(@0);
    }];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@-16);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.upgradeView.mas_bottom).offset(10);
        make.bottom.equalTo(@0);
    }];
    
    self.backgroundColor = UIColor.whiteColor;
    
    self.lblTitle.textColor = RGB(60, 60, 60);
    self.lblTitle.font = kFONT14;
    self.lblTitle.numberOfLines = 1;
    
    self.lblPrice.textColor = RGB(255, 131, 20);
    self.lblPrice.font = [UIFont boldSystemFontOfSize:18];
    
    self.lblDesc.textColor = RGB(200, 200, 200);
    self.lblDesc.font = kFONT13;
    
    self.lblCount.textColor = RGB(200, 200, 200);
    self.lblCount.font = kFONT13;
    
    self.lblFan.font = kFONT11;
    
    self.vLine.backgroundColor = [UIColor clearColor];//FNHomeBackgroundColor;
}

- (UIImageView*) imgUpgradeBG {
    if (_imgUpgradeBG == nil) {
        _imgUpgradeBG = [[UIImageView alloc] init];
    }
    return _imgUpgradeBG;
}

- (UIImageView*) imgUpgrade {
    if (_imgUpgrade == nil) {
        _imgUpgrade = [[UIImageView alloc] init];
    }
    return _imgUpgrade;
}
- (UILabel*) lblUpgrade {
    if (_lblUpgrade == nil) {
        _lblUpgrade = [[UILabel alloc] init];
        _lblUpgrade.font = kFONT11;
        //        _lblUpgrade.numberOfLines = 0;
    }
    return _lblUpgrade;
}
- (UIButton*) btnUpgrade {
    if (_btnUpgrade == nil) {
        _btnUpgrade = [[UIButton alloc] init];
        _btnUpgrade.titleLabel.font = kFONT11;
        @weakify(self);
        [_btnUpgrade addJXTouch:^{
            @strongify(self);
            if (self.upgradeClicked) {
                self.upgradeClicked();
            }
        }];
    }
    return _btnUpgrade;
}

- (UIView*) upgradeView {
    if (_upgradeView == nil) {
        
        _upgradeView = [[UIView alloc] init];
        
        [_upgradeView addSubview:self.imgUpgradeBG];
        [self.imgUpgradeBG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        
        [_upgradeView addSubview:self.imgUpgrade];
        [self.imgUpgrade mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgUpgradeBG).offset(5);
            make.centerY.equalTo(self.imgUpgradeBG);
            make.width.height.mas_equalTo(14);
        }];
        //        self.imgUpgrade
        
        [_upgradeView addSubview:self.btnUpgrade];
        [self.btnUpgrade mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.imgUpgradeBG).offset(-4);
            make.centerY.equalTo(self.imgUpgradeBG);
        }];
        [self.btnUpgrade setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        
        [_upgradeView addSubview:self.lblUpgrade];
        [self.lblUpgrade mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgUpgrade.mas_right).offset(4);
            //            make.top.equalTo(@6);
            //            make.bottom.equalTo(@-6);
            make.centerY.equalTo(self.imgUpgradeBG);
            make.right.lessThanOrEqualTo(self.btnUpgrade.mas_left).offset(-10);
        }];
        
        
        
    }
    
    return _upgradeView;
}

- (void)setHeader: (NSArray<NSString*>*) headerUrls {
    if (self.cycleScrollView == nil) {
        self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenWidth) imageURLStringsGroup:headerUrls];
        self.cycleScrollView.autoScroll = YES;
        self.cycleScrollView.autoScrollTimeInterval = 15;
        
        [self.vImage addSubview:self.cycleScrollView];
        [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    else {
        [self.cycleScrollView setImageURLStringsGroup:headerUrls];
    }
}

- (void)setModel: (FNIntegralMallDetailModel*)model {
    NSDictionary *img_sjzDic=model.img_sjz;
    NSInteger sjShow=[img_sjzDic[@"is_show"] integerValue];
    if(sjShow==0){
        self.supgradeView.hidden=YES;
    }else{
        self.supgradeView.hidden=NO;
        NSString *sjString=[NSString stringWithFormat:@"%@%@",img_sjzDic[@"str"],img_sjzDic[@"bili"]];
        self.supgradeAddLb.text=sjString;
    }
    
    NSDictionary *img_fxz=model.img_fxz;
    NSInteger fxShow=[img_fxz[@"is_show"] integerValue];
    if(fxShow==0){
        self.shareView.hidden=YES;
    }else{
        self.shareView.hidden=NO;
        NSString *fxString=[NSString stringWithFormat:@"%@%@",img_fxz[@"str"],img_fxz[@"bili"]];
        self.shareAddLb.text=fxString;
    }
    
    @weakify(self)
    [self.imgFan sd_setImageWithURL:URL(model.goods_fanli_bjimg) placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if(image){
            self.lblFan.text = model.f_str;
            self.lblFan.textColor = [UIColor colorWithHexString: model.goodsfcommissionstr_color];
        }
    }];
    self.imgFan.hidden = ![model.f_str kr_isNotEmpty];
    self.lblFan.hidden = ![model.f_str kr_isNotEmpty];
    
    BOOL showMidUpgrade = model.mid_zgz && [model.mid_zgz[@"is_show"] isEqual:@"1"] && ![FNCurrentVersion isEqualToString:Setting_checkVersion];
    self.upgradeView.hidden = !showMidUpgrade;

//    self.upgradeView.hidden = NO;
    [self.imgUpgradeBG sd_setImageWithURL:URL(model.mid_zgz[@"img"])];
    [self.imgUpgrade sd_setImageWithURL:URL(model.mid_zgz[@"img1"])];
    self.lblUpgrade.text = model.mid_zgz[@"str"];
    self.lblUpgrade.textColor = [UIColor colorWithHexString:model.mid_zgz[@"fontcolor"]];
    [self.btnUpgrade setTitle:[NSString stringWithFormat:@"%@ >>", model.mid_zgz[@"str1"]] forState:UIControlStateNormal];
    [self.btnUpgrade setTitleColor:[UIColor colorWithHexString:model.mid_zgz[@"fontcolor"]] forState:UIControlStateNormal];

}

#pragma mark -  top分享 && 升级赚
-(void)shareAndUpgradeUI{
    
    //分享
    self.shareView=[UIImageView new];
    self.shareView.hidden=YES;
    self.shareView.image=IMAGE(@"dshare_bj");
    [self addSubview:self.shareView];
    self.shareView.sd_layout
    .rightEqualToView(self).topSpaceToView(self, 140).heightIs(30).widthRatioToView(self, 0.25);
    
    //分享图片
    UIImageView*shareImage = [UIImageView new];
    shareImage.cornerRadius=10;
    shareImage.image = IMAGE(@"detail_shareNew");
    [self.shareView addSubview:shareImage];
    shareImage.sd_layout
    .leftSpaceToView(self.shareView, 0).centerYEqualToView(self.shareView).heightIs(30).widthIs(30);
    //分享文字
    self.shareAddLb=[UILabel new];
    self.shareAddLb.textColor=[UIColor whiteColor];
    self.shareAddLb.numberOfLines=2;
    self.shareAddLb.font=kFONT10;
    [self.shareView addSubview:self.shareAddLb];
    self.shareAddLb.sd_layout
    .leftSpaceToView(shareImage, 10).rightSpaceToView(self.shareView, 5).heightIs(30);
    [self bringSubviewToFront:self.shareView];
    self.shareView.userInteractionEnabled = YES;
    [self.shareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareAction)]];
    
    //升级
    self.supgradeView=[UIImageView new];
    self.supgradeView.hidden=YES;
    self.supgradeView.image=IMAGE(@"dshare_bj");
    [self addSubview:self.supgradeView];
    self.supgradeView.sd_layout
    .rightEqualToView(self).bottomSpaceToView(self.shareView, 10).heightIs(30).widthRatioToView(self, 0.25);
    
    //升级图片
    UIImageView*supgradeImage = [UIImageView new];
    supgradeImage.cornerRadius=15;
    supgradeImage.image = IMAGE(@"detail_up");
    [self.supgradeView addSubview:supgradeImage];
    supgradeImage.sd_layout
    .leftSpaceToView(self.supgradeView, 0).centerYEqualToView(self.supgradeView).heightIs(30).widthIs(30);
    //升级文字
    self.supgradeAddLb=[UILabel new];
    self.supgradeAddLb.textColor=[UIColor whiteColor];
    self.supgradeAddLb.numberOfLines=2;
    self.supgradeAddLb.font=kFONT10;
    [self.supgradeView addSubview:self.supgradeAddLb];
    self.supgradeAddLb.sd_layout
    .leftSpaceToView(supgradeImage, 10).rightSpaceToView(self.supgradeView, 5).heightIs(30);
    [self bringSubviewToFront:self.supgradeView];
    self.supgradeView.userInteractionEnabled = YES;
    [self.supgradeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(supgradeAction)]];
}
//分享
-(void)shareAction{
    if (self.shareClicked) {
        self.shareClicked();
    }
}
//升级
-(void)supgradeAction{
    if (self.upgradeClicked) {
        self.upgradeClicked();
    }
    
}

@end
