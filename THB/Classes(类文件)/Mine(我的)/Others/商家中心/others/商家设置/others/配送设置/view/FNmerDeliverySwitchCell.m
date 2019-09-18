//
//  FNmerDeliverySwitchCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerDeliverySwitchCell.h"

@implementation FNmerDeliverySwitchCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.leftTitleLB=[[UILabel alloc]init];
    [self addSubview:self.leftTitleLB];
    
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.rightBtn];
    
    self.leftTitleLB.font=[UIFont systemFontOfSize:14];
    self.leftTitleLB.textColor=RGB(51, 51, 51);
    self.leftTitleLB.textAlignment=NSTextAlignmentLeft;
    
    
    self.leftTitleLB.sd_layout
    .leftSpaceToView(self, 15).heightIs(20).widthIs(120).centerYEqualToView(self);
    
    self.rightBtn.sd_layout
    .rightSpaceToView(self, 15).centerYEqualToView(self.leftTitleLB).widthIs(34).heightIs(22);
}
@end
