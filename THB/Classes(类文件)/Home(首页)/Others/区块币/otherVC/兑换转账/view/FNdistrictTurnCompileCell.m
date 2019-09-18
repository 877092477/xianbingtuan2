//
//  FNdistrictTurnCompileCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/6.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdistrictTurnCompileCell.h"

@implementation FNdistrictTurnCompileCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews{
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    self.numLB=[[UILabel alloc]init];
    [self addSubview:self.numLB];
    self.numTitleLB=[[UILabel alloc]init];
    [self addSubview:self.numTitleLB];
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    
    self.compileField=[[UITextField alloc]initWithFrame:CGRectMake(15, 140, 100, 30)];
    //self.leftField.delegate=self;
    self.compileField.font = kFONT17;
    //self.compileField.keyboardType = UIKeyboardTypePhonePad;
    [self addSubview:self.compileField];
    
    [self.compileField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.titleLB.font=[UIFont systemFontOfSize:15];
    self.titleLB.textColor=RGB(102, 102, 102);
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    
    self.numLB.font=[UIFont systemFontOfSize:24];
    self.numLB.textColor=RGB(51, 51, 51);
    self.numLB.textAlignment=NSTextAlignmentCenter;
    
    self.numTitleLB.font=[UIFont systemFontOfSize:15];
    self.numTitleLB.textColor=RGB(102, 102, 102);
    self.numTitleLB.textAlignment=NSTextAlignmentLeft;
    
    self.lineView.backgroundColor=RGB(240,240,240);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 15).topSpaceToView(self, 19).rightSpaceToView(self, 15).heightIs(20);
    
    self.numLB.sd_layout
    .leftSpaceToView(self, 15).topSpaceToView(self.titleLB, 20).rightSpaceToView(self, 15).heightIs(30);
    
    self.numTitleLB.sd_layout
    .leftSpaceToView(self, 15).topSpaceToView(self.numLB, 20).rightSpaceToView(self, 15).heightIs(20);
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 15).bottomSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(1);
    
    self.compileField.sd_layout
    .leftSpaceToView(self, 15).bottomSpaceToView(self, 9).rightSpaceToView(self, 15).heightIs(30);
    
}

- (void)textFieldDidChange:(id)sender{
        UITextField *field = (UITextField *)sender;
        if ([self.delegate respondsToSelector:@selector(didTurnCompileAction:withContent:)]) {
            [self.delegate didTurnCompileAction:self.index withContent:field.text];
        }
}
@end
