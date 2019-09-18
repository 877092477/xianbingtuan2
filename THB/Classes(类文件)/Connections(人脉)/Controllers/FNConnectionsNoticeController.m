//
//  FNConnectionsNoticeController.m
//  THB
//
//  Created by Weller Zhao on 2019/3/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsNoticeController.h"
#import "FNCustomeNavigationBar.h"

@interface FNConnectionsNoticeController ()<UITextViewDelegate>

@property(nonatomic,strong)FNCustomeNavigationBar *topNaivgationbar;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *moreBtn;

@property (nonatomic, strong) UITextView *textview;

@end

@implementation FNConnectionsNoticeController

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
    _textview = [[UITextView alloc] init];
    [self.view addSubview:_textview];
    [_textview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.topNaivgationbar.mas_bottom).offset(20);
        make.right.equalTo(@-20);
        make.height.mas_equalTo(120);
    }];
    _textview.cornerRadius = 4;
    _textview.borderColor = UIColor.lightGrayColor;
    _textview.borderWidth = 1;
    _textview.textColor = UIColor.grayColor;
    _textview.font = kFONT14;
    _textview.delegate = self;
    _textview.text = _notice;
    [_textview becomeFirstResponder];
    
    self.moreBtn.enabled = [_textview.text kr_isNotEmpty];
    self.moreBtn.backgroundColor = [_textview.text kr_isNotEmpty] ?  RGBA(255, 255, 255, 1) : RGBA(255, 255, 255, 0.2);
}

- (void)leftBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightBtnAction {
    [self requestNotice];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    self.moreBtn.enabled = [textView.text kr_isNotEmpty];
    self.moreBtn.backgroundColor = [textView.text kr_isNotEmpty] ?  RGBA(255, 255, 255, 1) : RGBA(255, 255, 255, 0.2);
}

#pragma mark - Networking
- (void)requestNotice {
    if ([_target isEqualToString:@"qun"]) {
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"qid": _uid, @"affiche": _textview.text}];
        @weakify(self);
        [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection_set&ctrl=set_affiche" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSString *error) {
            //
        } isHideTips:NO isCache:YES];
    }
}

@end
