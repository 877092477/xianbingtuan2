//
//  FNPasteSearchUpdateAlertView.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/5.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNPasteSearchUpdateAlertView.h"

#import "FNNewProductDetailModel.h"

#import "UIButton+WebCache.h"
#import <POP.h>
#import "FNIntegralMallDetailModel.h"


@interface FNPasteSearchUpdateAlertView ()

@property (nonatomic, strong) UIButton*    closedBtn;
@property (nonatomic, strong) UIView*      BgView;
@property (nonatomic, strong) UIImageView* ImageView;

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIImageView *imgQuan;
@property (nonatomic, strong) UILabel *lblQuan;
@property (nonatomic, strong) UIImageView *imgFan;
@property (nonatomic, strong) UILabel *lblFan;

@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UILabel *lblOriginPrice;

@property (nonatomic, strong) UIButton *searchBtn;


@end

@implementation FNPasteSearchUpdateAlertView

FNPasteSearchUpdateAlertView *_SearchUpdateAlertView = nil;

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
    if (_SearchUpdateAlertView == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _SearchUpdateAlertView = [[FNPasteSearchUpdateAlertView alloc]initWithFrame:FNKeyWindow.bounds];
        });
    }
    return _SearchUpdateAlertView;
}
#pragma mark - initializedSubviews
- (void)jm_setupViews{
    
    _BgView=[UIView new];
    _BgView.backgroundColor=[UIColor whiteColor];
    _BgView.cornerRadius=10;
    [self addSubview:_BgView];
    
    _ImageView = [UIImageView new];
    [_BgView addSubview:_ImageView];
    _ImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _lblTitle = [[UILabel alloc] init];
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = kFONT14;
    _lblTitle.numberOfLines = 2;
    [_BgView addSubview: _lblTitle];
    
    _imgQuan = [[UIImageView alloc] init];
    [_BgView addSubview: _imgQuan];
    
    _lblQuan = [[UILabel alloc] init];
    _lblQuan.textColor = UIColor.whiteColor;
    _lblQuan.font = kFONT14;
    [_BgView addSubview: _lblQuan];
    
    _imgFan = [[UIImageView alloc] init];
    [_BgView addSubview: _imgFan];
    _lblFan = [[UILabel alloc] init];
    _lblFan.textColor = UIColor.whiteColor;
    _lblFan.font = kFONT14;
    [_BgView addSubview: _lblFan];
    
    _lblPrice = [[UILabel alloc] init];
    _lblPrice.textColor = RGB(51, 51, 51);
    _lblPrice.font = [UIFont boldSystemFontOfSize:16];
    [_BgView addSubview: _lblPrice];
    
    _lblOriginPrice = [[UILabel alloc] init];
    _lblOriginPrice.textColor = RGB(153, 153, 153);
    _lblOriginPrice.font = kFONT10;
    [_BgView addSubview: _lblOriginPrice];
    
    _searchBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //    _searchBtn.cornerRadius=10;
    _searchBtn.titleLabel.font=kFONT13;
    [_searchBtn setTitle:@"" forState:UIControlStateNormal];
    [_searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_searchBtn addTarget:self action:@selector(storeSearchAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_BgView addSubview:_searchBtn];
    
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
//        make.height.equalTo(self.ImageView).offset(180);
//        make.height.equalTo(self.ImageView).offset(100);
    }];
    
    [_ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.mas_equalTo(0);
    }];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.lessThanOrEqualTo(@-20);
        make.top.equalTo(self.ImageView.mas_bottom).offset(12);
    }];
    [_imgQuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(8);
        make.height.mas_equalTo(15);
    }];
    [_lblQuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgQuan).offset(4);
        make.right.equalTo(self.imgQuan).offset(-4);
        make.center.equalTo(self.imgQuan);
    }];
    [_imgFan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgQuan.mas_right).offset(6);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(8);
        make.height.mas_equalTo(15);
    }];
    [_lblFan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgFan).offset(4);
        make.right.equalTo(self.imgFan).offset(-4);
        make.center.equalTo(self.imgFan);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.imgQuan.mas_bottom).offset(12);
    }];
    [_lblOriginPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblPrice.mas_right).offset(6);
        make.bottom.equalTo(self.lblPrice);
    }];
    
    [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblOriginPrice.mas_bottom).offset(12);
        make.left.equalTo(@12);
        make.right.equalTo(@-12);
        make.height.mas_equalTo(48);
        make.bottom.equalTo(@-20);
    }];

