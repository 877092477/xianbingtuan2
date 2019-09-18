//
//  FNStoreJoinBusinessController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/20.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreJoinBusinessController.h"
#import "TZImagePickerController/TZImagePickerController.h"

@interface FNStoreJoinBusinessController ()

@property (nonatomic, strong) UIView *vBottom;
@property (nonatomic, strong) UIView *vIndex;
@property (nonatomic, strong) UILabel *lblIndex;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;
@property (nonatomic, strong) UIButton *btnConfirm;

@property (nonatomic, strong) UIButton *btnTop;
@property (nonatomic, strong) UIImageView *imgTop;
@property (nonatomic, strong) UIButton *btnCloseTop;

@property (nonatomic, strong) UIImage *image1;

@end

@implementation FNStoreJoinBusinessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
    self.view.backgroundColor = RGB(240, 240, 240);
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
    _lblIndex.text = @"3";
    
    _lblTitle.textColor = RGB(24, 24, 24);
    _lblTitle.font = kFONT14;
    _lblTitle.text = @"营业执照";
    
    _lblDesc.textColor = RGB(60, 60, 60);
    _lblDesc.font = kFONT12;
    _lblDesc.numberOfLines = 0;
    _lblDesc.text = @"需文字清晰、边框完整、露出国徽\n复印件需加盖印章\n也可提供监管部门认可的具有营业执照\n同等法律效力的证件";
    
    _btnConfirm.backgroundColor = RGB(200, 200, 200);
    _btnConfirm.enabled = NO;
    [_btnConfirm setTitle: @"开店申请" forState: UIControlStateNormal];
    [_btnConfirm setTitleColor: UIColor.whiteColor forState: UIControlStateNormal];
    _btnConfirm.cornerRadius = 5;
    //    [_btnConfirm addTarget:self action:@selector(checkCode) forControlEvents:UIControlEventTouchUpInside];
    
    _btnTop = [[UIButton alloc] init];
    _imgTop = [[UIImageView alloc] init];
    _btnCloseTop = [[UIButton alloc] init];

    
    [self.view addSubview:_btnTop];
    [self.view addSubview:_imgTop];
    [self.view addSubview:_btnCloseTop];

    
    [_btnTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.right.equalTo(@-30);
        make.top.equalTo(@30);
        make.bottom.equalTo(self.vBottom.mas_top).offset(-20);
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
    
    
    _btnTop.layer.backgroundColor = UIColor.whiteColor.CGColor;
    _btnTop.layer.cornerRadius = 5;
    _btnTop.layer.borderWidth = 3;
    _btnTop.layer.borderColor = RGB(42, 152, 244).CGColor;
    _btnTop.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [_btnTop setImage: IMAGE(@"store_join_add_business") forState: UIControlStateNormal];
    [_btnTop setImage: IMAGE(@"store_join_add_business") forState: UIControlStateHighlighted];
    [_btnTop setTitle:@"上传店铺营业执照" forState: UIControlStateNormal];
    [_btnTop setTitleColor:RGB(42, 152, 244) forState: UIControlStateNormal];
    [_btnTop layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:20];
    
    _imgTop.image = IMAGE(@"store_join_add");
    _imgTop.contentMode = UIViewContentModeScaleAspectFit;
    [_btnCloseTop setImage: IMAGE(@"store_join_button_close") forState: UIControlStateNormal];
    _btnCloseTop.hidden = YES;
    
   
    
    [_btnConfirm addTarget:self action:@selector(addBusiness) forControlEvents:UIControlEventTouchUpInside];
    [_btnTop addTarget:self action:@selector(addTopImage) forControlEvents:UIControlEventTouchUpInside];
    [_btnCloseTop addTarget:self action:@selector(addTopClose) forControlEvents:UIControlEventTouchUpInside];

}

- (void)addTopImage {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowTakePicture = YES;
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowCrop = NO;
//    CGFloat height = XYScreenWidth * 4.0 / 3;
//    imagePickerVc.cropRect = CGRectMake(0, (XYScreenHeight - height) / 2, XYScreenWidth, height);
    [self presentViewController:imagePickerVc animated:YES completion:nil];

}


- (void)addTopClose {
    _imgTop.image = IMAGE(@"store_join_add");
    _btnCloseTop.hidden = YES;
    _image1 = nil;
}


- (void)addBusiness {
    [self requestCreate];
}

#pragma mark - TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    if (photos.count <= 0)
        return;

    _imgTop.image = photos[0];
    _image1 = photos[0];
    _btnCloseTop.hidden = NO;

    [self checkNext];
}

- (void)checkNext {
    if (_image1) {
        _btnConfirm.enabled = YES;
        _btnConfirm.backgroundColor = RGB(255, 56, 46);
    } else {
        _btnConfirm.enabled = NO;
        _btnConfirm.backgroundColor = RGB(200, 200, 200);
    }
}

#pragma mark - Networking

- (void)requestCreate{
    if (_params == nil) {
        return;
    }
    UIImage *img1 = _params[@"img1"];
    UIImage *img2 = _params[@"img2"];
    UIImage *img3 = _params[@"img3"];
    
    
    _params[@"img1"] = nil;
    _params[@"img2"] = nil;
    _params[@"img3"] = nil;
    
    
    @weakify(self);
    
    [FNRequestTool uploadImageWithParams:_params api:@"mod=appapi&act=small_store&ctrl=add_store" imageS:@[img1, img2, img3, _image1] success:^(id respondsObject) {
        @strongify(self)
        XYLog(@"dict is %@",respondsObject);
        
        [FNTipsView showTips:@"您的申请已提交"];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
        [XYNetworkAPI cancelAllRequest];
    }];
    
}

@end
