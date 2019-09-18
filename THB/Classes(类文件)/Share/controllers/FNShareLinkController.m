//
//  FNShareLinkController.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/3.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNShareLinkController.h"

#import "FNShareListView.h"
#import "FNShareMixModel.h"
#import "HXPhotoTools.h"

@interface FNShareLinkController ()<UICollectionViewDelegate, UICollectionViewDataSource, FNShareListViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UIView *vContent;

@property (nonatomic, strong) UILabel *lblStyle;
@property (nonatomic, strong) UIView *vLink;
@property (nonatomic, strong) UILabel *lblShareTitle;
@property (nonatomic, strong) UILabel *lblShareContent;
@property (nonatomic, strong) UIImageView *imgGoods;
@property (nonatomic, strong) UIView *vLine4;

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *txvContent;
@property (nonatomic, strong) UIView *vLine1;
@property (nonatomic, strong) UIView *vLine2;

@property (nonatomic, strong) UIButton *btnCopy;
@property (nonatomic, strong) UIView *vLine3;

@property (nonatomic, strong) FNShareListView *shareView;
@property (nonatomic, strong) NSMutableArray<NSString*> *checks;

@property (nonatomic, strong) FNShareMixModel *model;


@end

@implementation FNShareLinkController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _checks = [[NSMutableArray alloc] init];
    [self configUI];
}

- (void)configUI {
    
    _scrollview = [[UIScrollView alloc] init];
    _vContent = [[UIView alloc] init];
    
    _lblStyle = [[UILabel alloc] init];
    _vLink = [[UIView alloc] init];
    _lblShareTitle = [[UILabel alloc] init];
    _lblShareContent = [[UILabel alloc] init];
    _imgGoods = [[UIImageView alloc] init];
    _vLine4 = [[UIView alloc] init];
    
    _lblTitle = [[UILabel alloc] init];
    _txvContent = [[UILabel alloc] init];
    _vLine1 = [[UIView alloc] init];
    _vLine2 = [[UIView alloc] init];
    _btnCopy = [[UIButton alloc] init];
    _vLine3 = [[UIView alloc] init];
    _shareView = [[FNShareListView alloc] init];

    [self.view addSubview:_scrollview];
    [_scrollview addSubview:_vContent];
    
    [_vContent addSubview:_lblStyle];
    [_vContent addSubview:_vLink];
    [_vLink addSubview:_lblShareTitle];
    [_vLink addSubview:_lblShareContent];
    [_vLink addSubview:_imgGoods];
    [_vContent addSubview:_vLine4];
    
    [_vContent addSubview:_lblTitle];
    [_vContent addSubview:_txvContent];
    [_vContent addSubview:_vLine1];
    [_vContent addSubview:_vLine2];
    [_vContent addSubview:_btnCopy];
    [_vContent addSubview:_vLine3];
    [self.view addSubview: _shareView];
    
    [_scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.bottom.equalTo(self.shareView.mas_top);
        
    }];
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        make.width.equalTo(self.view);
        //        make.height.equalTo(self.view);
    }];
    [_vLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.height.mas_equalTo(1);
        make.left.right.equalTo(@0);
    }];
    
    [_lblStyle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.top.equalTo(@15);
        make.right.lessThanOrEqualTo(@-50);
    }];
    [_vLink mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.top.equalTo(self.lblStyle.mas_bottom).offset(10);
        make.right.equalTo(@-45);
        make.height.mas_lessThanOrEqualTo(112);
    }];
    [_lblShareTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.right.lessThanOrEqualTo(@-18);
    }];
    [_lblShareContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(self.lblShareTitle.mas_bottom).offset(8);
        make.right.equalTo(self.imgGoods.mas_left).offset(-28);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    [_imgGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblShareTitle.mas_bottom).offset(8);
        make.right.equalTo(@-12);
        make.width.height.mas_equalTo(54);
        make.bottom.equalTo(@-10);
    }];
    [_vLine4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLink.mas_bottom).offset(10);
        make.height.mas_equalTo(4);
        make.left.right.equalTo(@0);
    }];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.lessThanOrEqualTo(@-16);
        make.top.equalTo(self.vLine4.mas_bottom).offset(20);
    }];
    [_txvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(18);
        make.right.equalTo(@-20);
//        make.height.mas_equalTo(160);
    }];
    
    [_vLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txvContent.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
        make.left.right.equalTo(@0);
    }];
    [_btnCopy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-15);
        make.height.mas_equalTo(24);
        make.top.equalTo(self.vLine2.mas_bottom).offset(9);
    }];
    [_btnCopy.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnCopy).offset(10);
        make.right.equalTo(self.btnCopy).offset(-10);
        make.center.equalTo(self.btnCopy);
    }];
    [_vLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnCopy.mas_bottom).offset(15);
        make.height.mas_equalTo(4);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    [_shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(isIphoneX ? @-34 : @0);
        make.height.mas_equalTo(130);
    }];
    
    _scrollview.bounces = NO;
    
    _lblStyle.font = kFONT14;
    _lblStyle.textColor = RGB(51, 51, 51);
    
    _vLink.layer.cornerRadius = 4;
    _vLink.layer.borderWidth = 1;
    _vLink.layer.borderColor = RGBA(204, 204, 204, 0.5).CGColor;
    
    _lblShareTitle.font = [UIFont boldSystemFontOfSize:14];
    _lblShareTitle.textColor = RGB(51, 51, 51);
    
    _lblShareContent.font = kFONT13;
    _lblShareContent.textColor = RGB(153, 153, 153);
    _txvContent.numberOfLines = 0;
    
    _lblTitle.numberOfLines = 2;
    
    _txvContent.font = kFONT13;
    _txvContent.textColor = RGB(153, 153, 153);
    _txvContent.numberOfLines = 0;
