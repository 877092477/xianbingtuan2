//
//  FNStoreJoinFormController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/19.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreJoinFormController.h"
#import "FNStoreJoinCateModel.h"
#import "FNStoreJoinFormItemView.h"
#import "FNStoreJoinTypeView.h"
#import "FNStoreJoinModel.h"
#import "TZImagePickerController/TZImagePickerController.h"
#import "FNRushLocationDeViewController.h"
#import "FNStoreJoinAuthController.h"
#import "FNLocationSelectorViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>

@interface FNStoreJoinFormController()<TZImagePickerControllerDelegate, UITextFieldDelegate, FNRushLocationDeViewControllerDelegate, FNStoreJoinTypeViewDelegate, FNLocationSelectorViewControllerDelegate>

@property (nonatomic, strong) UIScrollView *scvForm;
@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UIButton *btnJoin;

@property (nonatomic, strong) UIImageView *imgHeader;
@property (nonatomic, strong) UILabel *lblHeader;

@property (nonatomic, strong) FNStoreJoinFormItemView *formName;
@property (nonatomic, strong) FNStoreJoinTypeView *typeJoin;
@property (nonatomic, strong) FNStoreJoinTypeView *typeTags;
@property (nonatomic, strong) FNStoreJoinFormItemView *formInvite;
@property (nonatomic, strong) UILabel *lblInvite;
@property (nonatomic, strong) FNStoreJoinFormItemView *formUsername;
@property (nonatomic, strong) FNStoreJoinFormItemView *formNumber;
@property (nonatomic, strong) FNStoreJoinFormItemView *formPhone;
@property (nonatomic, strong) UIButton *btnCode;
@property (nonatomic, strong) FNStoreJoinFormItemView *formCode;
@property (nonatomic, strong) FNStoreJoinFormItemView *formAddress;


@property (nonatomic, strong) FNStoreJoinFormModel *model;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger time;

@property (nonatomic, strong) UIImage *storeImage;
@property (nonatomic, assign) NSInteger currentCateIndex;
//@property (nonatomic, strong) FNHsearchModel* address;
@property (nonatomic, strong) AMapPOI* poi;

@end

@implementation FNStoreJoinFormController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _currentCateIndex = -1;
    [self configUI];
    [self requestMain];
}

- (void)configUI {
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"填写入驻申请";
    
    _scvForm = [[UIScrollView alloc]init];
    _scvForm.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scvForm];
    
    self.btnJoin = [[UIButton alloc] init];
    [self.view addSubview:self.btnJoin];
    
    [_scvForm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.btnJoin.mas_top).offset(-20);
        make.left.right.top.equalTo(@0);
    }];
    
    [self.btnJoin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.bottom.equalTo(isIphoneX ? @-54 : @-20);
        make.height.mas_equalTo(50);
    }];
    
    self.btnJoin.backgroundColor = RGB(200, 200, 200);
    self.btnJoin.enabled = NO;
    [self.btnJoin setTitle: @"下一步" forState: UIControlStateNormal];
    [self.btnJoin setTitleColor: UIColor.whiteColor forState: UIControlStateNormal];
    self.btnJoin.cornerRadius = 5;
    [self.btnJoin addTarget:self action:@selector(checkCode) forControlEvents:UIControlEventTouchUpInside];
    
    _vContent = [[UIView alloc] init];
    _imgHeader = [[UIImageView alloc] init];
    _lblHeader = [[UILabel alloc] init];
    
    [self.scvForm addSubview:_vContent];
    [_vContent addSubview:_imgHeader];
    [_vContent addSubview:_lblHeader];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        make.width.mas_equalTo(XYScreenWidth);
    }];
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@30);
        make.width.height.mas_equalTo(80);
    }];
    [_lblHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.imgHeader.mas_bottom).offset(12);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
    }];
    
    _imgHeader.cornerRadius = 40;
    _imgHeader.contentMode = UIViewContentModeScaleAspectFill;
    _imgHeader.image = IMAGE(@"store_join_button_header");
    _lblHeader.text = @"点击上传店铺头像";
    _lblHeader.textColor = RGB(200, 200, 200);
    _lblHeader.font = kFONT12;
    @weakify(self);
    [_imgHeader addJXTouch:^{
        @strongify(self);
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        imagePickerVc.allowPickingOriginalPhoto = YES;
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.allowPickingImage = YES;
        imagePickerVc.allowTakePicture = YES;
        imagePickerVc.allowTakeVideo = NO;
        imagePickerVc.allowCrop = YES;
        CGFloat height = XYScreenWidth;
        imagePickerVc.cropRect = CGRectMake(0, (XYScreenHeight - height) / 2, XYScreenWidth, height);
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }];
    
    _formName = [[FNStoreJoinFormItemView alloc] init];
    [_vContent addSubview:_formName];
    [_formName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.lblHeader.mas_bottom).offset(30);
        make.bottom.lessThanOrEqualTo(@-20);
    }];
    _formName.lblTitle.text = @"店铺名称";
    _formName.textField.placeholder = @"请输入店铺名称";
    _formName.imgIcon.image = IMAGE(@"store_join_icon_store");
    
    _typeJoin = [[FNStoreJoinTypeView alloc] init];
    [_vContent addSubview:_typeJoin];
    [_typeJoin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.formName.mas_bottom).offset(30);
        make.bottom.lessThanOrEqualTo(@-20);
    }];
    _typeJoin.lblTitle.text = @"选择店铺入驻类型";
    _typeJoin.delegate = self;
    
    _typeTags = [[FNStoreJoinTypeView alloc] init];
    [_vContent addSubview:_typeTags];
    [_typeTags mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.typeJoin.mas_bottom).offset(10);
        make.bottom.lessThanOrEqualTo(@-20);
    }];
