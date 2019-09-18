//
//  FNUPdetailsHeadNCell.m
//  THB
//
//  Created by Jimmy on 2018/9/26.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUPdetailsHeadNCell.h"

@interface FNUPdetailsHeadNCell()

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

@implementation FNUPdetailsHeadNCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCompositionView];
    }
    return self;
}
#pragma mark -  top分享 && 升级赚
-(void)shareAndUpgradeUI{
    
    //分享
    self.shareView=[UIImageView new];
    self.shareView.hidden=YES;
    self.shareView.image=IMAGE(@"dshare_bj");
    [self.contentView addSubview:self.shareView];
//    self.shareView.sd_layout
//    .rightEqualToView(self).topSpaceToView(self, XYScreenWidth - 100).heightIs(30).widthRatioToView(self, 0.25);
    [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.top.equalTo(@200);
        make.height.mas_equalTo(30);
        make.width.equalTo(self.shareView.mas_height).dividedBy(0.25);
    }];
    
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
//    [self bringSubviewToFront:self.shareView];
    self.shareView.userInteractionEnabled = YES;
    [self.shareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareAction)]];
    
    //升级
    self.supgradeView=[UIImageView new];
    self.supgradeView.hidden=YES;
    self.supgradeView.image=IMAGE(@"dshare_bj");
    [self.contentView addSubview:self.supgradeView];
//    self.supgradeView.sd_layout
//    .rightEqualToView(self).bottomSpaceToView(self.shareView, 10).heightIs(30).widthRatioToView(self, 0.25);
    [self.supgradeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.top.equalTo(self.shareView.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
        make.width.equalTo(self.supgradeView.mas_height).dividedBy(0.25);
    }];
    
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
//    [self bringSubviewToFront:self.supgradeView];
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
-(void)setCompositionView{
    //幻灯片模块
    _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, XYScreenWidth, 315) imageNamesGroup:nil];
    _bannerView.backgroundColor = FNWhiteColor;
    _bannerView.placeholderImage = DEFAULT;
    _bannerView.delegate=self;
    _bannerView.autoScrollTimeInterval = 5;
    _bannerView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _bannerView.titleLabelTextFont=kFONT17;
    [self.contentView addSubview:_bannerView];
    
    //商品标题
    self.GoodsTitleLabel=[UILabel new];
    self.GoodsTitleLabel.numberOfLines=2;
    self.GoodsTitleLabel.textColor=FNBlackColor;
    self.GoodsTitleLabel.font=kFONT14;
    [self.contentView addSubview:self.GoodsTitleLabel];
    
    //原价
    self.originPriceLabel=[UILabel new];
    [self.originPriceLabel sizeToFit];
    self.originPriceLabel.textColor=FNColor(246, 71, 111);
    self.originPriceLabel.font=[UIFont systemFontOfSize:24];
    [self.contentView addSubview:self.originPriceLabel];
    
    self.imgFan = [[UIImageView alloc] init];
    self.lblFan = [[UILabel alloc] init];
    [self.contentView addSubview:self.imgFan];
    [self.contentView addSubview:self.lblFan];
    self.lblFan.font = kFONT11;
    
    //月销量
    self.countLabel=[UILabel new];
    [self.countLabel sizeToFit];
    self.countLabel.textColor=FNGlobalTextGrayColor;
    self.countLabel.font=kFONT14;
    [self.contentView addSubview:self.countLabel];
    //优选
    self.optimizationLB=[UILabel new];
    [self.optimizationLB sizeToFit];
    self.optimizationLB.font=kFONT14;
    [self.contentView addSubview:self.optimizationLB];
    self.optimizationLB.cornerRadius=5/2;
    
    self.lineLB=[UILabel new];
    self.lineLB.backgroundColor=FNColor(239, 239, 239);
    [self.contentView addSubview:self.lineLB];
    
    
    [self.contentView addSubview:self.upgradeView];
    
    
    [self initializedSubviews];
    
}
#pragma mark - initializedSubviews
- (void)initializedSubviews {
    
    //CGFloat w = FNDeviceWidth/3;
    CGFloat interval_10 = 10;
    //商品标题
    self.GoodsTitleLabel.sd_layout
    .topSpaceToView(self.bannerView, interval_10).leftSpaceToView(self.contentView, interval_10).rightSpaceToView(self.contentView, interval_10).heightIs(20);
    
    [self.imgFan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self.GoodsTitleLabel.mas_bottom).offset(8);
        make.right.lessThanOrEqualTo(@-10);
        make.height.mas_equalTo(15);
    }];
    
    [self.lblFan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgFan).offset(4);
        make.right.equalTo(self.imgFan).offset(-4);
        make.center.equalTo(self.imgFan);
    }];
    
    self.lineLB.sd_layout
    .rightSpaceToView(self.contentView, 0).heightIs(5).bottomSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, 0);
    
    //原价
//    self.originPriceLabel.sd_layout
//    .leftSpaceToView(self.contentView, interval_10).heightIs(25).bottomSpaceToView(self.lineLB, interval_10/2);
//    [self.originPriceLabel setSingleLineAutoResizeWithMaxWidth:160];
    [self.originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.equalTo(self.imgFan.mas_bottom).offset(10);
        make.right.lessThanOrEqualTo(self.countLabel.mas_left).offset(-10);
    }];
    
    //月销量
//    self.countLabel.sd_layout
//    .rightSpaceToView(self.contentView, interval_10).heightIs(25).bottomSpaceToView(self.lineLB, interval_10/2);
//    [self.countLabel setSingleLineAutoResizeWithMaxWidth:160];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-15);
        make.bottom.equalTo(self.originPriceLabel);
    }];
    
    self.optimizationLB.sd_layout
    .topSpaceToView(self.bannerView, interval_10).leftSpaceToView(self.contentView, interval_10).heightIs(20);
    [self.optimizationLB setSingleLineAutoResizeWithMaxWidth:60];
    
    [self.upgradeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(24);
        make.top.equalTo(self.originPriceLabel.mas_bottom).offset(10);
        //        make.bottom.equalTo(@0);
    }];
   
    [self shareAndUpgradeUI];
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

-(void)setDataDic:(NSDictionary*)dataDic{
    _dataDic=dataDic;
    if(dataDic){
        FNUpDetailsNModel *model=[FNUpDetailsNModel mj_objectWithKeyValues:dataDic];
        NSArray* arr=model.slide_img;
        _bannerView.imageURLStringsGroup = arr;
        self.GoodsTitleLabel.text=[NSString stringWithFormat:@"%@ %@",model.label1,model.title];
        self.originPriceLabel.text=[NSString stringWithFormat:@"¥%@",model.price];
        self.countLabel.text=[NSString stringWithFormat:@"%@ 销量",model.goods_sales];
        self.optimizationLB.text=model.label1;
        self.optimizationLB.textColor=[UIColor colorWithHexString:model.label_fontcolor1];
        self.optimizationLB.backgroundColor=[UIColor colorWithHexString:model.label_bjcolor1];
        
        
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
    }
    
}
#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    //if (self.BannerClickedBlock) {
    //    self.BannerClickedBlock(index);
    //}
}
@end