//    _txvContent.enable = NO;
    
    _vLine1.backgroundColor = RGB(240, 240, 240);
    _vLine2.backgroundColor = RGB(240, 240, 240);
    _vLine3.backgroundColor = RGB(240, 240, 240);
    _vLine4.backgroundColor = RGB(240, 240, 240);
    
    _btnCopy.layer.cornerRadius = 12;
    _btnCopy.titleLabel.font = kFONT14;
    [_btnCopy addTarget:self action:@selector(onCopyClick) forControlEvents:UIControlEventTouchUpInside];
    
    _shareView.delegate = self;
    
    [self apiRequestcData];
}

- (void) updateView {
    if (self.model == nil)
        return;
    
    _lblTitle.text = self.model.goods_title;
    _txvContent.text = self.model.content;
    
    [_btnCopy setTitleColor: [UIColor colorWithHexString: self.model.color_copy] forState: UIControlStateNormal];
    [_btnCopy setTitle: self.model.str_copy forState: UIControlStateNormal];
    _btnCopy.layer.backgroundColor = [UIColor colorWithHexString: self.model.bjcolor_copy].CGColor;
    
    _lblStyle.text = self.model.url_title;
    _lblShareTitle.text = self.model.share_title;
    _lblShareContent.text = self.model.share_content;
    [_imgGoods sd_setImageWithURL:URL(self.model.goods_img)];
}

- (void) updateShare {
    if (self.model == nil)
        return;
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (FNShareMixButtonModel *mix in self.model.share_list) {
        [titles addObject: mix.title];
        [images addObject: mix.img];
    }
    [_shareView setImages:images withTitles:titles];
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
        
        [self updateShare];
        [self updateView];
        
    } failure:^(NSString *error) {
        
    } isHideTips:NO];
}

#pragma mark - Action

- (void)onCopyClick {
    if (![_txvContent.text kr_isNotEmpty])
        return;
    
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    [pab setString:_txvContent.text];
    if (pab == nil) {
        [FNTipsView showTips:@"复制失败"];
    }else{
        [FNTipsView showTips:@"复制成功"];
    }
}

#pragma mark - FNShareListViewDelegate
- (void)shareListView: (FNShareListView*)view didClickAt: (NSInteger) index {
    FNShareMixButtonModel *model = self.model.share_list[index];
    
    if ([model.type isEqualToString:@"copy_url"]) {
        
        UIPasteboard *pab = [UIPasteboard generalPasteboard];
        [pab setString:self.model.share_url];
        [FNTipsView showTips:@"复制成功"];
        
    } else if ([model.type isEqualToString:@"share_url"]) {
        
        UMSocialPlatformType type=UMSocialPlatformType_WechatSession;
        if ([model.share_platform isEqualToString:@"wechat"]) {
            type=UMSocialPlatformType_WechatSession;
        }else if ([model.share_platform isEqualToString:@"wechat_circle"]) {
            type=UMSocialPlatformType_WechatTimeLine;
        }else if ([model.share_platform isEqualToString:@"qq"]) {
            type=UMSocialPlatformType_QQ;
        }else if ([model.share_platform isEqualToString:@"sina"]) {
            type=UMSocialPlatformType_Sina;
        }
        
        [SDWebImageManager.sharedManager downloadImageWithURL:URL(self.model.goods_img) options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            [self umengShareWithURL:self.model.share_url image:image shareTitle:self.model.share_title andInfo:nil withType:type];
        }];
        
    }
    
    
}


@end
