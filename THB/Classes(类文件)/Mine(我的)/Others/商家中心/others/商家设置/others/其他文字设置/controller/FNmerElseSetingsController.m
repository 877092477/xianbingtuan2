//
//  FNmerElseSetingsController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerElseSetingsController.h"
#import "FNCustomeNavigationBar.h"
#import "FNDeliveryDatepView.h"
#import "FNdeliveryDateItemView.h"
#import "DSHPopupContainer.h"
@interface FNmerElseSetingsController ()<FNDeliveryDatepViewDelegate,FNdeliveryDateItemViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar *navigationView;
@property (nonatomic, strong)DSHPopupContainer      *container;
@property (nonatomic, strong)UIButton     *leftBtn;
@property (nonatomic, strong)UIButton     *rightBtn;
@property (nonatomic, strong)UITextField  *compileField;
@property (nonatomic, strong)UILabel      *titleLb;
@property (nonatomic, strong)UILabel      *hintLb;
@property (nonatomic, strong)UIView       *topTextView;//修改文本View
@property (nonatomic, strong)UIView       *topDateView;//修改时间View
@property (nonatomic, strong)UIButton     *dateBtn;//时间
@property (nonatomic, strong)UIButton     *dayBtn;//时间
@property (nonatomic, strong)NSString     *amendText;
@property (nonatomic, strong)NSString     *start_time;
@property (nonatomic, strong)NSString     *end_time;
@property (nonatomic, strong)NSString     *bussiness_day;
@end

