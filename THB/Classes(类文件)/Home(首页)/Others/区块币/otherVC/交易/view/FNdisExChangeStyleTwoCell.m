//
//  FNdisExChangeStyleTwoCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/7.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdisExChangeStyleTwoCell.h"

@implementation FNdisExChangeStyleTwoCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews{
    
    self.sumLB=[[UILabel alloc]init];
    [self addSubview:self.sumLB];
    
    self.msgLB=[[UILabel alloc]init];
    [self addSubview:self.msgLB]; 
    
    
    self.sumLB.font=[UIFont systemFontOfSize:14];
    self.sumLB.textColor=RGB(102, 102, 102);
    self.sumLB.textAlignment=NSTextAlignmentLeft;
    
    self.msgLB.font=[UIFont systemFontOfSize:11];
    self.msgLB.textColor=RGB(153, 153, 153);
    self.msgLB.textAlignment=NSTextAlignmentLeft;
    
    
    self.sumLB.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 2).rightSpaceToView(self, 10).heightIs(17);
    
    self.msgLB.sd_layout
    .leftSpaceToView(self, 10).rightSpaceToView(self, 10).bottomSpaceToView(self, 0).heightIs(16);
    
    self.line=[UIView new];
    self.line.backgroundColor=RGB(218, 218, 218);
    self.line.hidden=YES;
    [self addSubview:self.line];
    
    self.line.sd_layout
    .topSpaceToView(self, 0).bottomSpaceToView(self, 0).rightSpaceToView(self, 0).widthIs(1);
}
@end
