//
//  FNIntegralMallAddressEditController.m
//  THB
//
//  Created by Weller Zhao on 2019/1/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNIntegralMallAddressEditController.h"
#import "IQKeyboardManager/IQTextView.h"
#import "LJContactManager/LJContactManager.h"
#import "GetProvinceViewController.h"

@interface FNIntegralMallAddressEditController ()

@property (nonatomic, strong) NSArray<NSString*> *tags;
@property (nonatomic, strong) NSMutableArray<UILabel*> *lblTags;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *vContent;

@property (nonatomic, strong) UIButton *btnContact;

@property (nonatomic, strong) UILabel *lblNameTitle;
@property (nonatomic, strong) UITextField *txfName;

@property (nonatomic, strong) UILabel *lblPhoneTitle;
@property (nonatomic, strong) UITextField *txfPhone;

@property (nonatomic, strong) UILabel *lblLocationTitle;
@property (nonatomic, strong) UILabel *lblLocation;
@property (nonatomic, strong) UIImageView *imgLocation;
@property (nonatomic, strong) UIButton *btnLocation;

@property (nonatomic, strong) UILabel *lblAddressTitle;
@property (nonatomic, strong) IQTextView *txvAddress;

@property (nonatomic, strong) UILabel *lblTagTitle;
@property (nonatomic, strong) UIView *vTag;

@property (nonatomic, strong) UILabel *lblDefaultTitle;
@property (nonatomic, strong) UISwitch *swtDefault;

@property (nonatomic, strong) UIButton *btnSave;

@property (nonatomic, copy) NSString *siteString;
//省
@property (nonatomic, copy) NSString *provinceString;
//市
@property (nonatomic, copy)NSString *cityString;
//县
@property (nonatomic, copy)NSString *districtString;
//街道
@property (nonatomic, copy)NSString *areaString;
@property (nonatomic, copy)NSString *label;

@end

@implementation FNIntegralMallAddressEditController

- (void)setModel:(FNAddressModel *)model {
    _model = model;
    self.provinceString = model.province;
    self.cityString = model.city;
    self.districtString = model.district;
    self.areaString = model.area;
    self.siteString = model.address;
    [self configData:model];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lblTags = [[NSMutableArray alloc] init];
    [self configUI];
    [self apiRequestTag];
    
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(tongzhi:) name:@"EditProfile" object:nil];
}

- (void)dealloc
{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

#pragma mark - Network

- (void)apiRequestTag {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey: UserAccessToken}];
    @weakify(self);
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=convert_goods&ctrl=label_list" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (id name in respondsObject) {
            [array addObject: [name valueForKey:@"name"]];
        }
        self.tags = array;
        [self configTags];
        if (self.model) {
            for (NSInteger index = 0; index < self.lblTags.count; index ++) {
                if ([self.lblTags[index].text isEqualToString:self.model.label]) {
                    [self onTagClickAt:index];
                    break;
                }
            }
        }
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:NO];
}

- (void)apiRequestSave {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey: UserAccessToken}];
    if (self.model)
        params[@"id"] = self.model.ID;
    params[@"id"] = self.model.ID;
    params[@"name"] = self.txfName.text;
    params[@"phone"] = self.txfPhone.text;
    params[@"is_acquiesce"] = self.swtDefault.isOn ? @"1" : @"0";
    params[@"province"] = self.provinceString;
    params[@"city"] = self.cityString;
    params[@"district"] = self.districtString;
    params[@"area"] = self.areaString;
    params[@"address"] = self.txvAddress.text;
    params[@"label"] = self.label;
    [SVProgressHUD show];
    @weakify(self);
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=convert_goods&ctrl=add_address" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        if ([_delegate respondsToSelector:@selector(onAddressSave:)]) {
            [_delegate onAddressSave:self];
        }
        [self.navigationController popViewControllerAnimated:YES];
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:NO];
}


