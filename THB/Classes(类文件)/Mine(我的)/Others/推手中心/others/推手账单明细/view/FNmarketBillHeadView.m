//
//  FNmarketBillHeadView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmarketBillHeadView.h"

@implementation FNmarketBillHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.titleLB.font=[UIFont systemFontOfSize:14];
    self.titleLB.textColor=RGB(24, 24, 24);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 13).rightSpaceToView(self, 13).centerYEqualToView(self).heightIs(20); 
}
@end
