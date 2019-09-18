//
//  FNdisExchangeHeadView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/7.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdisExchangeHeadView.h"

@implementation FNdisExchangeHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews{
    
    self.topBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.topBtn];
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    self.titleLB.font=[UIFont systemFontOfSize:12];
    self.titleLB.textColor=RGB(102, 102, 102);
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    
    self.topBtn.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(32);
    self.topBtn.titleLabel.sd_layout
    .leftSpaceToView(self.topBtn, 20).rightSpaceToView(self.topBtn, 20).heightIs(30).centerYEqualToView(self.topBtn);
    self.topBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    self.topBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    self.titleLB.sd_layout
    .leftSpaceToView(self, 15).heightIs(28).bottomSpaceToView(self, 0).rightSpaceToView(self, 15);
    
}
@end