@implementation FNmerElseSetingsController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    [self.view addSubview:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 5).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:16];
    self.navigationView.titleLabel.textAlignment=NSTextAlignmentLeft;
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).leftSpaceToView(self.leftBtn, 1).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=RGB(250, 250, 250);
    
    if([self.keyWord isEqualToString:@"money"]||[self.keyWord isEqualToString:@"phone"]||[self.keyWord isEqualToString:@"name"]){
        [self inAddAmendtextSubViews];
        if([self.keyWord isEqualToString:@"money"]){
            self.navigationView.titleLabel.text=@"更改赏金比例";
            self.hintLb.text=@"赏金比例指用户在购买商品后返还的佣金占比";
            self.compileField.placeholder=@"设置用户赏金比例";
            self.compileField.keyboardType = UIKeyboardTypeDecimalPad;
            
            self.titleLb.text=@"赏金比例(%)";
            self.titleLb.sd_layout
            .leftSpaceToView(self.topTextView, 15).widthIs(90).heightIs(17).centerYEqualToView(self.topTextView);
            self.compileField.sd_resetLayout
            .leftSpaceToView(self.topTextView, 107).topSpaceToView(self.topTextView, 5).bottomSpaceToView(self.topTextView, 5).rightSpaceToView(self.topTextView, 15);
        }
        if([self.keyWord isEqualToString:@"phone"]){
            self.navigationView.titleLabel.text=@"更改电话";
            self.compileField.keyboardType = UIKeyboardTypePhonePad;
            self.hintLb.text=@"方便顾客咨询门店信息和点外卖订单";
            self.compileField.placeholder=@"请输入电话号码";
            //[self.compileField setEnabled:NO];
            //self.rightBtn.hidden=YES;
        }
        if([self.keyWord isEqualToString:@"name"]){
            self.navigationView.titleLabel.text=@"更改店铺名称";
            self.hintLb.text=@"好名字可以让顾客更容易记住你";
            self.compileField.placeholder=@"请输入店铺名称";
            //[self.compileField setEnabled:NO];
            //self.rightBtn.hidden=YES;
        }
        if([self.content kr_isNotEmpty]){
            self.compileField.text=self.content;
            self.amendText=self.content;
        }
    }
    
    if([self.keyWord isEqualToString:@"date"]){
        self.navigationView.titleLabel.text=@"设置营业时间";
        [self inAddAmendDateSubViews];
    }
    
}
//修改文本   money:更改赏金比例  phone:更改电话  name:更改店铺名称
-(void)inAddAmendtextSubViews{
    self.topTextView=[[UIView alloc]init];
    [self.view addSubview:self.topTextView];
    self.topTextView.backgroundColor=[UIColor whiteColor];
    
    self.titleLb=[[UILabel alloc]init];
    [self.topTextView addSubview:self.titleLb];
    self.titleLb.font=[UIFont systemFontOfSize:14];
    self.titleLb.textColor=RGB(24, 24, 24);
    self.titleLb.textAlignment=NSTextAlignmentLeft;
    
    self.compileField=[[UITextField alloc]initWithFrame:CGRectMake(15, 5, 200, 34)];
    self.compileField.font = kFONT14;
    self.compileField.textColor=RGB(51, 51, 51);
    self.compileField.textAlignment=NSTextAlignmentLeft;
    self.compileField.delegate=self;
    [self.topTextView addSubview:self.compileField];
    
    [self.compileField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.hintLb=[[UILabel alloc]init];
    [self.view addSubview:self.hintLb];
    self.hintLb.font=[UIFont systemFontOfSize:11];
    self.hintLb.textColor=RGB(153, 153, 153);
    self.hintLb.textAlignment=NSTextAlignmentLeft;
    
    self.topTextView.sd_layout
    .leftSpaceToView(self.view, 10).rightSpaceToView(self.view, 10).topSpaceToView(self.view, SafeAreaTopHeight+20).heightIs(44);
    
    self.compileField.sd_layout
    .leftSpaceToView(self.topTextView, 15).topSpaceToView(self.topTextView, 5).bottomSpaceToView(self.topTextView, 5).rightSpaceToView(self.topTextView, 15);
    
    self.hintLb.sd_layout
    .leftSpaceToView(self.view, 25).topSpaceToView(self.topTextView, 1).rightSpaceToView(self.view, 25).heightIs(30);
    
    
}
//设置营业时间
-(void)inAddAmendDateSubViews{
    self.topDateView=[[UIView alloc]init];
    [self.view addSubview:self.topDateView];
    self.topDateView.backgroundColor=[UIColor whiteColor];
    
    UIView *lineView=[[UIView alloc]init];
    [self.topDateView addSubview:lineView];
    lineView.backgroundColor=RGB(250, 250, 250);
    
    UILabel *leftTopLb=[[UILabel alloc]init];
    [self.topDateView addSubview:leftTopLb];
    leftTopLb.font=[UIFont systemFontOfSize:14];
    leftTopLb.textColor=RGB(51, 51, 51);
    leftTopLb.textAlignment=NSTextAlignmentLeft;
    
    UILabel *leftbottomLb=[[UILabel alloc]init];
    [self.topDateView addSubview:leftbottomLb];
    leftbottomLb.font=[UIFont systemFontOfSize:14];
    leftbottomLb.textColor=RGB(51, 51, 51);
    leftbottomLb.textAlignment=NSTextAlignmentLeft;
    
    leftTopLb.text=@"营业日";
    leftbottomLb.text=@"营业时间";
    
    self.topDateView.sd_layout
    .leftSpaceToView(self.view, 10).rightSpaceToView(self.view, 10).topSpaceToView(self.view, SafeAreaTopHeight+20).heightIs(89);
    
    lineView.sd_layout
    .leftSpaceToView(self.topDateView, 0).rightSpaceToView(self.topDateView, 0).topSpaceToView(self.topDateView, 44).heightIs(1);
    
    leftTopLb.sd_layout
    .leftSpaceToView(self.topDateView, 10).topSpaceToView(self.topDateView, 0).heightIs(44).widthIs(80);
    
    leftbottomLb.sd_layout
    .leftSpaceToView(self.topDateView, 10).topSpaceToView(lineView, 0).heightIs(44).widthIs(80);
    
    self.dayBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.dayBtn.titleLabel.font=kFONT14;
    self.dayBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    [self.dayBtn addTarget:self action:@selector(dayBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.dayBtn setImage:IMAGE(@"FJ_xY_img") forState:UIControlStateNormal];
    [self.dayBtn setTitle:@"请选择一周中的营业日" forState:UIControlStateNormal];
    [self.dayBtn setTitleColor:RGB(204, 204, 204) forState:UIControlStateNormal];
    [self.topDateView addSubview:self.dayBtn];
    
    self.dateBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.dateBtn.titleLabel.font=kFONT14;
    self.dateBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    [self.dateBtn addTarget:self action:@selector(dateBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.dateBtn setImage:IMAGE(@"FJ_xY_img") forState:UIControlStateNormal];
    [self.dateBtn setTitle:@"请选择营业时间" forState:UIControlStateNormal];
    [self.dateBtn setTitleColor:RGB(204, 204, 204) forState:UIControlStateNormal];
    [self.topDateView addSubview:self.dateBtn];
    
    self.dayBtn.sd_layout
    .leftSpaceToView(leftTopLb, 10).centerYEqualToView(leftTopLb).heightIs(30).rightSpaceToView(self.topDateView, 10);
    
    self.dayBtn.imageView.sd_layout
    .centerYEqualToView(self.dayBtn).rightSpaceToView(self.dayBtn, 5).widthIs(6).heightIs(11);
    
    self.dayBtn.titleLabel.sd_layout
    .centerYEqualToView(self.dayBtn).rightSpaceToView(self.dayBtn, 15).leftSpaceToView(self.dayBtn, 5).heightIs(20);
    
    self.dateBtn.sd_layout
    .leftSpaceToView(leftbottomLb, 10).centerYEqualToView(leftbottomLb).heightIs(30).rightSpaceToView(self.topDateView, 10);
    
    self.dateBtn.imageView.sd_layout
    .centerYEqualToView(self.dateBtn).rightSpaceToView(self.dateBtn, 5).widthIs(6).heightIs(11);
    
    self.dateBtn.titleLabel.sd_layout
    .centerYEqualToView(self.dateBtn).rightSpaceToView(self.dateBtn, 15).leftSpaceToView(self.dateBtn, 5).heightIs(20);
    
    //【bussiness_day 日期，start_time开始时间，end_time 结束时间】
    NSString *day=self.contentDic[@"bussiness_day"];
    NSString *start=self.contentDic[@"start_time"];
    NSString *end=self.contentDic[@"end_time"];
    NSString *jointStr=[NSString stringWithFormat:@"%@-%@",start,end];
    if([day kr_isNotEmpty]){
       [self.dayBtn setTitle:day forState:UIControlStateNormal];
        self.bussiness_day=day;
        NSArray *arrDay=@[@"",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期天"];
        NSArray *arrXQTIn=[day componentsSeparatedByString:@","];
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        if(arrXQTIn.count>0){
            [arrXQTIn enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *str=obj;
                NSInteger indeInt=[str integerValue];
                NSString *valStr=arrDay[indeInt];
                [arrM addObject:valStr];
            }];
            NSString *dayJoint=[arrM componentsJoinedByString:@","];
            [self.dayBtn setTitle:dayJoint forState:UIControlStateNormal];
            self.bussiness_day=day;
        }
    }
    if([start kr_isNotEmpty]&&[end kr_isNotEmpty]){
       [self.dateBtn setTitle:jointStr forState:UIControlStateNormal];
        self.start_time=start;
        self.end_time=end;
    }
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//保存
-(void)rightBtnAction{
    if([self.keyWord isEqualToString:@"phone"]||[self.keyWord isEqualToString:@"name"]){
        if(![self.compileField.text kr_isNotEmpty]){
            return;
        }
        if ([self.delegate respondsToSelector:@selector(inDidMerElseSetingsBackWithcontent:withType:)]) {
            [self.delegate inDidMerElseSetingsBackWithcontent:self.compileField.text withType:self.keyWord];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    if([self.keyWord isEqualToString:@"money"]){
        if(![self.compileField.text kr_isNotEmpty]){
            return;
        }
        [self requestYingYeBendi];
    }
    if([self.keyWord isEqualToString:@"date"]){
        
        if(![self.bussiness_day kr_isNotEmpty] &&![self.start_time kr_isNotEmpty]&&![self.end_time kr_isNotEmpty]){
            return;
        }
        
        [self requestYingYeBendi];
    }
    
    //[self requestMerSetingMsg];
    //[self requestYingYeBendi];
    
}
//选择时间(单天营业时间)
-(void)dateBtnAction{
    //[SVProgressHUD show];
    //[SVProgressHUD dismissWithDelay:1.5];
        FNDeliveryDatepView *customDateView = [[FNDeliveryDatepView alloc] init];
        customDateView.delegate=self;
        [customDateView.leftBtn addTarget:self action:@selector(inDateCancelClick)];
        self.container = [[DSHPopupContainer alloc] initWithCustomPopupView:customDateView];
        self.container.autoDismissWhenClickedBackground=NO;
        self.container.maskColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
        [self.container show];

}
//时间取消
-(void)inDateCancelClick{
    [self.container dismiss];
}
//选择时间(营业天数)
-(void)dayBtnAction{
    FNdeliveryDateItemView *dayDateView = [[FNdeliveryDateItemView alloc] init];
    dayDateView.delegate=self;
    [dayDateView.leftBtn addTarget:self action:@selector(inDateCancelClick)];
    self.container = [[DSHPopupContainer alloc] initWithCustomPopupView:dayDateView];
    self.container.autoDismissWhenClickedBackground=NO;
    self.container.maskColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    [self.container show];
}

#pragma mark -   FNDeliveryDatepViewDelegate 单天营业时间 HH:mm
- (void)inDateConfirmActionWithContent:(NSString*)start withContent:(NSString*)end{
    XYLog(@"开始时间 = %@  结束时间 = %@", start,end);
    self.start_time=start;
    self.end_time=end;
    if([start kr_isNotEmpty]&&[end kr_isNotEmpty]){
       [self.dateBtn setTitle:[NSString stringWithFormat:@"%@~%@",start,end] forState:UIControlStateNormal];
    }
    if([self.bussiness_day kr_isNotEmpty] &&[self.start_time kr_isNotEmpty]&&[self.end_time kr_isNotEmpty]){
        [self.rightBtn setBackgroundImage:IMAGE(@"FN_me_orBCimg") forState:UIControlStateNormal];
    }else{
        [self.rightBtn setBackgroundImage:IMAGE(@"FN_me_orBCnorImg") forState:UIControlStateNormal];
    }
    [self.container dismiss];
}
#pragma mark -   FNdeliveryDateItemViewDelegate  营业天数 星期- ~星期日
// 选择的时间天
- (void)inDeliveryDateItemWithDate:(NSString*)date withJoint:(NSString*)content{
    self.bussiness_day=date;
    if([content kr_isNotEmpty]){
       [self.dayBtn setTitle:content forState:UIControlStateNormal];
    }
    if([self.bussiness_day kr_isNotEmpty] &&[self.start_time kr_isNotEmpty]&&[self.end_time kr_isNotEmpty]){
       [self.rightBtn setBackgroundImage:IMAGE(@"FN_me_orBCimg") forState:UIControlStateNormal];
    }else{
       [self.rightBtn setBackgroundImage:IMAGE(@"FN_me_orBCnorImg") forState:UIControlStateNormal];
    }
    [self.container dismiss];
}

#pragma mark - request
//商家中心修改  赏金比例 电话  名字 营业时间
-(void)requestMerSetingMsg{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    NSString *url=@"";
    if([self.keyWord isEqualToString:@"money"]){
        url=@"mod=appapi&act=small_store&ctrl=revise_commission";
    }
    if([self.keyWord isEqualToString:@"phone"]){
        url=@"";
        params[@"phone"]=self.compileField.text;
        params[@"id"]=self.dataModel.id;
    }
    if([self.keyWord isEqualToString:@"name"]){
        url=@"";
        params[@"name"]=self.compileField.text;
        params[@"id"]=self.dataModel.id;
    }
    if([self.keyWord isEqualToString:@"date"]){
        if([self.bussiness_day kr_isNotEmpty]){
            params[@"bussiness_day"]=self.bussiness_day;
        }
        if([self.start_time kr_isNotEmpty]&&[self.end_time kr_isNotEmpty]){
            params[@"start_time"]=self.start_time;
            params[@"end_time"]=self.end_time;
        }
        url=@"mod=appapi&act=small_store&ctrl=revise_bussiness_day";
    }
    if(![url kr_isNotEmpty]){
        return;
    }
    XYLog(@"营业时间:%@",params);
    [FNRequestTool requestWithParams:params api:url respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSInteger state=[respondsObject[SuccessKey] integerValue];
        NSString *msgStr=respondsObject[MsgKey];
        [FNTipsView showTips:msgStr];
        if(state==1){
            if ([self.delegate respondsToSelector:@selector(inDidMerElseSetingsAction)]) {
                [self.delegate inDidMerElseSetingsAction];
            }
            [self.navigationController popViewControllerAnimated:YES];
        } 
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}

#pragma mark -  修改营业日 修改比例
-(void)requestYingYeBendi{
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    NSString *url=@"";
    if([self.keyWord isEqualToString:@"money"]){
        url=@"mod=appapi&act=small_store&ctrl=revise_commission";
        if(![self.compileField.text kr_isNotEmpty]){
            [FNTipsView showTips:@"请输入赏金比例"];
            return;
        }
        params[@"commission"]=self.compileField.text;
    }
    if([self.keyWord isEqualToString:@"phone"]){
        url=@"";
    }
    if([self.keyWord isEqualToString:@"name"]){
        url=@"";
    }
    if([self.keyWord isEqualToString:@"date"]){
        if([self.bussiness_day kr_isNotEmpty]){
            params[@"bussiness_day"]=self.bussiness_day;
        }
        if([self.start_time kr_isNotEmpty]&&[self.end_time kr_isNotEmpty]){
            params[@"start_time"]=self.start_time;
            params[@"end_time"]=self.end_time;
        }
        url=@"mod=appapi&act=small_store&ctrl=revise_bussiness_day";
    }
    if(![url kr_isNotEmpty]){
        return;
    }
    @weakify(self);
    [[XYNetworkAPI sharedManager] postResultWithThisLocalityParameter:params url:url successBlock:^(id responseBody) {
        @strongify(self);
        NSInteger state=[responseBody[SuccessKey] integerValue];
        NSString *msgStr=responseBody[MsgKey];
        [FNTipsView showTips:msgStr];
        if(state==1){
            if ([self.delegate respondsToSelector:@selector(inDidMerElseSetingsAction)]) {
                [self.delegate inDidMerElseSetingsAction];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failureBlock:^(NSString *error) {
    }];
}
- (void)textFieldDidChange:(id)sender{
    UITextField *field = (UITextField *)sender;
    if([field.text kr_isNotEmpty]){
       [self.rightBtn setBackgroundImage:IMAGE(@"FN_me_orBCimg") forState:UIControlStateNormal];
    }else{
       [self.rightBtn setBackgroundImage:IMAGE(@"FN_me_orBCnorImg") forState:UIControlStateNormal];
    }
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if([self.keyWord isEqualToString:@"money"]){
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
    }
    
    return YES;
}
@end
