//
//  FNmoneyOffItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmoneyOffItemCell.h"

@implementation FNmoneyOffItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.bgOneView=[[UIView alloc]init];
    [self addSubview:self.bgOneView];
    
    self.bgTwoView=[[UIView alloc]init];
    [self addSubview:self.bgTwoView];
    
    self.bgThreeView=[[UIView alloc]init];
    [self addSubview:self.bgThreeView];
    
    self.leftOneLB=[[UILabel alloc]init];
    [self.bgOneView addSubview:self.leftOneLB];
    
    self.rightOneLB=[[UILabel alloc]init];
    [self.bgOneView addSubview:self.rightOneLB];
    
    self.leftTwoLB=[[UILabel alloc]init];
    [self.bgTwoView addSubview:self.leftTwoLB];
    
    self.rightTwoLB=[[UILabel alloc]init];
    [self.bgTwoView addSubview:self.rightTwoLB];
    
    self.compileOneField=[[UITextField alloc]initWithFrame:CGRectMake(80, 10, FNDeviceWidth-160, 30)];
    self.compileOneField.delegate=self;
    self.compileOneField.font = kFONT14;
    self.compileOneField.keyboardType = UIKeyboardTypeDecimalPad;
    self.compileOneField.textAlignment=NSTextAlignmentRight;
    //self.compileOneField.tag=10001;
    [self.bgOneView addSubview:self.compileOneField];
    
    self.compileTwoField=[[UITextField alloc]initWithFrame:CGRectMake(80, 45, FNDeviceWidth-160, 30)];
    self.compileTwoField.delegate=self;
    self.compileTwoField.font = kFONT14;
    self.compileTwoField.keyboardType = UIKeyboardTypeDecimalPad;
    self.compileTwoField.textAlignment=NSTextAlignmentRight;
    //self.compileTwoField.tag=10002;
    [self.bgTwoView addSubview:self.compileTwoField];
    
    
    self.lineView=[[UIView alloc]init];
    [self.bgThreeView addSubview:self.lineView];
    
    self.leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgThreeView addSubview:self.leftBtn];
    
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgThreeView addSubview:self.rightBtn];
    
    self.hintLB=[[UILabel alloc]init];
    [self addSubview:self.hintLB];
    
    self.leftOneLB.font=[UIFont systemFontOfSize:14];
    self.leftOneLB.textColor=RGB(24, 24, 24);
    self.leftOneLB.textAlignment=NSTextAlignmentLeft;
    
    self.leftTwoLB.font=[UIFont systemFontOfSize:14];
    self.leftTwoLB.textColor=RGB(24, 24, 24);
    self.leftTwoLB.textAlignment=NSTextAlignmentLeft;
    
    self.rightOneLB.font=[UIFont systemFontOfSize:14];
    self.rightOneLB.textColor=RGB(24, 24, 24);
    self.rightOneLB.textAlignment=NSTextAlignmentRight;
    
    self.rightTwoLB.font=[UIFont systemFontOfSize:14];
    self.rightTwoLB.textColor=RGB(24, 24, 24);
    self.rightTwoLB.textAlignment=NSTextAlignmentRight;
    
    self.hintLB.font=[UIFont systemFontOfSize:11];
    self.hintLB.textColor=RGB(255, 102, 0);
    self.hintLB.textAlignment=NSTextAlignmentLeft;
    
    self.lineView.backgroundColor=RGB(240, 240, 240);
    
    self.bgOneView.backgroundColor=[UIColor whiteColor];
    self.bgOneView.cornerRadius=3;
    
    self.bgTwoView.backgroundColor=[UIColor whiteColor];
    self.bgTwoView.cornerRadius=3;
    
    self.bgThreeView.backgroundColor=[UIColor whiteColor];
    self.bgThreeView.cornerRadius=3;
    
    [self.leftBtn setTitleColor:RGB(6, 192, 162) forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:RGB(6, 192, 162) forState:UIControlStateNormal];
    self.leftBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    self.rightBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    self.leftBtn.titleLabel.font=kFONT14;
    self.rightBtn.titleLabel.font=kFONT14;
    
    self.bgOneView.sd_layout
    .leftSpaceToView(self, 20).rightSpaceToView(self, 20).topSpaceToView(self, 0).heightIs(45);
    
    self.bgTwoView.sd_layout
    .leftSpaceToView(self, 20).rightSpaceToView(self, 20).topSpaceToView(self.bgOneView, 1).heightIs(45);
    
    self.bgThreeView.sd_layout
    .leftSpaceToView(self, 20).rightSpaceToView(self, 20).topSpaceToView(self.bgTwoView, 1).heightIs(45); 
    
    self.hintLB.sd_layout
    .leftSpaceToView(self, 35).rightSpaceToView(self, 37).bottomSpaceToView(self, 5).heightIs(15);
    
    self.leftOneLB.sd_layout
    .leftSpaceToView(self.bgOneView, 15).centerYEqualToView(self.bgOneView).widthIs(120).heightIs(20);
    
    self.rightOneLB.sd_layout
    .rightSpaceToView(self.bgOneView, 15).centerYEqualToView(self.bgOneView).widthIs(30).heightIs(20);
    
    self.compileOneField.sd_layout
    .rightSpaceToView(self.bgOneView, 47).centerYEqualToView(self.bgOneView).heightIs(25).leftSpaceToView(self.leftOneLB, 10);
    
    self.leftTwoLB.sd_layout
    .leftSpaceToView(self.bgTwoView, 15).centerYEqualToView(self.bgTwoView).widthIs(120).heightIs(20);
    
    self.rightTwoLB.sd_layout
    .rightSpaceToView(self.bgTwoView, 15).centerYEqualToView(self.bgTwoView).widthIs(30).heightIs(20);
    
    self.compileTwoField.sd_layout
    .rightSpaceToView(self.bgTwoView, 47).centerYEqualToView(self.bgTwoView).heightIs(25).leftSpaceToView(self.leftTwoLB, 10);
    
    self.lineView.sd_layout
    .centerYEqualToView(self.bgThreeView).centerXEqualToView(self.bgThreeView).widthIs(1).heightIs(30);
    
    self.leftBtn.sd_layout
    .leftSpaceToView(self.bgThreeView, 5).rightSpaceToView(self.lineView, 5).centerYEqualToView(self.bgThreeView).heightIs(30);
    
    self.leftBtn.imageView.sd_layout
    .centerYEqualToView(self.leftBtn).widthIs(14).heightIs(15).leftSpaceToView(self.leftBtn, 30);
    
    self.leftBtn.titleLabel.sd_layout
    .centerYEqualToView(self.leftBtn).leftSpaceToView(self.leftBtn, 55).heightIs(20).rightSpaceToView(self.leftBtn, 5);
    
    self.rightBtn.sd_layout
    .leftSpaceToView(self.lineView, 5).rightSpaceToView(self.bgThreeView, 5).centerYEqualToView(self.bgThreeView).heightIs(30);
    
    self.rightBtn.imageView.sd_layout
    .centerYEqualToView(self.rightBtn).widthIs(14).heightIs(15).leftSpaceToView(self.rightBtn, 30);
    
    self.rightBtn.titleLabel.sd_layout
    .centerYEqualToView(self.rightBtn).leftSpaceToView(self.rightBtn, 55).heightIs(20).rightSpaceToView(self.rightBtn, 5);
    
    [self.leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)leftBtnClick{
    if ([self.delegate respondsToSelector:@selector(didMerMoneyOffLeftIndex:)]) {
        [self.delegate didMerMoneyOffLeftIndex:self.index];
    }
}
-(void)rightBtnClick{
    if ([self.delegate respondsToSelector:@selector(didMerMoneyOffRightIndex:)]) {
        [self.delegate didMerMoneyOffRightIndex:self.index];
    }
}
-(void)setModel:(FNmoneyOffOItemModel *)model{
    _model=model;
    if(model){
        self.leftOneLB.text=model.title1Str;
        self.leftTwoLB.text=model.title2Str;
        self.rightOneLB.text=model.unit1Str;
        self.rightTwoLB.text=model.unit2Str;
        self.compileOneField.placeholder=model.valueHint1Str;
        self.compileTwoField.placeholder=model.valueHint2Str;
        
        if([model.title1Str containsString:@"*"]){
           [self.leftOneLB fn_changeColorWithTextColor:RGB(0, 191, 162) changeText:@"*"];
        }
        if([model.title2Str containsString:@"*"]){
           [self.leftTwoLB fn_changeColorWithTextColor:RGB(0, 191, 162) changeText:@"*"];
        }
        
        
            self.compileOneField.text=model.condition;
       
       
            self.compileTwoField.text=model.price;
       
        [self.leftBtn setTitle:model.leftBtnStr forState:UIControlStateNormal];
        [self.rightBtn setTitle:model.rightBtnStr forState:UIControlStateNormal];
        
        [self.leftBtn setImage:IMAGE(model.leftBtnimg) forState:UIControlStateNormal];
        [self.rightBtn setImage:IMAGE(model.rightBtnimg) forState:UIControlStateNormal]; 
        
        if(model.isThree==YES){
           self.bgThreeView.hidden=YES;
        }else{
           self.bgThreeView.hidden=NO;
        }
        if(model.isHint==YES){
            self.hintLB.hidden=YES;
        }else{
            self.hintLB.hidden=NO;
            self.hintLB.text=model.hintStr;
        }
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    //XYLog(@"结束编辑=== %@",textField.text); 
        if(textField==self.compileOneField){
            if ([self.delegate respondsToSelector:@selector(didMerMoneyOffEditOneView:withContent:)]) {
                [self.delegate didMerMoneyOffEditOneView:self.index withContent:textField.text];
            }
        }
        if(textField==self.compileTwoField){
            if ([self.delegate respondsToSelector:@selector(didMerMoneyOffEditTwoView:withContent:)]) {
                [self.delegate didMerMoneyOffEditTwoView:self.index withContent:textField.text];
            }
        }
   
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
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
@end
