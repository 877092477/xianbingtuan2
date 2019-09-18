//
//  FNCanGrowDetailHeadView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNCanGrowDetailHeadView.h"

@implementation FNCanGrowDetailHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
   
    self.titleLB.font=[UIFont systemFontOfSize:15];
    self.titleLB.textColor=RGB(27, 27, 27);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    self.titleLB.sd_layout
    .leftSpaceToView(self, 20).centerYEqualToView(self).rightSpaceToView(self, 20).heightIs(20); 
    self.titleLB.text=@"成长明细";
}
@end
