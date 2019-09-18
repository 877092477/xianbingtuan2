//
//  FNStoreJoinResultController.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/21.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreJoinResultController.h"
#import "FNmerSetingsController.h"

@interface FNStoreJoinResultController ()

@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UIImageView *imgIcon;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIButton *btnSetting;

@property (nonatomic, assign) BOOL isSeted;

@end

@implementation FNStoreJoinResultController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    if (_isSeted) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(250, 250, 250);
    
    _vContent = [[UIView alloc] init];
    _imgIcon = [[UIImageView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _btnSetting = [[UIButton alloc] init];
    
    [self.view addSubview:_vContent];
    [_vContent addSubview:_imgIcon];
    [_vContent addSubview:_lblTitle];
    [_vContent addSubview:_btnSetting];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
    }];
    [_imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.width.height.mas_equalTo(100);
        make.top.equalTo(@30);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.left.greaterThanOrEqualTo(@40);
        make.right.lessThanOrEqualTo(@-40);
        make.top.equalTo(self.imgIcon.mas_bottom).offset(40);
    }];
    [_btnSetting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.right.equalTo(@-30);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(12);
        make.bottom.equalTo(@-20);
        make.height.mas_equalTo(46);
    }];
    
    _vContent.backgroundColor = UIColor.whiteColor;
    
    _imgIcon.contentMode = UIViewContentModeScaleAspectFit;
    
    _lblTitle.numberOfLines = 0;
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = kFONT12;
    _lblTitle.textAlignment = NSTextAlignmentCenter;
    
    [_btnSetting addTarget:self action:@selector(goSetting) forControlEvents:UIControlEventTouchUpInside];
    _btnSetting.hidden = YES;
    
    [self requestMain];
}

#pragma mark - Networking

- (void)requestMain{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=apply_status" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self)
        
        NSString *title = respondsObject[@"title"];
        NSString *img = respondsObject[@"img"];
        NSString *tips = respondsObject[@"tips"];
        NSString *btn = respondsObject[@"btn"];
        
        self.title = title;
        self.lblTitle.text = tips;
        [self.imgIcon sd_setImageWithURL: URL(img)];
        if ([btn kr_isNotEmpty]) {
            self.btnSetting.hidden = NO;
            [self.btnSetting sd_setBackgroundImageWithURL:URL(btn) forState: UIControlStateNormal];
        }
        
    } failure:^(NSString *error) {
        
        
    } isHideTips:NO isCache: NO];
    
}

- (void)goSetting {
    _isSeted = YES;
    FNmerSetingsController *vc = [[FNmerSetingsController alloc] init];
    vc.isConfirm = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
