//
//  FNdisOddLaunchHeadView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdisOddLaunchHeadView.h"

@implementation FNdisOddLaunchHeadView
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
    self.titleLB.font=[UIFont systemFontOfSize:14];
    self.titleLB.textColor=RGB(153, 153, 153);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.resultLB=[[UILabel alloc]init];
    [self addSubview:self.resultLB];
    self.resultLB.textColor=RGB(102, 102, 102); 
    self.resultLB.font=[UIFont systemFontOfSize:12];
    self.resultLB.textAlignment=NSTextAlignmentRight;
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 15).centerYEqualToView(self).widthIs(100).heightIs(20);
    
    self.resultLB.sd_layout
    .rightSpaceToView(self, 15).centerYEqualToView(self).heightIs(20).widthIs(190);
    
}
@end
