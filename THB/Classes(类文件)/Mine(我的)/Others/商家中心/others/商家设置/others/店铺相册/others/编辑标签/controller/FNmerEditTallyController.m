//
//  FNmerEditTallyController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/1.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerEditTallyController.h"
#import "FNmerSetPhotoHomeController.h"
#import "FNCustomeNavigationBar.h"
#import "FNmerAddTallyPhotoController.h"
@interface FNmerEditTallyController ()
@property (nonatomic, strong)FNCustomeNavigationBar *navigationView; 
@property (nonatomic, strong)UIButton     *leftBtn;
@property (nonatomic, strong)UIButton     *rightBtn;
@property (nonatomic, strong)UIView       *topTextView;//修改文本View
@property (nonatomic, strong)UITextField  *compileField;
@property (nonatomic, strong)UILabel      *hintLb;
@property (nonatomic, strong)UIView       *lineView;
@property (nonatomic, strong)UIButton     *tallyBtn;
@end

@implementation FNmerEditTallyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
#pragma mark - set up views
- (void)jm_setupViews{
     
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.navigationView.leftButton = self.leftBtn;
    
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightBtn.cornerRadius=5;
    self.rightBtn.size = CGSizeMake(54, 27);
    self.navigationView.rightButton = self.rightBtn;
    self.rightBtn.backgroundColor=RGB(255, 223, 197);
    self.rightBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:self.navigationView];
    
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 10).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.rightBtn.imageView.sd_layout
    .rightSpaceToView(self.rightBtn, 5).centerYEqualToView(self.rightBtn).widthIs(15).heightIs(15);
    
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:16];
    self.navigationView.titleLabel.textAlignment=NSTextAlignmentLeft;
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.navigationView.titleLabel.text=@"编辑标签";
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).leftSpaceToView(self.navigationView.leftButton, 2).heightIs(20).widthIs(150);
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    
    self.view.backgroundColor=RGB(250, 250, 250);
    
    [self addViewSubs];
    
    if([self.lableWord kr_isNotEmpty]){
        self.compileField.text=self.lableWord;
        self.rightBtn.backgroundColor=RGB(255, 120, 0);
    }
}

-(void)addViewSubs{
    
    self.topTextView=[[UIView alloc]init];
    [self.view addSubview:self.topTextView];
    
    self.topTextView.cornerRadius=5;
    self.topTextView.backgroundColor=[UIColor whiteColor];
    
    self.compileField=[[UITextField alloc]initWithFrame:CGRectMake(15, 5, 200, 34)];
    self.compileField.font = kFONT14;
    self.compileField.textColor=RGB(51, 51, 51);
    self.compileField.tintColor=[UIColor lightGrayColor];
    self.compileField.textAlignment=NSTextAlignmentLeft;
    [self.topTextView addSubview:self.compileField];
    [self.compileField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.hintLb=[[UILabel alloc]init];
    [self.topTextView addSubview:self.hintLb];  
    
    self.lineView=[[UIView alloc]init];
    [self.topTextView addSubview:self.lineView];
    self.lineView.backgroundColor=RGB(255, 120, 0);
    
//    self.tallyBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [self.view addSubview:self.tallyBtn];
//    self.tallyBtn.backgroundColor=RGB(255, 241, 231);
//    self.tallyBtn.titleLabel.font=[UIFont systemFontOfSize:14];
//    [self.tallyBtn setTitleColor:RGB(255, 120, 0) forState:UIControlStateNormal];
    
    self.hintLb.font=[UIFont systemFontOfSize:14];
    self.hintLb.textColor=RGB(51, 51, 51);
    self.hintLb.textAlignment=NSTextAlignmentLeft;
    
    self.topTextView.sd_layout
    .leftSpaceToView(self.view, 12).rightSpaceToView(self.view, 12).topSpaceToView(self.view, SafeAreaTopHeight+12).heightIs(64);
    
    self.hintLb.sd_layout
    .leftSpaceToView(self.topTextView, 15).topSpaceToView(self.topTextView, 17).widthIs(70).heightIs(18);
    
    self.compileField.sd_layout
    .leftSpaceToView(self.hintLb, 0).centerYEqualToView(self.hintLb).rightSpaceToView(self.topTextView, 10).heightIs(18);
    
    self.lineView.sd_layout
    .leftSpaceToView(self.topTextView, 10).rightSpaceToView(self.topTextView, 10).bottomSpaceToView(self.topTextView, 16).heightIs(1);
    
//    self.tallyBtn.sd_layout
//    .leftSpaceToView(self.view, 20).topSpaceToView(self.topTextView, 30).widthIs(85).heightIs(30);
//
//    [self.tallyBtn setTitle:@"删除标签" forState:UIControlStateNormal];
//    [self.tallyBtn addTarget:self action:@selector(tallyBtnClick)];
//    self.tallyBtn.cornerRadius=3;
    
    self.hintLb.text=@"*标签名字"; 
    [self.hintLb fn_changeColorWithTextColor:RGB(255, 120, 0) changeText:@"*"];
    
}
#pragma mark - 编辑
- (void)textFieldDidChange:(id)sender{
    UITextField *field = (UITextField *)sender;
    if([field.text kr_isNotEmpty]){
        self.rightBtn.backgroundColor=RGB(255, 120, 0);
    }else{
        self.rightBtn.backgroundColor=RGB(255, 223, 197);
    } 
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//确定
-(void)rightBtnAction{
    if([self.compileField.text kr_isNotEmpty]){
       [self requestLableBendi];
    } 
}
//删除标签
-(void)tallyBtnClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[FNmerSetPhotoHomeController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    } 
} 
#pragma mark -  本地数据 修改标签（相册名）
-(void)requestLableBendi{
    [SVProgressHUD show];
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    params[@"name"]=self.compileField.text;
    params[@"id"]=self.lableWordID;  
    @weakify(self);
    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:@"mod=appapi&act=rebate_album&ctrl=edit_label" successBlock:^(id responseBody) {
        XYLog(@"responseBody=%@",responseBody);
        @strongify(self);
        NSInteger state=[responseBody[SuccessKey] integerValue];
        NSString *msgStr=responseBody[MsgKey];
        [FNTipsView showTips:msgStr];
        if(state==1){
            if ([self.delegate respondsToSelector:@selector(inDidMerEditTallyRefreshAction)]) {
                [self.delegate inDidMerEditTallyRefreshAction];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failureBlock:^(NSString *error) {
    }];
}
@end
