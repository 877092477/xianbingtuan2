//
//  FNaddTallyPhotoHeadView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNaddTallyPhotoHeadView.h"

@implementation FNaddTallyPhotoHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    self.compileField=[[UITextField alloc]initWithFrame:CGRectMake(15, 5, 200, 34)];
    self.compileField.font = kFONT14;
    self.compileField.textColor=RGB(51, 51, 51);
    self.compileField.tintColor=[UIColor lightGrayColor];
    self.compileField.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.compileField];
    
    self.hintLb=[[UILabel alloc]init];
    [self addSubview:self.hintLb];
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    
    self.lineView.backgroundColor=RGB(255, 120, 0);
    
    self.hintLb.font=[UIFont systemFontOfSize:14];
    self.hintLb.textColor=RGB(51, 51, 51);
    self.hintLb.textAlignment=NSTextAlignmentLeft;
    
    self.hintLb.sd_layout
    .leftSpaceToView(self, 10).centerYEqualToView(self).widthIs(70).heightIs(18);
    
    self.compileField.sd_layout
    .leftSpaceToView(self.hintLb, 0).centerYEqualToView(self.hintLb).rightSpaceToView(self, 10).heightIs(18);
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 10).rightSpaceToView(self, 10).bottomSpaceToView(self, 0).heightIs(1);
    
    self.hintLb.text=@"*标签名字";
    self.compileField.placeholder=@"请输入新增标签";
    [self.hintLb fn_changeColorWithTextColor:RGB(255, 120, 0) changeText:@"*"];
}
@end