//    [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.lblTitle.mas_bottom).offset(10);
//        make.left.equalTo(_BgView.mas_left).offset(48);
//        make.right.equalTo(_BgView.mas_right).offset(-48);
//        make.height.mas_equalTo(22);
//    }];
    
    [_closedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_BgView.mas_top).offset(-50);
        make.right.equalTo(_BgView.mas_right).offset(20);
    }];
    

    
}

-(void)setFnIDstring:(NSString *)fnIDstring{
    _fnIDstring=fnIDstring;
    
    //    [_searchBtn setTitle:@"去详情" forState:UIControlStateNormal];
    _searchBtn.hidden = ![fnIDstring kr_isNotEmpty];
}
-(void)storeSearchAction{
    
    if (self.storeTypeBlock) {
        self.storeTypeBlock(nil, nil,nil);
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
- (void)showAnimation{
    _SearchUpdateAlertView.BgView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.25f animations:^{
        _SearchUpdateAlertView.BgView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)dismiss{
    
    [UIView animateWithDuration:0.25f animations:^{
        _SearchUpdateAlertView.BgView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

+ (void)showWithData:(NSDictionary*)dict view:(UIView *)view SkipUIIdentifier: (NSString*) SkipUIIdentifier withTypeblock:(StoreTypeBlock)Typeblock{
    
    _SearchUpdateAlertView = [FNPasteSearchUpdateAlertView shareInstance];
    _SearchUpdateAlertView.storeTypeBlock=Typeblock;
    
    if ([SkipUIIdentifier isEqualToString:@"buy_rebate_store"]) {
//        FNIntegralMallDetailModel *model = [FNIntegralMallDetailModel mj_objectWithKeyValues:dict];
        
        NSArray *goods_imgs = dict[@"goods_img"];
        if (goods_imgs.count > 0) {
            [_SearchUpdateAlertView.ImageView sd_setImageWithURL:URL(goods_imgs[0]) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [_SearchUpdateAlertView.ImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                    if (image) {
                        make.height.mas_equalTo((XYScreenWidth - 120) * image.size.height / image.size.width);
                    } else {
                        make.height.mas_equalTo(0);
                    }
                }];
                
            }];
        }
        
        NSString *fanli = dict[@"fanli"];
        NSString *fanli_bg = dict[@"fanli_bg"];
        
        if (![fanli kr_isNotEmpty]) {
            _SearchUpdateAlertView.lblFan.hidden = YES;
            _SearchUpdateAlertView.imgQuan.hidden = YES;
        }
        [_SearchUpdateAlertView.imgQuan sd_setImageWithURL: URL(fanli_bg)];
        _SearchUpdateAlertView.lblQuan.text = fanli;
        
        _SearchUpdateAlertView.lblPrice.text = [NSString stringWithFormat:@"￥%@", dict[@"goods_price"]];
        _SearchUpdateAlertView.lblOriginPrice.text = [NSString stringWithFormat:@"￥%@", dict[@"goods_cost_price"]];
        
        [_SearchUpdateAlertView.searchBtn setImage:IMAGE(@"home_search_alert_button") forState: UIControlStateNormal];
    } else {
        FNIntegralMallDetailModel *model = [FNIntegralMallDetailModel mj_objectWithKeyValues:dict];

        [_SearchUpdateAlertView.ImageView sd_setImageWithURL:URL(model.goods_img) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [_SearchUpdateAlertView.ImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                if (image) {
                    make.height.mas_equalTo((XYScreenWidth - 120) * image.size.height / image.size.width);
                } else {
                    make.height.mas_equalTo(0);
                }
            }];
            
        }];
        
        if ([model.is_hide_fl isEqualToString:@"1"] || [model.f_str isEqualToString:@""]) {
            _SearchUpdateAlertView.lblFan.hidden = YES;
            _SearchUpdateAlertView.imgQuan.hidden = YES;
        }
        [_SearchUpdateAlertView.imgQuan sd_setImageWithURL: URL(model.goods_fanli_bjimg)];
        _SearchUpdateAlertView.lblQuan.text = model.f_str;

        _SearchUpdateAlertView.lblPrice.text = [NSString stringWithFormat:@"￥%@", model.price];
        _SearchUpdateAlertView.lblOriginPrice.text = [NSString stringWithFormat:@"￥%@", model.goods_cost_price];

        [_SearchUpdateAlertView.searchBtn setImage:IMAGE(@"home_search_alert_button") forState: UIControlStateNormal];
    }
    
    [view addSubview:_SearchUpdateAlertView];
    [_SearchUpdateAlertView showAnimation];
    
}

+ (void)dismiss {
    [[FNPasteSearchUpdateAlertView shareInstance] removeFromSuperview];
}

@end