#pragma mark - UI
- (void)configUI {
    
    self.scrollView = [[UIScrollView alloc] init];
    self.vContent = [[UIView alloc] init];
    self.btnContact = [[UIButton alloc] init];
    self.lblNameTitle = [[UILabel alloc] init];
    self.txfName = [[UITextField alloc] init];
    self.lblPhoneTitle = [[UILabel alloc] init];
    self.txfPhone = [[UITextField alloc] init];
    self.lblLocationTitle = [[UILabel alloc] init];
    self.lblLocation = [[UILabel alloc] init];
    self.btnLocation = [[UIButton alloc] init];
    self.imgLocation = [[UIImageView alloc] init];
    self.lblAddressTitle = [[UILabel alloc] init];
    self.txvAddress = [[IQTextView alloc] init];
    self.lblTagTitle = [[UILabel alloc] init];
    self.vTag = [[UIView alloc] init];
    self.lblDefaultTitle = [[UILabel alloc] init];
    self.swtDefault = [[UISwitch alloc] init];
    self.btnSave = [[UIButton alloc] init];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.vContent];
    [self.vContent addSubview:self.btnContact];
    [self.vContent addSubview:self.lblNameTitle];
    [self.vContent addSubview:self.txfName];
    [self.vContent addSubview:self.lblPhoneTitle];
    [self.vContent addSubview:self.txfPhone];
    [self.vContent addSubview:self.lblLocationTitle];
    [self.vContent addSubview:self.lblLocation];
    [self.vContent addSubview:self.imgLocation];
    [self.vContent addSubview:self.btnLocation];
    [self.vContent addSubview:self.lblAddressTitle];
    [self.vContent addSubview:self.txvAddress];
    [self.vContent addSubview:self.lblTagTitle];
    [self.vContent addSubview:self.vTag];
    [self.vContent addSubview:self.lblDefaultTitle];
    [self.vContent addSubview:self.swtDefault];
    [self.view addSubview:self.btnSave];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.bottom.equalTo(self.btnSave.mas_top).offset(-20);
    }];
    [self.vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
//        make.height.mas_equalTo(800);
        make.width.mas_equalTo(XYScreenWidth);
    }];
    [self.lblNameTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@15);
    }];
    [self.lblNameTitle setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    UIView *vLine1 = [[UIView alloc] init];
    [self.vContent addSubview:vLine1];
    [vLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(self.btnContact.mas_left);
        make.top.equalTo(self.lblNameTitle.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    vLine1.backgroundColor = FNHomeBackgroundColor;
    [self.txfName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@90);
        make.right.equalTo(self.btnContact.mas_left).offset(-20);
        make.height.mas_equalTo(40);
        make.centerY.equalTo(self.lblNameTitle);
    }];
    [self.lblPhoneTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(vLine1.mas_bottom).offset(15);
    }];
    [self.lblPhoneTitle setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.txfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@90);
        make.right.equalTo(self.btnContact.mas_left).offset(-20);
        make.height.mas_equalTo(40);
        make.centerY.equalTo(self.lblPhoneTitle);
    }];
    UIView *vLine2 = [[UIView alloc] init];
    [self.vContent addSubview:vLine2];
    [vLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.lblPhoneTitle.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    vLine2.backgroundColor = FNHomeBackgroundColor;
    UIView *vLine3 = [[UIView alloc] init];
    [self.vContent addSubview:vLine3];
    [vLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnContact.mas_left);
        make.top.equalTo(@0);
        make.bottom.equalTo(vLine2);
        make.width.mas_equalTo(1);
    }];
    vLine3.backgroundColor = FNHomeBackgroundColor;
    [self.btnContact mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.width.mas_equalTo(94);
        make.bottom.equalTo(vLine2.mas_top);
    }];
    [self.lblLocationTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(vLine2.mas_bottom).offset(15);
    }];
    [self.lblLocationTitle setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    UIView *vLine4 = [[UIView alloc] init];
    [self.vContent addSubview:vLine4];
    [vLine4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.lblLocationTitle.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    vLine4.backgroundColor = FNHomeBackgroundColor;
    [self.imgLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-15);
        make.centerY.equalTo(self.lblLocationTitle);
    }];
    [self.lblLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@90);
        make.right.lessThanOrEqualTo(self.imgLocation.mas_left).offset(-20);
        make.centerY.equalTo(self.lblLocationTitle);
    }];
    [self.btnLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@90);
        make.right.equalTo(@-20);
        make.height.mas_equalTo(40);
        make.centerY.equalTo(self.lblLocationTitle);
    }];
    [self.lblAddressTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(vLine4.mas_bottom).offset(15);
    }];
    [self.lblAddressTitle setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.txvAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@90);
        make.right.equalTo(@-20);
        make.height.mas_equalTo(60);
        make.top.equalTo(vLine4.mas_bottom).offset(10);
    }];
    UIView *vLine5 = [[UIView alloc] init];
    [self.vContent addSubview:vLine5];
    [vLine5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.txvAddress.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    vLine5.backgroundColor = FNHomeBackgroundColor;
    [self.lblTagTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(vLine5.mas_bottom).offset(15);
    }];
    [self.lblTagTitle setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.vTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@90);
        make.right.equalTo(@-20);
        make.height.mas_equalTo(60);
        make.top.equalTo(vLine5.mas_bottom).offset(15);
    }];
    UIView *vLine6 = [[UIView alloc] init];
    [self.vContent addSubview:vLine6];
    [vLine6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.vTag.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    vLine6.backgroundColor = FNHomeBackgroundColor;
    [self.lblDefaultTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(vLine6.mas_bottom).offset(15);
        make.bottom.equalTo(@-15);
    }];
    [self.swtDefault mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lblDefaultTitle);
        make.right.equalTo(@-20);
    }];
    [self.btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@60);
        make.right.equalTo(@-60);
        make.bottom.equalTo(@-20);
        make.height.mas_equalTo(44);
    }];
    
    self.title = @"收货地址";
    self.view.backgroundColor = FNHomeBackgroundColor;
    self.vContent.backgroundColor = UIColor.whiteColor;
    
    [_btnContact setImage:IMAGE(@"address_button_contact") forState:UIControlStateNormal];
    [_btnContact setTitle:@"选联系人" forState:UIControlStateNormal];
    [_btnContact setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
    _btnContact.titleLabel.font = kFONT12;
    [_btnContact layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [_btnContact addTarget:self action:@selector(onContactClick)];
    
    _lblNameTitle.text = @"收货人";
    _lblNameTitle.textColor = RGB(24, 24, 24);
    _lblNameTitle.font = kFONT14;
    [_lblNameTitle sizeToFit];
    
    _txfName.placeholder = @"填写收货人姓名";
    _txfName.font = kFONT14;
    
    _lblPhoneTitle.text = @"手机号码";
    _lblPhoneTitle.textColor = RGB(24, 24, 24);
    _lblPhoneTitle.font = kFONT14;
    
    _txfPhone.placeholder = @"填写手机号码";
    _txfPhone.font = kFONT14;
    _txfPhone.keyboardType = UIKeyboardTypePhonePad;
    
    _lblLocationTitle.text = @"所在地区";
    _lblLocationTitle.textColor = RGB(24, 24, 24);
    _lblLocationTitle.font = kFONT14;
    
    _lblLocation.text = @"选择地区";
    _lblLocation.textColor = RGB(200, 200, 200);
    _lblLocation.font = kFONT13;
    
    _imgLocation.image = IMAGE(@"integral_order_image_more");
    
    _lblAddressTitle.text = @"详细地址";
    _lblAddressTitle.textColor = RGB(24, 24, 24);
    _lblAddressTitle.font = kFONT14;
    
    [_btnLocation addTarget:self action:@selector(onLocationClick)];
    
    _txvAddress.placeholder = @"详细地址  如道路、门牌号、小区、楼栋号、单元室等";
    _txvAddress.font = kFONT14;
    
    _lblTagTitle.text = @"标签";
    _lblTagTitle.textColor = RGB(24, 24, 24);
    _lblTagTitle.font = kFONT14;
    
    _lblDefaultTitle.text = @"设为默认地址";
    _lblDefaultTitle.textColor = RGB(24, 24, 24);
    _lblDefaultTitle.font = kFONT14;
    
    self.btnSave.backgroundColor = RGB(255, 37, 37);
    [self.btnSave setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self.btnSave setTitle:@"保存" forState:UIControlStateNormal];
    self.btnSave.cornerRadius = 22;
    [self.btnSave addTarget:self action:@selector(onSaveClick)];
    
    [self configData:_model];
}

- (void)configData: (FNAddressModel*)model {
    if (model == nil)
        return;
    self.txfName.text = model.name;
    self.txfPhone.text = model.phone;
    self.lblLocation.text = [NSString stringWithFormat:@"%@%@%@%@", model.province, model.city, model.district, model.area];
    self.txvAddress.text = model.detail_address;
    for (NSInteger index = 0; index < self.lblTags.count; index ++) {
        if ([self.lblTags[index].text isEqualToString:model.label]) {
            [self onTagClickAt:index];
            break;
        }
    }
    [self.swtDefault setOn:model.is_acquiesce.integerValue == 1];
}

#define TagWidth 54
#define TagPadding 10
- (void)configTags {
    for (UILabel *lblTag in self.lblTags) {
        [lblTag removeFromSuperview];
    }
    [self.lblTags removeAllObjects];
    
    CGFloat width = self.vTag.frame.size.width;
    //计算每行个数
    int count = (int)(width / (TagWidth + TagPadding));
    for (NSInteger index = 0; index < self.tags.count; index++) {
        UILabel *label = [[UILabel alloc] init];
        [self.vTag addSubview:label];
        [self.lblTags addObject:label];
        
        label.text = self.tags[index];
        label.cornerRadius = 11;
        label.font = kFONT13;
        label.borderColor = FNHomeBackgroundColor;
        label.borderWidth = 1;
        label.textAlignment = NSTextAlignmentCenter;
        NSInteger idx = index;
        @weakify(self)
        [label addJXTouch:^{
            @strongify(self)
            [self onTagClickAt:idx];
        }];
        NSInteger i = index % count;
        NSInteger j = index / count;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(self.lblTags[index - 1].mas_right).offset(TagPadding);
            }
            if (j == 0) {
                make.top.equalTo(@0);
            } else {
                make.top.equalTo(self.lblTags[index - count].mas_bottom).offset(TagPadding);
            }
            make.width.mas_equalTo(TagWidth);
            make.height.mas_equalTo(22);
            make.bottom.lessThanOrEqualTo(@0);
        }];
        
    }
    if (self.lblTags.count > 0)
        [self onTagClickAt:0];
}
    