//    _typeTags.lblTitle.text = @"选择标签类型";
    _typeTags.delegate = self;

    _formInvite = [[FNStoreJoinFormItemView alloc] init];
    [_vContent addSubview:_formInvite];
    [_formInvite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.typeTags.mas_bottom).offset(30);
        make.bottom.lessThanOrEqualTo(@-20);
    }];
    _formInvite.lblTitle.text = @"入驻邀请码:";
    _formInvite.textField.placeholder = @"请输入邀请码";
    _formInvite.imgIcon.image = IMAGE(@"store_join_icon_invite");
    
    _lblInvite = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 40, 30)];
    _lblInvite.text = @"*选填";
    _lblInvite.textColor = RGB(200, 200, 200);
    _lblInvite.font = kFONT12;
    _formInvite.textField.rightView = _lblInvite;
    _formInvite.textField.rightViewMode = UITextFieldViewModeAlways;
    
    _formUsername = [[FNStoreJoinFormItemView alloc] init];
    [_vContent addSubview:_formUsername];
    [_formUsername mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.formInvite.mas_bottom).offset(20);
        make.bottom.lessThanOrEqualTo(@-20);
    }];
    _formUsername.lblTitle.text = @"负责人姓名:";
    _formUsername.textField.placeholder = @"请输入负责人姓名";
    _formUsername.imgIcon.image = IMAGE(@"store_join_icon_username");
    
    _formNumber = [[FNStoreJoinFormItemView alloc] init];
    [_vContent addSubview:_formNumber];
    [_formNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.formUsername.mas_bottom).offset(20);
        make.bottom.lessThanOrEqualTo(@-20);
    }];
    _formNumber.lblTitle.text = @"固定电话:";
    _formNumber.textField.placeholder = @"请输入固定电话";
    _formNumber.imgIcon.image = IMAGE(@"store_join_icon_phone");
    
    UILabel *lblNumber = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 40, 30)];
    lblNumber.text = @"*选填";
    lblNumber.textColor = RGB(200, 200, 200);
    lblNumber.font = kFONT12;
    _formNumber.textField.rightView = lblNumber;
    _formNumber.textField.rightViewMode = UITextFieldViewModeAlways;
    
    _formPhone = [[FNStoreJoinFormItemView alloc] init];
    [_vContent addSubview:_formPhone];
    [_formPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.formNumber.mas_bottom).offset(20);
        make.bottom.lessThanOrEqualTo(@-20);
    }];
    _formPhone.lblTitle.text = @"联系电话:";
    _formPhone.textField.placeholder = @"请输入联系电话";
    _formPhone.imgIcon.image = IMAGE(@"store_join_icon_phone");
    
    _formCode = [[FNStoreJoinFormItemView alloc] init];
    [_vContent addSubview:_formCode];
    [_formCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.formPhone.mas_bottom).offset(0);
        make.bottom.lessThanOrEqualTo(@-20);
    }];
    _formCode.textField.placeholder = @"请输入验证码";
    _formCode.imgIcon.image = IMAGE(@"store_join_icon_code");
    
    _btnCode = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 28)];
    [_btnCode setTitle:@"获取验证码" forState: UIControlStateNormal];
    [_btnCode setTitleColor:RGB(24, 24, 24) forState: UIControlStateNormal];
    _btnCode.layer.cornerRadius = 14;
    _btnCode.layer.borderWidth = 1;
    _btnCode.layer.borderColor = RGB(200, 200, 200).CGColor;
    _btnCode.titleLabel.font = kFONT12;
    [_btnCode addTarget:self action:@selector(codeAction) forControlEvents:UIControlEventTouchUpInside];
    _formCode.textField.rightView = _btnCode;
    _formCode.textField.rightViewMode = UITextFieldViewModeAlways;
    
    _formAddress = [[FNStoreJoinFormItemView alloc] init];
    [_vContent addSubview:_formAddress];
    [_formAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.formCode.mas_bottom).offset(20);
        make.bottom.lessThanOrEqualTo(@-20);
    }];
    _formAddress.lblTitle.text = @"地址:";
    _formAddress.textField.placeholder = @"请选择店铺地址";
    _formAddress.textField.textAlignment = NSTextAlignmentRight;
    _formAddress.textField.delegate = self;
    _formAddress.imgIcon.image = IMAGE(@"store_join_icon_location");
    
    UIImageView *imgRight = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 30, 30)];
    imgRight.image = IMAGE(@"shop_right");
    imgRight.contentMode = UIViewContentModeCenter;
    _formAddress.textField.rightView = imgRight;
    _formAddress.textField.rightViewMode = UITextFieldViewModeAlways;
    
    [_formName.textField addTarget:self action:@selector(didNameChanged:) forControlEvents:UIControlEventEditingChanged];
    [_formInvite.textField addTarget:self action:@selector(didNameChanged:) forControlEvents:UIControlEventEditingChanged];
    [_formUsername.textField addTarget:self action:@selector(didNameChanged:) forControlEvents:UIControlEventEditingChanged];
    [_formPhone.textField addTarget:self action:@selector(didNameChanged:) forControlEvents:UIControlEventEditingChanged];
    [_formCode.textField addTarget:self action:@selector(didNameChanged:) forControlEvents:UIControlEventEditingChanged];
    [_formAddress.textField addTarget:self action:@selector(didNameChanged:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - Networking

- (void)requestMain{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=apply_form" respondType:(ResponseTypeModel) modelType:@"FNStoreJoinFormModel" success:^(id respondsObject) {
        @strongify(self)
        
        self.model = respondsObject;
        
        self.title = self.model.title;
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSMutableArray *selecteds = [[NSMutableArray alloc] init];
        for (FNStoreJoinCateModel *cate in self.model.cate) {
            [array addObject: cate.catename];
            [selecteds addObject: cate.isSelected ? @"1" : @"0"];
        }
        [_typeJoin setTags: array isSelecteds: selecteds];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

- (void)requestCode: (NSString*)phone{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"phone": phone}];
    _btnCode.enabled = NO;
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=getcode" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        
        [FNTipsView showTips: @"验证码已下发"];
        
        if (self.timer)
            [self.timer invalidate];
        
        self.time = 60;
        [self updateTime];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        
    } failure:^(NSString *error) {
    
        _btnCode.enabled = YES;
        
    } isHideTips:NO isCache: NO];
    
}

