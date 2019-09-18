//
//  FNmerConsumeSeekHCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/7.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerConsumeSeekHCell.h"

@implementation FNmerConsumeSeekHCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    self.bgView=[[UIView alloc]init];
    [self addSubview:self.bgView];
    self.bgView.backgroundColor=[UIColor whiteColor];
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.compileField=[[UITextField alloc]initWithFrame:CGRectMake(22, 50, FNDeviceWidth-140, 20)];
    self.compileField.font = kFONT14;
    self.compileField.delegate=self;
    self.compileField.keyboardType = UIKeyboardTypePhonePad;
    [self addSubview:self.compileField];
    self.compileField.rightViewMode = UITextFieldViewModeWhileEditing;
    // [self.compileField valueForKey:@"_clearButton"];
   
    //clearButton.frame=CGRectMake(0, 0, 20, 20);
    //UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    //imageView.image = [UIImage imageNamed:@"FN_merSanGBXicon"];
   
    self.compileField.placeholder=@"立即输入";
    [self.compileField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.titleLB.font=[UIFont systemFontOfSize:13];
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    self.lineView.backgroundColor=RGB(204, 204, 204);
    
    self.bgView.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 0).rightSpaceToView(self, 10).bottomSpaceToView(self, 0);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 32).topSpaceToView(self, 24).heightIs(17).rightSpaceToView(self, 32);
    
    self.compileField.sd_layout
    .leftSpaceToView(self, 32).topSpaceToView(self.titleLB, 16).rightSpaceToView(self, 60).heightIs(20);
    
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 32).rightSpaceToView(self, 45).bottomSpaceToView(self, 10).heightIs(1);
    
    UIButton *clearButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton setImage:[UIImage imageNamed:@"FN_merSanGBXicon"] forState:UIControlStateNormal];
    clearButton.size=CGSizeMake(20, 20);
    clearButton.frame=CGRectMake(FNDeviceWidth-112, 0, 20, 20);
    self.compileField.rightView = clearButton;
    [clearButton addTarget:self action:@selector(clearButtonClick)];
    
    self.titleLB.text=@"请输入消费码";
}
-(void)clearButtonClick{
    self.compileField.text=@"";
    if ([self.delegate respondsToSelector:@selector(didmerConsumeSeekHActionwithContent:withIndex:)]) {
        [self.delegate didmerConsumeSeekHActionwithContent:@"" withIndex:self.index];
    }
}
- (void)textFieldDidChange:(id)sender{
    UITextField *field = (UITextField *)sender;
    if ([self.delegate respondsToSelector:@selector(didmerConsumeSeekHActionwithContent:withIndex:)]) {
        [self.delegate didmerConsumeSeekHActionwithContent:field.text withIndex:self.index];
    }
}

-(void)setModel:(FNmerConsumeModel *)model{
    _model=model;
    if(model){
        if([model.seekStr kr_isNotEmpty]){
            self.compileField.text=model.seekStr;
        }
    }
}
@end
