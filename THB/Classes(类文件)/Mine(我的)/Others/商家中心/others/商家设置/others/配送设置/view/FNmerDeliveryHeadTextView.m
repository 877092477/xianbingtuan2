//
//  FNmerDeliveryHeadTextView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerDeliveryHeadTextView.h"

@implementation FNmerDeliveryHeadTextView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    
    self.titleLB.font=[UIFont systemFontOfSize:12];
    self.titleLB.textColor=RGB(153, 153, 153);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.lineView.backgroundColor=RGB(250, 250, 250);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 15).rightSpaceToView(self, 10).centerYEqualToView(self).heightIs(17);
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 15).rightSpaceToView(self, 15).bottomSpaceToView(self, 0).heightIs(1); 
   
    
}

@end