- (void)requestCheck: (NSString*)phone captch: (NSString*)captch extend_id: (NSString*)extend_id{
    @weakify(self);
    NSMutableDictionary *p=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"phone": phone, @"captch": captch}];
    if ([extend_id kr_isNotEmpty]) {
        p[@"extend_id"] = extend_id;
    }
    [FNRequestTool requestWithParams:p api:@"mod=appapi&act=small_store&ctrl=checkcode" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        
        FNStoreJoinAuthController *vc = [[FNStoreJoinAuthController alloc] init];
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"name"] = self.formName.textField.text;
        params[@"cid"] = self.model.cate[self.currentCateIndex].id;
        NSMutableString *label = [[NSMutableString alloc] init];
        NSArray<FNStoreJoinTagModel*> *tags = self.model.cate[_currentCateIndex].label;
        BOOL isFirst = YES;
        for (FNStoreJoinTagModel *model in tags) {
            if (model.isSelected) {
                if (isFirst)
                    [label appendString:model.id];
                else
                    [label appendString:[NSString stringWithFormat:@",%@", model.id]];
                isFirst = NO;
            }
        }
        params[@"label_id"] = label;
        if ([extend_id kr_isNotEmpty]) {
            params[@"extend_id"] = extend_id;
        }
        params[@"realname"] = self.formUsername.textField.text;
        params[@"phone"] = self.formPhone.textField.text;
        params[@"captch"] = self.formCode.textField.text;
        if ([self.formNumber.textField.text kr_isNotEmpty]) {
            params[@"fixed_phone"] = self.formNumber.textField.text;
        }
        params[@"address"] = self.formAddress.textField.text;
        if (self.poi) {
            params[@"lat"] = @(self.poi.location.latitude);
            params[@"lng"] = @(self.poi.location.longitude) ;
            params[@"province"] = self.poi.province ? self.poi.province : @"";
            params[@"city"] = self.poi.city ? self.poi.city : @"";
            params[@"district"] = self.poi.district ? self.poi.district : @"";
        }
        
        params[@"img1"] = self.storeImage;
        vc.params = params;
        [self.navigationController pushViewController:vc animated:YES];
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}


