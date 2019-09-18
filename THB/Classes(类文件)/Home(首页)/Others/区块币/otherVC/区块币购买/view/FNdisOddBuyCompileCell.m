//
//  FNdisOddBuyCompileCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdisOddBuyCompileCell.h"

@implementation FNdisOddBuyCompileCell
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
    self.titleLB.font=[UIFont systemFontOfSize:15];
    self.titleLB.textColor=RGB(102, 102, 102);
    self.titleLB.textAlignment=NSTextAlignmentLeft; 
   
    self.compileField=[[UITextField alloc]initWithFrame:CGRectMake(120, 10, 100, 30)];
    //self.compileField.delegate=self;
    self.compileField.font = kFONT15;
    //self.compileField.keyboardType = UIKeyboardTypeDecimalPad;//UIKeyboardTypePhonePad;
    [self addSubview:self.compileField];
    
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.rightBtn];
    self.rightBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 15).centerYEqualToView(self).widthIs(105).heightIs(20);
    
    self.compileField.sd_layout
    .leftSpaceToView(self, 120).centerYEqualToView(self).rightSpaceToView(self, 85).heightIs(20);
    
    self.rightBtn.sd_layout
    .rightSpaceToView(self, 15).centerYEqualToView(self).heightIs(20); 
    [self.rightBtn setupAutoSizeWithHorizontalPadding:10 buttonHeight:20];
    
    self.line=[UIView new];
    self.line.backgroundColor=RGB(240, 240, 240);
    [self addSubview:self.line];
    self.line.sd_layout
    .leftSpaceToView(self, 15).bottomSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(1);
    
}
@end
