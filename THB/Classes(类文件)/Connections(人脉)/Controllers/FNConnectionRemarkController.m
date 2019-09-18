//
//  FNConnectionRemarkController.m
//  THB
//
//  Created by Weller Zhao on 2019/3/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionRemarkController.h"
#import "FNCustomeNavigationBar.h"

@interface FNConnectionRemarkController ()<UITextFieldDelegate>


@property(nonatomic,strong)FNCustomeNavigationBar *topNaivgationbar;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *moreBtn;

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UITextField *textview;
@property (nonatomic, strong) UIView *vLine;

@end

@implementation FNConnectionRemarkController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopNavBar];
    [self configUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

#pragma mark - 导航栏view
-(void)setTopNavBar{
    
    UIView *topView=[[UIView alloc]init];
    topView.frame=CGRectMake(0, 0, FNDeviceWidth, SafeAreaTopHeight);
    //self.topImg=[[UIImageView alloc]init];
    //[topView addSubview:self.topImg];
    self.topNaivgationbar = [FNCustomeNavigationBar customeNavigationBarWithCustomeView:topView];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,FNDeviceWidth,SafeAreaTopHeight);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:177/255.0 green:101/255.0 blue:251/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:255/255.0 green:59/255.0 blue:153/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0)];
    
    [self.topNaivgationbar.layer addSublayer:gl];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn setImage:[UIImage imageNamed:@"return-white"] forState:UIControlStateNormal];
    [self.leftBtn setTitle:self.nickname forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font=kFONT17;
    [self.leftBtn sizeToFit];
    self.leftBtn.size = CGSizeMake(self.leftBtn.width+10, 30);
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.leftBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10.0f];
    
    self.topNaivgationbar.leftButton = self.leftBtn;
    
    self.moreBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //    [self.moreBtn setImage: IMAGE(@"connections_chat_more") forState: UIControlStateNormal];
    [self.moreBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.moreBtn setTitleColor:RED forState:UIControlStateNormal];
    self.moreBtn.backgroundColor = UIColor.whiteColor;
    [self.moreBtn sizeToFit];
    self.moreBtn.size = CGSizeMake(self.moreBtn.width+10, 30);
    [self.moreBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    //    [self.moreBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10.0f];
    //    self.moreBtn.hidden = YES;
    
    self.topNaivgationbar.rightButton = self.moreBtn;
    
    [self.view addSubview:_topNaivgationbar];
    self.topNaivgationbar.backgroundColor =[UIColor whiteColor];
    
}

- (void)configUI {
    _lblTitle = [[UILabel alloc] init];
    [self.view addSubview: _lblTitle];
    _textview = [[UITextField alloc] init];
    [self.view addSubview:_textview];
    _vLine = [[UIView alloc] init];
    [self.view addSubview: _vLine];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.topNaivgationbar.mas_bottom).offset(20);
        make.right.lessThanOrEqualTo(@-20);
//        make.height.mas_equalTo(120);
    }];
    [_textview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(8);
        make.right.equalTo(@-20);
        make.height.mas_equalTo(40);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.bottom.equalTo(self.textview);
        make.height.mas_equalTo(1);
    }];
    
    _lblTitle.text = @"备注";
    _lblTitle.textColor = UIColor.grayColor;
    _lblTitle.font = kFONT14;
    
    _textview.textColor = UIColor.grayColor;
    _textview.font = kFONT16;
    _textview.delegate = self;
    _textview.text = _nickname;
    _textview.placeholder = self.nickname;
//    _textview.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
//    _textview.leftViewMode = UITextFieldViewModeAlways;
    [_textview becomeFirstResponder];
    [_textview addTarget:self action:@selector(textContentChanged:) forControlEvents:UIControlEventEditingChanged];
    
    _vLine.backgroundColor = UIColor.lightGrayColor;
    
    self.moreBtn.enabled = [_textview.text kr_isNotEmpty];
    self.moreBtn.backgroundColor = [_textview.text kr_isNotEmpty] ?  RGBA(255, 255, 255, 1) : RGBA(255, 255, 255, 0.2);
}

- (void)leftBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightBtnAction {
    [self requestNotice];
}

- (void)textContentChanged: (UITextField*)textField {
    self.moreBtn.enabled = [textField.text kr_isNotEmpty];
    self.moreBtn.backgroundColor = [textField.text kr_isNotEmpty] ?  RGBA(255, 255, 255, 1) : RGBA(255, 255, 255, 0.2);
}

#pragma mark - Networking
- (void)requestNotice {
    if ([_target isEqualToString:@"ren"]) {
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"tid": _uid, @"remark": _textview.text}];
        @weakify(self);
        [SVProgressHUD show];
        [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection_set&ctrl=set_remark" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(didNameChange:)]) {
                [self.delegate didNameChange:self.textview.text];
            }
            
            [SVProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSString *error) {
            [SVProgressHUD dismiss];
        } isHideTips:NO isCache:NO];
    } else if ([_target isEqualToString:@"qun"]) {
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"qid": _uid, @"nickname": _textview.text}];
        @weakify(self);
        [SVProgressHUD show];
        [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection_set&ctrl=set_nickname" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(didNameChange:)]) {
                [self.delegate didNameChange:self.textview.text];
            }
            
            [SVProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSString *error) {
            [SVProgressHUD dismiss];
            //
        } isHideTips:NO isCache:NO];
    }
}


@end
