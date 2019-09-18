//
//  FNMyVideoCardDetailController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNMyVideoCardDetailController.h"
#import "FNMyVideoCardModel.h"

@interface FNMyVideoCardDetailController ()

@property (nonatomic, strong) FNMyVideoCardModel *model;

@property (nonatomic, strong) UIImageView *imgBackground;
@property (nonatomic, strong) UILabel *lblTitleCode;
@property (nonatomic, strong) UILabel *lblTitleTime;
@property (nonatomic, strong) UIButton *btnCopy;
@property (nonatomic, strong) UIImageView *imgCode;
@property (nonatomic, strong) UILabel *lblCode;
@property (nonatomic, strong) UIButton *btnSave;

@end

@implementation FNMyVideoCardDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"卡密详情";
    [self requestDetail];
    [self configUI];
}

- (void)configUI {
    _imgBackground = [[UIImageView alloc] init];
    _lblTitleCode = [[UILabel alloc] init];
    _lblTitleTime = [[UILabel alloc] init];
    _btnCopy = [[UIButton alloc] init];
    _imgCode = [[UIImageView alloc] init];
    _lblCode = [[UILabel alloc] init];
    _btnSave = [[UIButton alloc] init];
    
    [self.view addSubview:_imgBackground];
    [self.view addSubview:_lblTitleCode];
    [self.view addSubview:_lblTitleTime];
    [self.view addSubview:_btnCopy];
    [self.view addSubview:_imgCode];
    [self.view addSubview:_lblCode];
    [self.view addSubview:_btnSave];
    
    [_imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@14);
        make.top.equalTo(@14);
//        make.right.equalTo(@-14);
        make.centerX.equalTo(@0);
        make.width.mas_equalTo(XYScreenWidth - 28);
        make.height.equalTo(self.imgBackground.mas_width).dividedBy(1);
    }];
    [_lblTitleCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgBackground).offset(30);
        make.top.equalTo(self.imgBackground).offset(40);
        make.right.lessThanOrEqualTo(self.btnCopy.mas_left).offset(-10);
    }];
    [_lblTitleTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgBackground).offset(30);
        make.top.equalTo(self.lblTitleCode.mas_bottom).offset(4);
        make.right.lessThanOrEqualTo(self.btnCopy.mas_left).offset(-10);
    }];
    [_btnCopy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imgBackground).offset(-20);
        make.top.equalTo(self.imgBackground).offset(34);
    }];
    [_imgCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imgBackground);
        make.width.mas_lessThanOrEqualTo(150);
        make.height.mas_lessThanOrEqualTo(150);
        
        make.bottom.equalTo(self.lblCode.mas_top).offset(-10);
    }];
    [_lblCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imgBackground);
        make.left.greaterThanOrEqualTo(self.imgBackground).offset(30);
        make.right.lessThanOrEqualTo(self.imgBackground).offset(-30);
        make.bottom.equalTo(self.btnSave.mas_top).offset(-10);
    }];
    [_btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imgBackground);
        make.bottom.equalTo(self.imgBackground).offset(-20);
        make.height.mas_equalTo(30);
    }];
    
    _lblTitleCode.font = kFONT14;
    _lblTitleTime.font = kFONT14;
    
    _lblCode.font = kFONT12;
    _lblCode.textColor = RGB(153, 153, 153);
    
    _btnSave.contentEdgeInsets = UIEdgeInsetsMake(2, 20, 2, 20);
    _btnSave.titleLabel.font = kFONT12;
    [_btnSave addTarget:self action:@selector(onSaveClick)];
    
    _btnCopy.contentEdgeInsets = UIEdgeInsetsMake(8, 20, 8, 20);
    _btnCopy.titleLabel.font = kFONT12;
    [_btnCopy addTarget:self action:@selector(onCopyClick)];
}

#pragma mark - Networking
- (FNRequestTool *)requestDetail {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token":UserAccessToken,  @"id": _cardId}];
    @weakify(self)
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=app_movie_order&ctrl=detail" respondType:(ResponseTypeModel) modelType:@"FNMyVideoCardModel" success:^(id respondsObject) {
        @strongify(self)
        self.model = respondsObject;
        
        self.lblTitleCode.text = [NSString stringWithFormat:@"卡密：%@", self.model.code];
        self.lblTitleTime.text = self.model.time_str;
        @weakify(self)
        [self.imgBackground sd_setImageWithURL:URL(self.model.detail_bjimg) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            @strongify(self)
            if (image && error == nil) {
                [self.imgBackground mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(self.imgBackground.mas_width).dividedBy(image.size.width / image.size.height);
                }];
            }
        }];
        self.lblTitleCode.textColor = [UIColor colorWithHexString:self.model.code_color];
        self.lblTitleTime.textColor = [UIColor colorWithHexString:self.model.code_color];
        [self.imgCode sd_setImageWithURL:URL(self.model.code_url)];
        self.lblCode.text = self.model.code_str;
        [self.btnSave setTitle:self.model.save_str forState:UIControlStateNormal];
        [self.btnSave setTitleColor:[UIColor colorWithHexString:self.model.save_color] forState:UIControlStateNormal];
        [self.btnSave sd_setBackgroundImageWithURL:URL(self.model.save_img) forState:UIControlStateNormal];
        [self.btnCopy setTitle:self.model.str_copy forState:UIControlStateNormal];
        [self.btnCopy setTitleColor:[UIColor colorWithHexString:self.model.color_copy] forState:UIControlStateNormal];
        [self.btnCopy sd_setBackgroundImageWithURL:URL(self.model.img_copy) forState:UIControlStateNormal];
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache:NO];
}

#pragma mark - Action

- (void)onCopyClick {
    if (self.model) {
        [FNTipsView showTips:@"复制成功"];
        [[UIPasteboard generalPasteboard] setString:self.model.code];
    }
}

- (void)onSaveClick {
    if (self.model) {
        [SVProgressHUD show];
        [XYNetworkAPI downloadImages:@[self.model.code_url] withFinishedBlock:^(NSArray<UIImage *> *images) {
            
            if (images.count == 1) {
                UIImage *image = images[0];
                UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
            }
            else {
                [SVProgressHUD dismiss];
                [FNTipsView showTips:@"保存失败，请稍后再试"];
            }
        }];
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    [SVProgressHUD dismiss];
    if (error) {
        [FNTipsView showTips:error.localizedDescription];
    } else {
        [FNTipsView showTips:@"保存成功"];
    }
}

@end
