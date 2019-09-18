//
//  FNTeOddEnsureNeController.m
//  69橙子
//
//  Created by Jimmy on 2018/11/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//付款
#import "FNTeOddEnsureNeController.h"
#import "FNTeOddPromptlyNeController.h"
@interface FNTeOddEnsureNeController ()

@end

@implementation FNTeOddEnsureNeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"付款";
    self.view.backgroundColor=RGB(246, 246, 246);
    [self constructView];
}
-(void)constructView{
    //CGFloat spaceeHeight=SafeAreaTopHeight+20;
    CGFloat spaceeHeight=20;
    UIView *whiteBgView=[[UIView alloc]init];
    whiteBgView.frame=CGRectMake(20, spaceeHeight, FNDeviceWidth-40, 250);
    whiteBgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:whiteBgView];
    whiteBgView.sd_layout
    .widthIs(330).heightIs(250).centerXEqualToView(self.view).topSpaceToView(self.view, spaceeHeight);
    
    UIImageView *storeImageView=[[UIImageView alloc]init];
    storeImageView.backgroundColor=[UIColor lightGrayColor];
    [whiteBgView addSubview:storeImageView];
    storeImageView.sd_layout
    .widthIs(62).heightIs(62).centerXEqualToView(whiteBgView).topSpaceToView(whiteBgView, 30);
    
    UILabel *storeName=[[UILabel alloc]init];
    //storeName.backgroundColor=[UIColor lightGrayColor];
    storeName.textAlignment=NSTextAlignmentCenter;
    storeName.font=kFONT17;
    [whiteBgView addSubview:storeName];
    storeName.sd_layout
    .topSpaceToView(storeImageView, 20).heightIs(25).leftSpaceToView(whiteBgView, 20).rightSpaceToView(whiteBgView, 20);
    
    UILabel *estimateLb=[[UILabel alloc]init];
    //estimateLb.backgroundColor=[UIColor lightGrayColor];
    estimateLb.font=kFONT13;
    estimateLb.textColor=RGB(219, 76, 70);
    estimateLb.text=@"预估";
    [whiteBgView addSubview:estimateLb];
    estimateLb.sd_layout
    .bottomSpaceToView(whiteBgView, 5).heightIs(20).leftSpaceToView(whiteBgView, 20).rightSpaceToView(whiteBgView, 20);
    
    
    UIView *exportView=[[UIView alloc]init];
    //exportView.backgroundColor=[UIColor lightGrayColor];
    [whiteBgView addSubview:exportView];
    exportView.sd_layout
    .leftSpaceToView(whiteBgView, 20).rightSpaceToView(whiteBgView, 20).bottomSpaceToView(estimateLb, 15).heightIs(50);
    
    UILabel *wordLb=[[UILabel alloc]init];
    wordLb.text=@"¥";
    wordLb.font=kFONT17;
    //wordLb.backgroundColor=[UIColor whiteColor];
    [exportView addSubview:wordLb];
    wordLb.sd_layout
    .leftEqualToView(exportView).heightIs(25).widthIs(25).centerYEqualToView(exportView);
    
    UITextField*ratedTF = [[UITextField alloc]initWithFrame:CGRectMake(30, 10, 150, 30)];
    wordLb.backgroundColor=[UIColor whiteColor];
    ratedTF.placeholder = @"请输入金额";
    //ratedTF.keyboardType = UIKeyboardTypePhonePad;
    [exportView addSubview:ratedTF];
    ratedTF.sd_layout.centerYEqualToView(exportView).leftSpaceToView(wordLb, 0).rightSpaceToView(exportView, 10).heightIs(30);
    
    UILabel *lineLb=[[UILabel alloc]init];
    lineLb.backgroundColor=RGB(237, 237, 237);
    [exportView addSubview:lineLb];
    lineLb.sd_layout
    .bottomSpaceToView(exportView, 0).leftEqualToView(exportView).rightEqualToView(exportView).heightIs(1);
    
    
    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 20+250+20 , FNDeviceWidth-40, 50)];
    [confirmBtn.layer setMasksToBounds:YES];
    [confirmBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
    [confirmBtn setTitle:@"确定支付" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = kFONT16;
    confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    confirmBtn.backgroundColor = RGB(246, 51, 40);
    [confirmBtn addTarget:self action:@selector(clickBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    confirmBtn.sd_layout
    .topSpaceToView(whiteBgView, 20).leftEqualToView(whiteBgView).rightEqualToView(whiteBgView).heightIs(50);
}
-(void)clickBtnMethod{
    FNTeOddPromptlyNeController *vc=[[FNTeOddPromptlyNeController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