#pragma mark - Action
- (void)checkCode {
    if (![_formPhone.textField.text kr_isNotEmpty]) {
        [_formPhone.textField kr_shake];
        return;
    }
    
    if (![_formCode.textField.text kr_isNotEmpty]) {
        [_formCode.textField kr_shake];
        return;
    }
    
    [self requestCheck: _formPhone.textField.text captch: _formCode.textField.text extend_id: _formInvite.textField.text];
}

- (void)codeAction {
    NSString *phone = _formPhone.textField.text;
    if (![phone kr_isNotEmpty]) {
        [FNTipsView showTips: @"请输入联系电话"];
        [_formPhone.textField kr_shake];
        return;
    }
    
    [self requestCode: phone];
    
}

- (void)updateTime {
    NSString *code = [NSString stringWithFormat:@"%lds重新获取", self.time];
    if (self.time > 0) {
        [_btnCode setTitle:code forState: UIControlStateNormal];
        [_btnCode setTitleColor:UIColor.whiteColor forState: UIControlStateNormal];
        _btnCode.backgroundColor = RGB(255, 142, 136);
        _btnCode.enabled = NO;
    } else {
        [_btnCode setTitle:@"获取验证码" forState: UIControlStateNormal];
        [_btnCode setTitleColor:RGB(24, 24, 24) forState: UIControlStateNormal];
        _btnCode.backgroundColor = UIColor.whiteColor;
        _btnCode.enabled = YES;
        if (self.timer)
            [self.timer invalidate];
    }
    _time --;
}

- (void)didNameChanged: (UITextField*)sender {
    [self checkCanNext];
}

- (void) checkCanNext {
    BOOL canNext = YES;
    do {
        if (_storeImage == nil) {
            canNext = NO;
            break;
        }
        if (![_formName.textField.text kr_isNotEmpty]) {
            canNext = NO;
            break;
        }
        if (![_formUsername.textField.text kr_isNotEmpty]) {
            canNext = NO;
            break;
        }
        if (![_formPhone.textField.text kr_isNotEmpty]) {
            canNext = NO;
            break;
        }
        if (![_formCode.textField.text kr_isNotEmpty]) {
            canNext = NO;
            break;
        }
        if (![_formAddress.textField.text kr_isNotEmpty]) {
            canNext = NO;
            break;
        }
        BOOL isSelectedCate = NO;
        for (FNStoreJoinCateModel *cate in self.model.cate) {
            if (cate.isSelected) {
                isSelectedCate = YES;
                break;
            }
        }
        if (!isSelectedCate) {
            canNext = NO;
            break;
        }
    } while(NO);
    _btnJoin.enabled = canNext;
    if (canNext) {
        self.btnJoin.backgroundColor = RGB(255, 56, 46);
    } else {
        self.btnJoin.backgroundColor = RGB(200, 200, 200);
    }
}

