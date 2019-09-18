//
//  FNShareMiniProgramController.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/3.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNShareMiniProgramController.h"
#import "FNShareMixModel.h"
#import "WechatOpenSDK/WXApi.h"

@interface FNShareMiniProgramController ()

@property (nonatomic, strong) FNShareMixModel *model;

@property (nonatomic, strong) UIView *vLine1;
@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UIImageView *imgIco;
@property (nonatomic, strong) UILabel *lblIco;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIImageView *imgGoods;
@property (nonatomic, strong) UIView *vLine2;
@property (nonatomic, strong) UIImageView *imgLogo;
@property (nonatomic, strong) UILabel *lblLogo;
@property (nonatomic, strong) UIButton *btnShare;

@end

@implementation FNShareMiniProgramController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    [self apiRequestcData];
}



- (void) configUI {
    _vLine1 = [[UILabel alloc] init];
    _vContent = [[UIView alloc] init];
    _imgIco = [[UIImageView alloc] init];
    _lblIco = [[UILabel alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _imgGoods = [[UIImageView alloc] init];
    _vLine2 = [[UILabel alloc] init];
    _imgLogo = [[UIImageView alloc] init];
    _lblLogo = [[UILabel alloc] init];
    _btnShare = [[UIButton alloc] init];
    
    [self.view addSubview:_vLine1];
    [self.view addSubview:_vContent];
    [_vContent addSubview:_imgIco];
    [_vContent addSubview:_lblIco];
    [_vContent addSubview:_lblTitle];
    [_vContent addSubview:_imgGoods];
    [_vContent addSubview:_vLine2];
    [_vContent addSubview:_imgLogo];
    [_vContent addSubview:_lblLogo];
    [self.view addSubview:_btnShare];
    
    [_vLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.height.mas_equalTo(1);
        make.left.right.equalTo(@0);
    }];
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.left.equalTo(@50);
        make.right.equalTo(@-50);
    }];
    [_imgIco mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.top.equalTo(@11);
        make.width.height.mas_equalTo(14);
    }];
    [_lblIco mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgIco.mas_right).offset(5);
        make.centerY.equalTo(self.imgIco);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.right.lessThanOrEqualTo(@-12);
        make.top.equalTo(self.imgIco.mas_bottom).offset(8);
    }];
    [_imgGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.right.equalTo(@-5);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(8);
        make.width.equalTo(self.imgGoods.mas_height);
    }];
    [_vLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.imgGoods.mas_bottom).offset(8);
    }];
    [_imgLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.top.equalTo(self.vLine2.mas_bottom).offset(6);
        make.bottom.equalTo(@-6);
        make.height.width.mas_equalTo(10);
    }];
    [_lblLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgLogo.mas_right);
        make.centerY.equalTo(self.imgLogo);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.right.equalTo(@-50);
        make.height.mas_equalTo(44);
        make.top.equalTo(self.vContent.mas_bottom).offset(50);
    }];
    
    _vLine1.backgroundColor = RGBA(204, 204, 204, 0.5);
    
    _vContent.layer.cornerRadius = 4;
    _vContent.layer.borderWidth = 1;
    _vContent.layer.borderColor = RGBA(204, 204, 204, 0.5).CGColor;
    
    _lblIco.font = kFONT12;
    _lblIco.textColor = RGB(153, 153, 153);
    
    _lblTitle.font = [UIFont systemFontOfSize:18];
    _lblTitle.textColor = RGB(51, 51, 51);
    
    _vLine2.backgroundColor = RGBA(204, 204, 204, 0.5);

    _lblLogo.font = kFONT10;
    _lblLogo.textColor = RGB(153, 153, 153);
    
//    _btnShare;
    [_btnShare addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)updateView {
    if (self.model == nil)
        return;
    
    [_imgIco sd_setImageWithURL:URL(self.model.mini_ico)];
    _lblIco.text = self.model.mini_title;
    
    _lblTitle.text = self.model.goods_title;
    [_imgGoods sd_setImageWithURL:URL(self.model.goods_img)];
    
    [_imgLogo sd_setImageWithURL:URL(self.model.mini_ico1)];
    _lblLogo.text = self.model.mini_label;
    
    [_btnShare setTitle: self.model.mini_share_str forState: UIControlStateNormal];
    [_btnShare setTitleColor: [UIColor colorWithHexString: self.model.mini_share_color] forState: UIControlStateNormal];
    _btnShare.layer.backgroundColor = [UIColor colorWithHexString: self.model.mini_share_bjcolor].CGColor;
    _btnShare.layer.cornerRadius = 22;
}

#pragma mark - Networking

- (FNRequestTool *)apiRequestcData{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token": UserAccessToken}];
    if(self.SkipUIIdentifier){
        params[@"SkipUIIdentifier"]=self.SkipUIIdentifier;
    }
    if(self.fnuo_id){
        params[@"gid"]=self.fnuo_id;
    }
    if(self.type){
        params[@"type"]=self.type;
    }
    NSLog(@"searSkipUIIdentifier:%@",self.SkipUIIdentifier);
    @weakify(self)
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=share_model&ctrl=index" respondType:(ResponseTypeModel) modelType:@"FNShareMixModel" success:^(id respondsObject) {
        @strongify(self)
        
        self.model = respondsObject;
        
        [self updateView];
        
    } failure:^(NSString *error) {
        
    } isHideTips:NO];
}

#pragma mark - Action

- (void)shareClick: (id) sender {
    if (self.model == nil)
        return;
    
    if ([self.model.miniprogram_share_type isEqualToString:@"1"]) {
        
        UMSocialPlatformType type=UMSocialPlatformType_WechatSession;

        [SDWebImageManager.sharedManager downloadImageWithURL:URL(self.model.goods_img) options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            [self umengShareWithURL:nil image:image shareTitle:nil andInfo:nil withType:type];
        }];
        
    } else {
        @weakify(self)
        [SDWebImageManager.sharedManager downloadImageWithURL:URL(self.model.goods_img) options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            @strongify(self)
            [self shareMiniProgram: self.model.share_title content: self.model.share_content image: image username:self.model.username path: self.model.share_url webpageUrl: self.model.webpageUrl];
            
        }];
    }
    
    
}



@end
