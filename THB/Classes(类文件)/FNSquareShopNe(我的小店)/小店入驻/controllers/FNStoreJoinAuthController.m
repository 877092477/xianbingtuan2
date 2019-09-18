//
//  FNStoreJoinAuthController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/20.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreJoinAuthController.h"
#import "TZImagePickerController/TZImagePickerController.h"
#import "FNStoreJoinBusinessController.h"

@interface FNStoreJoinAuthController ()<TZImagePickerControllerDelegate>

@property (nonatomic, strong) UIView *vBottom;
@property (nonatomic, strong) UIView *vIndex;
@property (nonatomic, strong) UILabel *lblIndex;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;
@property (nonatomic, strong) UIButton *btnConfirm;

@property (nonatomic, strong) UIButton *btnTop;
@property (nonatomic, strong) UIImageView *imgTop;
@property (nonatomic, strong) UIButton *btnCloseTop;

@property (nonatomic, strong) UIButton *btnBottom;
@property (nonatomic, strong) UIImageView *imgBottom;
@property (nonatomic, strong) UIButton *btnCloseBottom;

@property (nonatomic, assign) BOOL isTop;

@property (nonatomic, strong) UIImage *image1;
@property (nonatomic, strong) UIImage *image2;

@end

@implementation FNStoreJoinAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
    self.view.backgroundColor = RGB(240, 240, 240);
    self.isTop = YES;
    [self configUI];
}

- (void)configUI {
    _vBottom = [[UIView alloc] init];
    _vIndex = [[UIView alloc] init];
    _lblIndex = [[UILabel alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _btnConfirm = [[UIButton alloc] init];
    
    [self.view addSubview:_vBottom];
    [_vBottom addSubview:_vIndex];
    [_vIndex addSubview:_lblIndex];
    [_vBottom addSubview:_lblTitle];
    [_vBottom addSubview:_lblDesc];
    [_vBottom addSubview:_btnConfirm];
    
    [_vBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    [_vIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@20);
        make.width.height.mas_equalTo(18);
    }];
    [_lblIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vIndex.mas_right).offset(8);
        make.centerY.equalTo(self.vIndex);
        make.right.lessThanOrEqualTo(@-20);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.vIndex.mas_bottom).offset(10);
        make.right.lessThanOrEqualTo(@-20);
    }];
    
    [_btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblDesc.mas_bottom).offset(20);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.bottom.equalTo(isIphoneX ? @-54 : @-20);
        make.height.mas_equalTo(50);
    }];
    
    _vBottom.backgroundColor = UIColor.whiteColor;
    
    _vIndex.cornerRadius = 9;
    _vIndex.backgroundColor = RGB(240, 52, 38);
    
    _lblIndex.textColor = UIColor.whiteColor;
    _lblIndex.font = kFONT14;
    _lblIndex.text = @"2";
    
    _lblTitle.textColor = RGB(24, 24, 24);
    _lblTitle.font = kFONT14;
    _lblTitle.text = @"法定代表人手持身份证正反面";
    
    _lblDesc.textColor = RGB(60, 60, 60);
    _lblDesc.font = kFONT12;
    _lblDesc.numberOfLines = 0;
    _lblDesc.text = @"需清晰展示人物五官及身份证信息\n需拍摄手持身份证反面\n不可自拍、不可只拍身份证";
    
    _btnConfirm.backgroundColor = RGB(200, 200, 200);
    _btnConfirm.enabled = NO;
    [_btnConfirm setTitle: @"确认上传" forState: UIControlStateNormal];
    [_btnConfirm setTitleColor: UIColor.whiteColor forState: UIControlStateNormal];
    _btnConfirm.cornerRadius = 5;