#pragma mark - TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {

    if (photos.count > 0) {
        _imgHeader.image = photos[0];
        _storeImage = photos[0];
    }
    [self checkCanNext];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:_formAddress.textField]) {
//        FNRushLocationDeViewController *vc=[[FNRushLocationDeViewController alloc]init];
//        vc.delegate=self;
//        vc.title = @"选择商铺地址";
////        vc.locationModel=model;
//        [self.navigationController pushViewController:vc animated:YES];
        
        FNLocationSelectorViewController *vc = [[FNLocationSelectorViewController alloc] init];
        vc.title = @"选择商铺地址";
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        return NO;
    }
    
    return YES;
}

#pragma mark - FNLocationSelectorViewControllerDelegate

- (void)locationController: (FNLocationSelectorViewController*)vc didSelectPoi: (AMapPOI*) poi {
    _formAddress.textField.text = poi.name;
    _poi = poi;
    
    [self checkCanNext];
    
    [self.navigationController popViewControllerAnimated:YES];
}

//#pragma mark - FNRushLocationDeViewControllerDelegate
//
////选择地址
//-(void)inSelectLocationAction:(NSString*)send withlLongitude:(CGFloat)longitude withLatitude:(CGFloat)latitude {
//    NSLog(@"%@  %f  %f", send, longitude, latitude);
//    [self checkCanNext];
//}
//
////选择地址
//-(void)inSelectLocationAction:(FNHsearchModel*)send {
//    [self checkCanNext];
//    NSLog(@"%@", send);
//    _address = send;
//    _formAddress.textField.text = send.address;
//
//}

#pragma mark - FNStoreJoinTypeViewDelegate
- (void)typeView: (FNStoreJoinTypeView*)view didSelectAt: (NSInteger) index {
    if ([view isEqual:_typeJoin]) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSMutableArray *selecteds = [[NSMutableArray alloc] init];
        for (FNStoreJoinCateModel *cate in self.model.cate) {
            [array addObject: cate.catename];
            cate.isSelected = NO;
            [selecteds addObject:@"0"];
        }
        selecteds[index] = @"1";
        self.model.cate[index].isSelected = YES;
        _currentCateIndex = index;
        [_typeJoin setTags: array isSelecteds: selecteds];
        
        
        NSMutableArray *labels = [[NSMutableArray alloc] init];
        NSMutableArray *tabSelecteds = [[NSMutableArray alloc] init];
        for (FNStoreJoinTagModel *model in self.model.cate[index].label) {
            [labels addObject:model.name];
            [tabSelecteds addObject: @"0"];
        }
        if (labels.count <= 0) {
            _typeTags.hidden = YES;
            _typeTags.lblTitle.text = @"";
        } else {
            _typeTags.hidden = NO;
            _typeTags.lblTitle.text = @"选择标签类型";
        }
        [_typeTags setTags:labels isSelecteds:tabSelecteds];
             
        
    } else if ([view isEqual:_typeTags]) {
        
        NSArray<FNStoreJoinTagModel*> *tags = self.model.cate[_currentCateIndex].label;
        tags[index].isSelected = !tags[index].isSelected;
        NSMutableArray *labels = [[NSMutableArray alloc] init];
        NSMutableArray *tabSelecteds = [[NSMutableArray alloc] init];
        for (FNStoreJoinTagModel *model in tags) {
            [labels addObject:model.name];
            [tabSelecteds addObject: model.isSelected ? @"1" : @"0"];
        }
        [_typeTags setTags:labels isSelecteds:tabSelecteds];
        
    }
    
    [self checkCanNext];
}

@end
