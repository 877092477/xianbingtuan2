//
//  FNdistrictPhoneCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/6.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdistrictPhoneCell.h"

@implementation FNdistrictPhoneCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews{
    self.backgroundColor=RGB(250, 250, 250);
    self.bgView=[[UIView alloc]init];
    [self addSubview:self.bgView];
    self.bgView.backgroundColor=[UIColor whiteColor];
    
    self.leftField=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    //self.leftField.delegate=self;
    self.leftField.font = kFONT16;
    self.leftField.keyboardType = UIKeyboardTypePhonePad;
    [self addSubview:self.leftField];
    
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.rightBtn];
    
    self.bgView.sd_layout
    .rightSpaceToView(self, 0).leftSpaceToView(self, 0).topSpaceToView(self, 12).bottomSpaceToView(self, 12);
    
    self.leftField.sd_layout
    .rightSpaceToView(self, 75).leftSpaceToView(self, 18).heightIs(25).centerYEqualToView(self.bgView);
    
    self.rightBtn.sd_layout
    .rightSpaceToView(self, 23).heightIs(25).widthIs(25).centerYEqualToView(self.bgView);
}
@end
