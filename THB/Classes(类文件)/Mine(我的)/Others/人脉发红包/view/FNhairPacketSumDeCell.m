//
//  FNhairPacketSumDeCell.m
//  THB
//
//  Created by Jimmy on 2019/2/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNhairPacketSumDeCell.h"

@implementation FNhairPacketSumDeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.backgroundColor=RGB(243, 243, 243);
    
    self.bgView=[[UIView alloc]init];
    self.bgView.cornerRadius=5/2;
    self.bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.bgView];
    
    self.pinImg=[[UIImageView alloc]init];
    self.pinImg.hidden=YES;
    [self.bgView addSubview:self.pinImg];
    
    self.nameLB=[[UILabel alloc]init];
    self.nameLB.font=kFONT17;
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.nameLB];
    
    self.compileText=[[UITextField alloc]init];
    self.compileText.delegate=self;
    self.compileText.textAlignment=NSTextAlignmentRight;
    self.compileText.font=kFONT17;
    [self.bgView addSubview:self.compileText];
    [self.compileText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.unitLB=[[UILabel alloc]init];
    self.unitLB.font=kFONT17;
    self.unitLB.textAlignment=NSTextAlignmentRight;
    [self.bgView addSubview:self.unitLB];
    
    [self incomposition];
    
}

-(void)incomposition{ 
    
    CGFloat inter_20=20;
    
    self.bgView.sd_layout
    .leftSpaceToView(self,inter_20).rightSpaceToView(self,inter_20).topSpaceToView(self, 0).heightIs(40);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.bgView, inter_20).centerYEqualToView(self.bgView).topSpaceToView(self.bgView, 0).bottomSpaceToView(self.bgView, 0).widthIs(80);
    
    self.unitLB.sd_layout
    .rightSpaceToView(self.bgView, inter_20).centerYEqualToView(self.bgView).topSpaceToView(self.bgView, 0).bottomSpaceToView(self.bgView, 0);
    [self.unitLB setSingleLineAutoResizeWithMaxWidth:80];
    
    self.compileText.sd_layout
    .rightSpaceToView(self.bgView,60).centerYEqualToView(self.bgView).widthIs(180).heightIs(25);
    
    self.pinImg.sd_layout
    .leftSpaceToView(self.bgView,inter_20).centerYEqualToView(self.bgView).widthIs(17).heightIs(17);
    
}

-(void)setModel:(FNRedPackageNaModel *)model{
    _model=model;
    if(model){
        self.nameLB.text=model.title;
        self.compileText.placeholder=model.remark;
        self.unitLB.text=model.unit;
        CGFloat nameLBW=[self getWidthWithText:self.nameLB.text height:40 font:17];
        self.nameLB.sd_layout
        .leftSpaceToView(self.bgView, 20).centerYEqualToView(self.bgView).topSpaceToView(self.bgView, 0).bottomSpaceToView(self.bgView, 0).widthIs(nameLBW);
        
        if([model.unit kr_isNotEmpty]){
            self.compileText.sd_layout
            .leftSpaceToView(self.bgView,nameLBW+25).rightSpaceToView(self.bgView,60).centerYEqualToView(self.bgView).heightIs(20);
        }else{
            self.compileText.sd_layout
            .leftSpaceToView(self.bgView,nameLBW+25).rightSpaceToView(self.bgView,15).centerYEqualToView(self.bgView).heightIs(20);
        }
        if([model.sum kr_isNotEmpty]){
            self.compileText.text=model.sum;
        }
        if([model.amendState integerValue]==1){
            
            self.pinImg.image=IMAGE(@"FN_hair_pinImg");
            
            self.pinImg.hidden=NO;
            self.nameLB.sd_layout
            .leftSpaceToView(self.bgView, 45).centerYEqualToView(self.bgView).topSpaceToView(self.bgView, 0).bottomSpaceToView(self.bgView, 0).widthIs(nameLBW);
        }else{
            self.pinImg.image=IMAGE(@"");
            self.pinImg.hidden=YES;
            self.nameLB.sd_layout
            .leftSpaceToView(self.bgView, 20).centerYEqualToView(self.bgView).topSpaceToView(self.bgView, 0).bottomSpaceToView(self.bgView, 0).widthIs(nameLBW);
        }
    }
}
//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    XYLog(@"结束输入内容为:%@",textField.text);
    //if ([self.delegate respondsToSelector:@selector(inHairPacketCompileItemAction:withContent:)]) {
        
    //    [self.delegate inHairPacketCompileItemAction:self.indexPath withContent:textField.text];
        
    //}
}

- (void)textFieldDidChange:(id)sender{
    UITextField *field = (UITextField *)sender;
    //NSLog(@"%@",[field text]);
    if ([self.delegate respondsToSelector:@selector(inHairPacketCompileItemAction:withContent:)]) {
        [self.delegate inHairPacketCompileItemAction:self.indexPath withContent:field.text];
    }
} 


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //限制只能输入数字
    if(self.indexPath.section==0) {
    
    BOOL isHaveDian = YES;
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    NSString*tempStr = [textField.text stringByAppendingString:string];
    if([tempStr longLongValue] >=200) {
       [FNTipsView showTips:[NSString stringWithFormat:@"不能大于%d元",200]];
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
