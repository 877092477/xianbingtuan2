//
//  FNWaresTextHeadNaView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNWaresTextHeadNaView.h"

@implementation FNWaresTextHeadNaView
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
    self.titleLB.font=[UIFont systemFontOfSize:18];
    self.titleLB.textColor=[UIColor whiteColor];
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 5).rightSpaceToView(self, 0).centerYEqualToView(self).heightIs(20);
    
}
@end
