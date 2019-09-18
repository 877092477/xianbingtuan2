//
//  FNAstrictDeliverysController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNAstrictDeliverysController.h"
#import "FNCustomeNavigationBar.h"
#import "FNDeliveryDatepView.h"
#import "DSHPopupContainer.h"
@interface FNAstrictDeliverysController ()<UITextFieldDelegate,FNDeliveryDatepViewDelegate>

@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;

@property (nonatomic, strong)UIButton *topNorBtn;
@property (nonatomic, strong)UIButton *astrictBtn;
@property (nonatomic, strong)UILabel *hintOneLB;

@property (nonatomic, strong)UIView      *compileView;
@property (nonatomic, strong)UILabel     *leftCompileTitleLB;
@property (nonatomic, strong)UITextField *compileField;
@property (nonatomic, strong)UILabel     *hintTwoLB;
@property (nonatomic, strong)UIButton    *rightDateBtn;
@property (nonatomic, strong)NSString    *astrictState;
@property (nonatomic, strong)NSString    *backString;
@property (nonatomic, strong)NSString    *start_time;
@property (nonatomic, strong)NSString    *end_time;
@property (nonatomic, strong)DSHPopupContainer *container;
@property (nonatomic, strong)FNDeliveryDatepView *customDateView;
@end

@implementation FNAstrictDeliverysController

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
    self.leftBtn.size = CGSizeMake(40, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightBtn.size = CGSizeMake(54, 27);
    self.navigationView.rightButton = self.rightBtn;
    [self.rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.rightBtn setBackgroundImage:IMAGE(@"FN_me_orBCimg") forState:UIControlStateNormal];
    //[self.rightBtn setBackgroundImage:IMAGE(@"FN_me_orBCnorImg") forState:UIControlStateNormal];
    
    [self.view addSubview:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 5).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:16];
    self.navigationView.titleLabel.textAlignment=NSTextAlignmentLeft;
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).leftSpaceToView(self.leftBtn, 1).heightIs(20);
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.navigationView.titleLabel.text=self.keyWord ? [NSString stringWithFormat:@"设置%@",self.keyWord]:@"设置"; 
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=RGB(250, 250, 250);
    
    self.astrictState=@"0";
    self.backString=@"";
    self.start_time=@"";
    self.end_time=@"";
    [self didTopOptionViews];
    
    [self didOptionCompileViews];
    
    self.compileView.hidden=YES;
    self.hintTwoLB.hidden=YES;
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//保存
-(void)rightBtnAction{
    if([self.astrictState isEqualToString:@"0"]){
        if ([self.delegate respondsToSelector:@selector(didmerDeliverysNoLimitAction:withContent:withType:)]) {
            [self.delegate didmerDeliverysNoLimitAction:self.backIndex  withContent:@"不限制" withType:self.keyWord];
        }
        if ([self.delegate respondsToSelector:@selector(didmerDeliverysDateAction:withStartTime:withEndTime:)]) {
            [self.delegate didmerDeliverysDateAction:self.backIndex  withStartTime:@"不限制" withEndTime:@"不限制"];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(didmerDeliverysAction:withContent:withType:)]) {
            [self.delegate didmerDeliverysAction:self.backIndex withContent:self.backString withType:self.keyWord];
        }
        if([self.keyWord isEqualToString:@"配送时间"]){
            if ([self.delegate respondsToSelector:@selector(didmerDeliverysDateAction:withStartTime:withEndTime:)]) {
                [self.delegate didmerDeliverysDateAction:self.backIndex  withStartTime:self.start_time withEndTime:self.end_time];
            }
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
//选择时间
-(void)rightDateBtnClick{
    self.customDateView = [[FNDeliveryDatepView alloc] init];
    self.customDateView.delegate=self;
    [self.customDateView.leftBtn addTarget:self action:@selector(inDateCancelClick)];
    
    self.container = [[DSHPopupContainer alloc] initWithCustomPopupView:self.customDateView];
    self.container.autoDismissWhenClickedBackground=YES;
    self.container.maskColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    [self.container show];
}
//时间取消
-(void)inDateCancelClick{
    [self.container dismiss];
}
#pragma mark -  //时间确定 FNDeliveryDatepViewDelegate
- (void)inDateConfirmActionWithContent:(NSString*)start withContent:(NSString*)end{
    [self.container dismiss];
    XYLog(@"开始时间 = %@  结束时间 = %@", start,end);
    self.start_time=start;
    self.end_time=end;
    if([start kr_isNotEmpty]&&[start kr_isNotEmpty]){
        self.backString=[NSString stringWithFormat:@"%@-%@",self.start_time,self.end_time];
        [self.rightDateBtn setTitle:[NSString stringWithFormat:@"%@-%@",self.start_time,self.end_time] forState:UIControlStateNormal];
        //cell.compileField.text=[NSString stringWithFormat:@"%@-%@",self.start_time,self.end_time];
    }
}
//不限制
-(void)topNorBtnClick{
    self.astrictState=@"0";
    [self.topNorBtn setImage:IMAGE(@"FN_rightGXRedimg") forState:UIControlStateNormal];
    [self.astrictBtn setImage:IMAGE(@"") forState:UIControlStateNormal];
    self.compileView.hidden=YES;
    self.hintTwoLB.hidden=YES;
}
//限制
-(void)astrictBtnClick{
    self.astrictState=@"1";
    [self.topNorBtn setImage:IMAGE(@"") forState:UIControlStateNormal];
    [self.astrictBtn setImage:IMAGE(@"FN_rightGXRedimg") forState:UIControlStateNormal];
    self.compileView.hidden=NO;
    self.hintTwoLB.hidden=NO;
}
#pragma mark - topViews
-(void)didTopOptionViews{
    self.topNorBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.topNorBtn];
    
    self.astrictBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.astrictBtn];
    
    self.hintOneLB=[[UILabel alloc]init];
    [self.view addSubview:self.hintOneLB];
    
    self.topNorBtn.backgroundColor=[UIColor whiteColor];
    self.topNorBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    self.topNorBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.topNorBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    
    self.astrictBtn.backgroundColor=[UIColor whiteColor];
    self.astrictBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    self.astrictBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.astrictBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    
    self.hintOneLB.font=[UIFont systemFontOfSize:11];
    self.hintOneLB.textColor=RGB(153, 153, 153);
    self.hintOneLB.textAlignment=NSTextAlignmentLeft;
    
    CGFloat topGap=SafeAreaTopHeight+15;
    self.topNorBtn.sd_layout
    .leftSpaceToView(self.view, 10).rightSpaceToView(self.view, 10).topSpaceToView(self.view, topGap).heightIs(44);
    self.topNorBtn.titleLabel.sd_layout
    .leftSpaceToView(self.topNorBtn, 10).centerYEqualToView(self.topNorBtn).rightSpaceToView(self.topNorBtn, 50).heightIs(25);
    self.topNorBtn.imageView.sd_layout
    .widthIs(12).heightIs(10).centerYEqualToView(self.topNorBtn).rightSpaceToView(self.topNorBtn, 20);
    self.astrictBtn.sd_layout
    .leftSpaceToView(self.view, 10).rightSpaceToView(self.view, 10).topSpaceToView(self.topNorBtn, 1).heightIs(44);
    self.astrictBtn.titleLabel.sd_layout
    .leftSpaceToView(self.astrictBtn, 10).centerYEqualToView(self.astrictBtn).rightSpaceToView(self.astrictBtn, 50).heightIs(25);
    self.astrictBtn.imageView.sd_layout
    .widthIs(12).heightIs(10).centerYEqualToView(self.astrictBtn).rightSpaceToView(self.astrictBtn, 20);
    self.hintOneLB.sd_layout
    .leftSpaceToView(self.view, 25).topSpaceToView(self.astrictBtn, 10).rightSpaceToView(self.view, 25).heightIs(15);
    
    [self.topNorBtn setImage:IMAGE(@"FN_rightGXRedimg") forState:UIControlStateNormal];
    [self.astrictBtn setImage:IMAGE(@"") forState:UIControlStateNormal];
    
    [self.topNorBtn addTarget:self action:@selector(topNorBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.astrictBtn addTarget:self action:@selector(astrictBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.topNorBtn setTitle:[NSString stringWithFormat:@"不限制%@",self.keyWord] forState:UIControlStateNormal];
    [self.astrictBtn setTitle:[NSString stringWithFormat:@"限制%@",self.keyWord] forState:UIControlStateNormal];
    
    if([self.keyWord isEqualToString:@"起送费"]){
        self.hintOneLB.text=@"限制后，顾客单笔配送订单需满足起送费时才能下单";
    }
    if([self.keyWord isEqualToString:@"配送费"]){
        self.hintOneLB.text=@"设置后，顾客单笔配送订单需收取的配送费";
    }
    if([self.keyWord isEqualToString:@"配送时间"]){
        self.hintOneLB.text=@"限制后，所设置的时间外顾客无法下配送订单";
    }
    if([self.keyWord isEqualToString:@"配送范围"]){
        self.hintOneLB.text=@"限制后，超出配送范围的顾客无法下配送订单";
    }
}

#pragma mark - 编辑Views
-(void)didOptionCompileViews{
    
    self.compileView=[[UIView alloc]init];
    [self.view addSubview:self.compileView];
    self.compileView.backgroundColor=[UIColor whiteColor];
    
    self.leftCompileTitleLB=[[UILabel alloc]init];
    [self.compileView addSubview:self.leftCompileTitleLB];
    
    self.hintTwoLB=[[UILabel alloc]init];
    [self.view addSubview:self.hintTwoLB];
    
    self.hintTwoLB.font=[UIFont systemFontOfSize:11];
    self.hintTwoLB.textColor=RGB(153, 153, 153);
    self.hintTwoLB.textAlignment=NSTextAlignmentLeft;
    
    self.leftCompileTitleLB.font=[UIFont systemFontOfSize:14];
    self.leftCompileTitleLB.textColor=RGB(51, 51, 51);
    self.leftCompileTitleLB.textAlignment=NSTextAlignmentLeft;
    
    CGFloat topGap=SafeAreaTopHeight+150;
    self.compileView.sd_layout
    .leftSpaceToView(self.view, 10).rightSpaceToView(self.view, 10).topSpaceToView(self.view, topGap).heightIs(44);
    
    self.leftCompileTitleLB.sd_layout
    .leftSpaceToView(self.compileView, 10).widthIs(100).centerYEqualToView(self.compileView).heightIs(25);
    
    self.hintTwoLB.sd_layout
    .leftSpaceToView(self.view, 25).topSpaceToView(self.compileView, 10).rightSpaceToView(self.view, 25).heightIs(15);
    
    self.compileField=[[UITextField alloc]initWithFrame:CGRectMake(114, 7, 100, 30)];
    self.compileField.delegate=self;
    self.compileField.font = kFONT14;
    self.compileField.textColor=RGB(102, 102, 102);
    self.compileField.keyboardType = UIKeyboardTypeDecimalPad;//UIKeyboardTypePhonePad;
    [self.compileView addSubview:self.compileField];
    [self.compileField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.compileField.sd_layout
    .leftSpaceToView(self.compileView, 114).rightSpaceToView(self.compileView, 10).centerYEqualToView(self.compileView).heightIs(30);
    
    self.rightDateBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.compileView addSubview:self.rightDateBtn];
    self.rightDateBtn.sd_layout
    .centerYEqualToView(self.compileView).rightSpaceToView(self, 20).heightIs(25).rightSpaceToView(self.compileView, 20);
    self.rightDateBtn.titleLabel.sd_layout
    .leftSpaceToView(self.rightDateBtn, 10).centerYEqualToView(self.rightDateBtn).rightSpaceToView(self.rightDateBtn, 20).heightIs(25);
    self.rightDateBtn.imageView.sd_layout
    .widthIs(6).heightIs(10).centerYEqualToView(self.rightDateBtn).rightSpaceToView(self.rightDateBtn, 0);
    
    [self.rightDateBtn addTarget:self action:@selector(rightDateBtnClick)];
    [self.rightDateBtn setImage:IMAGE(@"FJ_xY_img") forState:UIControlStateNormal];
    [self.rightDateBtn setTitleColor:RGB(204, 204, 204) forState:UIControlStateNormal];
    [self.rightDateBtn setTitle:@"请选择" forState:UIControlStateNormal];
    self.rightDateBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    self.rightDateBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    
    self.leftCompileTitleLB.text=self.keyWord;
    self.rightDateBtn.hidden=YES;
    self.compileField.hidden=YES;
    
    if([self.keyWord isEqualToString:@"起送费"]){
        self.hintTwoLB.text=@"*起送费不包含配送所需的配送费";
        self.rightDateBtn.hidden=YES;
        self.compileField.hidden=NO;
        self.compileField.placeholder=@"请输入金额(元)";
        [self.hintTwoLB fn_changeColorWithTextColor:RGB(255, 121, 37) changeText:@"*"];
    }
    if([self.keyWord isEqualToString:@"配送费"]){
        self.hintTwoLB.text=@"";
        self.rightDateBtn.hidden=YES;
        self.compileField.hidden=NO;
        self.compileField.placeholder=@"请输入金额(元)";
    }
    if([self.keyWord isEqualToString:@"配送时间"]){
        self.leftCompileTitleLB.text=[NSString stringWithFormat:@"选择%@",self.keyWord];
        self.hintTwoLB.text=@"";
        self.rightDateBtn.hidden=NO;
        self.compileField.hidden=YES;
    }
    if([self.keyWord isEqualToString:@"配送范围"]){
        self.hintTwoLB.text=@"限制后，超出配送范围的顾客无法下配送订单";
        self.hintTwoLB.text=@"";
        self.rightDateBtn.hidden=YES;
        self.compileField.hidden=NO;
        self.compileField.placeholder=@"请输入骑行的配送范围(公里)";
    }
}
- (void)textFieldDidChange:(id)sender{
    UITextField *field = (UITextField *)sender;
    self.backString=field.text;
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
        //限制只能输入数字
        BOOL isHaveDian = YES;
        if ([string isEqualToString:@" "]) {
            return NO;
        }
        
        if ([textField.text rangeOfString:@"."].location == NSNotFound) {
            isHaveDian = NO;
        }
        if ([string length] > 0) {
            unichar single = [string characterAtIndex:0];//当前输入的字符
            
            if ((single >= '0' && single <= '9') || single == '.') {
                //数据格式正确
                if([textField.text length] == 0){
                    if(single == '.') {
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                //输入的字符是否是小数点
                if (single == '.') {
                    if(!isHaveDian) {
                        //text中还没有小数点
                        isHaveDian = YES;
                        return YES;
                    }else{
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }else{
                    //存在小数点
                    if (isHaveDian) {
                        //判断小数点的位数
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 2) {
                            return YES;
                        }else{
                            return NO;
                        }
                    }else{
                        return YES;
                    }
                }
            }else{
                //输入的数据格式不正确
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        else
        {
            return YES;
        }
     
    
    return YES;
}
@end