//    [_btnConfirm addTarget:self action:@selector(checkCode) forControlEvents:UIControlEventTouchUpInside];
    
    _btnTop = [[UIButton alloc] init];
    _imgTop = [[UIImageView alloc] init];
    _btnCloseTop = [[UIButton alloc] init];
    _btnBottom = [[UIButton alloc] init];
    _imgBottom = [[UIImageView alloc] init];
    _btnCloseBottom = [[UIButton alloc] init];
    
    [self.view addSubview:_btnTop];
    [self.view addSubview:_imgTop];
    [self.view addSubview:_btnCloseTop];
    [self.view addSubview:_btnBottom];
    [self.view addSubview:_imgBottom];
    [self.view addSubview:_btnCloseBottom];
    
    [_btnTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.right.equalTo(@-30);
        make.top.equalTo(@30);
    }];
    [_imgTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.btnTop);
        make.left.top.greaterThanOrEqualTo(self.btnTop).offset(20);
        make.bottom.right.lessThanOrEqualTo(self.btnTop).offset(-20);
    }];
    [_btnCloseTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgTop).offset(8);
        make.right.equalTo(self.imgTop).offset(-8);
    }];
    
    [_btnBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.right.equalTo(@-30);
        make.top.equalTo(self.btnTop.mas_bottom).offset(30);
        make.bottom.equalTo(self.vBottom.mas_top).offset(-30);
        make.height.equalTo(self.btnTop);
    }];
    [_imgBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.btnBottom);
        make.left.top.greaterThanOrEqualTo(self.btnBottom).offset(20);
        make.bottom.right.lessThanOrEqualTo(self.btnBottom).offset(-20);
    }];
    [_btnCloseBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgBottom).offset(8);
        make.right.equalTo(self.imgBottom).offset(-8);
    }];
    
    _btnTop.layer.backgroundColor = UIColor.whiteColor.CGColor;
    _btnTop.layer.cornerRadius = 5;
    _btnTop.layer.borderWidth = 3;
    _btnTop.layer.borderColor = RGB(42, 152, 244).CGColor;
    _btnTop.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [_btnTop setImage: IMAGE(@"store_join_add_card_1") forState: UIControlStateNormal];
    [_btnTop setImage: IMAGE(@"store_join_add_card_1") forState: UIControlStateHighlighted];
    [_btnTop setTitle:@"上传手持身份证正面" forState: UIControlStateNormal];
    [_btnTop setTitleColor:RGB(42, 152, 244) forState: UIControlStateNormal];
    [_btnTop layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:20];
    
    _imgTop.image = IMAGE(@"store_join_add");
    _imgTop.contentMode = UIViewContentModeScaleAspectFit;
    [_btnCloseTop setImage: IMAGE(@"store_join_button_close") forState: UIControlStateNormal];
    _btnCloseTop.hidden = YES;
    
    _btnBottom.layer.backgroundColor = UIColor.whiteColor.CGColor;
    _btnBottom.layer.cornerRadius = 5;
    _btnBottom.layer.borderWidth = 3;
    _btnBottom.layer.borderColor = RGB(42, 152, 244).CGColor;

    _btnBottom.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [_btnBottom setImage: IMAGE(@"store_join_add_card_2") forState: UIControlStateNormal];
    [_btnBottom setImage: IMAGE(@"store_join_add_card_2") forState: UIControlStateHighlighted];
    [_btnBottom setTitle:@"上传手持身份证反面" forState: UIControlStateNormal];
    [_btnBottom setTitleColor:RGB(42, 152, 244) forState: UIControlStateNormal];
    [_btnBottom layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:20];
    
    _imgBottom.image = IMAGE(@"store_join_add");
    _imgBottom.contentMode = UIViewContentModeScaleAspectFit;
    [_btnCloseBottom setImage: IMAGE(@"store_join_button_close") forState: UIControlStateNormal];
    _btnCloseBottom.hidden = YES;
    
    [_btnConfirm addTarget:self action:@selector(addBusiness) forControlEvents:UIControlEventTouchUpInside];
    [_btnTop addTarget:self action:@selector(addTopImage) forControlEvents:UIControlEventTouchUpInside];
    [_btnCloseTop addTarget:self action:@selector(addTopClose) forControlEvents:UIControlEventTouchUpInside];
    [_btnBottom addTarget:self action:@selector(addBottomImage) forControlEvents:UIControlEventTouchUpInside];
    [_btnCloseBottom addTarget:self action:@selector(addBottomClose) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addTopImage {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowTakePicture = YES;
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowCrop = NO;
//    CGFloat height = XYScreenWidth * 3.0 / 4;
//    imagePickerVc.cropRect = CGRectMake(0, (XYScreenHeight - height) / 2, XYScreenWidth, height);
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    _isTop = YES;
}

- (void)addBottomImage {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowTakePicture = YES;
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowCrop = NO;
//    CGFloat height = XYScreenWidth * 3.0 / 4;
//    imagePickerVc.cropRect = CGRectMake(0, (XYScreenHeight - height) / 2, XYScreenWidth, height);
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    _isTop = NO;
}

- (void)addTopClose {
    _imgTop.image = IMAGE(@"store_join_add");
    _btnCloseTop.hidden = YES;
    _image1 = nil;
}

- (void)addBottomClose {
    _imgBottom.image = IMAGE(@"store_join_add");
    _btnCloseBottom.hidden = YES;
    _image2 = nil;
}

- (void)addBusiness {
    FNStoreJoinBusinessController *vc = [[FNStoreJoinBusinessController alloc] init];
    
    if (_params) {
        _params[@"img2"] = _image1;
        _params[@"img3"] = _image2;
        vc.params = _params;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    if (photos.count <= 0)
        return;
    if (_isTop) {
        _imgTop.image = photos[0];
        _image1 = photos[0];
        _btnCloseTop.hidden = NO;
    } else {
        _imgBottom.image = photos[0];
        _image2 = photos[0];
        _btnCloseBottom.hidden = NO;
    }
    [self checkNext];
}

- (void)checkNext {
    if (_image1 && _image2) {
        _btnConfirm.enabled = YES;
        _btnConfirm.backgroundColor = RGB(255, 56, 46);
    } else {
        _btnConfirm.enabled = NO;
        _btnConfirm.backgroundColor = RGB(200, 200, 200);
    }
}

@end
