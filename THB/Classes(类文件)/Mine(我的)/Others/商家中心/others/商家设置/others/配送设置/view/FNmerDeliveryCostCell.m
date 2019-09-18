//
//  FNmerDeliveryCostCell.m
//  珍购多
//
//  Created by Jimmy on 2019/6/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerDeliveryCostCell.h"

@implementation FNmerDeliveryCostCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    
    self.titleLB.font=[UIFont systemFontOfSize:12];
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    
    self.lineView.backgroundColor=RGB(208, 208, 208);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 10).rightSpaceToView(self, 10).topSpaceToView(self, 14).heightIs(17);
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 10).rightSpaceToView(self, 10).bottomSpaceToView(self, 12).heightIs(1);
    
    self.compileField=[[UITextField alloc]initWithFrame:CGRectMake(10, 70, 80, 30)];
    //self.compileField.delegate=self;
    self.compileField.font = kFONT14;
    //self.compileField.keyboardType = UIKeyboardTypeDecimalPad;//UIKeyboardTypePhonePad;
    self.compileField.keyboardType = UIKeyboardTypeDecimalPad;
    self.compileField.textAlignment=NSTextAlignmentCenter;
    self.compileField.textColor=RGB(102, 102, 102);
    [self addSubview:self.compileField];
    [self.compileField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.compileField.sd_layout
    .leftSpaceToView(self, 10).rightSpaceToView(self, 10).bottomSpaceToView(self, 14).heightIs(40);
    
}
- (void)textFieldDidChange:(id)sender{
    UITextField *field = (UITextField *)sender;
    if ([self.delegate respondsToSelector:@selector(didmerCostEditorAction:withContent:)]) {
        [self.delegate didmerCostEditorAction:self.index withContent:field.text];
    }
}
@end
