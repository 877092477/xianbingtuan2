//
//  FNmerDeliveryEditorCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerDeliveryEditorCell.h"

@implementation FNmerDeliveryEditorCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.leftTitleLB=[[UILabel alloc]init];
    [self addSubview:self.leftTitleLB];
    
    //self.rightLB=[[UILabel alloc]init];
    //[self addSubview:self.rightLB];
    
    self.rightImgView=[[UIImageView alloc]init];
    [self addSubview:self.rightImgView];
    
    self.leftTitleLB.font=[UIFont systemFontOfSize:14];
    self.leftTitleLB.textColor=RGB(51, 51, 51);
    self.leftTitleLB.textAlignment=NSTextAlignmentLeft;
    
    //self.rightLB.font=[UIFont systemFontOfSize:14];
    //self.rightLB.textColor=RGB(140, 140, 140);
    //self.rightLB.textAlignment=NSTextAlignmentRight;
    
    
    self.leftTitleLB.sd_layout
    .leftSpaceToView(self, 15).heightIs(20).widthIs(120).centerYEqualToView(self);
    
    self.rightImgView.sd_layout
    .rightSpaceToView(self, 11).centerYEqualToView(self).widthIs(7).heightIs(13);
    
    
    self.compileField=[[UITextField alloc]initWithFrame:CGRectMake(120, 10, 100, 30)];
    self.compileField.delegate=self;
    self.compileField.font = kFONT14;
    self.compileField.textColor=RGB(102, 102, 102);
    //self.compileField.keyboardType = UIKeyboardTypeDecimalPad;//UIKeyboardTypePhonePad;
    self.compileField.textAlignment=NSTextAlignmentRight;
    [self addSubview:self.compileField];
    [self.compileField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
   
    
    self.siteView=[[UITextView alloc]init];
    self.siteView.textAlignment=NSTextAlignmentRight;
    self.siteView.editable = YES;
    self.siteView.delegate = self;
    self.siteView.font = kFONT14;
    self.siteView.scrollEnabled = YES;
    self.siteView.textColor=RGB(102, 102, 102);
    [self addSubview:self.siteView];
    self.siteView.sd_layout
    .leftSpaceToView(self.leftTitleLB, 5).topSpaceToView(self, 5).bottomSpaceToView(self, 5).rightSpaceToView(self, 33);
    self.compileField.sd_layout
    .leftSpaceToView(self.leftTitleLB, 5).topSpaceToView(self, 5).bottomSpaceToView(self, 5).rightSpaceToView(self, 33);
    
    self.siteHint=[[UILabel alloc]init];
    self.siteHint.hidden=YES;
    [self addSubview:self.siteHint];
    self.siteHint.font=[UIFont systemFontOfSize:14];
    self.siteHint.textColor=RGB(204, 204, 204);
    self.siteHint.textAlignment=NSTextAlignmentRight;
    
    self.siteHint.sd_layout
    .leftSpaceToView(self.leftTitleLB, 5).topSpaceToView(self, 12).rightSpaceToView(self, 38).heightIs(16);
    
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.backgroundColor=[UIColor clearColor];
    [self addSubview:self.rightBtn];
    self.rightBtn.hidden=YES;
    self.rightBtn.sd_layout
    .leftSpaceToView(self.leftTitleLB, 5).topSpaceToView(self, 5).bottomSpaceToView(self, 5).rightSpaceToView(self, 33);
    [self.rightBtn addTarget:self action:@selector(rightBtnClick)];
    self.rightImgView.image=IMAGE(@"FJ_xY_img");
}

- (void)textFieldDidChange:(id)sender{
    UITextField *field = (UITextField *)sender;
    if ([self.delegate respondsToSelector:@selector(didmerDeliveryEditorAction:withContent:)]) {
        [self.delegate didmerDeliveryEditorAction:self.index withContent:field.text];
    }
}
-(void)rightBtnClick{
    if ([self.delegate respondsToSelector:@selector(didmerDeliveryRightAction:)]) {
        [self.delegate didmerDeliveryRightAction:self.index];
    }
}

-(void)setModel:(FNdeliverySetsModel *)model{
    _model=model;
    if(model){
        self.leftTitleLB.text=model.title;
        if(model.isBearEd==YES){
            [self.compileField setEnabled:NO];
            self.rightBtn.hidden=NO;
        }else{
            [self.compileField setEnabled:YES];
            self.rightBtn.hidden=YES;
        }
        self.rightImgView.hidden=model.isHsj; 
        
        if(model.isLocation==YES){
            self.compileField.hidden=YES;
            self.siteView.hidden=NO;
            self.siteHint.hidden=NO;
            self.siteHint.text=model.hint;
            self.siteView.text=model.value;
            if([model.value kr_isNotEmpty]){
                self.siteHint.hidden = YES;
            }else{
                self.siteHint.hidden = NO;
            }
        }else{
            self.compileField.hidden=NO;
            self.siteView.hidden=YES;
            self.siteHint.hidden=YES;
        }
        self.compileField.placeholder=model.hint; 
        self.compileField.text=model.value;
        
        if([self.model.edType isEqualToString:@"num"] ||[self.model.edType isEqualToString:@"numInt"]){ 
            self.compileField.keyboardType = UIKeyboardTypeDecimalPad;//UIKeyboardTypePhonePad;
        }else{
            self.compileField.keyboardType = UIKeyboardTypeDefault;
        }
        
    }
}
//当textView的内容发生改变的时候调用
- (void)textViewDidChange:(UITextView *)textView {
    XYLog(@"textView:%@",textView.text);
    if(self.model.isLocation==YES){
        if([textView.text kr_isNotEmpty]){
            self.siteHint.hidden = YES;
        }else{
            self.siteHint.hidden = NO;
        }
    }
    if ([self.delegate respondsToSelector:@selector(didmerDeliveryEditorAction:withContent:)]) {
        [self.delegate didmerDeliveryEditorAction:self.index withContent:textView.text];
    }
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (![text isEqualToString:@""]){
        //self.siteHint.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1){
        
        //self.siteHint.hidden = NO;
    }
    return YES;
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if([self.model.edType isEqualToString:@"num"] ||[self.model.edType isEqualToString:@"numInt"]){
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
            if([self.model.edType isEqualToString:@"numInt"]){
                if (single == '.') {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
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