- (void)onTagClickAt:(NSInteger)index {
    for (NSInteger idx = 0; idx < self.lblTags.count; idx++) {
        if (idx == index) {
            self.lblTags[idx].backgroundColor = RGB(255, 131, 20);
            self.lblTags[idx].textColor = UIColor.whiteColor;
        } else {
            self.lblTags[idx].backgroundColor = UIColor.whiteColor;
            self.lblTags[idx].textColor = RGB(24, 24, 24);
        }
    }
    self.label = self.tags[index];
}

#pragma mark - Action
- (void)onContactClick {
    @weakify(self);
    [LJContactManager.sharedInstance selectContactAtController:self complection:^(NSString *name, NSString *phone) {
        @strongify(self);
        self.txfName.text = name;
        self.txfPhone.text = phone;
    }];
}

- (void)onSaveClick {
    if ([self.txfName.text isEqualToString:@""]) {
        [FNTipsView showTips:@"请填写收货人姓名"];
        return;
    }
    if ([self.txfPhone.text isEqualToString:@""]) {
        [FNTipsView showTips:@"请填写手机号"];
        return;
    }
    if (self.siteString == nil || [self.siteString isEqualToString:@""]) {
        [FNTipsView showTips:@"请选择地区"];
        return;
    }
    if ([self.txvAddress.text isEqualToString:@""]) {
        [FNTipsView showTips:@"请填写详细地址"];
        return;
    }
    [self apiRequestSave];
}

- (void)onLocationClick {
    GetProvinceViewController *vc = [[GetProvinceViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 选择结果通知
- (void)tongzhi:(NSNotification *)noti{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    self.siteString = [defaults objectForKey:XYAddress];
    //省
    self.provinceString = [defaults objectForKey:XYProvince];
    //市
    self.cityString = [defaults objectForKey:XYCity];
    //县
    self.districtString = [defaults objectForKey:XYDistrict];
    self.lblLocation.text = self.siteString;
}


@end
